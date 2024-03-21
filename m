Return-Path: <linux-kernel+bounces-109743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A97BA885523
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6C11C2118B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059DB77F10;
	Thu, 21 Mar 2024 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj3uD43T"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8E69971;
	Thu, 21 Mar 2024 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711007416; cv=none; b=m/dW8JzJ9vGIvMZxf6sl5gefSucBQwKoMU3Aa5yyIlCn4Tkt1nkV97veFXrvU+X7zar5joOUY8fDH8lKpEF0MJ78pAGdW+StqSEcsb6BqeRj8x441xjcUyTq5mwdEcHm351yhbJh8pWP05R/2+rLe7GSVsOVpzBa5HAfTgbvk+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711007416; c=relaxed/simple;
	bh=SMgAsKkEs5GaLb3ObM+ETzsphSav0e7nuDg0ec4brto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WbfoQvNijxgmiaakzDq0UCc/pdu4AtHqe6YIzVh4m281QsAPVmiIUepiTrlIq5FuaDh3p7/KSmk183D/Aux0X5wVPPn14/i6/Fmj1QCIbtlZH4CvLC7Ufn9lB8Za9ePmlFT5i0FMIEg2QtdNaR5itfnjU+4JkXswO4SsEfXFR34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zj3uD43T; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3412f49bac7so456599f8f.0;
        Thu, 21 Mar 2024 00:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711007413; x=1711612213; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2S5Rh9foK5diPxVaypXMHTBWZ5SvF8XVJcwbUU67u6Q=;
        b=Zj3uD43TfEhOIKKnQKRxeFlCtJv/Ylol45VqnkFbLp77K91ws4DrOmh0O6eKAfuaou
         G0qeE34AwxpGqn1We/4iMq1mB73i4QdLMM9YW0MbLx0kegcwlNOw3YGEJqFUAIQ5THlH
         qhh2lyh0BZxIddI2a4JEWgMyU8jPyeikgj6y/3jeBoAmwgxExev1N3tNQvbp1xuuQiti
         Ll8WctijO2iy+5AL/eF3/w10V2zQLbNHQ8645cQPbCus/jaUQob1tG+J3EKaAY1VebBa
         3OMkwWebafJQUCIhmwwv3eFqk2Id4TsYXVb6sNnFjq127i9GoBoGRuktL9r7jx/JMWgY
         iAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711007413; x=1711612213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2S5Rh9foK5diPxVaypXMHTBWZ5SvF8XVJcwbUU67u6Q=;
        b=U8Ie0D2EdvrJGPUiHkLizOGYiR62aevIZ2GnZYOf1VcaOQwW0Pd3PxYAJOMx3JHD1o
         kAUdDtIKdzZ44f7vq/v0bDcT4GyzS0ElFk4jv7rSYhDj+hblMyscB37uE789Xt8Velq3
         tbWlsPezUGI7pZEVJQVhbMde9+YTSK/9wKfNEG809MNGLj7c3Mth7692RxxE5cn1PdMp
         QNsHoMXPsSGXd5bc70CwiPX7zlZkjz44kkT6TP5Irwfo35owc8PQpyMpn545JrIR3pe8
         egIIS4x3zklfZ/oKbc1ScNq5g1UYPdTrriSu2wb9eRNV8uqu/Jju30iLFypiiN1NzRlt
         ByQA==
X-Forwarded-Encrypted: i=1; AJvYcCVbBvyKi4E8WqlSyK0u+QL0p5YspNB1eyy3cRsJSw2yEFeiAdt2xi70B/jkWzc4M7qAXxJl8LXDVFuy26iAIdKrT0+TKRBvVIVkfYxFF43Ahgv1ObD7ZzeLWKOwoM2zyqM/W+g0yNyO
X-Gm-Message-State: AOJu0YyT6KixSPVFq/Oekic6EKsrcI/ATJ9yHPs3pH2bjMaiO91+Sbvv
	minrwhbe8c8f/Y+1gjJv1MVfx+l7DRTLHdZLv5p50zCYr/MZjkbR
X-Google-Smtp-Source: AGHT+IF3Qt5A4TYSPqz5KdqZNYsS0+swvj35yi9DD4wcISqNf0gMYuL12H4v/zV5oLdb0fmnkUVofA==
X-Received: by 2002:adf:f646:0:b0:33e:c677:3272 with SMTP id x6-20020adff646000000b0033ec6773272mr1191665wrp.56.1711007413254;
        Thu, 21 Mar 2024 00:50:13 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id p1-20020a05600c1d8100b004146bda6c32sm4637096wms.9.2024.03.21.00.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 00:50:12 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 21 Mar 2024 08:49:57 +0100
Subject: [PATCH v2 4/6] clk: qcom: apss-ipq-pll: constify match data
 structures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-apss-ipq-pll-cleanup-v2-4-201f3cf79fd4@gmail.com>
References: <20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com>
In-Reply-To: <20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The match data structures are used only by the apss_ipq_pll_probe()
function and are never modified so mark those as constant.

No functional changes.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

---
Changes in v2:
 - add Reviewed-by tag from Dmitry
 - Link to v1: https://lore.kernel.org/r/20240318-apss-ipq-pll-cleanup-v1-4-52f795429d5d@gmail.com
---
 drivers/clk/qcom/apss-ipq-pll.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index 816b0d1f8d8c8..49da67435d4fe 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -140,22 +140,22 @@ static const struct apss_pll_data ipq5018_pll_data = {
 	.pll_config = &ipq5018_pll_config,
 };
 
-static struct apss_pll_data ipq5332_pll_data = {
+static const struct apss_pll_data ipq5332_pll_data = {
 	.pll = &ipq_pll_stromer_plus,
 	.pll_config = &ipq5332_pll_config,
 };
 
-static struct apss_pll_data ipq8074_pll_data = {
+static const struct apss_pll_data ipq8074_pll_data = {
 	.pll = &ipq_pll_huayra,
 	.pll_config = &ipq8074_pll_config,
 };
 
-static struct apss_pll_data ipq6018_pll_data = {
+static const struct apss_pll_data ipq6018_pll_data = {
 	.pll = &ipq_pll_huayra,
 	.pll_config = &ipq6018_pll_config,
 };
 
-static struct apss_pll_data ipq9574_pll_data = {
+static const struct apss_pll_data ipq9574_pll_data = {
 	.pll = &ipq_pll_huayra,
 	.pll_config = &ipq9574_pll_config,
 };

-- 
2.44.0


