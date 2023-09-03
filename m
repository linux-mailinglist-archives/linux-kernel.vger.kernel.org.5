Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79905790D96
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 20:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345904AbjICSuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 14:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245005AbjICSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 14:50:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76E6C6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 11:50:17 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bd0d19a304so11997081fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 11:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693767016; x=1694371816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=//s30MSIWsrHQoIMTLpp7oeLM2VNMMYIf4n8S/OD/KE=;
        b=fwRThjGj/OjVYVVpEbT+ovpjzj11p4FFstMK4cljwbaKyJ8PaQUHPWFzXiVApi6uTq
         ZUyJH5olsNqv8kThJUEN8ckZnWmdrGoA5TPGz5ZTr6IBhWYhbPEAQC9xlldWMbMh7Hp3
         iTojrqB6iOzi9ltOUsJ5rXvZiES/cLO/v3QSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693767016; x=1694371816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//s30MSIWsrHQoIMTLpp7oeLM2VNMMYIf4n8S/OD/KE=;
        b=S4AsQB+/+Qfcq3XVx+kiglaoHEjRZ7kMVzxwKjcxJgW1afLVn3YpZlc0/W+j5uAcAV
         a4AqTIqgG14n/MFxZ7lRhaTT5iUJ5Lrg7FP/f8H1KJb5FATKikqk5FvdFhwfrbWbzC8Z
         ek2vzW80eCihbYrAdpfgNctJDsi2RZ+kvxIJ1Qd2IUflLYsXPGBAmrLCow726wcHGigD
         sNd3N9ey+SiVyzPcgK/0HelKz/bJ7zw+uLHejliL1vRAW5LsIYG5vQwjKFOx0cb26MpK
         8BNKBSg8wRJZ1WV1X4dB05yIcAknwzagW2h9BwTv0LE32mAoVteDfBqGNM1x3FJznH40
         ciIg==
X-Gm-Message-State: AOJu0YyqCsnHEcfDLUGXtkK67duB1KOKTbPYivQCD1KrLpsZOVw5glGG
        v9uwYUtfSHNUDsEYXKT2ulJdN0MqZpNStSfo9pDnzxJN
X-Google-Smtp-Source: AGHT+IGS5cNLyIqvmorD/IFFKrXeWJQykCMViDQU7yCJ9cac2YWba4oIiU9fyG/U3hE9t+4Wd6yqTQ==
X-Received: by 2002:a2e:8608:0:b0:2bc:dada:dbe0 with SMTP id a8-20020a2e8608000000b002bcdadadbe0mr5887937lji.10.1693767016079;
        Sun, 03 Sep 2023 11:50:16 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id j6-20020a2e3c06000000b002bcd94f9714sm1679674lja.126.2023.09.03.11.50.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 11:50:14 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so11893011fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 11:50:14 -0700 (PDT)
X-Received: by 2002:a2e:98cd:0:b0:2bc:d607:4d1f with SMTP id
 s13-20020a2e98cd000000b002bcd6074d1fmr5171524ljj.44.1693767014063; Sun, 03
 Sep 2023 11:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
In-Reply-To: <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Sep 2023 11:49:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
Message-ID: <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sept 2023 at 08:20, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I'm going to patch this, but first I want to address the bigger
> problem of glibc implementing fstat as newfstatat, demolishing perf of
> that op. In their defense currently they have no choice as this is the
> only exporter of the "new" struct stat. I'll be sending a long email
> to fsdevel soon(tm) with a proposed fix.

This ended up nagging me, and I looked it up.

You are correct that glibc seems to implement 'fstat()' as
'newfstatat(..AT_EMPTY_PATH)', which is a damn shame. We could
short-circuit that, but we really shouldn't need to.

Because you are incorrect when you claim that it's their only choice.
We have a native 'newfstat()' that glibc *should* be using.

We've had 'newfstat()' *forever*. It predates not just the git tree,
but the BK tree before it.

In fact, our 'newfstat()' system call goes back to Linux-0.97 (August
1, 1992), and yes, back then it really took a 'struct new_stat' as the
argument.

So I have no idea why you claim that "currently they have no choice".
glibc is simply being incredibly stupid, and using newfstatat() for no
good reason.

How very very annoying.

I guess we can - and now probably should - short-circuit the "empty
path with AT_EMPTY_PATH" case, but dammit, we shouldn't _need_ to.

Only because of excessive stupidity in user space does it look like we
should do it.

Why _is_ glibc doing that thing?

              Linus

PS. On 32-bit x86, we also have 'stat64', but that has native
'fstat64()' support too, so that's no excuse. And it actually uses our
'unsafe_put_user()' infrastructure to avoid having to double copy,
mainly because it doesn't need to worry about the padding fields like
the generic 'cp_new_stat' does.
