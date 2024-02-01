Return-Path: <linux-kernel+bounces-47647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 963988450B4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF92228F8C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17873CF43;
	Thu,  1 Feb 2024 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAOYYnba"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868713C478;
	Thu,  1 Feb 2024 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706765491; cv=none; b=r1mJNAMORkumSMQHyPp0GCk8/UJjbqi4knunjnN3Er3bxbLEdaVuo5aVgo7qDAlXfOy1eJ0RQ9sPbzxLFLpC9SqUCJMiZWsvzNPTyjmpfwnEr/1dovrLYeSHmj9pyGzayKSIpqlW9Iq9qrTfpJlM2UFeASb4lkhzsVQLlE3HhCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706765491; c=relaxed/simple;
	bh=QlftfIFyNktXBOTMuxycW6hjQubl1kp68ABcVxyeijc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lj0lVIZKLhwhHKmvrEY8uSOzNtckT+ILX9xXIcScZY5yKcS12h1GYJXMw67CwHsOFKgrUyvUpD5LxycFWCrHWBaZg2xSGSFESZElCKcX0N/LVG5X3GyY+qlp0x/5sHHmtd2hROcC3L/bfA1ZvSiPI+BiEpybdErglsX5sydzOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAOYYnba; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso584005a12.3;
        Wed, 31 Jan 2024 21:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706765487; x=1707370287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3agqooba06XYvulS6J+XmdbHaLA7r3clg+3M7KTsGI=;
        b=KAOYYnbaJBJN6XTL89u5eSPF3uALJ8dTrk+1+7YfbyRlKF/Hadrl0MckyBrtIHzVNd
         ZvuQOU7kX9XbdM5A/6Ow+w4P1K2KHE9yt3hsoQEpPzWLvkLjhEWJQ6NXc0Gn9EKFH+kn
         bDnmQP+MK707SCOX+eGCvD4FZr6iGBfwOr6jIkniY0bWWtwAxBYnshNMzG8Rxxtw6XGT
         AzZrt4KiTV7HC0ocwX3brQxLNuo3GHwmn7/U8MDLkpT0PYtX4bTiPN280LYLE6LJJHVl
         Uyly0gc0jAKDzdtrgMHL6/Bo8M6n51nOwRcY8wcQOGVwYmK1dEFx8JmjENjZ2ooITXPz
         Vuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706765487; x=1707370287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3agqooba06XYvulS6J+XmdbHaLA7r3clg+3M7KTsGI=;
        b=hU15pWk3YkHaejui25l4VelP+HcsHn2Ho6QhJ1kkowxhpPlj17vr47FFl/k6DNwtoj
         aPV2l+LqWgQMdPBNenerWwL5UNqdvMlnIZrm8z3YDJNxzI6R1yrh9X3RHP3AJqAMwO4Q
         /TweqQnSxR901iI4OyFhFSqtfwMmQr7UkhOVsO2BQMhU+z7F4yCwTdbmcb4Vf/EDf5v4
         dBP7l8r6x1Tq0xev1Ag9oB1u1Oc8RryIhkdHw4ErcZf7eVrFe/B024tyrX6IcA3yGCUn
         jNObKIKlB61wFgw4lXE1deoitNMqF6G/sOWpbIziKKwHj6skh8d2a94wAvvFYFhNRggR
         E98Q==
X-Gm-Message-State: AOJu0YxSts5ANHiDWQtVDTubofTD+fGIuc/QaU/Dsp5NsiIJa6qp7u39
	KkHMFLAEfHLC56RUXxh4NZxp9dZ6ppUYJZv4adzV8T1pXUIj0kyW9j239fJC4srO4Vt3l9evf+b
	7Airomr90bbsTX9KeobqV/ZT1n3I=
X-Google-Smtp-Source: AGHT+IHK2Ox6ysaXgJnnNk3FU9Ma1xL/0jJ/KBN59ylMSp2Wi8ii8MYTYP4GWLRpu6wiYJjrKb9fLP2aC1c7ZzgehIc=
X-Received: by 2002:a05:6402:234b:b0:55f:6a35:b541 with SMTP id
 r11-20020a056402234b00b0055f6a35b541mr3572700eda.14.1706765487509; Wed, 31
 Jan 2024 21:31:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126231348.281600-1-thepacketgeek@gmail.com>
 <20240126231348.281600-4-thepacketgeek@gmail.com> <Zbi+Zw2o0rDfX1pj@gmail.com>
 <CADvopva+tesNHtCBOadK9x3bbqgjX+ZkkyPDeX1pto7ZUU=QVA@mail.gmail.com>
In-Reply-To: <CADvopva+tesNHtCBOadK9x3bbqgjX+ZkkyPDeX1pto7ZUU=QVA@mail.gmail.com>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Wed, 31 Jan 2024 21:31:16 -0800
Message-ID: <CADvopvZYoPYOf8=TX16BzQGobofp8i7ud3MOBbuj5mXPtR106A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/8] net: netconsole: move newline trimming to function
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 8:45=E2=80=AFPM Matthew Wood <thepacketgeek@gmail.c=
om> wrote:
>
> On Tue, Jan 30, 2024 at 1:16=E2=80=AFAM Breno Leitao <leitao@debian.org> =
wrote:
> >
> > On Fri, Jan 26, 2024 at 03:13:38PM -0800, Matthew Wood wrote:
> > > Move newline trimming logic from `dev_name_store()` to a new function
> > > (trim_newline()) for shared use in netconsole.c
> > >
> > > Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> > > ---
> > >  drivers/net/netconsole.c | 17 +++++++++++------
> > >  1 file changed, 11 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > > index 085350beca87..b280d06bf152 100644
> > > --- a/drivers/net/netconsole.c
> > > +++ b/drivers/net/netconsole.c
> > > @@ -230,6 +230,16 @@ static struct netconsole_target *to_target(struc=
t config_item *item)
> > >                           struct netconsole_target, group);
> > >  }
> > >
> > > +/* Get rid of possible trailing newline, returning the new length */
> > > +static void trim_newline(char *s, size_t maxlen)
> > > +{
> > > +     size_t len;
> > > +
> > > +     len =3D strnlen(s, maxlen);
> > > +     if (s[len - 1] =3D=3D '\n')
> > > +             s[len - 1] =3D '\0';
> > > +}
> >
> > I am thinking about this one. Should we replace the first `\n` in the
> > file by `\0` no matter where it is? This will probably make it easier t=
o
> > implement the netconsd, where we know it will be impossible to have `\n=
`
> > in the userdata.
> >
> > Maybe something as:
> >
> >         static inline void trim_newline(char *str)
> >         {
> >                 char *pos =3D strchr(str, '\n');
> >
> >                 if (pos)
> >                         *pos =3D '\0';
> >         }
> >
> >
> > All in all, this is a good clean up, which make the code easier to read=
.
> > Thanks!
>
> I like this idea, I agree that only accepting userdata values upto the
> first newline clears up the expectations for log output and parsing on
> the receiving side. I would prefer that to the case where multiple
> values (delimited by newlines) are somehow attempted with a single
> key, seems like just using additional key/value pairs would be
> cleaner.

In practice truncating at the first newline makes no difference as
printk, echo, and other methods seem to buffer and write per-line. So
in this example, the stored value will be "val2" with or without the
suggested change:

$ printf "val1\nval2" > userdata/testing/value
# This results in two calls to userdatum_value_store, the first with
"val1\n" and the second with "val2". "val2" remains as the latest
write.
$ cat userdata/testing/value
val2

I will add a warning about this possibly unexpected behavior in the
docs for v3 for the patch

