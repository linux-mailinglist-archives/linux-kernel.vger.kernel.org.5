Return-Path: <linux-kernel+bounces-119021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9323B88C2CA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9FB1C352E6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A5F70CC2;
	Tue, 26 Mar 2024 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTr2HCVD"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5F8745F4;
	Tue, 26 Mar 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457875; cv=none; b=C02GBPhJIgJWymakVpY5AAdnv9wsCPJo6rB9ghYq+NswOivPzW+zDXysp7w/eICY4QDu4uTBM7m7KSaeVAaXmC3LAzf0rlvntDqwYCUGRMuYHtnLaQA1VW0LndAEthC22S+uNWjjrrJThFHwRmj2ylbw2jsSssiRqWbjaybdmBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457875; c=relaxed/simple;
	bh=Y0xYcO9bU3WosRx4H9Lrvbw+EdK+hNVOpMluAOikeW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ynq84QTT+We37nMiTQ3hIIriBq6lLrVJ4syu5g8rSBw0kLdRPGd+hCAb6pY2dvUzmJ0eua7GWh/eNQmGM3sh/5yM2hIfcVKDrSxCHI7eGdBX69YyVwyPgYhMazCWxr0TRZUjmRAUQMNS+3HO5lgIsFXkKFEIY7zMQJ3xePP/5LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTr2HCVD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so4624962a12.0;
        Tue, 26 Mar 2024 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711457871; x=1712062671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drVPGfSx+iJ2vgDEnImJCiM3IvlfW1xJHMsQvMhnClE=;
        b=GTr2HCVD+lONEhKEHsVyH+bvau/UOqP4jXFjfAYjz/D9mE8ccFyUXZHHiAHGIxfYX3
         gwSPgIETJpcRrLrbDjBIFCUZ/NGoX+b4KngX/dpPD2IJegLFgLPSfcidtmazanDGzUgg
         dwIlUBW9QRtA+OHQg6wh/wOpqrawQxjv57V05fAcRbl+D5J/VwuHhH/5H7gxnez1jsyR
         VNEtleAWHDxq17C49N1wLr6tn9pAVkLLGtDyLHSPbYhkeO+jJGYdkn8cRUWXwLKZba9A
         8rqIUuXXzMuCba7Krbg6owLyGy2kPEElIgOpI1YZqzs04Ukv2FVYtl1ozsE9L6EXAA5E
         T5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711457871; x=1712062671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drVPGfSx+iJ2vgDEnImJCiM3IvlfW1xJHMsQvMhnClE=;
        b=vJsstDSkMkesIQ851AcHbVrkbhx/uoes5W5iDqyFiHppWkex3/amOYILfw9eGM1E1G
         maGyxIMRyQz9rRsLho6j++GlM4vD/b/J5oTOjS1vn1eWJmVartRXWDuElesF6++0TFsj
         QRwCZevjP2FwdDXD8hZBcQ6e+YBTFvoQiP1ELO1i7Q7H0yuAir2b7t2YMZwDQ7egZGWk
         oHRnRhrRdQK0PJA+ehT0tgGxa1PIMMjbAtuuQe3rZkPWZL9OQEsJz+FeUUDptCli0Hnr
         T0Y5yuqAr2JlHIlIuernuiZcxYsn1i6qToIdkH+lDuD5y3ZoY2288zfvmAlz3olNkmbB
         GYtw==
X-Forwarded-Encrypted: i=1; AJvYcCVeJBaVXFnKX9czIjL/YpXOiaTRa24nfdOQ5DCJgyem8OKDHpRXIhLO8fx3JwtpkRTa//Wz6z1c2afruzsirk3fDevPhx9B9D+cL3CAaVIogwWQRXudBiDN2KLHgUe2wlvi0N2HA87W
X-Gm-Message-State: AOJu0YxW87qfGWsZYDjWLCrFXFZ9dRtH2UqP3SMOjklFMxHmlJ0PfYPt
	5LdeH2OMgD7Bi6FUkIhqGIFe2rU7VFwuTc0Sr9s2owgVIO77/S4rfJCdNssm
X-Google-Smtp-Source: AGHT+IHE7eomNg4oLC6maSEJSUohHvZGV0wLkAgUAYsqLobxvOZkz7xraSk5Y6qpR7UrptNmNEfp2g==
X-Received: by 2002:a50:9e65:0:b0:568:fb58:bc4d with SMTP id z92-20020a509e65000000b00568fb58bc4dmr811049ede.8.1711457870515;
        Tue, 26 Mar 2024 05:57:50 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id n1-20020aa7c781000000b0056bb65f4a1esm4101413eds.94.2024.03.26.05.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 05:57:50 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 26 Mar 2024 13:57:41 +0100
Subject: [PATCH v3 4/5] clk: qcom: apss-ipq-pll: constify clk_init_data
 structures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-apss-ipq-pll-cleanup-v3-4-15c4aeeb14ac@gmail.com>
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

The clk_init_data structures are never modified, so add const
qualifier to the ones where it is missing.

No functional changes.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v3:
 - rebase on top of v6.9-rc1
 - add Reviewed-by tags from Dmitry and Konrad
 - Link to v2: https://lore.kernel.org/r/20240321-apss-ipq-pll-cleanup-v2-5-201f3cf79fd4@gmail.com

Changes in v2:
 - no changes
 - Link to v1: https://lore.kernel.org/r/20240318-apss-ipq-pll-cleanup-v1-5-52f795429d5d@gmail.com
---
 drivers/clk/qcom/apss-ipq-pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index 191b87df51bba..1a6f4db253796 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -15,7 +15,7 @@ static struct clk_alpha_pll ipq_pll_huayra = {
 	.clkr = {
 		.enable_reg = 0x0,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "a53pll",
 			.parent_data = &(const struct clk_parent_data) {
 				.fw_name = "xo",
@@ -55,7 +55,7 @@ static struct clk_alpha_pll ipq_pll_stromer_plus = {
 	.clkr = {
 		.enable_reg = 0x0,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "a53pll",
 			.parent_data = &(const struct clk_parent_data) {
 				.fw_name = "xo",

-- 
2.44.0


