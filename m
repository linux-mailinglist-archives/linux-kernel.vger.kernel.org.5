Return-Path: <linux-kernel+bounces-11708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC90C81EA55
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 23:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA3E28329C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 22:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8B8107A1;
	Tue, 26 Dec 2023 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMMo0jvp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBDF101D0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 22:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150CBC43391
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 22:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703629972;
	bh=aTk3u429GEejNCLpssh9GPjwH82PofR7ITkqa8xIdII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LMMo0jvpuzO2M9QLF9nimk9jaUMd8NzUjEXVJe9HtSDWMay3VGqS4KJh4HBJwrcjH
	 RWYv5VJYFq6uzT/A99xJaK2H/r2mA/PEJMT5TsQV/AdF0twkuHBHiJY7Lksc0H6+VU
	 e+eLqwfY1YFxc4vsTxR8J8WOgJ+9TO462LRn37e4jUjQ9bMQ5y8txbQXzBTJyVtQAk
	 Cg3Au/mWyHGcN0XReZrlQRuPfCcEKhoayzHPYs580AuxMdNDp92ioBq4CJxabw8R2J
	 TYkwXWkWbLfoInRX3fQi/1zV+vhEla82zZwoMzgYlNNofO2CNj2tB1Bt+8DxyRnOT0
	 qqqkVyQomwapw==
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cd68a0de49so3434755a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 14:32:52 -0800 (PST)
X-Gm-Message-State: AOJu0YxR9t6OvrVTWvQ7stOy3HcFIDlhYI3sARypYbyInL6BLx9ZlKgS
	FLdU50huSIxSPMyDXHypIjqexLsgqG6TQiQ1mseQeYxQHXgs
X-Google-Smtp-Source: AGHT+IHAtUrhv4F+st4zkjPP/if3bdQDsNxJn4hroAPM1xkZtkeuZUjltXT9m3ItsphJqEDnxlZwEg9nJyjq9mL8o/Y=
X-Received: by 2002:a05:6a20:394a:b0:196:1ca7:89eb with SMTP id
 r10-20020a056a20394a00b001961ca789ebmr152499pzg.66.1703629971409; Tue, 26 Dec
 2023 14:32:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000b05cd060d6b5511@google.com> <CAKEwX=OmWYivf7dg_izW8pn5s5q15+nx-vRMsV47T_qG=dep_Q@mail.gmail.com>
In-Reply-To: <CAKEwX=OmWYivf7dg_izW8pn5s5q15+nx-vRMsV47T_qG=dep_Q@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 26 Dec 2023 14:32:40 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPLEXEXG+4esR6MbRa3iirTrJ7-w3YCorB9iD=gnQ+G3A@mail.gmail.com>
Message-ID: <CAF8kJuPLEXEXG+4esR6MbRa3iirTrJ7-w3YCorB9iD=gnQ+G3A@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] general protection fault in
 scatterwalk_copychunks (5)
To: Nhat Pham <nphamcs@gmail.com>
Cc: syzbot <syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com, 
	zhouchengming@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nhat,

Thanks for the first stab on this bug.

On Tue, Dec 26, 2023 at 1:08=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Dec 26, 2023 at 7:28=E2=80=AFAM syzbot
> <syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    39676dfe5233 Add linux-next specific files for 20231222
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D172080a1e80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df3761490b73=
4dc96
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D3eff5e51bf1db=
122a16e
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D178f6e26e=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15c399e9e80=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/360542c2ca67/d=
isk-39676dfe.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/900dfb21ca8a/vmli=
nux-39676dfe.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/c94a2a3ea0e0=
/bzImage-39676dfe.xz
> >
> > The issue was bisected to:
> >
> > commit 7bc134496bbbaacb0d4423b819da4eca850a839d
> > Author: Chengming Zhou <zhouchengming@bytedance.com>
> > Date:   Mon Dec 18 11:50:31 2023 +0000
> >
> >     mm/zswap: change dstmem size to one page
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15f60c36=
e80000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D17f60c36=
e80000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13f60c36e80=
000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com
> > Fixes: 7bc134496bbb ("mm/zswap: change dstmem size to one page")
> >
> > general protection fault, probably for non-canonical address 0xdffffc00=
00000001: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> > CPU: 0 PID: 5065 Comm: syz-executor140 Not tainted 6.7.0-rc6-next-20231=
222-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 11/17/2023
> > RIP: 0010:scatterwalk_start include/crypto/scatterwalk.h:63 [inline] <=
=3D=3D=3D=3D=3D=3D=3D=3D=3D This is the offending line.
> > RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:83 [inline]
> > RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:72 [inline]
> > RIP: 0010:scatterwalk_copychunks+0x3e0/0x560 crypto/scatterwalk.c:50

