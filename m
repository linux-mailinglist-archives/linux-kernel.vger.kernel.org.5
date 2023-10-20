Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D4D7D0A5F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbjJTIQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJTIQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:16:57 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2C3E8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:16:53 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231020081649euoutp016f5ca737d7dba5a9747d469300cc17c7~PwtYdmNS90704407044euoutp01S
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:16:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231020081649euoutp016f5ca737d7dba5a9747d469300cc17c7~PwtYdmNS90704407044euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697789809;
        bh=wzSstyDCnGvRKqkLCoU0yVZL9DxpC55aNBQ7a5fvoqQ=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=r3hkpYaCxPfshPQyMD0xct9u5H7T4muH8haj5P8AFFGq86lG4FuvQxTpjzzl+dfj0
         Ifmjtrx95kiM4XvbISEU99xdkRBqI1lczANWz+m80MVrrNdTEnSTX8457cUEJFvmwo
         GL9ZNTe2etefF5sbM4hSW//NR2W8P9ttc8OOS+nI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231020081648eucas1p163b5f631c1f5fdac38d071af52abe179~PwtYCFLf11288412884eucas1p1p;
        Fri, 20 Oct 2023 08:16:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 69.76.42423.07732356; Fri, 20
        Oct 2023 09:16:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231020081648eucas1p17d2572cfca5762d2f5cbc560dd648564~PwtXgMVcS1169311693eucas1p1v;
        Fri, 20 Oct 2023 08:16:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231020081648eusmtrp25a731dd1b01fccb768dc918808a88fa8~PwtXfVxCq2171621716eusmtrp2d;
        Fri, 20 Oct 2023 08:16:48 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-e6-6532377091e2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8E.2E.10549.07732356; Fri, 20
        Oct 2023 09:16:48 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231020081646eusmtip19e42584464e04ee4d77d2df44f266c5b~PwtWMLgPR1066210662eusmtip1h;
        Fri, 20 Oct 2023 08:16:46 +0000 (GMT)
