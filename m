Return-Path: <linux-kernel+bounces-82839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978D7868A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE8A1F24E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA77C56458;
	Tue, 27 Feb 2024 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGu/0dR9"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4502B55E57;
	Tue, 27 Feb 2024 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021103; cv=none; b=GRx6XUJ3abBQx/6GEpEn4II5iyl8NXzgBVX+Bs/1HNd8gNnbfksOrDvKgkrg3xEGUVzaXnza12lYFsDYXUG1KcwXk8UYDnm92jZejiSKWmWxwW9KBGkBGnXFt3U+qxyUh6me4K/YXpQeK1fVUuUgpN9KsWCbjJxtRMR+9JvQwws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021103; c=relaxed/simple;
	bh=dLc6qzpdn0QcbWH35jBWzBShMzWwsYYOLtQdcDNpS08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/Nz7Irf/5UeFpWxgwN6THAs1djuvKz3Boj+istMyblBbC/GZ6msm97csNZEhpQcvI+zrbRFS2WfyauAavlrsqo1sRp5HOHbBA5OQBVZFOvjY7X/xuHX9Jfxa5zymK+0YzGtne45ydlS+HYL5iufDt/imQ0HAUSN73+f7UDqCus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGu/0dR9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5656e5754ccso4902155a12.0;
        Tue, 27 Feb 2024 00:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709021099; x=1709625899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IQYfg/jEbKsFfnP7Ml8GxrhHj0pSAVN9Eix4gdEtcY=;
        b=AGu/0dR97o7ALNRJBJIjtnL5ZqtzEjPFZqxQK5A/DUANqvjIQxm+fenlNu4NEdeVc1
         56S+zMHoyyW5ZbXoxyb5HKhJndiV3J+ZH2onDEbXYh5bmHWyYU0rUTy/GwNXBPNRgtoz
         waToFSeg1FMvCP8J8bgMnQI8Sgly6DRls3/iIynK2sCQtNhSUyB7LO5+ZYuljS9EBHNZ
         N0EglxP1KNIIA53u0yMJTvAzHqY2or9DgHoz9+pzEdVvPCIgIfrhB1g5UzhiHf6cPuSi
         gTV9wusuJpdOLIzdTIwSLvEVn0UoN6hyu2ENvlJEYa9qOgb86zNjsN2U/Bbfwi2lCywz
         6mdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709021099; x=1709625899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IQYfg/jEbKsFfnP7Ml8GxrhHj0pSAVN9Eix4gdEtcY=;
        b=td+t7iXRDl8Jd9pD7qFLHY6utvGj7ErOrrFSOtq3oe+Lrv4bur02JKCgkVn7Khiqc3
         0Zk9pxSkzIqAJsoqnSvHR0QAQma1Auf/1Hq5fIHoKDFFx23fSIr57XU1aIsiTEtxajFm
         z0AQ3oeoroCOPostDJbwskdG6VEhD8Sr2z8pCHX25kNfpEfofl+GrnlrDhdwhF75Tlks
         LdkKlKJhyOFenW2y5roRWrf41JZMnkV4yRs92OZ1bFgfAs4JgAn59j7KafTPGdmeXKhG
         quZQOUBVSYbtmPlKaqa2uzPOt5GHcRAYxFGUUibLHCr9yVVDH0wFRA5WtvwQNsj5ZdQ2
         dr2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIKMOe3Dtv5e0O3XhROtOWNFCMDCH5VnjBXk0wvluiR+UBMop3YEvrhxvG5cHBUJidWXfr5eE3lTN0QiG+Qon0D0V877R/GwaAtfaWofqF2f2CmhXnoMWgTgfmfpqT1SaNjtGN00q1wrJaGq9v2nfTVMCwUoEwyT8B1lxJ9dyflU75BDKo82a65E/f5zaxkebBLkGfvMxHreEHY3SA1t+5KqO4
X-Gm-Message-State: AOJu0YzU+Iay7eir6jpjxAgYXFkfupFH/gNVjCyKiV7i1Jn8Xu0H4pjY
	OnnMeTl9LfOIUjbPidHerCnoYWW0GwnCOfM1jWKWP6xD0aEh+i5DRSNU8eeFehu9Q2FI1ZlWkKu
	dsbgTjn02EFbrHeqiPiJQ5u49xts2tNLxP2OQmA==
