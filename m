Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7957B2891
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjI1WtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjI1WtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:49:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E47B19D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 15:49:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso3742a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 15:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695941343; x=1696546143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH1OIK0gWyk1N4xaqASo2H5s560h9u2ewBbOcfS8pdg=;
        b=aCsB1TyKMgElOwsAG1n6V3mDnAEkv9/JZg4agc2c+UQHrdkAJUzQfebGgU7G4y9Wz6
         i0OzOvDS9peMHt1Ws6kYYh14JJxG7JPIcz3wdyofQBdnEBdcdy6Gm+RyGaVV25/pnPBS
         iDgAjMX0Nb+XTdV92l9j18AFSZs4Z+xlDWh3AUvuXiVkFNRD+q4bkQroKpv8sp7UjQ9d
         EB0gns8T0/WnGg5rlHA/IESfO2zpm/wPq8ieIw1b4HaFPjajvkqAiniOAimMRQGIh/qx
         gpbeIHTmvX/L85gaW+SRoJyrtU/qSvc6rqq+DBCv/1GiElRvAuKRLufSsGxtiG9H8lGP
         X9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695941343; x=1696546143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aH1OIK0gWyk1N4xaqASo2H5s560h9u2ewBbOcfS8pdg=;
        b=fKnSzl34FbrvBjEMeTTOHBfoJfHHa00Ej7R/48BZCAsMk7H11I4QfQo9ofog01oRKo
         e8C5jszmntorXGCowDkrnZCrQIVi6J9bxWVAsL22rK/uHxW1EPHeNtCLJFRpPZpnFIZC
         Zfs/M0Sl1qjC8O8ODPrJAZSNJxgcSEgD8jOMoTYuyf50O+k/T1Yr7DXtQcH1Ihb7nsy2
         yMZD7fvKdpTuWLhEY8XUD8z6zzjwZPfk+nXlIoo5gnXMDrj2GIaEuHZhJaM6CfLVLeGk
         UZ6YWGotZGJPXapEH47iH8ZBlwQ+ScKGWuOR1pOYLLFiJf/ZEbzDKkFgdB5/8svUInt7
         6VkA==
X-Gm-Message-State: AOJu0YzCLuP8UW8QdXXJcp7QVYkKlJ+7xZorn0/cJdqODKPhg3VMdyR3
        vjKpE3UWH4HEim1VA/fC5LoN5Jio8cFH9k4TKKij+g==
X-Google-Smtp-Source: AGHT+IEwgqOTiiLagyh/Eid9MJeL9VTSnkiJWAIbQ+ucpeAT1mLUqgG5yAYFQxQuyOWRkehH2swmIuDSqlUFnQMjTg8=
X-Received: by 2002:a50:9fef:0:b0:523:b133:57fe with SMTP id
 c102-20020a509fef000000b00523b13357femr478875edf.1.1695941342775; Thu, 28 Sep
 2023 15:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <4d6c9b19-cdbb-4a00-9a40-5ed5c36332e5@arm.com> <ZRVbV6yJ-zFzRoas@debian.me>
 <54e5accf-1a56-495a-a4f5-d57504bc2fc8@arm.com> <CAAa6QmRbDbEamFgEDbgVhwKOf1GHNa90COuyz29BmduOAjbmyA@mail.gmail.com>
 <20230928210436.GG11456@frogsfrogsfrogs>
In-Reply-To: <20230928210436.GG11456@frogsfrogsfrogs>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 28 Sep 2023 15:48:25 -0700
Message-ID: <CAAa6QmTh33HKBdYu9GnXtR4PnVMwc4pDU23eo0mO9t-m-kr7=Q@mail.gmail.com>
Subject: Re: BUG: MADV_COLLAPSE doesn't work for XFS files]
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
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

