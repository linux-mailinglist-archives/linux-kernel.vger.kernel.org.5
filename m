Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562527AC3EE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjIWRVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIWRVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:21:40 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CC2AF
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 10:21:33 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41761e9181eso151541cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695489693; x=1696094493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JA637fn4lFty7zWiP+OrSwzPySKA2HmpKzTELZBFHyM=;
        b=SbGje/S/+OrmIwlPFM/8DtnAOsVtEM3SUqHvU2qUPhJiF0jmh2qsjgK2UpSm8TxRX0
         GWRhSr3Vzsr2uRZSyU9wolC6/P8yrNzrLyAlS2RlQ7h7cY89RAJKyFDqnSvugkOmVLJG
         B52e+hSudIETHdjj6tzNFxn0FUMivHge3I9p8ki+9MZUI+u99Qh96KKEIUEk9DGY2gmx
         +CkHGkGluh939KnobOWMJzFEN3s0oWLtBRELViWKON+rFe/bO7AWnKcqrs2Lugla9fTB
         UnB4FetdxMhAd6RzQbr9Bao3fQStp4QnbhEY8B1cJXBrHd6HIm64BFR0CQz6+tZWRvj1
         hkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695489693; x=1696094493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JA637fn4lFty7zWiP+OrSwzPySKA2HmpKzTELZBFHyM=;
        b=QMIL0xk486/Sj3A3yHozH39VvWQ9AkC9so2k2K265bk3ZcQ0yeXMqMw6+KgOwY3Bvn
         eDc7RkEcSp+K02ueuw5xJiNHIbtReC29ucjRHeFw8uSVOqsTQ6YmGB1i/u6zSbEPAXrI
         JiN3ucqCIgPQem5j/oVZ/qahvREtFBAkn2oW89pt48HZzP5aRtUWr0Sbfr0zTu+n7NWA
         /Fx3mwgO3w7cHa3OrDTkz23l8Da/wp4tbTnfdWqMPAw2kL3ssKV0h4RP/n4wHI0TRKbS
         AYWimuE/+KRogvZrrrkVDfxlExuRyH9pIwOPYXf53v4MDf6WF+PL2uT7qeHRZZVkVvrA
         /kxg==
X-Gm-Message-State: AOJu0Yy4h++hLAgAzlF/c98xuu1Sr+LDKcKBMLElIT2XKt9PVmgaBPXg
        cHqcHoB6kC9rh/5TTOta+SorJUaNPG2MmREZPiT4b4eATyg//mAzWxA/HQ==
X-Google-Smtp-Source: AGHT+IHpcbQKbg/M1gEo5U5bAAeOREpxxwaaVhXM9IzKqk+ZthWEQOqOrKTgUKmSbzmvQRoRG22wEHqEIktpTxEYqUw=
X-Received: by 2002:a05:622a:107:b0:412:16f:c44f with SMTP id
 u7-20020a05622a010700b00412016fc44fmr214013qtw.6.1695489692762; Sat, 23 Sep
 2023 10:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230918210631.3882376-1-jbrennen@google.com> <CAK7LNASSgCFYequw+0zQpUC-9yLHvJLHZ97Ko1ejUYZVTkM81w@mail.gmail.com>
In-Reply-To: <CAK7LNASSgCFYequw+0zQpUC-9yLHvJLHZ97Ko1ejUYZVTkM81w@mail.gmail.com>
From:   Jack Brennen <jbrennen@google.com>
Date:   Sat, 23 Sep 2023 13:21:21 -0400
Message-ID: <CAF5hLgJOMJ70whVsPhZgsiVGYv10S8mpXvzY1HnreV6X4oZg4A@mail.gmail.com>
Subject: Re: [PATCH] modpost: Optimize symbol search from linear to binary search
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mainly just clarifying that we're willing to change the behavior in corner
cases? The existing behavior has one set of quirks about which symtab entry
is returned, and your proposed behavior has another different set of quirks=
.

It's probably OK to break builds which have an undocumented assumption
about the order of symtab entries; personally, I'd rather not risk that mys=
elf,
but if somebody with more experience is willing to back that decision, I'm
OK with it.

Also, there's an alternative approach that uses bsearch from the standard
library and a common comparison function between qsort and bsearch. I
considered this alternative earlier; maybe you would prefer it because it
eliminates having to reimplement a binary search algorithm.
I chose not to do it this way because of trying to duplicate the quirks.
If no duplication of the quirks is needed, this becomes easier.

