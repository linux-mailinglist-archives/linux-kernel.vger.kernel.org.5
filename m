Return-Path: <linux-kernel+bounces-150197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEC58A9B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BEF61F23C70
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B30A1635C4;
	Thu, 18 Apr 2024 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpWa/Ywr"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21FE84D02;
	Thu, 18 Apr 2024 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448007; cv=none; b=LRdv9pdj1E9hA7yjfO5TgleVkZiooGLoxYntXwweS4SFHV5dlvFtiumIbN1E0248rBAFotkll96l4XT9n8MkXh+xwu21iaggxLtpjndKw+ee/Vpz+Wi2TzUydJr4smrKDbJ0igG4mceyPpQhic6lqI0/0Fqi1aeqvt59IbivLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448007; c=relaxed/simple;
	bh=gW8dXb6Q7XLgPxHV9ikTqeBfKystElfghh0UjTRZTNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFaGRXNREFjYNJXwzkKRX4UQ8t9E4WHjB7gVT+RrOfx5XzWpFNFLHTBzJI0uOKJV/ElRRf5h+p709K5lyYKmRdFEo/n21bdoaNuFVaVXHBuY3UVT8LY4VO7UoWfdMIGMU/V62Wt6WrcjBIWg/eI6/vaSaoaWzV2Rn3rs48SvCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpWa/Ywr; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36b309dd33bso3371805ab.1;
        Thu, 18 Apr 2024 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713448004; x=1714052804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gGi5waHieAvVi8Tc0QBDOeAQpOHxjESm7pISzq4RViM=;
        b=LpWa/YwrYoOCU7WOeyVz2mrF77xcv5USUALUzHA0tGllyY5xwXKxPVYgSeTlvA4RP4
         J98oIs1dttVACOlyFtj6cNhejSOMMVqFb+d2ExPskQ41xP25NghE7SeUbzaa1K1STD+c
         pcCfqfxrW24+li+xYaKhM+H5jkrS0KsIGvAm0mtaERf74LV6uMiicYqNbO5Ph5T1YrwH
         9zqxiutmvhzBLhc10eISOp2lkIuFdkRBhwn7detKJmasjVn2+OoimbzOTIj4XSFUqkPm
         ekWVJNgvUIQHXORk7m21nqZ5nyOqQr0grGJC2B8G7C4Y1hqRp3KiKjkT4q3G8J/G91dC
         ggMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713448004; x=1714052804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGi5waHieAvVi8Tc0QBDOeAQpOHxjESm7pISzq4RViM=;
        b=G+Gg+kqDhM0D5qtYFKzsMVeLGKX9BsEd9/eQ97+pRtJa6XMvJs3mLB++w/GglqxzvS
         Lzjq30GeOeLtKGnU/D1isQxUjticFRu0p0h7d7KBGyBR0slyDp6UOq5IrcdGWNPL5FFI
         YAUEE9A3NAMaJBPu8r6LxlqpVdECRJ93aDjDVKjWnl1Tc/TF8WN7Fw5FN3zcWUpQtqLc
         APO1tWbaGgCv3FBi5QDw4tuNjEG6SdQXiQ1ngp6SzqoZ1LgVwqsq8HJKwluCM/2m/yZa
         SPghbUWUNmnVIcVSuQb/lkLJNgnDsP5KKMO5A85UsDlu5hOS3I/A79hpiFrdHWJq4VQG
         LPJw==
X-Forwarded-Encrypted: i=1; AJvYcCXYX263+dbLhBsiYhKzomOw3+4oK/PBR5EPfNON76AdVaaSq+an2qx2aT2nPiANd2TcwGZkJ3HykiIPZq9KWfm8OheORhRQydkQpgfsJEf1jRrinjcGc+lsojXnVVWY5j/67K8GmEom1hyZ
X-Gm-Message-State: AOJu0Yzqg2Y3AcPwI3hoH4hpvDQFJdDJA3ZV97z5BPuMmh9tCYMgwOxd
	fZT22uW0DzO6lw3Q2eoACRkApR4h+m7cW65POWeAmDkm8dyjPIUBmcPsmf1asE9Wb1OBQYhvTEz
	+QNXb5ShW8KhYFTIZtq56SZ6tRx4=
X-Google-Smtp-Source: AGHT+IEoY8D9Jpg7uMpntADhnxTP1sKLam3YuKyv3a9rM9dkzBnvXCPvVhYLBXcdJYl4EkepVCeAZDTepPa7Rbz+bLU=
X-Received: by 2002:a05:6e02:152d:b0:36b:2218:c913 with SMTP id
 i13-20020a056e02152d00b0036b2218c913mr3495688ilu.6.1713448004122; Thu, 18 Apr
 2024 06:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418124349.26289-1-esa.laakso@fidelix.com> <2024041840-roundworm-sedate-9167@gregkh>
