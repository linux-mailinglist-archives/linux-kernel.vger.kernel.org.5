Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9397B5796
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbjJBP4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbjJBPzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:55:54 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174DEE5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:55:44 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d849df4f1ffso18308421276.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696262143; x=1696866943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mnaiR8TXXIrREj/0Esj6L2AmB5bef0JgMh7T1K6lR8=;
        b=XRIwf0Pw2tJPsXjoeVGJv+OYAFYoBYoTOrgc7vEzsLzvSe2ZW6a8F2OB9uc3z4MAqT
         bWmTFfAbwFoULRPDH+C0+fMaY8TxLLHiEIdrZ6u260ykGAYljMDgngcqe/5XcVqo0Grj
         9nclEaPaAaeqHntS/vf36QyofOFk6LH1memcOUvooOMwSgD5uLiKXsQr5L53JTn3FsRL
         /hf9de11r8+IhcyL/8nWZeBdsJFIFN3UcdsSPP22CokJs9Xn8oZn5S9IJrAjUV09vhFa
         G7AS3YeXnjgUsvdjPwDWwo4+UuSuQfIXLrv1uNyQv1LkKfoVGZ+X8em5VyeHjwzBvzTN
         6Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696262143; x=1696866943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mnaiR8TXXIrREj/0Esj6L2AmB5bef0JgMh7T1K6lR8=;
        b=SO/+qLbQBtT/fFLrtHZo+isMVjqctc39XFMBbewy/hJAvqZL3rB9+0spDgITSEMC/b
         VjU1VEL8+heGGJEkpK+uPJ3rpAiShELoV47Ybhu9Ve+bJEn3TevQQCYACu6gT8CATNyU
         HnhpEbDsdpae3FVTg/oRKqr9QS3dAN1DeJ94Xx+AXmfmPjpN8ooACrRSZ+K9bR+YPKyi
         J9LxP7y8ELNAZO/N6gF+ZOyI4NNYLwkBK8p4zoJTwD5dgMPm6B3fXF+j7/yhtI3tV4em
         24RzGutKKpeHSqs2Mkv588YKC65CmDlIRmFgTEfCsBXqEesiV4Qwr6sPs6fi09qrbrt2
         zZPQ==
X-Gm-Message-State: AOJu0Yz231iBE4sBB+gqS5xyyeihWSlk6aeKhKMA0jX4hE+A5ZdFjjsr
        Yd0N+nBlfDyr3iOe9zlqKqHqfF/6y3Ec6CIFgm/aXzBr
X-Google-Smtp-Source: AGHT+IHkpCA2eqF2W2EP/F9HGpvjnYAiwfb7O5/E6Y3fIUbc1GjKWKQTVIaC4N7EZmgzBlyRALj4OsIrc9BLMKqTRsU=
X-Received: by 2002:a25:b10:0:b0:d7a:ee98:4f8 with SMTP id 16-20020a250b10000000b00d7aee9804f8mr11528185ybl.30.1696262142966;
 Mon, 02 Oct 2023 08:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230922193639.10158-1-vishal.moola@gmail.com>
 <20230922193639.10158-3-vishal.moola@gmail.com> <CAHbLzkqt8LFFDH2a7+xaQmncwiK=Ynv6vHs9d=TDNjp9_wJ4rw@mail.gmail.com>
 <ZRVB49PruFvT7+43@casper.infradead.org> <CAHbLzkqZHJV8j+C1czfDrZ9t8W_9YLDaZ7FnhNKa224ehnH1zA@mail.gmail.com>
In-Reply-To: <CAHbLzkqZHJV8j+C1czfDrZ9t8W_9YLDaZ7FnhNKa224ehnH1zA@mail.gmail.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Mon, 2 Oct 2023 08:55:34 -0700
Message-ID: <CAOzc2pyqFZW8zwKKUdY4w-OOfac6t3VMNOrqXx751VDCuLGrCg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm/khugepaged: Remove compound_pagelist
To:     Yang Shi <shy828301@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 12:33=E2=80=AFPM Yang Shi <shy828301@gmail.com> wro=
te:
>
> On Thu, Sep 28, 2023 at 2:05=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Tue, Sep 26, 2023 at 03:07:18PM -0700, Yang Shi wrote:
> > > On Fri, Sep 22, 2023 at 9:33=E2=80=AFPM Vishal Moola (Oracle)
> > > <vishal.moola@gmail.com> wrote:
> > > >
> > > > Currently, khugepaged builds a compound_pagelist while scanning, wh=
ich
> > > > is used to properly account for compound pages. We can now account
> > > > for a compound page as a singular folio instead, so remove this lis=
t.
> > > >
> > > > Large folios are guaranteed to have consecutive ptes and addresses,=
 so
> > > > once the first pte of a large folio is found skip over the rest.
> > >
> > > The address space may just map a partial folio, for example, in the
> > > extreme case the HUGE_PMD size range may have HUGE_PMD_NR folios with
> > > mapping one subpage from each folio per PTE. So assuming the PTE
> > > mapped folio is mapped consecutively may be wrong.
> >
> > How?  You can do that with two VMAs, but this is limited to scanning
> > within a single VMA.  If we've COWed a large folio, we currently do
> > so as a single page folio, and I'm not seeing any demand to change that=
.
> > If we did COW as a large folio, we'd COW every page in that folio.
> > How do we interleave two large folios in the same VMA?
>
> It is not about COW. The magic from mremap() may cause some corner
> cases. For example,
>
> We have a 2M VMA, every 4K of the VMA may be mapped to a subpage from
> different folios. Like:
>
> 0: #0 subpage of folio #0
> 1: #1 subpage of folio #1
> 2: #2 subpage of folio #2
> ....
> 511: #511 subpage of folio #511
>
> When khugepaged is scanning the VMA, it may just isolate and lock the
> folio #0, but skip all other folios since it assumes the VMA is just
> mapped by folio #0.
>
> This may trigger kernel bug when unlocking other folios which are
> actually not locked and maybe data corruption since the other folios
> may go away under us (unisolated, unlocked and unpinned).

Thanks for the review. I did not know this could happen; I'll drop
this patch for
now until I can think of a better way to iterate through ptes for large fol=
ios.
