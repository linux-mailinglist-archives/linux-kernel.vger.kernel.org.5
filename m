Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800D376E2A9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbjHCIOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjHCIN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:13:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08AB59C3;
        Thu,  3 Aug 2023 01:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691049892; x=1691654692; i=deller@gmx.de;
 bh=Wyd0c03S0B/h4G4JVbJAcBNMf8jV6S12a+ESlp6Swzk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=VsawcGmx1ngfVOoMmN2Yr1WjBAGrdFdkh9lAbwPVNgCCmJgScNEHYNFoC49WX77tp3WHst3
 FreRo/bDqeBxjHcAMRmYCHbFwHKqMkjdQ3tGBA1f5jDI28lqxglcrDRQpeQiwvpmqoRw/g6db
 6yMIxqq27/yJ9gu640OhtIqO3Zlb29kYi362M2vvjofod9we3fPmAuIIyPuEOGO1FOu+cAD+m
 dth0apHNuQAI81lYaea+Sl6eZMaZUsISrtfSGcGWsD5lOJS5aHZkpD4K/OJQwwW3QvPjTMt0m
 9sKotSkf7zV8W/k/IDYIyxSaIIdBPDVyPAMOPavqSm75DQQEPrOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.147.53]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f5T-1qPWzD0Vhf-004Ay8; Thu, 03
 Aug 2023 10:04:52 +0200
Message-ID: <0ff53a6d-4730-1fa5-740d-93dee35c80ea@gmx.de>
Date:   Thu, 3 Aug 2023 10:04:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] parisc: pci-dma: remove unused and dead EISA code and
 comment
Content-Language: en-US
To:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
References: <20230802163321.1560-1-petrtesarik@huaweicloud.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230802163321.1560-1-petrtesarik@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aDSPKvrnmaLVRZGqHBrCHBXcmFlubNlWIPa/D56wTS7V2JiVhws
 7vAPnaeNmO1nTn4bIPMcC3BqwsOJUpN+nYzHuc4dJcX4uCNDAGtjmD0L/dlGvaJonHQKKUD
 6gBXtPEefZyCdzJkLuKQzQReq5FppMTCmXUZhksmIXA4aIstey7MEN46I40JEnNnf/Bfq4U
 Rrwtwm7Xsve7shB81Ah9g==
UI-OutboundReport: notjunk:1;M01:P0:qf9lH98l+2c=;V/5kk4YjlbDHox1FyoRLl7ka4fI
 znxjlYC1DjkQm2ZioiBNMm8v1JNEfHk8IBLFK0Fp/fRnrO78LD3ffmsEKP576742/ZJjEC0VT
 zriAZlAF1yfy6YBhrk4X2yQbkjRWaCYiWqZsNULAV7cDZoF/o8n087G3h4FlghrtDYG7xKypu
 JsPmWN5zS5OgNXnSyrLGPjStnGLTjxHW39MM92+CqNmtYvlrLSM9oc9LbrC9L0+gTD/Ty8alZ
 MlwYMxFb8FPXd7PQch9JQqBI+A3Bm0fYQ6B5YFWxWsZhLJ16HqoDyG0NlZzj/V9+H7WUNf7hW
 8p575c6Zh4DnNB80JHR2SFYaSr7C6GGhc87jZoxAiI75d5iBwktEsmEfzDB43SU09zBASjyBv
 46rSQO16lijJZwiGOFsIEcdOY2nndyoM4JYMTVv7ZeNIblfP3RS55KiLdsYiDmUPUX1KgClMb
 Etr52i8wE28AbS5/9Vf3HNqP29aJ3RWYXbCVH9IrUD6mADYRuzmfgpvApbIYRcOz+k/u+qHyI
 A9efiXqA7Znu6d5EHUiSz60XmdaLKuT6OenYTX1HrspS+RtWzgiGh7EV3txAPfzLrMz0P0dk3
 qSRURAq9ZOs4emKVHE3MA0VtN2VT9Cukics6HMbZY+cwQJRQo+NAO5UP32OTsmsjsEl3gXoK/
 qlP48C9o6/VqnNjgHEWiqKozAosaV/V6RSqYQJspIKAAbLPKw+2Mm+Iqze2wT8llZZ0Zb+zH2
 k6hLZWdzMfZz+p1zCgg6hDkL/2x32axk298rSYXbhaa/seiR7oeDo32cebazG0YHuzqg6/N2G
 b5UbjjrIa6vhQ/hdzi2/9HJJyqQx/T98urMFKsiKRhSObNn0QlnM5Uh+KGpeIjqI7dbBdLMKL
 vAs1Lwhw0YLH2lvxn0aEYgx3upRnEeCz3Ksnc1JG+r55h4wA4nT1hTPEazleCkSxf2MhVPMMo
 D93Vk20ZbSz3gnnSQ2HaGopG1m8=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 18:33, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
>
> Clearly, this code isn't needed, but it gives a false positive when
> grepping the complete source tree for coherent_dma_mask.
>
> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>

queued up in parisc git tree.

Thanks!
Helge

> ---
>   arch/parisc/kernel/pci-dma.c | 8 --------
>   1 file changed, 8 deletions(-)
>
> diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
> index d818ece23b4a..3f6b507970eb 100644
> --- a/arch/parisc/kernel/pci-dma.c
> +++ b/arch/parisc/kernel/pci-dma.c
> @@ -417,14 +417,6 @@ void *arch_dma_alloc(struct device *dev, size_t siz=
e,
>   	map_uncached_pages(vaddr, size, paddr);
>   	*dma_handle =3D (dma_addr_t) paddr;
>
> -#if 0
> -/* This probably isn't needed to support EISA cards.
> -** ISA cards will certainly only support 24-bit DMA addressing.
> -** Not clear if we can, want, or need to support ISA.
> -*/
> -	if (!dev || *dev->coherent_dma_mask < 0xffffffff)
> -		gfp |=3D GFP_DMA;
> -#endif
>   	return (void *)vaddr;
>   }
>

