Return-Path: <linux-kernel+bounces-122678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCC388FB49
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA181C2D2E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0427D074;
	Thu, 28 Mar 2024 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb8jWQ9c"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21E7C09F;
	Thu, 28 Mar 2024 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617811; cv=none; b=nXNbWFXWApADEAj6ma/PJHP3QJ0xonlvPOcZ4hXdVrLzh7Fcbg1mXDHVVIQWPK+AKn+SzDbNSJzCsnYlEioFMHZw8RUyZfOiopURmeri28bAHt1wYMBLlbQ3NS/nYb54N1o1bWbVX/MOVZXR1Q1U3kXyezitPa2P2A2RwQAFbbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617811; c=relaxed/simple;
	bh=HDaHMWNU7PLs12J9KOzXqxBoiHLJOXbdXjIdIRFe9Ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rgik+PZsulSG5LwE6VQW5yIV1Z1zAo/K4a7xjksyEC63P6jjZm9iZtCy3z0cygCRZxtfNwG80SugfMjIBpJrP+sySaFEs6fwWE2KysUruoqbN8CGg/fnYyy1viMPBSydF96aG4ABd7E+Myhw/80AKkO5kFgUG6U876xI1vcttkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sb8jWQ9c; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56bc8cfc19fso795722a12.1;
        Thu, 28 Mar 2024 02:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711617808; x=1712222608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vauk91PF7ieZRwGJILWu8q5B3JSwVd1dILX9wlslKeA=;
        b=Sb8jWQ9cO0j9vV+X7gv2eCKs5DKeEbZmWCYk8tUQNSIkTdCHrQBsSupAs4VpeaEp7E
         31gTogpY6ot3rbh0HKapBsThybLnS8fmLlx6t1eUdKI3P6XDeN97dcWobg1bTVc73lZh
         sKC3Q0u+bh+Ci51bHn374aqWm7z1HU3T0BnNRfL43zxkvUTNxr4ydw5umCiPx7FCRaqS
         kpZlvxIoHZVLEyP3/xzMnrJCwO2I/P2+a2joiFOsQyDUm5yKy4+pdI0iEFT+wjwV7g2s
         D5IFODpM+P3rJBMMzhCt9k25fLNJwCfmzCTCK8OjVLl9vJD9JCSnZSiyM0xiIRAqtrkH
         v7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711617808; x=1712222608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vauk91PF7ieZRwGJILWu8q5B3JSwVd1dILX9wlslKeA=;
        b=vBKc6lZZlbmszKKes+fUpHboHhfCCwCybJoOvh5CK9GJ9n+ZhYlmZ8VSeqK7uUtoAq
         pltjMVy1OoDJtDCd3hODuIpXonfDPL9nJqE+YNod9gtF1PXtmB9yzhGso5sJfddEiJAO
         mNwskYXJBTPghZ1VcxgREA/jPmIVTm8pdSTba4oCiK/NJ0zlnfNwL4Bz/uZeoPpJFSAP
         If/pIVfXH29tK2njii57Q92OcDZJuYrKxO4YWrxShr6W9EnIiy5j5Ljz6hDzSDKzLYN+
         Sk19JRpdemCqC2SR9GcfVHPjmXLmlkbYVRntZHQ/7FgVUtz8AfPov9z5SR02vggeCCLY
         AMMA==
X-Forwarded-Encrypted: i=1; AJvYcCUm6pkAuxscwyeQ2gXWZ2rOgHLVsrQgNIST8fInHwbWdPo21IFl8wbISWiPBTOEAuBnjsPzDbkVM0TvAOewyYgSuNEGdqHRbO2dVdsRBfvIEzVVf9zNGgDVo2WftPlhSSiSxcgw+buW
X-Gm-Message-State: AOJu0YwK/Y56T0znIZ6WY1BuCipS8OBfTnH7LSyN0qMwJ/1mucbxOjfc
	DVZURpB6/tbwTGY2Zo9Y+aQ0dMAi3uqMO7IMPyalBaWPWHcMGYCV
X-Google-Smtp-Source: AGHT+IEi0VNY1uLHZPQfCTLhDvneL2aousaHHpKmvCW7ONZ9nW8Qwg97ScwGNjR1ysQJFuxdTMR1Ug==
X-Received: by 2002:a50:9f44:0:b0:568:fb58:bc4d with SMTP id b62-20020a509f44000000b00568fb58bc4dmr1539770edf.8.1711617807596;
        Thu, 28 Mar 2024 02:23:27 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id cf2-20020a0564020b8200b0056b0af78d80sm609298edb.34.2024.03.28.02.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:23:27 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 28 Mar 2024 10:23:12 +0100
Subject: [PATCH v4 3/5] clk: qcom: apss-ipq-pll: constify match data
 structures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-apss-ipq-pll-cleanup-v4-3-eddbf617f0c8@gmail.com>
References: <20240328-apss-ipq-pll-cleanup-v4-0-eddbf617f0c8@gmail.com>
In-Reply-To: <20240328-apss-ipq-pll-cleanup-v4-0-eddbf617f0c8@gmail.com>
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
Changes in v4:
 - no changes
 - Link to v3: https://lore.kernel.org/r/20240326-apss-ipq-pll-cleanup-v3-3-15c4aeeb14ac@gmail.com

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
index 8cf17374a2e2..191b87df51bb 100644
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


