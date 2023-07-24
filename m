Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DFF75EE7A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjGXIzw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jul 2023 04:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjGXIzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:55:36 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865A7195
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:55:31 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-576a9507a9bso75987667b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690188930; x=1690793730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeL9Fwxd5AD4NKyHzXf07pn2OcHCNFziaHSPLDQBHPQ=;
        b=WZqDSErZwbQBXgA0VfZGm+EjlQ5tbHG9xSL0AKYST4LfxFpsWUYbIJ6jbPMDjfY+jb
         +ZADazQFtluSckc+u+BmcfiOjrhtyh6wfXva25WQgmn+NCudvDdC4JMEoaSo4NhKD+4k
         6SKmy1CfZM/k1gbXqIbxIPHU7Iu8hVPuFnRt7lblxDtswZL0vHIfc3ke8iK/Lr9JticG
         xSHVrm7PM2nsvvoowuQ3aeuibOd71XTEPjXr3EhVMjxUWV8RYiVJ07sunrX1Gc8zkpBK
         Q4MqzNMBdu3Fs5uxQcafmowk2VsUiEVHAYvh27qFTUa9HkFLYu65JuFNc4I1uoY0a/r6
         4FZA==
X-Gm-Message-State: ABy/qLYL+d/SO+8OgHG102Rq5jLbzosVdh3tQoYjcI3nNbMxs5reMfqA
        OqWCdk2dCVeGqsxZ/ddNu9vQ2GSYz+TyCQ==
X-Google-Smtp-Source: APBJJlFKPFi5lNlBEGObwW0jxO05Yc50XqU/sOvAC94OdPI63t9w+a3DPwC9qqoy1CypKEDwCYC7lQ==
X-Received: by 2002:a0d:eac6:0:b0:583:8c62:b162 with SMTP id t189-20020a0deac6000000b005838c62b162mr4964445ywe.4.1690188930590;
        Mon, 24 Jul 2023 01:55:30 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id d16-20020a814f10000000b005840bd271c5sm118579ywb.100.2023.07.24.01.55.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 01:55:30 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-cea0021d1f3so7626731276.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:55:30 -0700 (PDT)
X-Received: by 2002:a25:8005:0:b0:d08:7d6a:2221 with SMTP id
 m5-20020a258005000000b00d087d6a2221mr4165293ybk.18.1690188929804; Mon, 24 Jul
 2023 01:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_7098E5576B2FD785B3A3B9CD6CE0643D4C07@qq.com> <4d862263222c7358840745c2cd0ce0fa@208suo.com>
In-Reply-To: <4d862263222c7358840745c2cd0ce0fa@208suo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 10:55:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVOXvNykCmzJij=ZrVCxnM0DSrwB4_mX6c8-d7ztzNSUA@mail.gmail.com>
Message-ID: <CAMuHMdVOXvNykCmzJij=ZrVCxnM0DSrwB4_mX6c8-d7ztzNSUA@mail.gmail.com>
Subject: Re: [PATCH] m68k: q40: prefer 'unsigned int' to bare use of 'unsigned'
To:     xuanzhenggang001@208suo.com
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhenggang,

On Sat, Jul 8, 2023 at 6:06 PM <xuanzhenggang001@208suo.com> wrote:
> Fix the following warnings reported by checkpatch:
>
> ./arch/m68k/q40/q40ints.c:172: WARNING: Prefer 'unsigned int' to bare
> use of 'unsigned'
> ./arch/m68k/q40/q40ints.c:211: WARNING: Prefer 'unsigned int' to bare
> use of 'unsigned'
>
> Signed-off-by: Zhenggang Xuan <xuanzhenggang001@208suo.com>

Thanks for your patch!

But obviously you forgot to run scripts/checkpatch.pl on your own patch:

    WARNING: From:/Signed-off-by: email name mismatch: 'From:
xuanzhenggang001@208suo.com' != 'Signed-off-by: Zhenggang Xuan
<xuanzhenggang001@208suo.com>'

> --- a/arch/m68k/q40/q40ints.c
> +++ b/arch/m68k/q40/q40ints.c
> @@ -169,7 +169,7 @@ void q40_sched_init (void)
>    *
>   */
>
> -struct IRQ_TABLE{ unsigned mask; int irq ;};
> +struct IRQ_TABLE { unsigned int mask ; int irq ; };
>   #if 0
>   static struct IRQ_TABLE iirqs[]={
>     {Q40_IRQ_FRAME_MASK,Q40_IRQ_FRAME},
> @@ -208,7 +208,7 @@ static int aliased_irq;        /* how many times
> inside handler ?*/
>   /* got interrupt, dispatch to ISA or keyboard/timer IRQs */
>   static void q40_irq_handler(unsigned int irq, struct pt_regs *fp)
>   {
> -    unsigned mir, mer;
> +    unsigned int mir, mer;

This part is white-space damaged, and thus fails to apply.

>       int i;
>
>   //repeat:

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
