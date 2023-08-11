Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AC9778EF7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbjHKMQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbjHKMQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:16:07 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF3035A0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:46 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9c66e2e36so22289491fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691756145; x=1692360945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Jk+wJ9CO+wR8Vi5jTDSfP6BergdYMpS9/1Jq0Z1BzU=;
        b=ULBFRNhgYXX81w4M5ShH29ryrYEdEptBHe4D2LE92tByzskAYyN1T7geEX2H/FuNrA
         OMb4hcG40eH+n+kw0lHyxuOSUGAr/Id9NhLmiwitV3p2IJpQXmIpoOJyc9eXt9yJNQe1
         FFYoOS8CQ2Te9/zbHVc2sNwvsfB4YnSh1O3kJLqSurBkfxhuuJJ7G6ILj6TcKOk3IsSd
         oDfPj6ZjE0WLvft7U+8WtY/F3QOHfdqo46/0VfKi9XpZBkKRScr88Q6K4YSg1Bo6aV80
         4Bqm3dbnEeLp8ORge+x0Hv7xsfgaFNnVjQjl7d0c5NrTgdk2u130BTpR0sMeppUNY+x+
         qKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756145; x=1692360945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Jk+wJ9CO+wR8Vi5jTDSfP6BergdYMpS9/1Jq0Z1BzU=;
        b=lXzm+pz4S4L0cE8rgojLZiXZkDAop7qgSYptwMoXqAHQtYASjBcpQGeCB4RqghT8Lk
         8OQpuQxpaOoEYx1/Tg2HJ6d/TTpcqKv3XL+IhtO4LmoVrAG6vpNyC15zd6NDtWtNIgUA
         alC+ZpqejeTRRN0REWgGhKs8mWkXnHxeBvcX01azAWgFIv3QqJSpdUvm3vRDkvQdFxcA
         OUAPg1IksUDuQiI5vno72QsI/895lPJlmKFbHlDlywDpRJHEaD3jOulKRj6ytk7r21SJ
         +QfPCYEr6jDmFkxiPoyjH0QbFuyJczL4D7/a4nEX6yDW6qibIxhYuJGVpUPCQphhmXcf
         HIng==
X-Gm-Message-State: AOJu0Yyd6kHnxgxf+vnZd17kW91sTGJKBFRkliAEazye0NIc9iiqMgP6
        56+gWVt4cfnTm2YHJqsx30Mhr8ZpTpncg2JrrIA=
X-Google-Smtp-Source: AGHT+IHi0PEDCQvRH+mt4u1QtzDhD0bG18DZoMfNI50FtywW5c86rlDMx/bmd2YpzwscUlgTPfF++w==
X-Received: by 2002:a05:651c:84:b0:2b8:8642:c00d with SMTP id 4-20020a05651c008400b002b88642c00dmr708906ljq.17.1691756144897;
        Fri, 11 Aug 2023 05:15:44 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e870c000000b002b9ec22d9fasm848487lji.29.2023.08.11.05.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:15:44 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 14:15:25 +0200
Subject: [PATCH 14/20] interconnect: qcom: sdx55: Retire DEFINE_QBCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_retire_macrosd-v1-14-c03aaeffc769@linaro.org>
References: <20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org>
In-Reply-To: <20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691756124; l=4712;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=IjwJTrieF0QztXHJ4DEyMdHaBBf2IYgqsEQVXJiWaZ8=;
 b=OCnwXc4D354JqHfIG1aIvVzHOF/bnzBhzAMDoTNZvmEIS/kgWpgeHWczCJda4F0AUXBEKq8Y1
 NxoXeyjxQluDVGu4vXAdmxXvTIeVXyJbgOAaEqIitrC3Vxh2viJerzr
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct definition macros are hard to read and comapre, expand them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sdx55.c | 160 +++++++++++++++++++++++++++++++++-----
 1 file changed, 139 insertions(+), 21 deletions(-)

diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
index c4d4e24bf18a..4117db046fa0 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -643,27 +643,145 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.buswidth = 8,
 };
 
-DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
-DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
-DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_pn0, "PN0", false, &qhm_snoc_cfg);
-DEFINE_QBCM(bcm_sh3, "SH3", false, &xm_apps_rdwr);
-DEFINE_QBCM(bcm_sh4, "SH4", false, &qns_memnoc_snoc, &qns_sys_pcie);
-DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_snoc_memnoc);
-DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
-DEFINE_QBCM(bcm_pn1, "PN1", false, &xm_sdc1);
-DEFINE_QBCM(bcm_pn2, "PN2", false, &qhm_audio, &qhm_spmi_fetcher1);
-DEFINE_QBCM(bcm_sn3, "SN3", false, &xs_qdss_stm);
-DEFINE_QBCM(bcm_pn3, "PN3", false, &qhm_blsp1, &qhm_qpic);
-DEFINE_QBCM(bcm_sn4, "SN4", false, &xs_sys_tcu_cfg);
-DEFINE_QBCM(bcm_pn5, "PN5", false, &qxm_crypto);
-DEFINE_QBCM(bcm_sn6, "SN6", false, &xs_pcie);
-DEFINE_QBCM(bcm_sn7, "SN7", false, &qnm_aggre_noc, &xm_emac, &xm_emac, &xm_usb3,
-	    &qns_aggre_noc);
-DEFINE_QBCM(bcm_sn8, "SN8", false, &qhm_qdss_bam, &xm_qdss_etr);
-DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_memnoc);
-DEFINE_QBCM(bcm_sn10, "SN10", false, &qnm_memnoc_pcie);
-DEFINE_QBCM(bcm_sn11, "SN11", false, &qnm_ipa, &xm_ipa2pcie_slv);
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_pn0 = {
+	.name = "PN0",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qhm_snoc_cfg },
+};
+
+static struct qcom_icc_bcm bcm_sh3 = {
+	.name = "SH3",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &xm_apps_rdwr },
+};
+
+static struct qcom_icc_bcm bcm_sh4 = {
+	.name = "SH4",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qns_memnoc_snoc, &qns_sys_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_snoc_memnoc },
+};
+
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxs_imem },
+};
+
+static struct qcom_icc_bcm bcm_pn1 = {
+	.name = "PN1",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &xm_sdc1 },
+};
+
+static struct qcom_icc_bcm bcm_pn2 = {
+	.name = "PN2",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qhm_audio, &qhm_spmi_fetcher1 },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &xs_qdss_stm },
+};
+
+static struct qcom_icc_bcm bcm_pn3 = {
+	.name = "PN3",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qhm_blsp1, &qhm_qpic },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &xs_sys_tcu_cfg },
+};
+
+static struct qcom_icc_bcm bcm_pn5 = {
+	.name = "PN5",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_sn6 = {
+	.name = "SN6",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &xs_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn7 = {
+	.name = "SN7",
+	.keepalive = false,
+	.num_nodes = 5,
+	.nodes = { &qnm_aggre_noc, &xm_emac, &xm_emac, &xm_usb3, &qns_aggre_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn8 = {
+	.name = "SN8",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qhm_qdss_bam, &xm_qdss_etr },
+};
+
+static struct qcom_icc_bcm bcm_sn9 = {
+	.name = "SN9",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_memnoc },
+};
+
+static struct qcom_icc_bcm bcm_sn10 = {
+	.name = "SN10",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_memnoc_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn11 = {
+	.name = "SN11",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qnm_ipa, &xm_ipa2pcie_slv },
+};
 
 static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_mc0,

-- 
2.41.0

