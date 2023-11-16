Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABE67ED9CB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344553AbjKPCzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjKPCzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:55:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D87DA4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:55:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5F9C433C8;
        Thu, 16 Nov 2023 02:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700103304;
        bh=ZqesSgGnkVZM04RFsgA7wOog4cC0NwW8GeTDpVZM7eo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CvyfsMcf7sdo3j1uzQfaol/ZITI27NtDWoHNx/qNQKZpvFsfY/6KxpizWMtjEjrzT
         UqGhkv1DYO428o1V7FLwOg6Yac70GG4dK5i9fvipUAHNLJldii5N/TV4uvNed/WCHu
         /lClVFSG7gQBt30snqdSOmd4KxBTPt/twxpCIMJiBnCzmDKxtxaiRbSO1ndINKHQf/
         89g1gfHkiwHdycnErF/bRmjdcUuAuo0+nyqMFXtqoIAv+y9NFwr72NE3wgNr+r9TK/
         qcImN6EKfXlTzqHYm6tLemYHtWue0Co/SOAF5J9LU4OfAd0rOFRC5hfLK+aPqgK1eQ
         o/UIsQ09s3WcA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5440f25dcc7so519139a12.0;
        Wed, 15 Nov 2023 18:55:03 -0800 (PST)
X-Gm-Message-State: AOJu0YyjKP8zYF02m2si6RyRwVY3aZblylmxzBy0Cma6cIzCgxwv7Nys
        IiXXzvxCY0XDWO2GtQ1EFNwrCmSpe0IkofNdgh8=
X-Google-Smtp-Source: AGHT+IGoyHYHxifCTEl8SsnAL1yE8tDDpUcvj5Qt/DgQNFhXKJlIPTjK+Dm+HM5u0H1F+5copmj1N5nmRNBShvMzuxs=
X-Received: by 2002:a05:6402:1042:b0:540:c989:fcdd with SMTP id
 e2-20020a056402104200b00540c989fcddmr11265637edu.11.1700103302368; Wed, 15
 Nov 2023 18:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20231116023036.2324371-1-maobibo@loongson.cn>
In-Reply-To: <20231116023036.2324371-1-maobibo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 16 Nov 2023 10:54:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Wyp-6_gFSfm8uWUMiEJnebk9n4JxQrx_nBdxkTF5wUA@mail.gmail.com>
Message-ID: <CAAhV-H4Wyp-6_gFSfm8uWUMiEJnebk9n4JxQrx_nBdxkTF5wUA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] LoongArch: KVM: Remove SW timer switch when vcpu
 is halt polling
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     Tianrui Zhao <zhaotianrui@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibo,

I suggest submitting this series to the internal repo, too. Because we
don't have enough resources to test the stability for the upstream
version, while this is a fundamental change. On the other hand, the
patch "LoongArch:LSVZ: set timer offset at first time once" can be
submitted first because it is already in the internal repo.

Huacai

On Thu, Nov 16, 2023 at 10:33=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> This patches removes SW timer switch during vcpu block stage. VM uses HW
> timer rather than SW PV timer on LoongArch system, it can check pending
> HW timer interrupt status directly, rather than switch to SW timer and
> check injected SW timer interrupt.
>
> When SW timer is not used in vcpu halt-polling mode, the relative
> SW timer handling before entering guest can be removed also. Timer
> emulation is simpler than before, SW timer emuation is only used in vcpu
> thread context switch.
> ---
> Changes in v4:
>   If vcpu is scheduled out since there is no pending event, and timer is
> fired during sched-out period. SW hrtimer is used to wake up vcpu thread
> in time, rather than inject pending timer irq.
>
> Changes in v3:
>   Add kvm_arch_vcpu_runnable checking before kvm_vcpu_halt.
>
> Changes in v2:
>   Add halt polling support for idle instruction emulation, using api
> kvm_vcpu_halt rather than kvm_vcpu_block in function kvm_emu_idle.
>
> ---
> Bibo Mao (3):
>   LoongArch: KVM: Remove SW timer switch when vcpu is halt polling
>   LoongArch: KVM: Allow to access HW timer CSR registers always
>   LoongArch: KVM: Remove kvm_acquire_timer before entering guest
>
>  arch/loongarch/include/asm/kvm_vcpu.h |  1 -
>  arch/loongarch/kvm/exit.c             | 13 +-----
>  arch/loongarch/kvm/main.c             |  1 -
>  arch/loongarch/kvm/timer.c            | 62 ++++++++++-----------------
>  arch/loongarch/kvm/vcpu.c             | 38 ++++------------
>  5 files changed, 32 insertions(+), 83 deletions(-)
>
>
> base-commit: c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
> --
> 2.39.3
>
