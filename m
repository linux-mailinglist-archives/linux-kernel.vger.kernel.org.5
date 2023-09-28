Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71567B25F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjI1Tdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjI1Tdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:33:44 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC89A1A3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:33:41 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-565e395e7a6so7312569a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695929621; x=1696534421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cP94ADCLXZC+EbVbSK8US0v0vCqsoTekl1vFKhJob1s=;
        b=ChiJ4Qw1kHC68rSdpVL5ZxpCKSi/KggfZqjfIPkuBHaArH4bldzkCtD7Z7/ZnmZ0PL
         xGR+/d67wiCBl27+iS+kaY/xHuRYGzoKpJIaaNSkfHJF8/2WiswCUfvEhX7gl2xZsl7B
         OTeRSDnlTJpZ/Y6Ldf8TZvFelQbNzc3mmribTzGlW4ZJgygXgGchGUn9XMguMJoE0Sn7
         apRjmHrOJKbD8QK7nXjWD7Fx0dywPoqCRlQI7K51Z6B3H6HU1yOfO7W+HEzJJYQNoGEt
         RUWWkvDg6QOMpZVmY4A0GEnB2djJmnkfyYVwteR42M1/2hagH5niekElpXOSTxaROZjO
         pQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695929621; x=1696534421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cP94ADCLXZC+EbVbSK8US0v0vCqsoTekl1vFKhJob1s=;
        b=Bv43mW781/6fS3SBgLfxV2FhRJYEfqfsL+WWeGX4KhqM+KidkMGq0QAGMoVCn9m9NV
         3SBzRnPmu6QKbFoE3aWd03FkFuGLpKJu6o/HQ91hQcnOYvgw/vYu1i47Qd+UzYU2Nn13
         MF+8JynzfSUerT6Co/uUUz1qUhWuHzcVzmeOUwnbQlUxwJ7IxEDmFSOPP9ySS4rlogZ/
         b6RbuFuLvlZ96LPfL/ijbpmW7d2KFeRebi1+C3IH9MOuDupwSqNxaD0mi3mizAFJXlY7
         6+/aUSjYzc+Un8xVSzSRbbWjmBSg15wNPqSwcQoxDr3X9OMPYkGfsAS4imxwo4JG7LOG
         OwWQ==
X-Gm-Message-State: AOJu0YwCHcC8+2UihVQMPZfiuj6xLxvZHyQk6pzgdDM8BwLD/5kutyG3
        tHeA1YJ644IFmyR94R9dcH6D1AfFwdEDPwRgxY8=
X-Google-Smtp-Source: AGHT+IFyOmwDuIcD2siC2xh5eeFm74R1+T8tnixQH+ZK9iaX+VQLln+zGhfpfzzHkRc9qegPAJVt7zFZFRE/LhKlXwg=
X-Received: by 2002:a17:90a:3884:b0:26b:49de:13bd with SMTP id
 x4-20020a17090a388400b0026b49de13bdmr2015081pjb.36.1695929621058; Thu, 28 Sep
 2023 12:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230922193639.10158-1-vishal.moola@gmail.com>
 <20230922193639.10158-3-vishal.moola@gmail.com> <CAHbLzkqt8LFFDH2a7+xaQmncwiK=Ynv6vHs9d=TDNjp9_wJ4rw@mail.gmail.com>
 <ZRVB49PruFvT7+43@casper.infradead.org>
In-Reply-To: <ZRVB49PruFvT7+43@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 28 Sep 2023 12:33:29 -0700
Message-ID: <CAHbLzkqZHJV8j+C1czfDrZ9t8W_9YLDaZ7FnhNKa224ehnH1zA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm/khugepaged: Remove compound_pagelist
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 2:05=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Sep 26, 2023 at 03:07:18PM -0700, Yang Shi wrote:
> > On Fri, Sep 22, 2023 at 9:33=E2=80=AFPM Vishal Moola (Oracle)
> > <vishal.moola@gmail.com> wrote:
> > >
> > > Currently, khugepaged builds a compound_pagelist while scanning, whic=
h
> > > is used to properly account for compound pages. We can now account
> > > for a compound page as a singular folio instead, so remove this list.
> > >
> > > Large folios are guaranteed to have consecutive ptes and addresses, s=
o
> > > once the first pte of a large folio is found skip over the rest.
> >
> > The address space may just map a partial folio, for example, in the
> > extreme case the HUGE_PMD size range may have HUGE_PMD_NR folios with
> > mapping one subpage from each folio per PTE. So assuming the PTE
> > mapped folio is mapped consecutively may be wrong.
>
> How?  You can do that with two VMAs, but this is limited to scanning
> within a single VMA.  If we've COWed a large folio, we currently do
> so as a single page folio, and I'm not seeing any demand to change that.
> If we did COW as a large folio, we'd COW every page in that folio.
> How do we interleave two large folios in the same VMA?

