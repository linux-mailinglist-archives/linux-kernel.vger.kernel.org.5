Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400AC7B3D15
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 01:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjI2X5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 19:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjI2X5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 19:57:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328A6193
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 16:57:50 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-536071e79deso2692554a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 16:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696031868; x=1696636668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p6arnneMpUAz4OILpzifu1P4tUCrP8Vk4FTrbxGUOVI=;
        b=cWkblA4hgsbrGfxjhWGgeDyWlrS/T0c6Yfn0uf8ITG2GVx9uryE2k4DMpUgVLEUfjb
         ZdF5iri8eDgK+OnNh1or4m6YZym769+B7Ro/IJ20hVJgTXodJZHMF59QYvtdKcLEQhL9
         BClbsYbvDZkAyISUmuOLtP5NLVnygiY5vDpT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696031868; x=1696636668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6arnneMpUAz4OILpzifu1P4tUCrP8Vk4FTrbxGUOVI=;
        b=tEGTU2TD98viFdXAFAJNfrY75Ohz2oHNbuskJyj3H0C3PzpR2QI0rQn4vyUPV5b9pb
         F/SZuBUVzfXn3g2/U0OhW2t/zWehJLCaFYHv4pZhLlhG6JYYQma6mFkclxiUFMBag7p5
         FYEtFOP5pnMBUEXePbPH1z3gQjI9wBuHoPmsQWBGbAvH2LdV3jjGFUf/pI5xaLq1aA3J
         CMR488XvQhmN8C3NTYkYEIRp4XMtQOC0Kcr7VDGDVkjUHZo/wgMdWuCSKYh11bbx5a64
         dIEMadJY05Hhf6o2GX+prz3fEQGKWtuxGA1h4uBEwTeRXLfXunO9R0kbcTXmrzFQ4F8Z
         DRgg==
X-Gm-Message-State: AOJu0Yw25uTuKMA0r1UJiBS8iyLeuDwZLzKkvaIgJZpc4eTITX63zJU7
        BWHiQr5G0jQuxSRBfv86G6KcD93eDZ4g8eiOBB1zy/YCrG0=
X-Google-Smtp-Source: AGHT+IGdFjGzQveMJvJEg8hbOhBmS38pdi4EIOm62RIFKe9Hwom1RV7c3kvnGQaf0jDztIM58HKi7Q==
X-Received: by 2002:a05:6402:42c3:b0:522:405f:a7 with SMTP id i3-20020a05640242c300b00522405f00a7mr5134780edc.16.1696031868481;
        Fri, 29 Sep 2023 16:57:48 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id dm3-20020a05640222c300b0053635409213sm2653766edb.34.2023.09.29.16.57.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 16:57:47 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9b275afb6abso268376166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 16:57:47 -0700 (PDT)
X-Received: by 2002:a17:907:6092:b0:9a5:c38d:6b75 with SMTP id
 ht18-20020a170907609200b009a5c38d6b75mr5518234ejc.15.1696031866848; Fri, 29
 Sep 2023 16:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
 <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
 <ZRR1Kc/dvhya7ME4@f> <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
 <20230928-kulleraugen-restaurant-dd14e2a9c0b0@brauner> <20230928-themen-dilettanten-16bf329ab370@brauner>
 <CAG48ez2d5CW=CDi+fBOU1YqtwHfubN3q6w=1LfD+ss+Q1PWHgQ@mail.gmail.com>
 <CAHk-=wj-5ahmODDWDBVL81wSG-12qPYEw=o-iEo8uzY0HBGGRQ@mail.gmail.com>
 <20230929-kerzen-fachjargon-ca17177e9eeb@brauner> <CAG48ez2cExy+QFHpT01d9yh8jbOLR0V8VsR8_==O_AB2fQ+h4Q@mail.gmail.com>
 <20230929-test-lauf-693fda7ae36b@brauner> <CAGudoHHwvOMFqYoBQAoFwD9mMmtq12=EvEGQWeToYT0AMg9V0A@mail.gmail.com>
 <CAGudoHHuQ2PjmX5HG+E6WMeaaOhSNEhdinCssd75dM0P+3ZG8Q@mail.gmail.com>
In-Reply-To: <CAGudoHHuQ2PjmX5HG+E6WMeaaOhSNEhdinCssd75dM0P+3ZG8Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Sep 2023 16:57:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wir8YObRivyUX6cuanNKCJNKvojK0p2Rg_fKyUiHDVs-A@mail.gmail.com>
Message-ID: <CAHk-=wir8YObRivyUX6cuanNKCJNKvojK0p2Rg_fKyUiHDVs-A@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jann Horn <jannh@google.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Fri, 29 Sept 2023 at 14:39, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> So to be clear, obtaining the initial count would require a dedicated
> accessor.

Please, no.

Sequence numbers here are fundamentally broken, since getting that
initial sequence number would involve either (a) making it something
outside of 'struct file' itself or (b) require the same re-validation
of the file pointer that the non-sequence number code needed in the
first place.

We already have the right model in the only place that really matters
(ie fd lookup). Using that same "validate file pointer after you got
the ref to it" for the two or three other cases that didn't do it (and
are simpler: the exec pointer in particular doesn't need the fdt
re-validation at all).

The fact that we had some fd lookup that didn't do the full thing that
a *real* fd lookup did is just bad. Let's fix it, not introduce a
sequence counter that only adds more complexity.

          Linus
