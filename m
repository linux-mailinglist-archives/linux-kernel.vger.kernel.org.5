Return-Path: <linux-kernel+bounces-152662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EF78AC236
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 01:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75AA280E49
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 23:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C29C46521;
	Sun, 21 Apr 2024 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIPEXUHl"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185302942D;
	Sun, 21 Apr 2024 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713743860; cv=none; b=okNZWttnA+Fd8ZkBnBK/CeR8cm9x8i1o6POpG6ihxKfEZTPvDefhMrVFiUpz/Us7vEbLKtiSsJMJbUrxjZ/FlK/aHUWEFT/7Ts+l7vj/p1RoXTpMKi7wuqfW0aGVedJwqnhxwT1AYRDu2DY7Rguib7+4m+Yv1b/NwL8WyiAWybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713743860; c=relaxed/simple;
	bh=Z/jzNz3JxKMz8rh2SaixiLsCvy5He9AXKvLqtDEqT+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uubLGOixN1S88dQdFvTdI5Q1p5w0ltyvL6SFKZxG7ZmLqd82LLNJMePHJ8bjG3No8B96j9hSdgk6Vr0Q/1J2WDJbqFzOxrO06BfmtL8+RCjSxkTRpGb42B6lECq8yqEAYuyBjFAKLbaT3w4Ds8vbHG09T28NEu0QqDTTNaySt/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIPEXUHl; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5196fe87775so4103420e87.3;
        Sun, 21 Apr 2024 16:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713743857; x=1714348657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXzbfWU/cv59hlsArAtixP8QdoqZrrFUOUzSvxpRvZc=;
        b=FIPEXUHl+pymwK5ztA3vC+AeKkvq9iJ4gD5021FFLJwQbFkT4ioVUUjlKMnJrdbQiM
         t7TZbEveSCK3XrU/wUh4bqxPaByTejdXsLLZHp2Z5Nmxr1rfvxO6g0qo9W5Ruwba5Tcn
         BgFDxHyCbTujftF3LgC3tEg+W5ac0IeUY7XIHgSWoZTW4uX86dLEWMOjh3aKg/OI/Jc2
         Wg5E/z4jmrZIHFPt14PNbwpUlxWRSGx2KH36w1w6zDWN5WrRCe/5QijJjt9AvmBaSehI
         YwUo38X5OfiteCLV2ycA4KIvtVMRyLyBNp6jc7P5wDjbH8KGtOcIu9rsIeVERc2Jifop
         2YIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713743857; x=1714348657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXzbfWU/cv59hlsArAtixP8QdoqZrrFUOUzSvxpRvZc=;
        b=Hdd4E2tLh/FRihoGHVEXwDeqTc5fWpGy8BIIwM9fQYBu/HxIGJWJTpxahLcZln2n6R
         nqG2O+oBUZrdE/UzQSPumSMUVScDq0PN7WTp3XWBqyoKKU1ENDf5FgZVJhvPdOh5yYV0
         h1+0iJ9Jwffnycgslq4uchJeCa6JJAUMdyt5Mj+l4QiVm8S8BfLDI9G+c2xrMm32Shfa
         ASqD20cxsPk5zyNVJMYRKTzNx4hzKfThGLyTWke5hVP3QpMebeXZnuzt6CpYULrFx/Ki
         hS37klnXz1DSdGv2lxHAFapa8KFQTffBZI5CR5NP5kB5Etuepwvz7/Ch7HW4kEl35LEp
         insg==
X-Forwarded-Encrypted: i=1; AJvYcCXQHZaSfbUqeCX2VNvWw7sf744D9mI6rTKCGiDtMSupXhlcGqjyXqXLu/hcAmab8e85W7FtMGkyEDYwqNmkZTgPvzYS6wE4fdXmHqDbZSGwFPMjNQnaqDykDyKc11wjeVnDPqA=
X-Gm-Message-State: AOJu0YxDunIzUYS0xZRF/QexjUjQhIo/Re5fHr5SP020TZgdDw6cnFWV
	4liIl71XSJs7XWu4PqO7DI/uDYhAIj3YuWQaky5zQm+utIKLfjkOKAsqwLc+CeM8C+/O2gHYtZS
	hqfu4f/K6rLoNtudgGssHk0AHLms=
X-Google-Smtp-Source: AGHT+IGzPXEXFKo9eCpXdx+pp1GxTkh0dDHdAlbTT0vcN8u07BNk4pvX9s4+f4OPe8hmlkxIPMNUK89awtX0BqJ+mnA=
X-Received: by 2002:a19:f80b:0:b0:51a:b9f5:3416 with SMTP id
 a11-20020a19f80b000000b0051ab9f53416mr4883102lff.39.1713743856733; Sun, 21
 Apr 2024 16:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011193444.81254-1-jandryuk@gmail.com> <CAKf6xpuJe6Cza6bow3QxDGf1viu0kish7Y8YRN8haXL1oEF3HA@mail.gmail.com>
 <CAKf6xpv2oDpPB3wWh=Fz_ahDVgmvw2MSj_q3RYqQ8NG6km5Tuw@mail.gmail.com> <ZgWxYvQH4A_Vh1i4@google.com>
In-Reply-To: <ZgWxYvQH4A_Vh1i4@google.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Sun, 21 Apr 2024 19:57:24 -0400
Message-ID: <CAKf6xpu+8Uh263NqKm1qFkYG9VzHH-p4UZ=x+Fm+-SHR7J5=wQ@mail.gmail.com>
Subject: Re: [PATCH v3] Input: xen-kbdfront - drop keys to shrink modalias
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Phillip Susi <phill@thesusis.net>, 
	stable@vger.kernel.org, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
	linux-input@vger.kernel.org, xen-devel <xen-devel@lists.xenproject.org>, 
	Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Thu, Mar 28, 2024 at 2:05=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Jason,
>
> On Wed, Mar 20, 2024 at 01:42:27PM -0400, Jason Andryuk wrote:
> > Hi Dmitry,
> >
> > Do you have any feedback, or can you pick up this patch?  It solves a
> > real issue affecting udev, which crashes the Debian installer and
> > breaks the mouse for Gnome.
> >
> > Or would you be okay if this patch went in via the Xen tree?
>
> I'd rather not. Could you please ping me in 2 weeks on this. I promise
> we find a solution before the next release.

It's been ~3 weeks.  Any ideas?

If you think this patch should be pursued in this form, I'd like to
post a v4 that adds BTN_DPAD_{UP,DOWN,LEFT,RIGHT} on the off chance
someone wants to use a controller.  I dropped them initially since
they are not keyboard keys, but button presses are delivered through
the keyboard.  Hence, they should be included.

Thanks,
Jason

