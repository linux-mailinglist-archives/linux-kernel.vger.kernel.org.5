Return-Path: <linux-kernel+bounces-106055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C5A87E86A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95BEF1F21952
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EF937711;
	Mon, 18 Mar 2024 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j55I04ma"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C78364BA;
	Mon, 18 Mar 2024 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760806; cv=none; b=nvLwDNY9XTrv63oYwg/noAS+4BETIR6hN5YPLpt3eO0xK50xEaf1EAWj8cmyt8/qnkgSGHeqPbi1Npn2br3qUJqIew1JrK9qo1QxhLCMYg9AFNQV7FxYRxMapmKa/F14JupSca/VuWinL807XlK8phjIrNKJAMEXrBr6uawgO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760806; c=relaxed/simple;
	bh=O6HxZDdhxKhcpMpgS7Eo6/JYG3XMRSAnE9PVhV+ItNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WnwZvJ/kGeOqAdx8zyfHGzA976Q5/p1w+tAa0jaboWVbaxQVkdVqADOam/Y/2dt3mgmEISzPpKLAr5FebtiiVR1UzlSUh8gCLhFey+4K+dkOTzI0mCK9GcXJgpHyLTaj9ECS6eEa5m8P2Wjxf1uzQvdA5OKMKKJQf9YEB0fwFwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j55I04ma; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-413f4cb646dso26382695e9.1;
        Mon, 18 Mar 2024 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710760803; x=1711365603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLFOLb3TX+tmTty9pVbOBLP2wGa5npaJQBpBbAbldYg=;
        b=j55I04maIfz5QyPcyZ+uNNa7LVzXNFhCU9I2mCGZV/38+LxMtOjELixkW+MlwnPSNf
         2z3u5PktSKi/B51JjTgLSRPaxYYx/OnhfPg2PHLdcHgOZF7VyHPXDrqi9Hah0TkwOGH1
         skVEfT/GmhPfRkhsUfnlCUovhU6FFJeVu0KpA8YcJbxFg4f8GjMEUib52h+xHxcFCUdc
         Ypj1Wz1CJXx2MAYdDbbDw9IbeXw1vgJI0bnipch+7IWQnfSYRYKXY+2ksqwxhSGj55WR
         KOCz3SgtcKrEIKivSvfg+ihb2xfWGL+DoeF8pU7N4ZH2a8XQ/nVcc9db3f3NQ6ANsjJx
         vAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710760803; x=1711365603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLFOLb3TX+tmTty9pVbOBLP2wGa5npaJQBpBbAbldYg=;
        b=p6hgYjK+oxY9CjTH+Kqi5OBPoVEQqxVC8sUfbG17s+2vSP6W9CVRzKskQO42GE6/96
         AuYDv2VEdGOT5l5rWjGAro0YRE33eg/HaB8U4LOfkk117oNLpUyWi699kwwc3SPOL+lE
         uybbQdMs/JDWoID/q2NsGFpBJkvMgoplKX2TzzaJHglJR68t+HPC4doTvZtqcinCt0F2
         TYTMNlY66wdH6A13lYrwsRCXo6MX0S5Q8Ip92O7DLuxQcCUxgAFh3lq6aoFyzlSMVJa7
         WLpt4F6f+TE47ncLfXez7p+kfyBaLOpVg/TIGNUxAZ+kEtoJCMvYESJlhCS1Ng6KOiJd
         ZylQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4CngivYw8IplKFzBiXdW2zNgbEQGxzMlTDG8R3jvkoe16ElU0VCuxLaZPDznk4Paelk19eqFbIOdjIiusNFpFB7QfnWDGmBCsFf4Ol9znlm01P9hW1iP1DOpHpu2VrSlJqO/VO6MK
X-Gm-Message-State: AOJu0YxjgdvsA4vbs49s1YhjP6AQKzLejd2OHLhDlMAEv+wVPnc5p0un
	4ojJJo+gcpFugH/2XWaYOdbIZQeKniFpDbU4ZuXaJSZ3tX3ll5AG
X-Google-Smtp-Source: AGHT+IE60u97Ahd+O/QJ907yAAsdejUCQpurbXQ9rWkEcjmkTWP5TE+9NxXK8gl6H4wC2BUvYbKjXQ==
X-Received: by 2002:adf:b184:0:b0:33e:96ba:2d48 with SMTP id q4-20020adfb184000000b0033e96ba2d48mr8533833wra.57.1710760803457;
        Mon, 18 Mar 2024 04:20:03 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id az1-20020adfe181000000b0033ed7181fd1sm6650421wrb.62.2024.03.18.04.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:20:03 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 18 Mar 2024 12:19:56 +0100
Subject: [PATCH 2/5] clk: qcom: apss-ipq-pll: use an 1-D array for Huayra
 pll register offsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-apss-ipq-pll-cleanup-v1-2-52f795429d5d@gmail.com>
References: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com>
In-Reply-To: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The 'ipq_pll_offsets' is defined as a two-dimensional array, but it
contains a sole element only so convert it to an one-dimensional
array. Also, rename the variable to better reflect that it is used
for the Huayra PLLs.

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/clk/qcom/apss-ipq-pll.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index ed3e6405f99cb..f5c7eaf8db374 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -13,22 +13,20 @@
  * are different from the one mentioned in the clk-alpha-pll.c, since the
  * PLL is specific to APSS, so lets the define the same.
  */
-static const u8 ipq_pll_offsets[][PLL_OFF_MAX_REGS] = {
-	[CLK_ALPHA_PLL_TYPE_HUAYRA] =  {
-		[PLL_OFF_L_VAL] = 0x08,
-		[PLL_OFF_ALPHA_VAL] = 0x10,
-		[PLL_OFF_USER_CTL] = 0x18,
-		[PLL_OFF_CONFIG_CTL] = 0x20,
-		[PLL_OFF_CONFIG_CTL_U] = 0x24,
-		[PLL_OFF_STATUS] = 0x28,
-		[PLL_OFF_TEST_CTL] = 0x30,
-		[PLL_OFF_TEST_CTL_U] = 0x34,
-	},
+static const u8 ipq_pll_huayra_regs[PLL_OFF_MAX_REGS] = {
+	[PLL_OFF_L_VAL] = 0x08,
+	[PLL_OFF_ALPHA_VAL] = 0x10,
+	[PLL_OFF_USER_CTL] = 0x18,
+	[PLL_OFF_CONFIG_CTL] = 0x20,
+	[PLL_OFF_CONFIG_CTL_U] = 0x24,
+	[PLL_OFF_STATUS] = 0x28,
+	[PLL_OFF_TEST_CTL] = 0x30,
+	[PLL_OFF_TEST_CTL_U] = 0x34,
 };
 
 static struct clk_alpha_pll ipq_pll_huayra = {
 	.offset = 0x0,
-	.regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_HUAYRA],
+	.regs = ipq_pll_huayra_regs,
 	.flags = SUPPORTS_DYNAMIC_UPDATE,
 	.clkr = {
 		.enable_reg = 0x0,

-- 
2.44.0


