Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456D078BA53
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjH1Vds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjH1VdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:33:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49156FC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:33:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bf3f59905so473809966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693258388; x=1693863188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LTVfWBUstm/LcJQNRGzyJxx9fX5i3c498999odZFq5I=;
        b=ZOAllAzLQ4SEeGn08TheeBs8HxsbZzUG43pYhMuWguECpRsnVcCvis0DSRAmwzMrRu
         CxVZfBtsySHTgZp7TNkYhah3uu6i7qc1PD4cgOXjzK+Ps1k9wPTdZjm/WrmuvPDgVuOK
         CsUAt8pmzDDKCThV9uPdou0urIyuFoIAVPVm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693258388; x=1693863188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTVfWBUstm/LcJQNRGzyJxx9fX5i3c498999odZFq5I=;
        b=d54+C4Tovhvl2LUoDnOK3n6jfq+xTs7XGB3jlhTo+8pDBqUmxzG+LtZO2ibRJaAUlW
         6MemR+E4HMoAfaqsHvZ2xIcoSAF2q6R76n0f04+HnuxIxTbbf9n7faOvE5sx/WnbfnSD
         qmmADNBxvQtbznM32DWKypALgCgzbGuW3WB2+3TwHAZo6+dE2eJMJGqseoJJLlU21EtY
         5Ejd6ewt5fUlCqBCosxQPb8ahYnkmWhB+0P0/eQodLJODBZ9ErQb1MOD0wkP6w5HaV80
         ZuuwMopPE12BsFelIQGj4bzDexgZQLG4IMce3igTnah5vF999ipr1sCSMQzH66PXhfKT
         ncEA==
X-Gm-Message-State: AOJu0YzOgKKEMa5mqTPj6DXTbN1bUaEHJmgk4bmmJPpXJnHYuSPa44on
        H+LqD4QMxLNTkHQCJx4H3D+nlABI3kf8aGmic4buww==
X-Google-Smtp-Source: AGHT+IF/CLU2AlMSCbdznsZ2UNeVVZkCQ38a11tSsD+n8cumNW4t4iCfwQvWJnaMFP14I5yJ0EXK3Q==
X-Received: by 2002:a17:906:29a:b0:9a1:e231:67e5 with SMTP id 26-20020a170906029a00b009a1e23167e5mr10553238ejf.39.1693258388587;
        Mon, 28 Aug 2023 14:33:08 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id dk24-20020a170906f0d800b009937dbabbd5sm5085553ejb.220.2023.08.28.14.33.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 14:33:08 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99bf3f59905so473808266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:33:08 -0700 (PDT)
X-Received: by 2002:a17:906:76cf:b0:9a1:b98a:c723 with SMTP id
 q15-20020a17090676cf00b009a1b98ac723mr16317105ejn.4.1693258387851; Mon, 28
 Aug 2023 14:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <169322654636.420889.373907562030292433.tglx@xen13.tec.linutronix.de>
 <CAHk-=wjomZiu4QiyjAH=RSTsdZCpcjq-0yD42dLMN2+rcm4_cg@mail.gmail.com>
In-Reply-To: <CAHk-=wjomZiu4QiyjAH=RSTsdZCpcjq-0yD42dLMN2+rcm4_cg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Aug 2023 14:32:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiU+frgquJYSjkbQt+sQAshRrbg=9qnf7u58VKcjGgFA@mail.gmail.com>
Message-ID: <CAHk-=wgiU+frgquJYSjkbQt+sQAshRrbg=9qnf7u58VKcjGgFA@mail.gmail.com>
Subject: Re: [GIT pull] core/entry for v6.6-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 14:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Heh. Lovely. I wonder if we have other cases of #ifdef's that just
> aren't #define'd anywhere any more.
>
> But I'm too lazy and/or incompetent to write up some trivial script to check.

I shamed myself into writing two one-liner scripts to create a list of
identifiers we do 'ifdef' on, and another list of identifiers we
#define somewhere.

And then just run 'comm -13' on the two.

And it turns out to be useless, because even after I filter out our
config options (which get #define'd separately), we end up having a
ton of identifiers that we just expect to be set from outside,. or are
just random noise in drivers (some of it more random than others: the
spca501.c tests for ALTER_GAMA in addition to ALTER_GAMMA, which I
assume is just a typo).

Several of them seem to be quite reasonable (ie deflate has
UNALIGNED_OK, expecting people to use -DUNALIGNED_OK from the build),
but it does mean that at least my trivial "let's see what symbols we
test without ever defining" idea was just simplistic garbage.

As so many of my ideas are...

             Linus
