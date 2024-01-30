Return-Path: <linux-kernel+bounces-44289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07051841FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E0A294FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6A4605BE;
	Tue, 30 Jan 2024 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leh6T7Ek"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F0D38DEC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607991; cv=none; b=JUNUOsCglydaQwrPl4MNMWBirOj0MDtk1vt3S3z+DHWuw8tU6IY4i423VfhI6Zk8dEdJmY73pGe6Hm19Ykl8xgxkDcAE5t7zP6M540nkyyPpUkK7U0Y0MtQRxEdw9UVaUrZy9FB5E5aGb5Dan0MwJ2/WHBaNGTsCNnz6lUnLvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607991; c=relaxed/simple;
	bh=gb2HjwEa0C8yF0X/vBJtNDEd4ZBIosdsqR7MEMmpMJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6Gm0g48DZHoLLZFcaMaGVqclS7081H5K2WouThEEgYCHUfmHbT3TjSiK0pBPACrzQxTWVoMg6EE0v/oyq4F3o3vRT37bGt63EcA9AXuDzXIojbYRgrd4ZM6Gze3k3fi4wJvKbIbAG/DxeZvExtHyZfT/qV4J/+q8QDohqsxLRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leh6T7Ek; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5ff821b9acfso36103387b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706607988; x=1707212788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb2HjwEa0C8yF0X/vBJtNDEd4ZBIosdsqR7MEMmpMJI=;
        b=leh6T7Ekt2SKdHOF7tvf9on187uAdXv8WgYRau1CNGbr2tSIXnQ0jC/XawGJw+vlid
         aJoFkYDIJ8XV8tvVwMCM+Uaz/iyVNrjICIQG0MMmtng9tR1BGJhcSizTNWeN3YwIRwVa
         gD84VX1HUnCrEL8DXIlgA0RT52wt5In+2h5HCZFcoJgRE0b+TcTY/GJJahs01FllyuNI
         uEfTpL8N+I0TdVygWZNpROLi311dSYvS8BbvOGvLNH+U4GmL9BPrG8qb9/xNbkmN11bn
         GCq1VDNw288Y2grA3Y75Xmn/bTvgv4PF5TDNQZO+UK0i9w7EXEWayGuhnrXkiLeP2eY8
         OEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706607988; x=1707212788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gb2HjwEa0C8yF0X/vBJtNDEd4ZBIosdsqR7MEMmpMJI=;
        b=wrW7R7GTf8yif6jCTSVRfjMVnigohi6siPq+4ijK86c1qKnJzNbESO1whJ/6g4K6WK
         Hs4mpAtMD4EJ+LkWe9XXczwv/hurONXIQdJ2CmkMGo0KgfryQPufc3Tx460zOTMU6fUJ
         Mq/zdWdEa6w3Gevm5vYG+FhfBcw1D6J+Zsoz3JojWqmB1szh5nZmxRs7uwHURNOTQOeP
         IVs9qn/mmXvvtfBEj7bLUx1PmAkZIBJPiP29yWC+5aWN6yAmqLGihIwoF64HnM3ad1mI
         QLa429P1+58RsS8Gux7PsJDvFscFvzBIkSbWcRLJrmWXC7JoPcyNQvkPMFTgl1vehUWL
         pSAQ==
X-Gm-Message-State: AOJu0YyYlZ4sAojgShnGh1TNk4uqQ5x8409eZr0StSiZg+Yj5I4wMIiP
	sdhkupYKLo23g8aIqynE3DG2wDbkE19OOml3OORTJSZjhEkW/yO3CbDdQAhNMU6U+5BuFXN9RTc
	CZdvl2sItdXYFOX4NzVMTma24q20=
X-Google-Smtp-Source: AGHT+IFXcC7BqxRD4z3lrqJQHTykje+TypiWIqSCrJ4vDx/Xypbg56dheSPWpOlqrOtbYKSkWEtCUYnjyLHBkpqzKQs=
X-Received: by 2002:a05:6902:18a:b0:dc6:19ea:9204 with SMTP id
 t10-20020a056902018a00b00dc619ea9204mr3893891ybh.61.1706607988559; Tue, 30
 Jan 2024 01:46:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <ZbfSP6xt6JAE2NrH@tiehlicka>
 <CAK1f24miiADZCpugOa4QUmerG70kOsMT97Zvmy=5ifOG4mW=+g@mail.gmail.com>
 <CAK1f24=2YE+BCYiizkqc8rmN8NaFv_Q6ZtE+4DiFK0PpcefOrQ@mail.gmail.com> <ZbjC7KyI21ik1xpK@tiehlicka>
In-Reply-To: <ZbjC7KyI21ik1xpK@tiehlicka>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 30 Jan 2024 17:46:17 +0800
Message-ID: <CAK1f24=WJa7qpwBW8J-eYBc2TGrViE_8vtCTESXxMDd=hhQdjw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 5:35=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 30-01-24 11:08:10, Lance Yang wrote:
> > On Tue, Jan 30, 2024 at 10:12=E2=80=AFAM Lance Yang <ioworker0@gmail.co=
m> wrote:
> > >
> > > Hey Michal,
> > >
> > > Thanks for taking time to review!
> > >
> > > On some servers within our company, we deploy a
> > > daemon responsible for monitoring and updating
> > > local applications. Some applications prefer not to
> > > use THP, so the daemon calls prctl to disable THP
> > > before fork/exec. Conversely, for other applications,
> > > the daemon calls prctl to enable THP before fork/exec.
> > >
> > > Ideally, the daemon should invoke prctl after the fork,
> > > but its current implementation follows the described
> > > approach.
> >
> > In the Go standard library, there is no direct encapsulation
> > of the fork system call. Instead, fork and execve are
> > combined into one through syscall.ForkExec.
>
> OK, this is an important detail. Something that should be a part
> of the chnagelog. It is also important to note that this is not
> a correctness issue but rather an optimization to save expensive
> checks on each VMA when userspace cannot prctl itself before spawning
> into the new process.

Thanks for pointing that out!

I'll include it in the changelog. Good to know it's an optimization
rather than a correctness issue.

Thanks,
Lance

> --
> Michal Hocko
> SUSE Labs

