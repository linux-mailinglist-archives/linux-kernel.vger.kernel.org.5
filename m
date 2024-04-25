Return-Path: <linux-kernel+bounces-159147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCC78B29E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D38F1C21A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE346BFBC;
	Thu, 25 Apr 2024 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdTGFzzj"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5F02E642;
	Thu, 25 Apr 2024 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077246; cv=none; b=eFL2J/5i+xGxSaEyktT9n04CDf8vSHVEocEDGENmvJhJ4zHzORj3arX9n1Wsk3KS0lpym4HBzYOVs6xrKN5UcKXTiTIOQmzsJ1zOG09MX9vvOCdlEyCYkmde0FdF1tnRaD3aehju8Wpn7vqXalOWOUtullq3MlnOs+BgD/7F/VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077246; c=relaxed/simple;
	bh=Nyj6zBYMZcndQ5jCfv8eLMmMnJKfWlXatXtEJboMryY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iooC4iUha2AIOpgpQeJY31U30BLTNIxwsg9Q2K+brL4QlajytSyQj1nBOHPgkfo8MhqWyumpJvaYvj0m89N2usFTD0wZUZxbVdgCb483Ejwzp/WXcCQMmb5Oajas5JDQZD0h8wPORJxjAeYpx1uiylZ71Jc+Nv+RzsgL9wdUP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdTGFzzj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso2234285a12.1;
        Thu, 25 Apr 2024 13:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714077243; x=1714682043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nyj6zBYMZcndQ5jCfv8eLMmMnJKfWlXatXtEJboMryY=;
        b=YdTGFzzjVDEFzHHrN/GoNe1qCY9rCxQqfLaMxkLd8gV/xeN6Hqi1XMIRRcdy9K24oG
         Tb0qwszVviplWWJGWy0pkKBLiJ8lm6xv/FVVzWGwPFgMtdnXIo7at2agla9jgAR+0eA0
         BVGUkwCQv6IWWfQne2FWAKCXaxtSLamtqfHLTQsM2rslh1/6bpSHo96pLPTsAfS0H9m1
         0GAfX/HmJ1n8vkkcEkjvn5g17yKcOEv0lw+Du3NrCCqJKQi2ZuLkh5MrBQlG1/RgOTDy
         ELwN8F0RdCa2DiZD2JTRTMdqBSllBx7vX8QNPuMy56Zuv5b7UyXkU9++JTSmBnqtMVKs
         tSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714077243; x=1714682043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nyj6zBYMZcndQ5jCfv8eLMmMnJKfWlXatXtEJboMryY=;
        b=P1HJ4y+MtBA9qGsx5Wo26qEjH7KOYxaaBNZy4FcQ60JulAfISqjPE823pv6HVJspNu
         Rf5yp2OHbQf6YeL3HHqJDj4Kc3eeFjfR9KTXMhATE6WaYRrqDFU64kENyazQZykrjvCT
         jclMufFYc8WLXZZKpQWygavIa5j7eMcJYC9REwFftu2I+eHawzOFWPczdhJEjJy1wgPg
         bvmizccgeQJQPFL3iuPAWVQaJjnBJ1UgDrdoj0hTvAeQRDobTStkAddyI1OQ84BUkSlR
         RA9GcsPQakccCJdjdkOwMzO6vTliiaMUtDz9UZsrhk8SYpNBZyPrvePO5meFKV5zX3CZ
         72LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDtTOw4Ewd2lsLXQ6OmfjjlBah1HPOY+NPoQejkK61j6q62vrTpCnKecLznPPsYo+LibYDrJS66ckx1jKotdrMpU5mVKAuo53F5rOjUdfGIWIXcTCcmARvRBFWGO6L4TBghJV+4gse
X-Gm-Message-State: AOJu0Yz/L6K8IGKoBav9/h3ErxW5+xVwP3KqE74uRQFomCwrl2pKbk3a
	Hp9iKWP4SdGc2DjBkbTT/gXdCsOO3zJQUvY1Vy4uQ93tanXuPqQSH7JreoaDnbc68Y5Ih9KRluG
	UEcBBZ+HmtQyK5M4SnwiGeM7Vn2CqSA==
X-Google-Smtp-Source: AGHT+IHVh9Ds7XYM2RoEvKur8faoUssSA/evOZjxR2fpEhQmQ+zeUj7yNLurL0BPctMhsE3ker7vbCbwppB7hvOFKhE=
X-Received: by 2002:a50:d75d:0:b0:56e:42e0:e53c with SMTP id
 i29-20020a50d75d000000b0056e42e0e53cmr498852edj.34.1714077243214; Thu, 25 Apr
 2024 13:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jz0X=CKR1POvF41oEumrq1z=MVWPdF2ECbzV6-rhht8-g@mail.gmail.com>
 <ZiGYbJezGZg6tGgq@dread.disaster.area> <CAJg=8jycPX=fQskUb=48g=AS7-uUNAVKZyZ+tyAC5uGYwfpabg@mail.gmail.com>
 <ZiWl2MG5f0wAp7mM@dread.disaster.area> <CAJg=8jyZuxsUX+oNU6O_L4LNOVs21xVKTDi8ywPfDbj+cAxegA@mail.gmail.com>
 <20240424034232.GD360940@frogsfrogsfrogs> <CACzhbgSdDBzTyqc3ci17U2DG8GKo=Fq=H3c+eTM7J5u_Xh2QmA@mail.gmail.com>
In-Reply-To: <CACzhbgSdDBzTyqc3ci17U2DG8GKo=Fq=H3c+eTM7J5u_Xh2QmA@mail.gmail.com>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Thu, 25 Apr 2024 13:33:51 -0700
Message-ID: <CAJg=8jw=D5kVL6ETwm5EMias4rgUKfEg2H9dLUgesqf1wq7evw@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Write in xlog_cil_commit
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, harrisonmichaelgreen@gmail.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leah,

Thanks for your response!

I can reliably reproduce the issue, so I'll try to create a patch and
let you know.

Wishing you a lovely day!

Best,
Marius

On Thu, 25 Apr 2024 at 13:31, Leah Rumancik <leah.rumancik@gmail.com> wrote=
:
>
> Hi Marius,
>
> Thanks for the bug report. If you can reliably reproduce this issue
> and can provide a patch which fixes it, I can add that patch to the
> next set of 5.15 backports. I am a bit limited for time at the moment
> though and trying to work on the backlog of backports into 6.1.y as
> well, so I am not sure what the exact timeline would look for a 5.15.y
> set yet.
>
> - Leah
>
>
> On Tue, Apr 23, 2024 at 8:42=E2=80=AFPM Darrick J. Wong <djwong@kernel.or=
g> wrote:
> >
> > On Tue, Apr 23, 2024 at 08:05:22AM -0700, Marius Fleischer wrote:
> > > Hi Dave,
> > >
> > > Thank you so much for your detailed explanations!
> > >
> > > > > Do you think it would make sense to backport that patch to 5.15.1=
56 (the
> > > > > LTS kernel)?
> > > >
> > > > That's up to the 5.15 LTS maintainers to decide. They also need to
> > > > weigh up the fact that xlog_cil_kvmalloc() doesn't exist anymore in
> > > > the upstream code base. i.e. we found other places that had the sam=
e
> > > > kvmalloc() performance problems, and so lifted that code up further
> > > > and used it in other places in XFS....
> > > >
> > >
> > > Understood. Please allow me one last follow-up question. Did I add th=
e correct
> > > maintainers/mailing lists to reach the 5.15 LTS maintainers? If not,
> > > how do I find
> > > the correct addresses? I used scripts/get_maintainer.pl as suggested =
here
> > > (https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.=
html)
> > > to locate maintainers/mailing lists.
> >
> > You got it correct -- Leah is the 5.15 maintainer of record.
> >
> > --D
> >
> > > Wishing you a lovely week!
> > >
> > > Best,
> > > Marius

