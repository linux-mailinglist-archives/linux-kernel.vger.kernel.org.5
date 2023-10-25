Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDD67D7401
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjJYTMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYTMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:12:06 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4ABBB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:12:03 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41cb7720579so46261cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698261123; x=1698865923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQsXRm/26AnMKfle1hOvoePNzv6mvpNR6kguNEXwq5g=;
        b=3MBCiFOXBQj7wLOmbS4x3qZZQb8H6SPc+jS2JYxiytH0qB+pfxgDN9gs6/uCDwtDum
         46hwBK21ij+DeVZpoZIEapJzInF4p6Un/J8A+ywl+VjQKjRMsJlkNPjMpHnoPhxVCB0Z
         wMSctz0Mqm8kxp/YFjBKPDv4RsKlrt5dEIWRrnPO4btOlTLy5FeIxPxiXugZVCF3MAeC
         BnFeQBR2fxe7jSjuSUpWrJjNBXJEEXz0ANZN8vLSxR34K8NycVC4Yy8QSvxwylt1mI73
         9aA3dvqd+yHVU4ISwZD17b7wftEJfv8qD151EcWxz8BgQ9BZR/Vr34Kyo2mLBsjIyxvY
         jDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698261123; x=1698865923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQsXRm/26AnMKfle1hOvoePNzv6mvpNR6kguNEXwq5g=;
        b=FDhQDknGgcyF0x4G6xzTPUNvS2lZjzSKod9bGWEx7IduwEcHOWXGVA8+CMHPT50Lz1
         9lJnKzqq0nYG7c2ipUg97brF0zX34a34TFqS9+YAAE8jle+XFn/n+Q2C4JlY+2d3C9O8
         WFcAglujPyHYmsg5gGi6iwgTiZ6ZngPF8ftH96C0KsYGi3jQdzre9gLU1ywnrknTLoUx
         xjxPw/lelSHIBvDcKEqSBjd+9l7wUeNLh89vvF9L3XAtkTvYjC6Z3nvA+Rz0an4E08hZ
         Pom0BsnT6KbG9OhGjtk3H4faIQCKMHtD7hpjYcQwfoKmbkpO8+/LdQHSJMHPuBVdfh0l
         +prw==
X-Gm-Message-State: AOJu0Yzq5/NrFLkvRDlDX+W8pgrdmQ/ZUZIf+Q9+V2VJzClTDSjHEWxS
        dShBYswAAZoLg+V2OZONrJ7HlB0i0KwzLbdQRy3O2A==
X-Google-Smtp-Source: AGHT+IG6KDiuxywIZwUVL3S8gGg9WWokTQZh8SEtNeM0/s7tsiam2k4ilI1Lup8w7V77HEhKysK+YikM3ctquirsU/o=
X-Received: by 2002:ac8:7cad:0:b0:41e:2984:6dba with SMTP id
 z13-20020ac87cad000000b0041e29846dbamr257820qtv.3.1698261122754; Wed, 25 Oct
 2023 12:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com> <a7781f13-21ca-48c7-99c4-22beef0400f9@arm.com>
 <fcbe9179-dcd9-4bf8-b1d1-82201880527e@arm.com> <a2e11353-fad8-475c-a4d1-dc1de22dde11@redhat.com>
In-Reply-To: <a2e11353-fad8-475c-a4d1-dc1de22dde11@redhat.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 25 Oct 2023 13:11:24 -0600
Message-ID: <CAOUHufa9CyfRaMFXWtFWPG22Z9Zf9hZZWbZdTke6THimtbPzRQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
To:     David Hildenbrand <david@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Wed, Oct 25, 2023 at 12:47=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 25.10.23 18:24, Ryan Roberts wrote:
> > On 20/10/2023 13:33, Ryan Roberts wrote:
> >> On 06/10/2023 21:06, David Hildenbrand wrote:
> >>> On 29.09.23 13:44, Ryan Roberts wrote:
> >>>> Hi All,
> >>>
> >>
> >> [...]
> >>
> >>>> NOTE: These changes should not be merged until the prerequisites are=
 complete.
