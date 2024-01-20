Return-Path: <linux-kernel+bounces-31838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4C4833557
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A3D28410F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 16:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F090F1094E;
	Sat, 20 Jan 2024 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BijnTFU7"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33E5101F2;
	Sat, 20 Jan 2024 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705766444; cv=none; b=lReFp0qMxn0yKPjc9bUzjNn+2gWgb4IuzouymI5NE22J+sdKZHYCGrBa6kUaYwbOAzOQE3t0TjyxPGA4IqZ2GqeH91ZG+vLaqX8qQf+5/VFg1z7ZSH7EyxJ7GFK4lRAcCGMXpH1G+03UNssesAAZzq7GQ+VNoQr+p2HNM8IvvWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705766444; c=relaxed/simple;
	bh=LjUL/KvSMjBbQYSgDt/NxUG0hDJAe0TjiuGGZaoHnms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BF6hTf3puWTcColPd4DPPLtqkQo+ciOjOTAb9Y6UR83qh+/C88ub6Tag24qrjEI7IWYurUHD3CY+kYWFHaFRpiuQ5B1sY+ibreoQEeqdeR8yih2GvGYWMKlf95U9KKOjsQMYwyzLpYOOf9VmPL0jTyMeICzfEEbHAPVaRDnZsts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BijnTFU7; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bbec1d1c9dso85604739f.1;
        Sat, 20 Jan 2024 08:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705766441; x=1706371241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDMba898QCD1xJMzInkaVLstqNui1SJewd5Xj+Qlc5o=;
        b=BijnTFU7oGZ8qeK2GWXwaZLudewTM81dDL/ibkhQu6teAobsy9AvXO0s1MI66Nu1qP
         qlzupJ19pv80cqIrONWcEXVsz+rCLKNMRJhdlvookY9qBSN0+3LlPw/xYwtp0XUFj+19
         VketJKQAN3mr3AsZG5Jkxt84t1Q/jb7/oFUogfK55w5xNyP1EJcKl+Svk5rMihlhYx3n
         M9DJFeiEgd1IJnGb75YgZU92WWI3NOU/bYDWOpyVmCmp0kSDOnW+AvXcoT0VZ0ogOgvb
         G0aJvO1MHKUTuru8ZsloNnu8HUTlEpwzPy1o+oOtmrdW1z87O1nWMxXtYtdus1zm+/gj
         9iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705766441; x=1706371241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDMba898QCD1xJMzInkaVLstqNui1SJewd5Xj+Qlc5o=;
        b=ungMpCuxXPYGy9SSTx+e9QqNT8nQXxCMSueRe+IQ+ERYmFHbhSqVS0Gp+TrPsfQvcp
         OI7vAEHFmJQ86xzmzbA12Fxcl60V2oFDmnJkxuI2A6hSIk6wL4Hn5eYz8JmdqoiKIQGD
         00Fzd77LRqe4Jnewr3j/cVoM5I05SLGMYAE5wJkzAq+vi09ueVurk4bbS//+POGzPZkW
         bDqyNeE92DyFCjNyktuxSALPu1F2EdjL8Exj+8Vl4VfO0X7qOh09vDLPRM0a0wxXx16m
         FK3uEO5lpnHB8ajjpg4A9RJ1UA50ESyz6K1Z+Gsh4G6+O9PkzhZ9csBfvIOObC1tO/HX
         At+A==
X-Gm-Message-State: AOJu0Yy6yIltuRxPgT9+YMroqti3ZMn9hhv73LK4CdRcWP5wQJ7MEWrZ
	JfSNvfNZm2KZhYQxZOvLNaVA9SMM/cew5p4fAO+1zMQsYDrwHeo=
X-Google-Smtp-Source: AGHT+IFE4TuOrJtzgHLyBaksg6zWj1nGUuiBUsShGIJO51OPBEs5aW70fx/DlpadBlXHiBtEPvLJgg==
X-Received: by 2002:a6b:ec12:0:b0:7bf:397a:dbe1 with SMTP id c18-20020a6bec12000000b007bf397adbe1mr2287663ioh.4.1705766440970;
        Sat, 20 Jan 2024 08:00:40 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4600:279c:2034:6e39:5ea1? ([2a02:810b:f40:4600:279c:2034:6e39:5ea1])
        by smtp.gmail.com with ESMTPSA id j20-20020a02cc74000000b0046cd8bac20dsm2136149jaq.12.2024.01.20.08.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 08:00:40 -0800 (PST)
