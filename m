Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD0C76FBA4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjHDIGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjHDIGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055514687
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691136325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VofZULzxpJMYd+uZzeF2azmhZUsdcjOUcKOHUNEppE0=;
        b=SEn0XlEGOB/0OihEQ0ht293AwZ77QHxs4MOhkNarqAUjQ2A4I5Yapq57wV3+feB0yHcytx
        2of8cOdQoWyn2m0LFjgACeNZ39wZMryy2oLKxGswKkN8aRlYvEgKaeoSl0exbL0TmYOb0e
        5KNymVh9WTKPsaGFCzTiesrXg0zW0fA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-jrX7WfhiPQ-_L4Y93rUELA-1; Fri, 04 Aug 2023 04:05:23 -0400
X-MC-Unique: jrX7WfhiPQ-_L4Y93rUELA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-40c10c73650so24061371cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691136323; x=1691741123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VofZULzxpJMYd+uZzeF2azmhZUsdcjOUcKOHUNEppE0=;
        b=CGmeY9nFFVjsho5+/rZHuMc6FjnwXN3ZsaN3DA4Y1B3XE6Kng65jpRPJrbjddm2r/S
         TTKoyvtzFPMz3WEENHlFgT/QqnMi2k5CIa49A02EI4StJZNBNCNc6y7A3lAAmku1B81v
         3iifKKxH4bMrUTgBUqqHzA1S6wo9t9I/Jz6W8EyONHBf2QAIP8U0x7INpHOwGz57krjt
         9z/0o28FYMTY3ivNsNIa5x/oTVXkO7tgP6lY4ApM1yP4G4fIBm/qc4k5aEKqD59G0PgN
         aJx/1xIur/c78A58L9aqff4ET100+lTvlEjAhGd9dgTxB+rwrFOHv+et9D71iQ3whVt6
         4wwg==
X-Gm-Message-State: AOJu0Yxs7V/JwDPuqNoTV37LKJ4SF5scHAUpuIwGZAsMdDMhRrF7G/Ke
        mb0sLqL8VEo/SNPcXIWgTcNPBaahKJtuTO1nS39MwxqioXHRz5UgTD6c8qSNjZNv+bVF9cjYjh/
        wAWPzEogQ7e1CQrD2Qla7IqNGjDELa5kLhQM8Hbp+
X-Received: by 2002:a05:622a:1488:b0:403:ad6d:fbbb with SMTP id t8-20020a05622a148800b00403ad6dfbbbmr1252888qtx.14.1691136323200;
        Fri, 04 Aug 2023 01:05:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH05FVpFTdwqmIx8uI2Izje4VI7Tylz6J6OaYPyWqXQHH9xaqoXg8Iq2F98PsZ6YLp4Fq85SyQDuYedJdGKDY=
X-Received: by 2002:a05:622a:1488:b0:403:ad6d:fbbb with SMTP id
 t8-20020a05622a148800b00403ad6dfbbbmr1252874qtx.14.1691136322947; Fri, 04 Aug
 2023 01:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230803051401.710236-2-leobras@redhat.com> <CAJF2gTShfMzVZw5TVqBvLNAzEBMzhWxNGC9JS70euPcKKN85zQ@mail.gmail.com>
 <CAJ6HWG5mzxN=txnbdi-=c+=wLsDfSe7Me+1DQE79ZX0NN6U1_g@mail.gmail.com> <CAJF2gTTag3hR7ZgM8o+yk+0Ox3A+xm4jAVTikAA0HqXQFKayRA@mail.gmail.com>
In-Reply-To: <CAJF2gTTag3hR7ZgM8o+yk+0Ox3A+xm4jAVTikAA0HqXQFKayRA@mail.gmail.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Fri, 4 Aug 2023 05:05:11 -0300
Message-ID: <CAJ6HWG6ofyiLRq-HZFmocxPFzQhM+HwBQVOqwp-XSfctFHLNTQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Deduplicate RISCV cmpxchg.h and atomic.c macros
To:     Guo Ren <guoren@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 11:29=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> On Fri, Aug 4, 2023 at 10:20=E2=80=AFAM Leonardo Bras Soares Passos
> <leobras@redhat.com> wrote:
> >
> > On Thu, Aug 3, 2023 at 9:53=E2=80=AFPM Guo Ren <guoren@kernel.org> wrot=
e:
> > >
> > > On Thu, Aug 3, 2023 at 1:14=E2=80=AFPM Leonardo Bras <leobras@redhat.=
com> wrote:
> > > >
> > > > I unified previous patchsets into a single one, since the work is r=
elated.
> > > >
> > > > While studying riscv's cmpxchg.h file, I got really interested in
> > > > understanding how RISCV asm implemented the different versions of
> > > > {cmp,}xchg.
> > > >
> > > > When I understood the pattern, it made sense for me to remove the
> > > > duplications and create macros to make it easier to understand what=
 exactly