This is the call stack with an inline function. Very nice annotations
on the inline function expansions call stacks.

> > Code: f0 48 c1 e8 03 80 3c 08 00 0f 85 81 01 00 00 49 8d 44 24 08 4d 89=
 26 48 bf 00 00 00 00 00 fc ff df 48 89 44 24 10 48 c1 e8 03 <0f> b6 04 38 =
84 c0 74 08 3c 03 0f 8e 47 01 00 00 48 8b 44 24 08 41
> > RSP: 0018:ffffc90003a8ecf0 EFLAGS: 00010202
> > RAX: 0000000000000001 RBX: 0000000000000000 RCX: dffffc0000000000
> > RDX: ffff88802785d940 RSI: ffffffff8465df74 RDI: dffffc0000000000
> > RBP: 0000000000001000 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000002 R11: 82d8bd1b6060f805 R12: 0000000000000000
> > R13: 0000000000000014 R14: ffffc90003a8ed88 R15: 0000000000001000
> > FS:  00005555565c5380(0000) GS:ffff8880b9800000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000d5e538 CR3: 0000000079f3a000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  scatterwalk_map_and_copy+0x151/0x1d0 crypto/scatterwalk.c:67
> >  scomp_acomp_comp_decomp+0x3a3/0x780 crypto/scompress.c:149
>
> Looks like it's this line:
>
> scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,1);

Yes indeed.

The offending instruction is actually this one:

The inlined part of the call stack:
RIP: 0010:scatterwalk_start include/crypto/scatterwalk.h:63 [inline]
<=3D=3D=3D=3D=3D=3D=3D=3D=3D This is the offending line.
static inline void scatterwalk_start(struct scatter_walk *walk,
     struct scatterlist *sg)
{
walk->sg =3D sg;
walk->offset =3D sg->offset; <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D RI=
P pointer
}

RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:83 [inline]

static inline void scatterwalk_pagedone(struct scatter_walk *walk, int out,
unsigned int more)
{
if (out) {
struct page *page;

page =3D sg_page(walk->sg) + ((walk->offset - 1) >> PAGE_SHIFT);
flush_dcache_page(page);
}

if (more && walk->offset >=3D walk->sg->offset + walk->sg->length)
scatterwalk_start(walk, sg_next(walk->sg)); <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
}

RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:72 [inline]
RIP: 0010:scatterwalk_copychunks+0x3e0/0x560 crypto/scatterwalk.c:50

void scatterwalk_copychunks(void *buf, struct scatter_walk *walk,
    size_t nbytes, int out)
{
for (;;) {
unsigned int len_this_page =3D scatterwalk_pagelen(walk);
u8 *vaddr;

if (len_this_page > nbytes)
len_this_page =3D nbytes;

if (out !=3D 2) {
vaddr =3D scatterwalk_map(walk);
memcpy_dir(buf, vaddr, len_this_page, out);
scatterwalk_unmap(vaddr);
}

scatterwalk_advance(walk, len_this_page);

if (nbytes =3D=3D len_this_page)
break;

buf +=3D len_this_page;
nbytes -=3D len_this_page;

scatterwalk_pagedone(walk, out & 1, 1); <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
}
}

then the unlined portion of the call stack:
 scatterwalk_map_and_copy+0x151/0x1d0 crypto/scatterwalk.c:67

void scatterwalk_map_and_copy(void *buf, struct scatterlist *sg,
      unsigned int start, unsigned int nbytes, int out)
{
struct scatter_walk walk;
struct scatterlist tmp[2];

if (!nbytes)
return;

sg =3D scatterwalk_ffwd(tmp, sg, start);

scatterwalk_start(&walk, sg);
scatterwalk_copychunks(buf, &walk, nbytes, out); <=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
scatterwalk_done(&walk, out, 0);
}

 scomp_acomp_comp_decomp+0x3a3/0x780 crypto/scompress.c:149
