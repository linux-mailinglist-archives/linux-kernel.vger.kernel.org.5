Return-Path: <linux-kernel+bounces-30575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA11F8320DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6861F23F83
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEC931A98;
	Thu, 18 Jan 2024 21:24:29 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2BA31A60;
	Thu, 18 Jan 2024 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705613069; cv=none; b=TYpzHKjeaYRmV3vMDvDDHm9o+MNrSrSQB9jW526TVY0BBPfsWCgJHVHl1PT0DnSI2oMlWPyC0KhNDBD+AFi0/Fio0uQLKvHq4KmMygJffra3SDEhQpF+nbTnRDVnme8IHhJaGM5aR+V0+uIPxluf8zFG01jcGB+K5SRVZom0jZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705613069; c=relaxed/simple;
	bh=kDO5jV6HQThjwTath5dSObs5vTro+4U2S57FtIRoIJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJ/u3QBeJgRGMYWpjR8xAgnRILsx1BBP/0HMBvOqwivG75QJgZRuiL/Y0a3D4BxrgG4291sFhbI5GtPwBtfXh0+5f/rHysJdwa4O3H0mvM8pFVRadTQ02DhNK6rJB1bFf5BavJXj7GEhgukq0fGujtH2y7BCI6j21Fc+mcH8HBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF6FC20003;
	Thu, 18 Jan 2024 21:24:16 +0000 (UTC)
Message-ID: <3fc9e255-2363-4255-80dd-602f886cab27@ghiti.fr>
Date: Thu, 18 Jan 2024 22:24:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jan 18 (arch/riscv/mm/init.c)
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>
References: <20240118143152.3c34b117@canb.auug.org.au>
 <344dca85-5c48-44e1-bc64-4fa7973edd12@infradead.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <344dca85-5c48-44e1-bc64-4fa7973edd12@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Randy,

On 18/01/2024 18:47, Randy Dunlap wrote:
>
> On 1/17/24 19:31, Stephen Rothwell wrote:
>> Hi all,
>>
>> News: the merge window has opened, so please do not add any material
>> intended for v6.9 to your linux-next included branches until asfter
>> v6.8-rc1 has been released.
>>
>> Changes since 20240117:
>>
> on riscv 32-bit:
>
> ../arch/riscv/mm/init.c: In function 'setup_vm':
> ../arch/riscv/mm/init.c:1063:34: error: 'PAGE_OFFSET_L3' undeclared (first use in this function); did you mean 'PAGE_OFFSET'?
>   1063 |         kernel_map.page_offset = PAGE_OFFSET_L3;
>        |                                  ^~~~~~~~~~~~~~
>        |                                  PAGE_OFFSET
> ../arch/riscv/mm/init.c:1063:34: note: each undeclared identifier is reported only once for each function it appears in
>
>
> PAGE_OFFSET_L3 is only defined for CONFIG_64BIT.
>
>
> Full randconfig file is attached (fwiw).


Thanks for the report, I sent a fix here: 
https://lore.kernel.org/linux-riscv/20240118212120.2087803-1-alexghiti@rivosinc.com/T/#u

Alex


>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

