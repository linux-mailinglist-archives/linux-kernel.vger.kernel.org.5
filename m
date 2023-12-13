Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F2B810A22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378576AbjLMGQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbjLMGQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:16:37 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7B3AD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:16:43 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9f572c4c5so97766081fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702448202; x=1703053002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71L6UE8bKw9xAm3N5o4/wivq75A3TGoxxbYsqvN4Hr0=;
        b=hwx4i2gLSl4bcvr9DhAI5+kNX6LiOF78YQbCipRICgjWAFcaCaKRchlaqR7KnEx3Bb
         KQq4SL9I9NGxYDfARVmPKv4QrKlL8GzEpIHEB987BqMTKUm0G0IyTxj7SDfAHuYZFVsp
         CDXFZptk515kIOSCkeCdZFQiiKcTjuzW6aMfWjMGGOYrTV1vICIQTDL0jXipdTgv/6eR
         pF15RsJYq3Sup4kb8ZIMafr4BEnmPq7vYZH3HDUnyqVWbgenvw/Ee7dY+tRy46BKCzTy
         7BIUhEUODWOKvbz3Nm+7/C3/k5BOchSZgOy+cDgvzz/PxP7/5Wr4YvvSQhtpf2F3SY4u
         g39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702448202; x=1703053002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71L6UE8bKw9xAm3N5o4/wivq75A3TGoxxbYsqvN4Hr0=;
        b=EIbjTf6H4UpKKcD2NmwlnvvOhxrrzTdLMntb0ZMX06HxxfUHLh4mHNUd4H8fTP24J5
         F3FhAH3IZk8GbyDe859q2orQOXtznyzPuuOTocYZL0hheUAFRN9RH5/XWzTYRs6FRo2Y
         Vz25k4UUpPbYIw8lCgzhhEnaT0dv8vUlNtpaD18kHuuCVDiXlM+EgOv4U/eZLpPEKRP6
         hzwBKkn7Vla5NmHHxBUp1Mo8vwJwJhVkKkEhetrACF7OKSZC2bXVdWuoR9NTh1HjJtbB
         5gy0vd130gzWpSyPYIrrSeOrl6Gr1/09FBsSS3TG70izF32M8qIxeVa2YV+EXVSr0NMf
         TSnA==
X-Gm-Message-State: AOJu0YwgjuNXIIH7Ac5+SzpguxZ2CTd+mebqlzZr8Zhrsww0aGVKTsKK
        bTnu7V3OmcglwFOjxdvvsBTrZeG41Pm4Y/oODNwQIQ==
X-Google-Smtp-Source: AGHT+IG/SLo7IZipsDDy7zRrZC+GgAuTAGWON0Bsoqj4uYyJv+RSVk/6F7C6tK2fz6ryDtVCQEYyyNn3PWzHDXcwocU=
X-Received: by 2002:a05:651c:1145:b0:2cc:1ee4:a930 with SMTP id
 h5-20020a05651c114500b002cc1ee4a930mr3971199ljo.106.1702448201538; Tue, 12
 Dec 2023 22:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20231024132655.730417-1-cleger@rivosinc.com> <20231024132655.730417-6-cleger@rivosinc.com>
In-Reply-To: <20231024132655.730417-6-cleger@rivosinc.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 13 Dec 2023 11:46:30 +0530
Message-ID: <CAK9=C2UTww1AcF+U+7MBiT5c7PVtQrQQN=tNszjse+AgJd6xCQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] riscv: kvm: use ".L" local labels in assembly when applicable
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 6:58=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> For the sake of coherency, use local labels in assembly when
> applicable. This also avoid kprobes being confused when applying a
> kprobe since the size of function is computed by checking where the
> next visible symbol is located. This might end up in computing some
> function size to be way shorter than expected and thus failing to apply
> kprobes to the specified offset.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Queued this patch for Linux-6.8

Thanks,
Anup


> ---
>  arch/riscv/kvm/vcpu_switch.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_switch.S b/arch/riscv/kvm/vcpu_switch.S
> index 8b18473780ac..0c26189aa01c 100644
> --- a/arch/riscv/kvm/vcpu_switch.S
> +++ b/arch/riscv/kvm/vcpu_switch.S
> @@ -45,7 +45,7 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
>         REG_L   t0, (KVM_ARCH_GUEST_SSTATUS)(a0)
>         REG_L   t1, (KVM_ARCH_GUEST_HSTATUS)(a0)
>         REG_L   t2, (KVM_ARCH_GUEST_SCOUNTEREN)(a0)
> -       la      t4, __kvm_switch_return
> +       la      t4, .Lkvm_switch_return
>         REG_L   t5, (KVM_ARCH_GUEST_SEPC)(a0)
>
>         /* Save Host and Restore Guest SSTATUS */
> @@ -113,7 +113,7 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
>
>         /* Back to Host */
>         .align 2
> -__kvm_switch_return:
> +.Lkvm_switch_return:
>         /* Swap Guest A0 with SSCRATCH */
>         csrrw   a0, CSR_SSCRATCH, a0
>
> --
> 2.42.0
>
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv
