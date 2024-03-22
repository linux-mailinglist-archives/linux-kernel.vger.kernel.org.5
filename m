Return-Path: <linux-kernel+bounces-111178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B978868C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC001C2200E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E3220DE7;
	Fri, 22 Mar 2024 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="umNMY7hg"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF529199AD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098141; cv=none; b=Ry5F/9+NzlZ1TRLfsQpQI4RjrOJoRtUY3xMKyD+nKShuDXkVmRiF2c7uKjrD4b8AckAwmAr6o4/Oz459AO0qef9ydj2uVZbwiFmfI2MyAg4D9YZRtfA1MDRVblFlyaGBLNTL6fOj8uly7BHTetC7Zbb9DH4ZghB0tn6y/o+TE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098141; c=relaxed/simple;
	bh=5JeoQNR9VZ2cbl3FB3+5GV9iRalRWo99LgPPmVy+/vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL/GxyBfyN96vGPIFJbnOqUQzJU4FDivUKqQax5LfE691KSlJOW888tAsGIuNxGyOZEXaZ0IADSjeHyooTupCz47kCFGAnsGAW+hBPyAxlFZmo8IqUTWlshHK78VzS5RJ/FELwExLj1m+ruwcMiOZdbPNi3B/LUKt1KQ37b8pz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=umNMY7hg; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513e134f73aso2405799e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711098134; x=1711702934; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hUzf5nKXJcZoLD8MvnpqaQA7qM/nqL7Uk1I6CtEEXOg=;
        b=umNMY7hgrMYFIy22wbe09P2bxA5vMPHUMd/AiPPm1ZfwpRNGP1nLOFswsZHy602dW2
         INjkJeln1nWw7/qggkpUX6/2KVyGYv7zltHaC3K3aWsQ3Tv2s45O3EoklrYTu3wWqs1S
         HdiBGNz2vtApGZRdAS8HkvNd/fOr8Pnru0cPsluw8oVNRLoafFtwI2raGOOc0ryKYLae
         RTUAMKj0Zc/3Br/auZQNboHc7arzNxsjPszAyL/RFDINl3dO3TCYdIr2Ppa9keYamyPv
         gtaWlOwucmZFN/i7QMxS/LogGxfSqoeYpngc6crfK4H/ik1U/Uw4t9DHgEGW8rtTwiud
         LLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711098134; x=1711702934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUzf5nKXJcZoLD8MvnpqaQA7qM/nqL7Uk1I6CtEEXOg=;
        b=Uw4q8M0KaMEt6R+QLL3ZJFR7okv8mcdjOXBkDD1GlhCRuabt84b8YqKriADxDIWtvz
         MSccX301HH7BGa8IdmHBuLCvNuT7Tw6iRXcV2vGtkrKRSnHhBdfpvDRSoyMBt54gEM+I
         YaOgSyuQIE5JwXWfQ65dmj7iruwOZQOthndszyszSZDAOGnrw8pbA+vZs6eX+NlzK3bg
         p1HTV1kduxwLXib1C8xdFvTEVNKKeWLIjypipzFCUyOiEwbamY7ceuvyhD445rOFEPlC
         LHwXUOGM2RDLI6TA/2B2Gvv7pRm4kxQDleX1foBkjB0JHDil55HgbAWZMS+WVKR9+q4J
         18pA==
X-Forwarded-Encrypted: i=1; AJvYcCUXf+ajgMrnu7B33VnwDt49SG27upz6K/ZffAI74FWm5K1VYuk39N9sfUya5Z0Milb3HSPz1Bm6lluwggX5EwpFGL8uZLUTbR9FUqfN
X-Gm-Message-State: AOJu0YxQreD1hExNot1hb9VMmd2H12rTY4gmtqRu8vPfo8oo9sy1774F
	ccP0bPUkUkIF0h/vUzJmxUKtCyMlrj5w+ZOas323sZOtWb9LmHu2cnkAme3f5W8=
X-Google-Smtp-Source: AGHT+IHniU7CPbKzwOEhGuzwE8AwGzYsZ0G6mV+KCvG60Tzz4js77hfZDu3VTJ7rMBK/KS1DZSeZdQ==
X-Received: by 2002:a05:6512:44e:b0:515:92f5:e38c with SMTP id y14-20020a056512044e00b0051592f5e38cmr1165531lfk.50.1711098133310;
        Fri, 22 Mar 2024 02:02:13 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id df10-20020a5d5b8a000000b0033e756ed840sm1581249wrb.47.2024.03.22.02.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:02:12 -0700 (PDT)