if (dir)
ret =3D crypto_scomp_compress(scomp, scratch->src, req->slen,
    scratch->dst, &req->dlen, *ctx);
else
ret =3D crypto_scomp_decompress(scomp, scratch->src, req->slen,
      scratch->dst, &req->dlen, *ctx);
if (!ret) {
if (!req->dst) {
req->dst =3D sgl_alloc(req->dlen, GFP_ATOMIC, NULL);
if (!req->dst) {
ret =3D -ENOMEM;
goto out;
}
}
scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1);
}

 crypto_acomp_compress include/crypto/acompress.h:302 [inline]
 zswap_store+0x98b/0x2430 mm/zswap.c:1666
 swap_writepage+0x8e/0x220 mm/page_io.c:198
 pageout+0x399/0x9e0 mm/vmscan.c:656
 shrink_folio_list+0x2f47/0x3ea0 mm/vmscan.c:1319
 reclaim_folio_list+0xe4/0x3a0 mm/vmscan.c:2104
 reclaim_pages+0x483/0x6a0 mm/vmscan.c:2140
 madvise_cold_or_pageout_pte_range+0x129e/0x1f70 mm/madvise.c:526
 walk_pmd_range mm/pagewalk.c:143 [inline]
>
> My guess is dlen here exceeds 1 page - maybe the data is
> incompressible, so the output exceeds the original input? Based on the
> included kernel config, the algorithm used here is lzo, and it seems
> that can happen for this particular compressor:
>
> https://github.com/nemequ/lzo/blob/master/doc/LZO.FAQ#L200C1-L203C1
> https://github.com/nemequ/lzo/blob/master/doc/LZO.TXT#L157C2-L157C62

The decompressed output can be bigger than input. However, here we
specify the output size limit to be one page. The decompressor should
not output more than the 1 page of the dst buffer.

I did check the  lzo1x_decompress_safe() function.
It is supposed to use the  NEED_OP(x) check before it stores the output buf=
fer.
However I do find one place that seems to be missing that check, at
least it is not obvious to me how that check is effective. I will
paste it here let other experts take a look as well:
Line 228:

if (op - m_pos >=3D 8) {
unsigned char *oe =3D op + t;
if (likely(HAVE_OP(t + 15))) {
do {
COPY8(op, m_pos);
op +=3D 8;
m_pos +=3D 8;
COPY8(op, m_pos);
op +=3D 8;
m_pos +=3D 8;
} while (op < oe);
op =3D oe;
if (HAVE_IP(6)) {
state =3D next;
COPY4(op, ip); <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D This COPY4 does not have
obvious NEED_OP() check. As far as I can tell, this output is not
converted by the above HAVE_OP(t + 15)) check, which means to protect
the unaligned two 8 byte stores inside the "do while" loops.
op +=3D next;
ip +=3D next;
continue;
}
} else {
NEED_OP(t);
do {
*op++ =3D *m_pos++;
} while (op < oe);
}
} else


>
> Not 100% sure about linux kernel's implementation though. I'm no
> compression expert :)

Me neither. Anyway, if it is a decompression issue. For this bug, it
is good to have some debug print assert to check that after
decompression, the *dlen is not bigger than the original output
length. If it does blow over the decompression buffer, it is a bug
that needs to be fixed in the decompression function side, not the
zswap code.

Chris

