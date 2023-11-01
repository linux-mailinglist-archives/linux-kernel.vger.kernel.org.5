Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29087DE210
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjKANlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjKANlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:41:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82267F7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:41:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b02ed0f886so61967927b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 06:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698846106; x=1699450906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nFf6aEaGwk5ej5JezQy0IgMN87WPAcTCXufwbiE3fug=;
        b=R2O+hzqrfXKjpVkCK7WWKNStZqPyF2cdxKhoLb11/ctjZo5ZPSp0q11vTaRIMqKh+G
         rTGHEntcK74whLXVzkwTEfg4kXFGvDFoyHYkdR0w4NkG++ha3FYomi7HyzXNxjoxUIK2
         kcKweF9pJ+NEs74UZBMULXVN7G7SWL8wASy0+pNCqSNNPT1zkqvQfLHK78Y20NUzPNkc
         zAZ09oqc5lZHgiYL4DmQPGFbydmLOB6LzfwncWQjpui3CcXu6Wc1sVfHimGhI82PhfIb
         /7xN434TnAp+9QvKT0AHhWkz3sCvRmyo2aHZIig6PpsFsT18SvRKUf81x8cwxHJJ0j8r
         nrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698846106; x=1699450906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFf6aEaGwk5ej5JezQy0IgMN87WPAcTCXufwbiE3fug=;
        b=XQpGq+WESPYhqiiCQyjLetE0/zokhdT9tZuTtDb14WsDcnB8h3wbiwNT4KiHU0bl49
         kVQ9ahZdPnVvYtPO9UmRf1hFA3UHwJp0VTU3ljgfPjZJtdEN2zUIE4gcvd56cvuNBPgN
         8IP0jxx0IeTJHSD2BXHVzr/m1XCPiRvBHzHgrMVprTGjEm2fnISWHpg3O1p5IKjBHEUr
         EoNjRxnJRfaBovHpHEvPqI1ZxaApyXUJ8CTUOLEiOMntRBpzXh6ZzSiEMgDCG/u2608u
         9qwnNaY9xFUSMO/krIAhfynO+YQudNoDv9qTsiwLgRiuCTdFf/uMkL+JUD5zNRows+Zk
         d22A==
X-Gm-Message-State: AOJu0YyMOiPWveUqbTKIhxlDgF0MIdk7SGZz0AWxVRD+P4NkEOALVN80
        bi2ap7KVZjYhZiIgh7SzpUjRa8kAoKk=
X-Google-Smtp-Source: AGHT+IEsRM1yQnQClQeVqyoNLxT9cYgRny7PWezkHcY0wXTm/cdeLyJgnrb+5OZENHYJQKvQlFBt8yx8E+I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:e689:0:b0:5a7:bfcf:2cb8 with SMTP id
 p131-20020a0de689000000b005a7bfcf2cb8mr314827ywe.1.1698846106686; Wed, 01 Nov
 2023 06:41:46 -0700 (PDT)
Date:   Wed, 1 Nov 2023 06:41:45 -0700
In-Reply-To: <92ba7ddd-2bc8-4a8d-bd67-d6614b21914f@intel.com>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-18-seanjc@google.com>
 <7c0844d8-6f97-4904-a140-abeabeb552c1@intel.com> <ZUEML6oJXDCFJ9fg@google.com>
 <92ba7ddd-2bc8-4a8d-bd67-d6614b21914f@intel.com>
Message-ID: <ZUJVfCkIYYFp5VwG@google.com>
Subject: Re: [PATCH v13 17/35] KVM: Add transparent hugepage support for
 dedicated guest memory
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
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
        linux-kernel@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023, Xiaoyao Li wrote:
