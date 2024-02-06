Return-Path: <linux-kernel+bounces-55475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0684784BD27
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04B128BF28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2027617BCD;
	Tue,  6 Feb 2024 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xX9qjImQ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7690C175AA
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245031; cv=none; b=mYXQhjYpHfJIEr+nzdDU9EEpriNd7Q88O2o2Vikspmd4a+X0rL8L1u6U852JG8WdYBvUAbGCFUOEorOrZqHBymkir+TiH8zlHaEnVK+OFfRWSzzudtND97JjzP5n08mVQcjs8jA8U55urn0h9yNU3JTJ50vIECdsvALW3L4Uyvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245031; c=relaxed/simple;
	bh=cYbItYW2hueTIMDZ5ErUB7KsJqgkLUBYpnYuLwK48bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TO2Q/HCpzcObn/NFaEggUdqK6eE5R1sCLdeAvZYzQDeq70hinXXhQC1EQu6L9P4C55uPPBG7ZYw4RoGiA4H49gHdnvCHzgxYS8N/JZ3QNfb1smb0suD2Cscu84nsSB62uiLEsuIDxHxZ1ZCTY4Dh1UPBWhsoP/rmEPWRXQhSN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xX9qjImQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50eac018059so7397149e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707245027; x=1707849827; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJKRPokuZG9Shr1HCLUQ2NfmjznI2k78hzHx2xJmuZY=;
        b=xX9qjImQhpe8/9E60DMD14VQwWWr16qkOy38owYEaJQ8MyVsHSkCiiucC1+6/Q3DgP
         lb5iKrV7j9F2bfsOH5zF2GWaDbCgEXOa/KG78U2/1JhLrR7FBe+rxIrnJncTNlxf9yu0
         uW/d5eUcQPElTGPeHtzfplbArTC145olVm8Xl0KRJiXK6rU3rWianplmM0TnzI31ghr5
         vzcHvg9xCeysM421hgZhVf6Y9COmzIhDO2jBMgF725Uu4BPdFAylAQywp15iPtDX0e/x
         msHawMBA6iqx4r6JWU1bnCXmDzQmyLSCh0RKCaOvhKBKj2GyhMHRhVoIafp6O42NxSxU
         BOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245027; x=1707849827;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJKRPokuZG9Shr1HCLUQ2NfmjznI2k78hzHx2xJmuZY=;
        b=mZiRohC6Nc460q9/TFeJA9uaSg/Lv0D5u+SxT13lV6asLqQXZvCL41xUvQmo7iJX6J
         4Eya6pVn244jzA/VH3FfJIKlDmAdeN0mm5bIriDVcb0N7SMebB9pcGHSEnw+WXGOW0Kn
         pwEWWuvVXl9xhBPFvCvJlYY9g2jabuHQVMa1eG8fKXf/cjmqQnTxuZeIqBi3r14PjVGV
         1EHu3Bp7bBEcRxWPTFbf66y6tAZvRGAejevQdD4JIskqNz0lUr/V+4FkTrsXGU5ZF7TW
         iU6UWCIuz829nWZlw4n3LR0Q8WWsB6vnA4T4FY337R1AvjCncuyvud7/++qX0Px1ZlNn
         m3NQ==
X-Gm-Message-State: AOJu0YynFpqiDg8zAojOdOScO0X84cZLqntoZykONJnk+77t9FeJmW9W
	8orbta8vSiMa2sFVmABrCR0S5v58nK0edeIL46R+6WckdbyJ6r0HQRxVyPyEjpw=
X-Google-Smtp-Source: AGHT+IGIFUIRo+PA7YF57GnuCMh0z4jEYdINS8CLn+9cxEIJBnfRs4FcndJeS1BGByLuS1+qncg+Hw==
X-Received: by 2002:a05:6512:e89:b0:511:3ef3:cbc8 with SMTP id bi9-20020a0565120e8900b005113ef3cbc8mr2719942lfb.42.1707245027586;
        Tue, 06 Feb 2024 10:43:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVpdOisAfJ33Wxu+kdkaTbQq7mSdvuw1kPTzMAJqP0SZzPBGoAivXtdVkEGmok5eGaKGlkymgMH+8RmB5xaeAWTYt+afaw2CpcO5Ql18X4HGZDdB3N7fv1RzPa1hpWErlyKAK7ftoBQVGGphkPoAGYQBSxVrd0nYQrbIGC+Oel20s8dZr7B4jT2McFrt8cKI+b8e1Y5LN9Ap/IWBRg9WlvpKV+tPWY1SI3K43xCFytfMU7lm28iOgj/v57y7aAUzTZoK3tIBe6DoWk4C1l7Y1Bc9BKo8aQVro1+Cknd4DtpMwlJOkAhj1veizrdBq60wqtCbxIAOprZP/MWeMKRNm8qbA0xlbHaXdIb/1eF+ulgBefiV4KaK4L4eubR5mbyVU/rhys0zga5Zu6jLz9hUI0HWlObRjXHfmElLJGkE5Cz8HkjN0RoElc6OHPm4FVDjzH/VT6lLjEd
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id un9-20020a170907cb8900b00a384365e3b9sm562305ejc.195.2024.02.06.10.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 10:43:47 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 06 Feb 2024 19:43:39 +0100
Subject: [PATCH v2 06/18] clk: qcom: gcc-sc8280xp: Set delay for Venus CLK
 resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-topic-venus_reset-v2-6-c37eba13b5ce@linaro.org>
References: <20240105-topic-venus_reset-v2-0-c37eba13b5ce@linaro.org>
In-Reply-To: <20240105-topic-venus_reset-v2-0-c37eba13b5ce@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707245017; l=1264;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=cYbItYW2hueTIMDZ5ErUB7KsJqgkLUBYpnYuLwK48bo=;
 b=9wxflDm24MJVJvHCAenQNJMU7vt8sE50cxRtDntg30mLNIvc3fQjxlQ8h52Ml/4aRIMhCSRjR
 mVvL7NXaRc/Bfyb2cmfGNs7XhTkSilxhKjxir1CyKLalI31hwTBt24k
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some Venus resets may require more time when toggling. Describe that.

The value was obtained on a best-guess basis: msm-5.4 being the base
kernel for this SoC and 8280 being generally close to 8350 which is known
to require a higher delay [1].

[1] https://git.codelinaro.org/clo/la/platform/vendor/opensource/video-driver/-/commit/dfe241edf23daf3c1ccbb79b02798965123fad98
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


