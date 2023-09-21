Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD647AA1ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjIUVJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjIUVJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:09:15 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42844CDBE6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:37:03 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c448ba292dso11513395ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328622; x=1695933422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aP7hpifj13TY/cmxy/VtYAtAKQo7n6lxac2QUYqGXnE=;
        b=aCsMPYSruNk/9yL3kVNkQ67ftw0JWLNZ8Ei5Se2KTIg1H7jjRUX8tAcarx71wgV4rV
         CenTLjy5vBKKNjV9P5bNNTnh9mjsay+f6OqT/Q+zYJApi0UEV/WySiVMfXEJQREQ8zuU
         7RHX7Pk/c5pUD3oTAAvaG8+elXyX1j5ckWUOXLOkxGYf7owt5uRSY4L9zDaydEsT19NZ
         pPaKAZiwOjyww1gX5GeGEJn3s1zBcUep+Qn3T0S0AMYZFHc/aI0vOG/EySkgNkQnBqu4
         BgQPy7AlJg+zQiaNx1gFJf/SFWCfZnrnH9J3+5kTRmGIahPoQ5ZDY0A2je7Kw9p0rV1x
         HOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328622; x=1695933422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aP7hpifj13TY/cmxy/VtYAtAKQo7n6lxac2QUYqGXnE=;
        b=Ou0VWoQ67OOJFCkpWS+l5OL5C+HZe/wV1fzsyeVVUEfKc4mlW1W29SsOgawK5CUPw9
         lJO1fblOJLypRU90I3EF2ZVKPN/08DA5hSC1yxWlW5fuHm1h6UAVISk+4gfkhEUXB7o9
         vtaKVwuNlLI6ozGadtEm4MRGZP0tmotPuEvq8VJtJpH4KSvy1/VZpKfYeBdghuFq4MZH
         JEbKbKXcDVbn83C8EWLo/9NJcHCUyup/0EeLQWSzQWBUQcG3gamdMvGi2HjrdhHCKnUu
         F4cislTAavIl5Ca2Ls9qCOggYN/deP1m1ut/DH8rkHZPRDSVkJIUSXK93S1+HRKlQa86
         6DDQ==
X-Gm-Message-State: AOJu0YxB+191LXPoeMYABFkT8Di8uIeINlJQqKkb5ZUExoX7wlc7iF1P
        LsTiHBvn1ihYf+SdgMzpAl9ctlLCaac=
X-Google-Smtp-Source: AGHT+IEWJRg13o8CQmL28cdN0w6eaHgxHhAvKYngOPLn2gpdCakJVl0UPMB+5b2YBqkaLGEngQ4iwIMDAII=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1c7:b0:1b8:3c5e:2289 with SMTP id
 e7-20020a17090301c700b001b83c5e2289mr84379plh.2.1695328622355; Thu, 21 Sep
 2023 13:37:02 -0700 (PDT)
Date:   Thu, 21 Sep 2023 13:37:01 -0700
In-Reply-To: <f987dcde3b051371b496847282022c679e9402e4.1695327124.git.isaku.yamahata@intel.com>
Mime-Version: 1.0
References: <cover.1695327124.git.isaku.yamahata@intel.com> <f987dcde3b051371b496847282022c679e9402e4.1695327124.git.isaku.yamahata@intel.com>
Message-ID: <ZQypbSuMrbJpJBER@google.com>
Subject: Re: [RFC PATCH v2 1/6] KVM: gmem: Truncate pages on punch hole
From:   Sean Christopherson <seanjc@google.com>
To:     isaku.yamahata@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Michael Roth <michael.roth@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        linux-coco@lists.linux.dev,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Quentin Perret <qperret@google.com>, wei.w.wang@intel.com,
        Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Although kvm_gmem_punch_hole() keeps all pages in mapping on punching hole,
> it's common expectation that pages are truncated.  Truncate pages on
> punching hole.  As page contents can be encrypted, avoid zeroing partial
> folio by refusing partial punch hole.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>  virt/kvm/guest_mem.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
> index a819367434e9..01fb4ca861d0 100644
> --- a/virt/kvm/guest_mem.c
> +++ b/virt/kvm/guest_mem.c
> @@ -130,22 +130,32 @@ static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
>  static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  {
>  	struct list_head *gmem_list = &inode->i_mapping->private_list;
> +	struct address_space *mapping  = inode->i_mapping;
>  	pgoff_t start = offset >> PAGE_SHIFT;
>  	pgoff_t end = (offset + len) >> PAGE_SHIFT;
>  	struct kvm_gmem *gmem;
>  
> +	/*
> +	 * punch hole may result in zeroing partial area.  As pages can be
> +	 * encrypted, prohibit zeroing partial area.
> +	 */
> +	if (offset & ~PAGE_MASK || len & ~PAGE_MASK)
> +		return -EINVAL;

This should be unnecessary, kvm_gmem_fallocate() does

	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
		return -EINVAL;

before invoking kvm_gmem_punch_hole().  If that's not working, i.e. your test
fails, then that code needs to be fixed.  I'll run your test to double-check,
but AFAICT this is unnecesary.

> +
>  	/*
>  	 * Bindings must stable across invalidation to ensure the start+end
>  	 * are balanced.
>  	 */
> -	filemap_invalidate_lock(inode->i_mapping);
> +	filemap_invalidate_lock(mapping);
>  
>  	list_for_each_entry(gmem, gmem_list, entry) {
>  		kvm_gmem_invalidate_begin(gmem, start, end);
>  		kvm_gmem_invalidate_end(gmem, start, end);
>  	}
>  
> -	filemap_invalidate_unlock(inode->i_mapping);
> +	truncate_inode_pages_range(mapping, offset, offset + len - 1);

The truncate needs to happen between begin() and end(), otherwise KVM can create
mappings to the memory between end() and truncate().

> +
> +	filemap_invalidate_unlock(mapping);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
