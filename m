Return-Path: <linux-kernel+bounces-10309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D99A881D284
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8A91F230DC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5955664;
	Sat, 23 Dec 2023 05:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="os/Ze/Ns"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E5F46AF;
	Sat, 23 Dec 2023 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=W9Kx4nF3KFPQK2kkiqXk55C73jfsyS/GcCxcI4u85jQ=; b=os/Ze/Ns53J+3516r7Yo/l7+H6
	becg9B4gFaIMBtZ9K9I5E9Atd2NWE6xU0lr5XSCrUcKq61IIw9Gd7b+0TPQa2ug+8+ud+/IpTocVL
	xMudz8BG7wR+gXWbgClOXDIXW0Ke5NipP3HS+3ZF4F5rnRPcAK0C8XezC2GXKaORSHwYz8+dDnffQ
	9ROjv/IE+b44qEtVoIZnFxNNHsDMRP9ayAFfSJ7wYzq6I/hzF8UPKZp8sB5yczlODm8BJnNjL7U9G
	MFevzweyCcI+6WsDR+gWnxGujHNfJV80W8gdmkI8CZ6fqZ5D1sMvEVnsDV1KRJ95HwppoXeEa/dml
	Bp96WCkg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGuco-007Q9m-1F;
	Sat, 23 Dec 2023 05:32:38 +0000
Message-ID: <f9991fef-e50e-4085-ad9c-4da494d2a296@infradead.org>
Date: Fri, 22 Dec 2023 21:32:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: media: atomisp: pci: Fix spelling mistake in
 ia_css_acc_types.h
Content-Language: en-US
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: hdegoede@redhat.com, mchehab@kernel.org, sakari.ailus@linux.intel.com,
 gregkh@linuxfoundation.org, hpa@redhat.com, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20231223051108.74711-1-kdipendra88@gmail.com>
 <d1c18155-9c8e-4164-a2bf-5eab3d42995d@infradead.org>
 <CAEKBCKP+-6=JuRYtHU7YVstfZzzbTdvm9L4PBvOWAgKj2xaOrA@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAEKBCKP+-6=JuRYtHU7YVstfZzzbTdvm9L4PBvOWAgKj2xaOrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/22/23 21:29, Dipendra Khadka wrote:
> Hi Randy,
> 
> On Sat, 23 Dec 2023 at 11:03, Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Hi Dipendra,
>>
>> On 12/22/23 21:11, Dipendra Khadka wrote:
>>> codespell reported spelling mistakes in
>>> ia_css_acc_types.h as below:
>>>
>>> '''
>>> ia_css_acc_types.h:87: cummulative ==> cumulative
>>> ia_css_acc_types.h:411: descibes ==> describes
>>> '''
>>>
>>> This patch fixes these spelling mistakes.
>>>
>>> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
>>
>> This patch is an improvement so it could be merged as is IMO.
>> But...
>>
>>> ---
>>> v2:
>>>  - Previously only corrected spelling  mistake reported by checkpatch.pl.
>>>  - All spelling mistakes reported by codespell are fixed.
>>> v1: https://lore.kernel.org/lkml/20231222200350.2024-1-kdipendra88@gmail.com/
>>>
>>>  drivers/staging/media/atomisp/pci/ia_css_acc_types.h | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
>>> index d6e52b4971d6..1dc2085ecd61 100644
>>> --- a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
>>> +++ b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
>>> @@ -84,7 +84,7 @@ struct ia_css_blob_info {
>>>               memory_offsets;  /** offset wrt hdr in bytes */
>>>       u32 prog_name_offset;  /** offset wrt hdr in bytes */
>>>       u32 size;                       /** Size of blob */
>>> -     u32 padding_size;       /** total cummulative of bytes added due to section alignment */
>>> +     u32 padding_size;       /** total cumulative of bytes added due to section alignment */
>>
>> I apologize for not looking at your v1 patch carefully.
>> The comment above would be much better as
>>
>>                                 /** total accumulation of bytes added due to section alignment */
>>
> 
> So, would you like me to change "cummulative" to accumulation or
> should I wait what other maintainer(s) would say?
> 

I think just wait for a few days to see what other review comments there are.

> 
>> And if the maintainer(s) want to take it as is:
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>
>> Thanks.
>>
>>
>>>       u32 icache_source;      /** Position of icache in blob */
>>>       u32 icache_size;        /** Size of icache section */
>>>       u32 icache_padding;/** bytes added due to icache section alignment */
>>> @@ -408,7 +408,7 @@ struct ia_css_acc_sp {
>>>  };
>>>
>>>  /* Acceleration firmware descriptor.
>>> -  * This descriptor descibes either SP code (stand-alone), or
>>> +  * This descriptor describes either SP code (stand-alone), or
>>>    * ISP code (a separate pipeline stage).
>>>    */
>>>  struct ia_css_acc_fw_hdr {
>>
>> --
>> #Randy
>> https://people.kernel.org/tglx/notes-about-netiquette
>> https://subspace.kernel.org/etiquette.html

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

