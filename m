Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4A97EF7DC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346191AbjKQTaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346184AbjKQTaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:30:11 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6B3D4E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:30:04 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-408382da7f0so19471195e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700249403; x=1700854203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/VFXQyC/uHK3jgeZHFzLlSxky95FXvt0ibC3wwB25I=;
        b=coNfcDQRGsQ5oPJP8GxpskUayy5/XQGJDSjMJt1o0sFCFYiOAHk+8wS/cDoeXsozVC
         bME6mfzxz0DZycL8mX/6dIm5LIEWjOmRzh//NoW+TRNAUrxYaQqOOhkucn9VMpWPiNTI
         1v7Rs9QR1TpXiir9tQxq2XkZyv1QWPhU5QLsuCThdNFTreFm0ban+E4t/l89bhJUjo6M
         qEEgNBiwyyLMcwXJcahinicjC91ZWig1rxDmtG7qTPRMPfIucTzvHzOa8N1IQaqWtndg
         tGN+HjEcvAhLUL9xdEMTRf4HzawKBGGS4+SkObOE+njd+9BikaUoo4q3S3Q8prSc25iV
         LM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700249403; x=1700854203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/VFXQyC/uHK3jgeZHFzLlSxky95FXvt0ibC3wwB25I=;
        b=rFTG3Me9ohYGqcap1bcxf/2WllwchygrteAGvoxuNYeiKQtDqy8ORBAJzCPPLdOz+e
         j3DlhE0ePar8lmBMkahSQFdQw1IAMXwePoFy7tBBPpFrcBQqfAwcfIRP/lovNxceGpQw
         MR3m7ecIWI6BbIC5LgcKcm7mqoBNZEKHSZyDrRF0E6tlagEfG2MKTzSAKw1/3evVJmwt
         pymORnfmJ1ica1XVOcbqTJW94ZcZN68oTqizbMZZZ4XhSWc8RbPcDyAfmv58n0c++TCV
         aiFwqvLyO5R6/92TUaJb4gMj+WvHgOA+p7h7nQIep3X1K+WGxBO5579uB3ZQWAO1/tGp
         8MrA==
X-Gm-Message-State: AOJu0Ywdvrfix4wuRdqFXuUF6brkB9a7Cp3BAt1qG+OCPWJ+iTJ8bXW4
        4pgi1kZi6WJ5ODMc3b4ZY8o=
X-Google-Smtp-Source: AGHT+IHUtt6p7V1k4VMSwACurJrtlpo0Demrw29OzxDby05ataPD6stOjARSquR8hdGydeLf/98H0g==
X-Received: by 2002:a05:600c:4797:b0:3fe:1232:93fa with SMTP id k23-20020a05600c479700b003fe123293famr87569wmo.22.1700249402857;
        Fri, 17 Nov 2023 11:30:02 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id 22-20020a05600c021600b0040523bef620sm4440397wmi.0.2023.11.17.11.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 11:30:02 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] w1: ds2433: rename W1_EEPROM_DS2433
Date:   Fri, 17 Nov 2023 14:29:05 -0500
Message-Id: <20231117192909.98944-3-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117192909.98944-1-marc.ferland@sonatest.com>
References: <20231117192909.98944-1-marc.ferland@sonatest.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Ferland <marc.ferland@sonatest.com>

Rename the W1_EEPROM_DS2433 define to W1_F23_EEPROM_DS2433 to make it
clear it is associated with family 0x23.

This is ground work for supporting both the ds2433 and the ds28ec20.

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
---
 drivers/w1/slaves/w1_ds2433.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index e1e45ea1bfa4..6b04fdef2923 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -22,7 +22,7 @@
 
 #include <linux/w1.h>
 
-#define W1_EEPROM_DS2433	0x23
+#define W1_F23_EEPROM_DS2433	0x23
 
 #define W1_EEPROM_SIZE		512
 #define W1_PAGE_COUNT		16
@@ -296,7 +296,7 @@ static const struct w1_family_ops w1_f23_fops = {
 };
 
 static struct w1_family w1_family_23 = {
-	.fid = W1_EEPROM_DS2433,
+	.fid = W1_F23_EEPROM_DS2433,
 	.fops = &w1_f23_fops,
 };
 
@@ -322,4 +322,4 @@ module_exit(w1_ds2433_exit);
 MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
 MODULE_DESCRIPTION("w1 family 23 driver for DS2433, 4kb EEPROM");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("w1-family-" __stringify(W1_EEPROM_DS2433));
+MODULE_ALIAS("w1-family-" __stringify(W1_F23_EEPROM_DS2433));
-- 
2.34.1