On Thu, Sep 28, 2023 at 2:04=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Sep 28, 2023 at 12:43:57PM -0700, Zach O'Keefe wrote:
> > Hey Ryan,
> >
> > Thanks for bringing this up.
> >
> > On Thu, Sep 28, 2023 at 4:59=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> > >
> > > On 28/09/2023 11:54, Bagas Sanjaya wrote:
> > > > On Thu, Sep 28, 2023 at 10:55:17AM +0100, Ryan Roberts wrote:
> > > >> Hi all,
> > > >>
> > > >> I've just noticed that when applied to a file mapping for a file o=
n xfs, MADV_COLLAPSE returns EINVAL. The same test case works fine if the f=
ile is on ext4.
> > > >>
> > > >> I think the root cause is that the implementation bails out if it =
finds a (non-PMD-sized) large folio in the page cache for any part of the f=
ile covered by the region. XFS does readahead into large folios so we hit t=
his issue. See khugepaged.h:collapse_file():
> > > >>
> > > >>              if (PageTransCompound(page)) {
> > > >>                      struct page *head =3D compound_head(page);
> > > >>
> > > >>                      result =3D compound_order(head) =3D=3D HPAGE_=
PMD_ORDER &&
> > > >>                                      head->index =3D=3D start
> > > >>                                      /* Maybe PMD-mapped */
> > > >>                                      ? SCAN_PTE_MAPPED_HUGEPAGE
> > > >>                                      : SCAN_PAGE_COMPOUND;
> > > >>                      goto out_unlock;
> > > >>              }
> > > >
> >
> > Ya, non-PMD-sized THPs were just barely visible in my peripherals when
> > writing this, and I'm still woefully behind on your work on them now
> > (sorry!).
> >
> > I'd like to eventually make collapse (not just MADV_COLLAPSE, but
> > khugepaged too) support arbitrary-sized large folios in general, but
> > I'm very pressed for time right now. I think M. Wilcox is also
> > interested in this, given he left the TODO to support it :P
>
> Is the point of MADV_COLLAPSE to replace base pages with PMD-sized pages
> in the pagecache for faster lookups?  Or merely to replace them with
> something larger, even if it's not PMD sized?

Might depend on who you ask, but IMHO, the principle purpose of
collapse is saving TLB entries, with TLB coalescing complicating
things a little in terms of PMD-sized things or not. M. Wilcox's work
with descriptor-izing folios might make a nice case for memory savings
as well, down the line.

> As of 6.6, XFS asks for folios of size min(read/readahead/write_len,
> ondisk_mapping_length), so in theory the folio size should roughly
> follow the access patterns.  If the goal is merely larger folios, then
> we are done here and can move on to some other part of the collapse.
>
> OTOH if the goal is TLB savings, then I suppose you'd actually /want/ to
> select a large (but not PMD) folio for collapsing into a PMD sized
> folio, right?

I suppose it might make some operations easier / faster during
collapse if we have less folios to process.

