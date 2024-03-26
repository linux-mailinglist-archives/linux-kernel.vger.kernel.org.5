Return-Path: <linux-kernel+bounces-119022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9A788C2CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFFD1F64550
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098F476404;
	Tue, 26 Mar 2024 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBVI7TeG"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8069F757FD;
	Tue, 26 Mar 2024 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457875; cv=none; b=DIH5dVYmeGKPgZRxJ8xU0LvE4p76SCeSwn8zNhmTy6zwc5RhOPtiFHShlObQhkikGbIlGVk48An3cidwwdKksR3Mp7A62Txxw6e0mO9Pk1cS17nL+BqV02VBezG8cVtI2NtexsVaVGs39/EG2LoKXZm0sSvTwZWyRFJtN2UvdXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457875; c=relaxed/simple;
	bh=oYCsxsfSFaFHBDDJQkn/FDgFzKP1hHPSiJsjZW1H/bI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lodtrPT2OtWGwrvuJZ8yz8a+p8b6iIw0MxVOPZQP7B/lu5+73gtyW8hqe+zyP/cVLxKucXpxdB7JgDZILHXs6CQbYK4/Sr+dDezytU7sY7cioZ+26WqxSeLOSM5i/+hxc/942jLlh060znEN9amUivge1EQZb/oVlPQe09/XZe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBVI7TeG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so6815087a12.2;
        Tue, 26 Mar 2024 05:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711457872; x=1712062672; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JS7nxv8tugyml+hsxbfo9kWmjKT1N355RpJIJwQxhuA=;
        b=SBVI7TeG7Xr/C4VdOzwIxGBzUBcOR5imGsCA0r+sknXw8T78TPw8BsbvjNQoEu/PX4
         jJRH+fldLRFkGQmk5gC001bdxfWHtFYzKv1pdb96MmNnkQqKWBOgM3I2Oc2YcpArBCgM
         pQwioy/EW/Ii+/tACwHf8LJ72a7a+mkDXBerlQp3JqhhsC86w5mGfby4wQRHHEM+AUOj
         9IgitjjPAAMSGfd0lcv7LvOKwyVs/e241XWHC1ySNOszdwzqXMFDxAuB9eisI/fSWhKI
         Mjx7ZH5geCQF+GEZeK4cUjg+itLtQGkOgCr79ZyUC4FtP0D50lsJqpV7k1VK3AKcFhZU
         7oBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711457872; x=1712062672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JS7nxv8tugyml+hsxbfo9kWmjKT1N355RpJIJwQxhuA=;
        b=ZY6tVnxwkfUkofBit1TZMgmd4CEfSNPLDSGvq9CjCpGrPa5j8aswhp1GFg4Pv1l93x
         0kOOrkGRFy2wMitl1FWULJWVQcuR31pasJqgJiSOsSV4toOazC/6xe0qq73lHFMj/mhE
         gFF61IShhAjkRnL643u+Zd7SInUHagBkHeg59SjhPTou4BdZv7if27VFRakszs21G0lY
         mOpYuWM7doj3jWFSK/bzdTUfK7toqo/UOvDpmEMDR0CTtsK0s3bV37Mh0V13+fVW/zg9
         KUR+0CPt5UhaBWSwPfaADbeMM9qyZ/l3Lxnb8SkCTb0vUwAHr40OmrSrdDP7rol5QZ+H
         beBg==
X-Forwarded-Encrypted: i=1; AJvYcCWnnR4JL31cjOpUVXb+i+jVxs5X3/3Jeii/BpMAeBKAP26V0Mg4+OgoRDlZDW5LDCXR1QEY3J3L8MqvvWFyUQLx0qKZyd9gv9QMvlPvMilaIsZrCJ7PaGaW4U3ivNp3ABdydCXGm31n
X-Gm-Message-State: AOJu0YzYe+Z7r1f0QCH7/SElLtGGe59DhiFNSOAHmXTWkUcu1g6xt2Po
	/s6Mb2AqB8xhUaLanfvrV5kqsYPMRPs1Vim5cIETGUSMo2MzvW0f8t+HMhXf
X-Google-Smtp-Source: AGHT+IEUU16a5r7JK4pdVixGyZyoUXZ4LHnPl74GPUB7g1QMuT12o+YC4RCDe42E7a/FJ0ZVr/mbHQ==
X-Received: by 2002:a50:bb47:0:b0:56b:ced7:8a53 with SMTP id y65-20020a50bb47000000b0056bced78a53mr6711351ede.20.1711457871874;
        Tue, 26 Mar 2024 05:57:51 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id n1-20020aa7c781000000b0056bb65f4a1esm4101413eds.94.2024.03.26.05.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 05:57:51 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 26 Mar 2024 13:57:42 +0100
Subject: [PATCH v3 5/5] clk: qcom: clk-cbf-8996: use HUAYRA_APPS register
 map for cbf_pll
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-apss-ipq-pll-cleanup-v3-5-15c4aeeb14ac@gmail.com>
References: <20240326-apss-ipq-pll-cleanup-v3-0-15c4aeeb14ac@gmail.com>
In-Reply-To: <20240326-apss-ipq-pll-cleanup-v3-0-15c4aeeb14ac@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.13.0

The register map used for 'cbf_pll' is the same as the one defined for
the CLK_ALPHA_PLL_TYPE_HUAYRA_APSS indice in the 'clk_alpha_pll_regs'
array.

Drop the local register map and use the global one instead to reduce
code duplication.

No functional changes intended. Compile tested only.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes since v2:
 - rebase on top of v6.9-rc1
 - add Reviewed-by tag from Dmitry
 - Link to v2: https://lore.kernel.org/r/20240321-apss-ipq-pll-cleanup-v2-5-201f3cf79fd4@gmail.com

Changes since v1:
  - new patch

Note: Although this patch is not strictly related to the subject of the
series but as the change has been suggested by Dmitry during the review
process it has been added here for completeness.
---
 drivers/clk/qcom/clk-cbf-8996.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/clk/qcom/clk-cbf-8996.c b/drivers/clk/qcom/clk-cbf-8996.c
index fe24b4abeab48..76bf523431b85 100644
--- a/drivers/clk/qcom/clk-cbf-8996.c
+++ b/drivers/clk/qcom/clk-cbf-8996.c
@@ -41,17 +41,6 @@ enum {
 
 #define CBF_PLL_OFFSET 0xf000
 
-static const u8 cbf_pll_regs[PLL_OFF_MAX_REGS] = {
-	[PLL_OFF_L_VAL] = 0x08,
-	[PLL_OFF_ALPHA_VAL] = 0x10,
-	[PLL_OFF_USER_CTL] = 0x18,
-	[PLL_OFF_CONFIG_CTL] = 0x20,
-	[PLL_OFF_CONFIG_CTL_U] = 0x24,
-	[PLL_OFF_TEST_CTL] = 0x30,
-	[PLL_OFF_TEST_CTL_U] = 0x34,
-	[PLL_OFF_STATUS] = 0x28,
-};
-
 static struct alpha_pll_config cbfpll_config = {
 	.l = 72,
 	.config_ctl_val = 0x200d4828,
@@ -67,7 +56,7 @@ static struct alpha_pll_config cbfpll_config = {
 
 static struct clk_alpha_pll cbf_pll = {
 	.offset = CBF_PLL_OFFSET,
-	.regs = cbf_pll_regs,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_HUAYRA_APSS],
 	.flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "cbf_pll",

-- 
2.44.0


