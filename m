Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B492E7DE13C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343900AbjKAMwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 08:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjKAMwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 08:52:01 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3F7B7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 05:51:56 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-49dd3bb5348so2769735e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698843115; x=1699447915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3o84LhG/JDs4XT09LqOqAL557WR+kTbV5Toac0tgZE=;
        b=v29IL5VyU3B+aIfMrMdmbix8p5RVup/xW4vUd6RBnr33Bu8rfYh4G9v+WM1qpVJypq
         gUqbJSpQOqW37W/djoRJRIkKHZzIrcfejcAVmEP62zMyHDrCtUV8o5xm9kmK0A5uXqpN
         apJ1xeSyhmnijeGDVHeBGftbSrruIvUPi1PhaD+ZY5fJYApRylMJb9TK7eDjeoSvgGgS
         fGgQaVG7lCLuPpTDIcraWrc5yHng2VtxHRAKVcjqPT7wuVWgNcUO2wyZf05wsrfCjkOW
         LFomWquwgrI4aiqOJaMRYMEiqNFRO4P8TGYhaKNN5Qy9bJ5LxbPFHzUI5OiqEo5kfxQy
         2+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698843115; x=1699447915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3o84LhG/JDs4XT09LqOqAL557WR+kTbV5Toac0tgZE=;
        b=ZLsPOo1lFWxlwb5m9FZVLOEeo+NRmU7Pp+E3rEHQOEJg29PbFFGUCjFJUChDunhdK1
         0L5EKID4pZNOMsB44u0rWTk0aM/Z9wm/LutqWXUYEon8nDRCzGgllxXqXJvZs2uOvBwg
         j9G0UOb0n6NQg2caNFOJKVwOqW8KAJAUf68qS07oLJDEmIzW3GhBbkH6yltPp4IJonGE
         fBW1n91jj7s4sBvbS338ef5SzBKvV/0Bx9qM46WaLRLrLTv/G6kVO+GQ9XFjDrvQ3OJG
         DKQtEOEA5xfhevewZnjv/bMDJ+zJDzHHQI0r1GDAW+QGpyRTVVezVK+Zm0WN/4hjnLXC
         oiDw==
X-Gm-Message-State: AOJu0YxjWpzskfFu6pKFddF26wFqoRz+CsZXkeBPsD3bpXGr4RPFf2pE
        0GoYbGd3kgNTWPUz/dGMRAxX7FXF08YRwo6RUY/eIQ==
X-Google-Smtp-Source: AGHT+IF0GS509bXC109Q/KsllvKKbuNv6izlI+nfo857C1iROxiLKrI4wNuuGIZxmkDtH9Saf2Z2BbskHZJDaldFC6s=
X-Received: by 2002:a1f:9b13:0:b0:4a1:7278:3bf5 with SMTP id
 d19-20020a1f9b13000000b004a172783bf5mr13903007vke.4.1698843115068; Wed, 01
 Nov 2023 05:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-6-seanjc@google.com>
In-Reply-To: <20231027182217.3615211-6-seanjc@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Wed, 1 Nov 2023 12:51:19 +0000
Message-ID: <CA+EHjTxq9zBY02bqsThV5+afLY1mGXyfs+X1yiKL0kM8SSz_Ug@mail.gmail.com>
Subject: Re: [PATCH v13 05/35] KVM: PPC: Drop dead code related to KVM_ARCH_WANT_MMU_NOTIFIER
To:     Sean Christopherson <seanjc@google.com>
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 7:22=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Assert that both KVM_ARCH_WANT_MMU_NOTIFIER and CONFIG_MMU_NOTIFIER are
> defined when KVM is enabled, and return '1' unconditionally for the
> CONFIG_KVM_BOOK3S_HV_POSSIBLE=3Dn path.  All flavors of PPC support for K=
VM
> select MMU_NOTIFIER, and KVM_ARCH_WANT_MMU_NOTIFIER is unconditionally
> defined by arch/powerpc/include/asm/kvm_host.h.
>
> Effectively dropping use of KVM_ARCH_WANT_MMU_NOTIFIER will simplify a
> future cleanup to turn KVM_ARCH_WANT_MMU_NOTIFIER into a Kconfig, i.e.
> will allow combining all of the
>
>   #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
>
> checks into a single
>
>   #ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
>
> without having to worry about PPC's "bare" usage of
> KVM_ARCH_WANT_MMU_NOTIFIER.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  arch/powerpc/kvm/powerpc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 7197c8256668..b0a512ede764 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -632,12 +632,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>                 break;
>  #endif
>         case KVM_CAP_SYNC_MMU:
> +#if !defined(CONFIG_MMU_NOTIFIER) || !defined(KVM_ARCH_WANT_MMU_NOTIFIER=
)
> +               BUILD_BUG();
> +#endif
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>                 r =3D hv_enabled;
> -#elif defined(KVM_ARCH_WANT_MMU_NOTIFIER)
> -               r =3D 1;
>  #else
> -               r =3D 0;
> +               r =3D 1;
>  #endif
>                 break;
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> --
> 2.42.0.820.g83a721a137-goog
>