In-Reply-To: <2024041840-roundworm-sedate-9167@gregkh>
From: Esa Laakso <fidelix.laakso@gmail.com>
Date: Thu, 18 Apr 2024 16:46:32 +0300
Message-ID: <CAM3Ruo1=38jYvbHPwnTPHo5nyNO1d8e6AcM_5nzU0-04GWn85g@mail.gmail.com>
Subject: Re: [PATCH RFC] pty: Add parity enabling routine
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org, 
	kari.argillander@gmail.com, linux-kernel@vger.kernel.org, 
	Esa Laakso <esa.laakso@fidelix.com>
Content-Type: text/plain; charset="UTF-8"

to 18. huhtik. 2024 klo 15.53 Greg KH (gregkh@linuxfoundation.org) kirjoitti:
>
> On Thu, Apr 18, 2024 at 03:43:49PM +0300, Esa Laakso wrote:
> > There are some cases where parity selection is required for passing
> > it forward to a virtualized terminal. In this sepcific use-case, we
> > want to use pty to send and receive serial data to a serial
> > multiplexer. By using a pty, we avoid writing a custom tty driver.
> >
> > There is very little evidence on the reasoning on why this option is
> > hard-coded to be disabled. AFAIK it has been as such since 1996. With
> > the lack of information about why this is, and based on the fact there
> > are other similar fields that are not hard-coded, it is considered safe
> > to enable this option.
> >
> > Still, in order not to be too intrusive about the change, add it only on
> > the condition that the termios flag `EXTPROC` is turned on. This way
> > there is very little chance it will cause any unintended problems in any
> > other implementation.
>
> You need to document that EXTPROC thing somewhere, otherwise someone is
> going to ask about this in 20 years and be confused :)

True! Is it enough if this is documented as a comment? I would like to add it
to the actual documentation, but AFAICS there does not seem to be a proper
location for it...

>
> > Signed-off-by: Esa Laakso <esa.laakso@fidelix.com>
> > Signed-off-by: Esa Laakso <fidelix.laakso@gmail.com>
>
> Do not sign off on something twice, use your real email address only
> once, that's all that is needed.

Alright. I'm unable to use our company e-mail as it adds a signature by force,
so I wasn't sure what the proper protocol for this was. Thanks for the info.

>
> > ---
> >
> > We are looking for some assistance on this patch, or just a green light
> > to submit it, if it is good to go.
> >
> > We would need to know if the change is valid in context of pty, as
> > there seems to be fairly little information about the reasoning behind
> > the hard-coded values.
> >
> > Our guess is that they have been as such forever and nobody has had a
> > reason to change them. We have a reason to change them, and we would
> > like to know if it is safe to do so and possibly contribute in the
> > process. Either by just using the patch for ourselves or submitting
> > it here.
> >
> > For the record, this is my first patch submitted upstream. Please let
> > me know if something is incorrect or missing.
> > ---
> >
> >  drivers/tty/pty.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> > index 07394fdaf522..e2d9718dcea0 100644
> > --- a/drivers/tty/pty.c
> > +++ b/drivers/tty/pty.c
> > @@ -267,7 +267,9 @@ static void pty_set_termios(struct tty_struct *tty,
> >               }
> >       }
> >
> > -     tty->termios.c_cflag &= ~(CSIZE | PARENB);
> > +     tty->termios.c_cflag &= ~(CSIZE);
> > +     if (!L_EXTPROC(tty))
> > +             tty->termios.c_cflag &= ~(PARENB);
>
> Some description of how you tested this in the changelog would also be

With "changelog", do you mean the commit message? I'll do that.

> good, and a comment here too as to what you are doing.

We are using a (legacy) hardware serial port multiplexer in our device. In order
to avoid writing a kernel driver for this, we decided the next best approach is
to have a rust driver in userspace and use pty:s instead of tty:s. This way we
get to have access to the needed parts of the termios structure, plus any other
niceties that come with pty code without having to implement those ourselves.
Our rust code hosts a pty master, takes the termios settings defined by the
slave endpoint and passes the relevant parts to the multiplexer. This way we can
take almost any software that uses a serial and it will have a high chance
working out of the box.

We use EXTPROC flag to get the termios settings asyncronously from the slaves to
the master. When termios is used by the process attached to the slave pty, it
will send a byte to indicate change of options. We then pass those settings on
the multiplexer, resulting in a minimal delay.

When doing this, we noted that we were unable to control the parity flag, as it
would always be disabled. This meant that we were unable to pass it onto the
multiplexer. This did not apply to other similar, non-effecting settings like
baudrate, which does nothing on pty:s either (AFAIK). Hence the careful change
here, where we used the EXTPROC to determine the behavior of the PARENB bit.

We can still change this to NOT be EXTPROC dependent, but we felt that such we
could cause a regression due to lack of knowledge. Very little to no info on the
PARENB flag, or any of the other relevant flags could be found on the
pty. Let us
know if you deem otherwise.

>
> thanks,
>
> greg k-h

