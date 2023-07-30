Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6686876891C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 00:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjG3W3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 18:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjG3W3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 18:29:30 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520BA10EB
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 15:28:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31297125334so2634207f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 15:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690756132; x=1691360932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZRFFoPcrSqd2GFBZXJZF1g0vixMajlncvKykQWDSkY=;
        b=YzB1thtMpuJiI1xsxQuVURjrMrRw5vcT/6Dyyglz/ZbnFidLcqiOnSizY540mInsfM
         T8rwx0+kRebLNuQjZJWcx1P8d2UqUIDEM22G2B34P8iCZoikdYG1PnmyplNFJjQTswqG
         TcdoJA83ZcS7t0X5uiaphV7UwflSJKhJQQaJpIR9TWQeSjZ/mVn0nHG1zaP9f04EmFkb
         xRl9KpftnIE6VKFlY908Oa+/ZhuwVmI7Zhdplb7gCa8bJTprmBXKW/xiduITrncFAijc
         FOOHlwMhxIflul4kHSgPp2r+G+Wg6zncPqYh/c8iYeaJyRjIwYhWqOxoMzV33HWVlOJH
         8LZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690756132; x=1691360932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZRFFoPcrSqd2GFBZXJZF1g0vixMajlncvKykQWDSkY=;
        b=YwGULCiK0wjuF7oa8992mI3/G4g2/O22In1ysNLeQ2urB7BxbyqIDnYJ8Z26KpvNhr
         TGH+ThTTDuE98a0LhNvfrHQbd7DXtxHgdnNgS+WrwcnqEhnJijZciqSvDKW/GcMy4pFS
         BnlyihPtxHKpcfszGMsjaGPFj5O08wdpnipCncVvqBIyZ/kxUad6Xy4sPoIWHk0XrV+S
         QoC8fzALyYV3qhxrm1A+ARxS8J1eLWebMXKBSSuaYnFKPkw126HVGZtClLsiXE3CCFqZ
         O+HD1weomDqqep/yQiOmL/YJvt3Ce8bDg6cSA0nBtMgSG7yrBKpzngA+veU0zstkOjGU
         +nwg==
X-Gm-Message-State: ABy/qLbQiJkFfEAR+Qon1aZAz+kd4oHj1hUjsV9OMd+PmWpiTU35Gisn
        X2NBSclW9e355bK7CLNL/VgSq8gnGt3/0aQWN0M=
X-Google-Smtp-Source: APBJJlG/YsFGRjLOglbrshFMlFn9hDKFjCnmZwdnmkb8yJ706MwEXRG84bNhu+tyayk6Yzs6C0UF/w==
X-Received: by 2002:a5d:6686:0:b0:317:6220:ac0d with SMTP id l6-20020a5d6686000000b003176220ac0dmr6617400wru.1.1690756131769;
        Sun, 30 Jul 2023 15:28:51 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b465:0:eda5:aa63:ce24:dac2? ([2a02:6b6a:b465:0:eda5:aa63:ce24:dac2])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d6184000000b003142c85fbcdsm11094522wru.11.2023.07.30.15.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 15:28:51 -0700 (PDT)
Message-ID: <d0004780-0716-cc21-de66-e1ec6d257735@bytedance.com>
Date:   Sun, 30 Jul 2023 23:28:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [v2 0/6] mm/memblock: Skip prep and initialization of struct
 pages freed later by HVO
Content-Language: en-US
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com
References: <20230730151606.2871391-1-usama.arif@bytedance.com>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <20230730151606.2871391-1-usama.arif@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/07/2023 16:16, Usama Arif wrote:
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
> 
> Thanks,
> Usama
> 

There were build errors reported by kernel-bot when 
CONFIG_HUGETLBFS/CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is disabled due to 
patches 5 and 6 which should be fixed by below diff. Will wait for 
review and include it in next revision as its a trivial diff

diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 3fff6f611c19..285b59b71203 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -38,6 +38,8 @@ static inline unsigned int 
hugetlb_vmemmap_optimizable_size(const struct hstate
                 return 0;
         return size > 0 ? size : 0;
  }
+
+extern bool vmemmap_optimize_enabled;
  #else
  static inline int hugetlb_vmemmap_restore(const struct hstate *h, 
struct page *head)
  {
@@ -58,6 +60,8 @@ static inline bool vmemmap_should_optimize(const 
struct hstate *h, const struct
         return false;
  }

+static bool vmemmap_optimize_enabled = false;
+
  #endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */

  static inline bool hugetlb_vmemmap_optimizable(const struct hstate *h)
@@ -65,6 +69,4 @@ static inline bool hugetlb_vmemmap_optimizable(const 
struct hstate *h)
         return hugetlb_vmemmap_optimizable_size(h) != 0;
  }

-extern bool vmemmap_optimize_enabled;
-
  #endif /* _LINUX_HUGETLB_VMEMMAP_H */
diff --git a/mm/internal.h b/mm/internal.h
index 692bb1136a39..c3321afa36cb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1106,7 +1106,7 @@ struct vma_prepare {
  #ifdef CONFIG_HUGETLBFS
  void __init hugetlb_hstate_alloc_gigantic_pages(void);
  #else
-static inline void __init hugetlb_hstate_alloc_gigantic_pages(void);
+static inline void __init hugetlb_hstate_alloc_gigantic_pages(void)
  {
  }
  #endif /* CONFIG_HUGETLBFS */


> [v1->v2]:
> - (Mike Rapoport) Code quality improvements (function names, arguments,
> comments).
> 
> [RFC->v1]:
> - (Mike Rapoport) Change from passing hugepage_size in
> memblock_alloc_try_nid_raw for skipping struct page initialization to
> using MEMBLOCK_RSRV_NOINIT flag
> 
> 
> 
> Usama Arif (6):
>    mm: hugetlb: Skip prep of tail pages when HVO is enabled
>    mm: hugetlb_vmemmap: Use nid of the head page to reallocate it
>    memblock: pass memblock_type to memblock_setclr_flag
>    memblock: introduce MEMBLOCK_RSRV_NOINIT flag
>    mm: move allocation of gigantic hstates to the start of mm_core_init
>    mm: hugetlb: Skip initialization of struct pages freed later by HVO
> 
>   include/linux/memblock.h |  9 +++++
>   mm/hugetlb.c             | 71 +++++++++++++++++++++++++---------------
>   mm/hugetlb_vmemmap.c     |  6 ++--
>   mm/hugetlb_vmemmap.h     | 18 +++++++---
>   mm/internal.h            |  9 +++++
>   mm/memblock.c            | 45 +++++++++++++++++--------
>   mm/mm_init.c             |  6 ++++
>   7 files changed, 118 insertions(+), 46 deletions(-)
> 
