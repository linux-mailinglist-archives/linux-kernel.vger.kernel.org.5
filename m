Return-Path: <linux-kernel+bounces-9786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A152D81CB71
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00BA1C21A57
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235EA208C4;
	Fri, 22 Dec 2023 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="ExlnJcmV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp56.i.mail.ru (smtp56.i.mail.ru [95.163.41.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BFE200CC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=Nf9azq1dr1z2dpFM9eMLA/tB6ok0rLUWyMMPYho3Nds=; t=1703255985; x=1703345985; 
	b=ExlnJcmVqWPK2YskFp10s/Fz78k+7eS7EUEBL5angc3bGoJDlzWAq9JAs9GwTgPtjK94Bd184Go
	/6x+3W09KA3UnXE4oaYDOB6ht4rEUeQee29YA9AyeE4p4hv4PrA8H3qGn7t/E/zM8EusHnFrAHsdh
	oixtFK0MjxGU7qYychBeWw4wm6oX4V9yqB/tHfoyqONBgkJ5RPsKvor8EjrQtTnCTyk4fDTu+0NaH
	U6Y3iMOZm6D6ki6QkxPYe4MkGkOvgY2Vhsy83bhyrHrYKyw/7+b+eZEjDGj1YBYZtdqQ/80dlpViS
	EjOZRKeOvQoly7x19+F479jQ8z0Coeq2BEug==;
Received: by smtp56.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1rGggZ-002Msc-0P; Fri, 22 Dec 2023 17:39:35 +0300
Message-ID: <c53c22dd-c482-4808-bdd7-e81c01c04f9e@inbox.ru>
Date: Fri, 22 Dec 2023 17:39:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: set ARCH_DMA_DEFAULT_COHERENT if
 RISCV_DMA_NONCOHERENT is not set
To: Christoph Hellwig <hch@lst.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, mpe@ellerman.id.au, aou@eecs.berkeley.edu,
 palmer@dabbelt.com, paul.walmsley@sifive.com, Conor Dooley <conor@kernel.org>
References: <20231221185152.327231-1-fido_max@inbox.ru>
 <20231221-discount-decade-e306e5878c46@spud>
 <f31d929c-fa0a-4046-be05-38e92afa5d92@flygoat.com>
 <20231222041428.GA2803@lst.de>
Content-Language: en-US
From: Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <20231222041428.GA2803@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp56.i.mail.ru; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9F008C97756F746CAA89CC280A9C73C8312970F1BEE6B7403182A05F5380850405CF697BA74B6A9674E373B0751E947592A9A657C7DC718F9C700AD7340762BFD
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70386A6136E33FD82EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006377E85B0EC44E8FD73EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD8713C30587881FF020BBA20AE9EC107FDF020879F7C8C5043D14489FFFB0AA5F4BF1661749BA6B9773578FCF50C7EAF9C588941B15DA834481FA18204E546F3947CFA486DC37A503D0BF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063741F7343E26298569389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC2EE5AD8F952D28FBE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B08F9A42B2210255C75ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5422B6D5EE5F5B38D9D624E766B6FDA5FEE6E75F450048A99F87CCE6106E1FC07E67D4AC08A07B9B0DB8A315C1FF4794DBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34CAFBC0A7A4BEEE01EF0AC99BFA6B3341E98FB265FC4AF88B1E2C477CFBF0BD0176E9627D99F0F6D91D7E09C32AA3244CEBDF470873A2F30615B62B3E339914E151E887DA02A9F7BFAFF760E3CF2A505DB6C6411D86935C892AB2189BCAD71E73D640157F23F2FFE137E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj2irTGYQEnL0n463ASQOuOg==
X-Mailru-Sender: 689FA8AB762F7393590D8C940224AE3337E863210FDBA5BD78E186746C83CDCF98CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok



On 22.12.2023 07:14, Christoph Hellwig wrote:
> On Thu, Dec 21, 2023 at 10:27:33PM +0000, Jiaxun Yang wrote:
>>
>>
>> 在 2023/12/21 20:29, Conor Dooley 写道:
>>> + Christoph
>>>
>>> I don't think this patch is correct. Regardless of whether we support
>>> cache management operations, DMA is assumed to be coherent unless
>>> peripherals etc are specified to otherwise in DT (or however ACPI deals
>>> with that kind of thing).
>>>
>>> What problem are you trying to solve here?
>>>
>>> On Thu, Dec 21, 2023 at 09:51:52PM +0300, Maxim Kochetkov wrote:
>>>> Not all the RISCV are DMA coherent by default.
>>
>> Sorry for chime in here.
>> IMO if your platform is not coherent by default, just insert
>> "dma-noncoherent"
>> at devicetree root node.
> 
> Exactly.  ARCH_DMA_DEFAULT_COHERENTis a setting that just says for
> a given architecture assumes coherent unless otherwise specified,
> which has historically been the case for mips.  Not setting it means
> non-coherent unless specified, which has historially been the case
> for arm.
> 
> RISC-V starte out without support for non-coherent DMA, and high ups
> in RISCV still told me in 2019 that RISC-V doesn't need cache
> management instructions because no new hardware would ever not be
> dma coherent.  Yeah, right..
> 
> Anyay, Linux for RISC-V has historically been coherent only and then
> coherent default, so this option is wrong, and you need to mark
> you platform as non-coherent by inserting dma-noncoherent somewhere.
> 
Conor, Christoph, Jiaxun, thanks for quick feedback!

The problem is very simple:
For non mips platforms dma_default_coherent is used at 
of_dma_is_coherent() and device_initialize().
of_dma_is_coherent() affects only DT devices. And we can override it 
with "dma-coherent"/"dma-noncoherent". ACPI devices can specify by
"attr == DEV_DMA_COHERENT". But all other devices (platform_device, usb, 
etc..) do not have this feature. These devices will use value from 
device_initialize(). And we have no possibility to change 
dma_default_coherent value by disabling ARCH_DMA_DEFAULT_COHERENT.
Moreover, changing dma_default_coherent from false to true may cause 
regression for other devices. That is why I suggest possibility to 
disable ARCH_DMA_DEFAULT_COHERENT by RISCV_DMA_NONCOHERENT option.
It will works like for PPC:
.....
config PPC
	bool
	default y
	#
	# Please keep this list sorted alphabetically.
	#
	select ARCH_32BIT_OFF_T if PPC32
	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
.....
Doesn't the option RISCV_DMA_NONCOHERENT say the DMA should be 
non-coherent by default?

