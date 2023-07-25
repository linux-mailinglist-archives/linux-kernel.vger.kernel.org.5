Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E87176238D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjGYUhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjGYUhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:37:08 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AB6212C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:37:05 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-267f870e6ffso1659854a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690317424; x=1690922224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhdEP47Q6zcMA0F+PcMkdWz/9ABzj35GTZZYW72E4F8=;
        b=FK9uzQr2XJHv+OfyWZgjtunriUloqdtwx+ivv6sQ2PO2zuBkv8MqfPI9lg7syKN0Lc
         jKh6qXFqfVPH+Q6qa2kQ3Ihe8Ymc8CsB/6MVMGNgfmzaEbLiMCXZ6tlj4sYCiIfzo2r1
         6Fdvc5Qyo+4UaTFF7lBNW7PLpmXbQKhBDUpMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317424; x=1690922224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhdEP47Q6zcMA0F+PcMkdWz/9ABzj35GTZZYW72E4F8=;
        b=NOKGoqpPtE4G9eMypodh0fnlAxqzkT/ZPv7BUsiHRpPCwlvmKYGsaPBTWQR0v5V3N2
         6PDRJPgRqIojAza0pghfGipPAi+4pT8/yiKG8XnSkkfwCn3jElICm6vxVJZY0WRZWkzA
         krMLlrv8oaW7s2a2lfwDdjYVhLCAw8rZRUb+xHmHwMYhjVqTuGotsOr34d+tWUbudrOy
         uBZ/eFLjUNj7/SM3vzYNpv8vAvby5hb/h8ta28ToTfQBCKdtDT+HhTcrH+aIJkYu8DgH
         HIyp9Xd6oERTKbBUbo+SzhuuTrxv00SDc3/uwEsOY4Gpohn1oEEZQijzPnmIBAg32e0J
         3xMQ==
X-Gm-Message-State: ABy/qLZ4BeGtnisxWL7U2htsC8tweB8M/Kv30dWzs2alLgRn0+nRGZUe
        ZX+C2klYWokvK2ARGj1f4yDM0g==
X-Google-Smtp-Source: APBJJlE8zLseGuuhjbzBKd+iAHZds3QfI6mF3Uc1x/psuvBXvHbIdzRDRpl9iZDO7dZ4AOPJ1TwALg==
X-Received: by 2002:a17:90b:4b89:b0:268:2d6:74d6 with SMTP id lr9-20020a17090b4b8900b0026802d674d6mr235219pjb.16.1690317424748;
        Tue, 25 Jul 2023 13:37:04 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c363:4681:f5b8:301])
        by smtp.gmail.com with ESMTPSA id bg1-20020a17090b0d8100b002676e961261sm1396951pjb.1.2023.07.25.13.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:37:03 -0700 (PDT)
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
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 04/10] of: property: fw_devlink: Add a devlink for panel followers
Date:   Tue, 25 Jul 2023 13:34:39 -0700
Message-ID: <20230725133443.v3.4.Ibf8e1342b5b7906279db2365aca45e6253857bb3@changeid>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230725203545.2260506-1-dianders@chromium.org>
References: <20230725203545.2260506-1-dianders@chromium.org>
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

Inform fw_devlink of the fact that a panel follower (like a
touchscreen) is effectively a consumer of the panel from the purposes
of fw_devlink.

NOTE: this patch isn't required for correctness but instead optimizes
probe order / helps avoid deferrals.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Since this is so small, I'd presume it's OK for it to go through a DRM
tree with the proper Ack. That being said, this patch is just an
optimization and thus it could land completely separately from the
rest and they could all meet up in mainline.

(no changes since v2)

Changes in v2:
- ("Add a devlink for panel followers") new for v2.

 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index ddc75cd50825..cf8dacf3e3b8 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1266,6 +1266,7 @@ DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
 DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
 DEFINE_SIMPLE_PROP(leds, "leds", NULL)
 DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
+DEFINE_SIMPLE_PROP(panel, "panel", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1354,6 +1355,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_resets, },
 	{ .parse_prop = parse_leds, },
 	{ .parse_prop = parse_backlight, },
+	{ .parse_prop = parse_panel, },
 	{ .parse_prop = parse_gpio_compat, },
 	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_regulators, },
-- 
2.41.0.487.g6d72f3e995-goog