The idea for that is to build a sorted array of syminfo that look like this=
:

(section_index, addr_lo, addr_hi, sym_lo, sym_hi)

What this represents is the situation where for any lookup in the
range from (section_index, addr_lo) to (section_index, addr_hi)
inclusive, the nearest symbol will be either sym_lo or sym_hi.
There are four different meanings for (sym_lo, sym_hi):

(sym_lo =3D 0)
This is a placeholder for a duplicated address, and it cannot
compare equal to anything. After we sort the array, we set all
of the duplicated addresses except for the last one to sym_lo =3D 0.

(sym_lo =3D MAX_SYM)
This is used to designate an address being looked up. When this
is seen, it compares equal to any other syminfo that has an
overlapping range.

(sym_lo !=3D 0, sym_hi =3D 0)
This represents the last range in a section. There's no following
address that could match. Should also have addr_hi =3D MAX.

(sym_lo !=3D 0, sym_hi !=3D 0)
This represents a range in a section that's not the last range.
sym_hi may be usable to satisfy the lookup, but only if it's
closer than sym_lo and if allow_negative is true. Note that
the address of sym_hi will be addr_hi+1, so we don't need any
additional code to fetch that address.

Here's a sample comparison function:
int syminfo_compare(const void *a, const void *b) {
  const struct syminfo *sym1 =3D a;
  const struct syminfo *sym2 =3D b;

  if (sym1->section_index > sym2->section_index)
    return 1;
  if (sym1->section_index < sym2->section_index)
    return -1;
  if ((sym1->sym_lo =3D=3D MAX_SYM && sym2->sym_lo !=3D 0) ||
      (sym2->sym_lo =3D=3D MAX_SYM && sym1->sym_lo !=3D 0)) {
    /* Overlap is equality - test for it */
    if (sym1->addr_hi >=3D sym2->addr_lo &&
        sym2->addr_hi >=3D sym1->addr_lo) {
      return 0;
    }
    /* No overlap, fall through */
  }
  if (sym1->addr_lo > sym2->addr_lo)
    return 1;
  if (sym1->addr_lo < sym2->addr_lo)
    return -1;
  /* Note that if we are comparing a lookup (MAX_SYM) with
     a placeholder (0), the lookup always compares greater.
     This causes us to search to the "right" of the placeholder
     for a match, which is what we want. */
  if (sym1->sym_lo > sym2->sym_lo)
    return 1;
  if (sym1->sym_lo < sym2->sym_lo)
    return -1;
  return 0;
}

So this greatly simplifies the back-end searching. It's a bsearch()
which gives you either a miss, or one or two alternatives for the result.
On the front end, you have an extra step after sorting which massages the
search array into the right configuration.  There's actually not much code
needed to do that.

Is that of interest?  The leveraging of bsearch() in that way?

A few other responses below...

On Sat, Sep 23, 2023 at 4:50=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
> > +/* Populate the search array that we just allocated.
> > + * Be slightly paranoid here.  If the ELF file changes during processi=
ng,
>
> I could not understand. In which case, the ELF file changes?
>
> modpost loads the entire file to memory first..
>
> In which scenario, the memory content changes?
>

modpost doesn't load the entire file, it uses mmap to map it into the
address space.The easiest way to imagine this being an issue is that some
buggy parallelization happens and something is modifying vmlinux.o while
modpost is processing it.  Of course it's probably acceptable to say,
"Don't do that!"

There are two alternatives here: actually read in the entire file, which
is certainly suboptimal, or just live with the fact that mmap makes no
guarantees about whether changes in the file are reflected in the memory ma=
p.

> > +       /* A bit of paranoia; make sure that the end sentinel's address=
 is
> > +        * different than its predecessor.  Not doing this could cause
> > +        * possible undefined behavior if anybody ever inserts a symbol
> > +        * with section_index and addr both at their max values.
>
> I could not understand this comment.
>
> If section_index and addr both at their max values at [table_size - 2],
> ->table[table_size - 2].addr + 1 wraps to zero.
>
> The table is not sorted any longer?
>

That's correct, the table would not be sorted any longer. But by design,
we never do a relational comparison against the end sentinel. But if
we rework the search, either by your suggestion or by using bsearch(),
this sentinel goes away.
