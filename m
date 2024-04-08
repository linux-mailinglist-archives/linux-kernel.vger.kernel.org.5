Return-Path: <linux-kernel+bounces-134905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 486BC89B882
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F0C1C21D17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F7725778;
	Mon,  8 Apr 2024 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="SI4j28qf"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B3C219F0;
	Mon,  8 Apr 2024 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561725; cv=none; b=KYCPYQOGBmRv+Ij+WQorR6acHBQ9HQWuKsl9V+0+o1hGllRhN4DKt2BaiJOYe0bubKE8qMg27isAMB1m/92vNzFC4ujxp1fCnv0Fi2NBGyqn86e5PbGFuc++LFlYNq1sW7xuEbRFKgcHjpVZ+01GsEYMUwKvH+9h8CQSPU/tzWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561725; c=relaxed/simple;
	bh=A7/iA+y0FnHKo+ersN3mkh6UOmnGMAUMDHVVbNQFBBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d78ZyJWZ6IMf2JFJytPfKbG+TiNZ8mXsDKPkehP+DcVDkYcpAl6SBH41w90sNWyLYWj7z3WVuiGWusA1Klj5D1CPVoQDOg7s1myrDo3zJLOSu7k9IQvNziOsXEQUHLCSjMPemuMzx8vTDCpS5h9rpWEq+zXybbIBkeUzMNTscB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=SI4j28qf; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8293F20003;
	Mon,  8 Apr 2024 07:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1712561715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TOp49wR0ZnxZnd24arLLCuD8wpBxdjATDAE8QmV+ES4=;
	b=SI4j28qfV9ZiONtSaHOnwCk87oVwiir9ac6G/abNo4NaUkl50ord6H4AMnuvFzhvpOQX8g
	lDswJG2dZCztV2XiICclsxAe0VmPTqcwqGK0yvCEdS2UwuvetMqW3mbNBTu0gpCbafSVLx
	VqeYCnaSAAYJ/AxwQsBfl10X6PI7slsE+AfPMwmWBIx/jWJ0GCzhSadHQPMEbkzis0f1Ik
	AycxZwtm/rJl38O1RokPnQuB4puX2S9r4WZuJ5NAZK29GZyT4mI0cTcP6V/vYQ+mF3mkmK
	m+OvM1JiyJMpYCzs/PRtLG5KKmyxfXEqvKlRONihhDdsZ8HSlYPn+wr24BZm9Q==
Message-ID: <6e8d08e4-5b26-4705-b636-0fc4412a7457@arinc9.com>
Date: Mon, 8 Apr 2024 10:35:07 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] mips: dts: ralink: mt7621: improve DTS style
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
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Thomas, will you apply this patch series as is or should we squash it to
one patch?

Arınç

