Return-Path: <linux-kernel+bounces-106057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFACC87E871
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48631F21479
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB3138DF9;
	Mon, 18 Mar 2024 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzbMFTFj"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0475B376E6;
	Mon, 18 Mar 2024 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760808; cv=none; b=COvpoM5AfQlG8VgdxoDfakyhTtpn3mMSx2lXU3YJNplJLxifTayCrTGYhQFsG7gQrnVznf2DHWj+hc+6PxLhIRchleFAruEuQ4/HXhrfls9gwa4tWUNQPhl2ZDmNg5r54anAKekyfmC46IkYhJ14dDn6D/hfEPkSfJo6zqJJvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760808; c=relaxed/simple;
	bh=h168MlEyYXbWqKmcr3c1QrEYW+OujZ+/o9TumUSwsqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PB23//lSNdKOcNV4BeabupYHFVYQ3fIIvjufdTvI93A2/G7dxwyVHJh0HJSk21vQjCPRpK2eI5IYpMQIUdo4iza6U0cEivZQPdGAIOKQkkDcGsxNBjFc7wptmOOcqymMb2S4K0WjG5E9T0/3cpDLsx/Imxt2OtnQINDfqgVvZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzbMFTFj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ed5b6bf59so1580283f8f.0;
        Mon, 18 Mar 2024 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710760805; x=1711365605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11SsO5DV2l7dsIFWxNjWwkgefIRCA6N+9rlBR7yanMQ=;
        b=JzbMFTFj4fia25eKpEJv6uw2fj8RkPSoMynJ0cH8dNVrW3EbWUQmXF44zVWQkxSmK9
         Ks2Zns/Mrzj8PXoarOI4SrH+asH4pQvF9MnVnj4+ihMNMaw+aUfUVWC6Quw7CnGMWa/4
         DXWUl3HW6LGFKbi1gJAPC5Mg9PVroHKAlxFAbTFn6L1NXmgopsGC5n+UIrvtZoJPXt35
         h8qtLwC2QtdgFmlfdt3s0iJwqFeelPJEHjMZoGWkSGlCYGjKGU5lrKsDiJ383FMLlKh/
         uvoWMBtyoFhNaLI0gO3bbQUAZDMtWwrbwz9Hl+AeUEsvD1D/A3hchZ4yRQ/HvwHHREAk
         cTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710760805; x=1711365605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11SsO5DV2l7dsIFWxNjWwkgefIRCA6N+9rlBR7yanMQ=;
        b=fBtBRwv1CwFExKtO16r8utY8KTZNZreH1D9kOuKMf/Yh9vU9QpK6NdcuDwyln3NXCB
         h8ze9Jnbdqu4/G/6BAo798/HAqdmskgodw3i5iiUC8koH94lkMFf1UfQ0RwFn+FfEm21
         gQjRR6KBs0S4qdguuYRz00N57mT+C2FrRAovMq4DVlCLQzu1QLuLBtWm1VOx5LNDdDWf
         Y6ah8oOMonqDwHi5rBptXtDIHU0HDcvCWVswKYTdbvZmJTcx2cE5eb+Yamo6X/zZy8jc
         HFxpCvIHzcTEzR/b7ZBmokrl4jQwquheaT0yOfjtVgJO6swdXuU7HCkHYB/WCNOQSMsY
         +Shg==
X-Forwarded-Encrypted: i=1; AJvYcCXI+f4l/it+sy17ZZStWJusIQp1C1y99pnamqpw1YfIQfBqve0cIQgc6OJ3NeHob8W8eQEPXP2lctKZ+Fjrxg4OgigyZBdh9t7UBUYAz66ylBx0X6uRGsKZxbAbPVAEyO2dhCJ71FI7
X-Gm-Message-State: AOJu0YyUjt9akZiBFw4LltIVqhgvVfQ6IK4wrxsZOEg0enzXwhxaVnXx
	0judxcpITq4433MVQGwpiZZq3sgav/7Gg2Cw54wA7CX0eyHyHQdL
X-Google-Smtp-Source: AGHT+IF1iA9ClBNXylPILCeU6z/kdkk5Wq6SsBi8DFFYlfdUtVuSO9CFxxDAlvi5/JImnCrciAqbgg==
X-Received: by 2002:a5d:6a04:0:b0:33e:79d3:2cb with SMTP id m4-20020a5d6a04000000b0033e79d302cbmr7448322wru.38.1710760805376;
        Mon, 18 Mar 2024 04:20:05 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id az1-20020adfe181000000b0033ed7181fd1sm6650421wrb.62.2024.03.18.04.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:20:05 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 18 Mar 2024 12:19:58 +0100
Subject: [PATCH 4/5] clk: qcom: apss-ipq-pll: constify match data
 structures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-apss-ipq-pll-cleanup-v1-4-52f795429d5d@gmail.com>
References: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com>
In-Reply-To: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The match data structures are used only by the apss_ipq_pll_probe()
function and are never modified so mark those as constant.

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/clk/qcom/apss-ipq-pll.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index fb015385dae4b..6ee71ed6baed1 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -156,22 +156,22 @@ static const struct apss_pll_data ipq5018_pll_data = {
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


