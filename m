Return-Path: <linux-kernel+bounces-111694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FA3886FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A563284016
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E071524DF;
	Fri, 22 Mar 2024 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo4tlJR8"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAA54E1DD;
	Fri, 22 Mar 2024 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120998; cv=none; b=KuAAjOmytYJ56F7iDa+Fb7DIpysA00jhsIEDa+H7NpoBjCf4MfeCdd0HoKgE2KfUAYay5qKl2XbP/hXH8mDz59r1DOJawfQ5Vygtk7Jq8TSXN3iF70rcHdMk/CFExh0FlWzXfKUTRk59PBRHXXsSR+GhgNw9tklZIVz9j6LlNoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120998; c=relaxed/simple;
	bh=5I8DfBKY/5rSZznajR6tVgjMaaL+MRTjVPLcxFFHDdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9KFlFkiVmo0UnkhijOLhrM2/zk32Ff7PB8swmZWy6CzZhF7eXaEQv22C7S7EpsSqgbzJy45C8nrxzl7vnEDBOdSpO7+/x95QqYWQabao6Bdg3JNptNW6RkQFDthDqfwlcoQ420nKzGayEfz9c+l7eGHk6Jp7C+32T2BjONXe9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qo4tlJR8; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so1228684a12.1;
        Fri, 22 Mar 2024 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711120996; x=1711725796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KlzJ0fXAmftobkyQfyCcS5gYSWaLbke/Y5QeXT24JdU=;
        b=Qo4tlJR83lzEMMbEYfNCkb+4IrNTU0rXafb8TKtvZU9/bNzjBx7VFKbIYq/wi7BvLK
         nSFBRpusipt5VkOlAwXQFG1rSgf9TKTlUCOtxgFbVty+X7oOiq6LNCwBqi7cnrROHuZe
         ZcjkekvgTDBQr/OYJul60SK9g5dvefc5VvbPTZx0F8Cwgpwtr/ce1+Z06zLNA8CybKnc
         7Eg9InUi0GXZ24o3wIDnY2JX9SFcAgX2x2uXqZ+VwFLE1C/v2LqvPxGReuqcJVNvXN60
         LVp2HH3aRcDgt7v+wwc5cX+/qSTrY9JL7VHDOzwbA2xR0QKP2QEAlIUsE0jW0kpDYsUJ
         jyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120996; x=1711725796;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlzJ0fXAmftobkyQfyCcS5gYSWaLbke/Y5QeXT24JdU=;
        b=VcZoaPQeV3SJcv1/CP4QkCs/exPn+t+jpM3NjLp1N7ILi3s1EPz6L+4UzNYQB3/lyv
         QLdLiRRwHsiu5W4VgpFPlkusUNZ7bjOY4wn1hAidVW32Iy6ckajjj3jjW5K+lGBuaeiU
         O4LSW0lJPy8ZLF9dmwSLIsFFjtkTfEitmo5HXUSxDbvr2R63Pgrj1EflosJhGXRKNsqk
         SeSjidG4BIMV8Jr9fNr1WnIJc1Ajul/vFEMhCG4tF2XIavnHC3pTl1FkDhlTw8sx/lAg
         1cbY+cc5/gKR1IkuOl9EdBvR22TTqXz5TV60Vzwb9Aj81aG0OZM5Hs/PQso+fV6wgi3k
         PSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBXVJo/kK1fOAj34GKF0YhuCGCTE/73yF5TbVbrFgJ5gfGLeou3Tx16Dh71scFAAxAkxh/3sVjBksFzOKO0uev8aLd/FGVN8z+5NOluRBop7MA2oN/d/qZ4+sjhyloaXi1m5kDJNlJQakMHRfRE4Fc6/z970RFf7x7wrjVxwFmfw==
X-Gm-Message-State: AOJu0YwV2CRqk21lO7ntptWKPamHDpkkyIL/qM00UQQRhNxf8CVMQyR1
	u+eiI/SXJjAUFWQ94F0oTamQvCsL1p0CRcBXUNucfu7sI8LMVt7n
X-Google-Smtp-Source: AGHT+IFyGUwmEdjA6VFae40rqF3R0C/pnZshANOsv7qjkGI+uGf6gyMeU7vsP8ZjifikYT6sPdWGGQ==
X-Received: by 2002:a17:902:d551:b0:1e0:2c82:435c with SMTP id z17-20020a170902d55100b001e02c82435cmr10169plf.57.1711120996177;
        Fri, 22 Mar 2024 08:23:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kq3-20020a170903284300b001e01c1124absm2053226plb.171.2024.03.22.08.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 08:23:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <71178af5-b52f-4d60-a438-1cf6b0ecb4d8@roeck-us.net>
