Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7DE7633E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjGZKex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjGZKev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:34:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05909212F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:34:18 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so895372e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690367656; x=1690972456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6pBhJZIIkh5Y0ZegeYnaNPrsKup8SfYVJ8Ax7qMD0bM=;
        b=FU9mgCufp8+t0IW6faQAPl5Iyi4wcOnZOizZwNmJU76ZXU7xiOWIITjHX2EIGK1Oal
         Ei/6g+rsdQ4mETerF5Pv+aR7SpDCp135DImT99F+vRQlDrJPNFcFq/uXLREViUgA4nAs
         4V/SH5e4kF0nckxnWhIjVwPHlo6zI8uWN4PBph1S5DQXLK3ygU2aFl2/k5v5DPy4ynDN
         ZYfj36ZAE3iVvhO1/AXnqxpup1RnND1DG5+/LAtbZBvR0wbMIKj5F2W5TVKUzre187RU
         tlyogaTGkfVgIRxhdyIJi5XTe7+SNuLeS+7+2UF9pEWEjFtOEp8tluS2xZZbLRwF/GlH
         pfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690367656; x=1690972456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pBhJZIIkh5Y0ZegeYnaNPrsKup8SfYVJ8Ax7qMD0bM=;
        b=kG2GdYxmazg9URJVyL3/cZ9nbfJWL1oBSjwiVe8JddDmJUz1FC1yhKWsz/sfs7dTpa
         pkdwY9ASM8CBdw229c2RitJmjcSp9RbCZDSseTW7KmyaEuwnid+d53UBoAKpJOU1k/IP
         MBUIupdW1DeeGCaHjN6qurmqCozzkbcbKSeOVYazCKJLSIE1vRBNERzyDMCvv+oFhOIg
         paftcldTl/DrMgB/dEu1QdT2w0JzlhnXWK3aU+lboUzEjTpfGBMdhPEmJ44yJs5dndIV
         nP+DJ0+TWTk0/1R8gV3n+T9v7Ch/fH1hrtQbY8fMSbs/RjGTHa9uqChalwdrQ3KbVCHU
         6edQ==
X-Gm-Message-State: ABy/qLYOGRr+MuPzYJsZl5tl/0NjcSNzxwhg1VmXT5hullTHegqdqHhJ
        A+CAxs9eIaoOEkz5x7WpVGaxyX16mrG4NwRw5tw=
X-Google-Smtp-Source: APBJJlGJC+4Vw7ybsGTQvxNelxSmpvS0+CLSLRChw/6Kg32BWyc7brBDAHFPjsTUB/+9mvQi04/Caw==
X-Received: by 2002:a05:6512:2824:b0:4f9:5196:5ed0 with SMTP id cf36-20020a056512282400b004f951965ed0mr1336227lfb.7.1690367656268;
        Wed, 26 Jul 2023 03:34:16 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b465:0:2a3c:96a:1b3a:ab94? ([2a02:6b6a:b465:0:2a3c:96a:1b3a:ab94])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c235200b003fc07e1908csm1591999wmq.43.2023.07.26.03.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 03:34:15 -0700 (PDT)
Message-ID: <03476b1d-c825-0ab6-73bc-b98419d3dff6@bytedance.com>
Date:   Wed, 26 Jul 2023 11:34:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC 0/4] mm/memblock: Skip prep and initialization of struct
 pages freed later by HVO
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com
References: <20230724134644.1299963-1-usama.arif@bytedance.com>
Content-Language: en-US
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <20230724134644.1299963-1-usama.arif@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/07/2023 14:46, Usama Arif wrote:
> If the region is for gigantic hugepages and if HVO is enabled, then those
> struct pages which will be freed later by HVO don't need to be prepared and
> initialized. This can save significant time when a large number of hugepages
> are allocated at boot time.
> 
> For a 1G hugepage, this series avoid initialization and preparation of
> 262144 - 64 = 262080 struct pages per hugepage.
> 
> When tested on a 512G system (which can allocate max 500 1G hugepages), the
> kexec-boot time with HVO and DEFERRED_STRUCT_PAGE_INIT enabled without this
> patchseries to running init is 3.9 seconds. With this patch it is 1.2 seconds.
> This represents an approximately 70% reduction in boot time and will
> significantly reduce server downtime when using a large number of
> gigantic pages.

There were a few errors reported by kernel-bot if different config 
options were changed (CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP disabled, 
CONFIG_CMA enabled). I will fix these in the next revision if the 
general approach in the patches looks good to the community to start review.

Thanks,
Usama

> 
> Thanks,
> Usama
> 
> Usama Arif (4):
>    mm/hugetlb: Skip prep of tail pages when HVO is enabled
>    mm/memblock: Add hugepage_size member to struct memblock_region
>    mm/hugetlb_vmemmap: Use nid of the head page to reallocate it
>    mm/memblock: Skip initialization of struct pages freed later by HVO
> 
>   arch/arm64/mm/kasan_init.c                   |  2 +-
>   arch/powerpc/platforms/pasemi/iommu.c        |  2 +-
>   arch/powerpc/platforms/pseries/setup.c       |  4 +-
>   arch/powerpc/sysdev/dart_iommu.c             |  2 +-
>   include/linux/memblock.h                     |  8 +-
>   mm/cma.c                                     |  4 +-
>   mm/hugetlb.c                                 | 36 +++++---
>   mm/hugetlb_vmemmap.c                         |  6 +-
>   mm/hugetlb_vmemmap.h                         |  4 +
>   mm/memblock.c                                | 87 +++++++++++++-------
>   mm/mm_init.c                                 |  2 +-
>   mm/sparse-vmemmap.c                          |  2 +-
>   tools/testing/memblock/tests/alloc_nid_api.c |  2 +-
>   13 files changed, 106 insertions(+), 55 deletions(-)
> 
