Return-Path: <linux-kernel+bounces-109744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9FC885526
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A37A3B21340
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA091657A7;
	Thu, 21 Mar 2024 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItBhTc6S"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660A577A0F;
	Thu, 21 Mar 2024 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711007418; cv=none; b=RzMH81GPTJ9Q+kLQLKmgl1F7vN9IPKrcXsyqEAaCRlLgVCanKmms07kg8xnkk931b1RJ6GEF0Xlz1YJBW7nx3jYEHHoKYGYyJmv9duRBIV8o/G/gIZcI+LM1aeIgx84ucSKpyl8CoOrmGvonx5b8O8/9MbLW0oBIi2pSLGwTEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711007418; c=relaxed/simple;
	bh=TPKfokofPKWzc2OBgMHDrVTdBdePyNL2eD/POdq0oN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXTdcMZOEVm269LnTq8BSGJaJELYWlCjNf/cIDvX01VaJl+pedX+MQBPs2bywcBifjFDtH4sugxjKT+45hJtb7RJUtoSdLzEZLBAD4hSpOavdyG6/fyzDllyiU/bQEzrcJGViaPFb8VZoCmhtFaqCstMTZjzU9Z9UNEoq3n16lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItBhTc6S; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41400a9844aso10034655e9.0;
        Thu, 21 Mar 2024 00:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711007415; x=1711612215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHUxOwmal6qtF9YTqDD1z15OlxUPQ5b62w1T2fIRGXs=;
        b=ItBhTc6SVhQ7/zpdhzQULTZe8edpzIOUTNV1MF4rH4PEYSPxnksGnjHGZT2vM/WKhk
         2Bmg6PFMP2l1TfXvLN4/15CfC7xYuHEmLScdCr4jeqYs/YtF1hmZHH9PB8wdyyhja4mr
         jE/txS325d20tpMvGA8+B3yrRBa9c6H40UVu5DVR8/Fn/uZ1vJZL5FGoMJ6GIrd37gZa
         UozXu/hdQwSiZWkYYXf643cszrEqnI5Z/BJ78d9GVZ0nFvlYnvzbdvyh1VoADn/RCEdp
         Ze9pCmdOS3XuVVBPmBUziVfOU16u6xAcNhyL4J8LNVgeB6I7k+iahzQToMFY1DJSvISd
         t/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711007415; x=1711612215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHUxOwmal6qtF9YTqDD1z15OlxUPQ5b62w1T2fIRGXs=;
        b=KZpfUnJOrR+MW4JSPGJvUzqtis+iVft7zt0qvAsGwVDUS8RFVFqedVvrRe+FKvRc2+
         kTtPEdE8uSjm+sKArtKBSF+SnN6fvWskxYjMzrMkXrIuQaTJJQ0huxn75rozFnzJcEW+
         cxzJpQdXyGdGTZXXEWLNcDL17YVFXn555oROPu8cWKHFk3tqSpawLIxGzRhLBv9whZ5e
         +Wkxu6BPbNW8ItEEZao8E1AwsKzvU9CECSerSMixFmw2aKnua3/iG3FFCKUTKTPW1hqz
         hUp38YTsxt1dxx2UYDX4F2urQ8rcLJifRkb9DSxpGpHHvfjpE4dT9pQ/GgLjgv1+9wWG
         BBuA==
X-Forwarded-Encrypted: i=1; AJvYcCXB6l/bzomoMVC7QAlepVNB8vPfNxLUs14QiyLZGWUoy2X12hdv4fCqYOyV8akKzqyEyFFXx8MSDZy2Y8wNXWnCmUEdea6drSdcAjj3S5f0Vwq9qGtobF/MNJv7Xq83FHgAK7Wo1O4P
X-Gm-Message-State: AOJu0YzqLuYl8RevoUdsw9If7yZPbC3UQqJ889IDxw7l6KkDThIy6y2f
	CB2ZUBC6ZQrVubkAnySXinMMVvTIZyPsx2wH6YroF2XVO8DMn+ua
X-Google-Smtp-Source: AGHT+IEdev7pXxL09ucQ+0YmKSbCtHC9NGgyh/epDqGXGrz8wEjHYTJqI5uMLEibUmeqslpSdyrxWw==
X-Received: by 2002:a5d:5582:0:b0:33e:c0f0:c159 with SMTP id i2-20020a5d5582000000b0033ec0f0c159mr1553484wrv.10.1711007414771;
        Thu, 21 Mar 2024 00:50:14 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id p1-20020a05600c1d8100b004146bda6c32sm4637096wms.9.2024.03.21.00.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 00:50:14 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 21 Mar 2024 08:49:58 +0100
Subject: [PATCH v2 5/6] clk: qcom: apss-ipq-pll: constify clk_init_data
 structures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-apss-ipq-pll-cleanup-v2-5-201f3cf79fd4@gmail.com>
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

The clk_init_data structures are never modified, so add const
qualifier to the ones where it is missing.

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
 - no changes
 - Link to v1: https://lore.kernel.org/r/20240318-apss-ipq-pll-cleanup-v1-5-52f795429d5d@gmail.com
---
 drivers/clk/qcom/apss-ipq-pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index 49da67435d4fe..5bbf329c9bdd1 100644
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


