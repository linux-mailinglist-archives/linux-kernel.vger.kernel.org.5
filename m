Return-Path: <linux-kernel+bounces-104019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FB287C7F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03BC3B22569
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6431FD51E;
	Fri, 15 Mar 2024 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knDcyBhL"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD303D2FA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710473412; cv=none; b=auoRYj2iSWUzFaJ3YSOQjIcri+tou/bfVvH+ypi7iCPFLoLsrm8WLZIcipmKYUX+staj17SNNb63SKTODWUnHToDLC32RLpgQPqpHQXDYzj+6M17Ddp6HlxyiDZ8VgB6bt50lgCU5tzq0d2jtUR+CMBOM1PxPKxxXjncks4xE2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710473412; c=relaxed/simple;
	bh=CDgTZ00ev8gEUeNIlO7YSqdVcpwdndGCvS5D9JZz+D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLDJEIhMhtn6vmWL3tcQaqzk0B1Cn9DNAtiB3Mi9C+RcQl3cIxfcFL/lyhQxypLjAf1OZtjo+OUgQZif1mWL1uzq/9MWKwUo/UZBSwR5GC7HzJzFAgnJdZzO8cMe2FWvAS3BpoN6ZA/Z4cHZ2sZnjrqaA94g0sXCnzOfDggm/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knDcyBhL; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-568aa3096e9so705894a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 20:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710473409; x=1711078209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BOadd8fpWw24fQ+dpN551w2EzZFhXi8Nm7Mn+u1K9E=;
        b=knDcyBhLcGvSU7BUW5WrbBy+0OXhg4QMG4EWD37DYQ4xYDAKR3Ye+FVyU5g+NFWCA8
         gEnRHFrVAn9/LDtUbFe02KLzbbLZWpk1m/tHe6pGOIkWgDL5lrq9b3FFkPJNdbKSrM3d
         /+yUYl6ce+69AWT7x+IhMtrZGS9nyXx9sQhFHWj7Ht6hm4kWkuNn02FdC1zKFQhExDUs
         izvSI0ADb/jAXkWTScvgpIIh1fvDCa+ktl3SqJk7hwKA517FSmCK7mtLKaNsdJa/OICl
         PHcXG1ocTahA3Ut3RWyuAz7SICZdi6dhEcuLwCiB7ntEZU+fSVkiZZxRR+pPah3ELM9O
         xzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710473409; x=1711078209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BOadd8fpWw24fQ+dpN551w2EzZFhXi8Nm7Mn+u1K9E=;
        b=qPe2JlEYxObU9D2+OJ96TlKsBWTZwH25J01xaLGyr8sKPXszUd4E095Pb/6tiP0y+1
         3NR7vU5mY5YM2AwwTP87BST7nBQe0drB9UOl3PqoaeHJj7illbuHrbSipZuJhk/JBpzz
         YhHv6dbLRNIX5fAmiquU90ETQTWuvKJ7wzwPZEmG+whDZiYYtr916k9IcK2mvinjcGUp
         pH55RGbAeZ3re3BxsOzfdOcS5HGay82pwrwZrat51FgS6Estb6o4w3lKahtIyjokkVNH
         ghZ34MmvWfjrqI19TXJGV6B2eI9/cqMy2Ct8WJaMWJW1DZD2Sd0eNczFQex/E5KcOION
         B6Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWgI4aChsm2PQNG29KJQzt3oR15Hx4G5N6NTKYxHcLGaaXvGwMA4C4Hl3PsTJeLbmDC9YOocA1tNjBd2VMnIssZ4Q20rs+71fntTt1z
X-Gm-Message-State: AOJu0YykXpY/FIwGzJt3UmRZgRelHIKwBftUNxl1BD0tdTNmQCvSBaO9
	VEXqTR+PKlzTdmzeqIeoDOdLQ7eXtDTbr5L60b+LAnLZckEbthHOlP0kuFbm415jZbmdnNmbHGU
	Wjivy5A1LSBWK+V2rJV8HxZISv1M=
X-Google-Smtp-Source: AGHT+IFHS54SpNnKDt8mMe8ILXy8AdWC+kJxpK+jqfEnDEG8oDs47GBlV2v66U6GBTE2BnGOw7XsLILNfzyUDgTPRfg=
X-Received: by 2002:a05:6402:248b:b0:567:1947:d53f with SMTP id
 q11-20020a056402248b00b005671947d53fmr4327514eda.9.1710473408989; Thu, 14 Mar
 2024 20:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1710303061-16822-1-git-send-email-zhiguo.niu@unisoc.com>
 <eeefebcb-54db-4087-9319-dd5f9b63a1da@kernel.org> <CAHJ8P3+mo+yT8wfv2Xd3Rb7sFtXufmOgh_6CLzZxM5CjtYWC2Q@mail.gmail.com>
 <2f52570e-da77-40f3-a886-2ee76059fc6b@kernel.org>
