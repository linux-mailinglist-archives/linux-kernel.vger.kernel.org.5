Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC5A755A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGQDyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjGQDy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:54:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D495E67
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 20:54:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99342a599e9so585091466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 20:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1689566064; x=1692158064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IADBk67MmtQgEFrJ4GNzmRMtCsY7zxHXJTj9byIPGyM=;
        b=zL1UbGQQabWyZVL/qkzQG7J6gpH1aG3NKw0+gfIKICF7guBFe6P4URiTIsry1vB43c
         bHUACKVpACI3sa7hLDc+WBiVWNj+kEg1hTq47Z14aVk65UIHDCTJQzRNtTCXE5gqY9fE
         dFA6x/tlagHdw5z49kZ48idi/49e8dL6PaYQ3xMYgVlstvspYP+JESz9EkI3Fd0GzSvk
         PI8RVW68ilfaKc41gLfEgGunPkP/CCXuXkuPGjmfCL+iSZ6XmRt9j7CHkoa3k9x8ZM1a
         Zg1xaVfbGaDxBPCsMwFlRlI9VR8+SjEWMk8EgOTEgnMgMcgu/rDj1DeNe9iABrp1Q8Dq
         H9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689566064; x=1692158064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IADBk67MmtQgEFrJ4GNzmRMtCsY7zxHXJTj9byIPGyM=;
        b=fCACCDZL1zOgvPsDTpbZYsmlJucvyPfI8SK7REfWBu9ASNfbgLig0kndZP9sF5rfTe
         zU74/WXOc7rDOKjaAQ/ILnVNZYQ1c4ITUKyI9SxWhG3AaftpNx2e7um/hBKBrkmLbJPj
         1QBPbZggqGbR0zaLG/7gAqhVbMQp6S9RK4bGVhdGzdi8+7DkySylx8FWMC8LBgsdakNs
         YKnQgqpGhMcRHjlyWyPz0Ni5YDfW5UiM3mvfii8VyxjZ3pWwpkhrFUf1fqU/5hEEO2fw
         TgHX2MV7nud5jqYgAqa0wAuHUajIbl46a2p6Dh5ChV5XQ16Wwdy47+vIPau3VnsVPc+b
         eNYQ==
X-Gm-Message-State: ABy/qLYSAlAxkUR7eteEjq0w0rNmn2El77bML34M5kZOJlxNAkaeUfyU
        PRjLOOPbh5jA/+h0T0LoC88kq7GcYETHAjJg+Qcsug==
X-Google-Smtp-Source: APBJJlGMFjbuzvR13okMMKYKW2GKmezRZzN3Ec5qqIvk5Im4E5ilkEl+jfnCM7bLgPcLpNqXz758I9FrRMNgMcy8DR8=
X-Received: by 2002:a17:906:5185:b0:96f:a891:36cb with SMTP id
 y5-20020a170906518500b0096fa89136cbmr10978298ejk.0.1689566063601; Sun, 16 Jul
 2023 20:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230712161047.1764756-1-apatel@ventanamicro.com>
In-Reply-To: <20230712161047.1764756-1-apatel@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 17 Jul 2023 09:24:12 +0530
Message-ID: <CAAhSdy048rUYUj2j+rutCc73=aE0dKgCrt75ohz9tO476+n6Gg@mail.gmail.com>
Subject: Re: [PATCH 0/7] KVM RISC-V ONE_REG ISA extension improvements
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Ortiz <sameo@rivosinc.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 9:41=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> This series improves the ISA extension ONE_REG interface in following way=
s:
> 1) Move ONE_REG related code to dedicated source file
> 2) Allow multiple ISA extensions to be enabled/disabled in one ioctl
> 3) Add more ISA extensions to the ONE_REG interface
>
> The series has following dependencies:
> 1) PATCH6 depends on
> https://lore.kernel.org/linux-riscv/20230712084134.1648008-1-sameo@rivosi=
nc.com/
> 2) PATCH7 depends on
> https://lore.kernel.org/linux-riscv/20230711153743.1970625-1-heiko@sntech=
.de/
>
> The PATCH1 to PATCH5 of this series don't depend on any patches.
>
> These patches can also be found in the riscv_kvm_onereg_imp_v1 branch at:
> https://github.com/avpatel/linux.git
>
> Anup Patel (7):
>   RISC-V: KVM: Factor-out ONE_REG related code to its own source file
>   RISC-V: KVM: Extend ONE_REG to enable/disable multiple ISA extensions
>   RISC-V: KVM: Allow Zba and Zbs extensions for Guest/VM
>   RISC-V: KVM: Allow Zicntr, Zicsr, Zifencei, and Zihpm for Guest/VM
>   RISC-V: KVM: Sort ISA extensions alphabetically in ONE_REG interface
>   RISC-V: KVM: Allow Zbc, Zbk* and Zk* extensions for Guest/VM
>   RISC-V: KVM: Allow Zvb* and Zvk* extensions for Guest/VM

I have queued PATCH1 to PATCH5 for Linux-6.6 so that other in-flight
patches can be rebased on the riscv_kvm_queue.

The PATCH6 and PATCH7 will have to wait until required dependencies
are merged in arch/riscv.

Thanks,
Anup


>
>  arch/riscv/include/asm/kvm_host.h |   6 +
>  arch/riscv/include/uapi/asm/kvm.h |  35 ++
>  arch/riscv/kvm/Makefile           |   1 +
>  arch/riscv/kvm/vcpu.c             | 529 +----------------------
>  arch/riscv/kvm/vcpu_onereg.c      | 695 ++++++++++++++++++++++++++++++
>  5 files changed, 738 insertions(+), 528 deletions(-)
>  create mode 100644 arch/riscv/kvm/vcpu_onereg.c
>
> --
> 2.34.1
>
