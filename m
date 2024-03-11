Return-Path: <linux-kernel+bounces-99435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF81878845
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B461C21077
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00C858113;
	Mon, 11 Mar 2024 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfTuna3x"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C89A57305;
	Mon, 11 Mar 2024 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182733; cv=none; b=uq9hYkXbkfEwHS0TFki6KxZnsQWOXaSc3h7sv9UCBTfo+zVdUH8Ja2yFO9IuL2utNaag0VygYEWKsFyUCNY4EVQ35SUe1V4Jo7/mjiSV7ag3/afE+0Mp3tyBKjW8FKgyYfURmabAUwJ75TtWj4xj1U/BqZ2evTtXTcyU4BLsG84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182733; c=relaxed/simple;
	bh=9LJtDUa++5L/0htCXqrVzUKNW9ZT/zIfFgMw5goN8zM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=la0/zX5CRJTQktJYiP8APNWiTJjKT9YP8WTxfezHmQU/7OFCTK3WtLY3bq8DOi0o9gprKKUiNvgBQYZN0/VkvkZz65esijkSDrCZE1hyYRQWzfStZ9eGm5QSV6ZmbNRArNp6kll389SbTH9BIkROSZcpqKqxWYp1e19NNHRzbuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfTuna3x; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e8e9a4edaso2416397f8f.2;
        Mon, 11 Mar 2024 11:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710182729; x=1710787529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/wN2D+MaKOxSfb6CYMeYZ7ckjJAc5THjmRM23dZSKc=;
        b=EfTuna3xThlkSqWkHFR+M5M0xldW3xqLXMFljz6R7lMki1ccBlMKkxfdS1gHpPSslu
         iS4FCrAKG/KxOCdObXdwbjscLCyEbKYO2sYVc1Z1tnroe65OB4GPhnhZgsAwQreqQKKg
         w5LVwXuxTkhuT28i5dIHpg8v19spQuNWZ3W4uqB9ZgbbAzS7uFiL9gUl01lZHw5IZLWa
         ocBuv6zLhtdQsQJvcAwwOt8fYrVYaZI7Ts9ztCqcsDY/NYoAJaQnGqcOm2KdHogfzrvb
         la+WtKjbY8cmnbDQkJkbXQWCI0G8KHENqT4SPKjyEuQOSMkPQaczb+CxuCn4biIVe5wS
         T5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710182729; x=1710787529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/wN2D+MaKOxSfb6CYMeYZ7ckjJAc5THjmRM23dZSKc=;
        b=Wm20Mo040tLQSw6siXObnsdDpU2yxP289q9SRfMQMV8Xd0QPGSuwoUWoISIWA7+paR
         8ILddFuDZL8LrMB5mjAg4YR51vmw4aq7PLT7A7f5XsUhZfE8ALTl0ZkWH9h+VCSl6/xA
         5t8DNNkmyKv7o7DEdbBTGRTNFKA0JYb9D6v6WRlzM1EeGyHqHYRrFGls/hyIolxY9JcY
         r4QL2kf3W1PAcZcvbJSEU5jKBQSOPIdto6BHJ6+KuiT8DMga2iADM9wckvU8dusJRYRW
         EgwSyrWXlghXsBebZ5JlPrb6Zo4AJJ3klUBmreX7wC6r9I1JMyxKM79W8RTqkIX/MdiW
         MXqg==
X-Forwarded-Encrypted: i=1; AJvYcCX7KS0dNkLgiAQzmCwyJa2vepofiUtTAnOAyCn+HloZbhsC/z206AdIvIr7MeDwmqtp7m62hRHCzztMg60ef941OTYvWFleA05cek7Vn1va5yRACzB1Ldj9W7mO8vooaABIs8qWKLRC
X-Gm-Message-State: AOJu0YyQCjqISCWMRL7VcnXuxkRS81lut1mnhZ+iY3NBnXaE+QRTIO/h
	l5uxXL0yA4x3EaETbY4MROWktr9NYSVS1bHjCY5suZvcD06C1QJJ
X-Google-Smtp-Source: AGHT+IGAJ96i+gxphR34ruDubqmoZjfTzNYw7TWmSW1NsrEds6c0DHD/QkKNwdacMJaCV7eItZvf+g==
X-Received: by 2002:a5d:4d82:0:b0:33d:1656:21fa with SMTP id b2-20020a5d4d82000000b0033d165621famr927040wru.24.1710182729430;
        Mon, 11 Mar 2024 11:45:29 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id a11-20020adff7cb000000b0033b48190e5esm7012080wrq.67.2024.03.11.11.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:45:29 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 11 Mar 2024 19:45:20 +0100
Subject: [PATCH 2/2] clk: qcom: clk-alpha-pll: reorder Stromer register
 offsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240311-alpha-pll-stromer-cleanup-v1-2-f7c0c5607cca@gmail.com>
References: <20240311-alpha-pll-stromer-cleanup-v1-0-f7c0c5607cca@gmail.com>
In-Reply-To: <20240311-alpha-pll-stromer-cleanup-v1-0-f7c0c5607cca@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan R <quic_srichara@quicinc.com>, 
 Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The register offset arrays are ordered based on the register
offsets for all PLLs but the Stromer. For consistency, reorder
the Stromer specific array as well.

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 58ae732959803..55a77e36dc44c 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -212,9 +212,9 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_USER_CTL] = 0x18,
 		[PLL_OFF_USER_CTL_U] = 0x1c,
 		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_STATUS] = 0x28,
 		[PLL_OFF_TEST_CTL] = 0x30,
 		[PLL_OFF_TEST_CTL_U] = 0x34,
-		[PLL_OFF_STATUS] = 0x28,
 	},
 	[CLK_ALPHA_PLL_TYPE_STROMER_PLUS] =  {
 		[PLL_OFF_L_VAL] = 0x04,

-- 
2.44.0