It is not about COW. The magic from mremap() may cause some corner
cases. For example,

We have a 2M VMA, every 4K of the VMA may be mapped to a subpage from
different folios. Like:

0: #0 subpage of folio #0
1: #1 subpage of folio #1
2: #2 subpage of folio #2
....
511: #511 subpage of folio #511

When khugepaged is scanning the VMA, it may just isolate and lock the
folio #0, but skip all other folios since it assumes the VMA is just
mapped by folio #0.

This may trigger kernel bug when unlocking other folios which are
actually not locked and maybe data corruption since the other folios
may go away under us (unisolated, unlocked and unpinned).

>
> > Please refer to collapse_compound_extreme() in
> > tools/testing/selftests/mm/khugepaged.c.
>
> I agree that running that part of the test-suite would be useful, but
> could you point to which test specifically would create a problem here?

collapse_compound_extreme. I ran the test with this series (patch #1
is fine), it did trigger a kernel bug:

Collapse PTE table full of different compound pages....[  259.634265]
page:0000000088fc2e6f refcount:1 mapcount:1 mapping:0000000000000000
index:0x4000
1 pfn:0x124a00
[  259.636880] head:0000000088fc2e6f order:9 entire_mapcount:0
nr_pages_mapped:1 pincount:0
[  259.639158] memcg:ffff002035ab9000
[  259.640041] anon flags:
0x2fffff000a0078(uptodate|dirty|lru|head|mappedtodisk|swapbacked|node=3D0|z=
one=3D2|lastcpupid=3D0xfffff)
[  259.642884] page_type: 0x0()
[  259.643626] raw: 002fffff000a0078 fffffc001fd1a908 fffffc0003930008
ffff0007fd376209
[  259.645609] raw: 0000000000040001 0000000000000000 0000000100000000
ffff002035ab9000
[  259.647580] page dumped because:
VM_BUG_ON_FOLIO(!folio_test_locked(folio))
[  259.649535] ------------[ cut here ]------------
[  259.650739] kernel BUG at mm/filemap.c:1524!
[  259.651856] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
[  259.653419] Modules linked in: rfkill vfat fat virtio_net
net_failover failover fuse zram crct10dif_ce ghash_ce virtio_blk
qemu_fw_cfg virtio_mmio i
pmi_devintf ipmi_msghandler
[  259.657448] CPU: 6 PID: 828 Comm: khugepaged Not tainted 6.6.0-rc2+
#27
[  259.659269] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
02/06/2015
[  259.661168] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS
BTYPE=3D--)
[  259.663095] pc : folio_unlock+0x7c/0x88
[  259.664169] lr : folio_unlock+0x7c/0x88
[  259.665236] sp : ffff800086c9bae0
[  259.666169] x29: ffff800086c9bae0 x28: 00000000020378a0 x27:
ffff0000d81e4000
[  259.668332] x26: ffff8000826b43ec x25: ffff0000d81e4000 x24:
0000000000000001
[  259.670301] x23: ffff8000826b0b88 x22: ffff002062a25928 x21:
fffffc00036078e8
[  259.672240] x20: fffffc0003928000 x19: fffffc0003928000 x18:
ffffffffffffffff
[  259.674205] x17: 3032303066666666 x16: 2030303030303030 x15:
0000000000000006
[  259.676161] x14: 0000000000000000 x13: 29296f696c6f6628 x12:
64656b636f6c5f74
[  259.678301] x11: 00000000ffff7fff x10: ffff003f5f1f0000 x9 :
ffff800080248730
[  259.680187] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 :
00000000002bffa8
[  259.682111] x5 : ffff001ffec79988 x4 : 0000000000000000 x3 :
0000000000000000
[  259.683804] x2 : ffff001ffec86370 x1 : ffff801f7cbdc000 x0 :
000000000000003f
[  259.685500] Call trace:
[  259.686096]  folio_unlock+0x7c/0x88
[  259.686969]  release_pte_folio+0x64/0x80
[  259.687983]  __collapse_huge_page_copy_succeeded.isra.0+0x98/0x228
[  259.689495]  collapse_huge_page+0x4b8/0x708
[  259.690520]  hpage_collapse_scan_pmd+0x208/0x558
[  259.691565]  khugepaged_scan_mm_slot.constprop.0+0x33c/0x470
[  259.692934]  khugepaged+0xf0/0x2b0
[  259.693744]  kthread+0xe0/0xf0
[  259.694493]  ret_from_fork+0x10/0x20
[  259.695381] Code: d65f03c0 b0009a81 9139e021 94012728 (d4210000)
[  259.696856] ---[ end trace 0000000000000000 ]---
[  259.697977] note: khugepaged[828] exited with irqs disabled


