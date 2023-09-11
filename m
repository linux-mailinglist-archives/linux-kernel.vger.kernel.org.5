Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28F979B1CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358255AbjIKWIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241604AbjIKPK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:10:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0852FE40
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so5915173a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694445050; x=1695049850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dl99i48dgkFaFiuiu5aVJ8kJhbaWRuqEuatgk+IWw2o=;
        b=bB3xlBfauwKWWh6/VqQaM0saC7TVMEgb8exvJY+TC2Ll4kYlFjolOF0jhadlMEMFTZ
         tVd3b1rMiQlpIm208lr0IrvotSsC+c8xy9lzdDUTiX/gQBxo8WEaaQSKHTAQLSUkrp/b
         Lj70KCI6B7iQGmzmFzLgMHshxxhHzb9ltKZtloIvoSVUt/a2QcsP0FqykMtWOGUA3Jy+
         mbcocYFWgSTpnvwK4OqM0FiBRAA4AyxRinXy8I8mGJlBa7RCW1YPtweMJNd6UDVo3N/m
         0wG1j2lwILOR7qtPDog/Q4LUQ7PmNmZ5ScFkTcDRi61nnEAlPAomqLMOJ6pXZeXJOCAm
         SWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445050; x=1695049850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dl99i48dgkFaFiuiu5aVJ8kJhbaWRuqEuatgk+IWw2o=;
        b=pVBxd64HbTGMVLgetRj3q7dAkRjqXlqT/4SusL0RSj2ia6fBOOJM2ltOGxOUwax5fc
         l2h7jiV9g28fgp9HNMW8SxXRQUADgxTt0Sjpi4jVBJRhHmIM/1OMkZT1J6SvKj0gAlYY
         AHo5GPJvV2rjfcHupa9HyQbU4b2mbAfvIUX12jheenWRhmYVUW32M/aGkvcdWjVQJjU5
         /bZpNMfDDQI25P5UKfMfKJ8o1DytDSyc0Y1M4+P50NimcGt5OXE9148hTay2xUqZoIly
         Tms8PwWzaJpV1oBu1OapKXchKgcbJSuaRDI7myE6aSwA3nRtyeeAZDSydVuMRQBUfGvI
         k/fg==
X-Gm-Message-State: AOJu0YwHz60sEwWvAmJcy4XyJz3B2WcwlUvc+CU+MeWTffYZccKj01dv
        4EZC/IohCYzxCaSJLeoirkuGwQ==
X-Google-Smtp-Source: AGHT+IGjTwoKuO/nF9f+giZJp6zZCYwNV0et/hED8EkqY7QJ0N5afC2ym6nB9rOu5fmSKCdB4pPe6w==
X-Received: by 2002:aa7:d753:0:b0:522:2711:863 with SMTP id a19-20020aa7d753000000b0052227110863mr8641195eds.1.1694445050506;
        Mon, 11 Sep 2023 08:10:50 -0700 (PDT)
Received: from [10.167.154.1] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm4681281edv.41.2023.09.11.08.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:10:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 17:10:27 +0200
Subject: [PATCH RFT 13/20] media: venus: core: Remove cp_start
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v1-13-a7d38bf87bdb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694445027; l=2989;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=h53ZKh/yNo0bLYPAMV5n1Zw9RfUgxMBrX/Tc7gbPrsU=;
 b=MyR4nzOnMYNiQhw1jH6W3MyPjnn9iMncEi0lurWq1TO1u8q7eGsXCtmFz5wNbn4MLq1ZYMleS
 2DmBMguD4EUCFp4kFzbiIdckpfA+/Nsvm4/o53Hzrpc+oIcI4AflYkB
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

It's hardcoded to be zero. Always. Ever since msm-3.10. Or maybe
even before. Remove it!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c     | 3 ---
 drivers/media/platform/qcom/venus/core.h     | 1 -
 drivers/media/platform/qcom/venus/firmware.c | 3 +--
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 4dec10d21b05..bd624e965a92 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -650,7 +650,6 @@ static const struct venus_resources sdm660_res = {
 	.vcodec_clks_num = 1,
 	.max_load = 1036800,
 	.hfi_version = HFI_VERSION_3XX,
-	.cp_start = 0,
 	.cp_size = 0x79000000,
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x28000000,
@@ -719,7 +718,6 @@ static const struct venus_resources sdm845_res_v2 = {
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
 	.dma_mask = GENMASK(31, 29) - 1,
-	.cp_start = 0,
 	.cp_size = 0x70800000,
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
@@ -763,7 +761,6 @@ static const struct venus_resources sc7180_res = {
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
 	.dma_mask = GENMASK(31, 29) - 1,
-	.cp_start = 0,
 	.cp_size = 0x70800000,
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index fe4cb566d8e9..16acf738fd6c 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -81,7 +81,6 @@ struct venus_resources {
 	const enum vpu_version vpu_version;
 	const u8 num_vpp_pipes;
 	const u32 max_load;
-	const u32 cp_start;
 	const u32 cp_size;
 	const u32 cp_nonpixel_start;
 	const u32 cp_nonpixel_size;
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index fe7da2b30482..16e578780be7 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -245,7 +245,6 @@ int venus_boot(struct venus_core *core)
 	if (core->use_tz && res->cp_size) {
 		/*
 		 * Clues for porting using downstream data:
-		 * cp_start = 0
 		 * cp_size = venus_ns/virtual-addr-pool[0] - yes, address and not size!
 		 *   This works, as the non-secure context bank is placed
 		 *   contiguously right after the Content Protection region.
@@ -253,7 +252,7 @@ int venus_boot(struct venus_core *core)
 		 * cp_nonpixel_start = venus_sec_non_pixel/virtual-addr-pool[0]
 		 * cp_nonpixel_size = venus_sec_non_pixel/virtual-addr-pool[1]
 		 */
-		ret = qcom_scm_mem_protect_video_var(res->cp_start,
+		ret = qcom_scm_mem_protect_video_var(0,
 						     res->cp_size,
 						     res->cp_nonpixel_start,
 						     res->cp_nonpixel_size);

-- 
2.42.0

