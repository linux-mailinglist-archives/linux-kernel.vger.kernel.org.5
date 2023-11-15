Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236D07EBC70
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjKODzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbjKODzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:55:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4609D9;
        Tue, 14 Nov 2023 19:55:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571ADC433C9;
        Wed, 15 Nov 2023 03:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700020536;
        bh=DjioEA6yFkFSgqg2Fg87W7Jilj73akgzOASGYgK8gHw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uImMLZOVAb7cWC/V37UV+IJsRtdEfQ6ADj4ZQ4Mbti0LA6QBNKdVOJBMsTTvxVd2w
         uQSejMzTjPolGjMyMlnMSx/8+ZSPrLQaVQw/FuksyK4KujiUX38ZZgH2TnexBT6bXa
         gMl8nkSAZvMTrD2IW0a+jgaHvBl6eP0WvlzGb7iBQ1ac0JLM5Y/w9YV9pi8GMsfX9w
         B/GaiUHl8jgBOLzOFdFoPswdZQmba3IqibW9mlkugY9qeYnSLRk3xAmzBQpjUXkA+Y
         XX8N0oziYTHPpHl9A2f67DHr9VdT+nuAAip2+IIJpfWnX+drq419UoC1DWV0kAF92G
         98AVrIidnmYZA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9c603e2354fso88381066b.1;
        Tue, 14 Nov 2023 19:55:36 -0800 (PST)
X-Gm-Message-State: AOJu0YzdAN2A+To+XGPkb6EbT7tHxbIGGZ0N7SXF4a5fROYgMHMX1zM0
        +E6p3O0cccZte0gOcpLOkshOnyiHsn/8oTXlHcA=
X-Google-Smtp-Source: AGHT+IGiN/xewkmgirjSJILpaABI73kI4yfwGW0y4S7r3q1TLlfVBcz/Eyl2jNLvj5JbU9u9riOUEWgnwpZT4I8QvaU=
X-Received: by 2002:a17:907:9629:b0:9ee:295:5696 with SMTP id
 gb41-20020a170907962900b009ee02955696mr4368970ejc.2.1700020534757; Tue, 14
 Nov 2023 19:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20231115033350.1228588-1-sashal@kernel.org> <20231115033350.1228588-4-sashal@kernel.org>
In-Reply-To: <20231115033350.1228588-4-sashal@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 15 Nov 2023 11:55:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H61R006eHGN+ujvDqrT_6AYV0XBcSaT2zyVLJi1rR=kMA@mail.gmail.com>
Message-ID: <CAAhV-H61R006eHGN+ujvDqrT_6AYV0XBcSaT2zyVLJi1rR=kMA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 4/6] LoongArch/smp: Call rcutree_report_cpu_starting()
 earlier
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>, maobibo@loongson.cn,
        palmer@rivosinc.com, yangtiezhu@loongson.cn, wangliupu@loongson.cn,
        jpoimboe@kernel.org, zhoubinbin@loongson.cn,
        loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sasha,

In 6.6 and earlier versions, rcutree_report_cpu_starting() should be
rcu_cpu_starting().

Huacai

On Wed, Nov 15, 2023 at 11:34=E2=80=AFAM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> From: Huacai Chen <chenhuacai@loongson.cn>
>
> [ Upstream commit a2ccf46333d7b2cf9658f0d82ac74097c1542fae ]
>
> rcutree_report_cpu_starting() must be called before cpu_probe() to avoid
> the following lockdep splat that triggered by calling __alloc_pages() whe=
n
> CONFIG_PROVE_RCU_LIST=3Dy:
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: suspicious RCU usage
>  6.6.0+ #980 Not tainted
>  -----------------------------
>  kernel/locking/lockdep.c:3761 RCU-list traversed in non-reader section!!
>  other info that might help us debug this:
>  RCU used illegally from offline CPU!
>  rcu_scheduler_active =3D 1, debug_locks =3D 1
>  1 lock held by swapper/1/0:
>   #0: 900000000c82ef98 (&pcp->lock){+.+.}-{2:2}, at: get_page_from_freeli=
st+0x894/0x1790
>  CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.6.0+ #980
>  Stack : 0000000000000001 9000000004f79508 9000000004893670 9000000100310=
000
>          90000001003137d0 0000000000000000 90000001003137d8 9000000004f79=
508
>          0000000000000000 0000000000000001 0000000000000000 90000000048a3=
384
>          203a656d616e2065 ca43677b3687e616 90000001002c3480 0000000000000=
008
>          000000000000009d 0000000000000000 0000000000000001 80000000ffffe=
0b8
>          000000000000000d 0000000000000033 0000000007ec0000 13bbf50562dad=
831
>          9000000005140748 0000000000000000 9000000004f79508 0000000000000=
004
>          0000000000000000 9000000005140748 90000001002bad40 0000000000000=
000
>          90000001002ba400 0000000000000000 9000000003573ec8 0000000000000=
000
>          00000000000000b0 0000000000000004 0000000000000000 0000000000070=
000
>          ...
>  Call Trace:
>  [<9000000003573ec8>] show_stack+0x38/0x150
>  [<9000000004893670>] dump_stack_lvl+0x74/0xa8
>  [<900000000360d2bc>] lockdep_rcu_suspicious+0x14c/0x190
>  [<900000000361235c>] __lock_acquire+0xd0c/0x2740
>  [<90000000036146f4>] lock_acquire+0x104/0x2c0
>  [<90000000048a955c>] _raw_spin_lock_irqsave+0x5c/0x90
>  [<900000000381cd5c>] rmqueue_bulk+0x6c/0x950
>  [<900000000381fc0c>] get_page_from_freelist+0xd4c/0x1790
>  [<9000000003821c6c>] __alloc_pages+0x1bc/0x3e0
>  [<9000000003583b40>] tlb_init+0x150/0x2a0
>  [<90000000035742a0>] per_cpu_trap_init+0xf0/0x110
>  [<90000000035712fc>] cpu_probe+0x3dc/0x7a0
>  [<900000000357ed20>] start_secondary+0x40/0xb0
>  [<9000000004897138>] smpboot_entry+0x54/0x58
>
> raw_smp_processor_id() is required in order to avoid calling into lockdep
> before RCU has declared the CPU to be watched for readers.
>
> See also commit 29368e093921 ("x86/smpboot: Move rcu_cpu_starting() earli=
er"),
> commit de5d9dae150c ("s390/smp: move rcu_cpu_starting() earlier") and com=
mit
> 99f070b62322 ("powerpc/smp: Call rcu_cpu_starting() earlier").
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/loongarch/kernel/smp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index ef35c871244f0..5bca12d16e069 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -504,8 +504,9 @@ asmlinkage void start_secondary(void)
>         unsigned int cpu;
>
>         sync_counter();
> -       cpu =3D smp_processor_id();
> +       cpu =3D raw_smp_processor_id();
>         set_my_cpu_offset(per_cpu_offset(cpu));
> +       rcutree_report_cpu_starting(cpu);
>
>         cpu_probe();
>         constant_clockevent_init();
> --
> 2.42.0
>
