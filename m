Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E47DE7B9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjKAVzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjKAVzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:55:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275AD125
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:55:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da033914f7cso315870276.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698875748; x=1699480548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PcqXHpLnYUoCfOstmB/gusaSnz1wSaaIZvticgi9YrM=;
        b=yordn67/B9coJ27wikY+cNB1RREF7cB4b3Ue4KVs4bUxR7NMszr2uB6DsTcvRFezm4
         Mv9vIV4D1zL7Ebq8eYUvDJaTsA+b6DbfwYGOyfYZ+gn6JBg2zh32vssNDt0PgQWyi3Hc
         V30xoKLPHpSqs3H12W5kHbw59Cp3oq89IhbOXGRukrdOHcIips6mw6fvttACqcV26Iao
         o3OJKk/xvzHC16DLzD0pyWC3byA8iAor+alj9Jl/Ez2piZBXn5OAsYe77vVBVgD3KaOP
         Uo0at9aIB4srFmOFz36vXvyhDqsKT+KVB/6JAS3Kq2OtaQ1RroksSDGcgJr8iz7Y9trj
         xkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698875748; x=1699480548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcqXHpLnYUoCfOstmB/gusaSnz1wSaaIZvticgi9YrM=;
        b=WZGaDetqEicFnkQ5GkckZ1dCqMHmSbafYzFKJI7RuQbiBgvFMQnPFMs9bcTxnIwjg3
         GYYoq+smNu9l9Mmd/4sBRzAzusLGJoKNgMuQjaS/fgYhxY5qJViXz1vkHbAKkkqGpRxb
         dZgtCkrNjMSxMjBjQLfOC8LeHis0tZJ1/ia05eOEY56Oo1Q6ITmeS75CHi+LF6hgFY6O
         WP0ByBzm1/5wBI1zEg6YqQBGp0eG9dMka8jKG64wsmQSHtBq2WcpdGCGtoomkWgIS6aW
         pJ7KzypS9F89Rx9b/uGt2XHyqS1ReJVeSdCzSjjgMv+/Kja913w2WcKbglpTgTOoi4Bz
         ZhXA==
X-Gm-Message-State: AOJu0YwojN7UfsE5KcYxcoVOv/AYdFuJ5qibsilSZDMmuLUN38VWocss
        DFEB2HCy+Ep+ViOPsJcJDIUgjMJ7ugg=
X-Google-Smtp-Source: AGHT+IE2sMY2tsOG0bVHgm+pvNoyezNqlGkOo8OmSBoeRdI+YDBZP5bgBr5ffHZ4bVc102IwBIrDYpGpUa8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP id
 v3-20020a056902108300b00d9ac3b84274mr405001ybu.7.1698875748263; Wed, 01 Nov
 2023 14:55:48 -0700 (PDT)
Date:   Wed, 1 Nov 2023 14:55:46 -0700
In-Reply-To: <CA+EHjTwTT9cFzYTtwT43nLJS01Sgt0NqzUgKAnfo2fiV3tEvXg@mail.gmail.com>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-17-seanjc@google.com>
 <CA+EHjTzj4drYKONVOLP19DYpJ4O8kSXcFzw2AKier1QdcFKx_Q@mail.gmail.com>
 <ZUF8A5KpwpA6IKUH@google.com> <CA+EHjTwTT9cFzYTtwT43nLJS01Sgt0NqzUgKAnfo2fiV3tEvXg@mail.gmail.com>
Message-ID: <ZULJYg5cf1UrNq3e@google.com>
Subject: Re: [PATCH v13 16/35] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Sean Christopherson <seanjc@google.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        David Matlack <dmatlack@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023, Fuad Tabba wrote:
> > > > @@ -1034,6 +1034,9 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
> > > >  /* This does not remove the slot from struct kvm_memslots data structures */
> > > >  static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
> > > >  {
> > > > +       if (slot->flags & KVM_MEM_PRIVATE)
> > > > +               kvm_gmem_unbind(slot);
> > > > +
> > >
> > > Should this be called after kvm_arch_free_memslot()? Arch-specific ode
> > > might need some of the data before the unbinding, something I thought
> > > might be necessary at one point for the pKVM port when deleting a
> > > memslot, but realized later that kvm_invalidate_memslot() ->
> > > kvm_arch_guest_memory_reclaimed() was the more logical place for it.
> > > Also, since that seems to be the pattern for arch-specific handlers in
> > > KVM.
> >
> > Maybe?  But only if we can about symmetry between the allocation and free paths
> > I really don't think kvm_arch_free_memslot() should be doing anything beyond a
> > "pure" free.  E.g. kvm_arch_free_memslot() is also called after moving a memslot,
> > which hopefully we never actually have to allow for guest_memfd, but any code in
> > kvm_arch_free_memslot() would bring about "what if" questions regarding memslot
> > movement.  I.e. the API is intended to be a "free arch metadata associated with
> > the memslot".
> >
> > Out of curiosity, what does pKVM need to do at kvm_arch_guest_memory_reclaimed()?
> 
> It's about the host reclaiming ownership of guest memory when tearing
> down a protected guest. In pKVM, we currently teardown the guest and
> reclaim its memory when kvm_arch_destroy_vm() is called. The problem
> with guestmem is that kvm_gmem_unbind() could get called before that
> happens, after which the host might try to access the unbound guest
> memory. Since the host hasn't reclaimed ownership of the guest memory
> from hyp, hilarity ensues (it crashes).
> 
> Initially, I hooked reclaim guest memory to kvm_free_memslot(), but
> then I needed to move the unbind later in the function. I realized
> later that kvm_arch_guest_memory_reclaimed() gets called earlier (at
> the right time), and is more aptly named.

Aha!  I suspected that might be the case.

TDX and SNP also need to solve the same problem of "reclaiming" memory before it
can be safely accessed by the host.  The plan is to add an arch hook (or two?)
into guest_memfd that is invoked when memory is freed from guest_memfd.

Hooking kvm_arch_guest_memory_reclaimed() isn't completely correct as deleting a
memslot doesn't *guarantee* that guest memory is actually reclaimed (which reminds
me, we need to figure out a better name for that thing before introducing
kvm_arch_gmem_invalidate()).

The effective false positives aren't fatal for the current usage because the hook
is used only for x86 SEV guests to flush caches.  An unnecessary flush can cause
performance issues, but it doesn't affect correctness. For TDX and SNP, and IIUC
pKVM, false positives are fatal because KVM could assign memory back to the host
that is still owned by guest_memfd.

E.g. a misbehaving userspace could prematurely delete a memslot.  And the more
fun example is intrahost migration, where the plan is to allow pointing multiple
guest_memfd files at a single guest_memfd inode:
https://lore.kernel.org/all/cover.1691446946.git.ackerleytng@google.com

There was a lot of discussion for this, but it's scattered all over the place.
The TL;DR is is that the inode will represent physical memory, and a file will
represent a given "struct kvm" instance's view of that memory.  And so the memory
isn't reclaimed until the inode is truncated/punched.

I _think_ this reflects the most recent plan from the guest_memfd side:
https://lore.kernel.org/all/1233d749211c08d51f9ca5d427938d47f008af1f.1689893403.git.isaku.yamahata@intel.com
