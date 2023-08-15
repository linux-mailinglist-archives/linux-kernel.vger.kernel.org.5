Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9DB77CDB8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbjHOOBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237122AbjHOOAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:00:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80915D1;
        Tue, 15 Aug 2023 07:00:38 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so8717096e87.0;
        Tue, 15 Aug 2023 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692108037; x=1692712837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/J5BLI7U7z59XFqFa9a1k82CWsFOs34AOvZvawtPipE=;
        b=oMxoxV6kO+sLMRBrjig1knnZ0b+lRE71fItzGR0cuJ3Hc8h/A2Gr2Mw3CtKDLlKGx2
         2vav5i8oxgdVM1UjqpKjOfhlDX5xxydo+/i0eo6WsmJMXPIQ2eKpy0Syp5GM/+9iCukP
         7/Kga1mbnlDu8O6e0xuZjJK03FQdRM/JBHZ+s11edaYvpLckIJkHS95QsuWyho6X0TH6
         yVo2zsVnnsREgyNZrQPB2t04V+J+mnnTV/Eh+NyY1Y7AAwrBb0IXzUEVdiW/fHH88mg8
         +oJeUlmAdaW5esUK3ThbWr+9FFsw6neKaAGEI0qqnRT5xICQH1hSFIJp2cD+VRUI7lNL
         FLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692108037; x=1692712837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/J5BLI7U7z59XFqFa9a1k82CWsFOs34AOvZvawtPipE=;
        b=KIvt8yQXKMNDJhdwE70VcNKtQpkcf4llfrMHwOggyAlJOdwCjMXrnTd+95KVdkmhZH
         n9Pn+AmCSGpKAVRpwLjfmqeJJzhnXVqzmNwcBdK+u5+mt74eYCQcxoaks36md5PUOL5j
         nf/wdhYFo3UDTQkh0QIA4AmWidMlYxJS5zFdXnPhnNXEfL5Zukuq9IjNQAsabmmMF+1w
         YIHnoqRDHQLL8kT2W0Q7kzEWYcEecO9fu6jLXMQtVrmmlyCEmyDcXst8EGDynk2+E3xT
         txOOnOuk5cLkP8DShCmpjs1fYYYSuyVaRx+PZgPjqXg2/UIRNpKTp9UToElrnKZk3aoN
         VThw==
X-Gm-Message-State: AOJu0Yyu4eL2gPOkia8rcddD6AEN8BPr6dQjkMOsG5YjGwexWWNxMzOo
        QfCgJIZAzzIfPP6J2f2Qdz4=
X-Google-Smtp-Source: AGHT+IG5B6uqja6yiLKv29LYsifjGiyjWIDrpp9xtWC0X/BlTvQk/UlQ8DOitzCpm/vw+yowW7wIYA==
X-Received: by 2002:a05:6512:a8d:b0:4fd:c884:51fc with SMTP id m13-20020a0565120a8d00b004fdc88451fcmr10960985lfu.58.1692108035768;
        Tue, 15 Aug 2023 07:00:35 -0700 (PDT)
Received: from fedora.. (dh207-96-14.xnet.hr. [88.207.96.14])
        by smtp.googlemail.com with ESMTPSA id a26-20020aa7d91a000000b00525740aa68dsm1049042edr.36.2023.08.15.07.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:00:35 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     computersforpeace@gmail.com, Robert Marko <robimarko@gmail.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v2 2/5] firmware: qcom: scm: Add SDI disable support
Date:   Tue, 15 Aug 2023 15:59:35 +0200
Message-ID: <20230815140030.1068590-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815140030.1068590-1-robimarko@gmail.com>
References: <20230815140030.1068590-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoC-s like IPQ5018 require SDI(Secure Debug Image) to be disabled
before trying to reboot, otherwise board will just hang after reboot has
been issued via PSCI.

So, provide a call to SCM that allows disabling it.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/firmware/qcom_scm.c | 23 +++++++++++++++++++++++
 drivers/firmware/qcom_scm.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 06fe8aca870d..abb54df663ea 100644
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

