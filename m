Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18D1791044
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 05:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350961AbjIDDHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 23:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjIDDHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 23:07:45 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A096810E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 20:07:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50078e52537so1614878e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 20:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693796860; x=1694401660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t9x9/Aqy0Q3Hq7H8kkvHt4T4iDLN9ojDkJfODIFW/SI=;
        b=QXGVpq3FHJzYEmkPBLzwuZzv5jW2osH5HBsGPvmCByl7SUBGvR56n9mUN1wDAcfvSI
         vwc9zVfOdBly9J8n0mEq+Oob8LUSizsLw/sTtfBK4BjEaMgwSZmt0BJC2NlTn2XtfRyC
         hwrISoCMHcOZ5svdprzICFFjcWh8OR6RQmRWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693796860; x=1694401660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9x9/Aqy0Q3Hq7H8kkvHt4T4iDLN9ojDkJfODIFW/SI=;
        b=jq45QcNJGwh2j9V5PoieL9b7bKhI8rYGV51qLqoUpKJF1Ku0jN2wLs2TofX5OazD+C
         37+4XAZFKYkgRh2YSK9BcSPMRqVuFo8s1q7SAP3rHMxsQujmOGM1tGqylHZauEjUOWQQ
         3KjRAIGOzrCyk7sXcLYpXfnzVpQfqbeJePCc4ukNuNfV62eXymdIIzjCHzYMiVuQUBFA
         HutFpgEgfhCk4UHywENaoGyBjS8L+PxMTpl7JzJsn0gAv2fnqwZBelT7b7Z7LwCNmWCH
         4cVC0TlYSvnUxIXIRF5m6cF5gTBHcAUa0zSnZufn0B8OvFNWoQC5AnkipAvx5sxyLBnL
         Tn/A==
X-Gm-Message-State: AOJu0YxQV6QKnFxSIZnSaqB3EvT1JD1CusBuBf4eKDzyyIvI2O3b9Meb
        x3RBJuhZXsROIqZjBC1pBL4c3eR9LdzJT26FZqIxFV/T
X-Google-Smtp-Source: AGHT+IHUEY1ZYCUsHkBdluoL72zlCZFTBv/haQnz2KMJ1gHkb7eKlOciznmHU038hHQJchlH0b4H+w==
X-Received: by 2002:a19:2d17:0:b0:500:9a45:636 with SMTP id k23-20020a192d17000000b005009a450636mr4947382lfj.13.1693796859834;
        Sun, 03 Sep 2023 20:07:39 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id q1-20020ac25141000000b004ff9f88b86esm1508404lfd.308.2023.09.03.20.07.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 20:07:38 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2bd0a5a5abbso14168501fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 20:07:38 -0700 (PDT)
X-Received: by 2002:ac2:5499:0:b0:4fb:91c5:fd38 with SMTP id
 t25-20020ac25499000000b004fb91c5fd38mr5699314lfk.0.1693796858205; Sun, 03 Sep
 2023 20:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
 <ZPT/LzkPR/jaiaDb@gmail.com> <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
 <CAGudoHG1_r1B0pz6-HUqb6AfbAgWHxBy+TnimvQtwLLqkKtchA@mail.gmail.com>
In-Reply-To: <CAGudoHG1_r1B0pz6-HUqb6AfbAgWHxBy+TnimvQtwLLqkKtchA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Sep 2023 20:07:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjM6KwAvC9+sCAm9BgBSspZm60VBLzHcuonGcHrPKJrbw@mail.gmail.com>
Message-ID: <CAHk-=wjM6KwAvC9+sCAm9BgBSspZm60VBLzHcuonGcHrPKJrbw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, bp@alien8.de
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

On Sun, 3 Sept 2023 at 16:15, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> bad news: virtually no difference for stat(2) (aka newfstatat)
> before:  3898139
> after: 3922714 (+0%)

Yeah, the path lookup is way more expensive than a slight win in a L1
copy, and the pathname lookup will also have gone much deeper on the
stack.

> ok news: a modest win for the actual fstat system call (aka newfstat,
> *not* the libc wrapper calling newfstatat)
> before: 8511283
> after: 8746829 (+2%)

We might end up with slightly less deep stack, so potentially a
smaller cache footprint, and there is much less other stuff going on..

> The patch as proposed is kind of crap -- moving all that handling out
> of fs/stat.c is quite weird and trivially avoidable, with a way to do
> it already present in the file.

So you say. I claim that you're full of crap.

Try it and you'll see it is not even *remotely* as easy as you claim.
Not when you have to deal with random sizes and padding of 20+
different architectures.

             Linus