> On 10/31/2023 10:16 PM, Sean Christopherson wrote:
> > On Tue, Oct 31, 2023, Xiaoyao Li wrote:
> > > On 10/28/2023 2:21 AM, Sean Christopherson wrote:
> > > > Extended guest_memfd to allow backing guest memory with transparent
> > > > hugepages. Require userspace to opt-in via a flag even though there's no
> > > > known/anticipated use case for forcing small pages as THP is optional,
> > > > i.e. to avoid ending up in a situation where userspace is unaware that
> > > > KVM can't provide hugepages.
> > > 
> > > Personally, it seems not so "transparent" if requiring userspace to opt-in.
> > > 
> > > People need to 1) check if the kernel built with TRANSPARENT_HUGEPAGE
> > > support, or check is the sysfs of transparent hugepage exists; 2)get the
> > > maximum support hugepage size 3) ensure the size satisfies the alignment;
> > > before opt-in it.
> > > 
> > > Even simpler, userspace can blindly try to create guest memfd with
> > > transparent hugapage flag. If getting error, fallback to create without the
> > > transparent hugepage flag.
> > > 
> > > However, it doesn't look transparent to me.
> > 
> > The "transparent" part is referring to the underlying kernel mechanism, it's not
> > saying anything about the API.  The "transparent" part of THP is that the kernel
> > doesn't guarantee hugepages, i.e. whether or not hugepages are actually used is
> > (mostly) transparent to userspace.
> > 
> > Paolo also isn't the biggest fan[*], but there are also downsides to always
> > allowing hugepages, e.g. silent failure due to lack of THP or unaligned size,
> > and there's precedent in the form of MADV_HUGEPAGE.
> > 
> > [*] https://lore.kernel.org/all/84a908ae-04c7-51c7-c9a8-119e1933a189@redhat.com
> 
> But it's different than MADV_HUGEPAGE, in a way. Per my understanding, the
> failure of MADV_HUGEPAGE is not fatal, user space can ignore it and
> continue.
>
> However, the failure of KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is fatal, which leads
> to failure of guest memfd creation.

Failing KVM_CREATE_GUEST_MEMFD isn't truly fatal, it just requires different
action from userspace, i.e. instead of ignoring the error, userspace could redo
KVM_CREATE_GUEST_MEMFD with KVM_GUEST_MEMFD_ALLOW_HUGEPAGE=0.

We could make the behavior more like MADV_HUGEPAGE, e.g. theoretically we could
extend fadvise() with FADV_HUGEPAGE, or add a guest_memfd knob/ioctl() to let
userspace provide advice/hints after creating a guest_memfd.  But I suspect that
guest_memfd would be the only user of FADV_HUGEPAGE, and IMO a post-creation hint
is actually less desirable.

KVM_GUEST_MEMFD_ALLOW_HUGEPAGE will fail only if userspace didn't provide a
compatible size or the kernel doesn't support THP.  An incompatible size is likely
a userspace bug, and for most setups that want to utilize guest_memfd, lack of THP
support is likely a configuration bug.  I.e. many/most uses *want* failures due to
KVM_GUEST_MEMFD_ALLOW_HUGEPAGE to be fatal.

> For current implementation, I think maybe KVM_GUEST_MEMFD_DESIRE_HUGEPAGE
> fits better than KVM_GUEST_MEMFD_ALLOW_HUGEPAGE? or maybe *PREFER*?

Why?  Verbs like "prefer" and "desire" aren't a good fit IMO because they suggest
the flag is a hint, and hints are usually best effort only, i.e. are ignored if
there is a fundamental incompatibility.

"Allow" isn't perfect, e.g. I would much prefer a straight KVM_GUEST_MEMFD_USE_HUGEPAGES
or KVM_GUEST_MEMFD_HUGEPAGES flag, but I wanted the name to convey that KVM doesn't
(yet) guarantee hugepages.  I.e. KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is stronger than
a hint, but weaker than a requirement.  And if/when KVM supports a dedicated memory
pool of some kind, then we can add KVM_GUEST_MEMFD_REQUIRE_HUGEPAGE.
