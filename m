Return-Path: <linux-kernel+bounces-91537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F00C871353
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48631F21E47
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6A3823CE;
	Tue,  5 Mar 2024 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUNpBBf6"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C3D811E7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 02:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604161; cv=none; b=OjKdqfMKi6vZD9r2MToFXPGVZ1fYv9QHR8aul8C4JSiofRpqOnI6QDjHZgVH/27OM/iVJnNqH3JyMBd+ty68WzkbjuHTLA91SCKDQuaAQCGDQkKIsWb2CxxDnec/ib2hsB0SU7kxfDvibuiW592Rb1DBq87Ai+dRax6nKNVkDRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604161; c=relaxed/simple;
	bh=0g4kx20v/tRug+W1PYpsc8oafUvPrCF9Vh1iHG822jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0B8zhPHGgY8PQ+1jX68wTVfXlFnnJDimSJALfY7KQM6KxxxzSr5cxRVHfpc+5Y/OwEyKPUZWT74gqODuMN8TPCTenQU6HlIkvz7yuYT27uyOLwBUtk/y0uoAk9KYRiOjg/c90Osp8oYagaFSnk1AWrK+dlPrWKF7t1a6PwwL00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUNpBBf6; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d2fad80eacso62700061fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 18:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709604156; x=1710208956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlW642xaVm1YPl/8Ib6sKqDg0VXyxF4Hc3ocprVAWtM=;
        b=mUNpBBf6B0xbcS82v73Sbq2x0PCS1Prz0DTWRHuwlc+6+QVHfPIsHRLZyyikC14Kzo
         mjvw1iA5BeyP703mNp0OHtpC5fg9PncE/O9kteVNOI0QUPC1YO31auuHJEIg2QUhBltX
         xPe5FN6Lp9UAyh9+cuc0FZJ8uhcEinON6VqiY7yZ3rxC+6kJOYZ3J828pKGXFZ2gyTzh
         +06Q44rYufu6ZBkC/9xwxIBwfRrQHTJjPq8JFCc8VlFO9AkeW4tTtn0P48abhsOw+cPF
         ERVmKRCUVzB3pTfzDN5RJX+5gAgESt7GTN/e2jymL/fx3hIhbt7PM4fRixK4subFpyo3
         l3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709604156; x=1710208956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlW642xaVm1YPl/8Ib6sKqDg0VXyxF4Hc3ocprVAWtM=;
        b=Tjc3RNNwIe7802CVUKWboV6gfca+rN0lXSZxSvHHjBlQ7zL6s4xvjPD5Bgb+EkLcrD
         8BBnqMR6yKUx5d0vdW3mMgw/v+lvmiNBikF/60JKsgMaeoKe44z/8fSVy4xb3ZD8fRyH
         kIUhi25dKSLgffNJoLlD54a7B1qmrxSTF0EyeHNxRAahxSufxN+jIBrFgXIuYLOTuTVS
         +Wysi0LuNEZpal+xLBn2V6yZB9fLHk0QAo7yf7Sc62YKqQ4REZGUqMP3/oMJGBbzBW6d
         5KieUi+Hk9rmx4aHkEbEcOdnfCm3N4eX3C/nQijep8IfJSZY+71XVUN9NnZZM/n9Pvxq
         dCTw==
X-Forwarded-Encrypted: i=1; AJvYcCWg3WMka6RLpcYw0LilboTCXJ2O1L8kllGpsXFHJMUvrmYDSTAowAOsIdRb7NccGtkZor6EnVII8bmIPsxohvQ30Zgu3j5zbu2JvTTT
X-Gm-Message-State: AOJu0YwYhIoDzoMYPf/FqIaA6Rmge4KWtxftP88Ne543k77NdahTcSEI
	gHMG594gOIiipNPKbTYDXhL+8eazdEaq76NX67KSIQMy4JDS6IgHHdLPaad6Q28L77Hq1XnFWo8
	0p2pVpQuU7yu9DPaSSEI6d3v+jOA=
