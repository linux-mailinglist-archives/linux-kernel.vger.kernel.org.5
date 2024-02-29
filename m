Return-Path: <linux-kernel+bounces-86906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1248986CCA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3481C230DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7C71384A8;
	Thu, 29 Feb 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qXtrdo5p"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A70137C51
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219672; cv=none; b=OeGefLi2pz5pVU5kO1PXjjUQMDfyfLOCNGrmQhhyFCg1ryyLK/845XeE/ZAjROZFZMoSaMx6y6LgPIEmqxQaSOO7lUWUjQzDZBsXDWMrlBpuqQ74n7Cn+jSxE2GKfL/wSa5suytFnrax9fVZDJ/lYee5eYMxcdBFUTxKleplDAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219672; c=relaxed/simple;
	bh=jYHm+YTb8xq4rGTdRYaq0RSD5pXPCejLTN8MEDP6EF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9TpZDdFsPFzOZ1vxBV3ElLOBtlu38MxGm2au5cBFa15hhHlBlrCKfcOgIEKx2qHxhDhY1WqQGznuci3pvdQzdYDqOhhQz4sQ9B8wAGArkZIxapFKRqq5s7aGntDwRMlcmm9yAAU6flG0hHOTLDRmhmQG8Z1W5pZTaiWTZYQ0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qXtrdo5p; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E46234070C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1709219660;
	bh=jYHm+YTb8xq4rGTdRYaq0RSD5pXPCejLTN8MEDP6EF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=qXtrdo5p31MNSn2YuwbQD4ymWbZhC782/i9OIwx+2upaEtUWUwGaem7J6LMRQVIR4
	 Pv3oCsdDQKXeuSPgRkBZvr0URAlls85FXx578HH968qqXcwlW+5dMFACegNL6dlRHs
	 kRPhxEQy3YL8XL94uSj/DHzMKlYA8Chjn3jLRbrm3z+E3Jr1XcyIT7BzOlbeSdYoj6
	 t9EOHrlzxw40+MrNPdqC3lqK6n4uq+g2tbc4mxghN6sTw3UsXmka4VvgTYrlbROZRv
	 xZsOh62PFNaOm2moJ8Vl18R4cXZcTDtFuHDY3EBRgFJF3NpTdTPwOmpz0JhsoNGzSU
	 patWspFBxxFaQ==
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-dc6ceade361so1726423276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219657; x=1709824457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYHm+YTb8xq4rGTdRYaq0RSD5pXPCejLTN8MEDP6EF4=;
        b=duxYTtZ8O1EYopAhth6k+R5JUUHAISmqYTtaUZIV9SDoNgnjM0exxRjoOQ5bN3K9aF
         IYRTlLeZRdcHR88PcTdHmesf9g+R4sQEJDNVtGhq0i3lXcNYtETcfSwjlP6dyVpdp3y3
         FRCIWrDa2NqEiWQmpVB/TRnP4QtVTP8Z3QHCyZ3k0lam1vV/XGjKY33MuiZThnQVbLB5
         9V/B462VIZRuzisyt/4poZl1LH2Qm7pICha/LsUVolotXQl3AS36Jp51uF226fBrumbF
         XrsoVoV65teLyDlWaikmMGOt21H9bQG8BYlldnVUkpXbnMvqFSsBaoHZ8dzcD0GKBuNK
         MjcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUatgeMbfeyTXkJOgSWHd2g28K/B8GAhExS2ir4Xeqq5s5aLA3Et/DQ4P+9fmLYrLxFT7PpCnTN8ogN3Znqy6FYvMssKUnU6670iXun
X-Gm-Message-State: AOJu0Yz5BcX3myf1vCqH7a6J87qrHuJk0A1G4ukDULLQhfw9FhBI0C1A
	0z6cM2B+rQv6yV1PCANHKhv/tQ6Q3xxthjfvd8vfe+/moOyBxy+cAwDjyzCwfKkxlRXTc/lK8Yg
	exucA9WDHulNkYiOG7j8s/3tViN7vXmGeneSu4MUTt2NWK/0Jq+wCv8F8QDp/sNxlq6hiKy8WUa
	aJ+HZ94bx0K9RBsx758of8WmwgDtVmKQNkgyYMsENa+DXdzRG8LeKZ