Date: Fri, 22 Mar 2024 10:02:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: duanqiangwen@net-swift.com
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maciej.fijalkowski@intel.com,
	andrew@lunn.ch, wangxiongfeng2@huawei.com,
	linux-kernel@vger.kernel.org, michal.kubiak@intel.com
Subject: Re: [PATCH net v5] net: txgbe: fix i2c dev name cannot match clkdev
Message-ID: <Zf1JEfIq1E1SHiBD@nanopsycho>
References: <20240322080416.470517-1-duanqiangwen@net-swift.com>
 <Zf09VnR2YI_WOchd@nanopsycho>
 <000001da7c31$be2330f0$3a6992d0$@net-swift.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000001da7c31$be2330f0$3a6992d0$@net-swift.com>

Fri, Mar 22, 2024 at 09:20:04AM CET, duanqiangwen@net-swift.com wrote:
>
>-----Original Message-----
>From: Jiri Pirko <jiri@resnulli.us> 
>Sent: 2024年3月22日 16:12
>To: Duanqiang Wen <duanqiangwen@net-swift.com>
>Cc: netdev@vger.kernel.org; jiawenwu@trustnetic.com;
>mengyuanlou@net-swift.com; davem@davemloft.net; edumazet@google.com;
>kuba@kernel.org; pabeni@redhat.com; maciej.fijalkowski@intel.com;
>andrew@lunn.ch; wangxiongfeng2@huawei.com; linux-kernel@vger.kernel.org;
>michal.kubiak@intel.com
>Subject: Re: [PATCH net v5] net: txgbe: fix i2c dev name cannot match clkdev
>
>Fri, Mar 22, 2024 at 09:04:16AM CET, duanqiangwen@net-swift.com wrote:
>>txgbe clkdev shortened clk_name, so i2c_dev info_name also need to 
>>shorten. Otherwise, i2c_dev cannot initialize clock.
>>
>>Change log:
>>v4-v5: address comments:
>>	Jiri Pirko:
>>	Well, since it is used in txgbe_phy.c, it should be probably
>>	rather defined locally in txgbe_phy.c.
>
>Did you read Florian's comment? Please do.
>
>pw-bot: cr
>--------
>I replied to Florian: 
>" I want to shorten "i2c_desginware" to "i2c_dw" in txgbe driver, so other
>drivers
>which use "i2c_designware" need another patch to use a define. "
>
>Sorry, this email forgot to cc the mailing list.

Could you please use some sane email client that properly prefixes the
original text by ">"?


>
>>v3->v4: address comments:
>>	Jakub Kicinski:
>>	No empty lines between Fixes and Signed-off... please.
>>v2->v3: address comments:
>>	Jiawen Wu:
>>	Please add the define in txgbe_type.h
>>
>>Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID 
>>limits")
>>Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
>>---
>> drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 8 +++++---
>> 1 file changed, 5 insertions(+), 3 deletions(-)
>>
>>diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c 
>>b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>>index 5b5d5e4310d1..2fa511227eac 100644
>>--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>>+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>>@@ -20,6 +20,8 @@
>> #include "txgbe_phy.h"
>> #include "txgbe_hw.h"
>> 
>>+#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"
>>+
>> static int txgbe_swnodes_register(struct txgbe *txgbe)  {
>> 	struct txgbe_nodes *nodes = &txgbe->nodes; @@ -571,8 +573,8 @@
>static 
>>int txgbe_clock_register(struct txgbe *txgbe)
>> 	char clk_name[32];
>> 	struct clk *clk;
>> 
>>-	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
>>-		 pci_dev_id(pdev));
>>+	snprintf(clk_name, sizeof(clk_name), "%s.%d",
>>+		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
>> 
>> 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
>> 	if (IS_ERR(clk))
>>@@ -634,7 +636,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
>> 
>> 	info.parent = &pdev->dev;
>> 	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
>>-	info.name = "i2c_designware";
>>+	info.name = TXGBE_I2C_CLK_DEV_NAME;
>> 	info.id = pci_dev_id(pdev);
>> 
>> 	info.res = &DEFINE_RES_IRQ(pdev->irq);
>>--
>>2.27.0
>>
>>
> 
>

