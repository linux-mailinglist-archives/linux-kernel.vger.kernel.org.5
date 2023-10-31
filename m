Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076207DCF29
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343741AbjJaOQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343636AbjJaOQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:16:20 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE077F7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:16:17 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc1ddb34ccso31626065ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698761777; x=1699366577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+SCWDVcx1K76tZHWI6JguONJ6NnGeKLP7+QbYfrb3Rs=;
        b=3LTiG76GVOEc8lRq/TWhVMCBV8LuspBYlB/0ZIqRRak+sx2n46riS4bQtfSIk4aJnK
         ntUUHuodNmr6cOqafV7BjMw8U5tKd+L0HzhZeZsO1dOTZIcaN83bqsc5u0PJrHIXnUdH
         APf4M1tVvArfQk9bmox4Dgl8MvFDpXVQpuSqG1VX6yeO5/kYbwCjbCcT78UghJs4YwnI
         GPr3vgcKx3TG8dDPsz4v7hYyYBhF9AX1XGKsRyoQ1D8y2xbDFp/W/DVu5jXfFLA15Joz
         bGeQrIXuFRBDriN1OItvIqOh0QyQ3CMm62EVBPD98LhSaU/AWmprxKRG1r3hTvx/H04n
         o+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698761777; x=1699366577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+SCWDVcx1K76tZHWI6JguONJ6NnGeKLP7+QbYfrb3Rs=;
        b=AgcaeTFY0F/tkoSqCCPqJ0xWbh+qiceODeWlDEHQqKwqITV8Glc3Jw9uU8EiHzMxX3
         OhbSnx4PftAYjrhcmgGEbEQYADU5rS1MWI2SVhukGdiMOQynkFD9CPqmnZkfW82U4fLO
         GSUTuHpXTtlwawWxtULxIHweH/LKlsJz+0alvOshz2VGVpk7LBxtDjqbf3OyanwfZBoP
         xBJC7hERaD2GqV+35n6Afy6JB0pSLOfWggRp7mlPI5L+j5l7uwrS1FPeLOfEZj07tzXM
         PUopk7uhqVvcjyJIAy7L5DwFY9uOAonNaURxjfpgrOEeU/auiZQSD2Sc2T6m70vbXYVC
         JRGg==
X-Gm-Message-State: AOJu0Yx7ovWp3pkAq4mibhQEiSLyIw1FnINyNejM34qUJHmy/k1q9n8+
        sf2eSLAXgD51wh6CPm4IVfqOh7tJPfY=
X-Google-Smtp-Source: AGHT+IG8tFKfIuO6cbI6ukftnUzYB8muWE8fOHZgWpajrHJaT+RkL+zDaTOo8ZNIlEatfvapWXD9jFRr58g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2616:b0:1cc:2549:c281 with SMTP id
 jd22-20020a170903261600b001cc2549c281mr206233plb.13.1698761777291; Tue, 31
 Oct 2023 07:16:17 -0700 (PDT)
Date:   Tue, 31 Oct 2023 07:16:15 -0700
In-Reply-To: <7c0844d8-6f97-4904-a140-abeabeb552c1@intel.com>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-18-seanjc@google.com>
 <7c0844d8-6f97-4904-a140-abeabeb552c1@intel.com>
Message-ID: <ZUEML6oJXDCFJ9fg@google.com>
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023, Xiaoyao Li wrote:
> On 10/28/2023 2:21 AM, Sean Christopherson wrote:
> > Extended guest_memfd to allow backing guest memory with transparent
> > hugepages. Require userspace to opt-in via a flag even though there's no
> > known/anticipated use case for forcing small pages as THP is optional,
> > i.e. to avoid ending up in a situation where userspace is unaware that
> > KVM can't provide hugepages.
> 
> Personally, it seems not so "transparent" if requiring userspace to opt-in.
> 
> People need to 1) check if the kernel built with TRANSPARENT_HUGEPAGE
> support, or check is the sysfs of transparent hugepage exists; 2)get the
> maximum support hugepage size 3) ensure the size satisfies the alignment;
> before opt-in it.
> 
> Even simpler, userspace can blindly try to create guest memfd with
> transparent hugapage flag. If getting error, fallback to create without the
> transparent hugepage flag.
> 
> However, it doesn't look transparent to me.

The "transparent" part is referring to the underlying kernel mechanism, it's not
saying anything about the API.  The "transparent" part of THP is that the kernel
doesn't guarantee hugepages, i.e. whether or not hugepages are actually used is
(mostly) transparent to userspace.

Paolo also isn't the biggest fan[*], but there are also downsides to always
allowing hugepages, e.g. silent failure due to lack of THP or unaligned size,
and there's precedent in the form of MADV_HUGEPAGE.

[*] https://lore.kernel.org/all/84a908ae-04c7-51c7-c9a8-119e1933a189@redhat.com
