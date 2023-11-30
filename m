Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E977FFBFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376613AbjK3UIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376564AbjK3UIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:08:20 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB42B10EF;
        Thu, 30 Nov 2023 12:08:26 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a132acb67b5so196172866b.3;
        Thu, 30 Nov 2023 12:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701374905; x=1701979705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NVmjRzgAua03WdwORo421gdt6nsBZn8xmvtY8qjfbPE=;
        b=iVttznzW1Prfw6ucp3Q7llLSqT/ej6K9hjWjlirssye33l2Ye37zrLaTqdcHFYi4Fh
         hEUTOaYN480Uk5ffsAnaailPrCQhJObg+iro77ebpkgEjmB3Jr7keYfH7pfKbZQ+sWt9
         XHZ+4pCCqV+h6aRpSHp2VZvBT2V23soAl48g+bcphlVYiNGxY/1jnJZ4dJsjFnyF7M5/
         Qdre+nLmhZGwL0g6Q7JbMui1+nUKzqaOHwYgBHF6BZM0qv4B0XwlanM8sn98b0P1N6e9
         tYNm2EMM2W8iDXAyxZP/9KY3DWGR+vn4Ucn5kqE7dQZSlTNaAWUbmNsZvS+05jedBCRH
         HCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701374905; x=1701979705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVmjRzgAua03WdwORo421gdt6nsBZn8xmvtY8qjfbPE=;
        b=WzqHdHZSNFyXpycqFEuNfQNGSJ5jvnq78VHofxPa64P1XfqiQ3NA5P/cxhKVAbIxfj
         vyYRJsJNgPvVvLSbNCnYTeTfm/d+5jPD7qSWAs9zf5NNxgcvyzJvREpsemLle+H3DyAK
         9zlAhjxv7hO/t/YyEPFJ2/VAEX4y/TpHBnSGVGGOcTPt5jjpql5h6fsI07ZOGnpH4SX1
         Y+Cmi9YtjhJ6iah+8Gf+OWIBSAExEIwO9XvfRdmcFAz/XzjA36gSM1B+ai+OMFVHBmAA
         j8RuRAiD57Bsy2nb6mhvbBE8PpISEp8u+EooNxjlLSCCzPxaaw4X0Rx6dmuxGna5lbUd
         a5vA==
X-Gm-Message-State: AOJu0YxvF90SxbfptEPfPHl6/JvvyPBoSvCNTizlk1vPof6bF4bW6V0I
        yKc5deNHmELfDmwz42kIF98=
X-Google-Smtp-Source: AGHT+IGDj/cYED/zn7ZI/6ywZMAiLSEGIkHHYOLRjRCrTSCtxJdUs79XKkQbwFcSDTOef56n9FK6XQ==
X-Received: by 2002:a17:906:c306:b0:a19:34c1:de22 with SMTP id s6-20020a170906c30600b00a1934c1de22mr55366ejz.76.1701374904976;
        Thu, 30 Nov 2023 12:08:24 -0800 (PST)
Received: from ?IPV6:2a02:a466:68ed:1:d1c5:6360:2926:652a? (2a02-a466-68ed-1-d1c5-6360-2926-652a.fixed6.kpn.net. [2a02:a466:68ed:1:d1c5:6360:2926:652a])
        by smtp.gmail.com with ESMTPSA id ay5-20020a170906d28500b009fc3f347109sm1036124ejb.156.2023.11.30.12.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 12:08:24 -0800 (PST)
Message-ID: <76e8def2-ff45-47d3-91ab-96876ea84079@gmail.com>
Date:   Thu, 30 Nov 2023 21:08:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug in add_dma_entry()'s debugging code
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew <travneff@gmail.com>,
        Ferry Toth <ferry.toth@elsinga.info>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        iommu@lists.linux.dev,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
