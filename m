Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F22758513
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGRSxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGRSx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:53:29 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E066CF4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:53:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so9806318e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689706403; x=1692298403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3IO1Uv1cdKfSJ7S1X8tjfII0Q5SLyHa/H9peZm7KlQ=;
        b=Vpyp9+pbwfI1R4Tjrpph8sCMgNaAz+0d+dz48iMjno6fIO69mmdal8p2whZFy8HQ0D
         al/J37Tb/mWPDOjcfpEBgCnsPI/v7FTNPOg+U+t6hF/pME9eZFIPjOZqRjPphkIIwXWi
         s82nMQ4nkZ5XWg0fnEURmeTIQ8V4B5UpuW5ZR6LyyjkjTkNykgy0NcQsHQZGpb5MI9/A
         dMW3vPadtYBdTJ1GEtH7YOa3q7UWzp3mMYcp+fwncEAbJLsjvNW8HrZidFdgZliMCgJm
         DjZiG+DS2Z3eLyBcMkfirowJTi7Ko1uqMLZAgS4ij1LmqsBT10Vno0PJZC/yulCa1zyK
         LY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689706403; x=1692298403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3IO1Uv1cdKfSJ7S1X8tjfII0Q5SLyHa/H9peZm7KlQ=;
        b=TQ1Uaohn+HMGLbWWYX2GuSZIeJ8YO5+d8nN0vm0tIGQ8ielwIte2CWj/34q9Rrr0pr
         cF49s34iWqMLXTqbvjTTdUvyqFJfdGS4md6a9814GJW8G/wsGi18csysvoc1zCsRwzaJ
         pcTJanskl3hD26F1ar1DfgyV49qC//VkSvjxXx0s4IIme2Kh59a3Ax94dDNyrVnqKeSR
         amsehYp4iZ3diAGKHoNQSzx1TDKbebd1iQMG6rlGOUNQR/hL/gSnedR/kT4oqizk7rzZ
         Sp+7/WgtZbdS3/c3hKDhrjEh3/k3mQWx7nGrqeei0dHmQ8pJ5ZxghNXeHi9CWDXKLN7V
         jEPA==
X-Gm-Message-State: ABy/qLZQ2OhzTJG5B02t3E0Z+g7pRoKHCe2JIap0a7LTLTXXFyKSXc7e
        Em2jFtZ0P/gYL6xZHcJd0tUcQlbUAnqlCq8aQWkYfQ==
X-Google-Smtp-Source: APBJJlGBWpeJBJ5czNTcN2026bozwwX5c5KbDGOMr+plM5Ewg0v+sarPQvhfESyxaoIDxU37Eb+19ngO0U8PmOtINq0=
X-Received: by 2002:a2e:9e4b:0:b0:2ac:82c1:5a3d with SMTP id
 g11-20020a2e9e4b000000b002ac82c15a3dmr10180906ljk.23.1689706402576; Tue, 18
 Jul 2023 11:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230714194610.828210-1-hannes@cmpxchg.org> <ZLIVleBYOm4HIGTZ@casper.infradead.org>
 <20230717141250.GA866068@cmpxchg.org> <901409ed-504b-9500-54d8-e42f832e07b0@suse.cz>
 <20230717160227.GA867137@cmpxchg.org>
