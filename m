Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91E87F978F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjK0Cln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0Clk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:41:40 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223BE111
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:41:47 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d7e56f6845so2307884a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701052906; x=1701657706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJClfc4sDLiEj/eSTt+VCec2Lgvh20eFtg0zCQJNbx4=;
        b=axm7D8VSNjQWPP9tmqK5ZEdOTYm6UenuesqfDUGfUj4U9sDEVSscwwLydlkOXfiLB5
         wgMfPrr5BNX3UHkICTCl8Oart/gjnjUx7KFfKJ+S9o4gc7LhSx6ojmxi5Pm6WnONa8Xp
         uh6flmLlm4p9Z25/8IETTCrNbQnxYHbO2DxsfRQq78A0te8UsFOQeXOuqNzGxX4wjQLe
         zJW/OymxxjUf/affhQwUVquWLthqyMNl5ZNUhOL5Ez6ztCk7UVdIMHKdRjnptM9U7ieF
         vOlHT3xF11lYKUDte912avSSkeco/LIT9K7e96Pkk32sDKEzT95/WoAOy0l5v6Kwyo0g
         iqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701052906; x=1701657706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJClfc4sDLiEj/eSTt+VCec2Lgvh20eFtg0zCQJNbx4=;
        b=Xu1NFCxYBFSGCzz/Np3lyC08Suq7sfyUQjvEqW26tOsj6qQlVJG5+53/G6Pz+HgmjM
         L9IQiBIU70MJ59VYJ1rFZsH54QOnWZ7HqAK9BnsDG4CdJJphKZBJgGsyeL8CRvXRV340
         +93IEabIz6/iXC7Xw3wwXvj1QcL+C867gq8CiCBFd2k6dnsIQppO75d4XGkQ3kUTPZ6n
         MH4+d3vpjy97WmNFF8IyHxML/3KiqpXAW8U+sJR10TSWgU2uku6J3OvwJZHLqRz7XiTm
         NGCfrK2YEDYu93z7kFiRmczcd8gDq7CrqdQSm+5GLhS0IHHjtSH3uWLL3Nj29NEd1hKX
         s1GA==
X-Gm-Message-State: AOJu0YyOSsLBZd06CrI9OyzBj23exnRXfXR0IBZ+3bAlmCrKmJatpCd8
        rPU1KJV05mRdxq5BdbqU13acx/TdCAy6aSYTpquo0bR/bMZLtw==
X-Google-Smtp-Source: AGHT+IGHwCnnl/V4HEAdOxYhHMW6DPwEZ/BDf+qy3Yzj4LFXLVT3ZHq32Wm/RxTQIoL07zqbsDCNidoIBsf7jHQC8Po=
X-Received: by 2002:a05:6870:558f:b0:1fa:3678:6c4e with SMTP id
 qj15-20020a056870558f00b001fa36786c4emr4960309oac.8.1701052906041; Sun, 26
 Nov 2023 18:41:46 -0800 (PST)
MIME-Version: 1.0
References: <20231126121002.22568-1-hejinyang@loongson.cn>
In-Reply-To: <20231126121002.22568-1-hejinyang@loongson.cn>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Date:   Mon, 27 Nov 2023 10:41:35 +0800
Message-ID: <CAEyhmHRCJootEEcYo_S7BdCq5LhN5MBG3ut5oYrSLd8R8jWG8A@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Set unwind stack type to unknown rather than
 set error flag
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 8:10=E2=80=AFPM Jinyang He <hejinyang@loongson.cn> =
wrote:
>
> During the unwinding, unwind_done() is used as an end condition. Normally
> it unwind to the user stack and then set the stack type to unknown, which
> is a normal exit. When something unexpected happens in unwind process and
> we cannot unwind anymore, we should set the error flag, and also set the
> stack type to unknown to indicate that the unwind process cannot continue=
.
> The error flag emphasizes that the unwind process produce an unexpected
> error. There is no unexpected things when we unwind the PT_REGS in the
> top of IRQ stack and find out that is an user mode PT_REGS. Thus, we
> should not set error flag and just set stack type to unknown.
>
> Reported-by: Hengqi Chen <hengqi.chen@gmail.com>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> ---
>  arch/loongarch/kernel/stacktrace.c      | 2 +-
>  arch/loongarch/kernel/unwind.c          | 1 -
>  arch/loongarch/kernel/unwind_prologue.c | 2 +-
>  3 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/kernel/stacktrace.c b/arch/loongarch/kernel/s=
tacktrace.c
> index 92270f14db94..f623feb2129f 100644
> --- a/arch/loongarch/kernel/stacktrace.c
> +++ b/arch/loongarch/kernel/stacktrace.c
> @@ -32,7 +32,7 @@ void arch_stack_walk(stack_trace_consume_fn consume_ent=
ry, void *cookie,
>         }
>
>         for (unwind_start(&state, task, regs);
> -            !unwind_done(&state) && !unwind_error(&state); unwind_next_f=
rame(&state)) {
> +            !unwind_done(&state); unwind_next_frame(&state)) {
>                 addr =3D unwind_get_return_address(&state);
>                 if (!addr || !consume_entry(cookie, addr))
>                         break;
> diff --git a/arch/loongarch/kernel/unwind.c b/arch/loongarch/kernel/unwin=
d.c
> index ba324ba76fa1..a463d6961344 100644
> --- a/arch/loongarch/kernel/unwind.c
> +++ b/arch/loongarch/kernel/unwind.c
> @@ -28,6 +28,5 @@ bool default_next_frame(struct unwind_state *state)
>
>         } while (!get_stack_info(state->sp, state->task, info));
>
> -       state->error =3D true;
>         return false;
>  }
> diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/ker=
nel/unwind_prologue.c
> index 55afc27320e1..929ae240280a 100644
> --- a/arch/loongarch/kernel/unwind_prologue.c
> +++ b/arch/loongarch/kernel/unwind_prologue.c
> @@ -227,7 +227,7 @@ static bool next_frame(struct unwind_state *state)
>         } while (!get_stack_info(state->sp, state->task, info));
>
>  out:
> -       state->error =3D true;
> +       state->stack_info.type =3D STACK_TYPE_UNKNOWN;
>         return false;
>  }
>
> --
> 2.42.0
>

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>