X-Google-Smtp-Source: AGHT+IFlufugla77dD0j6LnZaS9EwyRoI4OBtOt4iPjnpLBqDX7T/t9hkHQLyVLsNt3OF+TRgbh8PTkCNXKpThlby/o=
X-Received: by 2002:a17:906:5fce:b0:a3e:73c9:7acc with SMTP id
 k14-20020a1709065fce00b00a3e73c97accmr5824341ejv.33.1709021099415; Tue, 27
 Feb 2024 00:04:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226104653.54877-1-lukas.bulwahn@gmail.com> <43df625f-bd32-4dd9-a960-6d0f5c0304c7@infradead.org>
In-Reply-To: <43df625f-bd32-4dd9-a960-6d0f5c0304c7@infradead.org>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Tue, 27 Feb 2024 09:04:48 +0100
Message-ID: <CAKXUXMxSnEEYCtvxVN6Z_QuDTEpLiq=Zsz+=g=kNzwKuLeH=Pg@mail.gmail.com>
Subject: Re: [PATCH] docs: submit-checklist: structure by category
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 1:41=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi Lukas,
>
> I'll review the file changes separately. This is just replying
> to the patch description comments.
>
>
> On 2/26/24 02:46, Lukas Bulwahn wrote:
(snipped)
>
> > Note that the previous first point still remains the first list even af=
ter
> > reordering. Based on some vague memory, the first point was important t=
o
> > Randy to stay the first one in any reordering.
>
> Yes, I have said that. Stephen Rothwell wanted it to be first in the list=
.
>

I have adjusted my commit message:

Note that the previous first point still remains the first list even after
reordering. Randy confirmed that it was important to Stephen Rothwell to
keep 'include what you use' to be the first in the list.

>
> > While at it, the reference to CONFIG_SLUB_DEBUG was replaced by
> > CONFIG_DEBUG_SLAB.
>
> I don't understand this comment. DEBUG_SLAB is gone.
> I think those 2 symbols might be reversed in your comments. ?
>

I must have mixed them up while writing down the commit message; so
now it reads:

While at it, replace the reference to the obsolete CONFIG_DEBUG_SLAB with
CONFIG_SLUB_DEBUG.

That is what is happening in the file.

>
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > So far, no point disappeared and nothing new was added.
> >
>
> That's a good start IMO.
>
> > Points/Ideas for further improvements (based on my knowledge and judgem=
ent):
> >
> >   - The Review Kconfig changes makes sense, but I am not sure if they a=
re
> >     so central during review. If we keep it, let us see if there are ot=
her
> >     parts for review that are also important similar to Kconfig changes=
.
> >
> >   - Concerning checking with tools, checkpatch probably still makes sen=
se;
> >     it pointed out in several places. If sparse and checkstack are real=
ly
> >     the next two tools to point out, I am not so sure about.
>
> I doubt that ckeckstack is important since gcc & clang warn us about
> stack usage.
>

So, I might drop this later on and replace it with something more
important to ask.

I have put it on my todo list (but others are welcome as well to pick it up=
):

KTODO: Investigate if the make checkstack tool is really obsolete, as
gcc and clang are already set up to warn about large stack usage just
as well as make checkstack does.

Present how it was investigated and which kind of "benchmark" was set
up and how the results were evaluated. If make checkstack is really
obsolete, create a patch to remove the tool from the repository, and
add some documentation to explain how kernel developers can check for
large stack usage.

> >     sparse has a lot of false positives nowadays, and many things are n=
ot
> >     fixed just because sparse complains about it.
> >     And I have never used make checkstack and have not found much
> >     documentation about it.
> >     So, maybe other tools deserve to be mentioned here instead?
> >

If make checkstack is removed from the list, this might give rise to
another linting/static analysis tool worth mentioning. The candidates
that come to my mind are clang-tidy or smatch. I need to check,
though, if the installation guides for those tools and the setup for
the kernel sources are clear enough to actually promote running these
tools.

But maybe there is another tool worth mentioning. I know about the
coverity setup, but this is not really suitable for checking
individual patches.

Randy, I will wait for your review and feedback on the file changes
and then send out a v2 patch. So far, the changes are only changes to
the commit message.


Lukas

