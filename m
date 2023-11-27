Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAAF7FACD6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjK0Vz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjK0Vz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:55:26 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5626BD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:55:32 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a02d12a2444so695252366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701122129; x=1701726929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaSFhmgVx3V8dB4TtK9NswdosRwsp4UPGC8yEbKiUf8=;
        b=LAUj6wUrOlHiXIK0KnUJpgQrIPQjU3e48Pr/DRUoRLri3yLVkK+kYJkRGy3mXtxbo3
         qTNab4nRhN2TvWLLQ7PU7EQzLl9r/a+yN7ezhohOWUmm4jSgtziCJPA6GBSCHAn75YR7
         zNERwmKMG5CH+CNApDKDzy+Or+Tz9qSt61Gd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122129; x=1701726929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaSFhmgVx3V8dB4TtK9NswdosRwsp4UPGC8yEbKiUf8=;
        b=pkk8779BrhYmJeRcfy+rbiDLNvr9h/R1LDWEQ4qrrMN4o3QYErCQLpTiVLUfRv9NLc
         vpVsUzr13i3xoaxTKJRvdXrFXJ5+kY8Cto9S04djJo4BIFBzCjC3KAh+4MlGEkKDaCFY
         wq2/mlZwjIqNIPYf8AS+T5VE/R3ikVhvIBQ6UhdoWhstrGHsfHQ7m75NVxbi6gwfvbl2
         t/rKISZd9WSnOogUBR92S73acvq5sv8D3O6HQd1pFU2pAEWrGWmmOie06iHp7bwJyneV
         IWjYuRYyZXmliH6ZoFXPIzVKj8nxvrkUXMr/nYGPDV4VQj6VwKig5B4O0rChM66WDeQG
         98hw==
X-Gm-Message-State: AOJu0YwDeC4diUNLbMLkASKxzvh9j3EGkLiUB4AH2yRwJWn9699YAw1b
        ygU48BTXxThzgtQzb1BwbFEThd/9/ljN8KvdZ114Nw==
X-Google-Smtp-Source: AGHT+IGyzyZfBsPpybXpNtY1RCkJowU8rl4GKTVh4sYBzp2UVWFn227S2TnYTIKURIGc0RPwDtSUjg==
X-Received: by 2002:a17:907:874a:b0:9cf:35a7:9ea5 with SMTP id qo10-20020a170907874a00b009cf35a79ea5mr11310185ejc.74.1701122129732;
        Mon, 27 Nov 2023 13:55:29 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id jx19-20020a170906ca5300b009fc9fab9178sm6109569ejb.125.2023.11.27.13.55.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 13:55:29 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40b35199f94so3775e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:55:28 -0800 (PST)
X-Received: by 2002:a05:600c:3b03:b0:40b:33aa:a2b9 with SMTP id
 m3-20020a05600c3b0300b0040b33aaa2b9mr623198wms.4.1701122128554; Mon, 27 Nov
 2023 13:55:28 -0800 (PST)
MIME-Version: 1.0
References: <CAD=FV=XhqDxmk=yTdujwtFyF23NZ13LORH0GMS5_iTAEVva_rA@mail.gmail.com>
 <20231122035304.57483-1-lizhe.67@bytedance.com> <ZWTORl4jMi9ODns1@alley>
In-Reply-To: <ZWTORl4jMi9ODns1@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Nov 2023 13:55:16 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UJc3Ln7KDXVfXfpmbWmmbp2v=1o4T_11nv2R=bWttZeQ@mail.gmail.com>
Message-ID: <CAD=FV=UJc3Ln7KDXVfXfpmbWmmbp2v=1o4T_11nv2R=bWttZeQ@mail.gmail.com>
Subject: Re: [RFC] softlockup: serialized softlockup's log
To:     Petr Mladek <pmladek@suse.com>
Cc:     lizhe.67@bytedance.com, akpm@linux-foundation.org,
        kernelfans@gmail.com, lecopzer.chen@mediatek.com,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        John Ogness <john.ogness@linutronix.de>
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

Hi,

On Mon, Nov 27, 2023 at 9:13=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> > I've tried several times, but unfortunately I haven't been able to
> > reproduce the problem you mentioned. My concern is that if the lock
> > is shared, there will be potential deadlock issues because hardlockup
> > exploits nmi.
>
> Yes, one has to be very careful when using locks under NMI.
> I am aware of three approaches:
>
>   1. It should be safe to use a lock which is used only in NMI.
>      The only problem might be ABBA deadlocks.
>
>      But this is not usable to serialize softlockup and hardlockup.
>
>
>   2. Using try_lock() in NMI and skipping the report when the lock
>      could not be taken.
>
>     But we probably should not skip the detailed info printed by the
>     hardlockup detector just because another softlockup or
>     hardlockup report is running in parallel.
>
>
>   3. Using a lock which might be nested on the same CPU.
>
>     It does not prevent mixed output completely. The nested
>     context will print the messages in the middle of the outer
>     one on the same CPU. But it would serialize output against
>     other CPUs.
>
>     There already is one used to serialize some backtraces,
>     see printk_cpu_sync_get_irqsave() in dump_stack_lvl() and
>     nmi_cpu_backtrace().
>
>     It should be safe when the locked code does not wait for
>     other CPUs. And when it is a leaf lock so that there
>     is no need to think about ABBA deadlocks against
>     other locks.
>
>     IMHO, printk_cpu_sync_get_irqsave() probably should be
>     safe to serialize the softlockup and hardlockup
>     detectors.
>
>
> Adding John into Cc. He is familiar with
> printk_cpu_sync_get_irqsave(). He wanted to use it also
> for synchronizing console drivers. Well, it will be done
> another way in the end.

Thanks for all the detailed info! Using printk_cpu_sync_get_irqsave()
looks pretty promising. I'll try to do some testing with this and then
aim to send a patch later this week that builds upon Li Zhe's patch.
If everything works out I'll probably remove the newly added spinlock
and use printk_cpu_sync_get_irqsave() instead, but the spinlock should
work fine in the short term in any case.

-Doug
