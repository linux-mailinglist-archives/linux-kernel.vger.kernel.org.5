Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390267660BE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjG1AYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjG1AX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:23:58 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBF5BF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:23:57 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso1378029276.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690503836; x=1691108636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcj+3z3CVbuBGBRuj/7fCoy99WoBx7sCuEmut4Zlw60=;
        b=r7Tn0OuqEg5YHM7yqlrrqTuTizuHUxv4h/N9Z98HzU/PBy1sCY5dhKtMklIIy5qvGP
         OS94Ifwgj8OGqExfZODklFgrf4GV4yLQtRP5S6CJWiW7P9r6lenJGMHtewsL7EFy2gRv
         7e+N1S3sWYB13slekvOVfKgg2dfyXGZfHlr/F/CbSO6IkrabsRqiaS/NwX5RKuo+AgT/
         lIPNha+WwO43X5Xt/ykaBQe/+OKixR+YW3ZBjnoBx4jiT9PYlLn9G+asQpRUch5sSjls
         dLSyEjSQtHrbBBJRQGgzMrDNrN9Kx2HFwdYs/cDcPC0mFAY3SjSO1eBbOyn5zT05if2O
         delw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690503836; x=1691108636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcj+3z3CVbuBGBRuj/7fCoy99WoBx7sCuEmut4Zlw60=;
        b=k+S/wJDcbWDCTRgwCO3yBT2Cs8vB0X6LL3WiOsohHyH9suv6rCRs+xv6TGfH3sWVwJ
         EpaMCFtALUjXNCr1MrB1W+3GKYJ9Hl2BoGhXvPPKqxAs0cm7ZGjXAepDfIVOA5QbrqF5
         Ea8otuTi2YcfUA2AGoXG8ud4IOovgi7ci0ECxgWt+M5xys9iOcSq4lWr8kSrGJTpvN18
         hNV1bDuQDWWGow0KXYNBL+TAAgv+ZIxih9LgxjyV/KZuQma90AYyn7Jq5PTbqWpA9WZi
         O7p+ajqGeL8BKy8ThXfV0v/WCvU0Ngz88vCV+pobRiQe30ZJ1kbbvJTi4CmH8tSwFc+j
         ZMLw==
X-Gm-Message-State: ABy/qLaBTdHHDNmJxRDLXc4mtoLZGyKAfoVOn256wR9qdBIh7BrJbD0f
        JZgUyAB3ScUuPoiLBqykCke7whFVb4vtT2NbqyI5/Q==
X-Google-Smtp-Source: APBJJlEJkbY3Nbq3mVmu2HVX20gcYgvh1pwPitsD+bAbZZGjYZxQO2Xb3309J/ez40H7ZF7gnBiG4jgOUABf/BR4KCc=
X-Received: by 2002:a25:c512:0:b0:c5d:1407:f2bc with SMTP id
 v18-20020a25c512000000b00c5d1407f2bcmr221118ybe.17.1690503836119; Thu, 27 Jul
 2023 17:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230728091849.7f32259d@canb.auug.org.au> <ZMMCnvc3h7XT/NM2@casper.infradead.org>
 <20230728102022.7593856b@canb.auug.org.au>
In-Reply-To: <20230728102022.7593856b@canb.auug.org.au>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 27 Jul 2023 17:23:45 -0700
Message-ID: <CAJuCfpHzz3f8Ru7C03b-TVi0g1gcMOEkd2v=ayNunEEs6cjZxg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 5:21=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi Matthew,
>
> On Fri, 28 Jul 2023 00:49:50 +0100 Matthew Wilcox <willy@infradead.org> w=
rote:
> >
> > On Fri, Jul 28, 2023 at 09:18:49AM +1000, Stephen Rothwell wrote:
> > > diff --cc mm/memory.c
> > > index ca632b58f792,271982fab2b8..000000000000
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@@ -5392,32 -5597,18 +5597,21 @@@ retry
> > >     if (!vma)
> > >             goto inval;
> > >
> > > -   /* Only anonymous and tcp vmas are supported for now */
> > > -   if (!vma_is_anonymous(vma) && !vma_is_tcp(vma))
> > >  -  /* find_mergeable_anon_vma uses adjacent vmas which are not locke=
d */
> > >  -  if (vma_is_anonymous(vma) && !vma->anon_vma)
> > > --          goto inval;
> > > --
> > >     if (!vma_start_read(vma))
> > >             goto inval;
> > >
> > >  +  /*
> > >  +   * find_mergeable_anon_vma uses adjacent vmas which are not locke=
d.
> > >  +   * This check must happen after vma_start_read(); otherwise, a
> > >  +   * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the=
 VMA
> > >  +   * from its anon_vma.
> > >  +   */
> > > -   if (unlikely(!vma->anon_vma && !vma_is_tcp(vma)))
> > > -           goto inval_end_read;
> > > -
> > > -   /*
> > > -    * Due to the possibility of userfault handler dropping mmap_lock=
, avoid
> > > -    * it for now and fall back to page fault handling under mmap_loc=
k.
> > > -    */
> > > -   if (userfaultfd_armed(vma))
> > > ++  if (unlikely(vma_is_anonymous(vma) && !vma_is_tcp(vma)))
> > >  +          goto inval_end_read;
> > >  +
> >
> > No, this isn't right.  It should be:
> >
> >       if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
> >               goto inval_end_read;
>
> Yeah, see my second attempt.
>
> > I'm not sure about the userfaultfd_armed() clause.  My patch wasn't
> > intended to affect that.
>
> That was removed by commit
>
>   69f6bbd1317f ("mm: handle userfaults under VMA lock")
>
> in the mm branch.


Hmm. 657b5146955e ("mm: lock_vma_under_rcu() must check vma->anon_vma
under vma lock") should be adding a "inval_end_read" label. At least I
see it in https://lore.kernel.org/all/20230726214103.3261108-3-jannh@google=
.com/
and will check Linus' tree in a min. I don't see that label in your
patch...
I also misspoke in my previous message. The patches in mm tree remove
some code from that function, so it's easier to apply them first and
then the one from Linus' tree.

>
> --
> Cheers,
> Stephen Rothwell