Message-ID: <e3713300-492c-43eb-aaf9-0add95ef3b19@gmail.com>
Date: Sat, 20 Jan 2024 17:00:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] phy: rockchip: Add Samsung HDMI/DP Combo PHY driver
Content-Language: en-US, de-DE
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, Johan Jonker <jbx6244@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Andy Yan <andy.yan@rock-chips.com>,
 Algea Cao <algea.cao@rock-chips.com>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
 <20240119193806.1030214-4-cristian.ciocaltea@collabora.com>
 <eodlujrytdm6gugcbaz3efnjvgg7sbvsqedwllmleh4ar6e7cr@3ejicokdjzcd>
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <eodlujrytdm6gugcbaz3efnjvgg7sbvsqedwllmleh4ar6e7cr@3ejicokdjzcd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 19.01.24 um 23:47 schrieb Sebastian Reichel:
> Hi Cristian,
> 
> On Fri, Jan 19, 2024 at 09:38:03PM +0200, Cristian Ciocaltea wrote:
>> Add driver for the Rockchip HDMI/eDP TX Combo PHY found on RK3588 SoC.
>>
>> The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
>> and eDP links.  The maximum data rate is 12Gbps (HDMI 2.1 FRL), while
>> the minimum is 250Mbps (HDMI 2.1 TMDS).
>>
>> Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
>> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
> 
> The driver has multiple sequences looking like this (this is just one
> example of many):
> 
>> +	hdptx_write(hdptx, CMN_REG0087, 0x04);
>> +	hdptx_write(hdptx, CMN_REG0089, 0x00);
>> +	hdptx_write(hdptx, CMN_REG008A, 0x55);
>> +	hdptx_write(hdptx, CMN_REG008B, 0x25);
>> +	hdptx_write(hdptx, CMN_REG008C, 0x2c);
>> +	hdptx_write(hdptx, CMN_REG008D, 0x22);
>> +	hdptx_write(hdptx, CMN_REG008E, 0x14);
>> +	hdptx_write(hdptx, CMN_REG008F, 0x20);
>> +	hdptx_write(hdptx, CMN_REG0090, 0x00);
>> +	hdptx_write(hdptx, CMN_REG0091, 0x00);
>> +	hdptx_write(hdptx, CMN_REG0092, 0x00);
>> +	hdptx_write(hdptx, CMN_REG0093, 0x00);
>> +	hdptx_write(hdptx, CMN_REG0095, 0x00);
>> +	hdptx_write(hdptx, CMN_REG0097, 0x02);
>> +	hdptx_write(hdptx, CMN_REG0099, 0x04);
>> +	hdptx_write(hdptx, CMN_REG009A, 0x11);
>> +	hdptx_write(hdptx, CMN_REG009B, 0x00);
> 
> Instead of the repetitive calls to regmap_write, it's better to do
> it like this:
> 
> static const struct reg_sequence some_init_seq[] = {
> 	REG_SEQ0(CMN_REG0087, 0x04),
> 	REG_SEQ0(CMN_REG0089, 0x00),
> 	REG_SEQ0(CMN_REG008A, 0x55),
> 	REG_SEQ0(CMN_REG008B, 0x25),
> 	REG_SEQ0(CMN_REG008C, 0x2c),
> 	REG_SEQ0(CMN_REG008D, 0x22),
> 	REG_SEQ0(CMN_REG008E, 0x14),
> 	REG_SEQ0(CMN_REG008F, 0x20),
> 	REG_SEQ0(CMN_REG0090, 0x00),
> 	REG_SEQ0(CMN_REG0091, 0x00),
> 	REG_SEQ0(CMN_REG0092, 0x00),
> 	REG_SEQ0(CMN_REG0093, 0x00),
> 	REG_SEQ0(CMN_REG0095, 0x00),
> 	REG_SEQ0(CMN_REG0097, 0x02),
> 	REG_SEQ0(CMN_REG0099, 0x04),
> 	REG_SEQ0(CMN_REG009A, 0x11),
> 	REG_SEQ0(CMN_REG009B, 0x00),
> };
> 
> regmap_multi_reg_write(hdptx->regmap, some_init_seq, ARRAY_SIZE(some_init_seq));
+1 on that.

It' quite hard currently to figure out what the driver is _actually_ doing
as it has all this hardcoded sequences mixed up with driver logic. Better
move them at the top as arrays and use regmap_multi_reg_write as Sebastian
suggests.

Alex
> 
>> +static const struct of_device_id rockchip_hdptx_phy_of_match[] = {
>> +	{ .compatible = "rockchip,rk3588-hdptx-phy", },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, rockchip_hdptx_phy_of_match);
>> +
>> +static struct platform_driver rockchip_hdptx_phy_driver = {
>> +	.probe  = rockchip_hdptx_phy_probe,
>> +	.driver = {
>> +		.name = "rockchip-hdptx-phy",
>> +		.pm = &rockchip_hdptx_phy_pm_ops,
>> +		.of_match_table = of_match_ptr(rockchip_hdptx_phy_of_match),
> 
> Remove of_match_ptr(). It's a nop, since the driver depends on OF.
> 
> Greetings,
> 
> -- Sebastian
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


