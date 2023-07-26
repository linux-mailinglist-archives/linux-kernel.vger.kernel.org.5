Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803CD763900
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbjGZOZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjGZOZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:25:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C59171E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:25:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-583fe0f84a5so35465317b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690381501; x=1690986301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mt8/YY3u8LjsBjr8d6/ke2ZW25YHueLUKLJjDJYMc8s=;
        b=KwMaCkiB4xAqGBUh9OF2kV0ZTXZJ9t/BQNvELYTboh2nFXRCb/O6mzI5Rf4+JkOSUf
         GbfKDvzjuzeoTYk+8UzFDnEFGCf4Xp/4j132VlBFiOap0dqwF0d+IWavL7GkLuWIPxaf
         FtFh1NcigPTHGOQymzspNYZcGJWMeYjGrAKFBYQg3vkICZKAIWBqnifvNeqq77Udkh7Z
         xGehHXpHV6lJVR2/PB6tUzMEDhiwA5lq38Ga3ndr8/43j3+UY7kRIeUxbAwefFFreB6b
         OU07H0FnfDMXq+of8q/ygEkV9SZmVl7edMM6TzYoGxGd/1xqW6Xr5wUrtaTzZVCwe9dk
         Dlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381501; x=1690986301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mt8/YY3u8LjsBjr8d6/ke2ZW25YHueLUKLJjDJYMc8s=;
        b=WRAtpfnB7Ood0fpb80J3HwU/66kHJ7Y2aibAz0yQM9nQB+RuWOZYVQ9ZlzFN5qYVEK
         BcOow5lplU+p5+5y4WEZNsfrp7RI2r5GWIjQQLsoW30q4Vg4AlD8IWhLKBwpSqc/6ox7
         txHyzTBIQ/pOXWqugMBhUTD4QyFTFIaA7GsJuTU6s045vwDpfYkqpw79askYRa+K1gLs
         fBDqNmITO4GnsY3JMs6XJyGOzaPFjvIVsk1n4nUyd4l7y1t0BJ9/efjk/TnfnXN0jD+t
         qfb+W7wU1ezwKaw3mO9HBcTJLdcYmaiueQsStBAyZV2A/+ligfY+/J/wZkPdN0nwbwXi
         s60w==
X-Gm-Message-State: ABy/qLZe4fvs40gMv0Ub1i3zUYpCZk6XlJogYA5Cnv5xHUaDEDNeUk/N
        pTmxyAqd5HdkgDbr+i/cLi30qUyy9q0=
X-Google-Smtp-Source: APBJJlHpunM1lrfEfJpa6UtG2AaqQE17ubaKuYzputooU8ueGDVFO/y80053uMgFIUrJA+dTGv8yhoGEgv0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ac60:0:b0:576:de5f:95e1 with SMTP id
 z32-20020a81ac60000000b00576de5f95e1mr20181ywj.1.1690381501073; Wed, 26 Jul
 2023 07:25:01 -0700 (PDT)
Date:   Wed, 26 Jul 2023 07:24:59 -0700
In-Reply-To: <2f98a32c-bd3d-4890-b757-4d2f67a3b1a7@amd.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <110f1aa0-7fcd-1287-701a-89c2203f0ac2@amd.com>
 <ZL6uMk/8UeuGj8CP@google.com> <2f98a32c-bd3d-4890-b757-4d2f67a3b1a7@amd.com>
Message-ID: <ZMEsuyqHhp1DAVdR@google.com>
Subject: Re: [RFC PATCH v11 00/29] KVM: guest_memfd() and per-page attributes
From:   Sean Christopherson <seanjc@google.com>
To:     "Nikunj A. Dadhania" <nikunj@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
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

On Wed, Jul 26, 2023, Nikunj A. Dadhania wrote:
> Hi Sean,
> 
> On 7/24/2023 10:30 PM, Sean Christopherson wrote:
> >>   Starting an SNP guest with 40G memory with memory interleave between
> >>   Node2 and Node3
> >>
> >>   $ numactl -i 2,3 ./bootg_snp.sh
> >>
> >>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> >>  242179 root      20   0   40.4g  99580  51676 S  78.0   0.0   0:56.58 qemu-system-x86
> >>
> >>   -> Incorrect process resident memory and shared memory is reported
> > 
> > I don't know that I would call these "incorrect".  Shared memory definitely is
> > correct, because by definition guest_memfd isn't shared.  RSS is less clear cut;
> > gmem memory is resident in RAM, but if we show gmem in RSS then we'll end up with
> > scenarios where RSS > VIRT, which will be quite confusing for unaware users (I'm
> > assuming the 40g of VIRT here comes from QEMU mapping the shared half of gmem
> > memslots).
> 
> I am not sure why will RSS exceed the VIRT, it should be at max 40G (assuming all the
> memory is private)

And also assuming that (a) userspace mmap()'d the shared side of things 1:1 with
private memory and (b) that the shared mappings have not been populated.   Those
assumptions will mostly probably hold true for QEMU, but kernel correctness
shouldn't depend on assumptions about one specific userspace application.

> >>   /proc/<qemu pid>/smaps
> >>   7f528be00000-7f5c8be00000 rw-p 00000000 00:01 26629                      /memfd:memory-backend-memfd-shared (deleted)
> >>   7f5c90200000-7f5c90220000 rw-s 00000000 00:01 44033                      /memfd:rom-backend-memfd-shared (deleted)
> >>   7f5c90400000-7f5c90420000 rw-s 00000000 00:01 44032                      /memfd:rom-backend-memfd-shared (deleted)
> >>   7f5c90800000-7f5c90b7c000 rw-s 00000000 00:01 1025                       /memfd:rom-backend-memfd-shared (deleted)
> > 
> > This is all expected, and IMO correct.  There are no userspace mappings, and so
> > not accounting anything is working as intended.
> Doesn't sound that correct, if 10 SNP guests are running each using 10GB, how
> would we know who is using 100GB of memory?

It's correct with respect to what the interfaces show, which is how much memory
is *mapped* into userspace.

As I said (or at least tried to say) in my first reply, I am not against exposing
memory usage to userspace via stats, only that it's not obvious to me that the
existing VMA-based stats are the most appropriate way to surface this information.
