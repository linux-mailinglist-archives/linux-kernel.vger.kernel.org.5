Return-Path: <linux-kernel+bounces-97286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B06876845
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D981C21E56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4E02E41F;
	Fri,  8 Mar 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="ElLEqFNt"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF62C699;
	Fri,  8 Mar 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914809; cv=none; b=EeKYkOtNYWM8YLvQ7J0VhT7N9PdVFASmNTB9DhdyJAFuxAHi7qaDr0+QbTg4nUWAqpWkLrVpEvzVL0F/GZapLZJp3mCFLqGn3DEiyCQRgeli2Z8776Hupe/DTZ1bQllyh8oeriCgOWm6gIEFJdgMw09utQMJnR8FB8Dwhjklphs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914809; c=relaxed/simple;
	bh=iabH5dDPOxmrfINZFoNfeS03SCb1iSJ89tqvyUeiArM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kolKVh0UyYWfMZ0Xl1oeDNwjD768ICKRKdjNfR6QZQIkwGBGtxJ29IHjcr9o4jZwbICQPwo37tJfHAd6EIrregZuLPW0ANoNAdSKd5CIJvdfYtJLEVEHWRQvkh60+Jf/75qK6ba8U4u8zqC+dBfOEiVlQnI2sllz/rk2cWh3Sqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=ElLEqFNt; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0CE39E0002;
	Fri,  8 Mar 2024 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1709914805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Xnmr9MOB5BVmHHO38AExbFHMmYDJ5xhXQdg0uW60yc=;
	b=ElLEqFNtfogo4T3KgmIGrNZ0WebCj57wAEylrFhNXCA5WzYQn91qzrcKwQLTxtgpD8/MKJ
	KkFH8dNoWReyYqihY6uL7r18tr+MURWJqwDDC5zOiv3vLdBpEXdH4N3Zv8Mmpzhm20uZ2Z
	acAGDPvc1NOs/tad60HMQ5hLKKhkqfPzFP7mcTN7P3Xn1TJU74BoZUfJej40ftVI97vPhT
	1fUqKjQRg30llQQdfVKLRvvEFaMvs7VbJ2E7UGo4AddvrdKUtdey9gIRKIncRByQKkpC9k
	A7sfWfiDan69753e1j17Z97yUwrjKEzJ2OT1BkeTbuT2hxsNcmOaWI60dZoh2g==
Message-ID: <f93f19de-1da4-4f8f-92f8-52b4cab0cf85@arinc9.com>
Date: Fri, 8 Mar 2024 19:19:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mips: dts: ralink: mt7621: add cell count properties
 to usb
Content-Language: en-GB
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
References: <20240308161130.12228-1-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240308161130.12228-1-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 08/03/2024 19:11, Justin Swartz wrote:
> Add default #address-cells and #size-cells properties to the
> usb node, which should be suitable for hubs and devices without
> explicitly declared interface nodes, as:
> 
>     "#address-cells":
>       description: should be 1 for hub nodes with device nodes,
>         should be 2 for device nodes with interface nodes.
>       enum: [1, 2]
> 
>     "#size-cells":
>       const: 0
> 
> -- from Documentation/devicetree/bindings/usb/usb-device.yaml
> 
> Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

