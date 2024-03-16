Return-Path: <linux-kernel+bounces-105139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4462087D994
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008A428233F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA5114A81;
	Sat, 16 Mar 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="OcckQWQi"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5219E14F70;
	Sat, 16 Mar 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710581095; cv=none; b=UNQphq4GcdZrvIuE3X6pwvG+CI59HQZGYTUU3/luDb/pLZBgiT9i3L4ZYRAHF2EyZTOafS9RxsxoLjjnSTYen9TgVWFbvWhODBxtXizEBnQq9QQ+X3z3qdgq95OCvMjsqHusLD7FmdZWnvhxVueGu/1iUkemA/FIqJnfcqBqh3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710581095; c=relaxed/simple;
	bh=oJn6GpVOHJxfXdm1SivJpAPrc53khPTN9CEI1e2gOrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4hnaqXJFqFGcYzPtRNWN1dR6Uh1vWKgCMPLuu1ON00LygNfIg+kKpbIyVhD6k0zOgo5aoQzs2ec6sboQit5J8a9fSvY9zBPpmI6XfietFyyY/8NIYXM6hFQiCLrsGPhcvwAuBbU/3+kUs8YVqIU6k6wx5TqOfWsSYvwMD8iXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=OcckQWQi; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 139B7240002;
	Sat, 16 Mar 2024 09:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710581091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZH9qUNtgW2Xw18S4ZKnK8rTsmDzcvUUwKZrWvPgRFE=;
	b=OcckQWQi32xy54cfHQz3WLnCSoqaaq9oHgi1nlYUUm+TTAdG/BiGRTFQZqH3l60DmNSiSn
	E1B9O1gMj2IqLvVNhZ/8HAO0Dwi/X/BTKiRTm+7Uxg4w3QxlHvvSEx1cxL/gPHghCLnOnm
	59NU5k/QkiBr5DX6iHyo+E2/mf5vu/chMZbs7RSvDI4S+PMk16U0co+52yYf/i4J2xC6T0
	xJ0tREElf19+E8FHaG4K/HpB8qfTX83KYLk4Hwre1O8T/0kaabiRoZfg3LE3Sbw1I8cSMN
	lsp0Irv1buYH8lxtIvL3n9qxp4uziOAMcySXVENqDgbn4c23tQm06cgKPQDuzw==
Message-ID: <31b3d00f-6cf4-4bf8-ad78-a8354d57c518@arinc9.com>
Date: Sat, 16 Mar 2024 12:24:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] mips: dts: ralink: mt7621: improve DTS style
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 16.03.2024 07:54, Justin Swartz wrote:
> This set of patches was created with the intention of cleaning up
> arch/mips/boot/dts/ralink/mt7621.dtsi so that it is aligned with
> the Devicetree Sources (DTS) Coding Style [1] [2] guide.
> 
> [1] Documentation/devicetree/bindings/dts-coding-style.rst
> 
> [2] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
> 
> Justin Swartz (14):
>    mips: dts: ralink: mt7621: reorder cpu node attributes
>    mips: dts: ralink: mt7621: reorder cpuintc node attributes
>    mips: dts: ralink: mt7621: reorder mmc regulator attributes
>    mips: dts: ralink: mt7621: reorder sysc node attributes
>    mips: dts: ralink: mt7621: reorder gpio node attributes
>    mips: dts: ralink: mt7621: reorder i2c node attributes
>    mips: dts: ralink: mt7621: reorder spi0 node attributes
>    mips: dts: ralink: mt7621: move pinctrl and sort its children
>    mips: dts: ralink: mt7621: reorder mmc node attributes
>    mips: dts: ralink: mt7621: reorder gic node attributes
>    mips: dts: ralink: mt7621: reorder ethernet node attributes and kids
>    mips: dts: ralink: mt7621: reorder pcie node attributes and children
>    mips: dts: ralink: mt7621: reorder pci?_phy attributes
>    mips: dts: ralink: mt7621: reorder the attributes of the root node
> 
>   arch/mips/boot/dts/ralink/mt7621.dtsi | 430 ++++++++++++++------------
>   1 file changed, 239 insertions(+), 191 deletions(-)

A well done patch series. Thank you very much for doing this!

Arınç

