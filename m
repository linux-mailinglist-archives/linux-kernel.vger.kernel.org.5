Return-Path: <linux-kernel+bounces-80228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA877862C51
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBDF1C20C25
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B61E1BC3C;
	Sun, 25 Feb 2024 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz9RBH2y"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBB01B81D;
	Sun, 25 Feb 2024 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708882402; cv=none; b=VGEboWjzsJwU7M2MR5EfaOk3s/9ciYElMwQCqspDiQsNkTgjSScFBmTkoz4sj+lmt2DHjrR8U1KJvnYrMVS36edI2tqCmJQej5WtNI+86hOQI3qDJPyeQCNi723JhRmG8c18aW3MlhFzanwErTJZfgI1gZsmMXL+kVYPs486hsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708882402; c=relaxed/simple;
	bh=INmmxuDp3cZ7nvFnkIiCImfSB4wWRoqAPhib6ZOQFDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mV/57h68H+/6ARdaTolcpymaHHdo/1qi0sffQ9tnHanZ/5VP96w9VJnsyYTdCjAfJZwu5rB2nyfYyHRt7BpIBgFLUouL9Z71My8H7A6uSSr1OD4Y+iZr3hhdr9h7mKAhnVMTHOvW+tGMN5Y6CSilOMF8Ad/NYRxhPrriTJiOZH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mz9RBH2y; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563f675be29so2240692a12.0;
        Sun, 25 Feb 2024 09:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708882399; x=1709487199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTMU7fFyDVEAl7ngOGbrGMHQBoOhZMAo5bweFW6SN0g=;
        b=Mz9RBH2yax8ghyg+Gbb7AM4WSsunRkqQrYFpYmcysSljlbHvnzBZs9hA3NNtyqZfZi
         qryhwsPV96geoXS7FRFYm4Iu8ZyM2G2rfSrw5Cea/ORCoFMNOlzdcuxGZFUqH+kAnZMp
         9yYgKgLmfBQeM/LCPJ5jWXoEX7occTpmjpw5pJJsTV6XMA3d6Y/KDOAQbBmA2YM0/E0y
         WEMxih8E2lpjvNZdQtORuloKFNNjhOm9P0xDOhTBiu2CpjFVbk0cLgSxEy8HpSsRMhSd
         NJJzoK4Mv/a+5/F0bd/LYmNVxx2Otqdb2r4HMrsjzooP6OGetz4Yxm67r1cnNCXLrlCc
         e+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708882399; x=1709487199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTMU7fFyDVEAl7ngOGbrGMHQBoOhZMAo5bweFW6SN0g=;
        b=juUN9VryHntA33uG1XIwd7y8YO1OH7eFkZxJeR2PA8BQ+dqOEff7sgLFydTrHJ2y2Z
         n5jZhlgCNpGw1SwlhtzaGY/YCQJ+j0pW9ajfSgzvQXDK4CVqE5UMF805mMHKeb3vuECf
         bPUgW1N+Bo+svdCCheMa0qmVfac/YCxcDZlmHWjD6gtYkJRmpOpCzeV2JqoNY/QcR6/4
         laNQBZ9kzhQKDHifqXaVqP6aaUk3D3CV2BZdMIfWez8TFfYQ5NTFjEo6Oc0g44G3/T77
         DmT7AMfwquKbgzdfNLuQYb0sSunChtwUfWyC6b3O1rnhx42XLDCjFZKTmq69lrElR53Z
         harA==
X-Forwarded-Encrypted: i=1; AJvYcCW2wQtjVuYNSyxvVLtPO/AXpp/PntHqHGLLXeBHJQCg56r34KmXlhm3cqMR7NpPJ0zXF7bd0iZ60xjGXKJGzvpCYk2Tpzg7OTsVmKuvncqRCOYGz4U/zAQ9ktiZ1uigcpYSaFUPsQ7S
X-Gm-Message-State: AOJu0YyT0uQw1N71G9sFsJ/qHzz6KrYxgvlvgVDWBadvXSAn+HEUMwjK
	GHcSfi1M0oHYIB88Gidrzjy+Ac5ELlxXkJrh4BWXy4gfB6xzTzNu93THlHFOM88=
X-Google-Smtp-Source: AGHT+IGn12BKwQjq/ATn5nMB6OP8QGv/a73XT8HyNqL84j2OZ8Qo6zibPGlR26E0RiE6ilwquduFjQ==
X-Received: by 2002:a17:906:6701:b0:a3f:6717:37ae with SMTP id a1-20020a170906670100b00a3f671737aemr3422585ejp.69.1708882399029;
        Sun, 25 Feb 2024 09:33:19 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id cw16-20020a170907161000b00a4306ac853fsm1182007ejd.206.2024.02.25.09.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 09:33:18 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Sun, 25 Feb 2024 18:32:56 +0100
Subject: [PATCH 3/3] clk: qcom: gcc-ipq5018: fix register offset for
 GCC_UBI0_AXI_ARES reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-gcc-ipq5018-register-fixes-v1-3-3c191404d9f0@gmail.com>
References: <20240225-gcc-ipq5018-register-fixes-v1-0-3c191404d9f0@gmail.com>
In-Reply-To: <20240225-gcc-ipq5018-register-fixes-v1-0-3c191404d9f0@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The current register offset used for the GCC_UBI0_AXI_ARES reset
seems wrong. Or at least, the downstream driver uses [1] the same
offset which is used for other the GCC_UBI0_*_ARES resets.

Change the code to use the same offset used in the downstream
driver and also specify the reset bit explicitly to use the
same format as the followup entries.

1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r4/drivers/clk/qcom/gcc-ipq5018.c?ref_type=heads#L3773

Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/clk/qcom/gcc-ipq5018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
index 5e81cfa77293a..e2bd54826a4ce 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -3632,7 +3632,7 @@ static const struct qcom_reset_map gcc_ipq5018_resets[] = {
 	[GCC_SYSTEM_NOC_BCR] = { 0x26000, 0 },
 	[GCC_TCSR_BCR] = { 0x28000, 0 },
 	[GCC_TLMM_BCR] = { 0x34000, 0 },
-	[GCC_UBI0_AXI_ARES] = { 0x680},
+	[GCC_UBI0_AXI_ARES] = { 0x68010, 0 },
 	[GCC_UBI0_AHB_ARES] = { 0x68010, 1 },
 	[GCC_UBI0_NC_AXI_ARES] = { 0x68010, 2 },
 	[GCC_UBI0_DBG_ARES] = { 0x68010, 3 },

-- 
2.43.2