>
> If this is the case though, perhaps we can't reduce the output buffer
> size to 1 page after all, unless we contractually obligate the output
> size to be <=3D input size (i.e new function in the compression API).
>
>
> >  crypto_acomp_compress include/crypto/acompress.h:302 [inline]
> >  zswap_store+0x98b/0x2430 mm/zswap.c:1666
> >  swap_writepage+0x8e/0x220 mm/page_io.c:198
> >  pageout+0x399/0x9e0 mm/vmscan.c:656
> >  shrink_folio_list+0x2f47/0x3ea0 mm/vmscan.c:1319
> >  reclaim_folio_list+0xe4/0x3a0 mm/vmscan.c:2104
> >  reclaim_pages+0x483/0x6a0 mm/vmscan.c:2140
> >  madvise_cold_or_pageout_pte_range+0x129e/0x1f70 mm/madvise.c:526
> >  walk_pmd_range mm/pagewalk.c:143 [inline]
> >  walk_pud_range mm/pagewalk.c:221 [inline]
> >  walk_p4d_range mm/pagewalk.c:256 [inline]
> >  walk_pgd_range+0xa48/0x1870 mm/pagewalk.c:293
> >  __walk_page_range+0x630/0x770 mm/pagewalk.c:395
> >  walk_page_range+0x626/0xa80 mm/pagewalk.c:521
> >  madvise_pageout_page_range mm/madvise.c:585 [inline]
> >  madvise_pageout+0x32c/0x820 mm/madvise.c:612
> >  madvise_vma_behavior+0x1cc/0x1b50 mm/madvise.c:1031
> >  madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1260
> >  do_madvise+0x333/0x660 mm/madvise.c:1440
> >  __do_sys_madvise mm/madvise.c:1453 [inline]
> >  __se_sys_madvise mm/madvise.c:1451 [inline]
> >  __x64_sys_madvise+0xa9/0x110 mm/madvise.c:1451
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x62/0x6a
> > RIP: 0033:0x7f15a5e14b69
> > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffde7b4a5c8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f15a5e14b69
> > RDX: 0000000000000015 RSI: 0000000000c00304 RDI: 0000000020000000
> > RBP: 0000000000000000 R08: 00005555565c6610 R09: 00005555565c6610
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007ffde7b4a808 R14: 0000000000000001 R15: 0000000000000001
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:scatterwalk_start include/crypto/scatterwalk.h:63 [inline]
> > RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:83 [inline]
> > RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:72 [inline]
> > RIP: 0010:scatterwalk_copychunks+0x3e0/0x560 crypto/scatterwalk.c:50
> > Code: f0 48 c1 e8 03 80 3c 08 00 0f 85 81 01 00 00 49 8d 44 24 08 4d 89=
 26 48 bf 00 00 00 00 00 fc ff df 48 89 44 24 10 48 c1 e8 03 <0f> b6 04 38 =
84 c0 74 08 3c 03 0f 8e 47 01 00 00 48 8b 44 24 08 41
> > RSP: 0018:ffffc90003a8ecf0 EFLAGS: 00010202
> > RAX: 0000000000000001 RBX: 0000000000000000 RCX: dffffc0000000000
> > RDX: ffff88802785d940 RSI: ffffffff8465df74 RDI: dffffc0000000000
> > RBP: 0000000000001000 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000002 R11: 82d8bd1b6060f805 R12: 0000000000000000
> > R13: 0000000000000014 R14: ffffc90003a8ed88 R15: 0000000000001000
> > FS:  00005555565c5380(0000) GS:ffff8880b9800000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000d5e538 CR3: 0000000079f3a000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > ----------------
> > Code disassembly (best guess):
> >    0:   f0 48 c1 e8 03          lock shr $0x3,%rax
> >    5:   80 3c 08 00             cmpb   $0x0,(%rax,%rcx,1)
> >    9:   0f 85 81 01 00 00       jne    0x190
> >    f:   49 8d 44 24 08          lea    0x8(%r12),%rax
> >   14:   4d 89 26                mov    %r12,(%r14)
> >   17:   48 bf 00 00 00 00 00    movabs $0xdffffc0000000000,%rdi
> >   1e:   fc ff df
> >   21:   48 89 44 24 10          mov    %rax,0x10(%rsp)
> >   26:   48 c1 e8 03             shr    $0x3,%rax
> > * 2a:   0f b6 04 38             movzbl (%rax,%rdi,1),%eax <-- trapping =
instruction
> >   2e:   84 c0                   test   %al,%al
> >   30:   74 08                   je     0x3a
> >   32:   3c 03                   cmp    $0x3,%al
> >   34:   0f 8e 47 01 00 00       jle    0x181
> >   3a:   48 8b 44 24 08          mov    0x8(%rsp),%rax
> >   3f:   41                      rex.B
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
>

