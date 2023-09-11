Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FAB79ACF6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350554AbjIKVjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbjIKPKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:10:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2E8CCC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31f4a286ae1so4250208f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694445045; x=1695049845; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spHpGVd+zWE6f7Ydbw/UHW0+Hj7H33rl1DfjyP47SF4=;
        b=JZcLo7Eg8ALbmFDX5fQEP6gHt0MZgrRZkScd/OEQBWQEKIKaphzqjhvhUTVzCbn3h4
         //u4HuR8aNC1A6zb26GYTDYB5PWBaQL3i5V6i3yAnQ8KAtPgOHem04rNQK46mCdeOu72
         28pjKCr7mMR7V/A01ahwOzuSuf0jkDTMvnYjBTgY8KJQlrmthn/kJg24tNPYTF1yTtuT
         pgOk2tj8gIOz11eQcqF4PzOaV7oakpWqq7WMg89H7kPtiRRmZNUWZoHC819ZrUxmKWsZ
         UnMgMIs/vDz3QRAlkls4y9Tu6rfPLtRGA+bQYeFX9Shpyr6V0DeK/HhlL/AB2G75O54i
         lWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445045; x=1695049845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spHpGVd+zWE6f7Ydbw/UHW0+Hj7H33rl1DfjyP47SF4=;
        b=YjkC+xokx4OX+vte5KGSFw8ztO45G0HE1+CS3Isd9P2XIBlGHe554BsynKO4mfxRF5
         pBvCq9YhcMSJIDNYp5MV9O32Ugff1wOKiT/Q7gzsrvJYuaPVlwxNrqgo468c9TPN2FDz
         73PyMeJbckf8KqMxNVbH2KTS76GEPmmuBaXmy9PVcbIefhNhk/jNcWLxxd49Pc/rYJ4L
         kbktyYEJdlKyXzGNoMy3xAXgKG2mtpzvfWUj2Q1w6DnXolwxTRcfWCgCEdCS/2FJrLgk
         v+hzJur28hOweGpKDSir0TDSx6VZTCbQQuN3KfieOE2phv5NjiTOdmD+Jv6XNEDAywzn
         XM8A==
X-Gm-Message-State: AOJu0YzYBiAioMdF8kEDed7bZYDzFyV6txjqpsSIaZM2oDu4kaCwS4hd
        S74VesdU8CGKL0A8egTNS6e2VR+6Sudap7OTUE8LHw==
X-Google-Smtp-Source: AGHT+IF9n8CHyg52W67gOGjSdWupf5OMQPqUAhCiwoTnkFLT1nNeDkt3jhXGl7lq9AZkswN325E1+w==
X-Received: by 2002:a5d:5e07:0:b0:31f:accf:bf0d with SMTP id ce7-20020a5d5e07000000b0031faccfbf0dmr2123820wrb.31.1694445045574;
        Mon, 11 Sep 2023 08:10:45 -0700 (PDT)
Received: from [10.167.154.1] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm4681281edv.41.2023.09.11.08.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:10:45 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 17:10:24 +0200
Subject: [PATCH RFT 10/20] media: venus: core: Get rid of vcodec_num
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v1-10-a7d38bf87bdb@linaro.org>
References: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
In-Reply-To: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694445027; l=3392;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=E27PEdtMbBCeTz/SFqV5c29UzEMxfDQhGYV4gJ2hkIU=;
 b=eP4J6G7A9i2lLxLYhcoqh71Uc92r7ve2wbf+NBuVaQNSf9izMM8bxIK75Ts6XO4kACND90Syh
 2QQ2fNoX89ABnCC6EQx1ivSgkt68Jdq1uOFNxGL5VRPfGh+iiIZU7DB
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That field was only introduced to differentiate between the legacy and
non-legacy SDM845 binding. Get rid of it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       | 5 -----
 drivers/media/platform/qcom/venus/core.h       | 1 -
 drivers/media/platform/qcom/venus/pm_helpers.c | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 8aac7f60fc81..e83c790ccc80 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -654,7 +654,6 @@ static const struct venus_resources sdm660_res = {
 	.vcodec0_clks = { "vcodec0_core" },
 	.vcodec1_clks = { "vcodec0_core" },
 	.vcodec_clks_num = 1,
-	.vcodec_num = 1,
 	.max_load = 1036800,
 	.hfi_version = HFI_VERSION_3XX,
 	.vmem_id = VIDC_RESOURCE_NONE,
@@ -728,7 +727,6 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec_pmdomains = { "venus", "vcodec0", "vcodec1" },
 	.vcodec_pmdomains_num = 3,
 	.opp_pmdomain = pd_names_cx,
-	.vcodec_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
@@ -777,7 +775,6 @@ static const struct venus_resources sc7180_res = {
 	.vcodec_pmdomains = { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_cx,
-	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
 	.vmem_id = VIDC_RESOURCE_NONE,
@@ -834,7 +831,6 @@ static const struct venus_resources sm8250_res = {
 	.vcodec_pmdomains = { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_mx,
-	.vcodec_num = 1,
 	.max_load = 7833600,
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2,
@@ -893,7 +889,6 @@ static const struct venus_resources sc7280_res = {
 	.vcodec_pmdomains = { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_cx,
-	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2_1,
 	.num_vpp_pipes = 1,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 9a38d568117a..de180f8e7973 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -75,7 +75,6 @@ struct venus_resources {
 	const char * const vcodec_pmdomains[VIDC_PMDOMAINS_NUM_MAX];
 	const unsigned int vcodec_pmdomains_num;
 	const char * const * const opp_pmdomain;
-	const unsigned int vcodec_num;
 	const char * const resets[VIDC_RESETS_NUM_MAX];
 	const unsigned int resets_num;
 	const enum hfi_version hfi_version;
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 7f22a078b38a..816d16f9153a 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -622,7 +622,7 @@ min_loaded_core(struct venus_inst *inst, u32 *min_coreid, u32 *min_load, bool lo
 			VIDC_CORE_ID_1 : VIDC_CORE_ID_2;
 	*min_load = min(core1_load, core2_load);
 
-	if (cores_max < VIDC_CORE_ID_2 || core->res->vcodec_num < 2) {
+	if (cores_max < VIDC_CORE_ID_2 || legacy_binding) {
 		*min_coreid = VIDC_CORE_ID_1;
 		*min_load = core1_load;
 	}

-- 
2.42.0

