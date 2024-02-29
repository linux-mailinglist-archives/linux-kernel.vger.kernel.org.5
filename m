Return-Path: <linux-kernel+bounces-87196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAB986D0F7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6261F260C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516D570AF0;
	Thu, 29 Feb 2024 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdJa1KYl"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3332B1EB42
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228506; cv=none; b=jHZ7/YyA0RmTAfBNhzJyfB1mQQY9vErVLWPJ2ZkylA26fJiVhNNJOMsrPBBzuJhWlkpd3ikeflADmBJCIIPy9HTSNScdxnJGS1UiB4HUGwnd7ENM6Y6k0tlc8kKc7YCxFosd19T6n+wwVlRH7GM5osx2wkFnEdjiNz3NxQdvwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228506; c=relaxed/simple;
	bh=zLNwrlweK1rH+IGDxdX7Ha/joeC9kP6INrjxLOdzz8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPBfHF0zb//jS+ai784rsQnVmW+Vvdm5yxzUX5jb/BYcZ0xx3VYkBxflvo105uE8+HzMo1ozGMuMxncUbng9k13PgrkgG8/VlJBMeNIhApRJKUEDdIE/YxCb1Wz1jczlEiW3FDkzsHU+d8S6j9gBc1ALgwH6SYwHoyCZQWJRbIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdJa1KYl; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7da6e831958so309635241.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709228504; x=1709833304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2olijefr8r2GLBicKoERyrJ4GIhxgDek+nU7uJKZm0=;
        b=QdJa1KYlpI50YYwKymh02OG/JKRCCZZsxsjss5czw7UOgPul+m2UyMBuyueySDt35R
         zDExesE2gSs0/t9qzmDOClaD4vEvErm2ICwM1+B6vLPEpYRcsF2fnQtiHgn+457XAjkN
         ydVRD07yERO3a59REGCoeMgckNFXH0JouXaUoM7OMntlXv0hvwPpI0fKGlUhg/r7Emdm
         kRVzVp67ryNkzSxiVjXEuBAXRFHV75+C0r+kRwBQUfszZyW4abv2Fwl9eRLCavgk73IG
         DffaMWcvKyOgHeG//HLWDrSXJAFXmcBoqqcbbmW4pJGF4XNAA00Rk1TeCCIf4Rp3Fb85
         qkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228504; x=1709833304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2olijefr8r2GLBicKoERyrJ4GIhxgDek+nU7uJKZm0=;
        b=ZSGILKWrDLndFU7LXXYUkvPMUFxxep1IRdtiG5iiVd3+Pzz4M0EqRkL0vNrvfCerk7
         8ka4Jh6x0+z5JuAGTq3wF3lu3QAXBUlY9yq34L+HJ+Mj4QmfSxs7xGX2wXp3nLdOkV4l
         pmpws8JI7b3QvymiEdujf6f2KyawzDGG2cOYdsk+zeRmGyO9HiGTD0k/vBBJQYJMwQB4
         pHkOkJ2C0H8lQa6WD5VALugyQuVR5BMl+lY1MnkVWyoc31/1BpJ8f88QqVb748E9ZpJ2
         k5Jt1tI9BB7mZ4saRKJE0HAm/7VHye7j38wwylSgBnB6B0sv6joIwLJs4cbmDRds+s9J
         qzNA==
X-Forwarded-Encrypted: i=1; AJvYcCXU/ryqz4REMlL3NRNxMZ6VaNOEJmxlMkbeCpqiaIW+DdYLknBHicPNYnpC0jvuI39J50Oo9rjAHwKhlrZ25A0bjyHNYsKwy8Gj5rnq
X-Gm-Message-State: AOJu0YyCXZAB2sSidC5o2GiitcoHVFj157uG5hLDMf3Z8ppAQfc282f/
	PCDGylEkSxtGsTGtcaJeb90RNqtXcuwM5VW/hpTnvqe4Cd4swRVKL/1mA/b4fxleXJXGsKKvRTU
	Mb02aIkij83v214sFNH3F/sFgSOeJl4jcWBA=
X-Google-Smtp-Source: AGHT+IFwrxCvB48fqi/4yOhBcW29D5X9hpeOX+z7SzntXypJfSFeSHLD3FRq+DIAQVjUd0rx+LKUd0d/lHXlwxFquLk=
X-Received: by 2002:a1f:e483:0:b0:4cb:56c5:5818 with SMTP id
 b125-20020a1fe483000000b004cb56c55818mr2651057vkh.3.1709228504059; Thu, 29
 Feb 2024 09:41:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226013208.2389246-1-chao@kernel.org> <2b81aa6f-db51-4a7c-97ab-2af2c2fea056@kernel.org>
In-Reply-To: <2b81aa6f-db51-4a7c-97ab-2af2c2fea056@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 29 Feb 2024 09:41:33 -0800
Message-ID: <CACOAw_yn4m+nEGMEX8RL1xFEaZpzXvjUhUdSoo9d2EeGfzPrAA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: fix blkofs_end correctly in f2fs_migrate_blocks()
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:11=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> Jaegeuk, Daeho,
>
> Any comments on this serials?
>
> Thanks,

No functional difference here, since start_blk is always aligned with
the section address.
However, this is more clear in itself.

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks,

>
> On 2024/2/26 9:32, Chao Yu wrote:
> > In f2fs_migrate_blocks(), when traversing blocks in last section,
> > blkofs_end should be (start_blk + blkcnt - 1) % blk_per_sec, fix it.
> >
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > ---
> >   fs/f2fs/data.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index c21b92f18463..0c728e82d936 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -3841,13 +3841,14 @@ static int f2fs_migrate_blocks(struct inode *in=
ode, block_t start_blk,
> >       struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> >       unsigned int blkofs;
> >       unsigned int blk_per_sec =3D BLKS_PER_SEC(sbi);
> > +     unsigned int end_blk =3D start_blk + blkcnt - 1;
> >       unsigned int secidx =3D start_blk / blk_per_sec;
> >       unsigned int end_sec;
> >       int ret =3D 0;
> >
> >       if (!blkcnt)
> >               return 0;
> > -     end_sec =3D secidx + (blkcnt - 1) / blk_per_sec;
> > +     end_sec =3D end_blk / blk_per_sec;
> >
> >       f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >       filemap_invalidate_lock(inode->i_mapping);
> > @@ -3857,7 +3858,7 @@ static int f2fs_migrate_blocks(struct inode *inod=
e, block_t start_blk,
> >
> >       for (; secidx <=3D end_sec; secidx++) {
> >               unsigned int blkofs_end =3D secidx =3D=3D end_sec ?
> > -                     (blkcnt - 1) % blk_per_sec : blk_per_sec - 1;
> > +                             end_blk % blk_per_sec : blk_per_sec - 1;
> >
> >               f2fs_down_write(&sbi->pin_sem);
> >
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

