Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A0A7AA1DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjIUVHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjIUVFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:05:39 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1D26DE01
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:32:34 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-690a0ec0be4so1147314b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695317554; x=1695922354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFujV55InQpfIcmwhWIdcFo9LOSK6bP3ULKilR3pEPA=;
        b=CRrY5DH6PB4BwXaEGzcHDlcir4MD72Km3WSYqM2eWTj93A1wQ1C6wh8A0S9dz1YXGI
         8JTJSzUPgq9gB8WJQ2650xRU4IODoJA9ttmV6GFotUyD0AKY9VjieSr9nYp3IvysXnvg
         DjW09svO/Iktgs4Biyc9eMa+lhhUDuHftnK2ncYtQf/72FiZV9inILs5mLFteZqO756F
         GKYCopYONuRUazKxfRBeTIsHjIa3nOCEPZ+IgOGq+tSCHAg45ATbTikShguve6C0EayE
         O9mrQGTlA30G2YuN8lwYG0zPVqwAaVdhWJ8VJWzITm7a6IhBBnfMvVuISW1yS8yy0XCE
         fVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317554; x=1695922354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFujV55InQpfIcmwhWIdcFo9LOSK6bP3ULKilR3pEPA=;
        b=oV/l5Lsk7CI/GlYWimyvlRfOj15gw3TwFpVccE3a6eECzvNqPP27cZ0Dcp0YJcLxNZ
         jsx/hB0rxPJrjUXijCROC/82X2+OjmP5PibftnPLqZ8ISmSGrmt02hyq+ndWDMQ3btJ3
         pQNp/UmxQbbry6njikdBT/9Q7DvZGv7kn9+fuITV1MpJ3bTzRNmlSJaa6oYp6iBSjtTG
         UMNvyxkm0G/hQ0ooTEj0uXcxuHUHSN3yZgDi3CXBxwQ5Rmi/kKb/u7d6eNSCpr3Fu6xU
         /jXGSC4vC56eJ29KPpH02TFIHsQijVvWZPiyZvC7Qxm4EFxpGcDGW6Z0nwNYG5l23wzw
         BEoA==
X-Gm-Message-State: AOJu0YyVIYsewoVD8Lx3fg80IsuYRGSHN+cg0SHSyYlxqMtxbGBiPw9V
        cqnV6iSVUdZXqEZM2lxWCcO373Kiiso=
X-Google-Smtp-Source: AGHT+IGn6bxt0aytyfRrQvdNGXaSXeT8sIcIptWMB2qfEas65NY2TcrLdWuDyigFBOjNZ28AUG3erUeC33s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ce86:b0:1c3:c127:558 with SMTP id
 f6-20020a170902ce8600b001c3c1270558mr71199plg.0.1695306271120; Thu, 21 Sep
 2023 07:24:31 -0700 (PDT)
Date:   Thu, 21 Sep 2023 07:24:29 -0700
In-Reply-To: <ZQus1v3AvEZjuat9@yilunxu-OptiPlex-7050>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-3-seanjc@google.com>
 <ZQqMBEL61p739dpF@yilunxu-OptiPlex-7050> <ZQr5uXhV6Cnx4DYT@google.com> <ZQus1v3AvEZjuat9@yilunxu-OptiPlex-7050>
Message-ID: <ZQxSHXIGdWXy+zDU@google.com>
Subject: Re: [RFC PATCH v12 02/33] KVM: Use gfn instead of hva for mmu_notifier_retry
From:   Sean Christopherson <seanjc@google.com>
To:     Xu Yilun <yilun.xu@intel.com>
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
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
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
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023, Xu Yilun wrote:
> When the invalidation acrosses multiple slots, I'm not sure if the
> contiguous HVA range must correspond to contiguous GFN range. If not,
> are we producing a larger range than required?

Multiple invalidations are all but guaranteed to yield a range that covers addresses
that aren't actually being invalidated.  This is true today.

> And when the invalidation acrosses multiple address space, I'm almost
> sure it is wrong to merge GFN ranges from different address spaces. 

It's not "wrong" in the sense that false positives do not cause functional
problems, at worst a false positive can unnecessarily stall a vCPU until the
unrelated invalidations complete.

Multiple concurrent invalidations are not common, and if they do happen, they are
likely related and will have spacial locality in both host virtual address space
and guest physical address space.  Given that, we chose for the simple (and fast!)
approach of maintaining a single all-encompassing range.