References: <736e584f-7d5f-41aa-a382-2f4881ba747f@rowland.harvard.edu>
 <20231127160759.GA1668@lst.de>
 <637d6dff-de56-4815-a15a-1afccde073f0@rowland.harvard.edu>
 <20231128133702.GA9917@lst.de>
 <cb7dc5da-37cb-45ba-9846-5a085f55692e@rowland.harvard.edu>
 <ZWYnECPRKca5Dpqc@arm.com>
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <ZWYnECPRKca5Dpqc@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Op 28-11-2023 om 18:44 schreef Catalin Marinas:
> On Tue, Nov 28, 2023 at 10:18:19AM -0500, Alan Stern wrote:
>> On Tue, Nov 28, 2023 at 02:37:02PM +0100, Christoph Hellwig wrote:
>>> I'd actually go one step back:
>>>
>>>   1) for not cache coherent DMA you can't do overlapping operations inside
>>>      a cache line
>>
>> Rephrasing slightly: You mustn't perform multiple non-cache-coherent DMA
>> operations that touch the same cache line concurrently.  (The word
>> "overlapping" is a a little ambiguous in this context.)
> 
> The problem is worse. I'd say you should not perform even a single
> non-cache-coherent DMA (usually from-device or bidirectional) operation
> if the cache line is shared with anything else modifying it. It doesn't
> need to be another DMA operation. But that's more difficult to add to
> the DMA API debug code (maybe something like the bouncing logic in
> dma_kmalloc_needs_bounce()).
> 
>>> The logical confcusion from that would be that IFF dma-debug is enabled on
>>> any platform we need to set ARCH_DMA_MINALIGN to the cache line size.
> 
> Or just force the kmalloc() min align to cache_line_size(), something
> like:
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 4a658de44ee9..3ece20367636 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -543,6 +543,8 @@ static inline int dma_get_cache_alignment(void)
>   #ifdef ARCH_HAS_DMA_MINALIGN
>   	return ARCH_DMA_MINALIGN;
>   #endif
> +	if (IS_ENABLED(CONFIG_DMA_API_DEBUG))
> +		return cache_line_size();
>   	return 1;
>   }
>   #endif
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 8d431193c273..d0b21d6e9328 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -879,7 +879,7 @@ static unsigned int __kmalloc_minalign(void)
>   	unsigned int minalign = dma_get_cache_alignment();
>   
>   	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
> -	    is_swiotlb_allocated())
> +	    is_swiotlb_allocated() && !IS_ENABLED(CONFIG_DMA_API_DEBUG))
>   		minalign = ARCH_KMALLOC_MINALIGN;
>   
>   	return max(minalign, arch_slab_minalign());

With above suggestion "force the kmalloc() min align to 
cache_line_size()" + Alan's debug code:

root@yuna:~# journalctl -k | grep hub
kernel: usbcore: registered new interface driver hub
kernel: hub 1-0:1.0: USB hub found
kernel: usb usb1: hub buffer at 71c7180, status at 71c71c0
kernel: hub 1-0:1.0: 1 port detected
kernel: hub 2-0:1.0: USB hub found
kernel: usb usb2: hub buffer at 71c79c0, status at 71c7a00
kernel: hub 2-0:1.0: 1 port detected
kernel: hub 1-1:1.0: USB hub found
kernel: usb 1-1: hub buffer at 65b36c0, status at 6639340
kernel: hub 1-1:1.0: 7 ports detected

and the stack trace indeed goes away.

IOW also the 2 root hub kmalloc() are now also aligned to the cache line 
size, even though these never triggered the stack trace. Strange: hub 
status is aligned far away from hub buffer, kmalloc mysteries.

This still did not land for me: are we detecting a false alarm here as 
the 2 DMA operations can never happen on the same cache line on 
non-cache-coherent platforms? If so, shouldn't we fix up the dma debug 
code to not detect a false alarm? Instead of changing the alignment?
Or, is this a bonafide warning (for non-cache-coherent platforms)? Then 
we should not silence it by force aligning it, but issue a WARN (on a 
cache coherent platform) that is more useful (i.e. here we have not an 
overlap but a shared cache line). On a non-cache coherent platform 
something stronger than a WARN might be appropriate?

> Also note that to_cacheline_number() in kernel/dma/debug.c only takes
> into account the L1_CACHE_SHIFT. On arm64 for example, cache_line_size()
> returns the maximum line of all the cache levels (and we've seen
> hardware where the L1 is 64-byte, L2 is 128).
> 
>>> BUT:  we're actually reduzing our dependency on ARCH_DMA_MINALIGN by
>>> moving to bounce buffering unaligned memory for non-coherent
>>> architectures,
>>
>> What's the reason for this?  To allow the minimum allocation size to be
>> smaller than the cache line size?  Does the savings in memory make up
>> for the extra overhead of bounce buffering?
>>
>> Or is this just to allow people to be more careless about how they
>> allocate their DMA buffers (which doesn't seem to make sense)?
> 
> It's the former and it does make a difference with lots of small
> structure or string allocations.
> 
> [...]
>> I get the impression that you would really like to have two different
>> versions of kmalloc() and friends: one for buffers that will be used in
>> DMA (and hence require cache-line alignment) and one for buffers that
>> won't be.
> 
> We've been there for the past 2-3 years (and a few other options). It's
> hard to guess in a generic way because the allocation place may not
> necessarily know how the device is going to access that memory (PIO,
> DMA). The conclusion was that for those cases where the buffer is small,
> we just do a bounce. If it's performance critical, the driver can use a
> kmem_cache_create(SLAB_HWCACHE_ALIGN) and avoid the bouncing.
> 

