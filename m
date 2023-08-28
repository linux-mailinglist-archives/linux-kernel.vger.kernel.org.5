Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8275D78B6EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjH1SAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjH1SAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:00:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECC510D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:00:35 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so4762210a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693245634; x=1693850434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u3tQzITOp3UmLvv7KUe5rAM9jaal7noztUAimtSvj2Q=;
        b=DMQ1R9CO596dmrmCmY1p9PQAUFNqCK9kR58Et5NfiQhl5qvvZ9BgDDvyoaRn8shKKH
         zHv+/7AHvbHZdWKpmyLNEKwLPSZ5ohMoXUmaI5fMonJxzQOsbP7yvYKgmm2CrHqSx1su
         LA9Skjzl7be4WUXjDUFAhntlvVp++UUtLSevg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693245634; x=1693850434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3tQzITOp3UmLvv7KUe5rAM9jaal7noztUAimtSvj2Q=;
        b=XlOYOxIkAu5gxAB+Fbu8xdm7SD/QLqn8q30+SRC6sNeYdQjFZDEtxygA4PVyJGucu6
         fG+HtGSQq0ZGGIOJhY587z6sxZhHjHhVlIaC4wOVL7tRHcva8z2WxCf48zLS2FAOcRq+
         c+AOGIX7BfvXbD754G06c/1jLvp3JnQUmnWt+5e/Q2Z61Lbhc0hWczPQDyUktRjFRC+A
         brI52VBQd77xcdrR7rAHDvPSJv1a/kdEEW0HS0WWi2k+ss47vd19jMWXzRr9c5RP/O+P
         PevFRfuU7uwFVGgPkH8jGEdxKTQCzbFhPmVBht376KIFCuUvafVbate8TOwyO6Kpr6eM
         x/tw==
X-Gm-Message-State: AOJu0YxrIYBW51wpvZKCri8IyNiAJIjeIVwgQ6CyJM8pW3gx3ab224xk
        G5aQ5F3KnkYRB5Ck5bcHlF7V/YtN9LnImY+TtDGzAw==
X-Google-Smtp-Source: AGHT+IHLqjuouZR7g6Ta+9GadsOcs9t2BogoQIJrQBc8AIPLuNXDBXE3y/hXYP1mILQ86cfSmUp3XA==
X-Received: by 2002:a05:6402:3447:b0:523:1004:1ca0 with SMTP id l7-20020a056402344700b0052310041ca0mr23789340edc.5.1693245633961;
        Mon, 28 Aug 2023 11:00:33 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id y22-20020a056402135600b005255f5735adsm4683733edw.24.2023.08.28.11.00.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 11:00:33 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-99bfcf4c814so453951966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:00:33 -0700 (PDT)
X-Received: by 2002:a17:907:75d8:b0:9a5:821e:1655 with SMTP id
 jl24-20020a17090775d800b009a5821e1655mr6390140ejc.71.1693245632605; Mon, 28
 Aug 2023 11:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230828170732.2526618-1-mjguzik@gmail.com>
In-Reply-To: <20230828170732.2526618-1-mjguzik@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Aug 2023 11:00:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1BO1KQaPOTzs7N4QrLh2UCiRuNnW0MPVTDLrRxZhDww@mail.gmail.com>
Message-ID: <CAHk-=wi1BO1KQaPOTzs7N4QrLh2UCiRuNnW0MPVTDLrRxZhDww@mail.gmail.com>
Subject: Re: [PATCH] x86: bring back rep movsq for user access on CPUs without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
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

On Mon, 28 Aug 2023 at 10:07, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> While here make sure labels are unique.

I'll take a look at the other changes later, but this one I reacted
to: please don't do this.

It's a disaster. It makes people make up random numbers, and then
pointlessly change them if the code moves around etc.

Numeric labels should make sense *locally*.  The way to disambiguate
them is to have each use just have "f" and 'b" to distinguish whether
it refers forward or backwards.

And then just keep the numbering sensible in a *local* scope, because
the "file global" scope is just such a complete pain when you
pointlessly change the numbering just because some entirely unrelated
non-local thing changed.

And yes, you can see some confusion in the existing code where it uses
0/1/2/3, and that was because I just didn't consistently put the
exception table entries closer, and then moved things around.  So the
current code isn't entirely consistent either, but let's once and for
all make it clear that the sequential numbering is wrong, wrong,
wrong.

The numeric labels should not use sequential numbers, they should use
purely "locally sensible" numbers., and the exception handling should
similarly be as locally sensible as possible.

And if you use complicated numbering, please make the numbering be
some sane visually sensible grouping with commentary (ie that unrolled
'movq' loop case, or for an even nastier case see commit 034ff37d3407:
"x86: rewrite '__copy_user_nocache' function").

So if anything, the existing 2/3 labels in that file should be made
into 0/1. Because I've seen way too many of the "pointlessly renumber
lines just to sort them and make them unique".

I used to do that when I was twelve years old because of nasty BASIC
line numbering.

I'm a big boy now, all grown up, and I don't want to still live in a
world where we renumber lines because we added some code in the
middle.

The alternative, of course, is to use actual proper named labels. And
for "real assembly code" that is obviously always the right solution.

But for exception table entries or for random assembler macros, that's
actually horrendous.

The numeric labels literally *exist* to avoid the uniqueness
requirements, exactly because for things like assembler macros, you
want to be able to re-use the same (local) label in a macro expansion
multiple times.

So trying to make numeric labels unique is literally missing the
entire *point* of them.

                 Linus
