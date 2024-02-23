Return-Path: <linux-kernel+bounces-79014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCC6861C44
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CD77B21623
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D469F143C40;
	Fri, 23 Feb 2024 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/mI4Cfo"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99884FBB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708715153; cv=none; b=Joptr2McWFyy4Aws8FP3J2U1UQaPmx7NTXDDrb579IPNXahDPH+wmG+D3ycewUnAkuFhXZwEW8ZTKI1W/WzD+0Y608WtTXoBsFp1xjIMaiF5snuBTBSPyVAY0MeRAasFYBqTdm/jcoYvCETgsiZwgdyVlEsCAgXmR+SNw55p0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708715153; c=relaxed/simple;
	bh=dTcSTLD5NaRZsXtXw/gX8tyEjyUskYI1wyAzmVqPvp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQ6SbzmyMIl0ecybW8f5gLAr6/DZsM4h3sNXO47wLRug8/yYxwSUpkM4h96uCVXt6e/P3BAHTAjh+yGwBTOia5LUf0nB1wzxe2Y8NeX9FiXPf2orcQEle1USdyfkJYGqTXF/I8NdxBX1khEC9H8iu1HQwXS52NTLPpQyqBjOwyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/mI4Cfo; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3e75e30d36so222549066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708715150; x=1709319950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4v230DsXfCjAAZT8YLeLSGRy2+4z5zYxutuKPgHOFNE=;
        b=W/mI4Cfo27r/d8gKv1X1FQ5TuU9G+7ZCf3c7dPc+zXHrSL3fq/bVtA8RgkSmd1jn9a
         KHwSG7qAo+4ZMORjxG8wThCCoJpLUpElwQ1EuvY5J6iMrQkoDBPcDv3Gf9KSw2FgFg4y
         wGgMnzyZciQsZ8dzjt7QSZjNtAea7WYRplbEUAZW1q6jYYr6vmPWDDuf3pIvSqB+0Gry
         UuH4O3B1DtPaOWKE1ekgP+mn2ageg2Ejd6oVaSY8V9hbFdLGPRHSdqqshQ8q9JJPV2uE
         6fB8yLMewivBKvW3bL+axoHXO2uEsQ7hHIVY3Bgnda7BDyYavdWqLpeP03RTaoKOdgdZ
         Jy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708715150; x=1709319950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4v230DsXfCjAAZT8YLeLSGRy2+4z5zYxutuKPgHOFNE=;
        b=jycRUJ+RENnswf+MNe8BS1u4oPz1B3dXvY3zY99xA9s4xJUz5+ppSV4pRrQpMxScCZ
         BenKI5XpyrtSF6wC3rJErdt64sx482pdrt4/4YF9h4qM4tBtT/d8iwJYmFI7VAtyemN9
         Z693hFp7l+zT5jw/ksTUcbjRcopQXEoxmGk2ygUpuCoMg6lBw5ZOf6rAHkn+7PLvC+b+
         BfQf25Wpge4A1T+qPx+19yD6CqE1uSEVHuk2/3M4sYxYx6Y2vCGjsH4tzkxJ5qIwF+l0
         75SqDlj8m/hzamDzt5kNmFCHivaRVwCczeu8adSodajJZrvRDXqYsdhfc1OICqFPdaL+
         CszA==
X-Forwarded-Encrypted: i=1; AJvYcCXTKAMkJkvWPvIvikNPJeYdpho7/EkUf0TAzX0P1UWEMYrerDwCadBiVqljiSXzjGRKzjsulgxv8NB8YLVtI/ZbsotHypoZ7yxK1aQq
X-Gm-Message-State: AOJu0YxJlg3qP5vV6JR6A/eRfLK/6+g+hSAHJ8ygkasP5KGll/Dl5n3z
	aJUIQoGZQHOUL4iqFmEGtvbklD6fLok/Xx5V//RgCBO3Y4+SytTuUW+HOge4f9mLjP2qhcLpU5G
	aEYWOskdPMHaGgdzVDn34FVBWyXs=
X-Google-Smtp-Source: AGHT+IFQqUTyoI4fghwL4RHXduy4/O9ksMga8oXHmDyo93y9+5dbbSv1SfmE/Xe3fjLMWo0X7QZ/0zMmiPer1HFHqgw=
X-Received: by 2002:a17:906:354d:b0:a3e:b57f:2b8a with SMTP id
 s13-20020a170906354d00b00a3eb57f2b8amr622190eja.10.1708715149625; Fri, 23 Feb
 2024 11:05:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222051539.3001988-3-saravanak@google.com>
 <20240222051539.3001988-4-saravanak@google.com> <ffec7c7b8eb86f573e420e0582075ba1e75d0e54.camel@perches.com>
 <CAGETcx-mNt+_ST0opQ=_M1ZJK1acf8Rr0VqaAUskyig5YwL_dw@mail.gmail.com>
 <e51c5e6fe02bcc5a487cae063fe8f440013d0ca9.camel@perches.com> <CAGETcx8rANkOHhay6iFoXtXtJ8KvoNQBAMpruGENys+L2uHQTQ@mail.gmail.com>
In-Reply-To: <CAGETcx8rANkOHhay6iFoXtXtJ8KvoNQBAMpruGENys+L2uHQTQ@mail.gmail.com>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Fri, 23 Feb 2024 20:05:39 +0100
Message-ID: <CAKXUXMzhpRMmroT9tprvtbFfiv_phpY7iPrE3r4CVuqGzLfeBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkpatch: Don't check for unified diff format in
 git sendemail headers
To: Saravana Kannan <saravanak@google.com>
Cc: Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:10=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Thu, Feb 22, 2024 at 5:01=E2=80=AFPM Joe Perches <joe@perches.com> wro=
te:
> >
> > On Thu, 2024-02-22 at 16:45 -0800, Saravana Kannan wrote:
> > > On Thu, Feb 22, 2024 at 12:54=E2=80=AFAM Joe Perches <joe@perches.com=
> wrote:
> > > >
> > > > On Wed, 2024-02-21 at 21:15 -0800, Saravana Kannan wrote:
> > > > > When checkpatch is used as a git sendemail-validate hook, it's al=
so passed
> > > > > in the email header for sanity check.
> > > >
> > > > Why?
> > > >
> > > > If so, why not use a front-end script to stop/remove
> > > > the file from being scanned by checkpatch?
> > >
> > > Sure, I could do that. But this also makes it easier for people to
> > > start using checkpatch. Or I can put up a git hook wrapper script in
> > > here for people to symlink into their .git/hooks that does this.
> > >
> > > I'd prefer the lazy route of not creating a 1 line wrapper script :)
> >
> > I'd not.  checkpatch is for _patches_.
> > Don't feed stuff to it that isn't patches and expect good results.
>
> Would you be open to being a maintainer if I add a git hook
> sendemail-validate wrapper? It feels silly to add myself as a
> maintainer for a 1-line script. I'd rather give it to you :)
>

I agree with Joe's shrug. We got enough scripts, where very few
(actually: probably nobody) know what they are good for.

However, Saravana, if it helps you, feel free to add a section in the
checkpatch documentation where you describe which workflow you have
and in which files you need to set up what.
So, in case you forget, you will find it in the documentation and
possibly it is also helpful to others---if they read the
documentation, or some AI bot reads the documentation in the future
and then suggests it to someone asking that AI bot---well, that is our
brave new world nowadays...

I will maintain that section in the checkpatch documentation for you,
if you submit the documentation change as a proper patch.

Lukas

