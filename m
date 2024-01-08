Return-Path: <linux-kernel+bounces-19528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874A6826E5D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229BE1F22D18
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97484537E3;
	Mon,  8 Jan 2024 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMsofVPx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F16537FD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-557a3ce9942so1129770a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 04:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704717161; x=1705321961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OybVnChzpZZd58R6Wja2qOVNRv7BNYmPnvk8rkwqm98=;
        b=tMsofVPx9JKk721Kx6as/ycjkkPSJYqNsJPCKZYLiqw4wwhHnbv0PRc7z2LCu5oond
         9JHMDKKwIAUIl9fR3ZtxGME26AO4yR9HjZANf8dZUurnPDyklC4l0IV1uXCWAQad6Kwe
         fuA8v4fOKGpVgHH0wbgaPShfoFL2AIWkkxW2RsZ0br7PkybA5pCBo3hADCc0HhjlWjU6
         YSzWfxO/7i/06HQpcV8OCFeCTATxgtcQH7UNjKrincHcXjvd+XmLiJHgNN5SykwMhNih
         MAljMYhfUIvAst2GE1Pf2kzhrnUOyvu2S3l2K/Wz8R6SLTJZ/hq+1TO9Nvab3cOYruc1
         asfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704717161; x=1705321961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OybVnChzpZZd58R6Wja2qOVNRv7BNYmPnvk8rkwqm98=;
        b=e8jzQUmPkFIDUa4nD/ULBZiKSiirjZqYrYf5D0sEoSnlcjp0Z7f13l0NXkRkYJWTsa
         7PUPp0X00w3us2n1Pzpcx964+E1pb3A4Q9iupHbqhCS3DB1Xy5GBrAxWSEVnypeaYVI4
         RBXrA6PHXRX26FOmy8hkPdpfAAVv9GScwmRd4wdhaHC3sxuRaPIkEglb8G0Jn59gyYkI
         zEs+Vj6aUuS8jRA+F86fES2J16KzFZxV8neBRzu6PACrkR0eYkGscoOqVoZXA4+dL1yw
         XSNgMNOEgva6ZT8z+OhLHUrXqpsz2LArRKFLv1PaeTZVFBApNH5yx9oIjlxnnoruRMwN
         GhnA==
X-Gm-Message-State: AOJu0Yz1R5+rLqM8m2BenEJUBAtpeaNH28KHZgywpmNvy882U2oc7QJc
	NtLuAGZV1s+iPWk8MS4ME7BC+Sd8wYpnXC+t9uC0RYD0IDc=
X-Google-Smtp-Source: AGHT+IH7KYyxwTJNALeRq3oYMA4ASzmHDOu1dlUSY0fW0LrJLv4hQqpddVpS5nzDBXRMBPzGxxaQVg==
X-Received: by 2002:a17:906:6cf:b0:a28:e6b3:800a with SMTP id v15-20020a17090606cf00b00a28e6b3800amr972675ejb.89.1704717161537;
        Mon, 08 Jan 2024 04:32:41 -0800 (PST)
Received: from [10.167.154.1] (178235179081.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.81])
        by smtp.gmail.com with ESMTPSA id bs18-20020a170906d1d200b00a2808ee8ab1sm3892978ejb.150.2024.01.08.04.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:32:41 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 08 Jan 2024 13:32:23 +0100
Subject: [PATCH 06/18] clk: qcom: gcc-sc8280xp: Set delay for Venus CLK
 resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-topic-venus_reset-v1-6-981c7a624855@linaro.org>
References: <20240105-topic-venus_reset-v1-0-981c7a624855@linaro.org>
In-Reply-To: <20240105-topic-venus_reset-v1-0-981c7a624855@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704717148; l=956;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kXhMR6j6x8UUPoTkNpGBdxTOTiabGpXywak8UVlAUas=;
 b=IjUluzegb5LfVJy/+4amSn52zp1EhChG57OqSJNaJN8oBMLAufCdz4s3KuSnwAiO7mJ1ndEs0
 2/qagJFYxJ3BqAu7SLM08MGEyfky1JlMorpYZn5nO5Ek4+xB0UvOl7g
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some Venus resets may require more time when toggling. Describe that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sc8280xp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index bfb77931e868..9f4db815688c 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -7448,8 +7448,8 @@ static const struct qcom_reset_map gcc_sc8280xp_resets[] = {
 	[GCC_USB4PHY_PHY_PRIM_BCR] = { 0x4a004 },
 	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
 	[GCC_VIDEO_BCR] = { 0x28000 },
-	[GCC_VIDEO_AXI0_CLK_ARES] = { 0x28010, 2 },
-	[GCC_VIDEO_AXI1_CLK_ARES] = { 0x28018, 2 },
+	[GCC_VIDEO_AXI0_CLK_ARES] = { .reg = 0x28010, .bit = 2, .udelay = 400 },
+	[GCC_VIDEO_AXI1_CLK_ARES] = { .reg = 0x28018, .bit = 2, .udelay = 400 },
 };
 
 static struct gdsc *gcc_sc8280xp_gdscs[] = {

-- 
2.43.0