Message-ID: <3515448c-8a4b-4669-9f80-2f55c5100674@samsung.com>
Date:   Fri, 20 Oct 2023 10:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] ARM: Select DMA_DIRECT_REMAP to fix restricted
 DMA
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20231006074045.GA15303@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxbVRj29F5uP0LxtqvryUZCJELCPsqYU49ah4qam2xxW9L9WYxbs14p
        kxZs18H8mIVsdEM22tJms5SJo+OjIpB2GxTFQRVYM2m0c7UlxTaRWQdUZAwdQzbpx5R/z/O8
        53mf931zWBjfRKxjlSgP0yqltDSb4OBXRha9m8uf20pv+cX9NLJ2dxJo2TjCRF+eHsZRyBhl
        oslBHUD3Bj1M1NRoBKjji2EGGpipJ5CzpZ2BglErjkz/tDGQ41d/GrrRbyWQ2zwAkK7jFoF8
        9QYG+q67l4Empt9ETocZe1lA3fD/iFFL942AsoTHCKpvwgaohaCXQRnGNlMuywSTcthPEVTI
        /zVB/eH1Mqlr55Zw6rxnD+W0fUx9FdQSVMuZhjRq7tY4vpu3jyOW0aUlR2hV/vYDHLmnrgmU
        L2ZWNpzSpmnB9NpawGZBcht8oOvBawGHxSfbAbQ09jCT5C6AD+98niLzADpil8Eji6HLlbK0
        ARjQnseSZA7Avrk6RvwVl9wO++er8DjGyRx4IRBmJnUe9Hw6mdCfILNgePxcQl9D7oZV1bYE
        xkghHJ/8LNFHQO6ErfeugngARjYT0HbzLyxeIMgCWBurJeKYTW6CEdNFkDRnwd6YNTERJGs4
        cDbYy0zO/RocGWlN4TVwavRSCmfCh654WtygA7B5KZwiegC10fHU1i/CkPf+ShxrJSIPdvfn
        xyEkX4Heqx8mYQYMxHjJGTKg8cpZLClz4ckafrJHLrSMdv2XOvSDD9ODbMuqs1hWrW9ZtY3l
        /9hmgNuBkNaoFcW0ukBJV4jUUoVaoywWHSxTOMDKx73+YPROH2iamhO5AYMF3ACysGwBN4fa
        QvO5MunR92lV2X6VppRWu8F6Fp4t5ObIsmg+WSw9TL9L0+W06lGVwWKv0zIqjssbremHbCce
        +2hUeURSYc8TD77a4Bjq3LZcaD50rLWcvP3bs2xNs3HT3T8/2PU4efmdM/q/M4rGZxfaakn/
        0fy8ebbym5Yn909dSx94XoBk9sKdk0MeULReVRCJTlyK0eUvvC3v4IaeqpbrcsN1fJ/Sd1D0
        +7dZVYb5+iVzof+4RBJ5K2tR01Et3KX+pFL90s+89ya0gZ+UIZPEuWdsh2k4N9Aj/t55U9G+
        NViyEd/bdiK3pJkX8dkDeWXpRdP6i1PeffqMjbcHDBIx95gLs+nWRsx4tFOcKZiRKd6oLF2W
        ntxwveb0AuaK6oWiHbP+zmfSY116wwHX66ypmWxcLZcWbMBUaum/taQ0AScEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsVy+t/xu7oF5kapBrMfClrMWb+GzeLvpGPs
        Fmt7j7JY3Jn0nN3iyYF2RosfB06yW8ydPYnRYuXqo0wWe9/0s1lsXryCyeLm8zksFlP+LGey
        2PT4GqvF5V1z2CwOTd3LaNG+8imbxaX+iUwWR9ZvZ7K4+9rPYvOmqcwOIh6Xr11k9vj9axKj
        x6z7Z9k8dtxdwujx9eY5Jo+JZ3U9ds66y+6xaVUnm8eda3vYPN6dO8fucWLGbxaPeScDPTYv
        qffYfbOBzWNx32RWj49Pb7EECEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZ
        Kunb2aSk5mSWpRbp2yXoZZzsmctY8FOmYnJnA2sD42uxLkZODgkBE4mJ63aydDFycQgJLGWU
        uLqznQkiISNxcloDK4QtLPHnWhcbiC0k8J5RYs4dVRCbV8BOYtfnRhYQm0VAVWLRjfvsEHFB
        iZMzn4DFRQXkJe7fmgEWFxbwk5i0eT7YfGYBcYlbTyBsEQEfiWU/9jOCHMEssIRNYsGtL0wQ
        Fx1mkth9rg3sCjYBQ4mutxBXcAroSDyYspQRYpKZRNfWLihbXmL72znMExiFZiE5ZBaShbOQ
        tMxC0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYILZduzn5h2M81591DvEyMTBeIhR
        goNZSYRX1cMgVYg3JbGyKrUoP76oNCe1+BCjKTA0JjJLiSbnA1NcXkm8oZmBqaGJmaWBqaWZ
        sZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDU+rFmOU6517p9ZX+F482FZt/0JN53iLdPbwZ
        BU9eCbnvLWESvMh/cVWCB0sG+6NrmWzX+yY8kegUSbP9tMEyIfDBnIINVS4yXxjZObzYgxUX
        rBcVfl7mlL/Hfwb/78LtN+pa6m+cSizkCtHXMNOLuNWY9WdOZFWEIp/aLTWR2fcP25twNK10
        OMFw5YXF55bch3p3XeVE3vzWnXC/bIevEEOfytE2F6uv5W/Tg/7ztfRw7Z20esGRuCXpW+TK
        5iXzalyfohyd7vmksMxY++iHTelvwvV3NKja3gtImsF2Opt91zYJraKT3DXX0kpueey/1KB+
        Jzaa84Vq0LGPIQ1MhyPUmrfZnfwrfa32cY4SS3FGoqEWc1FxIgBtpaFzuQMAAA==