> > > > changes between the versions: Instruction sufixes & barriers.
> > > >
> > > > Also, did the same kind of work on atomic.c.
> > > >
> > > > Note to Guo Ren:
> > > > I did some further improvement after your previous reviews, so I en=
ded
> > > > up afraid including your Reviewed-by before cheching if the changes=
 are
> > > > ok for you. Please check it out again, I just removed some helper m=
acros
> > > > that were not being used elsewhere in the kernel.
> > > I found this optimization has conflicts with the below patches:
> > > https://lore.kernel.org/linux-riscv/20230802164701.192791-15-guoren@k=
ernel.org/
> > > https://lore.kernel.org/linux-riscv/20230802164701.192791-5-guoren@ke=
rnel.org/
> > >
> > > If yours merged, how do we support the inline cmpxchg/xchg_small
> > > function?
> >
> > Oh, I actually introduced my series so I could introduce new xchg and
> > cmpxchg for size 1 and 2. Is that what your patches are about, right?
> >
> > I was working on that yesterday, and decided to send the patchset
> > without them because I was still not sure enough.
> >
> > About implementation strategy, I was introducing a new macros for xchg
> > & cmpxchg with asm which would work for both for size 1 & size 2, and
> > use the switch-case to create the mask and and_value.
> >
> > You think that works enough?
> Good, go ahead.
>
> >
> > > It's very struggling to use macros to implement complex
> > > functions.
> >
> > I agree, but with this we can achieve more generic code, which makes
> > more clear what is the pattern for given function.
> >
> > > Could you consider a more relaxed optimization in which we could
> > > insert inline cmpxchg/xchg_small?
> >
> > What about this: I finish the patches I have been working with
> > (cmpxchg & xchg for sizes 1 and 2), and if they are fine we expand
> > this patchset with them.  If not, I try relaxing them a little so we
> > can merge with your set.
> >
> > Does that work for you?
> Great, you could provide cmpxchg & xchg for sizes 1 and 2, then my
> patch series would base on yours. After tested, I would give you
> Tested-by.

Awesome! Thanks!

I will send it shortly, just compile-testing the kernel.

> >
> > Best regards,
> > Leo
> >
> >
> > >
> > > >
> > > > Thanks!
> > > > Leo
> > > >
> > > >
> > > > Changes since squashed cmpxchg:
> > > > - Unified with atomic.c patchset
> > > > - Rebased on top of torvalds/master (thanks Andrea Parri!)
> > > > - Removed helper macros that were not being used elsewhere in the k=
ernel.
> > > >
> > > > Changes since (cmpxchg) RFCv3:
> > > > - Squashed the 6 original patches in 2: one for cmpxchg and one for=
 xchg
> > > > https://lore.kernel.org/all/20230404163741.2762165-1-leobras@redhat=
.com/
> > > >
> > > > Changes since (cmpxchg) RFCv2:
> > > > - Fixed  macros that depend on having a local variable with a magic=
 name
> > > > - Previous cast to (long) is now only applied on 4-bytes cmpxchg
> > > > https://lore.kernel.org/all/20230321074249.2221674-1-leobras@redhat=
.com/
> > > >
> > > > Changes since (cmpxchg) RFCv1:
> > > > - Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build=
 error
> > > > https://lore.kernel.org/all/20230318080059.1109286-1-leobras@redhat=
.com/
> > > >
> > > >
> > > > Leonardo Bras (3):
> > > >   riscv/cmpxchg: Deduplicate xchg() asm functions
> > > >   riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
> > > >   riscv/atomic.h : Deduplicate arch_atomic.*
> > > >
> > > >  arch/riscv/include/asm/atomic.h  | 164 ++++++++--------
> > > >  arch/riscv/include/asm/cmpxchg.h | 318 +++++----------------------=
----
> > > >  2 files changed, 123 insertions(+), 359 deletions(-)
> > > >
> > > > --
> > > > 2.41.0
> > > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> > >
> >
>
>
> --
> Best Regards
>  Guo Ren
>