X-Google-Smtp-Source: AGHT+IGiwUkSuP9+6+NmoXDCQ2rtvHtM4P7ba4Z9HtTCZAYBcKfxvv1g4VxkgI6pPEYXzDaY+XPTS3bfhbxe7gMTTBI=
X-Received: by 2002:a19:9149:0:b0:513:a6:2f4 with SMTP id y9-20020a199149000000b0051300a602f4mr320633lfj.13.1709604155767;
 Mon, 04 Mar 2024 18:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111081743.2999210-1-chao@kernel.org> <ae43ed8a-49b5-44bf-8fea-a222091e9790@kernel.org>
 <ed3eecaf9e2f4c8fae2fd01241aa097e@BJMBX02.spreadtrum.com> <CAHJ8P3JzanzGqjuJ8ODMxE4rguxrQ-yd4Ho16RCDH9u975gOEA@mail.gmail.com>
In-Reply-To: <CAHJ8P3JzanzGqjuJ8ODMxE4rguxrQ-yd4Ho16RCDH9u975gOEA@mail.gmail.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 5 Mar 2024 10:02:24 +0800
Message-ID: <CAHJ8P3K9uXCjJtGVtajPRWjjoH2yi29VVf09ckgqtLduYPZ6cw@mail.gmail.com>
Subject: Re: [PATCH v3] f2fs: reduce expensive checkpoint trigger frequency
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, 
	=?UTF-8?B?6YeR57qi5a6HIChIb25neXUgSmluKQ==?= <hongyu.jin@unisoc.com>, 
	=?UTF-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, move jaegeuk to the "To"   list

Dear  Jaegeuk,

Let me describe the problem process, it is reproduced by monkey stability t=
est:

 1.SBI_NEED_CP flag bit is set=EF=BC=8C
 set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);

 2.Ckpt thread is blocked by IO busy when it is doing CP,  it can not
get request tag from block queue,
 PID: 505      TASK: ffffff80ed7f49c0  CPU: 4    COMMAND: "f2fs_ckpt-254:4"
 #0 [ffffffc015fcb330] __switch_to at ffffffc010196350
 #1 [ffffffc015fcb390] __schedule at ffffffc01168e53c
 #2 [ffffffc015fcb3f0] schedule at ffffffc01168ed7c
 #3 [ffffffc015fcb450] io_schedule at ffffffc01168f7a0
 #4 [ffffffc015fcb4c0] blk_mq_get_tag at ffffffc0101008a4
 #5 [ffffffc015fcb530] blk_mq_get_request at ffffffc0109241b0
 #6 [ffffffc015fcb5f0] blk_mq_make_request at ffffffc0109233bc
 #7 [ffffffc015fcb680] generic_make_request at ffffffc0100fc6ec
 #8 [ffffffc015fcb700] submit_bio at ffffffc0100fc3b8
 #9 [ffffffc015fcb750] __submit_bio at ffffffc01081a2e0
 #10 [ffffffc015fcb7d0] __submit_merged_bio at ffffffc01081b07c
 #11 [ffffffc015fcb8a0] f2fs_submit_page_write at ffffffc0100ecd3c
 #12 [ffffffc015fcb990] f2fs_do_write_meta_page at ffffffc010845738
 #13 [ffffffc015fcb9d0] __f2fs_write_meta_page at ffffffc01080a8f4
 #14 [ffffffc015fcbb60] f2fs_sync_meta_pages at ffffffc01080a684
 #15 [ffffffc015fcbca0] do_checkpoint at ffffffc01080f0a8
 #16 [ffffffc015fcbd10] f2fs_write_checkpoint at ffffffc01080e50c
 #17 [ffffffc015fcbdb0] __checkpoint_and_complete_reqs at ffffffc010810f54
 #18 [ffffffc015fcbe40] issue_checkpoint_thread at ffffffc0108113ec
 #19 [ffffffc015fcbe80] kthread at ffffffc0102665b0

 3.Subsequent regular file fsync will trigger ckpt because SBI_NEED_CP
has not been cleared.
 In fact, these cases should not trigger ckpt.

 4.If some processes that perform f2fs_do_sync_file are important processes
 in the system(such as init) and are blocked for too long, it will
