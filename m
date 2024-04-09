Return-Path: <linux-kernel+bounces-136918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B757089D9D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23A81C21D98
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9491612F397;
	Tue,  9 Apr 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VBEC4XXL"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E472129E7A;
	Tue,  9 Apr 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668103; cv=none; b=rIJtm5wp5PO0lMAEsvc2MeR0r3eRCq/Tz6CR6r/M+WNiFpELNTi1mWJytwmFcl8QBM7NtEmYPu7B9qY0hcSNKigkMiRbgfdQDOmMQPX3yVpV2VKh43R2lwDBT5kCgn0SXYTj99Dw0LQop5wvihP3og0a2gv2wU+jSFRsJHtIMy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668103; c=relaxed/simple;
	bh=USkRKjkNUPqDX1AVEWTkSW/QEjiNTj8l9l2OaMWN0t8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=onOwIzb4ggvCybbAspwfVLPMrcIIWyH+zEEHllk4/IVvTg5UTiy9YndHX6VrdRRBAgRjpfZ9Vs51IRePJsZNJknycI8VoHY40aN1lgP5W7scgHdjY9Rkn6stL2DAa085kgDVuhdnHP0rMXWi8nbNoUzSsN/XQ8+25TBP9UnFi1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VBEC4XXL; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C144FF805;
	Tue,  9 Apr 2024 13:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712668099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9T6euOk4oLnKn7XOOhHOx32RHO0aEaguxxQgz1xRenE=;
	b=VBEC4XXLO+3SmdyGg1bRw00Sp2OP7hy7cflEZJpH9aRSZhvOWaVhNI9sCcJNL7JaVdc/um
	XXna65X+8UEA9BZ4VkMqJu9GGtSKm4pOkqogrWAhbxijF724FoKBRcVj/syhEVn26ayRVx
	o9muJeY5CNuqpR1yW7pL5LJZ4JnEHpFk2a3FYq6fi8yD2Bat0DnEsKdVuqTpffiX+vKFRd
	F9X6jwQuj4fWxwndWrh2adDmsNNL4U9a7ReMAZT3x5v23DRAMT3CAPhUHgS09OGiIN2tuE
	Af2UPIDPP2esXejHoZwNKajbPBvEUSTQQoOfi6HIgKHVNjI68tPSiSvY7tBq6A==
Message-ID: <1514d28a-5e96-4531-a972-894e41902efa@bootlin.com>
Date: Tue, 9 Apr 2024 15:08:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: add initial Milk-V Duo S board device
 tree
To: Inochi Amaoto <inochiama@outlook.com>, Conor Dooley <conor@kernel.org>
References: <20240409064504.4010353-1-michael.opdenacker@bootlin.com>
 <IA1PR20MB49532A8D4294ADCE0C33A654BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240409-prevent-deepness-2d22bf009b16@spud>
 <IA1PR20MB49534E00CAE29D24F7D7E718BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <IA1PR20MB49534E00CAE29D24F7D7E718BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com

Hi Inochi

On 4/9/24 at 14:27, Inochi Amaoto wrote:
> On Tue, Apr 09, 2024 at 01:13:32PM +0100, Conor Dooley wrote:
>> On Tue, Apr 09, 2024 at 03:17:35PM +0800, Inochi Amaoto wrote:
>>> On Tue, Apr 09, 2024 at 08:45:04AM +0200, michael.opdenacker@bootlin.com wrote:
>>>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>>>
>>>> This adds initial support for the Milk-V Duo S board
>>>> (https://milkv.io/duo-s), enabling the serial port and
>>>> read-only SD card support, allowing to boot Linux to the
>>>> command line.
>>>>
>>> Hi Michael,
>>>
>>> I think your patch losts the board binding and have wrong compatiable.
>>> Also, the SD can have rw support with proper property. See link [1]
>>> (need 'disable-wp').
>> [1] doesn't go anywhere useful.
>>
> This is my fault, I copied the wrong url. The right patch is
> https://lore.kernel.org/r/20240217144826.3944-1-jszhang@kernel.org.


No problem, I found out.
I confirm that using the "disable-wp;" property does the trick to make 
the MMC writable.

However, it wasn't mentioned in the above URL...

By the way, do I really need those under &sdhci0?

+ bus-width = <4>; + no-1-8-v; + no-mmc; + no-sdio;

My board looks happy so far without them ;-)
Thanks again for your help
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