> e.g.
>
>         if (PageTransCompound(page)) {
>                 struct page *head =3D compound_head(page);
>
>                 if (head->index !=3D start) {
>                         /* not sure what _COMPOUND means here... */
>                         result =3D SCAN_PAGE_COMPOUND;
>                         goto out_unlock;
>                 }
>
>                 if (compound_order(head) =3D=3D HPAGE_PMD_ORDER) {
>                         result =3D SCAN_PTE_MAPPED_HUGEPAGE;
>                         goto out_unlock;
>                 }
>
>                 /* result is still SCAN_SUCCEED, keep going */
>         }
>
> I /think/ that would work?  If the largefolio is dirty or not fully
> uptodate then collapse won't touch it; and I think fs/iomap handles this
> in a compatible way because it won't mark the folio uptodate until all
> the blocks have been read, and it marks the folio dirty if any of the
> blocks are dirty.
>
> (says me, who doesn't really understand this part of the code.)

I think there's a couple issues with this -- for example, the
head->index !=3D start case is going to be the common-case for
non-PMD-sized large folios. Regardless, there is some more code in
hpage_collapse_scan_file() and her in collapse_file() that would need
to be updated. I'm taking a cursory look, and naively it doesn't look
too bad -- most things "should just work" in file/shmem collapse path.
ac492b9c70cac ("mm/khugepaged: skip shmem with userfaultfd" was merged
since the last I looked carefully at this path, so I would need to
spend more time understanding some changes there. So, from correctness
POV, maybe there's not anything drastic to be done for file/shmem.
Maybe this is a good place to start.

For anon, things are different, as we are coming at the pages from a
different angle, and are operating over the pmd directly. I'm not
immediately sure if it makes things easier or harder. Probably harder.
Can we even get non-PMD-sized large anon folios right now, without
Ryan's work?

From a khugepaged policy POV, there are some questions to be
answered.. but I think these mostly boil down to: scale the
present/swap/none checks by (1 << order).

Anyways, this isn't to be taken with much weight as a thorough audit
is required to understand any subtleties lurking around.

Thanks,
Zach

> --D
>
> > Thank you for the reproducer though! I haven't run it, but I'll
> > probably come back here to steal it when the time comes.
> >
> > > > I don't see any hint to -EINVAL above. Am I missing something?
> > >
> > > The SCAN_PAGE_COMPOUND result ends up back at madvise_collapse() wher=
e it
> > > eventually gets converted to -EINVAL by madvise_collapse_errno().
> > >
> > > >
> > > >>
> > > >> I'm not sure if this is already a known issue? I don't have time t=
o work on a fix for this right now, so thought I would highlight it at leas=
t. I might get around to it at some point in the future if nobody else tack=
les it.
> >
> > My guess is Q1 2024 is when I'd be able to look into this, at the
> > current level of urgency. It doesn't sound like it's blocking anything
> > for your work right now -- lmk if that changes though!
> >
> > Thanks,
> > Zach
> >
> >
> >
> > > >>
> > > >> Thanks,
> > > >> Ryan
> > > >>
> > > >>
> > > >> Test case I've been using:
> > > >>
> > > >> -->8--
> > > >>
> > > >> #include <stdio.h>
> > > >> #include <stdlib.h>
> > > >> #include <sys/mman.h>
> > > >> #include <sys/types.h>
> > > >> #include <sys/stat.h>
> > > >> #include <fcntl.h>
> > > >> #include <unistd.h>
> > > >>
> > > >> #ifndef MADV_COLLAPSE
> > > >> #define MADV_COLLAPSE                25
> > > >> #endif
> > > >>
> > > >> #define handle_error(msg)    do { perror(msg); exit(EXIT_FAILURE);=
 } while (0)
> > > >>
> > > >> #define SZ_1K                        1024
> > > >> #define SZ_1M                        (SZ_1K * SZ_1K)
> > > >> #define ALIGN(val, align)    (((val) + ((align) - 1)) & ~((align) =
- 1))
> > > >>
> > > >> #if 1
> > > >> // ext4
> > > >> #define DATA_FILE            "/home/ubuntu/data.txt"
> > > >> #else
> > > >> // xfs
> > > >> #define DATA_FILE            "/boot/data.txt"
> > > >> #endif
> > > >>
> > > >> int main(void)
> > > >> {
> > > >>      int fd;
> > > >>      char *mem;
> > > >>      int ret;
> > > >>
> > > >>      fd =3D open(DATA_FILE, O_RDONLY);
> > > >>      if (fd =3D=3D -1)
> > > >>              handle_error("open");
> > > >>
> > > >>      mem =3D mmap(NULL, SZ_1M * 4, PROT_READ | PROT_EXEC, MAP_PRIV=
ATE, fd, 0);
> > > >>      close(fd);
> > > >>      if (mem =3D=3D MAP_FAILED)
> > > >>              handle_error("mmap");
> > > >>
> > > >>      printf("1: pid=3D%d, mem=3D%p\n", getpid(), mem);
> > > >>      getchar();
> > > >>
> > > >>      mem =3D (char *)ALIGN((unsigned long)mem, SZ_1M * 2);
> > > >>      ret =3D madvise(mem, SZ_1M * 2, MADV_COLLAPSE);
> > > >>      if (ret)
> > > >>              handle_error("madvise");
> > > >>
> > > >>      printf("2: pid=3D%d, mem=3D%p\n", getpid(), mem);
> > > >>      getchar();
> > > >>
> > > >>      return 0;
> > > >> }
> > > >>
> > > >> -->8--
> > > >>
> > > >
> > > > Confused...
> > >
> > > This is a user space test case that shows the problem; data.txt needs=
 to be at
> > > least 4MB and on a mounted ext4 and xfs filesystem. By toggling the '=
#if 1' to
> > > 0, you can see the different behaviours for ext4 and xfs -
> > > handle_error("madvise") fires with EINVAL in the xfs case. The getcha=
r()s are
> > > leftovers from me looking at the smaps file.
> > >
