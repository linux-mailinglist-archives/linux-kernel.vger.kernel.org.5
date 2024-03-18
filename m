Return-Path: <linux-kernel+bounces-106058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B24287E874
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401151F21BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F01E364BA;
	Mon, 18 Mar 2024 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De65PA0O"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01116381C5;
	Mon, 18 Mar 2024 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760809; cv=none; b=j2xbN9/1zwQkkUd2inKrTYkWSrlMKl85cjfCdF1rG7isrNv6f6IuGK1OU/TUOmo0Euk+zeLlXsjGELvDBjM3ND8c8gbQ3BlgyvvO/IlPKStIHtnVD1VLP+hcqdNuydv0qmWg/i3ndw7i3B/Umi2xAAuoH5dNueXTpyNrEuIOgyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760809; c=relaxed/simple;
	bh=VeSHBpyUKXYt/Yh7tQKPCVQRJ1T9+Llp9DI0p6yKfjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y0Uh+9Rn8TDYc/NGHFiyngczZqQKTCMPmKK2hS+K4SDHVPmpxlecRfkvWD8A3y9/L1Tiyb0/aol1S4qHWSRyh07I9CRXqN8F1xKmXEfSVqNujnxR4plVvhxAmzCXtLyf8hMzcMLx4MELzqoYJXgsG8JEWwbKBNme3b06MNr46S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=De65PA0O; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3416df43cabso609038f8f.3;
        Mon, 18 Mar 2024 04:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710760806; x=1711365606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPuoOY9/Q98dbqm96E10istRwlwF4G6fYLA56NqAfeQ=;
        b=De65PA0O4Po2tbxqrs5PcqG1HaTvAxUKwY/T3t2GdDzw7o+XXgXrL8Bz2QoUo6a1Ib
         Ug6/9UDwxE2EstIp4sGIRE8+JfInpB2Jt+KycdOOVCKdBzeOK8ZRg1CPgupR4769sRO+
         TqXOp4NJ9c7opnkbw7K6yJXYKl8Kv4We0fqsDJdABhNseyMKJbxOJregN5Ib2SGLbCys
         eu4yiCskFyJtE5FyERYGaEhRkA/hKTvVfFZAVJI/PAIixtiC/GdvoKeqfarIek6FQUZ3
         TxmSokl9SyKcmIN/zbf5Wai5AbCIUty81yIySCijHY/SX4VEI8hyQA+ZoXmbGkGyFvEe
         1hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710760806; x=1711365606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPuoOY9/Q98dbqm96E10istRwlwF4G6fYLA56NqAfeQ=;
        b=mUrFyIqWRmqIvMOhGTZPIQ9we+TzqhxbmXI1mVilJGbGkYu6ymOZ+hgz8S1pbL8ogr
         UScamhNaPDbpmazOQbT2LjDIXOcGX+MtqgtorO0NcwN+bUwQd0Fkjvi3GVaWqBnfFCHr
         xT6l0GyKzkiW+jkAazw3u+FrMzcOEJX6tDJPUfZaHtpQ0OhQl9/tQbS4IK9+vrBQoxl8
         VT1v51cVRuLWCNhr/oX4szBEloHN2lKgall4t5TPOf9lyW83ZGd1/lEs8nG6R/5IyND7
         AopUwpuJRJ7I/xCwvLn8owQyud8wLXEHXomAkfUDRgV4YsRSTdHtRWXd8oVFocxF6CCy
         mFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZbHBIRyqzOautmQUmf86VfJcfyrqN2+yAgQdgXSFy6z1xsfNMtkRDy+Yyi6BppRMIzHA5VVHcCsTxrGN4ohy3k28lHmsrmmlu0G+zPqfu6d8SSIaDJklkLKGXrLeB2FxN1vqSLGnb
X-Gm-Message-State: AOJu0Yw9Z/uqEGvWlKvO+Trh10yRTNSS0LNNzEph8wTnrvgY6XAdwGCh
	0AN7N7LxRI/NL4/u+ijMSv7RA23ZGMtPL1xCJtG5KDfkRjCrGIrT
X-Google-Smtp-Source: AGHT+IFqSLqH86uUqVcWskOa3664WxrdQZUIeDK6MH78X1d6f5pdQ6F6vPZNrjt0NUgpe+kOIlGqiw==
X-Received: by 2002:adf:eb11:0:b0:33d:2472:eb8c with SMTP id s17-20020adfeb11000000b0033d2472eb8cmr7350002wrn.19.1710760806267;
        Mon, 18 Mar 2024 04:20:06 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id az1-20020adfe181000000b0033ed7181fd1sm6650421wrb.62.2024.03.18.04.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:20:05 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 18 Mar 2024 12:19:59 +0100
Subject: [PATCH 5/5] clk: qcom: apss-ipq-pll: constify clk_init_data
 structures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-apss-ipq-pll-cleanup-v1-5-52f795429d5d@gmail.com>
References: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com>
In-Reply-To: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
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
 drivers/clk/qcom/apss-ipq-pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index 6ee71ed6baed1..6cf093f7f91eb 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -31,7 +31,7 @@ static struct clk_alpha_pll ipq_pll_huayra = {
 	.clkr = {
 		.enable_reg = 0x0,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data) {
 			.name = "a53pll",
 			.parent_data = &(const struct clk_parent_data) {
 				.fw_name = "xo",
@@ -71,7 +71,7 @@ static struct clk_alpha_pll ipq_pll_stromer_plus = {
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


