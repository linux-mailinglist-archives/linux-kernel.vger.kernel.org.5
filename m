Return-Path: <linux-kernel+bounces-55476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DEA84BD2A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F661F24C32
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FFD1AADD;
	Tue,  6 Feb 2024 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBF1Oxfs"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14756179AF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245033; cv=none; b=MsEfDKyyS+iZs1+Ajrc7K6avdOyg1jOTq73JmyZscGvtp8cXy4KxShYGYimD7UFfkOAtxnuF178qCeiMg0yPg+Cmc76BDjUQXSDvoIRNqyIoddlMBMVB9mHPZsuWUtF/C0WOG81P7RoOXaVfifJLNEs3M2z5Rx6ca1i7lUUe0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245033; c=relaxed/simple;
	bh=hNpPMHDWoOMTbeDBm7it/X/QFrunF620Ewnj+Kcxsr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QyVxEXTbPiMH0f6aQNQIqS4WiricvsrPJVKzn0cbo76vz1pZnJljXGqEvUs6ie36/M+pO5FduLEKeyfN6jwv3ICIBafylU9+jjtQAf7mgnYAvYJJRJeMbSmGzygDm0gh/RxvwwMvEYj1WrwWuAGHZnZPga1LbEQSz2nV/Ey1BDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VBF1Oxfs; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a30f7c9574eso785367466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707245029; x=1707849829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFLeZhpqcgOrxTzkmGltLeTXQrsN6KbONLIWDW0T9iY=;
        b=VBF1OxfsTAZ7I6JwNsA5G0KGrEGF/ZjPGh+u9ofkYg48jaHkeOjm4ZT6mY/dAJu3Ne
         igJXx6zY9FLhcB9IAKEHDow8HdeHPniVU4F2Bm5y5cNYCoK5eo7qaknl7KWnIXuZzs+3
         R2whsdfivPGPEeGW78OWQ6BEtLu7c+Gpicda2ZP8Di78c0zxxgSk82ua4suahVJBcAyW
         uTJHbEb1z/7HiF1XSu3cUHWMzuXATaCX2Mv8+iS6EyWR4wiEB0eX6tyZJf7S5Odr6HUO
         wLbVYZBeXWC1zPJZN3nGIh66/n8ZA74ZtJSjvZQdBsuUqDre+Y7fxfy860XJhXJgHM0z
         UhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245029; x=1707849829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFLeZhpqcgOrxTzkmGltLeTXQrsN6KbONLIWDW0T9iY=;
        b=k8YCq7ksm47eXd5CDOisOTwP+gZlkZKDJST5oiXyaKB/h4tpBUTVTbxCjYeEwrShsZ
         OqeFG+yMDBfdJTJU5hRFVKGBfRPGW+bn0ybphFU5RJjSN71dgOyvvzfq+xztsYnphfTq
         cDv/QYX/3CPGWM7tW67knf5EagEr1hR6F70vOo4M9Pk+ONy3ODrDygHDkxA1cBQmzrV+
         rwAd5Rc+cfOo6b7KeUqyMEaD8xt5VAS6B+fDxxhPRwD6BdB63vas5o+yOIOf9TZehqPt
         F3rE2tJF0UDY1yDwEjIEoAKkAiW5FHTFJMX2wVZBKbL5H/TCPKzdu5/3RXmNXQaHMC1s
         sL7Q==
X-Gm-Message-State: AOJu0Yx6owIuQp3BCqH7JXlCXKqjQ+7CkJH/LWJheH/HJtAdi1za7N9z
	u6yiTJZ6Gm+HT/uJTtfz704Uyynw9gJBpYiJG1G16fmq0JC3fxWZhNk3ijyGGPY=