> >>>> These are in progress and tracked at [7].
> >>>
> >>> We should probably list them here, and classify which one we see as s=
trict a
> >>> requirement, which ones might be an optimization.
> >>>
> >>
> >> Bringing back the discussion of prerequistes to this thread following =
the
> >> discussion at the mm-alignment meeting on Wednesday.
> >>
> >> Slides, updated following discussion to reflect all the agreed items t=
hat are
> >> prerequisites and enhancements, are at [1].
> >>
> >> I've taken a closer look at the situation with khugepaged, and can con=
firm that
> >> it does correctly collapse anon small-sized THP into PMD-sized THP. I =
did notice
> >> though, that one of the khugepaged selftests (collapse_max_ptes_none) =
fails when
> >> small-sized THP is enabled+always. So I've fixed that test up and will=
 add the
> >> patch to the next version of my series.
> >>
> >> So I believe the khugepaged prerequisite can be marked as done.
> >>
> >> [1]
> >> https://drive.google.com/file/d/1GnfYFpr7_c1kA41liRUW5YtCb8Cj18Ud/view=
?usp=3Dsharing&resourcekey=3D0-U1Mj3-RhLD1JV6EThpyPyA
> >
> > Hi All,
>
> Hi,
>
> I wanted to remind people in the THP cabal meeting, but that either
> didn't happen or zoomed decided to not let me join :)
>
> >
> > It's been a week since the mm alignment meeting discussion we had aroun=
d
> > prerequisites and the ABI. I haven't heard any further feedback on the =
ABI
> > proposal, so I'm going to be optimistic and assume that nobody has foun=
d any
> > fatal flaws in it :).
>
> After saying in the call probably 10 times that people should comment
> here if there are reasonable alternatives worth discussing, call me
> "optimistic" as well; but, it's only been a week and people might still
> be thinking about this/
>
> There were two things discussed in the call:
>
> * Yu brought up "lists" so we can have priorities. As briefly discussed
>    in the  call, this (a) might not be needed right now in an initial
>    version;  (b) the kernel might be able to handle that (or many cases)
>    automatically, TBD. Adding lists now would kind-of set the semantics
>    of that interface in stone. As you describe below, the approach
>    discussed here could easily be extended to cover priorities, if need
>    be.

I want to expand on this: the argument that "if you could allocate a
higher order you should use it" is too simplistic. There are many
reasons in addition to the one above that we want to "fall back" to
higher orders, e.g., those higher orders are not on PCP or from the
local node. When we consider the sequence of orders to try, user
preference is just one of the parameters to the cost function. The
bottom line is that I think we should all agree that there needs to be
a cost function down the road, whatever it looks like. Otherwise I
don't know how we can make "auto" happen.

> * Hugh raised the point that "bitmap of orders" could be replaced by
>    "added THP sizes", which really is "bitmap of orders" shifted to the
>    left. To configure 2 MiB +  64Kib, one would get "2097152 + 65536" =3D
>    "2162688" or in KiB "2112". Hm.

I'm not a big fan of the "bitmap of orders" approach, because it
doesn't address my concern above.

> Both approaches would require single-option files like "enable_always",
> "enable_madvise" ... which I don't particularly like, but who am I to jud=
ge.
>
>
> >
> > Certainly, I think it held up to the potential future policies that Yu =
Zhou
> > cited on the call - the possibility of preferring a smaller size over a=
 bigger
> > one, if the smaller size can be allocated without splitting a contiguou=
s block.
> > I think the suggestion of adding a per-size priority file would solve i=
t. And in
> > general because we have a per-size directory, that gives us lots of fle=
xibility
> > for growth.
>
> Jup, same opinion here. But again, I'm very happy to hear other
> alternatives and why they are better.

I'm not against David's proposal but I want to hear a lot more about
"lots of flexibility for growth" before I'm fully convinced. Why do I
need more convincing? When I brought up that we need to consider the
priority of each order and the potential need to fall back to higher
orders during the meeting, I got the impression people were surprised
why we want to fall back to higher orders. TBH, I was surprised too
that this possibility was never considered. I missed today's THP
meeting too but I'll join next time and if anyone has more ideas on
this, we can spend some time discussing it, especially on how LAF
should cooperate with the page allocator to make better decisions.
