Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9968B762368
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjGYUg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjGYUg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:36:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670F31BC3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:36:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-268128a0105so1797075a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690317415; x=1690922215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t38LAy3XUaR4J5EOGa4yFGEcqNsMLyxWnJ7wsD34WsQ=;
        b=iHRPLkhXJdKw3dpQvYmFjC/99lHj3UOs9u/D/w3Bpfc5fxoExuczXi6MvTCu9QgPPN
         qy38o6HYVeTpHNYl1XXdCDM5fWKtxbXaZ+YvftsbGZWubrYe40uFfE8B/076OY49NsoG
         URvenrNwJwLsWwhi7GtNTwxo2dpPx2XWXbzwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317415; x=1690922215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t38LAy3XUaR4J5EOGa4yFGEcqNsMLyxWnJ7wsD34WsQ=;
        b=EpDLIW3Po4QaMctzic+TxKbUHV9h+yTvj35KyPU2fRgPpkGaDEmaJ60lH/IY9IBGBQ
         X4c7JF9Dxouq9MlXMvWJVHg7/6MgMtKR6SGmQRz6qSMWDPOqlWxRTQwiarUOIX+6qtRL
         yXMdR7Tv7imfuq6kFE6PcdVKTyQWklaSL6Xd3T1HKp66DqbgMkDSKcKo3qcztG0rJ3NG
         a9RtO/IJchtN23gn1nrJjz9ycGaJGZ7Ui7w3YsrL280x6PFCsPCuLwvgJS5YMXVGICEM
         bLm7eJM6W/dFLvYL/6Fs+EPQOiOKsCzX63ZaK790MKtxALxEs/d1CvxO8hK4y+fv5tHz
         xwbA==
X-Gm-Message-State: ABy/qLYlvKBlECWlPCTDsIG4HXtBRe3zGh0LMbVvrkOYPNfn1yKHdA4T
        q+ZSkjZoWahI2dVL8CWFHJwvKg==
X-Google-Smtp-Source: APBJJlHGw8vWHsfZZ+Btmj+3nGK1dEOwr1gwf2QSLbSYYMWU4/ntcLarTpDHFPdMc18qiaoU1rliKw==
X-Received: by 2002:a17:90a:7e15:b0:268:2b5c:14d with SMTP id i21-20020a17090a7e1500b002682b5c014dmr228765pjl.36.1690317414860;
        Tue, 25 Jul 2023 13:36:54 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c363:4681:f5b8:301])
        by smtp.gmail.com with ESMTPSA id bg1-20020a17090b0d8100b002676e961261sm1396951pjb.1.2023.07.25.13.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:36:54 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, hsinyi@google.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        yangcong5@huaqin.corp-partner.google.com,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 00/10] drm/panel and i2c-hid: Allow panels and touchscreens to power sequence together
Date:   Tue, 25 Jul 2023 13:34:35 -0700
Message-ID: <20230725203545.2260506-1-dianders@chromium.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The big motivation for this patch series is mostly described in the patch
("drm/panel: Add a way for other devices to follow panel state"), but to
quickly summarize here: for touchscreens that are connected to a panel we
need the ability to power sequence the two device together. This is not a
new need, but so far we've managed to get by through a combination of
inefficiency, added costs, or perhaps just a little bit of brokenness.
It's time to do better. This patch series allows us to do better.

Assuming that people think this patch series looks OK, we'll have to
figure out the right way to land it. The panel patches and i2c-hid
patches will go through very different trees and so either we'll need
an Ack from one side or the other or someone to create a tag for the
other tree to pull in. This will _probably_ require the true drm-misc
maintainers to get involved, not a lowly committer. ;-)

Version 3 of this patch was a long time coming after v2. Maxime and I
had a very long discussion trying to figure out if there was a beter
way and in the end we didn't find one so he was OK with the series in
general [1]. After that got resolved, I tried to resolve Benjamin's
feedback but got stuck [2]. Presumably Benjamin is busy at the moment,
so I've done my best to try to resolve things. The end result is a v3
that's not that different from v2 but that has a tiny bit more code
split out.

Version 2 of this patch series didn't change too much. At a high level:
* I added all the forgotten "static" to functions.
* I've hopefully made the bindings better.
* I've integrated into fw_devlink.
* I cleaned up a few descriptions / comments.

This still needs someone to say that the idea looks OK or to suggest
an alternative that solves the problems. ;-)

[1] https://lore.kernel.org/r/gkwymmfkdy2p2evz22wmbwgw42ii4wnvmvu64m3bghmj2jhv7x@4mbstjxnagxd
[2] https://lore.kernel.org/r/CAD=FV=VbdeomBGbWhppY+5TOSwt64GWBHga68OXFwsnO4gg4UA@mail.gmail.com

Changes in v3:
- Add is_panel_follower() as a convenience for clients.
- Add "depends on DRM || !DRM" to Kconfig to avoid randconfig error.
- Split more of the panel follower code out of the core.

Changes in v2:
- Move the description to the generic touchscreen.yaml.
- Update the desc to make it clearer it's only for integrated devices.
- Add even more text to the commit message.
- A few comment cleanups.
- ("Add a devlink for panel followers") new for v2.
- i2c_hid_core_initial_power_up() is now static.
- i2c_hid_core_panel_prepared() and ..._unpreparing() are now static.
- ihid_core_panel_prepare_work() is now static.
- Improve documentation for smp_wmb().

Douglas Anderson (10):
  dt-bindings: HID: i2c-hid: Add "panel" property to i2c-hid backed
    touchscreens
  drm/panel: Check for already prepared/enabled in drm_panel
  drm/panel: Add a way for other devices to follow panel state
  of: property: fw_devlink: Add a devlink for panel followers
  HID: i2c-hid: Switch to SYSTEM_SLEEP_PM_OPS()
  HID: i2c-hid: Rearrange probe() to power things up later
  HID: i2c-hid: Make suspend and resume into helper functions
  HID: i2c-hid: Support being a panel follower
  HID: i2c-hid: Do panel follower work on the system_wq
  arm64: dts: qcom: sc7180: Link trogdor touchscreens to the panels

 .../bindings/input/elan,ekth6915.yaml         |   5 +
 .../bindings/input/goodix,gt7375p.yaml        |   5 +
 .../bindings/input/hid-over-i2c.yaml          |   2 +
 .../input/touchscreen/touchscreen.yaml        |   7 +
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |   1 +
 .../dts/qcom/sc7180-trogdor-homestar.dtsi     |   1 +
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |   1 +
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |   1 +
 .../qcom/sc7180-trogdor-quackingstick.dtsi    |   1 +
 .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |   1 +
 drivers/gpu/drm/drm_panel.c                   | 218 ++++++++++-
 drivers/hid/i2c-hid/Kconfig                   |   2 +
 drivers/hid/i2c-hid/i2c-hid-core.c            | 338 +++++++++++++-----
 drivers/of/property.c                         |   2 +
 include/drm/drm_panel.h                       |  94 +++++
 15 files changed, 583 insertions(+), 96 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog

