Return-Path: <linux-kernel+bounces-79850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4F7862796
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4CF1F21DC4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C15171AC;
	Sat, 24 Feb 2024 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzPLYyAD"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9048C2907
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708806819; cv=none; b=LI1GQFWZyWw8IFp8K9kzLaMaSP1XQk5yL05ev3OzR4cgPJtGVVwPfyGyKebdRgUo2gfueSjA+RqMxJd+HO9TDJuwrlCVASE0uSRBEyWVBAlax5N9TdB3Tt9QFaSwyXT/zqnhYXxAcWc7iYE9N+YIrzEA7OyQz3GuZ4wdLX8Lzbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708806819; c=relaxed/simple;
	bh=9oS3KrPJR07eSxCrD6jaIgwpwSu3635rB9ytLH2uYY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpDTWlhYyd08VfmqOOXE3VM5WnoDeEPJlw3MCj5dkyMSD6HkLSs3sXmcfLLSTV+NF8SbCS12RHo1GUhp31Vxh05fFgWkl5K3aci7Vi5zYsUCHJiAeD4o4IS9VlZy8yq1kBfkmuVLGg9EDtztiNCHgNnLJP1VrFos5x0ebcmLUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzPLYyAD; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso1598800276.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 12:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708806816; x=1709411616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcEB/B/u9FuYrsGK1/CrqSDGAOGwcMBuWBx3Xthh5/I=;
        b=lzPLYyADpUKvr3PZLCliRmY8oXjTNbpiTNT4i3Qh4pUpEw6nmROsOwlDrzA7uRQUFK
         9basFJS2rogs9vEgvQesRYb2vgtB0ZVBWZo5pYNdx2W9nc58j7f5ye1UwG3o85E5NIGX
         AKvRsN8Ppd9kEZzLDHvlA+M1pHk9nGmMyGRkzRYbFPWoapYNqH+qONo7nU4uieTQj5W8
         EWYGILUtRSXi1UrnLOLNBKTjtCahiWoTuWS9XCgMinsKyBAMRyaurGFZ5e7nYMtFif5q
         8pto0Zp0pTUJfZJHz8XasgvflUztVctb9t/EEwz8aHcnm53IGGsjSHrCLJMG5KM/QEe0
         g+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708806816; x=1709411616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcEB/B/u9FuYrsGK1/CrqSDGAOGwcMBuWBx3Xthh5/I=;
        b=bQBs2NdQzGD12vDjEE0NhZhLUCraFSHimujAn+nraGEGVuk5bEJGK2c0UN6+KrCCiX
         D93v4sniC8CY8wdPUAbYs26FL42tR0cYh+oHedZcqzLnSbFghsxV2mfWrFML033uHhfJ
         qqDem5HJvO/ezDW37Ux+sHpx15D0tfrS6frSYFOn5+E+a/Gm+GYFKYNRPJWUy4B2V35m
         2ppd6xaxevd60aoONshJWvJDbN6wMEQ8Ax0nKf8DzlKPj2wTDQzMUYykLT+LwI6yMqNW
         sVlgCLwbEXM5IslR7OEPzSmzfzIxJmMfuTUyhgIhgpP2yn5YomhIaePRjRAE6KURZ7ra
         i8dA==
X-Forwarded-Encrypted: i=1; AJvYcCVZXZ798J1hGTwxeWecrx0wWAdmRl+RDFyd+DmmisUIWAu6R9XSF2rFsy0CBk+/TV6RZjXlxv5X7USzPE/ZLjJ6/+oUGpG1ceGZI8uQ
X-Gm-Message-State: AOJu0Yxm618rzURCIjp90XHStuLskbuFuJTg9JjVwAH/hzZXgItXNrNL
	IRigWZyR2JZ6NaDg3/5pEprI//yn1j+g5nE5XdOv6Po41dmZybeYB06QCpF8rMRJSeVgNjtpuY+
	XET8/Oq7azE/wEbSyD9aSAckp1OXTFQffnw1N6g==
X-Google-Smtp-Source: AGHT+IHVYeG4sdxyYLY07ymIs/jw3wT3riBpDFnsIG97UyYCih8PQUJ+OgjP21HKGNOKC9IYaojcfsNRV1cDDc/ZQPY=
X-Received: by 2002:a81:9957:0:b0:608:7c7e:9d59 with SMTP id
 q84-20020a819957000000b006087c7e9d59mr3149810ywg.38.1708806816591; Sat, 24
 Feb 2024 12:33:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224190724.45681-1-sj@kernel.org> <20240224201221.46450-1-sj@kernel.org>
In-Reply-To: <20240224201221.46450-1-sj@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 25 Feb 2024 04:33:25 +0800
Message-ID: <CAGsJ_4w4wnbryJaAKRtNGNMg_YTGkeG3QwL9_JkT=wtwq1+_+Q@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than
 clearing young
To: SeongJae Park <sj@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>, akpm@linux-foundation.org, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	hannes@cmpxchg.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 4:12=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Sat, 24 Feb 2024 11:07:23 -0800 SeongJae Park <sj@kernel.org> wrote:
>
> > Hi Barry,
> >
> > On Sat, 24 Feb 2024 12:37:59 +0800 Barry Song <21cnbao@gmail.com> wrote=
:
> >
> > [...]
> > >
> > > BTW\uff0c
> > > Hi SeongJae,
> > > I am not quite sure if damon also needs this, so I have kept damon as=
 is by
> > > setting ignore_references =3D false.  MADV_PAGEOUT is an explicit hin=
t users
> > > don't want the memory to be reclaimed, I don't know if it is true for=
 damon as
> > > well. If you have some comments, please chime in.
> >
> > Thank you for calling my name :)
> >
> > For DAMON's usecase, the document simply says the behavior would be sam=
e to
> > MADV_PAGEOUT, so if we conclude to change MADV_PAGEOUT, I think same ch=
ange
> > should be made for DAMON's usecase, or update DAMON document.
>
> Thanks to Barry's nice explanation on my other reply to the patch, now I =
think
> the change is modest, and therefore I'd prefer the first way: Changing DA=
MON's
> usecase, and keep the document as is.

Hi SeongJae,

thanks! I actually blindly voted for keeping DAMON's behaviour but
slightly updated the
document as I set ignore_references to false for the DAMON case in the RFC =
:-)

--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -249,7 +249,7 @@ static unsigned long damon_pa_pageout(struct
damon_region *r, struct damos *s)
 put_folio:
  folio_put(folio);
  }
- applied =3D reclaim_pages(&folio_list);
+ applied =3D reclaim_pages(&folio_list, false);
  cond_resched();
  return applied * PAGE_SIZE;
 }

MADV_PAGEOUT comes from userspace by a specific process to tell the kernel
to reclaim its own memory(actually focus on non-shared memory as it
skips folios with
mapcount>1).
The range is a virtual address and the app does know it doesn't want
to access the
range in the foreseeable future.  and the affected app is itself not global=
.

In the DAMON case,  it seems the range is the physical address.  if
the pa is mapped
by more than one process, it seems safer to double-check in the kernel
as it might
affect multiple processes?

Please correct me if I am wrong.

>
>
> Thanks,
> SJ
>
> >
> >
> > Thanks,
> > SJ

Thanks
 Barry

