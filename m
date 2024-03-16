Return-Path: <linux-kernel+bounces-105209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9608687DA8B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A5C2821DD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08E41B968;
	Sat, 16 Mar 2024 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Na64/poC"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12EB168BE;
	Sat, 16 Mar 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710602188; cv=none; b=o8YpO0bz9oAjKdrVpAemr9ARbdbBUdN/RVhvjaAr7+5e9l2HRr+uVt1bkhZd3nKjFEX82Wjo72iC6dH/l+Sb9nwC9tFaC7zZwBaO4++PzURhv3PJGsynqbQEMq00vmiXEeksJQdqbmC90N7MISd2iHt9GEZp/RuY39VUvfr/sKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710602188; c=relaxed/simple;
	bh=YLu6uznwqoYWso1VNOs5aI/+fPnkPIAlDcBCIWg+EzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuKbiEnJx0C648fkyHbsZ/dmk3fkXyBavDx7BBdBDuZ6Uo2go9RB2QdrJ/U5NnNSsvVwCLh1lRFJqh/R6/s2MPLhKir9kQ1iWTkHBCUwjCydSJvU3gHwW3Hx4QniA3OKWoUw0GAQxeS4IYfTEwnzBR50I4algUmrs41HrH0dgEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=Na64/poC; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED03A20002;
	Sat, 16 Mar 2024 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710602182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14PPGHlwquM9FtQB61Tgvee0kwAHbcVyLM/4EWK6FbM=;
	b=Na64/poCupl4AkKi4SN9Jsi/boYqEvF9+dFwGvZocOEI360mcfckS1l/uCZuKD95CP9QHM
	PoGaMdImfpnFIZt0rVHwUNAnhveeIOO1hFjvnMhI1hLYa6jzLvwnXl5JduiZUBfUeInfTo
	GF/Z5K47NAwqmcT/PEgr6QmEBUOsJ2506Oa4xHfpRHe2WuLDaX20pne/ebq4vgNoErrPeC
	PzUDUzsTdZul+BLmRmoiCLfPyTyUaXXXoriOL1IhuqRP8hgJYZS84ZK9iN2nsaRIIvAoX3
	PMjf8qH4rYWuEYy0qPPwRWkPuuCnaheFD3ZaP+da2AFlLMOvduFyDJCOFrsAXA==
Message-ID: <3fe558d9-e231-4015-ab7e-85eac06aa971@arinc9.com>
Date: Sat, 16 Mar 2024 18:16:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] mips: dts: ralink: mt7621: improve DTS style
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <31b3d00f-6cf4-4bf8-ad78-a8354d57c518@arinc9.com>
 <c7eb79ee77542db3a539d8bb7719dba9@risingedge.co.za>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <c7eb79ee77542db3a539d8bb7719dba9@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 16.03.2024 17:03, Justin Swartz wrote:
> On 2024-03-16 11:24, Arınç ÜNAL wrote:
>> On 16.03.2024 07:54, Justin Swartz wrote:
>>> This set of patches was created with the intention of cleaning up
>>> arch/mips/boot/dts/ralink/mt7621.dtsi so that it is aligned with
>>> the Devicetree Sources (DTS) Coding Style [1] [2] guide.
>>>
>>> [1] Documentation/devicetree/bindings/dts-coding-style.rst
>>>
>>> [2] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
>>>
>>> Justin Swartz (14):
>>>    mips: dts: ralink: mt7621: reorder cpu node attributes
>>>    mips: dts: ralink: mt7621: reorder cpuintc node attributes
>>>    mips: dts: ralink: mt7621: reorder mmc regulator attributes
>>>    mips: dts: ralink: mt7621: reorder sysc node attributes
>>>    mips: dts: ralink: mt7621: reorder gpio node attributes
>>>    mips: dts: ralink: mt7621: reorder i2c node attributes
>>>    mips: dts: ralink: mt7621: reorder spi0 node attributes
>>>    mips: dts: ralink: mt7621: move pinctrl and sort its children
>>>    mips: dts: ralink: mt7621: reorder mmc node attributes
>>>    mips: dts: ralink: mt7621: reorder gic node attributes
>>>    mips: dts: ralink: mt7621: reorder ethernet node attributes and kids
>>>    mips: dts: ralink: mt7621: reorder pcie node attributes and children
>>>    mips: dts: ralink: mt7621: reorder pci?_phy attributes
>>>    mips: dts: ralink: mt7621: reorder the attributes of the root node
>>>
>>>   arch/mips/boot/dts/ralink/mt7621.dtsi | 430 ++++++++++++++------------
>>>   1 file changed, 239 insertions(+), 191 deletions(-)
>>
>> A well done patch series. Thank you very much for doing this!
>>
>> Arınç
> 
> ++ for reviewing them all.
> 
> As you have at least one board that features an MT7621 SoC,
> please may you (and anyone else willing) take a look at a
> patch [1] that I've submitted for spi-mt7621.c which allows
> GPIO chip select lines to be used as well as the native chip
> selects.
> 
> There's already been some back and forth with Mark Brown about
> the initial version of the patch (the linked patch is v2) and,
> of course I messed up how I send v2, as you'll read in the thread.
> 
> It seems you weren't included because I rely on [2] to determine
> which people to address as maintainers when sending patches.

I'd prefer not to be involved. It's not my area of expertise.

> 
> Is there a better approach for populating git send's --to argument?

This is how I used to submit patches before I started using b4 [1].

git format-patch HEAD~X --subject-prefix "PATCH (RFC) (tree) (vX)" --cover-letter

/scripts/get_maintainer.pl --norolestats --nol --nor 00* > to.txt
/scripts/get_maintainer.pl --norolestats --nom 00* > cc.txt

git send-email --no-chain-reply-to \
--to-cmd="cat to.txt && cat > /dev/null" \
--cc-cmd="cat cc.txt && cat > /dev/null" \
00*

[1] https://b4.docs.kernel.org/en/latest/index.html

Arınç