X-Google-Smtp-Source: AGHT+IF8EUkiN6qPS1bLyCZevmsZyN3xOU7aEzLiG6w+ePDJ86YOkZa5vMlvYh2u9l1VfKYCWCoSMw==
X-Received: by 2002:a17:907:7f17:b0:a37:7fb9:ea27 with SMTP id qf23-20020a1709077f1700b00a377fb9ea27mr3179350ejc.48.1707245029517;
        Tue, 06 Feb 2024 10:43:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW0n4Idf82KqAzmo0iSS++sV2ROsgmaZfsqrWdGdQk9b2xQ+KNJt4Me0nbSIf+EaEBIlFiSxezbLEojrXI58VIG/Y74yez+aVr84ErxAVJaHJExcwbnZPXpHu1HVC8V1Wi6yG1h5BwCUg7ktuVo4SjQ3kB+xX71jAzHfjjCbydWjLgTIaXUbP2cAxziPqmOqjahxqNBzJD4KzvvgzzTEOYcOpjBmmmlS7tUYhNFHBdI66dTdVBteTE1mgwKxWeAziTz/XP/UrUXSY2mNBEZJxr5/L/LsWS6FNmMEDy2ZO4+ClPY6OqPqc2Eje7DBYlxe9pEARk2srG69aO3T56kP3eGgml3VE4A4k809TZyYentAxjLLZnABwxXsJ0sKyeBHvzmwhDaQsvECxIv8YkNgSKTd5mH9YyAgxF5j4t5A0OJYuvrNddcQBtvlp0Km+XCoMQf03QX5tT0
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id un9-20020a170907cb8900b00a384365e3b9sm562305ejc.195.2024.02.06.10.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 10:43:49 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 06 Feb 2024 19:43:40 +0100
Subject: [PATCH v2 07/18] clk: qcom: gcc-sm4450: Set delay for Venus CLK
 resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-topic-venus_reset-v2-7-c37eba13b5ce@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707245017; l=1261;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hNpPMHDWoOMTbeDBm7it/X/QFrunF620Ewnj+Kcxsr8=;
 b=f80sDBRtJTlp1b8hWBFK0RU641PLMr6/l0nYv4kIqYmXYXY/Ih5z96kTOSuNVwy0TeNwqWR4Y
 wKfAWeK3ETFCYzaP10y2a7Xyuby63Ix93i6/cFDuCx1GtLfJ4K3pHN2
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some Venus resets may require more time when toggling. Describe that.

The value was obtained on a best-guess basis: msm-5.4 being the base
kernel for this SoC and 4450 being somewhat close to 8350 which is known
to require a higher delay [1].

[1] https://git.codelinaro.org/clo/la/platform/vendor/opensource/video-driver/-/commit/dfe241edf23daf3c1ccbb79b02798965123fad98
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm4450.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm4450.c b/drivers/clk/qcom/gcc-sm4450.c
index 31abe2775fc8..ab8fb77d15a2 100644
--- a/drivers/clk/qcom/gcc-sm4450.c
+++ b/drivers/clk/qcom/gcc-sm4450.c
@@ -2791,8 +2791,8 @@ static const struct qcom_reset_map gcc_sm4450_resets[] = {
 	[GCC_VENUS_BCR] = { 0xb601c },
 	[GCC_VIDEO_BCR] = { 0x42000 },
 	[GCC_VIDEO_VENUS_BCR] = { 0xb6000 },
-	[GCC_VENUS_CTL_AXI_CLK_ARES] = { 0x4201c, 2 },
-	[GCC_VIDEO_VENUS_CTL_CLK_ARES] = { 0xb6038, 2 },
+	[GCC_VENUS_CTL_AXI_CLK_ARES] = { .reg = 0x4201c, .bit = 2, .udelay = 400 },
+	[GCC_VIDEO_VENUS_CTL_CLK_ARES] = { .reg = 0xb6038, .bit = 2, .udelay = 400 },
 };
 
 static const struct clk_rcg_dfs_data gcc_dfs_clocks[] = {

-- 
2.43.0


