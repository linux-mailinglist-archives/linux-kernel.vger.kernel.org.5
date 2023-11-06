Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B257E2040
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjKFLo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFLo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:44:56 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6850B90
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 03:44:53 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a822f96aedso52096927b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 03:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699271092; x=1699875892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DX7ek6JbnQBP3kmz+KR8GNUYI0kM1PtX+UUHfn3vax8=;
        b=VNbdkXhidZPy2jyspbi+mWrdtQTAWbWJMGSXLu11+BoTws5mX97/h8fnfNA2YHtR5S
         pnSp6VIcooBGySQ96XECwJsRn8RkrAcwbf3JvjIjxo64IBBjH/0Zu9xnHEBEONaYyOLj
         vYNm4iuT6bI/bFTiOGU7PSeQbSxO6+teJD5HvjyRtsnE8XVrbM/dzsrEr3Wpj8dvrZJk
         xFnBnhx+hcTEr4GABAKg8/+16QKYDcjnPmmWrFTXhEpt52YBY12duJbTG+Fve8R7qKlr
         cLgqhf062bF0xiH5sfOKCGAkieIs5cLBUFyjGkEBC/yUPlx0auzSTpJa1FXbpwwTqgB9
         pbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699271092; x=1699875892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DX7ek6JbnQBP3kmz+KR8GNUYI0kM1PtX+UUHfn3vax8=;
        b=Lt2KLFrAZ62kLNuZlI0uqaHYr8ehC0aRPbeXlnh5Bxbtl1M8mwPixE9Am7uJAfOLGG
         P7HPpoKjb35mFg6vKUfPbwMkOut9FlQSHn3SFhBAnH7u2y0d2E8WSdyoTDAia8PPT9jO
         A+jaxUb0EUfZmLFYQKYBsQAYTCeVKw2njYu/8lUP0kHv5AVxv9iEuddte5NGNA7M5OHl
         dYp8gEDAKB8WMvQnFsLJ6lAZ/aPiNRYrLNWJB7Z95ViVAaSySpf5GtUIwu2IPNXYgohi
         u3/Wvfkrof3rstVhJyzb679ediJCySh9poE5OOCo0f92ze6db/lHVMNpOHFx+HJ2mvfD
         Hm+A==
X-Gm-Message-State: AOJu0YxAElcO56imleBUvkp7nb1CCwnMD8HqakFHLOlv0DH5RgXeX2B3
        lWkKoPoZkFWmB87cwcYA9Om/HQJgYsuw7pX7Ax7N3g==
X-Google-Smtp-Source: AGHT+IERnN25ZpQWhSoveHYhjH1bHINt0TuAVLiTz7wZcF5ueihZgXoSAZV3dV6i7b/f23cd983VPNMQFTyQCDpDsN0=
X-Received: by 2002:a0d:ccc5:0:b0:5a7:e4fe:ea3 with SMTP id
 o188-20020a0dccc5000000b005a7e4fe0ea3mr10768851ywd.22.1699271092440; Mon, 06
 Nov 2023 03:44:52 -0800 (PST)
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-27-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-27-pbonzini@redhat.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 6 Nov 2023 11:44:16 +0000
Message-ID: <CA+EHjTymGLsfHvdP4fPOFWTtaRwbtbCOBZ0XOC3gsX+nYm-cZQ@mail.gmail.com>
Subject: Re: [PATCH 26/34] KVM: selftests: Add helpers to do
 KVM_HC_MAP_GPA_RANGE hypercalls (x86)
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 5, 2023 at 4:34=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> From: Vishal Annapurve <vannapurve@google.com>
>
> Add helpers for x86 guests to invoke the KVM_HC_MAP_GPA_RANGE hypercall,
> which KVM will forward to userspace and thus can be used by tests to
> coordinate private<=3D>shared conversions between host userspace code and
> guest code.
>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> [sean: drop shared/private helpers (let tests specify flags)]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-Id: <20231027182217.3615211-29-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  .../selftests/kvm/include/x86_64/processor.h      | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/too=
ls/testing/selftests/kvm/include/x86_64/processor.h
> index 25bc61dac5fb..a84863503fcb 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -15,6 +15,7 @@
>  #include <asm/msr-index.h>
>  #include <asm/prctl.h>
>
> +#include <linux/kvm_para.h>
>  #include <linux/stringify.h>
>
>  #include "../kvm_util.h"
> @@ -1194,6 +1195,20 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, u=
int64_t a1, uint64_t a2,
>  uint64_t __xen_hypercall(uint64_t nr, uint64_t a0, void *a1);
>  void xen_hypercall(uint64_t nr, uint64_t a0, void *a1);
>
> +static inline uint64_t __kvm_hypercall_map_gpa_range(uint64_t gpa,
> +                                                    uint64_t size, uint6=
4_t flags)
> +{
> +       return kvm_hypercall(KVM_HC_MAP_GPA_RANGE, gpa, size >> PAGE_SHIF=
T, flags, 0);
> +}
> +
> +static inline void kvm_hypercall_map_gpa_range(uint64_t gpa, uint64_t si=
ze,
> +                                              uint64_t flags)
> +{
> +       uint64_t ret =3D __kvm_hypercall_map_gpa_range(gpa, size, flags);
> +
> +       GUEST_ASSERT(!ret);
> +}
> +
>  void __vm_xsave_require_permission(uint64_t xfeature, const char *name);
>
>  #define vm_xsave_require_permission(xfeature)  \
> --
> 2.39.1
>
>
