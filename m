Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E6E8139DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjLNSW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNSW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:22:26 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692DD122;
        Thu, 14 Dec 2023 10:22:33 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c210e34088so7014352a12.2;
        Thu, 14 Dec 2023 10:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702578153; x=1703182953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nW7YQuAxglqj6q/xmfwmVZsQUjHZQg8lnSbcIyJGzj0=;
        b=O0IUPWR3CC21PXdqpCyHLaPtCyIRFwuoBYSgtatsQBAfd2VwTifeyMTv0Ll0HvaI68
         2OT4GIwAxK6sHxVdvsQATj8IEqqSRPG5a6tnmutuyF2oPzbjcuFU0Li0Qx9ySIUNdmvw
         yJbAv5RaY6Zj6kQUhPSK1ZFm8BxltH47Qdz+m+XMn/wcP0dP/r9DSoFqnDNCmlB3//I7
         mN4FEPjgAPTmBrvg4m0ybRVYVRUhOjTDO3OsTSlgnElvJg4W2jOqepQHzE2GHx2ZMREm
         gHLRNcMYEscHUQ/k5cL8vllDEjeJIImqMSbLMZoutpRLc+uvycmrGjtbsKaJOqvMZMhT
         ZG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702578153; x=1703182953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nW7YQuAxglqj6q/xmfwmVZsQUjHZQg8lnSbcIyJGzj0=;
        b=VgKgHozExvREkPMuIQg9pO6YZonBof/fviiYIfS3ruKTlZ9NnPxHaPVNevj0J2Tqqz
         BVBnAQrUrntGpqyqym60nZtweFScdAIOGBeYpDkCeou4zzUoAmXVMi0L4/NkFbvtfVJd
         wdZU1yznKVw1tKFtQed99Xxre8GF4LGBwOrAgyXofPEcllQbbZhY4FtUh/gGBGeCpzBE
         ooAY1Xy+oT70RVMJOze9od7Rrw4snEXSwS2m7ceqJBplupIN1UB6wA0o3MTT0RiQ9TX4
         RlNfkPqDQ0ufK2SqXjfXLOCPfAELbiqcaswk7rdAgdecu+PXr/PRNdRUWqJbmjTAvOLb
         wW8Q==
X-Gm-Message-State: AOJu0YzhScB8XTcVx0h4vj2qtFwAs6HLU1pgFHKLM8rUmjRm/pNtAh4T
        2jLUID9VpqvZZUE9mrkMEYD0+uniHKwc/A==
X-Google-Smtp-Source: AGHT+IFSWzhP+yJbXjLlek3YaFccxzQV2Fb8vWZD7aBS7ToIo7bB/MXO3R2XPy8zYxYUW47oQo7cIQ==
X-Received: by 2002:a17:902:7842:b0:1d0:b229:faa2 with SMTP id e2-20020a170902784200b001d0b229faa2mr8048916pln.68.1702578152753;
        Thu, 14 Dec 2023 10:22:32 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c090:500::5:223d])
        by smtp.gmail.com with ESMTPSA id iz5-20020a170902ef8500b001cfcf3b6de7sm3559334plb.52.2023.12.14.10.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:22:32 -0800 (PST)
Date:   Thu, 14 Dec 2023 13:22:29 -0500
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH V4 2/2] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZXtH5T+/qs+dUqrz@dschatzberg-fedora-PF3DHTBV>
References: <20231213013807.897742-1-schatzberg.dan@gmail.com>
 <20231213013807.897742-3-schatzberg.dan@gmail.com>
 <ZXq_H4St_NSEFkcD@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXq_H4St_NSEFkcD@tiehlicka>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 09:38:55AM +0100, Michal Hocko wrote:
> On Tue 12-12-23 17:38:03, Dan Schatzberg wrote:
> > Allow proactive reclaimers to submit an additional swappiness=<val>
> > argument to memory.reclaim. This overrides the global or per-memcg
> > swappiness setting for that reclaim attempt.
> 
> You are providing the usecase in the cover letter and Andrew usually
> appends that to the first patch in the series. I think it would be
> better to have the usecase described here.
> 
> [...]
> > @@ -1304,6 +1297,18 @@ PAGE_SIZE multiple when read back.
> >  	This means that the networking layer will not adapt based on
> >  	reclaim induced by memory.reclaim.
> >  
> > +The following nested keys are defined.
> > +
> > +	  ==========		================================
> > +	  swappiness		Swappiness value to reclaim with
> > +	  ==========		================================
> > +
> > +	Specifying a swappiness value instructs the kernel to perform
> > +	the reclaim with that swappiness value. Note that this has the
> > +	same semantics as the vm.swappiness sysctl - it sets the
> 
> same semantics as vm.swappiness applied to memcg reclaim with all the
> existing limitations and potential future extensions.

Thanks, will make this change.

> 
> > +	relative IO cost of reclaiming anon vs file memory but does
> > +	not allow for reclaiming specific amounts of anon or file memory.
> > +
> >    memory.peak
> >  	A read-only single value file which exists on non-root
> >  	cgroups.
> 
> The biggest problem with the implementation I can see, and others have
> pointed out the same, is how fragile this is. You really have to check
> the code and _every_ place which defines scan_control to learn that
> mem_cgroup_shrink_node, reclaim_clean_pages_from_list,
> reclaim_folio_list, lru_gen_seq_write, try_to_free_pages, balance_pgdat,
> shrink_all_memory and __node_reclaim. I have only checked couple of
> them, like direct reclaim and kswapd and none of them really sets up
> swappiness to the default memcg nor global value. So you effectively end
> up with swappiness == 0.
> 
> While the review can point those out it is quite easy to break and you
> will only learn about that very indirectly. I think it would be easier
> to review and maintain if you go with a pointer that would fallback to
> mem_cgroup_swappiness() if NULL which will be the case for every
> existing reclaimer except memory.reclaim with swappiness value.

I agree. My initial implementation used a pointer for this
reason. I'll switch this back. Just to be clear - I still need to
initialize scan_control.swappiness in all these other places right? It
appears to mostly be stack-initialized which means it has
indeterminate value, not necessarily zero.