X-Received: by 2002:a25:db85:0:b0:dcd:98bd:7cc8 with SMTP id g127-20020a25db85000000b00dcd98bd7cc8mr2715109ybf.48.1709219657328;
        Thu, 29 Feb 2024 07:14:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkYZr9g67ah5M39WmxtPWANzTQDsddIbNxkeGXKAYMXFAu4x7bmVE+icldiZPPW3EIXh4DoSrldVoo0alQdK4=
X-Received: by 2002:a25:db85:0:b0:dcd:98bd:7cc8 with SMTP id
 g127-20020a25db85000000b00dcd98bd7cc8mr2715084ybf.48.1709219657042; Thu, 29
 Feb 2024 07:14:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com>
 <20240222160915.315255-3-aleksandr.mikhalitsyn@canonical.com>
 <Zdd8MAJJD3M11yeR@tycho.pizza> <20240223-kantholz-knallen-558beba46c62@brauner>
 <ZdoEavHorDs3IlF5@tycho.pizza> <20240226-gestrafft-pastinaken-94ff0e993a51@brauner>
 <Zdyumw6OfWBqQMTj@tycho.pizza>
In-Reply-To: <Zdyumw6OfWBqQMTj@tycho.pizza>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 29 Feb 2024 16:14:06 +0100
Message-ID: <CAEivzxcVbEZtr+wPL1p+dM4r8+vFNnPoF+E-QvG_nLNHGDYJQg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] tests/pid_namespace: add pid_max tests
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>, stgraber@stgraber.org, cyphar@cyphar.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 4:30=E2=80=AFPM Tycho Andersen <tycho@tycho.pizza> =
wrote:
>
> On Mon, Feb 26, 2024 at 09:57:47AM +0100, Christian Brauner wrote:
> > > > > A small quibble, but I wonder about the semantics here. "You can =
write
> > > > > whatever you want to this file, but we'll ignore it sometimes" se=
ems
> > > > > weird to me. What if someone (CRIU) wants to spawn a pid numbered=
 450
> > > > > in this case? I suppose they read pid_max first, they'll be able =
to
> > > > > tell it's impossible and can exit(1), but returning E2BIG from wr=
ite()
> > > > > might be more useful.
> > > >
> > > > That's a good idea. But it's a bit tricky. The straightforward thin=
g is
> > > > to walk upwards through all ancestor pid namespaces and use the low=
est
> > > > pid_max value as the upper bound for the current pid namespace. Thi=
s
> > > > will guarantee that you get an error when you try to write a value =
that
> > > > you would't be able to create. The same logic should probably apply=
 to
> > > > ns_last_pid as well.
> > > >
> > > > However, that still leaves cases where the current pid namespace wr=
ites
> > > > a pid_max limit that is allowed (IOW, all ancestor pid namespaces a=
re
> > > > above that limit.). But then immediately afterwards an ancestor pid
> > > > namespace lowers the pid_max limit. So you can always end up in a
> > > > scenario like this.
> > >
> > > I wonder if we can push edits down too? Or an render .effective file,=
 like
> >
> > I don't think that works in the current design? The pid_max value is pe=
r
> > struct pid_namespace. And while there is a 1:1 relationship between a
> > child pid namespace to all of its ancestor pid namespaces there's a 1 t=
o
> > many relationship between a pid namespace and it's child pid namespaces=
.
> > IOW, if you change pid_max in pidns_level_1 then you'd have to go
> > through each of the child pid namespaces on pidns_level_2 which could b=
e
> > thousands. So you could only do this lazily. IOW, compare and possibly
> > update the pid_max value of the child pid namespace everytime it's read
> > or written. Maybe that .effective is the way to go; not sure right now.

Hi Tycho!

>
> I wonder then, does it make sense to implement this as a cgroup thing
> instead, which is used to doing this kind of traversal?
>
> Or I suppose not, since the idea is to get legacy software that's
> writing to pid_max to work?

Yes, this is mostly for legacy software that expects host-like
behavior in the container.
I know that folks who work on running Android inside the container are
very-very interested in this.

Kind regards,
Alex

>
> Tycho

