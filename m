Return-Path: <linux-kernel+bounces-89271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0FA86EDA0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DF71C21D29
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283B76FB5;
	Sat,  2 Mar 2024 00:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ciwdgtcx"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA415B3
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 00:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709340743; cv=none; b=HQVoC/bgKgdWCP3SkG3KE3A4emfcc3eI/SYZEl7zpeHcDFgmOtIhC0BzKviE7y0TxoIMkU+mPAvBd2Q+TlMzI3kt7kHrzMzPO0kiFsG2brFQmD1gt8PsD1B7eaKteuPwN9uztH+lGANEYK56cdTXshWGolZp+LFU2Dq38zEKj5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709340743; c=relaxed/simple;
	bh=i9zNt6rOlk75HZazBVwuQFbrGUUh1ujpF0qjhh1iKXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IXZAgvtfWJh6KJb9dtLk16A1dW20ch+2lehJs8nRIePmSiOCJ/V9llMUzufZ11uvBMWmvlKhYSDZjXNkoQsp4QG04x0HpnC7OYvxdGHIcQ+FVYXyNEvZEJX95Wm/3b97XYomz8sY+31qYkBxSGIvfpWwvILWoCtJyXyUYtsm5ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ciwdgtcx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412d29057a9so726335e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 16:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709340740; x=1709945540; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/abXWgtHmlIb9XxgX5gbRZA6M3LUdmvdJ04zpHwkRbw=;
        b=Ciwdgtcxa/fSIwfjDv5PEpnA12SP3Ng9piagaR7l7Ovt6t65i3JcZOvJqi/zFXd29D
         b71KOEy3u2LsjJFBCCJRlM8pH7oe6DSv3KW68ycHfPxaIenn2tq3MBfDGeefdR9SFfhx
         tw3QZtzDdma3CBg6Ucj8l3+a/H7jDXEABjR2BUZ2fsc+dNoZmO4+XsgPQNKobxKKh9ld
         4NCIJfHOTrlvqKdTengK9/okDZjvdrSwhALXHhvgiZdYTVYK4ESkbh6VPxa91ufNVi/+
         p1jQg6C9VVudSqxgOxZYa5ZTiTR2uTaeyFdA8/8PzZ47iqyy4G4vRZM1o2msMKo2eRyy
         kboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709340740; x=1709945540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/abXWgtHmlIb9XxgX5gbRZA6M3LUdmvdJ04zpHwkRbw=;
        b=ncF67h+OVuLVYGVE+4+LF+4BltV6h8hrEvC3cu9pdc85QP6ngEFwxCmbCeJeD/xKMZ
         thOaqk2GnA51ktW8a1NoLwttymSUjCS/GL2RM8uGciYV/87cvMW5o150uFul5enuRFNI
         gHvHL144OeclB6wK23pIzgYm1ZSHUz8BdwyL1cKZlZnQl/gM5mhYZh6EP0+Ukoutlkf0
         d4SOsmLwiPRV1iDG7yayfZPwTaO9EaEREd1hO4c7JlmqpLP2KHUp/xlJyhVDlphs7q10
         HpspleRr4YJ2meaT+r3JpSS9U9/0hIQJoi2p0ZGlFGEDp5Bv9yMMiKszSJeamCJbnpm0
         7jBA==
X-Forwarded-Encrypted: i=1; AJvYcCWCVczW6dNCUi56oreu5vqIsZF/QgoarkWiz1pWQm+/tyUmpWSjXfL3YmviC+PBPtFuFExoYAcuft7sDrrM/1qr48E+FN6eVDQxp1br
X-Gm-Message-State: AOJu0YzERZYoN/qLRJvGfyF3SsbqxxjnTBS1uflKb+81BbLo9CaSbCM8
	cuRIyJydlGOfICoHISmk1x1sc9aeMxZvE8qEG0X5KiCH6gkKg3qeFc5G5j1pskM=
X-Google-Smtp-Source: AGHT+IFf6kIIxmFIowOq9kVezM+FJdAj6mvoHaDA7SDas70k/1wBH2ROYjcRSmBpd7FsWaBYTtjDew==
X-Received: by 2002:a05:600c:4448:b0:412:b0d3:49d9 with SMTP id v8-20020a05600c444800b00412b0d349d9mr3246722wmn.9.1709340739907;
        Fri, 01 Mar 2024 16:52:19 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id f15-20020adffccf000000b0033dedd63382sm5865501wrs.101.2024.03.01.16.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 16:52:19 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Sat, 02 Mar 2024 00:52:14 +0000
Subject: [PATCH 1/2] clk: Fix clk_core_get NULL dereference
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-linux-next-24-03-01-simple-clock-fixes-v1-1-25f348a5982b@linaro.org>
References: <20240302-linux-next-24-03-01-simple-clock-fixes-v1-0-25f348a5982b@linaro.org>
In-Reply-To: <20240302-linux-next-24-03-01-simple-clock-fixes-v1-0-25f348a5982b@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14-dev

It is possible for clk_core_get to dereference a NULL in the following
sequence:

clk_core_get()
    of_clk_get_hw_from_clkspec()
        __of_clk_get_hw_from_provider()
            __clk_get_hw()

__clk_get_hw() can return NULL which is dereferenced by clk_core_get() at
hw->core.

Prior to commit dde4eff47c82 ("clk: Look for parents with clkdev based
clk_lookups") the check IS_ERR_OR_NULL() was performed which would have
caught the NULL.

Reading the description of this function it talks about returning NULL but
that cannot be so at the moment.

Update the function to check for hw before dereferencing it and return NULL
if hw is NULL.

Fixes: dde4eff47c82 ("clk: Look for parents with clkdev based clk_lookups")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a3bc7fb90d0f..25371c91a58f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -418,6 +418,9 @@ static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
 
+	if (!hw)
+		return NULL;
+
 	return hw->core;
 }
 

-- 
2.43.0


