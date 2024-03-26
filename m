Return-Path: <linux-kernel+bounces-119020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAB988C2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7AC1C3488D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB2564A9F;
	Tue, 26 Mar 2024 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/XuABZl"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A874402;
	Tue, 26 Mar 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457872; cv=none; b=ervdMqd9ucsAST4X5Lm99uD1rBo4EJVjotAScTGxthsyF/7kcgBoG/R/KVBDIxQRjcUwzUN4azgCVcKCrS5IOUExuYRNXZDDc/MyL9IuOipVxsPLHpGXak3axe21EI3eJSKzjgUrKKCqCl1qvQgmfwDGeDv26But/YEHi4grcik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457872; c=relaxed/simple;
	bh=SxMD3ira2AwJaoCsxuRtqppBEbh8KktY5v1tXzI6y/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xtgraj2ra6Egky+JwY/uT9gCwaWu403SKueT9YpGvd/e78m9nOrTvTebm90niqbCmLpR5mQXJDqwXHkuK9G/L59790qG6Y59HAU32zu9VDpvZ3Czm3gcmqidA8JOT4VPfRbJEJ8++wKXVeaFRDPmQZXQzD8/tERQ6DRyi5mlUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/XuABZl; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56899d9bf52so6930893a12.2;
        Tue, 26 Mar 2024 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711457869; x=1712062669; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/joXcrXgcjd9zUGlJe25ycUJvIRNpniBP/7TKVo7cws=;
        b=K/XuABZlG3Vpa0mSAgp1NOd1e+8uGsff9UAnwcTf4Fk3wlywavbD4bCn501x2cguXA
         70Av3zxkUFdVqnuGO5w5VvJQtidf7fCCvaMDAPrzeCtAdHqblMUTwwvhL7zzGMOoeDIF
         WvaGPRYlDgknVyeBiecE5sZ7jhnW67e8cru1/RZSYXEfCCfZV1YPlVDZ0WMuOk8aNNd/
         ELU1MyxHLtv49BFWPAx9QLZNHc30CLPHZrJ712JxWIkyufDqL6BJls+ya4QpZcpaSP/2
         46iqs6y5nCVrkWDdV6tiqWbZUIuno8H3EP390ZEKXec8HoaiAG/p0iQNbvqpv+Dk78Ot
         tdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711457869; x=1712062669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/joXcrXgcjd9zUGlJe25ycUJvIRNpniBP/7TKVo7cws=;
        b=B3Ygb/xXm4jznSjK4ng6UfX0QerqLf+bbuFUJbd7487BWZtIdtEGys/IquYrLN/wds
         cNcrRKYBub1QqtOukxlk9hEz6b8SZZpixpWkHfSKDrdF4+kF6FSmZ8q6tvKeBYJK7poY
         kz8WSXTC5fYPXqEVAiY/F0I7Hp0ooLsoMhyraUHVj+jqlMuh7IrkcZmtGjk0Z3uil6et
         tnheQFujSmMNrZkKbkEZgZwc46nye3RFt2irFThU1Zhwgakc2HO+WfRtUqCJ6BqA7cG9
         e/05hTckomKw4OjTgBhMt0e3Xa2P9cP2VvB7q6ZKz6DqDwhLfUOdiJCng7KkzUzBFDSi
         VixA==
X-Forwarded-Encrypted: i=1; AJvYcCUNAV7wGfFBdUI/JbAQs7K7nxkGzCZywYo6lcTtuvGxa6PtRIbLu8LDXPQ3BNzlt5l7wW+iK/qeShbBDRvEvq52YQP/74kloWTKaqIKc+goXybGpei/SuK/NOlXolQy9aFsmxT668Om
X-Gm-Message-State: AOJu0Yzey79JR1y5OBOw5S1BvMEDlK9XjXW6z9SA7Cz0cLPXr2w/lkCM
	aMbMVBifB9RqLlKVsq6EgQqYzF4O+cwiloKEOySwr7g6aHlA/DkOKd8xyCDT
X-Google-Smtp-Source: AGHT+IHx6v0ozLpkPTiqwKpYBuomzNcaYKIUo9WD5R/Y8EpeAa0d0Qu0YQDdDEfoS7NAuhpXESC1vw==
X-Received: by 2002:a50:9341:0:b0:566:e3c7:921f with SMTP id n1-20020a509341000000b00566e3c7921fmr8735663eda.22.1711457869306;
        Tue, 26 Mar 2024 05:57:49 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id n1-20020aa7c781000000b0056bb65f4a1esm4101413eds.94.2024.03.26.05.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 05:57:48 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 26 Mar 2024 13:57:40 +0100
Subject: [PATCH v3 3/5] clk: qcom: apss-ipq-pll: constify match data
 structures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-apss-ipq-pll-cleanup-v3-3-15c4aeeb14ac@gmail.com>
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

The match data structures are used only by the apss_ipq_pll_probe()
function and are never modified so mark those as constant.

No functional changes.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v3:
 - rebase on top of v6.9-rc1
 - add Reviewed-by tag from Konrad
 - Link to v2: https://lore.kernel.org/r/20240321-apss-ipq-pll-cleanup-v2-4-201f3cf79fd4@gmail.com

Changes in v2:
 - add Reviewed-by tag from Dmitry
 - Link to v1: https://lore.kernel.org/r/20240318-apss-ipq-pll-cleanup-v1-4-52f795429d5d@gmail.com
---
 drivers/clk/qcom/apss-ipq-pll.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index 8cf17374a2e2a..191b87df51bba 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -142,25 +142,25 @@ static const struct apss_pll_data ipq5018_pll_data = {
 	.pll_config = &ipq5018_pll_config,
 };
 
-static struct apss_pll_data ipq5332_pll_data = {
+static const struct apss_pll_data ipq5332_pll_data = {
 	.pll_type = CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
 	.pll = &ipq_pll_stromer_plus,
 	.pll_config = &ipq5332_pll_config,
 };
 
-static struct apss_pll_data ipq8074_pll_data = {
+static const struct apss_pll_data ipq8074_pll_data = {
 	.pll_type = CLK_ALPHA_PLL_TYPE_HUAYRA,
 	.pll = &ipq_pll_huayra,
 	.pll_config = &ipq8074_pll_config,
 };
 
-static struct apss_pll_data ipq6018_pll_data = {
+static const struct apss_pll_data ipq6018_pll_data = {
 	.pll_type = CLK_ALPHA_PLL_TYPE_HUAYRA,
 	.pll = &ipq_pll_huayra,
 	.pll_config = &ipq6018_pll_config,
 };
 
-static struct apss_pll_data ipq9574_pll_data = {
+static const struct apss_pll_data ipq9574_pll_data = {
 	.pll_type = CLK_ALPHA_PLL_TYPE_HUAYRA,
 	.pll = &ipq_pll_huayra,
 	.pll_config = &ipq9574_pll_config,

-- 
2.44.0


