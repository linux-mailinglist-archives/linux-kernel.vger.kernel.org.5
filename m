Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D247C7A7DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjITMLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbjITMLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:11:40 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E542AC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:11:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-578af21ff50so1539377a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695211891; x=1695816691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NmLuj3GTWZxatQ+3XO/wNuxK4/LTmI5AxzHozqfBBQ=;
        b=O8M3NDekk4RXeaEvLGRUluitt47nYKrfisp/OF00wk9dkG8biFRkmPksil+cRfLdQ+
         dbdbR7qEPdv7QKCeaVKZ6uiZjSEP3NoANphjXR+NxbE9JYTWnTNbb5vtSC8JSg7d/7In
         S1GXphZB8nF2abVLX8gXxkzZF3mVQAZJV0ZQduje0K8L4QYH1QQV8MoEypczs9sAJOWH
         aoitrjkU7cYjcDjbjkpW07fBMOOqUbtcEvL5o3oX/ys3ya31E51tGAaQGfddIEI7nEwv
         XqHiBHvvkiSU1m7AgNJeug/HowYKlFnjAbhyYh7L2NuEjWZj+lBeAFuVCZhlb0CrcgPQ
         8/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695211891; x=1695816691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NmLuj3GTWZxatQ+3XO/wNuxK4/LTmI5AxzHozqfBBQ=;
        b=Aje7Ps2LD3OeL057yuTxkoAmcSL4cUMn3sJZQP9R4xw62OghquUdKvyRW4qDZmN+MD
         /tBgtlGMe3Q0wDPlEZlwHrvywSOFe8s4keWwmKFQF+9PeGnlRSnZ1K+09M0wVT3Bl6XM
         mXMZ8L+s14qhTG3tEPC/KPZnHDWROTLur7fJ4z1+H7p7MbkdOTpZv9qFajZY/u8OAqmP
         ubBMsOPbjNkDrbPDZS35wn4xvyhawQaC2A6gedvFR4GgWDgCT1dFLk88Qe5GidapanWN
         k9ILav3E7j64w5kTH1vhrDNv/eGYcCJ/2U6cmzV/YXHNggb49pKDOc0i6nUTQncWEYdw
         goTw==
X-Gm-Message-State: AOJu0YyVVUvd/er4umw0+FbFxfP63eeIrl9s9Z0xapCZObUfYPrZ1LGl
        rWtLkFBuy9IISyjtpGDeBOeAthDSL0mh1xCa8ZXJN+M2
X-Google-Smtp-Source: AGHT+IGCFn242NFlWZa7Bg3jOlv6QfWxUsCQdxdj3ALVid/Yi7urxkyGfdxFRAX909S4zvFak/NFNNJUipqKvg7rvKk=
X-Received: by 2002:a17:90b:148b:b0:268:2500:b17e with SMTP id
 js11-20020a17090b148b00b002682500b17emr2486381pjb.23.1695211891430; Wed, 20
 Sep 2023 05:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230920052139.10570-1-rdunlap@infradead.org>
In-Reply-To: <20230920052139.10570-1-rdunlap@infradead.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 20 Sep 2023 05:11:20 -0700
Message-ID: <CAMo8BfKtkEvbJj-Qx3gA_tw3Cq0pf7RU6n+G1vvNoLqTSDG3sg@mail.gmail.com>
Subject: Re: [PATCH 00/16] xtensa: fix W=1 build warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Tue, Sep 19, 2023 at 10:21=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> This series fixes all xtensa W=3D1 build warnings that I have seen
> with the exception of some in arch/xtensa/boot/. [1]
>
> These have been through defconfig, allnoconfig, tinyconfig, allyesconfig,
> allmodconfig, and many randconfig builds.
>
>  [PATCH 01/16] xtensa: FSF: define XCHAL_HAVE_DIV32
>  [PATCH 02/16] xtensa: fault: include <asm/traps.h>
>  [PATCH 03/16] xtensa: irq: include <asm/traps.h>
>  [PATCH 04/16] xtensa: ptrace: add prototypes to <asm/ptrace.h>
>  [PATCH 05/16] xtensa: processor.h: add init_arch() prototype
>  [PATCH 06/16] xtensa: signal: include headers for function prototypes
>  [PATCH 07/16] xtensa: stacktrace: include <asm/ftrace.h> for prototype
>  [PATCH 08/16] xtensa: traps: add <linux/cpu.h> for function prototype
>  [PATCH 09/16] irqchip: irq-xtensa-mx: include header for missing prototy=
pe
>  [PATCH 10/16] xtensa: smp: add headers for missing function prototypes
>  [PATCH 11/16] xtensa: hw_breakpoing: include header for missing prototyp=
e
>  [PATCH 12/16] xtensa: tlb: include <asm/tlb.h> for missing prototype
>  [PATCH 13/16] xtensa: iss/network: make functions static
>  [PATCH 14/16] xtensa: boot: don't add include-dirs
>  [PATCH 15/16] xtensa: umulsidi3: fix conditional expression
>  [PATCH 16/16] xtensa: boot/lib: add missing prototypes for functions
>
> 1:
> arch/xtensa/boot/boot-elf/bootstrap.S:68: Warning: value 0x1a0003000 trun=
cated to 0xa0003000
>
>  arch/xtensa/boot/Makefile                       |    3 +--
>  arch/xtensa/boot/lib/zmem.c                     |    4 ++++
>  arch/xtensa/include/asm/hw_breakpoint.h         |    1 +
>  arch/xtensa/include/asm/processor.h             |    5 +++++
>  arch/xtensa/include/asm/ptrace.h                |    3 +++
>  arch/xtensa/include/asm/smp.h                   |    1 +
>  arch/xtensa/include/asm/tlb.h                   |    2 ++
>  arch/xtensa/kernel/hw_breakpoint.c              |    1 +
>  arch/xtensa/kernel/irq.c                        |    1 +
>  arch/xtensa/kernel/ptrace.c                     |    1 -
>  arch/xtensa/kernel/signal.c                     |    2 ++
>  arch/xtensa/kernel/smp.c                        |    1 +
>  arch/xtensa/kernel/stacktrace.c                 |    1 +
>  arch/xtensa/kernel/traps.c                      |    1 +
>  arch/xtensa/lib/umulsidi3.S                     |    4 +++-
>  arch/xtensa/mm/fault.c                          |    1 +
>  arch/xtensa/mm/tlb.c                            |    1 +
>  arch/xtensa/platforms/iss/network.c             |    4 ++--
>  arch/xtensa/variants/fsf/include/variant/core.h |    1 +
>  drivers/irqchip/irq-xtensa-mx.c                 |    1 +
>  20 files changed, 33 insertions(+), 6 deletions(-)
>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>

Thank you for this nice cleanup. Applied the whole series (except
the first and the last patches, which I replaced with different fixes)
to my xtensa tree.

--=20
Thanks.
-- Max