collapse_full_of_compound also failed with the same BUG.

Collapse PTE table full of compound pages....[  145.909210]
page:0000000004cc4ad2 refcount:511 mapcount:0 mapping:0000000000000000
index:0x400[50/4619]
20ba000
[  145.911807] head:0000000004cc4ad2 order:9 entire_mapcount:0
nr_pages_mapped:511 pincount:0
[  145.913806] memcg:ffff002019745000
[  145.914686] anon flags:
0xafffff000a0078(uptodate|dirty|lru|head|mappedtodisk|swapbacked|node=3D1|z=
one=3D2|lastcpupid=3D0xfffff)
[  145.917667] page_type: 0xffffffff()
[  145.918580] raw: 00afffff000a0078 fffffc0081b37a08 ffff0020680f6800
ffff002044e834e1
[  145.920555] raw: 0000000000040000 0000000000000000 000001ffffffffff
ffff002019745000
[  145.922466] page dumped because:
VM_BUG_ON_FOLIO(!folio_test_locked(folio))
[  145.924151] ------------[ cut here ]------------
[  145.925326] kernel BUG at mm/filemap.c:1524!
[  145.926499] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
[  145.928199] Modules linked in: rfkill vfat fat virtio_net
net_failover failover fuse zram crct10dif_ce ghash_ce virtio_blk
qemu_fw_cfg virtio_mmio i
pmi_devintf ipmi_msghandler
[  145.932379] CPU: 135 PID: 2193 Comm: khugepaged Not tainted
6.6.0-rc2+ #27
[  145.934265] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
02/06/2015
[  145.936150] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS
BTYPE=3D--)
[  145.938066] pc : folio_unlock+0x7c/0x88
[  145.939140] lr : folio_unlock+0x7c/0x88
[  145.940208] sp : ffff800099d2bae0
[  145.941134] x29: ffff800099d2bae0 x28: 0000000002037aa0 x27:
ffff0020656e0000
[  145.943049] x26: ffff8000826b43ec x25: ffff0020656e0000 x24:
0000000000000001
[  145.944988] x23: ffff8000826b0b88 x22: ffff00203e0b1ee8 x21:
fffffc008195b7e8
[  145.946973] x20: fffffc0081e80040 x19: fffffc0081e80000 x18:
ffffffffffffffff
[  145.948914] x17: 3032303066666666 x16: 2066666666666666 x15:
0000000000000006
[  145.950882] x14: 0000000000000000 x13: 29296f696c6f6628 x12:
64656b636f6c5f74
[  145.952779] x11: 00000000ffff7fff x10: ffff003f5f1f0000 x9 :
ffff80008013bea0
[  145.954750] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 :
00000000002bffa8
[  145.956831] x5 : ffff003f5faca988 x4 : ffff800099d2b930 x3 :
ffff803edda2d000
[  145.958538] x2 : ffff003f5faca980 x1 : 0000000000000023 x0 :
000000000000003f
[  145.960300] Call trace:
[  145.960914]  folio_unlock+0x7c/0x88
[  145.961810]  release_pte_folio+0x64/0x80
[  145.962824]  __collapse_huge_page_copy_succeeded.isra.0+0x98/0x228
[  145.964270]  collapse_huge_page+0x4b8/0x708
[  145.965313]  hpage_collapse_scan_pmd+0x208/0x558
[  145.966629]  khugepaged_scan_mm_slot.constprop.0+0x33c/0x470
[  145.967825]  khugepaged+0xf0/0x2b0
[  145.968586]  kthread+0xe0/0xf0
[  145.969274]  ret_from_fork+0x10/0x20
[  145.970081] Code: d65f03c0 b0009a81 9139e021 94012728 (d4210000)
[  145.971411] ---[ end trace 0000000000000000 ]---
[  145.972439] note: khugepaged[2193] exited with irqs disabled
