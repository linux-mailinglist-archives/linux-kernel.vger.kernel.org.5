Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342C27E1F29
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjKFLDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjKFLDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:03:20 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C701C6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 03:03:17 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-672096e0e89so28253746d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 03:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699268596; x=1699873396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KU+b2mECXXvQ5slHB7/YEPM4eq1YPpk0J5Rl/yZ7AP8=;
        b=gPnY9VQ5ux3WodG09bnggGbMNCn/5I95R1UQmFsMf/bKsbXoc/QSaB20dnAkMrnEbd
         HN+IkAuGXXiyDw3HF8T9ceKfj0xHwar5NDQHmDkmYd726EBC2uL1P1SeyG1sSwlnfZ/u
         tcntB7xS1L9Fed0nzTGayk8h6OMjfDgwAOoiCwfdTdQqlMVJxSg57jfhklE6slN2IJg6
         1B/cnKd8cozSja5f8vgFwgTIHF0HnOyhfctEOFSvWp7JSkBgKzWbYoHEAoGM72m5KNSy
         a2QT43u3S5eYY0dZxAZlCY51R1wD8A3CIf6KcHfeGrv1yY375DZcNPKD03n0SQCm/RE9
         hZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699268596; x=1699873396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KU+b2mECXXvQ5slHB7/YEPM4eq1YPpk0J5Rl/yZ7AP8=;
        b=Ok7h65bqSD1Xo1nM+b1njvptjfzuYR9C6L/1jWmJoo71XwH/pShVHMlY1mcxQNB+Tn
         TXcS0rgpS3pCZTqYKQGvRUDQPEsGr1X+/Sp1ZRUWNM2kRwhAfa9Y5GYt4ndM5os++LAX
         yVNVF5i0mLumjF6zNrwS/reHtmDY5IanTM7HnHripaFw8+GpMqpWrg2WoMl5SLqj27qo
         CFN4g2+lLdYImNfYdVObzG1FAAjDaWX8A/VXbjHnGbPmDVhCuQtq+6YFCLhvoQnldRMA
         u68X8ch2sDF3lHZMEw2fG49TdB1XafUhI6EGUMVT3T9ts0U5oM7IzNmygnr2n/1Fbuj3
         0LOw==
X-Gm-Message-State: AOJu0YzvddR3ku7uO01J1dUX6CUhHdB4j6RCjIaAZgVVwDtCekNm391I
        M0oI1oqAdAFEdsn/Nlldr0ImPHTo8cJvbp9i6cAGEQ==
X-Google-Smtp-Source: AGHT+IH064K0ZtIRC0Ddcf2wpRdR9qcn5N+rpiGlH1rS/nMIj84KwquVAyvAa55WjBkBZ58J/DOu2Zh9h49soweI3jk=
X-Received: by 2002:a05:6214:2582:b0:671:3493:61e8 with SMTP id
 fq2-20020a056214258200b00671349361e8mr28685929qvb.26.1699268596310; Mon, 06
 Nov 2023 03:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-23-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-23-pbonzini@redhat.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 6 Nov 2023 11:02:40 +0000
Message-ID: <CA+EHjTwB-jssz7+8ZiLgXdQREp8U3r3tYN2NOH28g54=QNdQmg@mail.gmail.com>
Subject: Re: [PATCH 22/34] KVM: selftests: Drop unused kvm_userspace_memory_region_find()
 helper
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
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
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Nov 5, 2023 at 4:33=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Drop kvm_userspace_memory_region_find(), it's unused and a terrible API
> (probably why it's unused).  If anything outside of kvm_util.c needs to
> get at the memslot, userspace_mem_region_find() can be exposed to give
> others full access to all memory region/slot information.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-Id: <20231027182217.3615211-25-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  .../selftests/kvm/include/kvm_util_base.h     |  4 ---
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 29 -------------------
>  2 files changed, 33 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/=
testing/selftests/kvm/include/kvm_util_base.h
> index a18db6a7b3cf..967eaaeacd75 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -776,10 +776,6 @@ vm_adjust_num_guest_pages(enum vm_guest_mode mode, u=
nsigned int num_guest_pages)
>         return n;
>  }
>
> -struct kvm_userspace_memory_region *
> -kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
> -                                uint64_t end);
> -
>  #define sync_global_to_guest(vm, g) ({                         \
>         typeof(g) *_p =3D addr_gva2hva(vm, (vm_vaddr_t)&(g));     \
>         memcpy(_p, &(g), sizeof(g));                            \
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/s=
elftests/kvm/lib/kvm_util.c
> index 7a8af1821f5d..f09295d56c23 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -590,35 +590,6 @@ userspace_mem_region_find(struct kvm_vm *vm, uint64_=
t start, uint64_t end)
>         return NULL;
>  }
>
> -/*
> - * KVM Userspace Memory Region Find
> - *
> - * Input Args:
> - *   vm - Virtual Machine
> - *   start - Starting VM physical address
> - *   end - Ending VM physical address, inclusive.
> - *
> - * Output Args: None
> - *
> - * Return:
> - *   Pointer to overlapping region, NULL if no such region.
> - *
> - * Public interface to userspace_mem_region_find. Allows tests to look u=
p
> - * the memslot datastructure for a given range of guest physical memory.
> - */
> -struct kvm_userspace_memory_region *
> -kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
> -                                uint64_t end)
> -{
> -       struct userspace_mem_region *region;
> -
> -       region =3D userspace_mem_region_find(vm, start, end);
> -       if (!region)
> -               return NULL;
> -
> -       return &region->region;
> -}
> -
>  __weak void vcpu_arch_free(struct kvm_vcpu *vcpu)
>  {
>
> --
> 2.39.1
>
>
