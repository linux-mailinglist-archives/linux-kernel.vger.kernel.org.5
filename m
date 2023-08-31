Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4574F78F1C5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346866AbjHaRVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjHaRVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AB9107
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693502424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ymQvv7X9AMYZ6FyxsIOelJNS5mGxhoE6nVc+5tdBMkg=;
        b=MlTKTwY30zHMz3EKA72MZzuCmy4RfNOhxE50jY9glb5ppYTy+8eOOnIjIHGNULIvaP8BN3
        5AeYHRnox87hcu74z1gQug2ajOZgGwpLGuUyK6HRl1Bg4QcSzwF58T4xODyhGXzWL47+bR
        IS3hGr3/512Rt1nAfGTPWdCjKgT/udQ=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-HToUe34BMf-AA2rmk_HFLA-1; Thu, 31 Aug 2023 13:20:21 -0400
X-MC-Unique: HToUe34BMf-AA2rmk_HFLA-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-44d5ac106ddso507058137.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693502421; x=1694107221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymQvv7X9AMYZ6FyxsIOelJNS5mGxhoE6nVc+5tdBMkg=;
        b=l/9gTB9zkEObbqwNjGBUyAHagm6sm64QwtB7v+ptlc1oYD/7UZx5tENaaZiQlJAiCz
         IoQF3GbUurs/ynB1grxfn6D1nJGSxhB7xaNxbQXCjlrnkUWKV0QFsAgsr23wYoqYHNb2
         ru5vuL3p2EpPkeU/Lx85JJDr9AX5DK4xdWpw+W0sGvoQJzGYsm5oYESiXfunOk7SCi78
         NXOjFwtKn3JUOQ7pGge8F9n6PIGoHfia9J9cIUWiminQ+pv82ZThu+Xd92Xn9P7eHizK
         IdgCPQi0xVsgaGHGFihWBqLFp5UN6jr8Fbcy18W9aal4uy9Lkr62iLe7nQWoT0mmAdQL
         01Ig==
X-Gm-Message-State: AOJu0YyzSiwFqD/sJOtBHPuVjjsZO/CBb36VV7t/mcwB9Uiv9zFIW6xX
        LAmdRl2FBOgQ/OeSTMKmxWwW/FVlLeu9z7Zfs1E4fbQbIliU38As98V0a1iGKEZorRJags84J0M
        ODSnOUBS71OhKIrDR11qHeFAGF3DPnrf+Lu06P1eK
X-Received: by 2002:a05:6102:2454:b0:44e:d28f:e49c with SMTP id g20-20020a056102245400b0044ed28fe49cmr219951vss.23.1693502421367;
        Thu, 31 Aug 2023 10:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJzkOTnPItPnNZWsXGncuPRF1efAk4j4Fn3ZuMQ2PcrdaFfgq4G0JeoLlyEqDyllBC3Jlg2e47I507J/cwdko=
X-Received: by 2002:a05:6102:2454:b0:44e:d28f:e49c with SMTP id
 g20-20020a056102245400b0044ed28fe49cmr219936vss.23.1693502421158; Thu, 31 Aug
 2023 10:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230830000633.3158416-1-seanjc@google.com> <20230830000633.3158416-2-seanjc@google.com>
In-Reply-To: <20230830000633.3158416-2-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 31 Aug 2023 19:20:09 +0200
Message-ID: <CABgObfYjUzE6H4KLxwFS+WqP5deimRE8ip8Sy1t37b_HtC_eqg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: Non-x86 changes for 6.6
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 2:06=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Please pull a few smallish KVM-wide changes.  This will conflict with the=
 MMU
> pull request, which changed a WARN_ON() to a WARN_ON_ONCE().  The resolut=
ion
> is pretty straightfoward.
>
> diff --cc arch/x86/kvm/mmu/tdp_mmu.c
> index 6250bd3d20c1,b5629bc60e36..6c63f2d1675f
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@@ -1241,7 -1241,7 +1241,7 @@@ static bool set_spte_gfn(struct kvm *kv
>         u64 new_spte;
>
>         /* Huge pages aren't expected to be modified without first being =
zapped. */
> -       WARN_ON(pte_huge(range->arg.pte) || range->start + 1 !=3D range->=
end);
>  -      WARN_ON_ONCE(pte_huge(range->pte) || range->start + 1 !=3D range-=
>end);
> ++      WARN_ON_ONCE(pte_huge(range->arg.pte) || range->start + 1 !=3D ra=
nge->end);
>
>         if (iter->level !=3D PG_LEVEL_4K ||
>             !is_shadow_present_pte(iter->old_spte))
>
> The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b57=
4c:
>
>   Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-generic-6.6
>
> for you to fetch changes up to 458933d33af2cb3663bd8c0080c1efd1f9483db4:
>
>   KVM: Remove unused kvm_make_cpus_request_mask() declaration (2023-08-17=
 11:59:43 -0700)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> Common KVM changes for 6.6:
>
>  - Wrap kvm_{gfn,hva}_range.pte in a union to allow mmu_notifier events t=
o pass
>    action specific data without needing to constantly update the main han=
dlers.
>
>  - Drop unused function declarations
>
> ----------------------------------------------------------------
> Sean Christopherson (1):
>       KVM: Wrap kvm_{gfn,hva}_range.pte in a per-action union
>
> Yue Haibing (2):
>       KVM: Remove unused kvm_device_{get,put}() declarations
>       KVM: Remove unused kvm_make_cpus_request_mask() declaration
>
>  arch/arm64/kvm/mmu.c       |  2 +-
>  arch/mips/kvm/mmu.c        |  2 +-
>  arch/riscv/kvm/mmu.c       |  2 +-
>  arch/x86/kvm/mmu/mmu.c     |  2 +-
>  arch/x86/kvm/mmu/tdp_mmu.c |  6 +++---
>  include/linux/kvm_host.h   | 10 +++++-----
>  virt/kvm/kvm_main.c        | 19 ++++++++++---------
>  7 files changed, 22 insertions(+), 21 deletions(-)
>