cause other problems in the system, ANR or android reboot
 PID: 287      TASK: ffffff80f9eb0ec0  CPU: 2    COMMAND: "init"
 #0 [ffffffc01389bab0] __switch_to at ffffffc010196350
 #1 [ffffffc01389bb10] __schedule at ffffffc01168e53c
 #2 [ffffffc01389bb70] schedule at ffffffc01168ed7c
 #3 [ffffffc01389bbc0] wait_for_completion at ffffffc011692368
 #4 [ffffffc01389bca0] f2fs_issue_checkpoint at ffffffc010810cb0
 #5 [ffffffc01389bd00] f2fs_sync_fs at ffffffc0107f4e1c
 #6 [ffffffc01389bdc0] f2fs_do_sync_file at ffffffc0107d4d44
 #7 [ffffffc01389be20] f2fs_sync_file at ffffffc0107d492c
 #8 [ffffffc01389be30] __arm64_sys_fsync at ffffffc0105d31d8
 #9 [ffffffc01389be70] el0_svc_common at ffffffc0101aa550
 #10 [ffffffc01389beb0] el0_svc_handler at ffffffc0100886fc

and I tested Chao's patch can avoid the above case, please help
consider this patch or
any comment/suggestions about this?

thanks!

On Tue, Mar 5, 2024 at 9:56=E2=80=AFAM Zhiguo Niu <niuzhiguo84@gmail.com> w=
rote:
>
> Dear  Jaegeuk,
>
> Let me describe the problem process, it is reproduced by monkey stability=
 test:
>
>  1.SBI_NEED_CP flag bit is set=EF=BC=8C
>  set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
>
>  2.Ckpt thread is blocked by IO busy when it is doing CP,  it can not
> get request tag from block queue,
>  PID: 505      TASK: ffffff80ed7f49c0  CPU: 4    COMMAND: "f2fs_ckpt-254:=
4"
>  #0 [ffffffc015fcb330] __switch_to at ffffffc010196350
>  #1 [ffffffc015fcb390] __schedule at ffffffc01168e53c
>  #2 [ffffffc015fcb3f0] schedule at ffffffc01168ed7c
>  #3 [ffffffc015fcb450] io_schedule at ffffffc01168f7a0
>  #4 [ffffffc015fcb4c0] blk_mq_get_tag at ffffffc0101008a4
>  #5 [ffffffc015fcb530] blk_mq_get_request at ffffffc0109241b0
>  #6 [ffffffc015fcb5f0] blk_mq_make_request at ffffffc0109233bc
>  #7 [ffffffc015fcb680] generic_make_request at ffffffc0100fc6ec
>  #8 [ffffffc015fcb700] submit_bio at ffffffc0100fc3b8
>  #9 [ffffffc015fcb750] __submit_bio at ffffffc01081a2e0
>  #10 [ffffffc015fcb7d0] __submit_merged_bio at ffffffc01081b07c
>  #11 [ffffffc015fcb8a0] f2fs_submit_page_write at ffffffc0100ecd3c
>  #12 [ffffffc015fcb990] f2fs_do_write_meta_page at ffffffc010845738
>  #13 [ffffffc015fcb9d0] __f2fs_write_meta_page at ffffffc01080a8f4
>  #14 [ffffffc015fcbb60] f2fs_sync_meta_pages at ffffffc01080a684
>  #15 [ffffffc015fcbca0] do_checkpoint at ffffffc01080f0a8
>  #16 [ffffffc015fcbd10] f2fs_write_checkpoint at ffffffc01080e50c
>  #17 [ffffffc015fcbdb0] __checkpoint_and_complete_reqs at ffffffc010810f5=
4
>  #18 [ffffffc015fcbe40] issue_checkpoint_thread at ffffffc0108113ec
>  #19 [ffffffc015fcbe80] kthread at ffffffc0102665b0
>
>  3.Subsequent regular file fsync will trigger ckpt because SBI_NEED_CP
> has not been cleared.
>  In fact, these cases should not trigger ckpt.
>
>  4.If some processes that perform f2fs_do_sync_file are important process=
es
>  in the system(such as init) and are blocked for too long, it will
> cause other problems in the system, ANR or android reboot
>  PID: 287      TASK: ffffff80f9eb0ec0  CPU: 2    COMMAND: "init"
>  #0 [ffffffc01389bab0] __switch_to at ffffffc010196350
>  #1 [ffffffc01389bb10] __schedule at ffffffc01168e53c
>  #2 [ffffffc01389bb70] schedule at ffffffc01168ed7c
>  #3 [ffffffc01389bbc0] wait_for_completion at ffffffc011692368
>  #4 [ffffffc01389bca0] f2fs_issue_checkpoint at ffffffc010810cb0
>  #5 [ffffffc01389bd00] f2fs_sync_fs at ffffffc0107f4e1c
>  #6 [ffffffc01389bdc0] f2fs_do_sync_file at ffffffc0107d4d44
>  #7 [ffffffc01389be20] f2fs_sync_file at ffffffc0107d492c
>  #8 [ffffffc01389be30] __arm64_sys_fsync at ffffffc0105d31d8
>  #9 [ffffffc01389be70] el0_svc_common at ffffffc0101aa550
>  #10 [ffffffc01389beb0] el0_svc_handler at ffffffc0100886fc
>
> and I tested Chao's patch can avoid the above case, please help
> consider this patch or
> any comment/suggestions about this?
>
> thanks!
>
> On Mon, Feb 26, 2024 at 9:22=E2=80=AFAM =E7=89=9B=E5=BF=97=E5=9B=BD (Zhig=
uo Niu) <Zhiguo.Niu@unisoc.com> wrote:
> >
> >
> > Hi Jaegeuk
> >
> > Sorry for disturbing you, Do you have any comments about this patch fro=
m Chao, I=E2=80=99ve met this issue several times on our platform when do m=
onkey test.
> > Thanks!
> >
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Chao Yu <chao@kernel.org>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B42=E6=9C=8819=E6=97=
=A5 15:19
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: jaegeuk@kernel.org
> > =E6=8A=84=E9=80=81: linux-f2fs-devel@lists.sourceforge.net; linux-kerne=
l@vger.kernel.org; =E7=89=9B=E5=BF=97=E5=9B=BD (Zhiguo Niu) <Zhiguo.Niu@uni=
soc.com>
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v3] f2fs: reduce expensive checkpoint tr=
igger frequency
> >
> >
> > =E6=B3=A8=E6=84=8F: =E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=87=
=AA=E4=BA=8E=E5=A4=96=E9=83=A8=E3=80=82=E9=99=A4=E9=9D=9E=E4=BD=A0=E7=A1=AE=
=E5=AE=9A=E9=82=AE=E4=BB=B6=E5=86=85=E5=AE=B9=E5=AE=89=E5=85=A8=EF=BC=8C=E5=
=90=A6=E5=88=99=E4=B8=8D=E8=A6=81=E7=82=B9=E5=87=BB=E4=BB=BB=E4=BD=95=E9=93=
=BE=E6=8E=A5=E5=92=8C=E9=99=84=E4=BB=B6=E3=80=82
> > CAUTION: This email originated from outside of the organization. Do not=
 click links or open attachments unless you recognize the sender and know t=
