Return-Path: <linux-kernel+bounces-119843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F3488CD9B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AEB1C614AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453D713D27C;
	Tue, 26 Mar 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Wt6eF98S"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837BA13D255;
	Tue, 26 Mar 2024 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482947; cv=none; b=W8S2WfJXaIIReBhGG0BlNU6i5THOds5sth0zvuP3QC2C6cKlBhEbt082qOkt6z/BRQns0g4MGzdziA4qq59ifrJRVlOUO8IjH48eAJMjXXMBuGzD8ySfguKTZvkKrrE3eQX1wNfDZrd8NEKzPQZUW221GLqxHK4voF9/ODEU1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482947; c=relaxed/simple;
	bh=t7CqjsZ9pZfysEVOI/X9SWqo8ohcJk7OgFJGLNKeMEc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jy0HccwkGrscTZFtvqBO9dpjnUbxugJDKdYVj4DgwN4TSx490xMD8cEKWEwnrBT0up59y4BS5Pp7/AsEfWb4AAc/BkSJ3dgsKDpc3YOxVqweMnI6aNUShZZyMEsSuPwQeS1hOiPfOjvdtsvGgQWLaNRAEqWfC1bLiaV6Nb6F6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Wt6eF98S; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711482942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aK+zeuu0YN/Z0DLh3IdinoCfvuQvS+27+MOgeO9A3HQ=;
	b=Wt6eF98SDxyLQr6Okc4sm2GV6BQH6/hFW+ovHSF7ID+oEYB+hSbXCUwv8qlAudRJWUJDNE
	6GR41G9zyKwulpPei60k3pZQnzVMT3BBtHyVOlG6QuGEZ5ApyGFSmrYREdTdK8wIT2Je1T
	i8u0oNVqFaIO3kSocywO16HTO/Gvc16y04SoyEqSlGA70SbHFTc2HwirwTqwvfBHBacHPk
	kcIjW2tzvbT+b6BlDMELsbPOy1KYJJHt1HVL0+tvLOiMMB0+JV+qGBHgkGidlEjdD7UuIZ
	EQoq34KPbf4Qblp/MsrgH2fejtnuN+/ZRHVa3fsp/cy4MmNfpB+Yr5evKbCtpg==
Date: Tue, 26 Mar 2024 20:55:40 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Conor Dooley <conor@kernel.org>
Cc: dev@folker-schwesinger.de, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Chris Ruehl
 <chris.ruehl@gtsys.com.hk>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Christopher Obbard <chris.obbard@collabora.com>,
 Alban Browaeys <alban.browaeys@gmail.com>, Doug Anderson
 <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Jensen
 Huang <jensenhuang@friendlyarm.com>, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] phy: rockchip: emmc: Enable pulldown for strobe line
In-Reply-To: <20240326-tactical-onlooker-3df8d2352dc2@spud>
References: <20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de>
 <20240326-rk-default-enable-strobe-pulldown-v1-1-f410c71605c0@folker-schwesinger.de>
 <20240326-tactical-onlooker-3df8d2352dc2@spud>
Message-ID: <436f78a981ecba441a0636912ddd1cf2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Conor and Folker,

On 2024-03-26 20:46, Conor Dooley wrote:
> On Tue, Mar 26, 2024 at 07:54:35PM +0100, Folker Schwesinger via B4 
> Relay wrote:
>> From: Folker Schwesinger <dev@folker-schwesinger.de>
>> 
>> Restore the behavior of the Rockchip kernel that undconditionally
>> enables the internal strobe pulldown.
> 
> What do you mean "restore the behaviour of the rockchip kernel"? Did
> mainline behave the same as the rockchip kernel previously? If not,
> using "restore" here is misleading. "Unconditionally" is also 
> incorrect,
> because you have a property that disables it.
> 
>> As the DT property rockchip,enable-strobe-pulldown is obsolete now,
>> replace it with a property to disable the internal pulldown.
>> 
>> This fixes I/O errors observed on various Rock Pi 4 and NanoPi4 series
>> boards with some eMMC modules. Other boards may also be affected.
>> 
>> An example of these errors is as follows:
>> 
>> [  290.060817] mmc1: running CQE recovery
>> [  290.061337] blk_update_request: I/O error, dev mmcblk1, sector 
>> 1411072 op 0x1:(WRITE) flags 0x800 phys_seg 36 prio class 0
>> [  290.061370] EXT4-fs warning (device mmcblk1p1): ext4_end_bio:348: 
>> I/O error 10 writing to inode 29547 starting block 176466)
>> [  290.061484] Buffer I/O error on device mmcblk1p1, logical block 
>> 172288
>> 
>> Fixes: 8b5c2b45b8f0 ("phy: rockchip: set pulldown for strobe line in 
>> dts")
>> Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>
>> ---
>>  drivers/phy/rockchip/phy-rockchip-emmc.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c 
>> b/drivers/phy/rockchip/phy-rockchip-emmc.c
>> index 20023f6eb994..6e637f3e1b19 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-emmc.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
>> @@ -376,14 +376,14 @@ static int rockchip_emmc_phy_probe(struct 
>> platform_device *pdev)
>>  	rk_phy->reg_offset = reg_offset;
>>  	rk_phy->reg_base = grf;
>>  	rk_phy->drive_impedance = PHYCTRL_DR_50OHM;
>> -	rk_phy->enable_strobe_pulldown = PHYCTRL_REN_STRB_DISABLE;
>> +	rk_phy->enable_strobe_pulldown = PHYCTRL_REN_STRB_ENABLE;
>>  	rk_phy->output_tapdelay_select = PHYCTRL_OTAPDLYSEL_DEFAULT;
>> 
>>  	if (!of_property_read_u32(dev->of_node, "drive-impedance-ohm", 
>> &val))
>>  		rk_phy->drive_impedance = convert_drive_impedance_ohm(pdev, val);
>> 
>> -	if (of_property_read_bool(dev->of_node, 
>> "rockchip,enable-strobe-pulldown"))
>> -		rk_phy->enable_strobe_pulldown = PHYCTRL_REN_STRB_ENABLE;
>> +	if (of_property_read_bool(dev->of_node, 
>> "rockchip,disable-strobe-pulldown"))
>> +		rk_phy->enable_strobe_pulldown = PHYCTRL_REN_STRB_DISABLE;
> 
> Unfortunately you cannot do this.
> Previously no property at all meant disabled and a property was 
> required
> to enable it. With this change the absence of a property means that it
> will be enabled.
> An old devicetree is that wanted this to be disabled would have no
> property and will now end up with it enabled. This is an ABI break and 
> is
> clearly not backwards compatible, that's a NAK unless it is 
> demonstrable
> that noone actually wants to disable it at all.

Moreover, as I already explained some time ago, [1] some boards and
devices are unfortunately miswired, and we don't want to enable the
DATA STROBE pull-down on such boards.

[1] 
https://lore.kernel.org/linux-rockchip/ca5b7cad01f645c7c559ab26a8db8085@manjaro.org/#t

> If this patch fixes a problem on a board that you have, I would suggest
> that you add the property to enable it, as the binding tells you to.
> 
> Thanks,
> Conor.
> 
>>  	if (!of_property_read_u32(dev->of_node, 
>> "rockchip,output-tapdelay-select", &val)) {
>>  		if (val <= PHYCTRL_OTAPDLYSEL_MAXVALUE)
>> 
>> --
>> 2.44.0
>> 
>> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