X-CMS-MailID: 20231020081648eucas1p17d2572cfca5762d2f5cbc560dd648564
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231020081648eucas1p17d2572cfca5762d2f5cbc560dd648564
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231020081648eucas1p17d2572cfca5762d2f5cbc560dd648564
References: <20230926175208.9298-1-james.quinlan@broadcom.com>
        <20230926175208.9298-2-james.quinlan@broadcom.com>
        <CACRpkdYGPpUUCqmJLT4t+6CNOOmRAh_vYPSPK1SWy+tNycnSqQ@mail.gmail.com>
        <20231002061628.GC911@lst.de>
        <CA+-6iNy79pLgACMGXxRkPuVkXca0VyLis+jQcRmCwtBvEfFzgw@mail.gmail.com>
        <20231006074045.GA15303@lst.de>
        <CGME20231020081648eucas1p17d2572cfca5762d2f5cbc560dd648564@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I didn't have enough time to follow the whole discussion, but it looks I 
can add some comments.

On 06.10.2023 09:40, Christoph Hellwig wrote:
> On Thu, Oct 05, 2023 at 01:53:33PM -0400, Jim Quinlan wrote:
>>> Yes, DMA_DIRECT_REMAP should only be used for platforms using the
>>> generic generic remap that plus straight into dma-direct and
>>> bypasses arch_dma_alloc.
>>>
>>> ARM first needs support to directly set the uncached/wc bits on
>>> the direct mapping for CMA, which should be fairly simple but require
>>> wide spread testing.
>>>
>>> I'd be happy to work with anyone who wants to look into this.
>> I'd like to look into this and help make it work for ARCH=arm but you
>> seem to be saying that you also need help from ARM the company?
> No, I don't care about companies.  I just need someone (singular or
> plural) to test a wide range of arm systems.
>
> Here is my idea for the attack plan:
>
> As step 1 ignore the whole CMA direct map issue, and just to the
> trivial generic dma remap conversion.  This should involved:
>
>   - select DMA_DIRECT_REMAP
>   - provide arch_dma_prep_coherent to flush out all dirty data by
>     calling __dma_clear_buffer
>   - remove the existing arch_dma_alloc/arch_dma_free and all their
>     infrastructure
>
> With this things should work fine on any system not using CMA

This won't be that easy.

For historical reasons (performance and limitations of the pre-ARM v7 
cores), on the 32bit ARM the whole kernel's direct mapping is done using 
so called 'sections' (1MiB size afair). Those sections are created in 
the per-process MMU page tables (there are no separate MMU table for the 
kernel mappings), so altering those mappings requires updating bits in 
all processes in the system. Practically this means that those mappings 
has to be static once created during boot time. That's why when no CMA 
is selected, the whole dma_alloc_coherent() allocations are limited to 
rather small region, which is already remapped as non-cached during boot.

This is a serious limitation, that's why some other approach was needed 
and it turned out that CMA can resolve that issue too.

CMA limits the DMA allocations to the specific memory regions, thus each 
such region (part of the kernel's direct map) CAN be easily remapped 
during boot time with standard 4K pages and then altered/updated 
on-demand when coherent allocation is performed. This slightly lowers 
the performance of the memory related operation on that region (access 
to 4K pages is a bit slower compared to the memory mapped with 
sections), but CMA is mainly used on the newer ARMv7 systems which often 
have a decent cache, which mitigates such performance drop.


> Then attack the CMA direct mapping:
>
>   - modify the core DMA mapping code so that the
>     ARCH_HAS_DMA_SET_UNCACHED code is only used conditionally
>     I'm not quite sure what the right checks and right place is,
>     but the intent is that it should allow arm to only use that
>     path for CMA allocations.  For all existing users of
>     CONFIG_ARCH_HAS_DMA_SET_UNCACHED it should evaluate to
>     a compile-time true to not change the behavior or code
>     generation
>   - then in arm select ARCH_HAS_DMA_SET_UNCACHED and implement
>     arch_dma_set_uncached, arch_dma_clear_uncached and the new
>     helper above

The plan for the CMA related case sounds good.

If you need any ARM related tests, let me know. I have a bunch of ARM 
based test machines, which I use for the tests of the linux-next on the 
day-to-day basis.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

