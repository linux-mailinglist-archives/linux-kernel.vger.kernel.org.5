Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E710A7565CB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjGQOG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjGQOGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:06:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5810A1A3;
        Mon, 17 Jul 2023 07:06:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso46853895e9.1;
        Mon, 17 Jul 2023 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689602803; x=1692194803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VGGtLy42tXq8i70nRWR8TQ7FF5MysAyQGWfRhzKitW0=;
        b=bcN7cd5Loixv1mGPI4frS+1cnEfiLNq1R08jPHMi6P/rv3ccOTFN/QwkrBZUzn8Pro
         R86+HuQl9jtDco5m94JCOYIpHGzKQ8f9aD2Jsn/fXR2oPaVCOeY5jkjTbZOV2Jp2kCmJ
         gjJIXLY6YxlnJZ36xBi7vKQIYWQqxnHmfq8gSZpH55vGRgZOwRiU0ORVP3kvi+2p2jZf
         LaBu0touE7aofYsHp0xQEEAKBh3J+Cas7rcSnT17UU9rHzyd2sdsYlbUDh4sVov4Svop
         lP0L+NtHAoGFYnftSS6514FAFW1vQ8Z9n1abjSO8zklYHhVhe9i098eYMG2CTX6VnSS6
         DJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602803; x=1692194803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGGtLy42tXq8i70nRWR8TQ7FF5MysAyQGWfRhzKitW0=;
        b=On+GRr25LbjmRU7HL7QrT/nGBKSHvGk9GV5twVzg0eZNGm9aM4hkVysS6zzYZWFFJe
         UoYc4GfPiINZbP6OUhngYoDIRsR/miJsVIoT15MsqKS4iog2M6F+OEoVc5cSD6u2XsPq
         arf2Qav0DrOxlCUbiRgpyjsXrPAh65YoMelL31hxWmxBCwuOEnwjNF9m0cf2074gsF5F
         FS6yJmpOLiKKixQrUKedh0iFW5EMxR1hofwnTAgzZcatSE3uA4iFaUXw+n6dT3UD0iEz
         VSEQ4VFFuNSYl++Fl7dA0g+FpHIm75zTKvif4iJIW+klNUXh7GBvkyFjHGrKNUeiLw+p
         17lg==
X-Gm-Message-State: ABy/qLbOOKJ/ChtGksmmz2/cl5KNA15NLZlHls5KKa6PWoncx3ACr0BG
        JpS2Usqd5bIDhbcyk9t3gHY=
X-Google-Smtp-Source: APBJJlG6kAd8gMh7mEl7ZB8YF4NYhFgVr+x3eFjCbEXE1J/OMeeUTT2Wmcm7iGQZYl9bMYL21KnPQQ==
X-Received: by 2002:a1c:f313:0:b0:3fc:5bcc:a91a with SMTP id q19-20020a1cf313000000b003fc5bcca91amr354182wmq.6.1689602802203;
        Mon, 17 Jul 2023 07:06:42 -0700 (PDT)
Received: from localhost.localdomain ([176.200.123.3])
        by smtp.googlemail.com with ESMTPSA id u11-20020a05600c00cb00b003fbb346279dsm8045800wmm.38.2023.07.17.07.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:06:41 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] hwspinlock: qcom: add missing regmap config for SFPB MMIO implementation
Date:   Sun, 16 Jul 2023 04:28:04 +0200
Message-Id: <20230716022804.21239-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5d4753f741d8 ("hwspinlock: qcom: add support for MMIO on older
SoCs") introduced and made regmap_config mandatory in the of_data struct
but didn't add the regmap_config for sfpb based devices.

SFPB based devices can both use the legacy syscon way to probe or the
new MMIO way and currently device that use the MMIO way are broken as
they lack the definition of the now required regmap_config and always
return -EINVAL (and indirectly makes fail probing everything that
depends on it, smem, nandc with smem-parser...)

Fix this by correctly adding the missing regmap_config and restore
function of hwspinlock on SFPB based devices with MMIO implementation.

Cc: stable@vger.kernel.org
Fixes: 5d4753f741d8 ("hwspinlock: qcom: add support for MMIO on older SoCs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/hwspinlock/qcom_hwspinlock.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
index 9cf186362ae2..3f08cd4a5c28 100644
--- a/drivers/hwspinlock/qcom_hwspinlock.c
+++ b/drivers/hwspinlock/qcom_hwspinlock.c
@@ -69,9 +69,18 @@ static const struct hwspinlock_ops qcom_hwspinlock_ops = {
 	.unlock		= qcom_hwspinlock_unlock,
 };
 
+static const struct regmap_config sfpb_mutex_config = {
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+	.max_register		= 0x100,
+	.fast_io		= true,
+};
+
 static const struct qcom_hwspinlock_of_data of_sfpb_mutex = {
 	.offset = 0x4,
 	.stride = 0x4,
+	.regmap_config = &sfpb_mutex_config,
 };
 
 static const struct regmap_config tcsr_msm8226_mutex_config = {
-- 
2.40.1

