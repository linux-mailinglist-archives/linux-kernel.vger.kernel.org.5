Return-Path: <linux-kernel+bounces-63497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E9185306A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944A11C22881
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E8E3E47E;
	Tue, 13 Feb 2024 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="fluFigwo"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927553A1D9;
	Tue, 13 Feb 2024 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826849; cv=none; b=HfroKi/Tov2G9KUdhNrxHdMd8MTfD7Q/RL0ApnWB2051RawsOWjMxJgeu7IKc39PLkQgod4weYIs5/7WRy0YFIIWLN9N4OqyWQm/+LP9T/jkNcYRP57MEjsj5IsdThfvSeCOnL1bXBUK7WTx4w/53HqK/3ydVGXgVuoAq53Vn14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826849; c=relaxed/simple;
	bh=0SO03Mqc4mdPTY44HIHi9I7knFvg8uEIau+3lOWaCUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axoyERBWmVuVBktSCStvMsPN00aCOFOh51pYTuWr0WU/xMJob8g2kL+hMzhbXfcjtiqrD8h68Djk7XU21eiwcD0ABeRLcKNwr5fPMV+MLdwNC4B80ZRxzfE7H2w4pjWF5ohxziRJRKZLO8Y7MBRe72XBZ0oDKGfwBXupgoa4UYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=fluFigwo; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1707826845;
	bh=2Zhv+ZaM8nUKLmAVxxr2UuwvJx0+8zc1nFajMDReAYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fluFigwo/qloHG91XPtCvzbsyxD8oYhOh4lVgz98fMvj+smgjROIqPdhrbeIq4ser
	 Qxg+SXfgyMoG4MKjiXEWnrhK1lbJ9yWH55FlkiPsV7nwERo9O3Vte5Ja+eYpNY1VSD
	 FBQKE/j2otmo/MBOELpY3bXo9kVPd7D7cbcvpn98=
Received: from [10.1.8.111] (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id 2F749A0522;
	Tue, 13 Feb 2024 13:20:45 +0100 (CET)
Message-ID: <db282aa5-2db3-49b9-a7dd-86e94226aa7b@ysoft.com>
Date: Tue, 13 Feb 2024 13:20:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: dts: imx6dl-yapp4: Fix the QCA switch register
 address
To: Andrew Lunn <andrew@lunn.ch>
Cc: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonathan McDowell <noodles@earth.li>
References: <1707751422-31517-1-git-send-email-michal.vokac@ysoft.com>
 <c5dad8e7-c486-4dd9-bfb5-bdfa2ddc18b3@lunn.ch>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <c5dad8e7-c486-4dd9-bfb5-bdfa2ddc18b3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12. 02. 24 17:08, Andrew Lunn wrote:
> On Mon, Feb 12, 2024 at 04:23:41PM +0100, Michal Vokáč wrote:
>> The switch address in the node name is in hex while the address in the reg
>> property is decimal which is wrong. Fix that and write the reg address
>> as a hexadecimal number.
> 
> This feels the wrong way around. The reg value is used by the kernel,
> where as the node name is not. If the reg value was wrong, the switch
> would not be found. If this file was tested, why did somebody not
> notice the switch was missing?
> 
> Do you have the hardware? Can you confirm is really does not work
> without this patch? Was 15b43e497ffd never actually tested?
Yes, I have bunch of these boards all around my desk - we manufacture
them. I am pretty sure I tested all the patches I have ever sent to
the mailing list regarding these boards.

The fact is that the switch actually works regardless of the reg value.
It worked prior to the 15b43e497ffd commit with address 0, it worked
later on with the reg value 10 and it works now with reg value 0x10.

While dealing with the broken reset gpio [1] I just noticed that in
the 15b43e497ffd commit I made a typo and the node name address value
and reg address value differ so I wanted to put that in order.

I barely remember that my motivation for creating the 15b43e497ffd
commit was that I saw similar change on the mailing list or in the git
log for the other boards using the QCA8K switch. So I "fixed" that
on our board as well.

Now when I was looking for some references I found that there is an
other board in mainline with similarly wrong setting:

arch/arm/boot/dts/qcom/qcom-ipq8064-rb3011.dts

                 switch1: switch@14 {
                         compatible = "qca,qca8337";

                         dsa,member = <1 0>;

                         pinctrl-0 = <&sw1_reset_pin>;
                         pinctrl-names = "default";

                         reset-gpios = <&qcom_pinmux 17 GPIO_ACTIVE_LOW>;
                         reg = <0x10>;

I admit that my understanding of the MDIO bus and addressing of
the connected external/internal devices is pretty limited. I have no
answer to why it works like that but as you brought up your questions
I would actually like to know as well.

Thank you!
Michal

+Cc: Jonathan McDowell
[1] https://patchwork.kernel.org/project/netdevbpf/patch/1706266175-3408-1-git-send-email-michal.vokac@ysoft.com/

