Return-Path: <linux-kernel+bounces-129080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A53896482
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58341284C21
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5474450A6D;
	Wed,  3 Apr 2024 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMpfz+Pa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F1A45941;
	Wed,  3 Apr 2024 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712125631; cv=none; b=I0TPu8OHOdnFf4gnDTr+CjsV+ys2GoI0jWGbpWiIYigGHyMWqdUBKcQ4nCSiWyyXe/vdnByQ+KvIzuYwvKZcD6YBBkMBabzPV2SXa7hhPlNRo7DAbrgo44Rj1Gc2EoOmv9CwRJtwPRWqTheImx/7yN/PK+ybg9lIglBo1iaGiBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712125631; c=relaxed/simple;
	bh=WAGggC/YAADO88TPD8W+g1SxwOBampJG3PNx3bfTBRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uif1tqtWK+acGMFBK2typ7Jvovx8TMmRWRMGNYVKDFcJcfTPRV8ukXa4JeXj4FTJaqXFrSSZuF+/QrjHwOiz18DH4dcjN3FOL3/5gAeWPRq9s+DnLov3g03LhT+iryl+ii0w/Rka7jsGfOZlGASKIztbJBvGZQJt5ZZ0P8a7B/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMpfz+Pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926E4C433C7;
	Wed,  3 Apr 2024 06:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712125631;
	bh=WAGggC/YAADO88TPD8W+g1SxwOBampJG3PNx3bfTBRc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jMpfz+PaMyh+vTpK5hcgRa8CvA805HLL/3vHGwMf3rTtc/hwY0TmpiJreMln5R9nS
	 l8AkUxCJsO071XpXvp2kW5CvMwMULt9TG+zMK6uNILeb53wr+1d7daun2hNqxIiAsS
	 zpzNslfl/rzMfYRBpFJDqAJm8Cy2iMEDo0sC0jDT2niaz5xWT6D+fu9rX0cLx3Hsvb
	 FWwwcZ9HXCvDQh/ppTAltsUh1yPpu7RupJLo4E177ftZ7EOAOxsivL7vebwUTtU/iE
	 YZdkhV52ywoyHljtbIKFaHwOWZrmCdGcdA0DZnmHCpwt5QtvVkzF7KvDUl5YOFcC7q
	 rbHOaueEZMb6g==
Message-ID: <eb7a0d5c-c197-44b9-baea-e9b54792b447@kernel.org>
Date: Wed, 3 Apr 2024 08:27:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: syscon: Add ti,am62p-cpsw-mac-efuse
 compatible
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20240402105708.4114146-1-s-vadapalli@ti.com>
 <2e9b6a91-43d3-4b23-830d-40e607505d8c@kernel.org>
 <30065bdc-ccef-4610-b1c1-7661f801b8e9@ti.com>
 <4b1380a8-0136-4395-ba42-9bcff2e1bdb0@kernel.org>
 <aabea385-16e0-4116-a12b-3ce1e06574e3@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <aabea385-16e0-4116-a12b-3ce1e06574e3@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 07:35, Siddharth Vadapalli wrote:
> On Tue, Apr 02, 2024 at 08:06:27PM +0200, Krzysztof Kozlowski wrote:
>> On 02/04/2024 14:30, Siddharth Vadapalli wrote:
>>> On Tue, Apr 02, 2024 at 02:08:32PM +0200, Krzysztof Kozlowski wrote:
>>>> On 02/04/2024 12:57, Siddharth Vadapalli wrote:
>>>>> The CTRLMMR_MAC_IDx registers within the CTRL_MMR space of TI's AM62p SoC
>>>>> contain the MAC Address programmed in the eFuse. Add compatible for
>>>>> allowing the CPSW driver to obtain a regmap for the CTRLMMR_MAC_IDx
>>>>> registers within the System Controller device-tree node. The default MAC
>>>>> Address for the interface corresponding to the first MAC port will be set
>>>>> to the value programmed in the eFuse.
>>>>>
>>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>>> ---
>>>>>
>>>>> This patch is based on linux-next tagged next-20240402.
>>>>
>>>> Where is the DTS using it?
>>>
>>> The current implementation in the device-tree for older TI K3 SoCs is as
>>> follows:
>>>
>>> 	cpsw_port1: port@1 {
>>> 		reg = <1>;
>>> 		ti,mac-only;
>>> 		label = "port1";
>>> 		phys = <&phy_gmii_sel 1>;
>>> 		mac-address = [00 00 00 00 00 00];
>>> 		ti,syscon-efuse = <&wkup_conf 0x200>;
>>> 	};
>>>
>>> The "ti,syscon-efuse" property passes the reference to the System
>>> Controller node as well as the offset to the CTRLMMR_MAC_IDx registers
>>> within the CTRL_MMR space.
>>
>> Please reference upstream DTS or lore link to patch under review.
> 
> An example of the existing implementation in the device-tree for AM64x
> is:
> https://github.com/torvalds/linux/blob/d4e8c8ad5d14ad51ed8813442d81c43019fd669d/arch/arm64/boot/dts/ti/k3-am64-main.dtsi#L697
> It uses:
> 	ti,syscon-efuse = <&main_conf 0x200>;
> 
> and "main_conf" node is defined at:
> https://github.com/torvalds/linux/blob/d4e8c8ad5d14ad51ed8813442d81c43019fd669d/arch/arm64/boot/dts/ti/k3-am64-main.dtsi#L40

It is quite different than your bindings, so your bindings are incorrect.

Please fix them and send when your DTS is ready.


Best regards,
Krzysztof


