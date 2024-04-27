Return-Path: <linux-kernel+bounces-161152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3B08B47B3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E3D1C20CA5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6C644C88;
	Sat, 27 Apr 2024 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMy1wOW+"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E935017C96
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714247462; cv=none; b=ohl5+kv7Gu4+Ysis/52mIdVTHm6MfhFwrBKSy/flMWvYv9qiAazrvSOghquxUH0XImASZHH6DSyjPjOxhXnPWXSIjcgxr1t1dM/kmqPOxx2iq7d84zOJK4UTZ94GNkAxuTCR+Uh/FmVuWjIsFOP4xLostpHy76rqCN9lrCOACKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714247462; c=relaxed/simple;
	bh=1vsosJBKgv5N1iIGtdZokDSg5iYoOImnmDW8Lg3/+fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKEBdtkx97YMBEYxnO9Wo/irwFvP/+gfGP59tK5SmB7y9gePqtosWh46hDosc0OXAwhI9Zs1STQLHTmLACCWfqJEIA/EguEr2sW/Pqreuv//QHlpS6EDWRSyM7Kls7lEZfMzz/vg2//Ju7KqhUUaswmcW278+GZgO9hP3seCQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMy1wOW+; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7f06c86bf87so101278241.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 12:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714247460; x=1714852260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mx+TZI+AhJhXc5nDbpJ3HSmPLnjW2+afsuYEIVpKobg=;
        b=IMy1wOW+MKl7zwpL0YGQ/x1bVvxY5WDDrl3yPAVG7rCuSEBOErtMhVCnLsobkEcPvR
         u0H67wUpELphW4RrUqvoFKHUrPbVS5BC6k2O3bfvBY31TCdrphDPL0HGtt8CfpKcOMJ/
         75AeguncGQ6x/CGdL7045G0y2ge52FcbnPY2lIy1mFEdllryijdGpeWPv50rJUTXx9NW
         ATvz1Tp4+SzxePX9KzbMhnJpe3/oL4SlViYKPcG+i8NEX/1lkNVs7scaF9xqySUloVFC
         1IJppZTCVcgjIZ4YGjNg6Vzm9Rwso06Wm4rO0Kf5OGGdQ+mctM+HH1pDM4Gsclytzpqx
         7oTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714247460; x=1714852260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mx+TZI+AhJhXc5nDbpJ3HSmPLnjW2+afsuYEIVpKobg=;
        b=BpurMf5G1+BxhtNwV219xqo5MwLK3wyjPZbVpwXisHR7qVAEaOKlEuEOKQP61DZ/t8
         LQnNzAlrFhO9hDHPif3FCX//lnGwSAjSuuBIC13Ofl2FvSM5Rzdc0FpcK8IGuK4d63pi
         i4/WRZpl8HgaqYgEdbbl1hbXbjIV4I5vyDn38+jp0z3ZHMUbdMqX0rBTpzi0wOwENPSd
         X0G+G+WDxNXmJSj67c2zM5AtP+I8iYFL4IVZ4s4zqXJE1nqShBrPi9iA2FlZQzJX14Mu
         IpMPwGzRoG2cSi9yUU9CKefAzWd49O43IgbL5rQ2VDve8nUjNtSCKkssVrNMKZSteFb9
         UIWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEkEwi6PC5zOlIF5LiYRxqZ2lNOkBjf04EGtwHRNpUtV37YKt/fAjiDAReCIqx6lckwPIYv0miyVKpW/s9ueYJFaoD3ledrv+h3yfr
X-Gm-Message-State: AOJu0YyzONZFhO5H7Os2hB15e+T4Jli4U6wQN2WQwTVIUcnh9MI7//Q0
	H7U9NmYSVhthtnke0RlNt60RVGXWSs4OIR4F29giqGG7/VnuPJZeCQ/FeY6So/Bvy3ftnr9vqDU
	F/mKDfBI+Ep7JZQLnJwtJohqjWs0=
X-Google-Smtp-Source: AGHT+IFkMsW89n1NQE8ZtjKKjwlrH4uCQQHVEgxNy01+vSTtZrZ2k22q04dE2BBrobvMdnaVsTw+xerI/NTKXm+2ao0=
X-Received: by 2002:a67:e8d1:0:b0:47b:fe0b:a92e with SMTP id
 y17-20020a67e8d1000000b0047bfe0ba92emr6582019vsn.16.1714247459742; Sat, 27
 Apr 2024 12:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426103528.406063-1-chao@kernel.org> <CACOAw_xiC08JTanBSLaBED8_zveCEhoaDWeJ3YVU0h9+dNkQUg@mail.gmail.com>
 <a08a091b-78d1-4fb1-982c-c51d9dff8f06@kernel.org>
In-Reply-To: <a08a091b-78d1-4fb1-982c-c51d9dff8f06@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Sat, 27 Apr 2024 12:50:48 -0700
Message-ID: <CACOAw_xuX-J=J5zYwK5kVxPGZWPa+KXBxQA2i-taPwzS2ds-aQ@mail.gmail.com>
Subject: Re: [PATCH] f2fs: zone: fix to don't trigger OPU on pinfile for
 direct IO
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 6:49=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/4/26 22:14, Daeho Jeong wrote:
> > On Fri, Apr 26, 2024 at 3:35=E2=80=AFAM Chao Yu <chao@kernel.org> wrote=
:
> >>
> >> Otherwise, it breaks pinfile's sematics.
> >>
> >> Cc: Daeho Jeong <daeho43@gmail.com>
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >>   fs/f2fs/data.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >> index bee1e45f76b8..e29000d83d52 100644
> >> --- a/fs/f2fs/data.c
> >> +++ b/fs/f2fs/data.c
> >> @@ -1596,7 +1596,8 @@ int f2fs_map_blocks(struct inode *inode, struct =
f2fs_map_blocks *map, int flag)
> >>
> >>          /* use out-place-update for direct IO under LFS mode */
> >>          if (map->m_may_create &&
> >> -           (is_hole || (f2fs_lfs_mode(sbi) && flag =3D=3D F2FS_GET_BL=
OCK_DIO))) {
> >> +           (is_hole || (flag =3D=3D F2FS_GET_BLOCK_DIO && (f2fs_lfs_m=
ode(sbi) &&
> >> +           (!f2fs_sb_has_blkzoned(sbi) || !f2fs_is_pinned_file(inode)=
))))) {
> >>                  if (unlikely(f2fs_cp_error(sbi))) {
> >>                          err =3D -EIO;
> >>                          goto sync_out;
> >> --
> >> 2.40.1
> >
> > So, we block overwrite io for the pinfile here.
>
> I guess you mean we blocked append write for pinfile, right?
>
> >
> > static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter=
 *from)
> >
> > {
> > ...
> >          if (f2fs_is_pinned_file(inode) &&
> >              !f2fs_overwrite_io(inode, pos, count)) {
>
> If !f2fs_overwrite_io() is true, it means it may trigger append write on
> pinfile?

Yes, I missed it. Thanks~

>
> Thanks,
>
> >                  ret =3D -EIO;
> >                  goto out_unlock;
> >          }
> >
> >
> >>

