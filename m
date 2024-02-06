Return-Path: <linux-kernel+bounces-55473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8D884BD21
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4222B28B28C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4026217582;
	Tue,  6 Feb 2024 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="End6W+xh"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1914292
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245028; cv=none; b=sTPkPyieeqmEKrO2Xnuqj7KwwMmjhYBZ4NO9fFebY2rXs3gF43/4nyA2MzfwkbOf37AslXM6mx5FdIfk58vdsbkJ4gtxh5SbblZJiILQw6OzoLoR781gL2GCIcEnx/wYUsT9x3ZbXyn5KbsFXm0JF+wt3Emt9Eq6lddikm2PgEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245028; c=relaxed/simple;
	bh=2ewvjxYTFuXfl1Lk2jvUqETAlBjYpSBzSi9qQsmkHxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F9M0GONAi39GWkbyXNR6GNY21c/e5Om0LqZ1nYynJu9TOrZeHNTVoh/tGars96w+xmXl0eTyj8OplJj34ZZrlt2r5FB4camSulYbxZY6m0geRzWZzp5jjnpFHmp2BluXhRDsQvJh9jg5ynUEuzVS3KZF0/8nVIaHctrswq1Ubjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=End6W+xh; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a38291dbe65so104885666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707245025; x=1707849825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRc/E0OawVy3KfCwkARwDXGHPJlfd3wz1+hpXwWRbNA=;
        b=End6W+xhX+zx39ngK8pw2qUApKR87qcgEyIZPB75a5yPbh0JB5QXSrzzdC2jUCr50T
         3cCnhTX3bWRHR/DVFGDw5vgjUcPgutk8hyvz6NYz7f4mET/o4MXM0XJFNjoixZnrLG+9
         4A+utrNWyctwkOjzBbdKp+PV25sF/2HV+d+HBhxDWfIOchnUbyy/5dHGv7wgt9x0SAe2
         Ev6l2GSMD4YaXpSZJKWIuUeo7DEPCEcv478+lc+lXBkZZ7VdyUYSd41uvwe0+nNc5YXp
         HkGtpWDmbz47Zg98dLXAcfD/sOt2eR7nTDaa/y0n2gKgPoXHCXgyXYx3J+5bXuh1/k/1
         V7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245025; x=1707849825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRc/E0OawVy3KfCwkARwDXGHPJlfd3wz1+hpXwWRbNA=;
        b=IV79aeofJHoO6/OlIrsXBG7MXvYfwk7h8YuHahTf8diN144Qp6ByPs/9Mo+XwXyq1C
         sngZ+YURm93OLVhx0UgfQ+IBvHK6Pd78/hh+fm8b3uJf5owmfdgtBEWETuruSmklGZxR
         SIKfkPUgLc01/5Zst+ynYHvbQWvPoYT1fXqXs0tursVjysz0NC3RwK6VCg+sIKsLBX36
         nMSSCJmR6O+DFs6HgrXJNLQmZshj0IgyK5R0r9Ldo8FLQBzLpwOiVPRgT7h0+hZVQ5L7
         K7N/yMpzuVgIvdUyqWMR6sNcZQKl3dKEKGWe1t4HvFkdgaSSQP+hEfmc62K6dCWmUQRJ
         VsPw==
X-Gm-Message-State: AOJu0YzdKPVFH0NNZKpZOlV6CkmOHMEZFCzIpuD3JftbkHb8d0AevlAl
	PHVgh05jn7EKGsVGCZCOyxuYZQg4WwvnshTdIT112gzVDiCD9seHhXV/q2xU2/E=
X-Google-Smtp-Source: AGHT+IEuh/uUEPdWaT2fIuS+vpCG1uskuLnlNHg7EXttq5ew2eUrcb2WVhzyOPtQaX4We1zaIyIh8A==
X-Received: by 2002:a17:906:2406:b0:a35:db4d:2ca9 with SMTP id z6-20020a170906240600b00a35db4d2ca9mr2471868eja.31.1707245024772;
        Tue, 06 Feb 2024 10:43:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWHt/dJgv5sbPXb9J6mG/1MeMQMplcgRfmAdpw8nwakHXqNLySlCcH81Dqz/4/dogrLyEvgORqLM2wi2HO7YiH2dzk3SuFZJeHZuqgrNdn4ADuSjd7qZgB5Seou3er0TylcmUrwA2PlN1IDwxRcbt+ppMw/w3thsfXwWx2SZa/kfShVIEJLqj439bVMKkQNUDAibiIKE/DjJn1fWOqjyW+UaILLUQJu7QHBHpxercLtrIt6NfFI1+ieXmlTzDkA8z/JcwX1mD0noiLpHvA9R3EftAfypdm2FvFukD+8vEbrbZdRrchnYVQQHGeFPvN4qGWBL+tgYyaoOpRGTOPQSoqr61H4Ry3xJ4etDGvnThhRmEX4C/ReY2kYH0kl44HEMdCVvkgYeRInMrRa37i4QpFmMoLrKhsN4cN/q7joN3mgYjY0VIyqvYV+B8T4Lw31mjlHcKaRvFuy
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id un9-20020a170907cb8900b00a384365e3b9sm562305ejc.195.2024.02.06.10.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 10:43:44 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 06 Feb 2024 19:43:37 +0100
Subject: [PATCH v2 04/18] clk: qcom: gcc-sa8775p: Set delay for Venus CLK
 resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-topic-venus_reset-v2-4-c37eba13b5ce@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707245017; l=1260;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2ewvjxYTFuXfl1Lk2jvUqETAlBjYpSBzSi9qQsmkHxk=;
 b=VbGIar/lFUsTjvxoVehzAI4eFVsChuq7EXlEbINw1h434cIzmQKmAg/btzj43o7pVDOBsC9gF
 zxk5PY27uN3B4kD++FhXbv/oR36QzECTS99e2XgpyqvXhuKiMI8f6EM
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some Venus resets may require more time when toggling. Describe that.

The value was obtained on a best-guess basis: msm-5.4 being the base
kernel for this SoC and 8775 being generally close to 8350 which is known
to require a higher delay [1].

[1] https://git.codelinaro.org/clo/la/platform/vendor/opensource/video-driver/-/commit/dfe241edf23daf3c1ccbb79b02798965123fad98
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sa8775p.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sa8775p.c b/drivers/clk/qcom/gcc-sa8775p.c
index 8171d23c96e6..c2b403cb6301 100644
--- a/drivers/clk/qcom/gcc-sa8775p.c
+++ b/drivers/clk/qcom/gcc-sa8775p.c
@@ -4662,8 +4662,8 @@ static const struct qcom_reset_map gcc_sa8775p_resets[] = {
 	[GCC_USB3UNIPHY_PHY_MP0_BCR] = { 0x5c020 },
 	[GCC_USB3UNIPHY_PHY_MP1_BCR] = { 0x5c024 },
 	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x76000 },
-	[GCC_VIDEO_AXI0_CLK_ARES] = { 0x34014, 2 },
-	[GCC_VIDEO_AXI1_CLK_ARES] = { 0x3401c, 2 },
+	[GCC_VIDEO_AXI0_CLK_ARES] = { .reg = 0x34014, .bit = 2, .udelay = 400 },
+	[GCC_VIDEO_AXI1_CLK_ARES] = { .reg = 0x3401c, .bit = 2, .udelay = 400 },
 	[GCC_VIDEO_BCR] = { 0x34000 },
 };
 

-- 
2.43.0


