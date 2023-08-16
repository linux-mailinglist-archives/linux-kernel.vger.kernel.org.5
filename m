Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAC577E6E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344882AbjHPQrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344932AbjHPQqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:46:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A86919A4;
        Wed, 16 Aug 2023 09:46:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so104415a12.0;
        Wed, 16 Aug 2023 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692204406; x=1692809206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsNvzP/rPks5RFe9XRQSnNtgu/uQYFDsxrAd/lRxGIA=;
        b=NrlqaEDoilO7TPeCetBx2PYTyTGcIFHOs/txZJklTk3Jp5VNQzGjAGRTihH1ZJAgsf
         QMlsFrXHFmP82oejZlzEBxbhwQwVXPqaWmG+2zolpZL9hAHuet69BK2ceDfZbMXdaaVm
         KsjETjFZYsbBmKrJldr88UX52hXHoZm0LDTeyppwz6gcSWo0VqA0WHKifjkTp1zLc/oY
         b4s0gukpRFIaEZoPFvxmIeKDKOuLwiLCOKxKFO8Ew9dCZVep1Qx09iq/3vmoDuNAsbml
         y6zukIInR1qqPp00uOQvQe/VqomAVq24Va99hl3IiuN9VK1AVwtgmJwXpvYO/Yi5dLBl
         DkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692204406; x=1692809206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsNvzP/rPks5RFe9XRQSnNtgu/uQYFDsxrAd/lRxGIA=;
        b=iJEJhuDN8lNjHHF2AT22r9pNWfkrzaSP/rdvAYSC/zHKi0zsupFLVslPevsTB82FLq
         tX922M1JU5iYHtvGBgglfe624Yc6mxc5p/l/srHx/Nx5p451mqNGivYJtD16u22/Msqy
         Wza5UKOTmiBra48CmcrbAgnI0je4QdEBb1kwtgJa/5UhLBZGXC5jOmu0V4RmZ2MGlLHr
         7w3xCYqr7gxOhgvbg9aVC4K/U1OqoeEHsjDgYs6N+Qe5nOTwPJ47QllBIWWBG9Gd3b5h
         w2AojRmdIF5Wrd33wEIaohhY+7wqLC+QbgVXRg5qpEpxuSs5HocNI9VOtt8vVUmrq+0T
         hlEA==
X-Gm-Message-State: AOJu0Yy72mpuVJcElE5tXyPcf/BdN/PSmFB4bom8PUC48p1OX/EffGVO
        TqZuI//sIv8FA4Ie5q8KBd0=
X-Google-Smtp-Source: AGHT+IEH7zXGt7eWEFq53OZOE+60kEKYj3rKEFPalBTmqErzLmyGvfCsw69FXtuYWo3a7d7cTZNg/A==
X-Received: by 2002:a17:907:6d18:b0:982:a022:a540 with SMTP id sa24-20020a1709076d1800b00982a022a540mr219609ejc.11.1692204405671;
        Wed, 16 Aug 2023 09:46:45 -0700 (PDT)
Received: from fedora.. (dh207-98-254.xnet.hr. [88.207.98.254])
        by smtp.googlemail.com with ESMTPSA id b15-20020a170906490f00b0099c971ba285sm8697400ejq.5.2023.08.16.09.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 09:46:45 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_mojha@quicinc.com
Cc:     computersforpeace@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 2/4] firmware: qcom_scm: disable SDI if required
Date:   Wed, 16 Aug 2023 18:45:39 +0200
Message-ID: <20230816164641.3371878-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816164641.3371878-1-robimarko@gmail.com>
References: <20230816164641.3371878-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
means that WDT being asserted or just trying to reboot will hang the board
in the debug mode and only pulling the power and repowering will help.
Some IPQ4019 boards like Google WiFI have it enabled as well.

Luckily, SDI can be disabled via an SCM call.

So, lets use the boolean DT property to identify boards that have SDI
enabled by default and use the SCM call to disable SDI during SCM probe.
It is important to disable it as soon as possible as we might have a WDT
assertion at any time which would then leave the board in debug mode,
thus disabling it during SCM removal is not enough.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v3:
* Squashed ("firmware: qcom: scm: Add SDI disable support") and
("firmware: qcom_scm: disable SDI if required")
---
 drivers/firmware/qcom_scm.c | 29 +++++++++++++++++++++++++++++
 drivers/firmware/qcom_scm.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 06fe8aca870d..de9d1a11d097 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -403,6 +403,29 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_set_remote_state);
 
+static int qcom_scm_disable_sdi(void)
+{
+	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_BOOT,
+		.cmd = QCOM_SCM_BOOT_SDI_CONFIG,
+		.args[0] = 1, /* Disable watchdog debug */
+		.args[1] = 0, /* Disable SDI */
+		.arginfo = QCOM_SCM_ARGS(2),
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+
+	ret = qcom_scm_clk_enable();
+	if (ret)
+		return ret;
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+
+	qcom_scm_clk_disable();
+
+	return ret ? : res.result[0];
+}
+
 static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 {
 	struct qcom_scm_desc desc = {
@@ -1468,6 +1491,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (download_mode)
 		qcom_scm_set_download_mode(true);
 
+	/*
+	 * Disable SDI if indicated by DT that it is enabled by default.
+	 */
+	if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-enabled"))
+		qcom_scm_disable_sdi();
+
 	return 0;
 }
 
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index e6e512bd57d1..7b68fa820495 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -80,6 +80,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_SVC_BOOT		0x01
 #define QCOM_SCM_BOOT_SET_ADDR		0x01
 #define QCOM_SCM_BOOT_TERMINATE_PC	0x02
+#define QCOM_SCM_BOOT_SDI_CONFIG	0x09
 #define QCOM_SCM_BOOT_SET_DLOAD_MODE	0x10
 #define QCOM_SCM_BOOT_SET_ADDR_MC	0x11
 #define QCOM_SCM_BOOT_SET_REMOTE_STATE	0x0a
-- 
2.41.0

