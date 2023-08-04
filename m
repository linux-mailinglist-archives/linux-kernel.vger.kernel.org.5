Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA9F76F7C7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjHDCVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjHDCUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C614482
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691115602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k9MPUsS9LKeZA9xUhJn9WI4fyyN2Ecl5BqHSfm/ZQkM=;
        b=cqT40ExWQCQcP40NtJQ3If0caSXVz2HvxquuYMfnoCfyab9W90cxm6eRlrXLyktp0PeHBR
        N0R9UH3YbCTUOYtU6CEbMS3wcIEYojQfjo6qB+4q4+ckCh7gZwl7rHZx4HkD4FTYwgTTRP
        JnaS8X7Arw69g2jbQuah0mWLKlcpno0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-sVanMi8GP6KzqJ1g7BUK6Q-1; Thu, 03 Aug 2023 22:20:01 -0400
X-MC-Unique: sVanMi8GP6KzqJ1g7BUK6Q-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40831789e55so18299721cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 19:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115600; x=1691720400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9MPUsS9LKeZA9xUhJn9WI4fyyN2Ecl5BqHSfm/ZQkM=;
        b=PLGMY8p3gFNrqg1KObCPlL28elsKTURFPkBG5UX6PDHBPOgRcsVaasKJi2mQbgrtEh
         +z0B8n/Gq8kNrP1EdT+laQZ6I1h2rHvwxz54Dwr2sAUeCgw5SIiurvtKXmqLXSPiqXSK
         r/sfoM/YtBW7kRT9LPjGvJkVi9QNKMb1bOCUsSoCNyWesjPh9BpmACYE0uDGMrb0RYbq
         ZlR1Q2Fzwrr1w8rBlXL2HhyXUQDxAFA4XKEE5fYVrqoCB4HYH/dN78PX95rVZILI5ecH
         cXjkISRzYbqLFPWwl+a/SYajOThzOV0eDIDIha/tWfYhRdIVdgjJtOICwMf7K2JF4tCU
         9xLg==
X-Gm-Message-State: AOJu0YzUId5wmsOWNxZSfHeennRVEH+GB7QZjK18dRlX402bvzWLes1U
        v6+MPETXMybgS7FkDgR1AoTaw6TJwP5Hczl/x0F0M+theV4ttJXM6rS6vnWebn6+vbZwtB6Ci0O
        J94/7QZdTcZFIpbFM+mTDaUqib3nHO9ocIGg/ItnZOBpZUyIjj2w=
X-Received: by 2002:a05:622a:11c1:b0:403:9e72:5e93 with SMTP id n1-20020a05622a11c100b004039e725e93mr691507qtk.9.1691115600724;
        Thu, 03 Aug 2023 19:20:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcGPylXNUCjdMCZunzjgYe6gHUKU7d0KRBYVhys4h+KsxLECchdEAao4TbRZpogi/6HAAcdy2vTjm9XSW2YFY=
X-Received: by 2002:a05:622a:11c1:b0:403:9e72:5e93 with SMTP id
 n1-20020a05622a11c100b004039e725e93mr691479qtk.9.1691115600415; Thu, 03 Aug
 2023 19:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230803051401.710236-2-leobras@redhat.com> <CAJF2gTShfMzVZw5TVqBvLNAzEBMzhWxNGC9JS70euPcKKN85zQ@mail.gmail.com>
In-Reply-To: <CAJF2gTShfMzVZw5TVqBvLNAzEBMzhWxNGC9JS70euPcKKN85zQ@mail.gmail.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Thu, 3 Aug 2023 23:19:49 -0300
Message-ID: <CAJ6HWG5mzxN=txnbdi-=c+=wLsDfSe7Me+1DQE79ZX0NN6U1_g@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 9:53=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Aug 3, 2023 at 1:14=E2=80=AFPM Leonardo Bras <leobras@redhat.com>=
 wrote:
> >
> > I unified previous patchsets into a single one, since the work is relat=
ed.
> >
> > While studying riscv's cmpxchg.h file, I got really interested in
> > understanding how RISCV asm implemented the different versions of
> > {cmp,}xchg.
> >
> > When I understood the pattern, it made sense for me to remove the
> > duplications and create macros to make it easier to understand what exa=
ctly
> > changes between the versions: Instruction sufixes & barriers.
> >
> > Also, did the same kind of work on atomic.c.
> >
> > Note to Guo Ren:
> > I did some further improvement after your previous reviews, so I ended
> > up afraid including your Reviewed-by before cheching if the changes are
> > ok for you. Please check it out again, I just removed some helper macro=
s
> > that were not being used elsewhere in the kernel.
> I found this optimization has conflicts with the below patches:
> https://lore.kernel.org/linux-riscv/20230802164701.192791-15-guoren@kerne=
l.org/
> https://lore.kernel.org/linux-riscv/20230802164701.192791-5-guoren@kernel=
.org/
>
> If yours merged, how do we support the inline cmpxchg/xchg_small
> function?

Oh, I actually introduced my series so I could introduce new xchg and
cmpxchg for size 1 and 2. Is that what your patches are about, right?

I was working on that yesterday, and decided to send the patchset
without them because I was still not sure enough.

About implementation strategy, I was introducing a new macros for xchg
& cmpxchg with asm which would work for both for size 1 & size 2, and
use the switch-case to create the mask and and_value.

You think that works enough?

> It's very struggling to use macros to implement complex
> functions.

I agree, but with this we can achieve more generic code, which makes
more clear what is the pattern for given function.

> Could you consider a more relaxed optimization in which we could
> insert inline cmpxchg/xchg_small?

What about this: I finish the patches I have been working with
(cmpxchg & xchg for sizes 1 and 2), and if they are fine we expand
this patchset with them.  If not, I try relaxing them a little so we
can merge with your set.

Does that work for you?

Best regards,
Leo


>
> >
> > Thanks!
> > Leo
> >
> >
> > Changes since squashed cmpxchg:
> > - Unified with atomic.c patchset
> > - Rebased on top of torvalds/master (thanks Andrea Parri!)
> > - Removed helper macros that were not being used elsewhere in the kerne=
l.
> >
> > Changes since (cmpxchg) RFCv3:
> > - Squashed the 6 original patches in 2: one for cmpxchg and one for xch=
g
> > https://lore.kernel.org/all/20230404163741.2762165-1-leobras@redhat.com=
/
> >
> > Changes since (cmpxchg) RFCv2:
> > - Fixed  macros that depend on having a local variable with a magic nam=
e
> > - Previous cast to (long) is now only applied on 4-bytes cmpxchg
> > https://lore.kernel.org/all/20230321074249.2221674-1-leobras@redhat.com=
/
> >
> > Changes since (cmpxchg) RFCv1:
> > - Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build err=
or
> > https://lore.kernel.org/all/20230318080059.1109286-1-leobras@redhat.com=
/
> >
> >
> > Leonardo Bras (3):
> >   riscv/cmpxchg: Deduplicate xchg() asm functions
> >   riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
> >   riscv/atomic.h : Deduplicate arch_atomic.*
> >
> >  arch/riscv/include/asm/atomic.h  | 164 ++++++++--------
> >  arch/riscv/include/asm/cmpxchg.h | 318 +++++--------------------------
> >  2 files changed, 123 insertions(+), 359 deletions(-)
> >
> > --
> > 2.41.0
> >
>
>
> --
> Best Regards
>  Guo Ren
>

