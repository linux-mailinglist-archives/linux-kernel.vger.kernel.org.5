Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7D877097A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjHDUJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjHDUJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:09:29 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87171734
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:09:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9338e4695so40339941fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 13:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691179762; x=1691784562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YoaP8ctdIEX70sI3ohM7m73HpotCvwK/aq0fzzmyIik=;
        b=d5zF/bvVlGGmMwcthpeE7mor7SyOGr2U3pkFEUXcSfXa0/5EgVNWGOKSyEgi49LM7H
         ljuyaIqgGonLX24qBIQiVuXzNC3GH9rbTr4XaOrlptZW+San4+LiVBviBoO9EYxeEC3O
         e7DP7F82CoighfoXRpQ6ABgNjidkZsa0/EWOI4ZsAjUVY/t3XWCv935+G8uLyIpxsQZF
         ZkR7BxtI8gjbY3ow/tIpDQ8TVoiXQxGbqXrKRqEzFsnvJyNflBxrvJ3cr85BGuINEXco
         4Hww6SgVV8vu8De89C+mRfWeFCJVg1nPOLFAjulSg8Hk4JWvphvydIBVKnYEKF1xhQVv
         L5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691179762; x=1691784562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoaP8ctdIEX70sI3ohM7m73HpotCvwK/aq0fzzmyIik=;
        b=Vea7cG9e6ga4AF+zkAEA9IoDv0Q6mCUeS13z3FkBUr2ygKWhNiTn0voFytGrb6LpRr
         I1TTLMPV9RgI8w6ZWOZK+0euziBlCi/F6kfUZKY3ZRNd8JbSou92lHABL1JjgHZqOoBs
         Dh8NIaeDfZHrUKMZEjYKSPo0kj4wStXTfgqGPkzeyFJJh4FvCcCFaYTmyKZJq1MP2qKC
         o9YyLnjQ9FZ68UdpooRjhV2Et1kgzCHOMZ7vUiAfiOI8swVEKEBwhSBfChneqxYbgvY9
         MrQ3tDNku9NmiM7Y6gnxtKW3C9AIrnhwStIgGvym4kDd+mHHDakSH0cHOLV63oYDBf6S
         f2vg==
X-Gm-Message-State: AOJu0Yyf4/smeTiTgy+sxJTZDsZKvv3bjzW8Nh8tkwjSNGpWBr4JR1Jt
        Cam3hPuy4clQc9N0F6gTW7+k7w==
X-Google-Smtp-Source: AGHT+IE0KrxGHOmqEoCtC9gqBu1DaZicvRrHe9zW69RiWXnyLjntw6HfkFmTmNBzL4mmgNfhD6EYrw==
X-Received: by 2002:a2e:3819:0:b0:2b6:9ebc:daf8 with SMTP id f25-20020a2e3819000000b002b69ebcdaf8mr2252244lja.31.1691179761750;
        Fri, 04 Aug 2023 13:09:21 -0700 (PDT)
Received: from [192.168.1.101] (abym15.neoplus.adsl.tpnet.pl. [83.9.32.15])
        by smtp.gmail.com with ESMTPSA id m8-20020a2e97c8000000b002b6fed37b18sm580048ljj.101.2023.08.04.13.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 13:09:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 04 Aug 2023 22:09:12 +0200
Subject: [PATCH 5/6] media: venus: core: Add SM8350 resource struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-topic-8280_venus-v1-5-8c8bbe1983a5@linaro.org>
References: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
In-Reply-To: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691179750; l=2298;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=uSN1hqyZi5mM/oG9PLelJiPOErsFSc85HmMMAOkfHiU=;
 b=iadVeXQWa2VrEkkJDYKGZ55mlmse+58yxydgNwyj1Pnf31+aE91ChHAXrPGiCxbFRShBB7DCm
 quceFCCROz+A/O1N7IVDEaWTQpshFdKjVqAY1XiOBaTHktlI2EQjldE
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

Add SM8350 configuration data and related compatible.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index db363061748f..5f285ae75e9d 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -844,6 +844,44 @@ static const struct venus_resources sm8250_res = {
 	.fwname = "qcom/vpu-1.0/venus.mdt",
 };
 
+static const struct reg_val sm8350_reg_preset[] = {
+	{ 0xb0088, 0, 0x11 },
+};
+
+static const struct venus_resources sm8350_res = {
+	.freq_tbl = sm8250_freq_table,
+	.freq_tbl_size = ARRAY_SIZE(sm8250_freq_table),
+	.reg_tbl = sm8350_reg_preset,
+	.reg_tbl_size = ARRAY_SIZE(sm8350_reg_preset),
+	.bw_tbl_enc = sm8250_bw_table_enc,
+	.bw_tbl_enc_size = ARRAY_SIZE(sm8250_bw_table_enc),
+	.bw_tbl_dec = sm8250_bw_table_dec,
+	.bw_tbl_dec_size = ARRAY_SIZE(sm8250_bw_table_dec),
+	.clks = { "core", "iface" },
+	.clks_num = 2,
+	.resets = { "core" },
+	.resets_num = 1,
+	.vcodec0_clks = { "vcodec0_core" },
+	.vcodec_clks_num = 1,
+	.vcodec_pmdomains = { "venus", "vcodec0" },
+	.vcodec_pmdomains_num = 2,
+	.opp_pmdomain = (const char *[]) { "mx", NULL },
+	.vcodec_num = 1,
+	.max_load = 7833600, /* 7680x4320@60fps */
+	.hfi_version = HFI_VERSION_6XX,
+	.vpu_version = VPU_VERSION_IRIS2,
+	.num_vpp_pipes = 4,
+	.vmem_id = VIDC_RESOURCE_NONE,
+	.vmem_size = 0,
+	.vmem_addr = 0,
+	.dma_mask = GENMASK(31, 29) - 1,
+	.cp_start = 0,
+	.cp_size = 0x25800000,
+	.cp_nonpixel_start = 0x1000000,
+	.cp_nonpixel_size = 0x24800000,
+	.fwname = "qcom/vpu-2.0/venus.mbn",
+};
+
 static const struct freq_tbl sc7280_freq_table[] = {
 	{ 0, 460000000 },
 	{ 0, 424000000 },
@@ -911,6 +949,7 @@ static const struct of_device_id venus_dt_match[] = {
 	{ .compatible = "qcom,sc7180-venus", .data = &sc7180_res },
 	{ .compatible = "qcom,sc7280-venus", .data = &sc7280_res },
 	{ .compatible = "qcom,sm8250-venus", .data = &sm8250_res },
+	{ .compatible = "qcom,sm8350-venus", .data = &sm8350_res },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, venus_dt_match);

-- 
2.41.0