In-Reply-To: <2f52570e-da77-40f3-a886-2ee76059fc6b@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 15 Mar 2024 11:29:57 +0800
Message-ID: <CAHJ8P3J=RsQikjMpEEO_nw5cMdp1kYKerMOdp=wGbhC5bi+Dfg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: add REQ_TIME time update for some user behaviors
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 11:07=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/3/15 9:46, Zhiguo Niu wrote:
> > On Thu, Mar 14, 2024 at 9:06=E2=80=AFPM Chao Yu <chao@kernel.org> wrote=
:
> >>
> >> On 2024/3/13 12:11, Zhiguo Niu wrote:
> >>> some user behaviors requested filesystem operations, which
> >>> will cause filesystem not idle.
> >>> Meanwhile adjust f2fs_update_time(REQ_TIME) of
> >>> f2fs_ioc_defragment to successful case.
> >>>
> >>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>> ---
> >>>    fs/f2fs/file.c | 9 ++++++++-
> >>>    1 file changed, 8 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>> index 4dfe38e..dac3836 100644
> >>> --- a/fs/f2fs/file.c
> >>> +++ b/fs/f2fs/file.c
> >>> @@ -2784,7 +2784,6 @@ static int f2fs_ioc_defragment(struct file *fil=
p, unsigned long arg)
> >>>        err =3D f2fs_defragment_range(sbi, filp, &range);
> >>>        mnt_drop_write_file(filp);
> >>>
> >>> -     f2fs_update_time(sbi, REQ_TIME);
> >>
> >> I guess we need to call f2fs_update_time() here if any data was
> >> migrated.
> > OK!
> >>
> >> if (range->len)
> >>          f2fs_update_time(sbi, REQ_TIME);
> >>
> >>>        if (err < 0)
> >>>                return err;
> >>>
> >>> @@ -2792,6 +2791,7 @@ static int f2fs_ioc_defragment(struct file *fil=
p, unsigned long arg)
> >>>                                                        sizeof(range))=
)
> >>>                return -EFAULT;
> >>>
> >>> +     f2fs_update_time(sbi, REQ_TIME);
> >>>        return 0;
> >>>    }
> >>>
> >>> @@ -3331,6 +3331,7 @@ static int f2fs_ioc_resize_fs(struct file *filp=
, unsigned long arg)
> >>>        if (copy_from_user(&block_count, (void __user *)arg,
> >>>                           sizeof(block_count)))
> >>>                return -EFAULT;
> >>> +     f2fs_update_time(sbi, REQ_TIME);
> >>
> >> There will be no further IO in the end of f2fs_ioc_resize_fs(), so we =
don't
> >> need to update time to delay gc/discard thread?
> >>
> >>>
> >>>        return f2fs_resize_fs(filp, block_count);
> >>>    }
> >>> @@ -3424,6 +3425,7 @@ static int f2fs_ioc_setfslabel(struct file *fil=
p, unsigned long arg)
> >>>        f2fs_up_write(&sbi->sb_lock);
> >>>
> >>>        mnt_drop_write_file(filp);
> >>> +     f2fs_update_time(sbi, REQ_TIME);
> >>
> >> Ditto,
> > Dear Chao,
> >
> > The two parts you proposed should be similar to the below scenario?
> > ---------------------------------------------------------
> > static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned l=
ong arg)
> > {
> > struct inode *inode =3D file_inode(filp);
> >
> > if (!f2fs_sb_has_encrypt(F2FS_I_SB(inode)))
> > return -EOPNOTSUPP;
> >
> > f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> >
> > return fscrypt_ioctl_set_policy(filp, (const void __user *)arg);
>
> fscrypt_ioctl_set_policy() will dirty inode, so we need to keep
> f2fs_update_time(), but it's better to update time after
> fscrypt_ioctl_set_policy()?
>
> Thanks,
Dear Chao,
agree all your suggestions. thanks a lot.
>
> > }
> > -----------------------------------------------------------
> > thanks!
> >
> >
> >>
> >> Thanks,
> >>
> >>>    out:
> >>>        kfree(vbuf);
> >>>        return err;
> >>> @@ -3597,6 +3599,7 @@ static int f2fs_release_compress_blocks(struct =
file *filp, unsigned long arg)
> >>>
> >>>        filemap_invalidate_unlock(inode->i_mapping);
> >>>        f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >>> +     f2fs_update_time(sbi, REQ_TIME);
> >>>    out:
> >>>        inode_unlock(inode);
> >>>
> >>> @@ -3766,6 +3769,7 @@ static int f2fs_reserve_compress_blocks(struct =
file *filp, unsigned long arg)
> >>>                clear_inode_flag(inode, FI_COMPRESS_RELEASED);
> >>>                inode_set_ctime_current(inode);
> >>>                f2fs_mark_inode_dirty_sync(inode, true);
> >>> +             f2fs_update_time(sbi, REQ_TIME);
> >>>        }
> >>>    unlock_inode:
> >>>        inode_unlock(inode);
> >>> @@ -3964,6 +3968,7 @@ static int f2fs_sec_trim_file(struct file *filp=
, unsigned long arg)
> >>>        if (len)
> >>>                ret =3D f2fs_secure_erase(prev_bdev, inode, prev_index=
,
> >>>                                prev_block, len, range.flags);
> >>> +     f2fs_update_time(sbi, REQ_TIME);
> >>>    out:
> >>>        filemap_invalidate_unlock(mapping);
> >>>        f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >>> @@ -4173,6 +4178,7 @@ static int f2fs_ioc_decompress_file(struct file=
 *filp)
> >>>        if (ret)
> >>>                f2fs_warn(sbi, "%s: The file might be partially decomp=
ressed (errno=3D%d). Please delete the file.",
> >>>                          __func__, ret);
> >>> +     f2fs_update_time(sbi, REQ_TIME);
> >>>    out:
> >>>        inode_unlock(inode);
> >>>        file_end_write(filp);
> >>> @@ -4252,6 +4258,7 @@ static int f2fs_ioc_compress_file(struct file *=
filp)
> >>>        if (ret)
> >>>                f2fs_warn(sbi, "%s: The file might be partially compre=
ssed (errno=3D%d). Please delete the file.",
> >>>                          __func__, ret);
> >>> +     f2fs_update_time(sbi, REQ_TIME);
> >>>    out:
> >>>        inode_unlock(inode);
> >>>        file_end_write(filp);

