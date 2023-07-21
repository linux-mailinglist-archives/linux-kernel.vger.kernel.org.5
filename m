Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77C575D78B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGUWdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjGUWdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:33:19 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28D3359F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:33:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58398367e4eso10358407b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689978797; x=1690583597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7T9EVRBobAr4a8JPgfiIjIX72kF/VyhERBKOIDOEvTo=;
        b=N3JmIIRFuucWrTRji2j76NW5FMl4jS4wLA3POQW0VLRrR4sFhmKgj7pRUj3gSs0yqe
         WZvjiVqpyglaAnq94LWefXiOIlgXr/PrbktD6W+TBAFf6s+alvi+gxgQyH8TNpVAsODx
         OCRkSmym8Xr89af+taUXT0Vhz6Xh0SqYzK++E+LxDlItaWIfk/xiv3hy/q9bOsyCLBei
         XOyxBMd+5ThifDUK6/o5f+QTqfW/eyfYM90Y+kU5f1e/gaMgZLzn2OVn9bd0Flf7Aat3
         ovp2GWeXuTu2BrzRvrwJog7aZBAUD7Ob8wE6NUPaB8bQmPi6OopUS5w2j6M71SZpRLW7
         K0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689978797; x=1690583597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7T9EVRBobAr4a8JPgfiIjIX72kF/VyhERBKOIDOEvTo=;
        b=fJqNAYkNVHhnXJKTIPsiH8XuM3VQ1z9BfrEL+QF3c5yaBcptveL4Q6gd7wuV0z5Q/A
         wkriGZoHCUZ7oTcimqcZFnPo4sxHtCKCgRkLVLiXHc/e0fcMeE2lbJx8hk8/HyMFA5tP
         EiB9LW59wIaSvTqQR31HqpJOnRhkmBjDeNNzsDc9us43ouZJRZi+z1Gg1BsfCoJWTC+4
         /ijL+h74GzFitxvo7LMM4GHJWvkHKfayOJqmBTpTuBgBHY1KYw+21L0276EkhHY+4UWn
         pSp6T1kQWZ3o2dBxm8uOR3zE0mgQfOOewO0jp7DpEboOsD9m/VTqI3oKye67K4YszWpV
         x1Gw==
X-Gm-Message-State: ABy/qLZLKxIWXZ7oCvHuc0EvmiiSDSuXGDvChe/riJpYo1Ojl/JROVFS
        JUTtntcCH5szYnj05aESrY2SSrGTnlQ=
X-Google-Smtp-Source: APBJJlHilhePzxpErmYmDQimNKPr2Kn3t6yMJLQXIDH2a2VxS3jSVStiMTfJxkBt/UbXzPR1R9iVHrOiOZs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ce82:0:b0:d04:faa6:e62b with SMTP id
 x124-20020a25ce82000000b00d04faa6e62bmr11683ybe.6.1689978797172; Fri, 21 Jul
 2023 15:33:17 -0700 (PDT)
Date:   Fri, 21 Jul 2023 15:33:15 -0700
In-Reply-To: <20230721222704.GJ25699@ls.amr.corp.intel.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-13-seanjc@google.com>
 <20230721061314.3ls6stdawz53drv3@yy-desk-7060> <20230721222704.GJ25699@ls.amr.corp.intel.com>
Message-ID: <ZLsHq69sMG7pmRiz@google.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Sean Christopherson <seanjc@google.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Yuan Yao <yuan.yao@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023, Isaku Yamahata wrote:
> On Fri, Jul 21, 2023 at 02:13:14PM +0800,
> Yuan Yao <yuan.yao@linux.intel.com> wrote:
> > > +static int kvm_gmem_error_page(struct address_space *mapping, struct page *page)
> > > +{
> > > +	struct list_head *gmem_list = &mapping->private_list;
> > > +	struct kvm_memory_slot *slot;
> > > +	struct kvm_gmem *gmem;
> > > +	unsigned long index;
> > > +	pgoff_t start, end;
> > > +	gfn_t gfn;
> > > +
> > > +	filemap_invalidate_lock_shared(mapping);
> > > +
> > > +	start = page->index;
> > > +	end = start + thp_nr_pages(page);
> > > +
> > > +	list_for_each_entry(gmem, gmem_list, entry) {
> > > +		xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
> > > +			for (gfn = start; gfn < end; gfn++) {
> > 
> > Why the start end range used as gfn here ?

Math is hard?  I almost always mess up these types of things, and then catch my
bugs via tests.  But I don't have tests for this particular flow...   Which
reminds me, we need tests for this :-)  Hopefully error injection provides most
of what we need?

> > the page->index is offset of inode's page cache mapping and
> > gmem address space, IIUC, gfn calculation should follow same
> > way as kvm_gmem_invalidate_begin().
> 
> Also instead of sending signal multiple times, we can utilize lsb argument.

As Vishal pointed out, this code shouldn't be sending signals in the first place.
