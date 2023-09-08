Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860EB79847F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbjIHJBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 05:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjIHJBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:01:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C3E1BC8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 02:01:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF7EC433C9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694163689;
        bh=rE5zH+On8EOe/kA8HLgVDoL97kxJNQGwOXrvmH08brw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pQxmZecx4EHJcQtFvleL5MDu6PXX2COHzS+Q8CYasrXQvV1fsF/yBa0djKu/I2+dG
         rrgWBsobUv+JSLwNrWMbkLytpoK/N9NPaF7D9LOZm/UTdoJ44EdQwh24kaKZkURer3
         vxt75QJUlwUvtZdbzJBv3t8FQiYlnzpRvbVKpqKR0Qw01HLcK1GO8R46HRj1vdvUYZ
         R2kZ4i+drfp52pTPkhtNhMDQq7OhWTvyObO62CA6Rl7LsF+MX2di48w6QGytcH2O8D
         oF/FmjyQmUi58zVGARoitippqRr21Upuy88BDHyGHDR1PR2QEYNgy4sK85hWSQY03B
         bSeHoe8u+8kBg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so2503483a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 02:01:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YwWiLFHFIxr80UUGM9CTGk/309RTgjhTCFiclrhYo82U1E5cZKN
        XllwyupzGzgtLLiZ0Tc5OP7VcqyvqcpIpmZhmwQ=
X-Google-Smtp-Source: AGHT+IErbyVlIoQhbQ1VhQjIiVqC1OCG7Hd1zNV8Jx507J94fI35vzASUhnf3ixLKSDlNyb079zIDDuEOhnBDpeNt9E=
X-Received: by 2002:a17:906:20dc:b0:9a9:e41f:d214 with SMTP id
 c28-20020a17090620dc00b009a9e41fd214mr1338393ejc.74.1694163688219; Fri, 08
 Sep 2023 02:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230906123216.255932-1-wangjiexun@tinylab.org>
In-Reply-To: <20230906123216.255932-1-wangjiexun@tinylab.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 8 Sep 2023 17:01:14 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQUx35vOrG82WeS9pS8XRjVVLiLTMGt+TRmn2HsNahGXQ@mail.gmail.com>
Message-ID: <CAJF2gTQUx35vOrG82WeS9pS8XRjVVLiLTMGt+TRmn2HsNahGXQ@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Fix use of non existent CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
To:     Jiexun Wang <wangjiexun@tinylab.org>
Cc:     conor@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, falcon@tinylab.org,
        jszhang@kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx for fixup.

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, Sep 6, 2023 at 8:34=E2=80=AFPM Jiexun Wang <wangjiexun@tinylab.org>=
 wrote:
>
> If configuration options SOFTIRQ_ON_OWN_STACK and PREEMPT_RT
> are enabled simultaneously under RISC-V architecture,
> it will result in a compilation failure:
>
> arch/riscv/kernel/irq.c:64:6: error: redefinition of 'do_softirq_own_stac=
k'
>    64 | void do_softirq_own_stack(void)
>       |      ^~~~~~~~~~~~~~~~~~~~
> In file included from ./arch/riscv/include/generated/asm/softirq_stack.h:=
1,
>                  from arch/riscv/kernel/irq.c:15:
> ./include/asm-generic/softirq_stack.h:8:20: note: previous definition of =
'do_softirq_own_stack' was here
>     8 | static inline void do_softirq_own_stack(void)
>       |                    ^~~~~~~~~~~~~~~~~~~~
>
> After changing CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK to CONFIG_SOFTIRQ_ON_OWN_=
STACK,
> compilation can be successful.
>
> Fixes: dd69d07a5a6c ("riscv: stack: Support HAVE_SOFTIRQ_ON_OWN_STACK")
> Signed-off-by: Jiexun Wang <wangjiexun@tinylab.org>
> ---
> Changes in v2:
> - changed to a more suitable subject line
> - add a Fixes tag
>
> ---
>  arch/riscv/kernel/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index a8efa053c4a5..a86f272ae2c3 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -60,7 +60,7 @@ static void init_irq_stacks(void)
>  }
>  #endif /* CONFIG_VMAP_STACK */
>
> -#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
> +#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
>  void do_softirq_own_stack(void)
>  {
>  #ifdef CONFIG_IRQ_STACKS
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren
