Return-Path: <linux-kernel+bounces-31627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD0783316C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E521F2350E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538BD58ADB;
	Fri, 19 Jan 2024 23:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eWAWNFYl"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198285789B;
	Fri, 19 Jan 2024 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705706551; cv=none; b=KSpEIpvXIVwBjuEW5HJCaaVtyvTU0S6w2/CYSXMXP1cBm3mUXi/QMmooL8UJixuP9zcSBIx+K1PLS+xiC5C1orIxu6uDiqhXNcA0xuR2kKOckTm/xWkiwwZLCRNCAf59f9ObG4u0vsKf3faOUX02ysQBFCEdx4XiROn17GkXdpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705706551; c=relaxed/simple;
	bh=5FsT8mgZflGaTw8AtvFQX7BxaQeZrNKpxYcDl51lLWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTnr3eVY1jCZgHNVJ0+SmZgAH6Rbjq1ePnpbvRwpjxrHI0spUpZvDHIiFqKVP4xAEmyGV5jFAsVEPiAyrOn4VVRx1bExJPoofuJ/fGDElsavJ2OOwLSLtQjsog5Vpsygf+M8YRSjvHJV+MvZ5fewoJQYjBm4bapv/XSZGAnbDAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eWAWNFYl; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705706548;
	bh=5FsT8mgZflGaTw8AtvFQX7BxaQeZrNKpxYcDl51lLWo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eWAWNFYlMthDefVPwaJFw+GmCB9DaGkA+I2dNr8mDFSRzHd8eCZ1UebtpHcfhC1c3
	 xM9UhD7GlORXQ5UcGn2mIiu6YtGswlqgnBEaQmYbhWp/U7+dANqiqn/eoM4a2uhXXx
	 Ui0B8734lUWgtarFWvfDgem/lp94h0tI4UDDsecmEjRhYstUBpSljR8818nBzhlTsp
	 uaOd03JRj+ODh/yg9AQoJLdz6bBYMyhZqeOo0ngRkea8OQs54gYh6Q0HT4j7dWaFYX
	 NFl6InhbX0bhT/lqFa3bkzxw8boMKBWLk5PNnH7XUtKHKWAUBm6xALd8Ly0KMP0qY9
	 MAVYNW3oRZGIw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 01D26378143B;
	Fri, 19 Jan 2024 23:22:26 +0000 (UTC)
Message-ID: <f4ab86cb-158a-48e4-af63-6b13e15a7823@collabora.com>
Date: Sat, 20 Jan 2024 01:22:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] phy: rockchip: Add Samsung HDMI/DP Combo PHY driver
Content-Language: en-US
To: Sebastian Reichel <sebastian.reichel@collabora.com>
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
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <eodlujrytdm6gugcbaz3efnjvgg7sbvsqedwllmleh4ar6e7cr@3ejicokdjzcd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 1/20/24 00:47, Sebastian Reichel wrote:
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

Thanks for the hint!  Will try to make use of this as much as possible.

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

Right, will drop it in v2.

Regards,
Cristian

