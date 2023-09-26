Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221027AE8B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjIZJNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjIZJNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:13:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE4CBF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:13:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50435ad51bbso11412053e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695719625; x=1696324425; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eRJvToNUf5WqQrtFGrRXNgdtxFqUONQI/Mo3ZEgnrNU=;
        b=KDynM2dEjuanBtO/4Mfu6PuTkIvUuTw5BnOXe6s6HiVL3m6N+g1R8gZDCfSzU5U9ie
         rRVDc/kWqMpuHXKBFKuPiS5iVa07VnW9KrjkZSFpyHknK1vttN9n+enzNuI1z1GPqB0A
         jjHGJWwa6QXYkongJTudmQfwWHBuCSw55QplY5Bxi5UlkfWwpwDL8/OOC20rSKsZZNZj
         aMCwCM3VMZ8lFJBjgRRhe1ecgkGvvA/G3wXXELKlBr+sSIOAG5Y9HS7Wts2Lr1pjUNw9
         Hn29Lp1kbrnmFsD7tLSK76qi6hi9DthL2E/fEyN0IYFHJQBeyUEdspvdSB2F3jCrdqVe
         JDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695719625; x=1696324425;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRJvToNUf5WqQrtFGrRXNgdtxFqUONQI/Mo3ZEgnrNU=;
        b=rk8GR9uM5RaUPxIhq1ZRs6Mbxq8vIelqPVkLyj/68JvxGnq/lD0Y0T5LIpBghI1lhy
         6rrFB74Bn9O5m/0w0YZAxd4Vsm5ymizEz4sfUFiivhyv86Fv5tklFvlvLLwEq+LEy8mY
         cHzbxX3FkiB/Xcw7kK/HpC3h9EcKhZD3elLlszZHZsAvPQKy+2I7tvEpq6QG3G+2daKR
         77naEp7J98EFR231/vPPRcSS1JLz4ImfNBp7fxMjit7JvT3G6PMZtZ9/ImPxrACTvOtW
         nPt+8zkHZ1pVbbZtB6HL21jucKi1+KyyVvHDNnHkzWGf48wglYMZK2Mv1T1UwHX6rd48
         VY7Q==
X-Gm-Message-State: AOJu0YxWFjGSM8uNkXG4m4ensdGZUunWPg+ivGN7bW63cPsz6VvyRohe
        3RfOc2gtsGLNyPn68eCC4MltF3PZG5Aj2Ot0sz0=
X-Google-Smtp-Source: AGHT+IHQC2xWWevS8Hi+Jr/qaTcfGVDca/jkUjpllY+Uc4Ot+5d3IGKnBnZr1mdGhCNBdq/0TbWuOw==
X-Received: by 2002:a05:6512:b1a:b0:502:a942:d7a8 with SMTP id w26-20020a0565120b1a00b00502a942d7a8mr8084934lfu.69.1695719625468;
        Tue, 26 Sep 2023 02:13:45 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id n19-20020a195513000000b004fba82dde47sm2151248lfe.123.2023.09.26.02.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 02:13:45 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Sep 2023 11:13:44 +0200
Subject: [PATCH v2] watchdog: ixp4xx: Make sure restart always works
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-ixp4xx-wdt-restart-v2-1-15cf4639b423@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMegEmUC/22NywrCMBBFf0Vm7UiT1Edd+R/SRWMm7YA0ZRJqp
 PTfjQV3Ls+Be+4CkYQpwnW3gNDMkcNYQO938Bi6sSdkVxh0pU3V6Bo5T3XO+HIJhWLqJKE7Wa8
 vdWPU2UAZTkKe8xa9t4UHjinIe/uY1df+csd/uVmhQk/aNlYZ5ay/PXnsJByC9NCu6/oBv15jF
 LUAAAA=
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IXP4xx watchdog in early "A0" silicon is unreliable and
cannot be registered, however for some systems such as the
USRobotics USR8200 the watchdog is the only restart option,
so implement a "dummy" watchdog that can only support restart
in this case.

Fixes: 1aea522809e6 ("watchdog: ixp4xx: Implement restart")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Switch debugprint about only supporting restart from dev_err()
  to dev_info().
- Link to v1: https://lore.kernel.org/r/20230925-ixp4xx-wdt-restart-v1-1-fe2b9b131dbf@linaro.org
---
 drivers/watchdog/ixp4xx_wdt.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/ixp4xx_wdt.c b/drivers/watchdog/ixp4xx_wdt.c
index 607ce4b8df57..ec0c08652ec2 100644
--- a/drivers/watchdog/ixp4xx_wdt.c
+++ b/drivers/watchdog/ixp4xx_wdt.c
@@ -105,6 +105,25 @@ static const struct watchdog_ops ixp4xx_wdt_ops = {
 	.owner = THIS_MODULE,
 };
 
+/*
+ * The A0 version of the IXP422 had a bug in the watchdog making
+ * is useless, but we still need to use it to restart the system
+ * as it is the only way, so in this special case we register a
+ * "dummy" watchdog that doesn't really work, but will support
+ * the restart operation.
+ */
+static int ixp4xx_wdt_dummy(struct watchdog_device *wdd)
+{
+	return 0;
+}
+
+static const struct watchdog_ops ixp4xx_wdt_restart_only_ops = {
+	.start = ixp4xx_wdt_dummy,
+	.stop = ixp4xx_wdt_dummy,
+	.restart = ixp4xx_wdt_restart,
+	.owner = THIS_MODULE,
+};
+
 static const struct watchdog_info ixp4xx_wdt_info = {
 	.options = WDIOF_KEEPALIVEPING
 		| WDIOF_MAGICCLOSE
@@ -114,14 +133,17 @@ static const struct watchdog_info ixp4xx_wdt_info = {
 
 static int ixp4xx_wdt_probe(struct platform_device *pdev)
 {
+	static const struct watchdog_ops *iwdt_ops;
 	struct device *dev = &pdev->dev;
 	struct ixp4xx_wdt *iwdt;
 	struct clk *clk;
 	int ret;
 
 	if (!(read_cpuid_id() & 0xf) && !cpu_is_ixp46x()) {
-		dev_err(dev, "Rev. A0 IXP42x CPU detected - watchdog disabled\n");
-		return -ENODEV;
+		dev_info(dev, "Rev. A0 IXP42x CPU detected - only restart supported\n");
+		iwdt_ops = &ixp4xx_wdt_restart_only_ops;
+	} else {
+		iwdt_ops = &ixp4xx_wdt_ops;
 	}
 
 	iwdt = devm_kzalloc(dev, sizeof(*iwdt), GFP_KERNEL);
@@ -141,7 +163,7 @@ static int ixp4xx_wdt_probe(struct platform_device *pdev)
 		iwdt->rate = IXP4XX_TIMER_FREQ;
 
 	iwdt->wdd.info = &ixp4xx_wdt_info;
-	iwdt->wdd.ops = &ixp4xx_wdt_ops;
+	iwdt->wdd.ops = iwdt_ops;
 	iwdt->wdd.min_timeout = 1;
 	iwdt->wdd.max_timeout = U32_MAX / iwdt->rate;
 	iwdt->wdd.parent = dev;

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230924-ixp4xx-wdt-restart-d6bf28493173

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