he content is safe.
> >
> >
> >
> > Jaegeuk,
> >
> > Any comments?
> >
> > On 2024/1/11 16:17, Chao Yu wrote:
> > > We may trigger high frequent checkpoint for below case:
> > > 1. mkdir /mnt/dir1; set dir1 encrypted 2. touch /mnt/file1; fsync
> > > /mnt/file1 3. mkdir /mnt/dir2; set dir2 encrypted 4. touch /mnt/file2=
;
> > > fsync /mnt/file2 ...
> > >
> > > Although, newly created dir and file are not related, due to commit
> > > bbf156f7afa7 ("f2fs: fix lost xattrs of directories"), we will trigge=
r
> > > checkpoint whenever fsync() comes after a new encrypted dir created.
> > >
> > > In order to avoid such condition, let's record an entry including
> > > directory's ino into global cache when we initialize encryption polic=
y
> > > in a checkpointed directory, and then only trigger checkpoint() when
> > > target file's parent has non-persisted encryption policy, for the cas=
e
> > > its parent is not checkpointed, need_do_checkpoint() has cover that b=
y
> > > verifying it with f2fs_is_checkpointed_node().
> > >
> > > Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > > Tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > > Reported-by: Yunlei He <heyunlei@hihonor.com>
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > > v3:
> > > - Recently, Zhiguo Niu reported the same issue, so I repost this patc=
h
> > > for comments.
> > >   fs/f2fs/f2fs.h              |  2 ++
> > >   fs/f2fs/file.c              |  3 +++
> > >   fs/f2fs/xattr.c             | 16 ++++++++++++++--
> > >   include/trace/events/f2fs.h |  3 ++-
> > >   4 files changed, 21 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index
> > > e2e0ca45f881..0094a8c85f4a 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -279,6 +279,7 @@ enum {
> > >       APPEND_INO,             /* for append ino list */
> > >       UPDATE_INO,             /* for update ino list */
> > >       TRANS_DIR_INO,          /* for transactions dir ino list */
> > > +     ENC_DIR_INO,            /* for encrypted dir ino list */
> > >       FLUSH_INO,              /* for multiple device flushing */
> > >       MAX_INO_ENTRY,          /* max. list */
> > >   };
> > > @@ -1147,6 +1148,7 @@ enum cp_reason_type {
> > >       CP_FASTBOOT_MODE,
> > >       CP_SPEC_LOG_NUM,
> > >       CP_RECOVER_DIR,
> > > +     CP_ENC_DIR,
> > >   };
> > >
> > >   enum iostat_type {
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c index
> > > 8198afb5fb9c..18b33b1f0c83 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -218,6 +218,9 @@ static inline enum cp_reason_type need_do_checkpo=
int(struct inode *inode)
> > >               f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
> > >                                                       TRANS_DIR_INO))
> > >               cp_reason =3D CP_RECOVER_DIR;
> > > +     else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
> > > +                                                     ENC_DIR_INO))
> > > +             cp_reason =3D CP_ENC_DIR;
> > >
> > >       return cp_reason;
> > >   }
> > > diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c index
> > > f290fe9327c4..cbd1b88297fe 100644
> > > --- a/fs/f2fs/xattr.c
> > > +++ b/fs/f2fs/xattr.c
> > > @@ -629,6 +629,7 @@ static int __f2fs_setxattr(struct inode *inode, i=
nt index,
> > >                       const char *name, const void *value, size_t siz=
e,
> > >                       struct page *ipage, int flags)
> > >   {
> > > +     struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> > >       struct f2fs_xattr_entry *here, *last;
> > >       void *base_addr, *last_base_addr;
> > >       int found, newsize;
> > > @@ -772,8 +773,19 @@ static int __f2fs_setxattr(struct inode *inode, =
int index,
> > >       if (index =3D=3D F2FS_XATTR_INDEX_ENCRYPTION &&
> > >                       !strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEX=
T))
> > >               f2fs_set_encrypted_inode(inode);
> > > -     if (S_ISDIR(inode->i_mode))
> > > -             set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
> > > +
> > > +     if (S_ISDIR(inode->i_mode)) {
> > > +             /*
> > > +              * In restrict mode, fsync() always tries triggering ch=
eckpoint
> > > +              * for all metadata consistency, in other mode, it only=
 triggers
> > > +              * checkpoint when parent's encryption metadata updates=
.
> > > +              */
> > > +             if (F2FS_OPTION(sbi).fsync_mode =3D=3D FSYNC_MODE_STRIC=
T)
> > > +                     set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
> > > +             else if (IS_ENCRYPTED(inode) &&
> > > +                     f2fs_is_checkpointed_node(sbi, inode->i_ino))
> > > +                     f2fs_add_ino_entry(sbi, inode->i_ino, ENC_DIR_I=
NO);
> > > +     }
> > >
> > >   same:
> > >       if (is_inode_flag_set(inode, FI_ACL_MODE)) { diff --git
> > > a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h index
> > > 7ed0fc430dc6..48f2e399e184 100644
> > > --- a/include/trace/events/f2fs.h
> > > +++ b/include/trace/events/f2fs.h
> > > @@ -139,7 +139,8 @@ TRACE_DEFINE_ENUM(EX_BLOCK_AGE);
> > >               { CP_NODE_NEED_CP,      "node needs cp" },             =
 \
> > >               { CP_FASTBOOT_MODE,     "fastboot mode" },             =
 \
> > >               { CP_SPEC_LOG_NUM,      "log type is 2" },             =
 \
> > > -             { CP_RECOVER_DIR,       "dir needs recovery" })
> > > +             { CP_RECOVER_DIR,       "dir needs recovery" },        =
 \
> > > +             { CP_ENC_DIR,           "persist encryption policy" })
> > >
> > >   #define show_shutdown_mode(type)                                   =
 \
> > >       __print_symbolic(type,                                         =
 \

