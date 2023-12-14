Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C66813953
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444086AbjLNSCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjLNSCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:02:11 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0D3CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:02:17 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35f69467104so1615ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702576936; x=1703181736; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u/dpKKuYQW5rtb0ApzQxLFyCdBQuf8dsFO4Akckbgdg=;
        b=mhqcXjxdHPrWJ1nocR+9ZQJ6fbtn1YT7nGxh6pSjAKUjlCJfq6+H4gfm6+KOhMsz07
         2On9bo5NGmMttewt/jmYV/pVPFzbCGrgp8VbuYXmEJXl8nfHQUDfY685jRrfYF/8Rm0b
         sG3SD9iE8xfT9yETwYm6f7IJELvWl9BnzQPzm388ebP9DGPpKWx0AsQ2K5CdyBPEvE2b
         CY+gom4JYI6crsZTzitwG99OFWoGpq3FIuydkdWSBM+qKVwGAiifU4hgnKEqyQJGvvMD
         6TH1bNmGUKm43wFIAEXH3hT8ZgHdXIF9z0A5iDTQcAXy8+wh23INpirLMA7a0nlArpfF
         43dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576936; x=1703181736;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/dpKKuYQW5rtb0ApzQxLFyCdBQuf8dsFO4Akckbgdg=;
        b=u+GupCkLAQjBdza+JqXFCpTkUACsz7CWKHjR32DADQ6/xLnP0Ci02XGz1dW2TinPmd
         c0SafilHgzhgptZ/EjgA47upH9Ntjl4hpxNK/Mvg2KOHAx3ZQvmAADU6WefYaliIQZ/D
         tOYA5k4HfSibhVWctqiH0qpIpK914vVd+W3lTl6if3VoVONQyoYH9LYzoZAqacAwVZ0a
         CGtMSlA/tuViB5KZ/7ybnz0QSQo1+bUSZyj29TBVMtvtFstdx8FJ/mvsWSy+OYvNg48W
         NcfmCAZZUUZ369N4BaXjwdAiG0knYKqC3Mp9gqW0ea6l2fGjt/VBLf9LAJT5K/HFnf73
         N3DQ==
X-Gm-Message-State: AOJu0YxGVSSzPVkBE90xJdYvbKszHRNOwKQIQcf8tBH1hnxMGlgF5FL1
        fGTh37NUYwTZJgtP/QImDnGn1w==
X-Google-Smtp-Source: AGHT+IGGaPI6cnZcFngPnCAkiSRePhz5Ew4wWckTDOMgQet1/XMgO7hA9mFqQFlIbu1sIxtOg+DrJA==
X-Received: by 2002:a92:d209:0:b0:35f:7cfd:c5d0 with SMTP id y9-20020a92d209000000b0035f7cfdc5d0mr271054ily.22.1702576936243;
        Thu, 14 Dec 2023 10:02:16 -0800 (PST)
Received: from [2620:0:1008:15:740b:4c24:bdb6:a42a] ([2620:0:1008:15:740b:4c24:bdb6:a42a])
        by smtp.gmail.com with ESMTPSA id fm21-20020a056a002f9500b006cea0fd9afdsm12411929pfb.92.2023.12.14.10.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:02:15 -0800 (PST)
Date:   Thu, 14 Dec 2023 10:02:14 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
cc:     akpm@linux-foundation.org, alim.akhtar@samsung.com,
        alyssa@rosenzweig.io, asahi@lists.linux.dev,
        baolu.lu@linux.intel.com, bhelgaas@google.com,
        cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
        dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
        iommu@lists.linux.dev, jernej.skrabec@gmail.com,
        jonathanh@nvidia.com, joro@8bytes.org,
        krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        marcan@marcan.st, mhiramat@kernel.org, m.szyprowski@samsung.com,
        paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
        samuel@sholland.org, suravee.suthikulpanit@amd.com,
        sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
        tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org,
        will@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH v2 10/10] iommu: account IOMMU allocated memory
In-Reply-To: <20231130201504.2322355-11-pasha.tatashin@soleen.com>
Message-ID: <c0d23d3e-39e6-57af-fd38-eb1b885d7da4@google.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com> <20231130201504.2322355-11-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023, Pasha Tatashin wrote:

> In order to be able to limit the amount of memory that is allocated
> by IOMMU subsystem, the memory must be accounted.
> 
> Account IOMMU as part of the secondary pagetables as it was discussed
> at LPC.
> 
> The value of SecPageTables now contains mmeory allocation by IOMMU
> and KVM.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 2 +-
>  Documentation/filesystems/proc.rst      | 4 ++--
>  drivers/iommu/iommu-pages.h             | 2 ++
>  include/linux/mmzone.h                  | 2 +-
>  4 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 3f85254f3cef..e004e05a7cde 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1418,7 +1418,7 @@ PAGE_SIZE multiple when read back.
>  	  sec_pagetables
>  		Amount of memory allocated for secondary page tables,
>  		this currently includes KVM mmu allocations on x86
> -		and arm64.
> +		and arm64 and IOMMU page tables.

Hmm, if existing users are parsing this field and alerting when it exceeds 
an expected value (a cloud provider, let's say), is it safe to add in a 
whole new set of page tables?

I understand the documentation allows for it, but I think potential impact 
on userspace would be more interesting.

>  
>  	  percpu (npn)
>  		Amount of memory used for storing per-cpu kernel
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 49ef12df631b..86f137a9b66b 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1110,8 +1110,8 @@ KernelStack
>  PageTables
>                Memory consumed by userspace page tables
>  SecPageTables
> -              Memory consumed by secondary page tables, this currently
> -              currently includes KVM mmu allocations on x86 and arm64.
> +              Memory consumed by secondary page tables, this currently includes
> +              KVM mmu and IOMMU allocations on x86 and arm64.
>  NFS_Unstable
>                Always zero. Previous counted pages which had been written to
>                the server, but has not been committed to stable storage.
> diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
> index 69895a355c0c..cdd257585284 100644
> --- a/drivers/iommu/iommu-pages.h
> +++ b/drivers/iommu/iommu-pages.h
> @@ -27,6 +27,7 @@ static inline void __iommu_alloc_account(struct page *pages, int order)
>  	const long pgcnt = 1l << order;
>  
>  	mod_node_page_state(page_pgdat(pages), NR_IOMMU_PAGES, pgcnt);
> +	mod_lruvec_page_state(pages, NR_SECONDARY_PAGETABLE, pgcnt);
>  }
>  
>  /**
> @@ -39,6 +40,7 @@ static inline void __iommu_free_account(struct page *pages, int order)
>  	const long pgcnt = 1l << order;
>  
>  	mod_node_page_state(page_pgdat(pages), NR_IOMMU_PAGES, -pgcnt);
> +	mod_lruvec_page_state(pages, NR_SECONDARY_PAGETABLE, -pgcnt);
>  }
>  
>  /**
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 1a4d0bba3e8b..aaabb385663c 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -199,7 +199,7 @@ enum node_stat_item {
>  	NR_KERNEL_SCS_KB,	/* measured in KiB */
>  #endif
>  	NR_PAGETABLE,		/* used for pagetables */
> -	NR_SECONDARY_PAGETABLE, /* secondary pagetables, e.g. KVM pagetables */
> +	NR_SECONDARY_PAGETABLE, /* secondary pagetables, KVM & IOMMU */
>  #ifdef CONFIG_IOMMU_SUPPORT
>  	NR_IOMMU_PAGES,		/* # of pages allocated by IOMMU */
>  #endif
> -- 
> 2.43.0.rc2.451.g8631bc7472-goog
> 
> 
> 