In-Reply-To: <20230717160227.GA867137@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 18 Jul 2023 11:52:45 -0700
Message-ID: <CAJD7tkbkoph+N3E92n4xGAvVP12H=issOfAPmdrS0655Ja=qAw@mail.gmail.com>
Subject: Re: [PATCH] mm: kill frontswap
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        konrad.wilk@oracle.com, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 9:02=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Jul 17, 2023 at 04:31:42PM +0200, Vlastimil Babka wrote:
> > On 7/17/23 16:12, Johannes Weiner wrote:
> > > On Sat, Jul 15, 2023 at 04:42:13AM +0100, Matthew Wilcox wrote:
> > >> On Fri, Jul 14, 2023 at 03:46:08PM -0400, Johannes Weiner wrote:
> > >> > diff --git a/mm/zswap.c b/mm/zswap.c
> > >> > index 62195f72bf56..1b0128060792 100644
> > >> > --- a/mm/zswap.c
> > >> > +++ b/mm/zswap.c
> > >> > @@ -2,7 +2,7 @@
> > >> >  /*
> > >> >   * zswap.c - zswap driver file
> > >> >   *
> > >> > - * zswap is a backend for frontswap that takes pages that are in =
the process
> > >> > + * zswap is a cache that takes pages that are in the process
> > >> >   * of being swapped out and attempts to compress and store them i=
n a
> > >> >   * RAM-based memory pool.  This can result in a significant I/O r=
eduction on
> > >> >   * the swap device and, in the case where decompressing from RAM =
is faster
> > >> > @@ -20,7 +20,6 @@
> > >> >  #include <linux/spinlock.h>
> > >> >  #include <linux/types.h>
> > >> >  #include <linux/atomic.h>
> > >> > -#include <linux/frontswap.h>
> > >> >  #include <linux/rbtree.h>
> > >> >  #include <linux/swap.h>
> > >> >  #include <linux/crypto.h>
> > >>
> > >> To make this patch compile, I had to add zswap.h to the include list=
.
> > >
> > > I can fix that up, but I'm curious what kind of failure you saw. It
> > > built fine for me, not even a warning.
> >
> > I get warnings but only with W=3D1 (worth fixing up though).
> >
> >   CC      mm/zswap.o
> > mm/zswap.c:1203:6: warning: no previous prototype for =E2=80=98zswap_st=
ore=E2=80=99 [-Wmissing-prototypes]
> >  1203 | bool zswap_store(struct page *page)
> >       |      ^~~~~~~~~~~
> > mm/zswap.c:1382:6: warning: no previous prototype for =E2=80=98zswap_lo=
ad=E2=80=99 [-Wmissing-prototypes]
> >  1382 | bool zswap_load(struct page *page)
> >       |      ^~~~~~~~~~
> > mm/zswap.c:1470:6: warning: no previous prototype for =E2=80=98zswap_in=
validate=E2=80=99 [-Wmissing-prototypes]
> >  1470 | void zswap_invalidate(int type, pgoff_t offset)
> >       |      ^~~~~~~~~~~~~~~~
> > mm/zswap.c:1487:6: warning: no previous prototype for =E2=80=98zswap_sw=
apon=E2=80=99 [-Wmissing-prototypes]
> >  1487 | void zswap_swapon(int type)
> >       |      ^~~~~~~~~~~~
> > mm/zswap.c:1502:6: warning: no previous prototype for =E2=80=98zswap_sw=
apoff=E2=80=99 [-Wmissing-prototypes]
> >  1502 | void zswap_swapoff(int type)
> >       |      ^~~~~~~~~~~~~
>
> Ah, thanks!
>
> Here is version 2 with the missing include:
> ---
> From 3f0b2e4dea80d4305581f71c46b035c426d66ad7 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Fri, 14 Jul 2023 13:25:07 -0400
> Subject: [PATCH V2] mm: kill frontswap
>
> The only user of frontswap is zswap, and has been for a long
> time. Have swap call into zswap directly and remove the indirection.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  Documentation/admin-guide/mm/zswap.rst        |  14 +-
>  Documentation/mm/frontswap.rst                | 264 ----------------
>  Documentation/mm/index.rst                    |   1 -
>  .../translations/zh_CN/mm/frontswap.rst       | 196 ------------
>  Documentation/translations/zh_CN/mm/index.rst |   1 -
>  MAINTAINERS                                   |   7 -
>  fs/proc/meminfo.c                             |   1 +
>  include/linux/frontswap.h                     |  91 ------
>  include/linux/swap.h                          |   9 -
>  include/linux/swapfile.h                      |   5 -
>  include/linux/zswap.h                         |  37 +++
>  mm/Kconfig                                    |   4 -
>  mm/Makefile                                   |   1 -
>  mm/frontswap.c                                | 283 ------------------
>  mm/page_io.c                                  |   6 +-
>  mm/swapfile.c                                 |  33 +-
>  mm/zswap.c                                    | 159 ++++------
>  17 files changed, 122 insertions(+), 990 deletions(-)
>  delete mode 100644 Documentation/mm/frontswap.rst
>  delete mode 100644 Documentation/translations/zh_CN/mm/frontswap.rst
>  delete mode 100644 include/linux/frontswap.h
>  create mode 100644 include/linux/zswap.h
>  delete mode 100644 mm/frontswap.c
>
> V2: fix missing zswap.h include (Willy, Vlastimil)
>
> diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin=
-guide/mm/zswap.rst
> index c5c2c7dbb155..45b98390e938 100644
> --- a/Documentation/admin-guide/mm/zswap.rst
> +++ b/Documentation/admin-guide/mm/zswap.rst
> @@ -49,7 +49,7 @@ compressed pool.
>  Design
>  =3D=3D=3D=3D=3D=3D
>
> -Zswap receives pages for compression through the Frontswap API and is ab=
le to
> +Zswap receives pages for compression from the swap subsystem and is able=
 to
>  evict pages from its own compressed pool on an LRU basis and write them =
back to
>  the backing swap device in the case that the compressed pool is full.
>
> @@ -70,19 +70,19 @@ means the compression ratio will always be 2:1 or wor=
se (because of half-full
>  zbud pages).  The zsmalloc type zpool has a more complex compressed page
>  storage method, and it can achieve greater storage densities.
>
> -When a swap page is passed from frontswap to zswap, zswap maintains a ma=
pping
> +When a swap page is passed from swapout to zswap, zswap maintains a mapp=
ing
>  of the swap entry, a combination of the swap type and swap offset, to th=
e zpool
>  handle that references that compressed swap page.  This mapping is achie=
ved
>  with a red-black tree per swap type.  The swap offset is the search key =
for the
>  tree nodes.
>
> -During a page fault on a PTE that is a swap entry, frontswap calls the z=
swap
> -load function to decompress the page into the page allocated by the page=
 fault
> -handler.
> +During a page fault on a PTE that is a swap entry, the swapin code calls=
 the
> +zswap load function to decompress the page into the page allocated by th=
e page
> +fault handler.
>
>  Once there are no PTEs referencing a swap page stored in zswap (i.e. the=
 count
> -in the swap_map goes to 0) the swap code calls the zswap invalidate func=
tion,
> -via frontswap, to free the compressed entry.
> +in the swap_map goes to 0) the swap code calls the zswap invalidate func=
tion
> +to free the compressed entry.
>
>  Zswap seeks to be simple in its policies.  Sysfs attributes allow for on=
e user
>  controlled policy:
> diff --git a/Documentation/mm/frontswap.rst b/Documentation/mm/frontswap.=
rst
> deleted file mode 100644
> index c892412988af..000000000000
> --- a/Documentation/mm/frontswap.rst
> +++ /dev/null
> @@ -1,264 +0,0 @@
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Frontswap
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Frontswap provides a "transcendent memory" interface for swap pages.
> -In some environments, dramatic performance savings may be obtained becau=
se
> -swapped pages are saved in RAM (or a RAM-like device) instead of a swap =
disk.
> -
> -.. _Transcendent memory in a nutshell: https://lwn.net/Articles/454795/
> -
> -Frontswap is so named because it can be thought of as the opposite of
> -a "backing" store for a swap device.  The storage is assumed to be
> -a synchronous concurrency-safe page-oriented "pseudo-RAM device" conform=
ing
> -to the requirements of transcendent memory (such as Xen's "tmem", or
> -in-kernel compressed memory, aka "zcache", or future RAM-like devices);
> -this pseudo-RAM device is not directly accessible or addressable by the
> -kernel and is of unknown and possibly time-varying size.  The driver
> -links itself to frontswap by calling frontswap_register_ops to set the
> -frontswap_ops funcs appropriately and the functions it provides must
> -conform to certain policies as follows:
> -
> -An "init" prepares the device to receive frontswap pages associated
> -with the specified swap device number (aka "type").  A "store" will
> -copy the page to transcendent memory and associate it with the type and
> -offset associated with the page. A "load" will copy the page, if found,
> -from transcendent memory into kernel memory, but will NOT remove the pag=
e
> -from transcendent memory.  An "invalidate_page" will remove the page
> -from transcendent memory and an "invalidate_area" will remove ALL pages
> -associated with the swap type (e.g., like swapoff) and notify the "devic=
e"
> -to refuse further stores with that swap type.
> -
> -Once a page is successfully stored, a matching load on the page will nor=
mally
> -succeed.  So when the kernel finds itself in a situation where it needs
> -to swap out a page, it first attempts to use frontswap.  If the store re=
turns
> -success, the data has been successfully saved to transcendent memory and
> -a disk write and, if the data is later read back, a disk read are avoide=
d.
> -If a store returns failure, transcendent memory has rejected the data, a=
nd the
> -page can be written to swap as usual.
> -
> -Note that if a page is stored and the page already exists in transcenden=
t memory
> -(a "duplicate" store), either the store succeeds and the data is overwri=
tten,
> -or the store fails AND the page is invalidated.  This ensures stale data=
 may
> -never be obtained from frontswap.
> -
> -If properly configured, monitoring of frontswap is done via debugfs in
> -the `/sys/kernel/debug/frontswap` directory.  The effectiveness of
> -frontswap can be measured (across all swap devices) with:
> -
> -``failed_stores``
> -       how many store attempts have failed
> -
> -``loads``
> -       how many loads were attempted (all should succeed)
> -
> -``succ_stores``
> -       how many store attempts have succeeded
> -
> -``invalidates``
> -       how many invalidates were attempted
> -
> -A backend implementation may provide additional metrics.
> -
> -FAQ
> -=3D=3D=3D
> -
> -* Where's the value?
> -
> -When a workload starts swapping, performance falls through the floor.
> -Frontswap significantly increases performance in many such workloads by
> -providing a clean, dynamic interface to read and write swap pages to
> -"transcendent memory" that is otherwise not directly addressable to the =
kernel.
> -This interface is ideal when data is transformed to a different form
> -and size (such as with compression) or secretly moved (as might be
> -useful for write-balancing for some RAM-like devices).  Swap pages (and
> -evicted page-cache pages) are a great use for this kind of slower-than-R=
AM-
> -but-much-faster-than-disk "pseudo-RAM device".
> -
> -Frontswap with a fairly small impact on the kernel,
> -provides a huge amount of flexibility for more dynamic, flexible RAM
> -utilization in various system configurations:
> -
> -In the single kernel case, aka "zcache", pages are compressed and
> -stored in local memory, thus increasing the total anonymous pages
> -that can be safely kept in RAM.  Zcache essentially trades off CPU
> -cycles used in compression/decompression for better memory utilization.
> -Benchmarks have shown little or no impact when memory pressure is
> -low while providing a significant performance improvement (25%+)
> -on some workloads under high memory pressure.
> -
> -"RAMster" builds on zcache by adding "peer-to-peer" transcendent memory
> -support for clustered systems.  Frontswap pages are locally compressed
> -as in zcache, but then "remotified" to another system's RAM.  This
> -allows RAM to be dynamically load-balanced back-and-forth as needed,
> -i.e. when system A is overcommitted, it can swap to system B, and
> -vice versa.  RAMster can also be configured as a memory server so
> -many servers in a cluster can swap, dynamically as needed, to a single
> -server configured with a large amount of RAM... without pre-configuring
> -how much of the RAM is available for each of the clients!
> -
> -In the virtual case, the whole point of virtualization is to statistical=
ly
> -multiplex physical resources across the varying demands of multiple
> -virtual machines.  This is really hard to do with RAM and efforts to do
> -it well with no kernel changes have essentially failed (except in some
> -well-publicized special-case workloads).
> -Specifically, the Xen Transcendent Memory backend allows otherwise
> -"fallow" hypervisor-owned RAM to not only be "time-shared" between multi=
ple
> -virtual machines, but the pages can be compressed and deduplicated to
> -optimize RAM utilization.  And when guest OS's are induced to surrender
> -underutilized RAM (e.g. with "selfballooning"), sudden unexpected
> -memory pressure may result in swapping; frontswap allows those pages
> -to be swapped to and from hypervisor RAM (if overall host system memory
> -conditions allow), thus mitigating the potentially awful performance imp=
act
> -of unplanned swapping.
> -
> -A KVM implementation is underway and has been RFC'ed to lkml.  And,
> -using frontswap, investigation is also underway on the use of NVM as
> -a memory extension technology.
> -
> -* Sure there may be performance advantages in some situations, but
> -  what's the space/time overhead of frontswap?
> -
> -If CONFIG_FRONTSWAP is disabled, every frontswap hook compiles into
> -nothingness and the only overhead is a few extra bytes per swapon'ed
> -swap device.  If CONFIG_FRONTSWAP is enabled but no frontswap "backend"
> -registers, there is one extra global variable compared to zero for
> -every swap page read or written.  If CONFIG_FRONTSWAP is enabled
> -AND a frontswap backend registers AND the backend fails every "store"
> -request (i.e. provides no memory despite claiming it might),
> -CPU overhead is still negligible -- and since every frontswap fail
> -precedes a swap page write-to-disk, the system is highly likely
> -to be I/O bound and using a small fraction of a percent of a CPU
> -will be irrelevant anyway.
> -
> -As for space, if CONFIG_FRONTSWAP is enabled AND a frontswap backend
> -registers, one bit is allocated for every swap page for every swap
> -device that is swapon'd.  This is added to the EIGHT bits (which
> -was sixteen until about 2.6.34) that the kernel already allocates
> -for every swap page for every swap device that is swapon'd.  (Hugh
> -Dickins has observed that frontswap could probably steal one of
> -the existing eight bits, but let's worry about that minor optimization
> -later.)  For very large swap disks (which are rare) on a standard
> -4K pagesize, this is 1MB per 32GB swap.
> -
> -When swap pages are stored in transcendent memory instead of written
> -out to disk, there is a side effect that this may create more memory
> -pressure that can potentially outweigh the other advantages.  A
> -backend, such as zcache, must implement policies to carefully (but
> -dynamically) manage memory limits to ensure this doesn't happen.
> -
> -* OK, how about a quick overview of what this frontswap patch does
> -  in terms that a kernel hacker can grok?
> -
> -Let's assume that a frontswap "backend" has registered during
> -kernel initialization; this registration indicates that this
> -frontswap backend has access to some "memory" that is not directly
> -accessible by the kernel.  Exactly how much memory it provides is
> -entirely dynamic and random.
> -
> -Whenever a swap-device is swapon'd frontswap_init() is called,
> -passing the swap device number (aka "type") as a parameter.
> -This notifies frontswap to expect attempts to "store" swap pages
> -associated with that number.
> -
> -Whenever the swap subsystem is readying a page to write to a swap
> -device (c.f swap_writepage()), frontswap_store is called.  Frontswap
> -consults with the frontswap backend and if the backend says it does NOT
> -have room, frontswap_store returns -1 and the kernel swaps the page
> -to the swap device as normal.  Note that the response from the frontswap
> -backend is unpredictable to the kernel; it may choose to never accept a
> -page, it could accept every ninth page, or it might accept every
> -page.  But if the backend does accept a page, the data from the page
> -has already been copied and associated with the type and offset,
> -and the backend guarantees the persistence of the data.  In this case,
> -frontswap sets a bit in the "frontswap_map" for the swap device
> -corresponding to the page offset on the swap device to which it would
> -otherwise have written the data.
> -
> -When the swap subsystem needs to swap-in a page (swap_readpage()),
> -it first calls frontswap_load() which checks the frontswap_map to
> -see if the page was earlier accepted by the frontswap backend.  If
> -it was, the page of data is filled from the frontswap backend and
> -the swap-in is complete.  If not, the normal swap-in code is
> -executed to obtain the page of data from the real swap device.
> -
> -So every time the frontswap backend accepts a page, a swap device read
> -and (potentially) a swap device write are replaced by a "frontswap backe=
nd
> -store" and (possibly) a "frontswap backend loads", which are presumably =
much
> -faster.
> -
> -* Can't frontswap be configured as a "special" swap device that is
> -  just higher priority than any real swap device (e.g. like zswap,
> -  or maybe swap-over-nbd/NFS)?
> -
> -No.  First, the existing swap subsystem doesn't allow for any kind of
> -swap hierarchy.  Perhaps it could be rewritten to accommodate a hierarch=
y,
> -but this would require fairly drastic changes.  Even if it were
> -rewritten, the existing swap subsystem uses the block I/O layer which
> -assumes a swap device is fixed size and any page in it is linearly
> -addressable.  Frontswap barely touches the existing swap subsystem,
> -and works around the constraints of the block I/O subsystem to provide
> -a great deal of flexibility and dynamicity.
> -
> -For example, the acceptance of any swap page by the frontswap backend is
> -entirely unpredictable. This is critical to the definition of frontswap
> -backends because it grants completely dynamic discretion to the
> -backend.  In zcache, one cannot know a priori how compressible a page is=
.
> -"Poorly" compressible pages can be rejected, and "poorly" can itself be
> -defined dynamically depending on current memory constraints.
> -
> -Further, frontswap is entirely synchronous whereas a real swap
> -device is, by definition, asynchronous and uses block I/O.  The
> -block I/O layer is not only unnecessary, but may perform "optimizations"
> -that are inappropriate for a RAM-oriented device including delaying
> -the write of some pages for a significant amount of time.  Synchrony is
> -required to ensure the dynamicity of the backend and to avoid thorny rac=
e
> -conditions that would unnecessarily and greatly complicate frontswap
> -and/or the block I/O subsystem.  That said, only the initial "store"
> -and "load" operations need be synchronous.  A separate asynchronous thre=
ad
> -is free to manipulate the pages stored by frontswap.  For example,
> -the "remotification" thread in RAMster uses standard asynchronous
> -kernel sockets to move compressed frontswap pages to a remote machine.
> -Similarly, a KVM guest-side implementation could do in-guest compression
> -and use "batched" hypercalls.
> -
> -In a virtualized environment, the dynamicity allows the hypervisor
> -(or host OS) to do "intelligent overcommit".  For example, it can
> -choose to accept pages only until host-swapping might be imminent,
> -then force guests to do their own swapping.
> -
> -There is a downside to the transcendent memory specifications for
> -frontswap:  Since any "store" might fail, there must always be a real
> -slot on a real swap device to swap the page.  Thus frontswap must be
> -implemented as a "shadow" to every swapon'd device with the potential
> -capability of holding every page that the swap device might have held
> -and the possibility that it might hold no pages at all.  This means
> -that frontswap cannot contain more pages than the total of swapon'd
> -swap devices.  For example, if NO swap device is configured on some
> -installation, frontswap is useless.  Swapless portable devices
> -can still use frontswap but a backend for such devices must configure
> -some kind of "ghost" swap device and ensure that it is never used.
> -
> -* Why this weird definition about "duplicate stores"?  If a page
> -  has been previously successfully stored, can't it always be
> -  successfully overwritten?
> -
> -Nearly always it can, but no, sometimes it cannot.  Consider an example
> -where data is compressed and the original 4K page has been compressed
> -to 1K.  Now an attempt is made to overwrite the page with data that
> -is non-compressible and so would take the entire 4K.  But the backend
> -has no more space.  In this case, the store must be rejected.  Whenever
> -frontswap rejects a store that would overwrite, it also must invalidate
> -the old data and ensure that it is no longer accessible.  Since the
> -swap subsystem then writes the new data to the read swap device,
> -this is the correct course of action to ensure coherency.
> -
> -* Why does the frontswap patch create the new include file swapfile.h?
> -
> -The frontswap code depends on some swap-subsystem-internal data
> -structures that have, over the years, moved back and forth between
> -static and global.  This seemed a reasonable compromise:  Define
> -them as global but declare them in a new include file that isn't
> -included by the large number of source files that include swap.h.
> -
> -Dan Magenheimer, last updated April 9, 2012
> diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> index 5a94a921ea40..31d2ac306438 100644
> --- a/Documentation/mm/index.rst
> +++ b/Documentation/mm/index.rst
> @@ -44,7 +44,6 @@ above structured documentation, or deleted if it has se=
rved its purpose.
>     balance
>     damon/index
>     free_page_reporting
> -   frontswap
>     hmm
>     hwpoison
>     hugetlbfs_reserv
> diff --git a/Documentation/translations/zh_CN/mm/frontswap.rst b/Document=
ation/translations/zh_CN/mm/frontswap.rst
> deleted file mode 100644
> index 434975390b48..000000000000
> --- a/Documentation/translations/zh_CN/mm/frontswap.rst
> +++ /dev/null
> @@ -1,196 +0,0 @@
> -:Original: Documentation/mm/frontswap.rst
> -
> -:=E7=BF=BB=E8=AF=91:
> -
> - =E5=8F=B8=E5=BB=B6=E8=85=BE Yanteng Si <siyanteng@loongson.cn>
> -
> -:=E6=A0=A1=E8=AF=91:
> -
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Frontswap
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Frontswap=E4=B8=BA=E4=BA=A4=E6=8D=A2=E9=A1=B5=E6=8F=90=E4=BE=9B=E4=BA=86=
=E4=B8=80=E4=B8=AA =E2=80=9Ctranscendent memory=E2=80=9D =E7=9A=84=E6=8E=A5=
=E5=8F=A3=E3=80=82=E5=9C=A8=E4=B8=80=E4=BA=9B=E7=8E=AF=E5=A2=83=E4=B8=AD=EF=
=BC=8C=E7=94=B1
> -=E4=BA=8E=E4=BA=A4=E6=8D=A2=E9=A1=B5=E8=A2=AB=E4=BF=9D=E5=AD=98=E5=9C=A8=
RAM=EF=BC=88=E6=88=96=E7=B1=BB=E4=BC=BCRAM=E7=9A=84=E8=AE=BE=E5=A4=87=EF=BC=
=89=E4=B8=AD=EF=BC=8C=E8=80=8C=E4=B8=8D=E6=98=AF=E4=BA=A4=E6=8D=A2=E7=A3=81=
=E7=9B=98=EF=BC=8C=E5=9B=A0=E6=AD=A4=E5=8F=AF=E4=BB=A5=E8=8E=B7=E5=BE=97=E5=
=B7=A8=E5=A4=A7=E7=9A=84=E6=80=A7=E8=83=BD
> -=E8=8A=82=E7=9C=81=EF=BC=88=E6=8F=90=E9=AB=98=EF=BC=89=E3=80=82
> -
> -.. _Transcendent memory in a nutshell: https://lwn.net/Articles/454795/
> -
> -Frontswap=E4=B9=8B=E6=89=80=E4=BB=A5=E8=BF=99=E4=B9=88=E5=91=BD=E5=90=8D=
=EF=BC=8C=E6=98=AF=E5=9B=A0=E4=B8=BA=E5=AE=83=E5=8F=AF=E4=BB=A5=E8=A2=AB=E8=
=AE=A4=E4=B8=BA=E6=98=AF=E4=B8=8Eswap=E8=AE=BE=E5=A4=87=E7=9A=84=E2=80=9Cba=
ck=E2=80=9D=E5=AD=98=E5=82=A8=E7=9B=B8=E5=8F=8D=E3=80=82=E5=AD=98
> -=E5=82=A8=E5=99=A8=E8=A2=AB=E8=AE=A4=E4=B8=BA=E6=98=AF=E4=B8=80=E4=B8=AA=
=E5=90=8C=E6=AD=A5=E5=B9=B6=E5=8F=91=E5=AE=89=E5=85=A8=E7=9A=84=E9=9D=A2=E5=
=90=91=E9=A1=B5=E9=9D=A2=E7=9A=84=E2=80=9C=E4=BC=AARAM=E8=AE=BE=E5=A4=87=E2=
=80=9D=EF=BC=8C=E7=AC=A6=E5=90=88transcendent memory
> -=EF=BC=88=E5=A6=82Xen=E7=9A=84=E2=80=9Ctmem=E2=80=9D=EF=BC=8C=E6=88=96=
=E5=86=85=E6=A0=B8=E5=86=85=E5=8E=8B=E7=BC=A9=E5=86=85=E5=AD=98=EF=BC=8C=E5=
=8F=88=E7=A7=B0=E2=80=9Czcache=E2=80=9D=EF=BC=8C=E6=88=96=E6=9C=AA=E6=9D=A5=
=E7=9A=84=E7=B1=BB=E4=BC=BCRAM=E7=9A=84=E8=AE=BE=E5=A4=87=EF=BC=89=E7=9A=84=
=E8=A6=81
> -=E6=B1=82=EF=BC=9B=E8=BF=99=E4=B8=AA=E4=BC=AARAM=E8=AE=BE=E5=A4=87=E4=B8=
=8D=E8=83=BD=E8=A2=AB=E5=86=85=E6=A0=B8=E7=9B=B4=E6=8E=A5=E8=AE=BF=E9=97=AE=
=E6=88=96=E5=AF=BB=E5=9D=80=EF=BC=8C=E5=85=B6=E5=A4=A7=E5=B0=8F=E6=9C=AA=E7=
=9F=A5=E4=B8=94=E5=8F=AF=E8=83=BD=E9=9A=8F=E6=97=B6=E9=97=B4=E5=8F=98=E5=8C=
=96=E3=80=82=E9=A9=B1=E5=8A=A8=E7=A8=8B=E5=BA=8F=E9=80=9A=E8=BF=87
> -=E8=B0=83=E7=94=A8frontswap_register_ops=E5=B0=86=E8=87=AA=E5=B7=B1=E4=
=B8=8Efrontswap=E9=93=BE=E6=8E=A5=E8=B5=B7=E6=9D=A5=EF=BC=8C=E4=BB=A5=E9=80=
=82=E5=BD=93=E5=9C=B0=E8=AE=BE=E7=BD=AEfrontswap_ops
> -=E7=9A=84=E5=8A=9F=E8=83=BD=EF=BC=8C=E5=AE=83=E6=8F=90=E4=BE=9B=E7=9A=84=
=E5=8A=9F=E8=83=BD=E5=BF=85=E9=A1=BB=E7=AC=A6=E5=90=88=E6=9F=90=E4=BA=9B=E7=
=AD=96=E7=95=A5=EF=BC=8C=E5=A6=82=E4=B8=8B=E6=89=80=E7=A4=BA:
> -
> -=E4=B8=80=E4=B8=AA =E2=80=9Cinit=E2=80=9D =E5=B0=86=E8=AE=BE=E5=A4=87=E5=
=87=86=E5=A4=87=E5=A5=BD=E6=8E=A5=E6=94=B6=E4=B8=8E=E6=8C=87=E5=AE=9A=E7=9A=
=84=E4=BA=A4=E6=8D=A2=E8=AE=BE=E5=A4=87=E7=BC=96=E5=8F=B7=EF=BC=88=E5=8F=88=
=E7=A7=B0=E2=80=9C=E7=B1=BB=E5=9E=8B=E2=80=9D=EF=BC=89=E7=9B=B8=E5=85=B3=E7=
=9A=84frontswap
> -=E4=BA=A4=E6=8D=A2=E9=A1=B5=E3=80=82=E4=B8=80=E4=B8=AA =E2=80=9Cstore=E2=
=80=9D =E5=B0=86=E6=8A=8A=E8=AF=A5=E9=A1=B5=E5=A4=8D=E5=88=B6=E5=88=B0trans=
cendent memory=EF=BC=8C=E5=B9=B6=E4=B8=8E=E8=AF=A5=E9=A1=B5=E7=9A=84=E7=B1=
=BB=E5=9E=8B=E5=92=8C=E5=81=8F=E7=A7=BB
> -=E9=87=8F=E7=9B=B8=E5=85=B3=E8=81=94=E3=80=82=E4=B8=80=E4=B8=AA =E2=80=
=9Cload=E2=80=9D =E5=B0=86=E6=8A=8A=E8=AF=A5=E9=A1=B5=EF=BC=8C=E5=A6=82=E6=
=9E=9C=E6=89=BE=E5=88=B0=E7=9A=84=E8=AF=9D=EF=BC=8C=E4=BB=8Etranscendent me=
mory=E5=A4=8D=E5=88=B6=E5=88=B0=E5=86=85=E6=A0=B8
> -=E5=86=85=E5=AD=98=EF=BC=8C=E4=BD=86=E4=B8=8D=E4=BC=9A=E4=BB=8Etranscend=
ent memory=E4=B8=AD=E5=88=A0=E9=99=A4=E8=AF=A5=E9=A1=B5=E3=80=82=E4=B8=80=
=E4=B8=AA =E2=80=9Cinvalidate_page=E2=80=9D =E5=B0=86=E4=BB=8E
> -transcendent memory=E4=B8=AD=E5=88=A0=E9=99=A4=E8=AF=A5=E9=A1=B5=EF=BC=
=8C=E4=B8=80=E4=B8=AA =E2=80=9Cinvalidate_area=E2=80=9D =E5=B0=86=E5=88=A0=
=E9=99=A4=E6=89=80=E6=9C=89=E4=B8=8E=E4=BA=A4=E6=8D=A2=E7=B1=BB=E5=9E=8B
> -=E7=9B=B8=E5=85=B3=E7=9A=84=E9=A1=B5=EF=BC=88=E4=BE=8B=E5=A6=82=EF=BC=8C=
=E5=83=8Fswapoff=EF=BC=89=E5=B9=B6=E9=80=9A=E7=9F=A5 =E2=80=9Cdevice=E2=80=
=9D =E6=8B=92=E7=BB=9D=E8=BF=9B=E4=B8=80=E6=AD=A5=E5=AD=98=E5=82=A8=E8=AF=
=A5=E4=BA=A4=E6=8D=A2=E7=B1=BB=E5=9E=8B=E3=80=82
> -
> -=E4=B8=80=E6=97=A6=E4=B8=80=E4=B8=AA=E9=A1=B5=E9=9D=A2=E8=A2=AB=E6=88=90=
=E5=8A=9F=E5=AD=98=E5=82=A8=EF=BC=8C=E5=9C=A8=E8=AF=A5=E9=A1=B5=E9=9D=A2=E4=
=B8=8A=E7=9A=84=E5=8C=B9=E9=85=8D=E5=8A=A0=E8=BD=BD=E9=80=9A=E5=B8=B8=E4=BC=
=9A=E6=88=90=E5=8A=9F=E3=80=82=E5=9B=A0=E6=AD=A4=EF=BC=8C=E5=BD=93=E5=86=85=
=E6=A0=B8=E5=8F=91=E7=8E=B0=E8=87=AA=E5=B7=B1=E5=A4=84=E4=BA=8E=E9=9C=80
> -=E8=A6=81=E4=BA=A4=E6=8D=A2=E9=A1=B5=E9=9D=A2=E7=9A=84=E6=83=85=E5=86=B5=
=E6=97=B6=EF=BC=8C=E5=AE=83=E9=A6=96=E5=85=88=E5=B0=9D=E8=AF=95=E4=BD=BF=E7=
=94=A8frontswap=E3=80=82=E5=A6=82=E6=9E=9C=E5=AD=98=E5=82=A8=E7=9A=84=E7=BB=
=93=E6=9E=9C=E6=98=AF=E6=88=90=E5=8A=9F=E7=9A=84=EF=BC=8C=E9=82=A3=E4=B9=88=
=E6=95=B0=E6=8D=AE=E5=B0=B1=E5=B7=B2
> -=E7=BB=8F=E6=88=90=E5=8A=9F=E7=9A=84=E4=BF=9D=E5=AD=98=E5=88=B0=E4=BA=86=
transcendent memory=E4=B8=AD=EF=BC=8C=E5=B9=B6=E4=B8=94=E9=81=BF=E5=85=8D=
=E4=BA=86=E7=A3=81=E7=9B=98=E5=86=99=E5=85=A5=EF=BC=8C=E5=A6=82=E6=9E=9C=E5=
=90=8E=E6=9D=A5=E5=86=8D=E8=AF=BB=E5=9B=9E=E6=95=B0=E6=8D=AE=EF=BC=8C
> -=E4=B9=9F=E9=81=BF=E5=85=8D=E4=BA=86=E7=A3=81=E7=9B=98=E8=AF=BB=E5=8F=96=
=E3=80=82=E5=A6=82=E6=9E=9C=E5=AD=98=E5=82=A8=E8=BF=94=E5=9B=9E=E5=A4=B1=E8=
=B4=A5=EF=BC=8Ctranscendent memory=E5=B7=B2=E7=BB=8F=E6=8B=92=E7=BB=9D=E4=
=BA=86=E8=AF=A5=E6=95=B0=E6=8D=AE=EF=BC=8C=E4=B8=94=E8=AF=A5=E9=A1=B5
> -=E5=8F=AF=E4=BB=A5=E5=83=8F=E5=BE=80=E5=B8=B8=E4=B8=80=E6=A0=B7=E8=A2=AB=
=E5=86=99=E5=85=A5=E4=BA=A4=E6=8D=A2=E7=A9=BA=E9=97=B4=E3=80=82
> -
> -=E8=AF=B7=E6=B3=A8=E6=84=8F=EF=BC=8C=E5=A6=82=E6=9E=9C=E4=B8=80=E4=B8=AA=
=E9=A1=B5=E9=9D=A2=E8=A2=AB=E5=AD=98=E5=82=A8=EF=BC=8C=E8=80=8C=E8=AF=A5=E9=
=A1=B5=E9=9D=A2=E5=B7=B2=E7=BB=8F=E5=AD=98=E5=9C=A8=E4=BA=8Etranscendent me=
mory=E4=B8=AD=EF=BC=88=E4=B8=80=E4=B8=AA =E2=80=9C=E9=87=8D=E5=A4=8D=E2=80=
=9D
> -=E7=9A=84=E5=AD=98=E5=82=A8=EF=BC=89=EF=BC=8C=E8=A6=81=E4=B9=88=E5=AD=98=
=E5=82=A8=E6=88=90=E5=8A=9F=EF=BC=8C=E6=95=B0=E6=8D=AE=E8=A2=AB=E8=A6=86=E7=
=9B=96=EF=BC=8C=E8=A6=81=E4=B9=88=E5=AD=98=E5=82=A8=E5=A4=B1=E8=B4=A5=EF=BC=
=8C=E8=AF=A5=E9=A1=B5=E9=9D=A2=E8=A2=AB=E5=BA=9F=E6=AD=A2=E3=80=82=E8=BF=99=
=E7=A1=AE=E4=BF=9D=E4=BA=86=E6=97=A7=E7=9A=84=E6=95=B0=E6=8D=AE=E6=B0=B8=E8=
=BF=9C
> -=E4=B8=8D=E4=BC=9A=E4=BB=8Efrontswap=E4=B8=AD=E8=8E=B7=E5=BE=97=E3=80=82
> -
> -=E5=A6=82=E6=9E=9C=E9=85=8D=E7=BD=AE=E6=AD=A3=E7=A1=AE=EF=BC=8C=E5=AF=B9=
frontswap=E7=9A=84=E7=9B=91=E6=8E=A7=E6=98=AF=E9=80=9A=E8=BF=87 `/sys/kerne=
l/debug/frontswap` =E7=9B=AE=E5=BD=95=E4=B8=8B=E7=9A=84
> -debugfs=E5=AE=8C=E6=88=90=E7=9A=84=E3=80=82frontswap=E7=9A=84=E6=9C=89=
=E6=95=88=E6=80=A7=E5=8F=AF=E4=BB=A5=E9=80=9A=E8=BF=87=E4=BB=A5=E4=B8=8B=E6=
=96=B9=E5=BC=8F=E6=B5=8B=E9=87=8F=EF=BC=88=E5=9C=A8=E6=89=80=E6=9C=89=E4=BA=
=A4=E6=8D=A2=E8=AE=BE=E5=A4=87=E4=B8=AD=EF=BC=89:
> -
> -``failed_stores``
> -       =E6=9C=89=E5=A4=9A=E5=B0=91=E6=AC=A1=E5=AD=98=E5=82=A8=E7=9A=84=
=E5=B0=9D=E8=AF=95=E6=98=AF=E5=A4=B1=E8=B4=A5=E7=9A=84
> -
> -``loads``
> -       =E5=B0=9D=E8=AF=95=E4=BA=86=E5=A4=9A=E5=B0=91=E6=AC=A1=E5=8A=A0=
=E8=BD=BD=EF=BC=88=E5=BA=94=E8=AF=A5=E5=85=A8=E9=83=A8=E6=88=90=E5=8A=9F=EF=
=BC=89
> -
> -``succ_stores``
> -       =E6=9C=89=E5=A4=9A=E5=B0=91=E6=AC=A1=E5=AD=98=E5=82=A8=E7=9A=84=
=E5=B0=9D=E8=AF=95=E6=98=AF=E6=88=90=E5=8A=9F=E7=9A=84
> -
> -``invalidates``
> -       =E5=B0=9D=E8=AF=95=E4=BA=86=E5=A4=9A=E5=B0=91=E6=AC=A1=E4=BD=9C=
=E5=BA=9F
> -
> -=E5=90=8E=E5=8F=B0=E5=AE=9E=E7=8E=B0=E5=8F=AF=E4=BB=A5=E6=8F=90=E4=BE=9B=
=E9=A2=9D=E5=A4=96=E7=9A=84=E6=8C=87=E6=A0=87=E3=80=82
> -
> -=E7=BB=8F=E5=B8=B8=E9=97=AE=E5=88=B0=E7=9A=84=E9=97=AE=E9=A2=98
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -* =E4=BB=B7=E5=80=BC=E5=9C=A8=E5=93=AA=E9=87=8C?
> -
> -=E5=BD=93=E4=B8=80=E4=B8=AA=E5=B7=A5=E4=BD=9C=E8=B4=9F=E8=BD=BD=E5=BC=80=
=E5=A7=8B=E4=BA=A4=E6=8D=A2=E6=97=B6=EF=BC=8C=E6=80=A7=E8=83=BD=E5=B0=B1=E4=
=BC=9A=E4=B8=8B=E9=99=8D=E3=80=82Frontswap=E9=80=9A=E8=BF=87=E6=8F=90=E4=BE=
=9B=E4=B8=80=E4=B8=AA=E5=B9=B2=E5=87=80=E7=9A=84=E3=80=81=E5=8A=A8=E6=80=81=
=E7=9A=84=E6=8E=A5=E5=8F=A3=E6=9D=A5
> -=E8=AF=BB=E5=8F=96=E5=92=8C=E5=86=99=E5=85=A5=E4=BA=A4=E6=8D=A2=E9=A1=B5=
=E5=88=B0 =E2=80=9Ctranscendent memory=E2=80=9D=EF=BC=8C=E4=BB=8E=E8=80=8C=
=E5=A4=A7=E5=A4=A7=E5=A2=9E=E5=8A=A0=E4=BA=86=E8=AE=B8=E5=A4=9A=E8=BF=99=E6=
=A0=B7=E7=9A=84=E5=B7=A5=E4=BD=9C=E8=B4=9F=E8=BD=BD=E7=9A=84=E6=80=A7
> -=E8=83=BD=EF=BC=8C=E5=90=A6=E5=88=99=E5=86=85=E6=A0=B8=E6=98=AF=E6=97=A0=
=E6=B3=95=E7=9B=B4=E6=8E=A5=E5=AF=BB=E5=9D=80=E7=9A=84=E3=80=82=E5=BD=93=E6=
=95=B0=E6=8D=AE=E8=A2=AB=E8=BD=AC=E6=8D=A2=E4=B8=BA=E4=B8=8D=E5=90=8C=E7=9A=
=84=E5=BD=A2=E5=BC=8F=E5=92=8C=E5=A4=A7=E5=B0=8F=EF=BC=88=E6=AF=94=E5=A6=82=
=E5=8E=8B=E7=BC=A9=EF=BC=89=E6=88=96=E8=80=85=E8=A2=AB=E7=A7=98=E5=AF=86
> -=E7=A7=BB=E5=8A=A8=EF=BC=88=E5=AF=B9=E4=BA=8E=E4=B8=80=E4=BA=9B=E7=B1=BB=
=E4=BC=BCRAM=E7=9A=84=E8=AE=BE=E5=A4=87=E6=9D=A5=E8=AF=B4=EF=BC=8C=E8=BF=99=
=E5=8F=AF=E8=83=BD=E5=AF=B9=E5=86=99=E5=B9=B3=E8=A1=A1=E5=BE=88=E6=9C=89=E7=
=94=A8=EF=BC=89=E6=97=B6=EF=BC=8C=E8=BF=99=E4=B8=AA=E6=8E=A5=E5=8F=A3=E6=98=
=AF=E7=90=86=E6=83=B3=E7=9A=84=E3=80=82=E4=BA=A4=E6=8D=A2
> -=E9=A1=B5=EF=BC=88=E5=92=8C=E8=A2=AB=E9=A9=B1=E9=80=90=E7=9A=84=E9=A1=B5=
=E9=9D=A2=E7=BC=93=E5=AD=98=E9=A1=B5=EF=BC=89=E6=98=AF=E8=BF=99=E7=A7=8D=E6=
=AF=94RAM=E6=85=A2=E4=BD=86=E6=AF=94=E7=A3=81=E7=9B=98=E5=BF=AB=E5=BE=97=E5=
=A4=9A=E7=9A=84=E2=80=9C=E4=BC=AARAM=E8=AE=BE=E5=A4=87=E2=80=9D=E7=9A=84=E4=
=B8=80=E5=A4=A7=E7=94=A8=E9=80=94=E3=80=82
> -
> -Frontswap=E5=AF=B9=E5=86=85=E6=A0=B8=E7=9A=84=E5=BD=B1=E5=93=8D=E7=9B=B8=
=E5=BD=93=E5=B0=8F=EF=BC=8C=E4=B8=BA=E5=90=84=E7=A7=8D=E7=B3=BB=E7=BB=9F=E9=
=85=8D=E7=BD=AE=E4=B8=AD=E6=9B=B4=E5=8A=A8=E6=80=81=E3=80=81=E6=9B=B4=E7=81=
=B5=E6=B4=BB=E7=9A=84RAM=E5=88=A9=E7=94=A8=E6=8F=90=E4=BE=9B=E4=BA=86=E5=B7=
=A8=E5=A4=A7=E7=9A=84
> -=E7=81=B5=E6=B4=BB=E6=80=A7=EF=BC=9A
> -
> -=E5=9C=A8=E5=8D=95=E4=B8=80=E5=86=85=E6=A0=B8=E7=9A=84=E6=83=85=E5=86=B5=
=E4=B8=8B=EF=BC=8C=E5=8F=88=E7=A7=B0=E2=80=9Czcache=E2=80=9D=EF=BC=8C=E9=A1=
=B5=E9=9D=A2=E8=A2=AB=E5=8E=8B=E7=BC=A9=E5=B9=B6=E5=AD=98=E5=82=A8=E5=9C=A8=
=E6=9C=AC=E5=9C=B0=E5=86=85=E5=AD=98=E4=B8=AD=EF=BC=8C=E4=BB=8E=E8=80=8C=E5=
=A2=9E=E5=8A=A0=E4=BA=86=E5=8F=AF=E4=BB=A5=E5=AE=89
> -=E5=85=A8=E4=BF=9D=E5=AD=98=E5=9C=A8RAM=E4=B8=AD=E7=9A=84=E5=8C=BF=E5=90=
=8D=E9=A1=B5=E9=9D=A2=E6=80=BB=E6=95=B0=E3=80=82Zcache=E6=9C=AC=E8=B4=A8=E4=
=B8=8A=E6=98=AF=E7=94=A8=E5=8E=8B=E7=BC=A9/=E8=A7=A3=E5=8E=8B=E7=BC=A9=E7=
=9A=84CPU=E5=91=A8=E6=9C=9F=E6=8D=A2=E5=8F=96=E6=9B=B4=E5=A5=BD=E7=9A=84=E5=
=86=85=E5=AD=98=E5=88=A9
> -=E7=94=A8=E7=8E=87=E3=80=82Benchmarks=E6=B5=8B=E8=AF=95=E6=98=BE=E7=A4=
=BA=EF=BC=8C=E5=BD=93=E5=86=85=E5=AD=98=E5=8E=8B=E5=8A=9B=E8=BE=83=E4=BD=8E=
=E6=97=B6=EF=BC=8C=E5=87=A0=E4=B9=8E=E6=B2=A1=E6=9C=89=E5=BD=B1=E5=93=8D=EF=
=BC=8C=E8=80=8C=E5=9C=A8=E9=AB=98=E5=86=85=E5=AD=98=E5=8E=8B=E5=8A=9B=E4=B8=
=8B=E7=9A=84=E4=B8=80=E4=BA=9B
> -=E5=B7=A5=E4=BD=9C=E8=B4=9F=E8=BD=BD=E4=B8=8A=EF=BC=8C=E5=88=99=E6=9C=89=
=E6=98=8E=E6=98=BE=E7=9A=84=E6=80=A7=E8=83=BD=E6=94=B9=E5=96=84=EF=BC=8825%=
=E4=BB=A5=E4=B8=8A=EF=BC=89=E3=80=82
> -
> -=E2=80=9CRAMster=E2=80=9D =E5=9C=A8zcache=E7=9A=84=E5=9F=BA=E7=A1=80=E4=
=B8=8A=E5=A2=9E=E5=8A=A0=E4=BA=86=E5=AF=B9=E9=9B=86=E7=BE=A4=E7=B3=BB=E7=BB=
=9F=E7=9A=84 =E2=80=9Cpeer-to-peer=E2=80=9D transcendent memory
> -=E7=9A=84=E6=94=AF=E6=8C=81=E3=80=82Frontswap=E9=A1=B5=E9=9D=A2=E5=83=8F=
zcache=E4=B8=80=E6=A0=B7=E8=A2=AB=E6=9C=AC=E5=9C=B0=E5=8E=8B=E7=BC=A9=EF=BC=
=8C=E4=BD=86=E9=9A=8F=E5=90=8E=E8=A2=AB=E2=80=9Cremotified=E2=80=9D =E5=88=
=B0=E5=8F=A6=E4=B8=80=E4=B8=AA=E7=B3=BB
> -=E7=BB=9F=E7=9A=84RAM=E3=80=82=E8=BF=99=E4=BD=BF=E5=BE=97RAM=E5=8F=AF=E4=
=BB=A5=E6=A0=B9=E6=8D=AE=E9=9C=80=E8=A6=81=E5=8A=A8=E6=80=81=E5=9C=B0=E6=9D=
=A5=E5=9B=9E=E8=B4=9F=E8=BD=BD=E5=B9=B3=E8=A1=A1=EF=BC=8C=E4=B9=9F=E5=B0=B1=
=E6=98=AF=E8=AF=B4=EF=BC=8C=E5=BD=93=E7=B3=BB=E7=BB=9FA=E8=B6=85=E8=BD=BD=
=E6=97=B6=EF=BC=8C=E5=AE=83=E5=8F=AF=E4=BB=A5
> -=E4=BA=A4=E6=8D=A2=E5=88=B0=E7=B3=BB=E7=BB=9FB=EF=BC=8C=E5=8F=8D=E4=B9=
=8B=E4=BA=A6=E7=84=B6=E3=80=82RAMster=E4=B9=9F=E5=8F=AF=E4=BB=A5=E8=A2=AB=
=E9=85=8D=E7=BD=AE=E6=88=90=E4=B8=80=E4=B8=AA=E5=86=85=E5=AD=98=E6=9C=8D=E5=
=8A=A1=E5=99=A8=EF=BC=8C=E5=9B=A0=E6=AD=A4=E9=9B=86=E7=BE=A4=E4=B8=AD=E7=9A=
=84=E8=AE=B8=E5=A4=9A=E6=9C=8D=E5=8A=A1=E5=99=A8
> -=E5=8F=AF=E4=BB=A5=E6=A0=B9=E6=8D=AE=E9=9C=80=E8=A6=81=E5=8A=A8=E6=80=81=
=E5=9C=B0=E4=BA=A4=E6=8D=A2=E5=88=B0=E9=85=8D=E7=BD=AE=E6=9C=89=E5=A4=A7=E9=
=87=8F=E5=86=85=E5=AD=98=E7=9A=84=E5=8D=95=E4=B8=80=E6=9C=8D=E5=8A=A1=E5=99=
=A8=E4=B8=8A......=E8=80=8C=E4=B8=8D=E9=9C=80=E8=A6=81=E9=A2=84=E5=85=88=E9=
=85=8D=E7=BD=AE=E6=AF=8F=E4=B8=AA=E5=AE=A2=E6=88=B7
> -=E6=9C=89=E5=A4=9A=E5=B0=91=E5=86=85=E5=AD=98=E5=8F=AF=E7=94=A8
> -
> -=E5=9C=A8=E8=99=9A=E6=8B=9F=E6=83=85=E5=86=B5=E4=B8=8B=EF=BC=8C=E8=99=9A=
=E6=8B=9F=E5=8C=96=E7=9A=84=E5=85=A8=E9=83=A8=E6=84=8F=E4=B9=89=E5=9C=A8=E4=
=BA=8E=E7=BB=9F=E8=AE=A1=E5=9C=B0=E5=B0=86=E7=89=A9=E7=90=86=E8=B5=84=E6=BA=
=90=E5=9C=A8=E5=A4=9A=E4=B8=AA=E8=99=9A=E6=8B=9F=E6=9C=BA=E7=9A=84=E4=B8=8D=
=E5=90=8C=E9=9C=80=E6=B1=82=E4=B9=8B=E9=97=B4=E8=BF=9B=E8=A1=8C=E5=A4=8D
> -=E7=94=A8=E3=80=82=E5=AF=B9=E4=BA=8ERAM=E6=9D=A5=E8=AF=B4=EF=BC=8C=E8=BF=
=99=E7=9C=9F=E7=9A=84=E5=BE=88=E9=9A=BE=E5=81=9A=E5=88=B0=EF=BC=8C=E8=80=8C=
=E4=B8=94=E5=9C=A8=E4=B8=8D=E6=94=B9=E5=8F=98=E5=86=85=E6=A0=B8=E7=9A=84=E6=
=83=85=E5=86=B5=E4=B8=8B=EF=BC=8C=E8=A6=81=E5=81=9A=E5=A5=BD=E8=BF=99=E4=B8=
=80=E7=82=B9=E7=9A=84=E5=8A=AA=E5=8A=9B=E5=9F=BA=E6=9C=AC=E4=B8=8A
> -=E6=98=AF=E5=A4=B1=E8=B4=A5=E7=9A=84=EF=BC=88=E9=99=A4=E4=BA=86=E4=B8=80=
=E4=BA=9B=E5=B9=BF=E4=B8=BA=E4=BA=BA=E7=9F=A5=E7=9A=84=E7=89=B9=E6=AE=8A=E6=
=83=85=E5=86=B5=E4=B8=8B=E7=9A=84=E5=B7=A5=E4=BD=9C=E8=B4=9F=E8=BD=BD=EF=BC=
=89=E3=80=82=E5=85=B7=E4=BD=93=E6=9D=A5=E8=AF=B4=EF=BC=8CXen Transcendent M=
emory
> -=E5=90=8E=E7=AB=AF=E5=85=81=E8=AE=B8=E7=AE=A1=E7=90=86=E5=99=A8=E6=8B=A5=
=E6=9C=89=E7=9A=84RAM =E2=80=9Cfallow=E2=80=9D=EF=BC=8C=E4=B8=8D=E4=BB=85=
=E5=8F=AF=E4=BB=A5=E5=9C=A8=E5=A4=9A=E4=B8=AA=E8=99=9A=E6=8B=9F=E6=9C=BA=E4=
=B9=8B=E9=97=B4=E8=BF=9B=E8=A1=8C=E2=80=9Ctime-shared=E2=80=9D=EF=BC=8C
> -=E8=80=8C=E4=B8=94=E9=A1=B5=E9=9D=A2=E5=8F=AF=E4=BB=A5=E8=A2=AB=E5=8E=8B=
=E7=BC=A9=E5=92=8C=E9=87=8D=E5=A4=8D=E5=88=A9=E7=94=A8=EF=BC=8C=E4=BB=A5=E4=
=BC=98=E5=8C=96RAM=E7=9A=84=E5=88=A9=E7=94=A8=E7=8E=87=E3=80=82=E5=BD=93=E5=
=AE=A2=E6=88=B7=E6=93=8D=E4=BD=9C=E7=B3=BB=E7=BB=9F=E8=A2=AB=E8=AF=B1=E5=AF=
=BC=E4=BA=A4=E5=87=BA=E6=9C=AA=E5=85=85=E5=88=86=E5=88=A9=E7=94=A8
> -=E7=9A=84RAM=E6=97=B6=EF=BC=88=E5=A6=82 =E2=80=9Cselfballooning=E2=80=9D=
=EF=BC=89=EF=BC=8C=E7=AA=81=E7=84=B6=E5=87=BA=E7=8E=B0=E7=9A=84=E6=84=8F=E5=
=A4=96=E5=86=85=E5=AD=98=E5=8E=8B=E5=8A=9B=E5=8F=AF=E8=83=BD=E4=BC=9A=E5=AF=
=BC=E8=87=B4=E4=BA=A4=E6=8D=A2=EF=BC=9Bfrontswap
> -=E5=85=81=E8=AE=B8=E8=BF=99=E4=BA=9B=E9=A1=B5=E9=9D=A2=E8=A2=AB=E4=BA=A4=
=E6=8D=A2=E5=88=B0=E7=AE=A1=E7=90=86=E5=99=A8RAM=E4=B8=AD=E6=88=96=E4=BB=8E=
=E7=AE=A1=E7=90=86=E5=99=A8RAM=E4=B8=AD=E4=BA=A4=E6=8D=A2=EF=BC=88=E5=A6=82=
=E6=9E=9C=E6=95=B4=E4=BD=93=E4=B8=BB=E6=9C=BA=E7=B3=BB=E7=BB=9F=E5=86=85=E5=
=AD=98=E6=9D=A1=E4=BB=B6=E5=85=81=E8=AE=B8=EF=BC=89=EF=BC=8C
> -=E4=BB=8E=E8=80=8C=E5=87=8F=E8=BD=BB=E8=AE=A1=E5=88=92=E5=A4=96=E4=BA=A4=
=E6=8D=A2=E5=8F=AF=E8=83=BD=E5=B8=A6=E6=9D=A5=E7=9A=84=E5=8F=AF=E6=80=95=E7=
=9A=84=E6=80=A7=E8=83=BD=E5=BD=B1=E5=93=8D=E3=80=82
> -
> -=E4=B8=80=E4=B8=AAKVM=E7=9A=84=E5=AE=9E=E7=8E=B0=E6=AD=A3=E5=9C=A8=E8=BF=
=9B=E8=A1=8C=E4=B8=AD=EF=BC=8C=E5=B9=B6=E4=B8=94=E5=B7=B2=E7=BB=8F=E8=A2=AB=
RFC'ed=E5=88=B0lkml=E3=80=82=E8=80=8C=E4=B8=94=EF=BC=8C=E5=88=A9=E7=94=A8fr=
ontswap=EF=BC=8C=E5=AF=B9NVM=E4=BD=9C=E4=B8=BA
> -=E5=86=85=E5=AD=98=E6=89=A9=E5=B1=95=E6=8A=80=E6=9C=AF=E7=9A=84=E8=B0=83=
=E6=9F=A5=E4=B9=9F=E5=9C=A8=E8=BF=9B=E8=A1=8C=E4=B8=AD=E3=80=82
> -
> -* =E5=BD=93=E7=84=B6=EF=BC=8C=E5=9C=A8=E6=9F=90=E4=BA=9B=E6=83=85=E5=86=
=B5=E4=B8=8B=E5=8F=AF=E8=83=BD=E6=9C=89=E6=80=A7=E8=83=BD=E4=B8=8A=E7=9A=84=
=E4=BC=98=E5=8A=BF=EF=BC=8C=E4=BD=86frontswap=E7=9A=84=E7=A9=BA=E9=97=B4/=
=E6=97=B6=E9=97=B4=E5=BC=80=E9=94=80=E6=98=AF=E5=A4=9A=E5=B0=91=EF=BC=9F
> -
> -=E5=A6=82=E6=9E=9C CONFIG_FRONTSWAP =E8=A2=AB=E7=A6=81=E7=94=A8=EF=BC=8C=
=E6=AF=8F=E4=B8=AA frontswap =E9=92=A9=E5=AD=90=E9=83=BD=E4=BC=9A=E7=BC=96=
=E8=AF=91=E6=88=90=E7=A9=BA=EF=BC=8C=E5=94=AF=E4=B8=80=E7=9A=84=E5=BC=80=E9=
=94=80=E6=98=AF=E6=AF=8F
> -=E4=B8=AA swapon'ed swap =E8=AE=BE=E5=A4=87=E7=9A=84=E5=87=A0=E4=B8=AA=
=E9=A2=9D=E5=A4=96=E5=AD=97=E8=8A=82=E3=80=82=E5=A6=82=E6=9E=9C CONFIG_FRON=
TSWAP =E8=A2=AB=E5=90=AF=E7=94=A8=EF=BC=8C=E4=BD=86=E6=B2=A1=E6=9C=89
> -frontswap=E7=9A=84 =E2=80=9Cbackend=E2=80=9D =E5=AF=84=E5=AD=98=E5=99=A8=
=EF=BC=8C=E6=AF=8F=E8=AF=BB=E6=88=96=E5=86=99=E4=B8=80=E4=B8=AA=E4=BA=A4=E6=
=8D=A2=E9=A1=B5=E5=B0=B1=E4=BC=9A=E6=9C=89=E4=B8=80=E4=B8=AA=E9=A2=9D=E5=A4=
=96=E7=9A=84=E5=85=A8=E5=B1=80=E5=8F=98=E9=87=8F=EF=BC=8C=E8=80=8C=E4=B8=8D
> -=E6=98=AF=E9=9B=B6=E3=80=82=E5=A6=82=E6=9E=9C CONFIG_FRONTSWAP =E8=A2=AB=
=E5=90=AF=E7=94=A8=EF=BC=8C=E5=B9=B6=E4=B8=94=E6=9C=89=E4=B8=80=E4=B8=AAfro=
ntswap=E7=9A=84backend=E5=AF=84=E5=AD=98=E5=99=A8=EF=BC=8C=E5=B9=B6=E4=B8=
=94
> -=E5=90=8E=E7=AB=AF=E6=AF=8F=E6=AC=A1 =E2=80=9Cstore=E2=80=9D =E8=AF=B7=
=E6=B1=82=E9=83=BD=E5=A4=B1=E8=B4=A5=EF=BC=88=E5=8D=B3=E5=B0=BD=E7=AE=A1=E5=
=A3=B0=E7=A7=B0=E5=8F=AF=E8=83=BD=EF=BC=8C=E4=BD=86=E6=B2=A1=E6=9C=89=E6=8F=
=90=E4=BE=9B=E5=86=85=E5=AD=98=EF=BC=89=EF=BC=8CCPU =E7=9A=84=E5=BC=80=E9=
=94=80=E4=BB=8D=E7=84=B6=E5=8F=AF=E4=BB=A5
> -=E5=BF=BD=E7=95=A5=E4=B8=8D=E8=AE=A1 - =E5=9B=A0=E4=B8=BA=E6=AF=8F=E6=AC=
=A1frontswap=E5=A4=B1=E8=B4=A5=E9=83=BD=E6=98=AF=E5=9C=A8=E4=BA=A4=E6=8D=A2=
=E9=A1=B5=E5=86=99=E5=88=B0=E7=A3=81=E7=9B=98=E4=B9=8B=E5=89=8D=EF=BC=8C=E7=
=B3=BB=E7=BB=9F=E5=BE=88=E5=8F=AF=E8=83=BD=E6=98=AF I/O =E7=BB=91=E5=AE=9A
> -=E7=9A=84=EF=BC=8C=E6=97=A0=E8=AE=BA=E5=A6=82=E4=BD=95=E4=BD=BF=E7=94=A8=
=E4=B8=80=E5=B0=8F=E9=83=A8=E5=88=86=E7=9A=84 CPU =E9=83=BD=E6=98=AF=E4=B8=
=8D=E7=9B=B8=E5=85=B3=E7=9A=84=E3=80=82
> -
> -=E8=87=B3=E4=BA=8E=E7=A9=BA=E9=97=B4=EF=BC=8C=E5=A6=82=E6=9E=9CCONFIG_FR=
ONTSWAP=E8=A2=AB=E5=90=AF=E7=94=A8=EF=BC=8C=E5=B9=B6=E4=B8=94=E6=9C=89=E4=
=B8=80=E4=B8=AAfrontswap=E7=9A=84backend=E6=B3=A8=E5=86=8C=EF=BC=8C=E9=82=
=A3=E4=B9=88
> -=E6=AF=8F=E4=B8=AA=E4=BA=A4=E6=8D=A2=E8=AE=BE=E5=A4=87=E7=9A=84=E6=AF=8F=
=E4=B8=AA=E4=BA=A4=E6=8D=A2=E9=A1=B5=E9=83=BD=E4=BC=9A=E8=A2=AB=E5=88=86=E9=
=85=8D=E4=B8=80=E4=B8=AA=E6=AF=94=E7=89=B9=E3=80=82=E8=BF=99=E6=98=AF=E5=9C=
=A8=E5=86=85=E6=A0=B8=E5=B7=B2=E7=BB=8F=E4=B8=BA=E6=AF=8F=E4=B8=AA=E4=BA=A4=
=E6=8D=A2=E8=AE=BE=E5=A4=87=E7=9A=84=E6=AF=8F=E4=B8=AA=E4=BA=A4=E6=8D=A2
> -=E9=A1=B5=E5=88=86=E9=85=8D=E7=9A=848=E4=BD=8D=EF=BC=88=E5=9C=A82.6.34=
=E4=B9=8B=E5=89=8D=E6=98=AF16=E4=BD=8D=EF=BC=89=E4=B8=8A=E5=A2=9E=E5=8A=A0=
=E7=9A=84=E3=80=82(Hugh Dickins=E8=A7=82=E5=AF=9F=E5=88=B0=EF=BC=8Cfrontswa=
p=E5=8F=AF=E8=83=BD
> -=E4=BC=9A=E5=81=B7=E5=8F=96=E7=8E=B0=E6=9C=89=E7=9A=848=E4=B8=AA=E6=AF=
=94=E7=89=B9=EF=BC=8C=E4=BD=86=E6=98=AF=E6=88=91=E4=BB=AC=E4=BB=A5=E5=90=8E=
=E5=86=8D=E6=9D=A5=E6=8B=85=E5=BF=83=E8=BF=99=E4=B8=AA=E5=B0=8F=E7=9A=84=E4=
=BC=98=E5=8C=96=E9=97=AE=E9=A2=98)=E3=80=82=E5=AF=B9=E4=BA=8E=E6=A0=87=E5=
=87=86=E7=9A=844K=E9=A1=B5=E9=9D=A2=E5=A4=A7=E5=B0=8F=E7=9A=84
> -=E9=9D=9E=E5=B8=B8=E5=A4=A7=E7=9A=84=E4=BA=A4=E6=8D=A2=E7=9B=98=EF=BC=88=
=E8=BF=99=E5=BE=88=E7=BD=95=E8=A7=81=EF=BC=89=EF=BC=8C=E8=BF=99=E6=98=AF=E6=
=AF=8F32GB=E4=BA=A4=E6=8D=A2=E7=9B=981MB=E5=BC=80=E9=94=80=E3=80=82
> -
> -=E5=BD=93=E4=BA=A4=E6=8D=A2=E9=A1=B5=E5=AD=98=E5=82=A8=E5=9C=A8transcend=
ent memory=E4=B8=AD=E8=80=8C=E4=B8=8D=E6=98=AF=E5=86=99=E5=88=B0=E7=A3=81=
=E7=9B=98=E4=B8=8A=E6=97=B6=EF=BC=8C=E6=9C=89=E4=B8=80=E4=B8=AA=E5=89=AF=E4=
=BD=9C=E7=94=A8=EF=BC=8C=E5=8D=B3=E8=BF=99=E5=8F=AF=E8=83=BD=E4=BC=9A
> -=E4=BA=A7=E7=94=9F=E6=9B=B4=E5=A4=9A=E7=9A=84=E5=86=85=E5=AD=98=E5=8E=8B=
=E5=8A=9B=EF=BC=8C=E6=9C=89=E5=8F=AF=E8=83=BD=E8=B6=85=E8=BF=87=E5=85=B6=E4=
=BB=96=E7=9A=84=E4=BC=98=E7=82=B9=E3=80=82=E4=B8=80=E4=B8=AAbackend=EF=BC=
=8C=E6=AF=94=E5=A6=82zcache=EF=BC=8C=E5=BF=85=E9=A1=BB=E5=AE=9E=E7=8E=B0=E7=
=AD=96=E7=95=A5
> -=E6=9D=A5=E4=BB=94=E7=BB=86=EF=BC=88=E4=BD=86=E5=8A=A8=E6=80=81=E5=9C=B0=
=EF=BC=89=E7=AE=A1=E7=90=86=E5=86=85=E5=AD=98=E9=99=90=E5=88=B6=EF=BC=8C=E4=
=BB=A5=E7=A1=AE=E4=BF=9D=E8=BF=99=E7=A7=8D=E6=83=85=E5=86=B5=E4=B8=8D=E4=BC=
=9A=E5=8F=91=E7=94=9F=E3=80=82
> -
> -* =E5=A5=BD=E5=90=A7=EF=BC=8C=E9=82=A3=E5=B0=B1=E7=94=A8=E5=86=85=E6=A0=
=B8=E9=AA=87=E5=AE=A2=E8=83=BD=E7=90=86=E8=A7=A3=E7=9A=84=E6=9C=AF=E8=AF=AD=
=E6=9D=A5=E5=BF=AB=E9=80=9F=E6=A6=82=E8=BF=B0=E4=B8=80=E4=B8=8B=E8=BF=99=E4=
=B8=AAfrontswap=E8=A1=A5=E4=B8=81=E7=9A=84=E4=BD=9C=E7=94=A8=E5=A6=82=E4=BD=
=95=EF=BC=9F
> -
> -=E6=88=91=E4=BB=AC=E5=81=87=E8=AE=BE=E5=9C=A8=E5=86=85=E6=A0=B8=E5=88=9D=
=E5=A7=8B=E5=8C=96=E8=BF=87=E7=A8=8B=E4=B8=AD=EF=BC=8C=E4=B8=80=E4=B8=AAfro=
ntswap =E7=9A=84 =E2=80=9Cbackend=E2=80=9D =E5=B7=B2=E7=BB=8F=E6=B3=A8=E5=
=86=8C=E4=BA=86=EF=BC=9B=E8=BF=99=E4=B8=AA=E6=B3=A8=E5=86=8C=E8=A1=A8
> -=E6=98=8E=E8=BF=99=E4=B8=AAfrontswap =E7=9A=84 =E2=80=9Cbackend=E2=80=9D=
 =E5=8F=AF=E4=BB=A5=E8=AE=BF=E9=97=AE=E4=B8=80=E4=BA=9B=E4=B8=8D=E8=A2=AB=
=E5=86=85=E6=A0=B8=E7=9B=B4=E6=8E=A5=E8=AE=BF=E9=97=AE=E7=9A=84=E2=80=9C=E5=
=86=85=E5=AD=98=E2=80=9D=E3=80=82=E5=AE=83=E5=88=B0=E5=BA=95=E6=8F=90
> -=E4=BE=9B=E4=BA=86=E5=A4=9A=E5=B0=91=E5=86=85=E5=AD=98=E6=98=AF=E5=AE=8C=
=E5=85=A8=E5=8A=A8=E6=80=81=E5=92=8C=E9=9A=8F=E6=9C=BA=E7=9A=84=E3=80=82
> -
> -=E6=AF=8F=E5=BD=93=E4=B8=80=E4=B8=AA=E4=BA=A4=E6=8D=A2=E8=AE=BE=E5=A4=87=
=E8=A2=AB=E4=BA=A4=E6=8D=A2=E6=97=B6=EF=BC=8C=E5=B0=B1=E4=BC=9A=E8=B0=83=E7=
=94=A8frontswap_init()=EF=BC=8C=E6=8A=8A=E4=BA=A4=E6=8D=A2=E8=AE=BE=E5=A4=
=87=E7=9A=84=E7=BC=96=E5=8F=B7=EF=BC=88=E5=8F=88=E7=A7=B0=E2=80=9C=E7=B1=BB
> -=E5=9E=8B=E2=80=9D=EF=BC=89=E4=BD=9C=E4=B8=BA=E4=B8=80=E4=B8=AA=E5=8F=82=
=E6=95=B0=E4=BC=A0=E7=BB=99=E5=AE=83=E3=80=82=E8=BF=99=E5=B0=B1=E9=80=9A=E7=
=9F=A5=E4=BA=86frontswap=EF=BC=8C=E4=BB=A5=E6=9C=9F=E5=BE=85 =E2=80=9Cstore=
=E2=80=9D =E4=B8=8E=E8=AF=A5=E5=8F=B7=E7=A0=81=E7=9B=B8=E5=85=B3=E7=9A=84=
=E4=BA=A4
> -=E6=8D=A2=E9=A1=B5=E7=9A=84=E5=B0=9D=E8=AF=95=E3=80=82
> -
> -=E6=AF=8F=E5=BD=93=E4=BA=A4=E6=8D=A2=E5=AD=90=E7=B3=BB=E7=BB=9F=E5=87=86=
=E5=A4=87=E5=B0=86=E4=B8=80=E4=B8=AA=E9=A1=B5=E9=9D=A2=E5=86=99=E5=85=A5=E4=
=BA=A4=E6=8D=A2=E8=AE=BE=E5=A4=87=E6=97=B6=EF=BC=88=E5=8F=82=E8=A7=81swap_w=
ritepage()=EF=BC=89=EF=BC=8C=E5=B0=B1=E4=BC=9A=E8=B0=83=E7=94=A8
> -frontswap_store=E3=80=82Frontswap=E4=B8=8Efrontswap backend=E5=8D=8F=E5=
=95=86=EF=BC=8C=E5=A6=82=E6=9E=9Cbackend=E8=AF=B4=E5=AE=83=E6=B2=A1=E6=9C=
=89=E7=A9=BA
> -=E9=97=B4=EF=BC=8Cfrontswap_store=E8=BF=94=E5=9B=9E-1=EF=BC=8C=E5=86=85=
=E6=A0=B8=E5=B0=B1=E4=BC=9A=E7=85=A7=E5=B8=B8=E6=8A=8A=E9=A1=B5=E6=8D=A2=E5=
=88=B0=E4=BA=A4=E6=8D=A2=E8=AE=BE=E5=A4=87=E4=B8=8A=E3=80=82=E6=B3=A8=E6=84=
=8F=EF=BC=8C=E6=9D=A5=E8=87=AAfrontswap
> -backend=E7=9A=84=E5=93=8D=E5=BA=94=E5=AF=B9=E5=86=85=E6=A0=B8=E6=9D=A5=
=E8=AF=B4=E6=98=AF=E4=B8=8D=E5=8F=AF=E9=A2=84=E6=B5=8B=E7=9A=84=EF=BC=9B=E5=
=AE=83=E5=8F=AF=E8=83=BD=E9=80=89=E6=8B=A9=E4=BB=8E=E4=B8=8D=E6=8E=A5=E5=8F=
=97=E4=B8=80=E4=B8=AA=E9=A1=B5=E9=9D=A2=EF=BC=8C=E5=8F=AF=E8=83=BD=E6=8E=A5=
=E5=8F=97=E6=AF=8F=E4=B9=9D=E4=B8=AA
> -=E9=A1=B5=E9=9D=A2=EF=BC=8C=E4=B9=9F=E5=8F=AF=E8=83=BD=E6=8E=A5=E5=8F=97=
=E6=AF=8F=E4=B8=80=E4=B8=AA=E9=A1=B5=E9=9D=A2=E3=80=82=E4=BD=86=E6=98=AF=E5=
=A6=82=E6=9E=9Cbackend=E7=A1=AE=E5=AE=9E=E6=8E=A5=E5=8F=97=E4=BA=86=E4=B8=
=80=E4=B8=AA=E9=A1=B5=E9=9D=A2=EF=BC=8C=E9=82=A3=E4=B9=88=E8=BF=99=E4=B8=AA=
=E9=A1=B5=E9=9D=A2=E7=9A=84=E6=95=B0
> -=E6=8D=AE=E5=B7=B2=E7=BB=8F=E8=A2=AB=E5=A4=8D=E5=88=B6=E5=B9=B6=E4=B8=8E=
=E7=B1=BB=E5=9E=8B=E5=92=8C=E5=81=8F=E7=A7=BB=E9=87=8F=E7=9B=B8=E5=85=B3=E8=
=81=94=E4=BA=86=EF=BC=8C=E8=80=8C=E4=B8=94backend=E4=BF=9D=E8=AF=81=E4=BA=
=86=E6=95=B0=E6=8D=AE=E7=9A=84=E6=8C=81=E4=B9=85=E6=80=A7=E3=80=82=E5=9C=A8=
=E8=BF=99=E7=A7=8D=E6=83=85=E5=86=B5
> -=E4=B8=8B=EF=BC=8Cfrontswap=E5=9C=A8=E4=BA=A4=E6=8D=A2=E8=AE=BE=E5=A4=87=
=E7=9A=84=E2=80=9Cfrontswap_map=E2=80=9D =E4=B8=AD=E8=AE=BE=E7=BD=AE=E4=BA=
=86=E4=B8=80=E4=B8=AA=E4=BD=8D=EF=BC=8C=E5=AF=B9=E5=BA=94=E4=BA=8E=E4=BA=A4=
=E6=8D=A2=E8=AE=BE=E5=A4=87=E4=B8=8A=E7=9A=84
> -=E9=A1=B5=E9=9D=A2=E5=81=8F=E7=A7=BB=E9=87=8F=EF=BC=8C=E5=90=A6=E5=88=99=
=E5=AE=83=E5=B0=B1=E4=BC=9A=E5=B0=86=E6=95=B0=E6=8D=AE=E5=86=99=E5=85=A5=E8=
=AF=A5=E8=AE=BE=E5=A4=87=E3=80=82
> -
> -=E5=BD=93=E4=BA=A4=E6=8D=A2=E5=AD=90=E7=B3=BB=E7=BB=9F=E9=9C=80=E8=A6=81=
=E4=BA=A4=E6=8D=A2=E4=B8=80=E4=B8=AA=E9=A1=B5=E9=9D=A2=E6=97=B6=EF=BC=88swa=
p_readpage()=EF=BC=89=EF=BC=8C=E5=AE=83=E9=A6=96=E5=85=88=E8=B0=83=E7=94=A8=
frontswap_load()=EF=BC=8C
> -=E6=A3=80=E6=9F=A5frontswap_map=EF=BC=8C=E7=9C=8B=E8=BF=99=E4=B8=AA=E9=
=A1=B5=E9=9D=A2=E6=98=AF=E5=90=A6=E6=97=A9=E5=85=88=E8=A2=ABfrontswap backe=
nd=E6=8E=A5=E5=8F=97=E3=80=82=E5=A6=82=E6=9E=9C=E6=98=AF=EF=BC=8C=E8=AF=A5=
=E9=A1=B5
> -=E7=9A=84=E6=95=B0=E6=8D=AE=E5=B0=B1=E4=BC=9A=E4=BB=8Efrontswap=E5=90=8E=
=E7=AB=AF=E5=A1=AB=E5=85=85=EF=BC=8C=E6=8D=A2=E5=85=A5=E5=B0=B1=E5=AE=8C=E6=
=88=90=E4=BA=86=E3=80=82=E5=A6=82=E6=9E=9C=E4=B8=8D=E6=98=AF=EF=BC=8C=E6=AD=
=A3=E5=B8=B8=E7=9A=84=E4=BA=A4=E6=8D=A2=E4=BB=A3=E7=A0=81=E5=B0=86=E8=A2=AB=
=E6=89=A7=E8=A1=8C=EF=BC=8C
> -=E4=BB=A5=E4=BE=BF=E4=BB=8E=E7=9C=9F=E6=AD=A3=E7=9A=84=E4=BA=A4=E6=8D=A2=
=E8=AE=BE=E5=A4=87=E4=B8=8A=E8=8E=B7=E5=BE=97=E8=BF=99=E4=B8=80=E9=A1=B5=E7=
=9A=84=E6=95=B0=E6=8D=AE=E3=80=82
> -
> -=E6=89=80=E4=BB=A5=E6=AF=8F=E6=AC=A1frontswap backend=E6=8E=A5=E5=8F=97=
=E4=B8=80=E4=B8=AA=E9=A1=B5=E9=9D=A2=E6=97=B6=EF=BC=8C=E4=BA=A4=E6=8D=A2=E8=
=AE=BE=E5=A4=87=E7=9A=84=E8=AF=BB=E5=8F=96=E5=92=8C=EF=BC=88=E5=8F=AF=E8=83=
=BD=EF=BC=89=E4=BA=A4=E6=8D=A2=E8=AE=BE=E5=A4=87=E7=9A=84=E5=86=99
> -=E5=85=A5=E9=83=BD=E8=A2=AB =E2=80=9Cfrontswap backend store=E2=80=9D =
=E5=92=8C=EF=BC=88=E5=8F=AF=E8=83=BD=EF=BC=89=E2=80=9Cfrontswap backend loa=
ds=E2=80=9D
> -=E6=89=80=E5=8F=96=E4=BB=A3=EF=BC=8C=E8=BF=99=E5=8F=AF=E8=83=BD=E4=BC=9A=
=E5=BF=AB=E5=BE=97=E5=A4=9A=E3=80=82
> -
> -* frontswap=E4=B8=8D=E8=83=BD=E8=A2=AB=E9=85=8D=E7=BD=AE=E4=B8=BA=E4=B8=
=80=E4=B8=AA =E2=80=9C=E7=89=B9=E6=AE=8A=E7=9A=84=E2=80=9D =E4=BA=A4=E6=8D=
=A2=E8=AE=BE=E5=A4=87=EF=BC=8C=E5=AE=83=E7=9A=84=E4=BC=98=E5=85=88=E7=BA=A7=
=E8=A6=81=E9=AB=98=E4=BA=8E=E4=BB=BB=E4=BD=95=E7=9C=9F=E6=AD=A3=E7=9A=84=E4=
=BA=A4=E6=8D=A2
> -  =E8=AE=BE=E5=A4=87=EF=BC=88=E4=BE=8B=E5=A6=82=E5=83=8Fzswap=EF=BC=8C=
=E6=88=96=E8=80=85=E5=8F=AF=E8=83=BD=E6=98=AFswap-over-nbd/NFS=EF=BC=89=EF=
=BC=9F
> -
> -=E9=A6=96=E5=85=88=EF=BC=8C=E7=8E=B0=E6=9C=89=E7=9A=84=E4=BA=A4=E6=8D=A2=
=E5=AD=90=E7=B3=BB=E7=BB=9F=E4=B8=8D=E5=85=81=E8=AE=B8=E6=9C=89=E4=BB=BB=E4=
=BD=95=E7=A7=8D=E7=B1=BB=E7=9A=84=E4=BA=A4=E6=8D=A2=E5=B1=82=E6=AC=A1=E7=BB=
=93=E6=9E=84=E3=80=82=E4=B9=9F=E8=AE=B8=E5=AE=83=E5=8F=AF=E4=BB=A5=E8=A2=AB=
=E9=87=8D=E5=86=99=E4=BB=A5=E9=80=82=E5=BA=94=E5=B1=82=E6=AC=A1
> -=E7=BB=93=E6=9E=84=EF=BC=8C=E4=BD=86=E8=BF=99=E5=B0=86=E9=9C=80=E8=A6=81=
=E7=9B=B8=E5=BD=93=E5=A4=A7=E7=9A=84=E6=94=B9=E5=8F=98=E3=80=82=E5=8D=B3=E4=
=BD=BF=E5=AE=83=E8=A2=AB=E9=87=8D=E5=86=99=EF=BC=8C=E7=8E=B0=E6=9C=89=E7=9A=
=84=E4=BA=A4=E6=8D=A2=E5=AD=90=E7=B3=BB=E7=BB=9F=E4=B9=9F=E4=BD=BF=E7=94=A8=
=E4=BA=86=E5=9D=97I/O=E5=B1=82=EF=BC=8C=E5=AE=83
> -=E5=81=87=E5=AE=9A=E4=BA=A4=E6=8D=A2=E8=AE=BE=E5=A4=87=E6=98=AF=E5=9B=BA=
=E5=AE=9A=E5=A4=A7=E5=B0=8F=E7=9A=84=EF=BC=8C=E5=85=B6=E4=B8=AD=E7=9A=84=E4=
=BB=BB=E4=BD=95=E9=A1=B5=E9=9D=A2=E9=83=BD=E6=98=AF=E5=8F=AF=E7=BA=BF=E6=80=
=A7=E5=AF=BB=E5=9D=80=E7=9A=84=E3=80=82Frontswap=E5=87=A0=E4=B9=8E=E6=B2=A1=
=E6=9C=89=E8=A7=A6
> -=E5=8F=8A=E7=8E=B0=E6=9C=89=E7=9A=84=E4=BA=A4=E6=8D=A2=E5=AD=90=E7=B3=BB=
=E7=BB=9F=EF=BC=8C=E8=80=8C=E6=98=AF=E5=9B=B4=E7=BB=95=E7=9D=80=E5=9D=97I/O=
=E5=AD=90=E7=B3=BB=E7=BB=9F=E7=9A=84=E9=99=90=E5=88=B6=EF=BC=8C=E6=8F=90=E4=
=BE=9B=E4=BA=86=E5=A4=A7=E9=87=8F=E7=9A=84=E7=81=B5=E6=B4=BB=E6=80=A7=E5=92=
=8C=E5=8A=A8=E6=80=81=E6=80=A7=E3=80=82
> -
> -=E4=BE=8B=E5=A6=82=EF=BC=8Cfrontswap backend=E5=AF=B9=E4=BB=BB=E4=BD=95=
=E4=BA=A4=E6=8D=A2=E9=A1=B5=E7=9A=84=E6=8E=A5=E5=8F=97=E6=98=AF=E5=AE=8C=E5=
=85=A8=E4=B8=8D=E5=8F=AF=E9=A2=84=E6=B5=8B=E7=9A=84=E3=80=82=E8=BF=99=E5=AF=
=B9frontswap backend
> -=E7=9A=84=E5=AE=9A=E4=B9=89=E8=87=B3=E5=85=B3=E9=87=8D=E8=A6=81=EF=BC=8C=
=E5=9B=A0=E4=B8=BA=E5=AE=83=E8=B5=8B=E4=BA=88=E4=BA=86backend=E5=AE=8C=E5=
=85=A8=E5=8A=A8=E6=80=81=E7=9A=84=E5=86=B3=E5=AE=9A=E6=9D=83=E3=80=82=E5=9C=
=A8zcache=E4=B8=AD=EF=BC=8C=E4=BA=BA=E4=BB=AC=E6=97=A0=E6=B3=95=E9=A2=84
> -=E5=85=88=E7=9F=A5=E9=81=93=E4=B8=80=E4=B8=AA=E9=A1=B5=E9=9D=A2=E7=9A=84=
=E5=8F=AF=E5=8E=8B=E7=BC=A9=E6=80=A7=E5=A6=82=E4=BD=95=E3=80=82=E5=8F=AF=E5=
=8E=8B=E7=BC=A9=E6=80=A7 =E2=80=9C=E5=B7=AE=E2=80=9D =E7=9A=84=E9=A1=B5=E9=
=9D=A2=E4=BC=9A=E8=A2=AB=E6=8B=92=E7=BB=9D=EF=BC=8C=E8=80=8C =E2=80=9C=E5=
=B7=AE=E2=80=9D =E6=9C=AC=E8=BA=AB=E4=B9=9F=E5=8F=AF
> -=E4=BB=A5=E6=A0=B9=E6=8D=AE=E5=BD=93=E5=89=8D=E7=9A=84=E5=86=85=E5=AD=98=
=E9=99=90=E5=88=B6=E5=8A=A8=E6=80=81=E5=9C=B0=E5=AE=9A=E4=B9=89=E3=80=82
> -
> -=E6=AD=A4=E5=A4=96=EF=BC=8Cfrontswap=E6=98=AF=E5=AE=8C=E5=85=A8=E5=90=8C=
=E6=AD=A5=E7=9A=84=EF=BC=8C=E8=80=8C=E7=9C=9F=E6=AD=A3=E7=9A=84=E4=BA=A4=E6=
=8D=A2=E8=AE=BE=E5=A4=87=EF=BC=8C=E6=A0=B9=E6=8D=AE=E5=AE=9A=E4=B9=89=EF=BC=
=8C=E6=98=AF=E5=BC=82=E6=AD=A5=E7=9A=84=EF=BC=8C=E5=B9=B6=E4=B8=94=E4=BD=BF=
=E7=94=A8
> -=E5=9D=97I/O=E3=80=82=E5=9D=97I/O=E5=B1=82=E4=B8=8D=E4=BB=85=E6=98=AF=E4=
=B8=8D=E5=BF=85=E8=A6=81=E7=9A=84=EF=BC=8C=E8=80=8C=E4=B8=94=E5=8F=AF=E8=83=
=BD=E8=BF=9B=E8=A1=8C =E2=80=9C=E4=BC=98=E5=8C=96=E2=80=9D=EF=BC=8C=E8=BF=
=99=E5=AF=B9=E9=9D=A2=E5=90=91RAM=E7=9A=84=E8=AE=BE=E5=A4=87=E6=9D=A5=E8=AF=
=B4=E6=98=AF
> -=E4=B8=8D=E5=90=88=E9=80=82=E7=9A=84=EF=BC=8C=E5=8C=85=E6=8B=AC=E5=B0=86=
=E4=B8=80=E4=BA=9B=E9=A1=B5=E9=9D=A2=E7=9A=84=E5=86=99=E5=85=A5=E5=BB=B6=E8=
=BF=9F=E7=9B=B8=E5=BD=93=E9=95=BF=E7=9A=84=E6=97=B6=E9=97=B4=E3=80=82=E5=90=
=8C=E6=AD=A5=E6=98=AF=E5=BF=85=E9=A1=BB=E7=9A=84=EF=BC=8C=E4=BB=A5=E7=A1=AE=
=E4=BF=9D=E5=90=8E=E7=AB=AF=E7=9A=84=E5=8A=A8
> -=E6=80=81=E6=80=A7=EF=BC=8C=E5=B9=B6=E9=81=BF=E5=85=8D=E6=A3=98=E6=89=8B=
=E7=9A=84=E7=AB=9E=E4=BA=89=E6=9D=A1=E4=BB=B6=EF=BC=8C=E8=BF=99=E5=B0=86=E4=
=B8=8D=E5=BF=85=E8=A6=81=E5=9C=B0=E5=A4=A7=E5=A4=A7=E5=A2=9E=E5=8A=A0fronts=
wap=E5=92=8C/=E6=88=96=E5=9D=97I/O=E5=AD=90=E7=B3=BB=E7=BB=9F=E7=9A=84
> -=E5=A4=8D=E6=9D=82=E6=80=A7=E3=80=82=E4=B9=9F=E5=B0=B1=E6=98=AF=E8=AF=B4=
=EF=BC=8C=E5=8F=AA=E6=9C=89=E6=9C=80=E5=88=9D=E7=9A=84 =E2=80=9Cstore=E2=80=
=9D =E5=92=8C =E2=80=9Cload=E2=80=9D =E6=93=8D=E4=BD=9C=E6=98=AF=E9=9C=80=
=E8=A6=81=E5=90=8C=E6=AD=A5=E7=9A=84=E3=80=82=E4=B8=80=E4=B8=AA=E7=8B=AC=E7=
=AB=8B
> -=E7=9A=84=E5=BC=82=E6=AD=A5=E7=BA=BF=E7=A8=8B=E5=8F=AF=E4=BB=A5=E8=87=AA=
=E7=94=B1=E5=9C=B0=E6=93=8D=E4=BD=9C=E7=94=B1frontswap=E5=AD=98=E5=82=A8=E7=
=9A=84=E9=A1=B5=E9=9D=A2=E3=80=82=E4=BE=8B=E5=A6=82=EF=BC=8CRAMster=E4=B8=
=AD=E7=9A=84 =E2=80=9Cremotification=E2=80=9D
> -=E7=BA=BF=E7=A8=8B=E4=BD=BF=E7=94=A8=E6=A0=87=E5=87=86=E7=9A=84=E5=BC=82=
=E6=AD=A5=E5=86=85=E6=A0=B8=E5=A5=97=E6=8E=A5=E5=AD=97=EF=BC=8C=E5=B0=86=E5=
=8E=8B=E7=BC=A9=E7=9A=84frontswap=E9=A1=B5=E9=9D=A2=E7=A7=BB=E5=8A=A8=E5=88=
=B0=E8=BF=9C=E7=A8=8B=E6=9C=BA=E5=99=A8=E3=80=82=E5=90=8C=E6=A0=B7=EF=BC=8C
> -KVM=E7=9A=84=E5=AE=A2=E6=88=B7=E6=96=B9=E5=AE=9E=E7=8E=B0=E5=8F=AF=E4=BB=
=A5=E8=BF=9B=E8=A1=8C=E5=AE=A2=E6=88=B7=E5=86=85=E5=8E=8B=E7=BC=A9=EF=BC=8C=
=E5=B9=B6=E4=BD=BF=E7=94=A8 =E2=80=9Cbatched=E2=80=9D hypercalls=E3=80=82
> -
> -=E5=9C=A8=E8=99=9A=E6=8B=9F=E5=8C=96=E7=8E=AF=E5=A2=83=E4=B8=AD=EF=BC=8C=
=E5=8A=A8=E6=80=81=E6=80=A7=E5=85=81=E8=AE=B8=E7=AE=A1=E7=90=86=E7=A8=8B=E5=
=BA=8F=EF=BC=88=E6=88=96=E4=B8=BB=E6=9C=BA=E6=93=8D=E4=BD=9C=E7=B3=BB=E7=BB=
=9F=EF=BC=89=E5=81=9A=E2=80=9Cintelligent overcommit=E2=80=9D=E3=80=82
> -=E4=BE=8B=E5=A6=82=EF=BC=8C=E5=AE=83=E5=8F=AF=E4=BB=A5=E9=80=89=E6=8B=A9=
=E5=8F=AA=E6=8E=A5=E5=8F=97=E9=A1=B5=E9=9D=A2=EF=BC=8C=E7=9B=B4=E5=88=B0=E4=
=B8=BB=E6=9C=BA=E4=BA=A4=E6=8D=A2=E5=8F=AF=E8=83=BD=E5=8D=B3=E5=B0=86=E5=8F=
=91=E7=94=9F=EF=BC=8C=E7=84=B6=E5=90=8E=E5=BC=BA=E8=BF=AB=E5=AE=A2=E6=88=B7=
=E6=9C=BA=E5=81=9A=E4=BB=96=E4=BB=AC
> -=E8=87=AA=E5=B7=B1=E7=9A=84=E4=BA=A4=E6=8D=A2=E3=80=82
> -
> -transcendent memory=E8=A7=84=E6=A0=BC=E7=9A=84frontswap=E6=9C=89=E4=B8=
=80=E4=B8=AA=E5=9D=8F=E5=A4=84=E3=80=82=E5=9B=A0=E4=B8=BA=E4=BB=BB=E4=BD=95=
 =E2=80=9Cstore=E2=80=9D =E9=83=BD=E5=8F=AF
> -=E8=83=BD=E5=A4=B1=E8=B4=A5=EF=BC=8C=E6=89=80=E4=BB=A5=E5=BF=85=E9=A1=BB=
=E5=9C=A8=E4=B8=80=E4=B8=AA=E7=9C=9F=E6=AD=A3=E7=9A=84=E4=BA=A4=E6=8D=A2=E8=
=AE=BE=E5=A4=87=E4=B8=8A=E6=9C=89=E4=B8=80=E4=B8=AA=E7=9C=9F=E6=AD=A3=E7=9A=
=84=E6=8F=92=E6=A7=BD=E6=9D=A5=E4=BA=A4=E6=8D=A2=E9=A1=B5=E9=9D=A2=E3=80=82=
=E5=9B=A0=E6=AD=A4=EF=BC=8C
> -frontswap=E5=BF=85=E9=A1=BB=E4=BD=9C=E4=B8=BA=E6=AF=8F=E4=B8=AA=E4=BA=A4=
=E6=8D=A2=E8=AE=BE=E5=A4=87=E7=9A=84 =E2=80=9C=E5=BD=B1=E5=AD=90=E2=80=9D =
=E6=9D=A5=E5=AE=9E=E7=8E=B0=EF=BC=8C=E5=AE=83=E6=9C=89=E5=8F=AF=E8=83=BD=E5=
=AE=B9=E7=BA=B3=E4=BA=A4=E6=8D=A2=E8=AE=BE=E5=A4=87=E5=8F=AF=E8=83=BD
> -=E5=AE=B9=E7=BA=B3=E7=9A=84=E6=AF=8F=E4=B8=80=E4=B8=AA=E9=A1=B5=E9=9D=A2=
=EF=BC=8C=E4=B9=9F=E6=9C=89=E5=8F=AF=E8=83=BD=E6=A0=B9=E6=9C=AC=E4=B8=8D=E5=
=AE=B9=E7=BA=B3=E4=BB=BB=E4=BD=95=E9=A1=B5=E9=9D=A2=E3=80=82=E8=BF=99=E6=84=
=8F=E5=91=B3=E7=9D=80frontswap=E4=B8=8D=E8=83=BD=E5=8C=85=E5=90=AB=E6=AF=94
> -swap=E8=AE=BE=E5=A4=87=E6=80=BB=E6=95=B0=E6=9B=B4=E5=A4=9A=E7=9A=84=E9=
=A1=B5=E9=9D=A2=E3=80=82=E4=BE=8B=E5=A6=82=EF=BC=8C=E5=A6=82=E6=9E=9C=E5=9C=
=A8=E6=9F=90=E4=BA=9B=E5=AE=89=E8=A3=85=E4=B8=8A=E6=B2=A1=E6=9C=89=E9=85=8D=
=E7=BD=AE=E4=BA=A4=E6=8D=A2=E8=AE=BE=E5=A4=87=EF=BC=8Cfrontswap
> -=E5=B0=B1=E6=B2=A1=E6=9C=89=E7=94=A8=E3=80=82=E6=97=A0=E4=BA=A4=E6=8D=A2=
=E8=AE=BE=E5=A4=87=E7=9A=84=E4=BE=BF=E6=90=BA=E5=BC=8F=E8=AE=BE=E5=A4=87=E4=
=BB=8D=E7=84=B6=E5=8F=AF=E4=BB=A5=E4=BD=BF=E7=94=A8frontswap=EF=BC=8C=E4=BD=
=86=E6=98=AF=E8=BF=99=E7=A7=8D=E8=AE=BE=E5=A4=87=E7=9A=84
> -backend=E5=BF=85=E9=A1=BB=E9=85=8D=E7=BD=AE=E6=9F=90=E7=A7=8D =E2=80=9Cg=
host=E2=80=9D =E4=BA=A4=E6=8D=A2=E8=AE=BE=E5=A4=87=EF=BC=8C=E5=B9=B6=E7=A1=
=AE=E4=BF=9D=E5=AE=83=E6=B0=B8=E8=BF=9C=E4=B8=8D=E4=BC=9A=E8=A2=AB=E4=BD=BF=
=E7=94=A8=E3=80=82
> -
> -
> -* =E4=B8=BA=E4=BB=80=E4=B9=88=E4=BC=9A=E6=9C=89=E8=BF=99=E7=A7=8D=E5=85=
=B3=E4=BA=8E =E2=80=9C=E9=87=8D=E5=A4=8D=E5=AD=98=E5=82=A8=E2=80=9D =E7=9A=
=84=E5=A5=87=E6=80=AA=E5=AE=9A=E4=B9=89=EF=BC=9F=E5=A6=82=E6=9E=9C=E4=B8=80=
=E4=B8=AA=E9=A1=B5=E9=9D=A2=E4=BB=A5=E5=89=8D=E8=A2=AB=E6=88=90=E5=8A=9F=E5=
=9C=B0=E5=AD=98=E5=82=A8=E8=BF=87=EF=BC=8C
> -  =E9=9A=BE=E9=81=93=E5=AE=83=E4=B8=8D=E8=83=BD=E6=80=BB=E6=98=AF=E8=A2=
=AB=E6=88=90=E5=8A=9F=E5=9C=B0=E8=A6=86=E7=9B=96=E5=90=97=EF=BC=9F
> -
> -=E5=87=A0=E4=B9=8E=E6=80=BB=E6=98=AF=E5=8F=AF=E4=BB=A5=E7=9A=84=EF=BC=8C=
=E4=B8=8D=EF=BC=8C=E6=9C=89=E6=97=B6=E4=B8=8D=E8=83=BD=E3=80=82=E8=80=83=E8=
=99=91=E4=B8=80=E4=B8=AA=E4=BE=8B=E5=AD=90=EF=BC=8C=E6=95=B0=E6=8D=AE=E8=A2=
=AB=E5=8E=8B=E7=BC=A9=E4=BA=86=EF=BC=8C=E5=8E=9F=E6=9D=A5=E7=9A=844K=E9=A1=
=B5=E9=9D=A2=E8=A2=AB=E5=8E=8B
> -=E7=BC=A9=E5=88=B0=E4=BA=861K=E3=80=82=E7=8E=B0=E5=9C=A8=EF=BC=8C=E6=9C=
=89=E4=BA=BA=E8=AF=95=E5=9B=BE=E7=94=A8=E4=B8=8D=E5=8F=AF=E5=8E=8B=E7=BC=A9=
=E7=9A=84=E6=95=B0=E6=8D=AE=E8=A6=86=E7=9B=96=E8=AF=A5=E9=A1=B5=EF=BC=8C=E5=
=9B=A0=E6=AD=A4=E4=BC=9A=E5=8D=A0=E7=94=A8=E6=95=B4=E4=B8=AA4K=E3=80=82=E4=
=BD=86=E6=98=AF
> -backend=E6=B2=A1=E6=9C=89=E6=9B=B4=E5=A4=9A=E7=9A=84=E7=A9=BA=E9=97=B4=
=E4=BA=86=E3=80=82=E5=9C=A8=E8=BF=99=E7=A7=8D=E6=83=85=E5=86=B5=E4=B8=8B=EF=
=BC=8C=E8=BF=99=E4=B8=AA=E5=AD=98=E5=82=A8=E5=BF=85=E9=A1=BB=E8=A2=AB=E6=8B=
=92=E7=BB=9D=E3=80=82=E6=AF=8F=E5=BD=93frontswap
> -=E6=8B=92=E7=BB=9D=E4=B8=80=E4=B8=AA=E4=BC=9A=E8=A6=86=E7=9B=96=E7=9A=84=
=E5=AD=98=E5=82=A8=E6=97=B6=EF=BC=8C=E5=AE=83=E4=B9=9F=E5=BF=85=E9=A1=BB=E4=
=BD=BF=E6=97=A7=E7=9A=84=E6=95=B0=E6=8D=AE=E4=BD=9C=E5=BA=9F=EF=BC=8C=E5=B9=
=B6=E7=A1=AE=E4=BF=9D=E5=AE=83=E4=B8=8D=E5=86=8D=E8=A2=AB=E8=AE=BF=E9=97=AE=
=E3=80=82=E5=9B=A0=E4=B8=BA=E4=BA=A4
> -=E6=8D=A2=E5=AD=90=E7=B3=BB=E7=BB=9F=E4=BC=9A=E6=8A=8A=E6=96=B0=E7=9A=84=
=E6=95=B0=E6=8D=AE=E5=86=99=E5=88=B0=E8=AF=BB=E4=BA=A4=E6=8D=A2=E8=AE=BE=E5=
=A4=87=E4=B8=8A=EF=BC=8C=E8=BF=99=E6=98=AF=E7=A1=AE=E4=BF=9D=E4=B8=80=E8=87=
=B4=E6=80=A7=E7=9A=84=E6=AD=A3=E7=A1=AE=E5=81=9A=E6=B3=95=E3=80=82
> -
> -* =E4=B8=BA=E4=BB=80=E4=B9=88frontswap=E8=A1=A5=E4=B8=81=E4=BC=9A=E5=88=
=9B=E5=BB=BA=E6=96=B0=E7=9A=84=E5=A4=B4=E6=96=87=E4=BB=B6swapfile.h=EF=BC=
=9F
> -
> -frontswap=E4=BB=A3=E7=A0=81=E4=BE=9D=E8=B5=96=E4=BA=8E=E4=B8=80=E4=BA=9B=
swap=E5=AD=90=E7=B3=BB=E7=BB=9F=E5=86=85=E9=83=A8=E7=9A=84=E6=95=B0=E6=8D=
=AE=E7=BB=93=E6=9E=84=EF=BC=8C=E8=BF=99=E4=BA=9B=E6=95=B0=E6=8D=AE=E7=BB=93=
=E6=9E=84=E5=A4=9A=E5=B9=B4=E6=9D=A5=E4=B8=80=E7=9B=B4
> -=E5=9C=A8=E9=9D=99=E6=80=81=E5=92=8C=E5=85=A8=E5=B1=80=E4=B9=8B=E9=97=B4=
=E6=9D=A5=E5=9B=9E=E7=A7=BB=E5=8A=A8=E3=80=82=E8=BF=99=E4=BC=BC=E4=B9=8E=E6=
=98=AF=E4=B8=80=E4=B8=AA=E5=90=88=E7=90=86=E7=9A=84=E5=A6=A5=E5=8D=8F=EF=BC=
=9A=E5=B0=86=E5=AE=83=E4=BB=AC=E5=AE=9A=E4=B9=89=E4=B8=BA=E5=85=A8=E5=B1=80=
=EF=BC=8C=E4=BD=86=E5=9C=A8=E4=B8=80
> -=E4=B8=AA=E6=96=B0=E7=9A=84=E5=8C=85=E5=90=AB=E6=96=87=E4=BB=B6=E4=B8=AD=
=E5=A3=B0=E6=98=8E=E5=AE=83=E4=BB=AC=EF=BC=8C=E8=AF=A5=E6=96=87=E4=BB=B6=E4=
=B8=8D=E8=A2=AB=E5=8C=85=E5=90=ABswap.h=E7=9A=84=E5=A4=A7=E9=87=8F=E6=BA=90=
=E6=96=87=E4=BB=B6=E6=89=80=E5=8C=85=E5=90=AB=E3=80=82
> -
> -Dan Magenheimer=EF=BC=8C=E6=9C=80=E5=90=8E=E6=9B=B4=E6=96=B0=E4=BA=8E201=
2=E5=B9=B44=E6=9C=889=E6=97=A5
> diff --git a/Documentation/translations/zh_CN/mm/index.rst b/Documentatio=
n/translations/zh_CN/mm/index.rst
> index 2f53e37b8049..b950dd118be7 100644
> --- a/Documentation/translations/zh_CN/mm/index.rst
> +++ b/Documentation/translations/zh_CN/mm/index.rst
> @@ -42,7 +42,6 @@ =E7=BB=93=E6=9E=84=E5=8C=96=E7=9A=84=E6=96=87=E6=A1=A3=
=E4=B8=AD=EF=BC=8C=E5=A6=82=E6=9E=9C=E5=AE=83=E5=B7=B2=E7=BB=8F=E5=AE=8C=E6=
=88=90=E4=BA=86=E5=AE=83=E7=9A=84=E4=BD=BF=E5=91=BD=EF=BC=8C=E5=8F=AF=E4=BB=
=A5=E5=88=A0=E9=99=A4=E3=80=82
>     damon/index
>     free_page_reporting
>     ksm
> -   frontswap
>     hmm
>     hwpoison
>     hugetlbfs_reserv
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dfbb271f1667..f2bb2f9eaccf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8394,13 +8394,6 @@ F:       Documentation/power/freezing-of-tasks.rst
>  F:     include/linux/freezer.h
>  F:     kernel/freezer.c
>
> -FRONTSWAP API
> -M:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> -L:     linux-kernel@vger.kernel.org
> -S:     Maintained
> -F:     include/linux/frontswap.h
> -F:     mm/frontswap.c
> -
>  FS-CACHE: LOCAL CACHING FOR NETWORK FILESYSTEMS
>  M:     David Howells <dhowells@redhat.com>
>  L:     linux-cachefs@redhat.com (moderated for non-subscribers)
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 8dca4d6d96c7..74e3c3815696 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -17,6 +17,7 @@
>  #ifdef CONFIG_CMA
>  #include <linux/cma.h>
>  #endif
> +#include <linux/zswap.h>
>  #include <asm/page.h>
>  #include "internal.h"
>
> diff --git a/include/linux/frontswap.h b/include/linux/frontswap.h
> deleted file mode 100644
> index eaa0ac5f9003..000000000000
> --- a/include/linux/frontswap.h
> +++ /dev/null
> @@ -1,91 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LINUX_FRONTSWAP_H
> -#define _LINUX_FRONTSWAP_H
> -
> -#include <linux/swap.h>
> -#include <linux/mm.h>
> -#include <linux/bitops.h>
> -#include <linux/jump_label.h>
> -
> -struct frontswap_ops {
> -       void (*init)(unsigned); /* this swap type was just swapon'ed */
> -       int (*store)(unsigned, pgoff_t, struct page *); /* store a page *=
/
> -       int (*load)(unsigned, pgoff_t, struct page *, bool *); /* load a =
page */
> -       void (*invalidate_page)(unsigned, pgoff_t); /* page no longer nee=
ded */
> -       void (*invalidate_area)(unsigned); /* swap type just swapoff'ed *=
/
> -};
> -
> -int frontswap_register_ops(const struct frontswap_ops *ops);
> -
> -extern void frontswap_init(unsigned type, unsigned long *map);
> -extern int __frontswap_store(struct page *page);
> -extern int __frontswap_load(struct page *page);
> -extern void __frontswap_invalidate_page(unsigned, pgoff_t);
> -extern void __frontswap_invalidate_area(unsigned);
> -
> -#ifdef CONFIG_FRONTSWAP
> -extern struct static_key_false frontswap_enabled_key;
> -
> -static inline bool frontswap_enabled(void)
> -{
> -       return static_branch_unlikely(&frontswap_enabled_key);
> -}
> -
> -static inline void frontswap_map_set(struct swap_info_struct *p,
> -                                    unsigned long *map)
> -{
> -       p->frontswap_map =3D map;
> -}
> -
> -static inline unsigned long *frontswap_map_get(struct swap_info_struct *=
p)
> -{
> -       return p->frontswap_map;
> -}
> -#else
> -/* all inline routines become no-ops and all externs are ignored */
> -
> -static inline bool frontswap_enabled(void)
> -{
> -       return false;
> -}
> -
> -static inline void frontswap_map_set(struct swap_info_struct *p,
> -                                    unsigned long *map)
> -{
> -}
> -
> -static inline unsigned long *frontswap_map_get(struct swap_info_struct *=
p)
> -{
> -       return NULL;
> -}
> -#endif
> -
> -static inline int frontswap_store(struct page *page)
> -{
> -       if (frontswap_enabled())
> -               return __frontswap_store(page);
> -
> -       return -1;
> -}
> -
> -static inline int frontswap_load(struct page *page)
> -{
> -       if (frontswap_enabled())
> -               return __frontswap_load(page);
> -
> -       return -1;
> -}
> -
> -static inline void frontswap_invalidate_page(unsigned type, pgoff_t offs=
et)
> -{
> -       if (frontswap_enabled())
> -               __frontswap_invalidate_page(type, offset);
> -}
> -
> -static inline void frontswap_invalidate_area(unsigned type)
> -{
> -       if (frontswap_enabled())
> -               __frontswap_invalidate_area(type);
> -}
> -
> -#endif /* _LINUX_FRONTSWAP_H */
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 456546443f1f..bb5adc604144 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -302,10 +302,6 @@ struct swap_info_struct {
>         struct file *swap_file;         /* seldom referenced */
>         unsigned int old_block_size;    /* seldom referenced */
>         struct completion comp;         /* seldom referenced */
> -#ifdef CONFIG_FRONTSWAP
> -       unsigned long *frontswap_map;   /* frontswap in-use, one bit per =
page */
> -       atomic_t frontswap_pages;       /* frontswap pages in-use counter=
 */
> -#endif
>         spinlock_t lock;                /*
>                                          * protect map scan related field=
s like
>                                          * swap_map, lowest_bit, highest_=
bit,
> @@ -630,11 +626,6 @@ static inline int mem_cgroup_swappiness(struct mem_c=
group *mem)
>  }
>  #endif
>
> -#ifdef CONFIG_ZSWAP
> -extern u64 zswap_pool_total_size;
> -extern atomic_t zswap_stored_pages;
> -#endif
> -
>  #if defined(CONFIG_SWAP) && defined(CONFIG_MEMCG) && defined(CONFIG_BLK_=
CGROUP)
>  void __folio_throttle_swaprate(struct folio *folio, gfp_t gfp);
>  static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gf=
p)
> diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
> index 7ed529a77c5b..99e3ed469e88 100644
> --- a/include/linux/swapfile.h
> +++ b/include/linux/swapfile.h
> @@ -2,11 +2,6 @@
>  #ifndef _LINUX_SWAPFILE_H
>  #define _LINUX_SWAPFILE_H
>
> -/*
> - * these were static in swapfile.c but frontswap.c needs them and we don=
't
> - * want to expose them to the dozens of source files that include swap.h
> - */
> -extern struct swap_info_struct *swap_info[];
>  extern unsigned long generic_max_swapfile_size(void);
>  unsigned long arch_max_swapfile_size(void);
>
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> new file mode 100644
> index 000000000000..850c377d9b6d
> --- /dev/null
> +++ b/include/linux/zswap.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ZSWAP_H
> +#define _LINUX_ZSWAP_H
> +
> +#include <linux/types.h>
> +#include <linux/mm_types.h>
> +
> +extern u64 zswap_pool_total_size;
> +extern atomic_t zswap_stored_pages;
> +
> +#ifdef CONFIG_ZSWAP
> +
> +bool zswap_store(struct page *page);
> +bool zswap_load(struct page *page);
> +void zswap_invalidate(int type, pgoff_t offset);
> +void zswap_swapon(int type);
> +void zswap_swapoff(int type);
> +
> +#else
> +
> +static inline bool zswap_store(struct page *page)
> +{
> +       return false;
> +}
> +
> +static inline bool zswap_load(struct page *page)
> +{
> +       return false;
> +}
> +
> +static inline void zswap_invalidate(int type, pgoff_t offset) {}
> +static inline void zswap_swapon(int type) {}
> +static inline void zswap_swapoff(int type) {}
> +
> +#endif
> +
> +#endif /* _LINUX_ZSWAP_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 09130434e30d..4ebc095590f6 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -25,7 +25,6 @@ menuconfig SWAP
>  config ZSWAP
>         bool "Compressed cache for swap pages"
>         depends on SWAP
> -       select FRONTSWAP
>         select CRYPTO
>         select ZPOOL
>         help
> @@ -870,9 +869,6 @@ config USE_PERCPU_NUMA_NODE_ID
>  config HAVE_SETUP_PER_CPU_AREA
>         bool
>
> -config FRONTSWAP
> -       bool
> -
>  config CMA
>         bool "Contiguous Memory Allocator"
>         depends on MMU
> diff --git a/mm/Makefile b/mm/Makefile
> index 678530a07326..e6d9a1d5e84d 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -72,7 +72,6 @@ ifdef CONFIG_MMU
>  endif
>
>  obj-$(CONFIG_SWAP)     +=3D page_io.o swap_state.o swapfile.o swap_slots=
.o
> -obj-$(CONFIG_FRONTSWAP)        +=3D frontswap.o
>  obj-$(CONFIG_ZSWAP)    +=3D zswap.o
>  obj-$(CONFIG_HAS_DMA)  +=3D dmapool.o
>  obj-$(CONFIG_HUGETLBFS)        +=3D hugetlb.o
> diff --git a/mm/frontswap.c b/mm/frontswap.c
> deleted file mode 100644
> index 2fb5df3384b8..000000000000
> --- a/mm/frontswap.c
> +++ /dev/null
> @@ -1,283 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Frontswap frontend
> - *
> - * This code provides the generic "frontend" layer to call a matching
> - * "backend" driver implementation of frontswap.  See
> - * Documentation/mm/frontswap.rst for more information.
> - *
> - * Copyright (C) 2009-2012 Oracle Corp.  All rights reserved.
> - * Author: Dan Magenheimer
> - */
> -
> -#include <linux/mman.h>
> -#include <linux/swap.h>
> -#include <linux/swapops.h>
> -#include <linux/security.h>
> -#include <linux/module.h>
> -#include <linux/debugfs.h>
> -#include <linux/frontswap.h>
> -#include <linux/swapfile.h>
> -
> -DEFINE_STATIC_KEY_FALSE(frontswap_enabled_key);
> -
> -/*
> - * frontswap_ops are added by frontswap_register_ops, and provide the
> - * frontswap "backend" implementation functions.  Multiple implementatio=
ns
> - * may be registered, but implementations can never deregister.  This
> - * is a simple singly-linked list of all registered implementations.
> - */
> -static const struct frontswap_ops *frontswap_ops __read_mostly;
> -
> -#ifdef CONFIG_DEBUG_FS
> -/*
> - * Counters available via /sys/kernel/debug/frontswap (if debugfs is
> - * properly configured).  These are for information only so are not prot=
ected
> - * against increment races.
> - */
> -static u64 frontswap_loads;
> -static u64 frontswap_succ_stores;
> -static u64 frontswap_failed_stores;
> -static u64 frontswap_invalidates;
> -
> -static inline void inc_frontswap_loads(void)
> -{
> -       data_race(frontswap_loads++);
> -}
> -static inline void inc_frontswap_succ_stores(void)
> -{
> -       data_race(frontswap_succ_stores++);
> -}
> -static inline void inc_frontswap_failed_stores(void)
> -{
> -       data_race(frontswap_failed_stores++);
> -}
> -static inline void inc_frontswap_invalidates(void)
> -{
> -       data_race(frontswap_invalidates++);
> -}
> -#else
> -static inline void inc_frontswap_loads(void) { }
> -static inline void inc_frontswap_succ_stores(void) { }
> -static inline void inc_frontswap_failed_stores(void) { }
> -static inline void inc_frontswap_invalidates(void) { }
> -#endif
> -
> -/*
> - * Due to the asynchronous nature of the backends loading potentially
> - * _after_ the swap system has been activated, we have chokepoints
> - * on all frontswap functions to not call the backend until the backend
> - * has registered.
> - *
> - * This would not guards us against the user deciding to call swapoff ri=
ght as
> - * we are calling the backend to initialize (so swapon is in action).
> - * Fortunately for us, the swapon_mutex has been taken by the callee so =
we are
> - * OK. The other scenario where calls to frontswap_store (called via
> - * swap_writepage) is racing with frontswap_invalidate_area (called via
> - * swapoff) is again guarded by the swap subsystem.
> - *
> - * While no backend is registered all calls to frontswap_[store|load|
> - * invalidate_area|invalidate_page] are ignored or fail.
> - *
> - * The time between the backend being registered and the swap file syste=
m
> - * calling the backend (via the frontswap_* functions) is indeterminate =
as
> - * frontswap_ops is not atomic_t (or a value guarded by a spinlock).
> - * That is OK as we are comfortable missing some of these calls to the n=
ewly
> - * registered backend.
> - *
> - * Obviously the opposite (unloading the backend) must be done after all
> - * the frontswap_[store|load|invalidate_area|invalidate_page] start
> - * ignoring or failing the requests.  However, there is currently no way
> - * to unload a backend once it is registered.
> - */
> -
> -/*
> - * Register operations for frontswap
> - */
> -int frontswap_register_ops(const struct frontswap_ops *ops)
> -{
> -       if (frontswap_ops)
> -               return -EINVAL;
> -
> -       frontswap_ops =3D ops;
> -       static_branch_inc(&frontswap_enabled_key);
> -       return 0;
> -}
> -
> -/*
> - * Called when a swap device is swapon'd.
> - */
> -void frontswap_init(unsigned type, unsigned long *map)
> -{
> -       struct swap_info_struct *sis =3D swap_info[type];
> -
> -       VM_BUG_ON(sis =3D=3D NULL);
> -
> -       /*
> -        * p->frontswap is a bitmap that we MUST have to figure out which=
 page
> -        * has gone in frontswap. Without it there is no point of continu=
ing.
> -        */
> -       if (WARN_ON(!map))
> -               return;
> -       /*
> -        * Irregardless of whether the frontswap backend has been loaded
> -        * before this function or it will be later, we _MUST_ have the
> -        * p->frontswap set to something valid to work properly.
> -        */
> -       frontswap_map_set(sis, map);
> -
> -       if (!frontswap_enabled())
> -               return;
> -       frontswap_ops->init(type);
> -}
> -
> -static bool __frontswap_test(struct swap_info_struct *sis,
> -                               pgoff_t offset)
> -{
> -       if (sis->frontswap_map)
> -               return test_bit(offset, sis->frontswap_map);
> -       return false;
> -}
> -
> -static inline void __frontswap_set(struct swap_info_struct *sis,
> -                                  pgoff_t offset)
> -{
> -       set_bit(offset, sis->frontswap_map);
> -       atomic_inc(&sis->frontswap_pages);
> -}
> -
> -static inline void __frontswap_clear(struct swap_info_struct *sis,
> -                                    pgoff_t offset)
> -{
> -       clear_bit(offset, sis->frontswap_map);
> -       atomic_dec(&sis->frontswap_pages);
> -}
> -
> -/*
> - * "Store" data from a page to frontswap and associate it with the page'=
s
> - * swaptype and offset.  Page must be locked and in the swap cache.
> - * If frontswap already contains a page with matching swaptype and
> - * offset, the frontswap implementation may either overwrite the data an=
d
> - * return success or invalidate the page from frontswap and return failu=
re.
> - */
> -int __frontswap_store(struct page *page)
> -{
> -       int ret =3D -1;
> -       swp_entry_t entry =3D { .val =3D page_private(page), };
> -       int type =3D swp_type(entry);
> -       struct swap_info_struct *sis =3D swap_info[type];
> -       pgoff_t offset =3D swp_offset(entry);
> -
> -       VM_BUG_ON(!frontswap_ops);
> -       VM_BUG_ON(!PageLocked(page));
> -       VM_BUG_ON(sis =3D=3D NULL);
> -
> -       /*
> -        * If a dup, we must remove the old page first; we can't leave th=
e
> -        * old page no matter if the store of the new page succeeds or fa=
ils,
> -        * and we can't rely on the new page replacing the old page as we=
 may
> -        * not store to the same implementation that contains the old pag=
e.
> -        */
> -       if (__frontswap_test(sis, offset)) {
> -               __frontswap_clear(sis, offset);
> -               frontswap_ops->invalidate_page(type, offset);
> -       }
> -
> -       ret =3D frontswap_ops->store(type, offset, page);
> -       if (ret =3D=3D 0) {
> -               __frontswap_set(sis, offset);
> -               inc_frontswap_succ_stores();
> -       } else {
> -               inc_frontswap_failed_stores();
> -       }
> -
> -       return ret;
> -}
> -
> -/*
> - * "Get" data from frontswap associated with swaptype and offset that we=
re
> - * specified when the data was put to frontswap and use it to fill the
> - * specified page with data. Page must be locked and in the swap cache.
> - */
> -int __frontswap_load(struct page *page)
> -{
> -       int ret =3D -1;
> -       swp_entry_t entry =3D { .val =3D page_private(page), };
> -       int type =3D swp_type(entry);
> -       struct swap_info_struct *sis =3D swap_info[type];
> -       pgoff_t offset =3D swp_offset(entry);
> -       bool exclusive =3D false;
> -
> -       VM_BUG_ON(!frontswap_ops);
> -       VM_BUG_ON(!PageLocked(page));
> -       VM_BUG_ON(sis =3D=3D NULL);
> -
> -       if (!__frontswap_test(sis, offset))
> -               return -1;

With the removal of the above, it will be a bit slower to realize an
entry is not in zswap and read it from disk (bitmask test vs. rbtree
lookup). I guess in the swapin path (especially from disk), it would
not matter much in practice. Just a note (mostly to myself).

> -
> -       /* Try loading from each implementation, until one succeeds. */
> -       ret =3D frontswap_ops->load(type, offset, page, &exclusive);
> -       if (ret =3D=3D 0) {
> -               inc_frontswap_loads();
> -               if (exclusive) {
> -                       SetPageDirty(page);
> -                       __frontswap_clear(sis, offset);
> -               }
> -       }
> -       return ret;
> -}
> -
> -/*
> - * Invalidate any data from frontswap associated with the specified swap=
type
> - * and offset so that a subsequent "get" will fail.
> - */
> -void __frontswap_invalidate_page(unsigned type, pgoff_t offset)
> -{
> -       struct swap_info_struct *sis =3D swap_info[type];
> -
> -       VM_BUG_ON(!frontswap_ops);
> -       VM_BUG_ON(sis =3D=3D NULL);
> -
> -       if (!__frontswap_test(sis, offset))
> -               return;
> -
> -       frontswap_ops->invalidate_page(type, offset);
> -       __frontswap_clear(sis, offset);
> -       inc_frontswap_invalidates();
> -}
> -
> -/*
> - * Invalidate all data from frontswap associated with all offsets for th=
e
> - * specified swaptype.
> - */
> -void __frontswap_invalidate_area(unsigned type)
> -{
> -       struct swap_info_struct *sis =3D swap_info[type];
> -
> -       VM_BUG_ON(!frontswap_ops);
> -       VM_BUG_ON(sis =3D=3D NULL);
> -
> -       if (sis->frontswap_map =3D=3D NULL)
> -               return;
> -
> -       frontswap_ops->invalidate_area(type);
> -       atomic_set(&sis->frontswap_pages, 0);
> -       bitmap_zero(sis->frontswap_map, sis->max);
> -}
> -
> -static int __init init_frontswap(void)
> -{
> -#ifdef CONFIG_DEBUG_FS
> -       struct dentry *root =3D debugfs_create_dir("frontswap", NULL);
> -       if (root =3D=3D NULL)
> -               return -ENXIO;
> -       debugfs_create_u64("loads", 0444, root, &frontswap_loads);
> -       debugfs_create_u64("succ_stores", 0444, root, &frontswap_succ_sto=
res);
> -       debugfs_create_u64("failed_stores", 0444, root,
> -                          &frontswap_failed_stores);
> -       debugfs_create_u64("invalidates", 0444, root, &frontswap_invalida=
tes);
> -#endif
> -       return 0;
> -}
> -
> -module_init(init_frontswap);
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 684cd3c7b59b..32afc2a52982 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -19,12 +19,12 @@
>  #include <linux/bio.h>
>  #include <linux/swapops.h>
>  #include <linux/writeback.h>
> -#include <linux/frontswap.h>
>  #include <linux/blkdev.h>
>  #include <linux/psi.h>
>  #include <linux/uio.h>
>  #include <linux/sched/task.h>
>  #include <linux/delayacct.h>
> +#include <linux/zswap.h>
>  #include "swap.h"
>
>  static void __end_swap_bio_write(struct bio *bio)
> @@ -198,7 +198,7 @@ int swap_writepage(struct page *page, struct writebac=
k_control *wbc)
>                 folio_unlock(folio);
>                 return ret;
>         }
> -       if (frontswap_store(&folio->page) =3D=3D 0) {
> +       if (zswap_store(&folio->page)) {
>                 folio_start_writeback(folio);
>                 folio_unlock(folio);
>                 folio_end_writeback(folio);
> @@ -515,7 +515,7 @@ void swap_readpage(struct page *page, bool synchronou=
s, struct swap_iocb **plug)
>         }
>         delayacct_swapin_start();
>
> -       if (frontswap_load(page) =3D=3D 0) {
> +       if (zswap_load(page)) {
>                 SetPageUptodate(page);
>                 unlock_page(page);
>         } else if (data_race(sis->flags & SWP_FS_OPS)) {
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 8e6dde68b389..38cd4dc4b2e7 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -35,13 +35,13 @@
>  #include <linux/memcontrol.h>
>  #include <linux/poll.h>
>  #include <linux/oom.h>
> -#include <linux/frontswap.h>
>  #include <linux/swapfile.h>
>  #include <linux/export.h>
>  #include <linux/swap_slots.h>
>  #include <linux/sort.h>
>  #include <linux/completion.h>
>  #include <linux/suspend.h>
> +#include <linux/zswap.h>
>
>  #include <asm/tlbflush.h>
>  #include <linux/swapops.h>
> @@ -95,7 +95,7 @@ static PLIST_HEAD(swap_active_head);
>  static struct plist_head *swap_avail_heads;
>  static DEFINE_SPINLOCK(swap_avail_lock);
>
> -struct swap_info_struct *swap_info[MAX_SWAPFILES];
> +static struct swap_info_struct *swap_info[MAX_SWAPFILES];
>
>  static DEFINE_MUTEX(swapon_mutex);
>
> @@ -746,7 +746,7 @@ static void swap_range_free(struct swap_info_struct *=
si, unsigned long offset,
>                 swap_slot_free_notify =3D NULL;
>         while (offset <=3D end) {
>                 arch_swap_invalidate_page(si->type, offset);
> -               frontswap_invalidate_page(si->type, offset);
> +               zswap_invalidate(si->type, offset);
>                 if (swap_slot_free_notify)
>                         swap_slot_free_notify(si->bdev, offset);
>                 offset++;
> @@ -2335,11 +2335,10 @@ static void _enable_swap_info(struct swap_info_st=
ruct *p)
>
>  static void enable_swap_info(struct swap_info_struct *p, int prio,
>                                 unsigned char *swap_map,
> -                               struct swap_cluster_info *cluster_info,
> -                               unsigned long *frontswap_map)
> +                               struct swap_cluster_info *cluster_info)
>  {
> -       if (IS_ENABLED(CONFIG_FRONTSWAP))
> -               frontswap_init(p->type, frontswap_map);
> +       zswap_swapon(p->type);
> +
>         spin_lock(&swap_lock);
>         spin_lock(&p->lock);
>         setup_swap_info(p, prio, swap_map, cluster_info);
> @@ -2382,7 +2381,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, speci=
alfile)
>         struct swap_info_struct *p =3D NULL;
>         unsigned char *swap_map;
>         struct swap_cluster_info *cluster_info;
> -       unsigned long *frontswap_map;
>         struct file *swap_file, *victim;
>         struct address_space *mapping;
>         struct inode *inode;
> @@ -2507,12 +2505,10 @@ SYSCALL_DEFINE1(swapoff, const char __user *, spe=
cialfile)
>         p->swap_map =3D NULL;
>         cluster_info =3D p->cluster_info;
>         p->cluster_info =3D NULL;
> -       frontswap_map =3D frontswap_map_get(p);
>         spin_unlock(&p->lock);
>         spin_unlock(&swap_lock);
>         arch_swap_invalidate_area(p->type);
> -       frontswap_invalidate_area(p->type);
> -       frontswap_map_set(p, NULL);
> +       zswap_swapoff(p->type);
>         mutex_unlock(&swapon_mutex);
>         free_percpu(p->percpu_cluster);
>         p->percpu_cluster =3D NULL;
> @@ -2520,7 +2516,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, speci=
alfile)
>         p->cluster_next_cpu =3D NULL;
>         vfree(swap_map);
>         kvfree(cluster_info);
> -       kvfree(frontswap_map);
>         /* Destroy swap account information */
>         swap_cgroup_swapoff(p->type);
>         exit_swap_address_space(p->type);
> @@ -2987,7 +2982,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specia=
lfile, int, swap_flags)
>         unsigned long maxpages;
>         unsigned char *swap_map =3D NULL;
>         struct swap_cluster_info *cluster_info =3D NULL;
> -       unsigned long *frontswap_map =3D NULL;
>         struct page *page =3D NULL;
>         struct inode *inode =3D NULL;
>         bool inced_nr_rotate_swap =3D false;
> @@ -3127,11 +3121,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, speci=
alfile, int, swap_flags)
>                 error =3D nr_extents;
>                 goto bad_swap_unlock_inode;
>         }
> -       /* frontswap enabled? set up bit-per-page map for frontswap */
> -       if (IS_ENABLED(CONFIG_FRONTSWAP))
> -               frontswap_map =3D kvcalloc(BITS_TO_LONGS(maxpages),
> -                                        sizeof(long),
> -                                        GFP_KERNEL);
>
>         if ((swap_flags & SWAP_FLAG_DISCARD) &&
>             p->bdev && bdev_max_discard_sectors(p->bdev)) {
> @@ -3184,16 +3173,15 @@ SYSCALL_DEFINE2(swapon, const char __user *, spec=
ialfile, int, swap_flags)
>         if (swap_flags & SWAP_FLAG_PREFER)
>                 prio =3D
>                   (swap_flags & SWAP_FLAG_PRIO_MASK) >> SWAP_FLAG_PRIO_SH=
IFT;
> -       enable_swap_info(p, prio, swap_map, cluster_info, frontswap_map);
> +       enable_swap_info(p, prio, swap_map, cluster_info);
>
> -       pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%l=
luk %s%s%s%s%s\n",
> +       pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%l=
luk %s%s%s%s\n",
>                 p->pages<<(PAGE_SHIFT-10), name->name, p->prio,
>                 nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10),
>                 (p->flags & SWP_SOLIDSTATE) ? "SS" : "",
>                 (p->flags & SWP_DISCARDABLE) ? "D" : "",
>                 (p->flags & SWP_AREA_DISCARD) ? "s" : "",
> -               (p->flags & SWP_PAGE_DISCARD) ? "c" : "",
> -               (frontswap_map) ? "FS" : "");
> +               (p->flags & SWP_PAGE_DISCARD) ? "c" : "");
>
>         mutex_unlock(&swapon_mutex);
>         atomic_inc(&proc_poll_event);
> @@ -3223,7 +3211,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specia=
lfile, int, swap_flags)
>         spin_unlock(&swap_lock);
>         vfree(swap_map);
>         kvfree(cluster_info);
> -       kvfree(frontswap_map);
>         if (inced_nr_rotate_swap)
>                 atomic_dec(&nr_rotate_swap);
>         if (swap_file)
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 62195f72bf56..d58672f23d43 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -2,7 +2,7 @@
>  /*
>   * zswap.c - zswap driver file
>   *
> - * zswap is a backend for frontswap that takes pages that are in the pro=
cess
> + * zswap is a cache that takes pages that are in the process
>   * of being swapped out and attempts to compress and store them in a
>   * RAM-based memory pool.  This can result in a significant I/O reductio=
n on
>   * the swap device and, in the case where decompressing from RAM is fast=
er
> @@ -20,7 +20,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
>  #include <linux/atomic.h>
> -#include <linux/frontswap.h>
>  #include <linux/rbtree.h>
>  #include <linux/swap.h>
>  #include <linux/crypto.h>
> @@ -28,7 +27,7 @@
>  #include <linux/mempool.h>
>  #include <linux/zpool.h>
>  #include <crypto/acompress.h>
> -
> +#include <linux/zswap.h>
>  #include <linux/mm_types.h>
>  #include <linux/page-flags.h>
>  #include <linux/swapops.h>
> @@ -1061,7 +1060,7 @@ static int zswap_get_swap_cache_page(swp_entry_t en=
try,
>   *
>   * This can be thought of as a "resumed writeback" of the page
>   * to the swap device.  We are basically resuming the same swap
> - * writeback path that was intercepted with the frontswap_store()
> + * writeback path that was intercepted with the zswap_store()
>   * in the first place.  After the page has been decompressed into
>   * the swap cache, the compressed version stored by zswap can be
>   * freed.
> @@ -1201,36 +1200,33 @@ static void zswap_fill_page(void *ptr, unsigned l=
ong value)
>         memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
>  }
>
> -/*********************************
> -* frontswap hooks
> -**********************************/
> -/* attempts to compress and store an single page */
> -static int zswap_frontswap_store(unsigned type, pgoff_t offset,
> -                               struct page *page)
> +bool zswap_store(struct page *page)
>  {
> +       swp_entry_t swp =3D { .val =3D page_private(page), };
> +       int type =3D swp_type(swp);
> +       pgoff_t offset =3D swp_offset(swp);
>         struct zswap_tree *tree =3D zswap_trees[type];
>         struct zswap_entry *entry, *dupentry;
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
>         struct obj_cgroup *objcg =3D NULL;
>         struct zswap_pool *pool;
> -       int ret;
>         unsigned int dlen =3D PAGE_SIZE;
>         unsigned long handle, value;
>         char *buf;
>         u8 *src, *dst;
>         gfp_t gfp;
> +       int ret;
> +
> +       VM_WARN_ON_ONCE(!PageLocked(page));
> +       VM_WARN_ON_ONCE(!PageSwapCache(page));
>
>         /* THP isn't supported */
> -       if (PageTransHuge(page)) {
> -               ret =3D -EINVAL;
> -               goto reject;
> -       }
> +       if (PageTransHuge(page))
> +               return false;
>
> -       if (!zswap_enabled || !tree) {
> -               ret =3D -ENODEV;
> -               goto reject;
> -       }
> +       if (!zswap_enabled || !tree)
> +               return false;
>
>         /*
>          * XXX: zswap reclaim does not work with cgroups yet. Without a
> @@ -1238,10 +1234,8 @@ static int zswap_frontswap_store(unsigned type, pg=
off_t offset,
>          * local cgroup limits.
>          */
>         objcg =3D get_obj_cgroup_from_page(page);
> -       if (objcg && !obj_cgroup_may_zswap(objcg)) {
> -               ret =3D -ENOMEM;
> +       if (objcg && !obj_cgroup_may_zswap(objcg))
>                 goto reject;
> -       }
>
>         /* reclaim space if needed */
>         if (zswap_is_full()) {
> @@ -1251,10 +1245,9 @@ static int zswap_frontswap_store(unsigned type, pg=
off_t offset,
>         }
>
>         if (zswap_pool_reached_full) {
> -              if (!zswap_can_accept()) {
> -                       ret =3D -ENOMEM;
> +              if (!zswap_can_accept())
>                         goto shrink;
> -               } else
> +               else
>                         zswap_pool_reached_full =3D false;
>         }
>
> @@ -1262,7 +1255,6 @@ static int zswap_frontswap_store(unsigned type, pgo=
ff_t offset,
>         entry =3D zswap_entry_cache_alloc(GFP_KERNEL);
>         if (!entry) {
>                 zswap_reject_kmemcache_fail++;
> -               ret =3D -ENOMEM;
>                 goto reject;
>         }
>
> @@ -1279,17 +1271,13 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
>                 kunmap_atomic(src);
>         }
>
> -       if (!zswap_non_same_filled_pages_enabled) {
> -               ret =3D -EINVAL;
> +       if (!zswap_non_same_filled_pages_enabled)
>                 goto freepage;
> -       }
>
>         /* if entry is successfully added, it keeps the reference */
>         entry->pool =3D zswap_pool_current_get();
> -       if (!entry->pool) {
> -               ret =3D -EINVAL;
> +       if (!entry->pool)
>                 goto freepage;
> -       }
>
>         /* compress */
>         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> @@ -1309,19 +1297,17 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
>          * synchronous in fact.
>          * Theoretically, acomp supports users send multiple acomp reques=
ts in one
>          * acomp instance, then get those requests done simultaneously. b=
ut in this
> -        * case, frontswap actually does store and load page by page, the=
re is no
> +        * case, zswap actually does store and load page by page, there i=
s no
>          * existing method to send the second page before the first page =
is done
> -        * in one thread doing frontswap.
> +        * in one thread doing zwap.
>          * but in different threads running on different cpu, we have dif=
ferent
>          * acomp instance, so multiple threads can do (de)compression in =
parallel.
>          */
>         ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &a=
comp_ctx->wait);
>         dlen =3D acomp_ctx->req->dlen;
>
> -       if (ret) {
> -               ret =3D -EINVAL;
> +       if (ret)
>                 goto put_dstmem;
> -       }
>
>         /* store */
>         gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> @@ -1356,15 +1342,12 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
>
>         /* map */
>         spin_lock(&tree->lock);
> -       do {
> -               ret =3D zswap_rb_insert(&tree->rbroot, entry, &dupentry);
> -               if (ret =3D=3D -EEXIST) {
> -                       zswap_duplicate_entry++;
> -                       /* remove from rbtree */
> -                       zswap_rb_erase(&tree->rbroot, dupentry);
> -                       zswap_entry_put(tree, dupentry);
> -               }
> -       } while (ret =3D=3D -EEXIST);
> +       while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=3D -E=
EXIST) {
> +               zswap_duplicate_entry++;
> +               /* remove from rbtree */
> +               zswap_rb_erase(&tree->rbroot, dupentry);
> +               zswap_entry_put(tree, dupentry);

nit: it would be nice to replace the above two lines with
zswap_invalidate_entry(), which also keeps it clear that we maintain
the frontswap semantics of invalidating a duplicated entry.

> +       }
>         if (entry->length) {
>                 spin_lock(&entry->pool->lru_lock);
>                 list_add(&entry->lru, &entry->pool->lru);
> @@ -1377,7 +1360,7 @@ static int zswap_frontswap_store(unsigned type, pgo=
ff_t offset,
>         zswap_update_total_size();
>         count_vm_event(ZSWPOUT);
>
> -       return 0;
> +       return true;
>
>  put_dstmem:
>         mutex_unlock(acomp_ctx->mutex);
> @@ -1387,30 +1370,30 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
>  reject:
>         if (objcg)
>                 obj_cgroup_put(objcg);
> -       return ret;
> +       return false;
>
>  shrink:
>         pool =3D zswap_pool_last_get();
>         if (pool)
>                 queue_work(shrink_wq, &pool->shrink_work);
> -       ret =3D -ENOMEM;
>         goto reject;
>  }
>
> -/*
> - * returns 0 if the page was successfully decompressed
> - * return -1 on entry not found or error
> -*/
> -static int zswap_frontswap_load(unsigned type, pgoff_t offset,
> -                               struct page *page, bool *exclusive)
> +bool zswap_load(struct page *page)
>  {
> +       swp_entry_t swp =3D { .val =3D page_private(page), };
> +       int type =3D swp_type(swp);
> +       pgoff_t offset =3D swp_offset(swp);
>         struct zswap_tree *tree =3D zswap_trees[type];
>         struct zswap_entry *entry;
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
>         u8 *src, *dst, *tmp;
>         unsigned int dlen;
> -       int ret;
> +       bool ret;
> +
> +       VM_WARN_ON_ONCE(!PageLocked(page));
> +       VM_WARN_ON_ONCE(!PageSwapCache(page));
>
>         /* find */
>         spin_lock(&tree->lock);
> @@ -1418,7 +1401,7 @@ static int zswap_frontswap_load(unsigned type, pgof=
f_t offset,
>         if (!entry) {
>                 /* entry was written back */

nit: the above comment is now obsolete. We may not find the entry
because it was never stored in zswap in the first place (since we
dropped the frontswap map, we won't know before we do the lookup
here).

>                 spin_unlock(&tree->lock);
> -               return -1;
> +               return false;
>         }
>         spin_unlock(&tree->lock);
>
> @@ -1426,14 +1409,14 @@ static int zswap_frontswap_load(unsigned type, pg=
off_t offset,
>                 dst =3D kmap_atomic(page);
>                 zswap_fill_page(dst, entry->value);
>                 kunmap_atomic(dst);
> -               ret =3D 0;
> +               ret =3D true;
>                 goto stats;
>         }
>
>         if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
>                 tmp =3D kmalloc(entry->length, GFP_KERNEL);
>                 if (!tmp) {
> -                       ret =3D -ENOMEM;
> +                       ret =3D false;
>                         goto freeentry;
>                 }
>         }
> @@ -1454,7 +1437,8 @@ static int zswap_frontswap_load(unsigned type, pgof=
f_t offset,
>         sg_init_table(&output, 1);
>         sg_set_page(&output, page, PAGE_SIZE, 0);
>         acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, dlen);
> -       ret =3D crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), =
&acomp_ctx->wait);
> +       if (crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &aco=
mp_ctx->wait))
> +               WARN_ON(1);
>         mutex_unlock(acomp_ctx->mutex);
>
>         if (zpool_can_sleep_mapped(entry->pool->zpool))
> @@ -1462,16 +1446,16 @@ static int zswap_frontswap_load(unsigned type, pg=
off_t offset,
>         else
>                 kfree(tmp);
>
> -       BUG_ON(ret);
> +       ret =3D true;
>  stats:
>         count_vm_event(ZSWPIN);
>         if (entry->objcg)
>                 count_objcg_event(entry->objcg, ZSWPIN);
>  freeentry:
>         spin_lock(&tree->lock);
> -       if (!ret && zswap_exclusive_loads_enabled) {
> +       if (ret && zswap_exclusive_loads_enabled) {
>                 zswap_invalidate_entry(tree, entry);
> -               *exclusive =3D true;
> +               SetPageDirty(page);
>         } else if (entry->length) {
>                 spin_lock(&entry->pool->lru_lock);
>                 list_move(&entry->lru, &entry->pool->lru);
> @@ -1483,8 +1467,7 @@ static int zswap_frontswap_load(unsigned type, pgof=
f_t offset,
>         return ret;
>  }
>
> -/* frees an entry in zswap */
> -static void zswap_frontswap_invalidate_page(unsigned type, pgoff_t offse=
t)
> +void zswap_invalidate(int type, pgoff_t offset)
>  {
>         struct zswap_tree *tree =3D zswap_trees[type];
>         struct zswap_entry *entry;
> @@ -1501,8 +1484,22 @@ static void zswap_frontswap_invalidate_page(unsign=
ed type, pgoff_t offset)
>         spin_unlock(&tree->lock);
>  }
>
> -/* frees all zswap entries for the given swap type */
> -static void zswap_frontswap_invalidate_area(unsigned type)
> +void zswap_swapon(int type)
> +{
> +       struct zswap_tree *tree;
> +
> +       tree =3D kzalloc(sizeof(*tree), GFP_KERNEL);
> +       if (!tree) {
> +               pr_err("alloc failed, zswap disabled for swap type %d\n",=
 type);
> +               return;
> +       }
> +
> +       tree->rbroot =3D RB_ROOT;
> +       spin_lock_init(&tree->lock);
> +       zswap_trees[type] =3D tree;
> +}
> +
> +void zswap_swapoff(int type)
>  {
>         struct zswap_tree *tree =3D zswap_trees[type];
>         struct zswap_entry *entry, *n;
> @@ -1520,29 +1517,6 @@ static void zswap_frontswap_invalidate_area(unsign=
ed type)
>         zswap_trees[type] =3D NULL;
>  }
>
> -static void zswap_frontswap_init(unsigned type)
> -{
> -       struct zswap_tree *tree;
> -
> -       tree =3D kzalloc(sizeof(*tree), GFP_KERNEL);
> -       if (!tree) {
> -               pr_err("alloc failed, zswap disabled for swap type %d\n",=
 type);
> -               return;
> -       }
> -
> -       tree->rbroot =3D RB_ROOT;
> -       spin_lock_init(&tree->lock);
> -       zswap_trees[type] =3D tree;
> -}
> -
> -static const struct frontswap_ops zswap_frontswap_ops =3D {
> -       .store =3D zswap_frontswap_store,
> -       .load =3D zswap_frontswap_load,
> -       .invalidate_page =3D zswap_frontswap_invalidate_page,
> -       .invalidate_area =3D zswap_frontswap_invalidate_area,
> -       .init =3D zswap_frontswap_init
> -};
> -
>  /*********************************
>  * debugfs functions
>  **********************************/
> @@ -1631,16 +1605,11 @@ static int zswap_setup(void)
>         if (!shrink_wq)
>                 goto fallback_fail;
>
> -       ret =3D frontswap_register_ops(&zswap_frontswap_ops);
> -       if (ret)
> -               goto destroy_wq;
>         if (zswap_debugfs_init())
>                 pr_warn("debugfs initialization failed\n");
>         zswap_init_state =3D ZSWAP_INIT_SUCCEED;
>         return 0;
>
> -destroy_wq:
> -       destroy_workqueue(shrink_wq);
>  fallback_fail:
>         if (pool)
>                 zswap_pool_destroy(pool);
> --
> 2.41.0
>

LGTM with a few nits above, probably they can be done in follow up
patches. Thanks for the cleanup!

FWIW:
Acked-by: Yosry Ahmed <yosryahmed@google.com>