Date: Fri, 22 Mar 2024 08:23:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] uio: introduce UIO_MEM_DMA_COHERENT type
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chris Leech <cleech@redhat.com>, Nilesh Javali <njavali@marvell.com>,
 Christoph Hellwig <hch@lst.de>, John Meneghini <jmeneghi@redhat.com>,
 Lee Duncan <lduncan@suse.com>, Mike Christie <michael.christie@oracle.com>,
 Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 GR-QLogic-Storage-Upstream@marvell.com, Simon Horman <horms@kernel.org>
References: <20240201233400.3394996-2-cleech@redhat.com>
 <20240205200137.138302-1-cleech@redhat.com>
 <4f606e50-865c-46f2-b89e-6c1dfe02f527@roeck-us.net>
 <2024032203-dawn-crestless-4199@gregkh>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2024032203-dawn-crestless-4199@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 07:30, Greg Kroah-Hartman wrote:
> On Fri, Mar 22, 2024 at 07:16:19AM -0700, Guenter Roeck wrote:
>> On Mon, Feb 05, 2024 at 12:01:37PM -0800, Chris Leech wrote:
>>> Add a UIO memtype specifically for sharing dma_alloc_coherent
>>> memory with userspace, backed by dma_mmap_coherent.
>>>
>>> This is mainly for the bnx2/bnx2x/bnx2i "cnic" interface, although there
>>> are a few other uio drivers which map dma_alloc_coherent memory and will
>>> be converted to use dma_mmap_coherent as well.
>>>
>>> Signed-off-by: Nilesh Javali <njavali@marvell.com>
>>> Signed-off-by: Chris Leech <cleech@redhat.com>
>>> ---
>>
>> Building i386:allyesconfig ... failed
>> --------------
>> Error log:
>> drivers/uio/uio.c: In function 'uio_mmap_dma_coherent':
>> drivers/uio/uio.c:795:16: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>>    795 |         addr = (void *)mem->addr;
>>        |                ^
> 
> So on 32bit systems phys_addr_t != the same size as (void *)?  How is
> that possible?  We also are doing an explicit cast here, how does this
> not work?

phys_addr_t is not always equivalent to the size of a pointer.
PHYS_ADDR_T_64BIT is a configuration option, after all, and it
is independent of "config 64BIT".

> 
> Ah, do you have CONFIG_X86_PAE enabled?  That would cause that mess,
> ick.
> 
> 
>> cc1: all warnings being treated as errors
>> make[5]: [scripts/Makefile.build:244: drivers/uio/uio.o] Error 1 (ignored)
>> drivers/uio/uio_dmem_genirq.c: In function 'uio_dmem_genirq_open':
>> drivers/uio/uio_dmem_genirq.c:63:39: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>>     63 |                 uiomem->addr = addr ? (phys_addr_t) addr : DMEM_MAP_ERROR;
>>        |                                       ^
>> drivers/uio/uio_dmem_genirq.c: In function 'uio_dmem_genirq_release':
>> drivers/uio/uio_dmem_genirq.c:92:43: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>>     92 |                                           (void *) uiomem->addr,
>>        |                                           ^
>> cc1: all warnings being treated as errorsphys_addr_t
>> make[5]: [scripts/Makefile.build:244: drivers/uio/uio_dmem_genirq.o] Error 1 (ignored)
>> drivers/uio/uio_pruss.c: In function 'pruss_probe':
>> drivers/uio/uio_pruss.c:194:34: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>>    194 |                 p->mem[2].addr = (phys_addr_t) gdev->ddr_vaddr;
>>        |                                  ^
>> cc1: all warnings being treated as errors
>>
>> Caused by this patch and "uio_dmem_genirq: UIO_MEM_DMA_COHERENT conversion" as well
>> as "uio_pruss: UIO_MEM_DMA_COHERENT conversion".
>>
>> I'd suggest to make uio dependent on 64 bit if 32 bit is no longer supported
>> to prevent waste of test builds resources.
> 
> Perhaps disable it if PHYS_ADDR_T_64BIT is not enabled?
> 

i386:allyesconfig sets

CONFIG_X86_HAVE_PAE=y
CONFIG_X86_PAE=y
CONFIG_PHYS_ADDR_T_64BIT=y

so that would not really help. The problem here is that this is a 32-bit build,
meaning pointers are 32 bit, while phys_addr_t is 64 bit. I did not check the
code, but it will simply not work if the pointer is supposed to reflect a
physical address. The new dependency would have to check if sizeof(void *) is
larger or equal to sizeof(phys_addr_t). Even then the code would need a double
cast since it is also possible that sizeof(void *) > sizeof(phys_addr_t).

Guenter


