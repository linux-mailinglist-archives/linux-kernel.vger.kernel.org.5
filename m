Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C877A6EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjISXDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjISXDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:03:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9ACC0;
        Tue, 19 Sep 2023 16:03:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAF6C433CD;
        Tue, 19 Sep 2023 23:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695164618;
        bh=AVm/wivqgdaYPeb2TV3gnjnCGczTQW2Knav2WIIU+3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pHeNS/agG4PS6WxON62G7QizekGP+u5vmPP2ipBG9P8uwxjXW73vH9UdVrn6WwsUX
         6vj/DYrQ14u7MCBDHmt/PNYf/5QogI4s9Q2qDAIQ8RjmUqJGtZMa+/HHPdILKcUTqv
         rKRZ+FtjEEs4ZwWdnVA0nEaS/9sZE8ZHWaoqlI8ODh5wUUZvmQqni6a58P8HUUhy/m
         A/0zyE9i5u1D34c4aqUkTYtJoSDelOi2ug+TUJ7Ekydhbq0qGuJataqmS+wOvtY+9Q
         SJrCq78hKb8rM0ph9DeRyYaYa0fbPU9Vm7NbbIdjoUYfBUFW3Z+o2Yzm9O7aftsWMG
         BdLPieoZMA90g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        hsinyi@google.com, Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: (subset) [PATCH v4 00/11] drm/panel and i2c-hid: Allow panels and touchscreens to power sequence together
Date:   Tue, 19 Sep 2023 16:07:29 -0700
Message-ID: <169516486001.787935.12322857337806445764.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230727171750.633410-1-dianders@chromium.org>
References: <20230727171750.633410-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Jul 2023 10:16:27 -0700, Douglas Anderson wrote:
> The big motivation for this patch series is mostly described in the patch
> ("drm/panel: Add a way for other devices to follow panel state"), but to
> quickly summarize here: for touchscreens that are connected to a panel we
> need the ability to power sequence the two device together. This is not a
> new need, but so far we've managed to get by through a combination of
> inefficiency, added costs, or perhaps just a little bit of brokenness.
> It's time to do better. This patch series allows us to do better.
> 
> [...]

Applied, thanks!

[11/11] arm64: dts: qcom: sc7180: Link trogdor touchscreens to the panels
        commit: 989aac9dea7fcfc33b5eedc4ae44abbf71460a4d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
