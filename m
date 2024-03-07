Return-Path: <linux-kernel+bounces-94778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D519C874521
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363B61F262DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E20E139F;
	Thu,  7 Mar 2024 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMtfdC34"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3557237E;
	Thu,  7 Mar 2024 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709771174; cv=none; b=mp4GatTzOLZPwslKIS6ppZSDtAhIkmYXUCBq49xT0CKsHNFHshtI11I1oTlebNTHdsJ6rKzWUYbLK867JyomGXIkUlBt+ACPPmX3StA0CpwqyORd+ulQp9uIm/qEkTqx8mp5kx5H3HMxEF2XKrKEUOo4FPv9+D0yquaHds7sxM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709771174; c=relaxed/simple;
	bh=YCJ6CH0a0t3D5gSjseqFCfEhtvti/5UHRPkBNg5lPv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+xNcs4b1m0c1tNeksn/ohAzt40qdcabNUhJrUKNVHr+2iS4WiIWzRQt0VKEHZ1T+pzDsKhLD+DZwmMKCq6rsP+KGb0Jxyk4/Ufmk7IVLYAGePqxygg1KjKqZdovBd7cZ5jn8rljHLNHC4mkhLNiqeRkYwDLKS9cqYPgbsusUR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMtfdC34; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so499907a12.0;
        Wed, 06 Mar 2024 16:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709771169; x=1710375969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKT1zaj6Eh3egPuYJiO+FIUKO65/GhPQVGH+8wAM2JE=;
        b=ZMtfdC34g6LGUrifmd/wpmi07eskngIJ9SrQe7kkEEQKiZyTYJxcnjgUMNKPSmEkTm
         /9MTfKEnMvnjqrCFjDsdpiRNau/ivFb8+pAZYrIPcdWT184sNKn7XYdTfpWpmvLIT+gH
         j8AKhlQzORFMgF2ypEOjAMSiLvQIpHMoc+BLH4vVVgiXL+WTAfxVFlH/V5k5oqERv/gv
         0s+JtOWsmeHQS75D+FEk1xBeImft41owv1zPzl81PF1XDGGcWQag9SH3k2GuDg7BYSix
         AUV6VkeW5Kg3bBIcv9LPwKTH32tsp3gmHtSC4KNAqHsauH9HXoi+kWB11F1ReqoTTbDa
         40FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709771169; x=1710375969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKT1zaj6Eh3egPuYJiO+FIUKO65/GhPQVGH+8wAM2JE=;
        b=KeTm108HrNeJ4xm7RVzMNplrxm6c3NjDt+64R4YG3dwoSToG+Tfih9/rrk+ZyNOUbJ
         xv3OUif2/qCVABhUM6fsRqX/XAZryhJEWoRveFqvodCONOhDFQ/f9HZ5iI2FSQO21nNV
         rK9bSJYSDWS77urn4DMm2J+ZDqFwCTF0W2bfv+sbcFX7R0IkZ2YnzELW0bnwtCaVmaO1
         0wUT16HvUfgbvT/L60zckiFYqvLDryYek5ESrg2uI6w1/6r5P8q7Z0wGGcwieqKuwhfM
         ejSE4jcHYB66r8mtWSw7NGaU944quxq6V7XUUnVkr9e04mAgl0qfqDQt8qbXR0w9Yg1z
         TQfg==
X-Forwarded-Encrypted: i=1; AJvYcCUQESg2xHmcJ9h5MpgAFDCadhbD+t1ugIERYgxcxHIQQ/5aST/QxenaB+mSvegA3NzZyCgdUK4EIY8qQ9Gu7O9RdG1HVwP3mJx/EW/RA+AB8XKHShdbZ/xkA9UHexPyNY3I45nkn0vYZhmdu5arNXYbstghe+guPUArnI5jjfHp
X-Gm-Message-State: AOJu0YycSj18i8JLt+AO1m8/UwgEJQjV0rw+s5juN57cpxScRpwVdtar
	e/pdnBveV/DqHB4WsF0a7rCkbKm3Cr26mB7KNzi2wkx5tBFN03L37vEmtWHo0+oiI/Cm5ecZvpB
	9/LPWLtepMDeQQzSU4HgJnRkHKp4=
X-Google-Smtp-Source: AGHT+IHSUuxOAd3FCTfADD0/0f8LI7wH0+oIlX2v8zLpdcMnw4cZbhCbYDbjbWu8kso/7/knQvSx/7EbcxT07EIffnI=
X-Received: by 2002:a05:6402:40cc:b0:567:1458:caa with SMTP id
 z12-20020a05640240cc00b0056714580caamr9536026edb.40.1709771169248; Wed, 06
 Mar 2024 16:26:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301185855.944405-1-thepacketgeek@gmail.com> <8a3ccdc5445d0cfda36418dd50746f13f447bdaa.camel@redhat.com>
In-Reply-To: <8a3ccdc5445d0cfda36418dd50746f13f447bdaa.camel@redhat.com>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Wed, 6 Mar 2024 16:25:58 -0800
Message-ID: <CADvopvYwZWsCtx6Vg42VHczexmX=0n5ZN99QAX3S=1aKzMAAWA@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: netconsole: Add continuation line prefix
 to userdata messages
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Breno Leitao <leitao@debian.org>, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 4:14=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Fri, 2024-03-01 at 10:58 -0800, Matthew Wood wrote:
> > Add a space (' ') prefix to every userdata line to match docs for
> > dev-kmsg. To account for this extra character in each userdata entry,
> > reduce userdata entry names (directory name) from 54 characters to 53.
> >
> > According to the dev-kmsg docs, a space is used for subsequent lines to
> > mark them as continuation lines.
> >
> > > A line starting with ' ', is a continuation line, adding
> > > key/value pairs to the log message, which provide the machine
> > > readable context of the message, for reliable processing in
> > > userspace.
> >
> > Testing for this patch::
> >
> >  cd /sys/kernel/config/netconsole && mkdir cmdline0
> >  cd cmdline0
> >  mkdir userdata/test && echo "hello" > userdata/test/value
> >  mkdir userdata/test2 && echo "hello2" > userdata/test2/value
> >  echo "message" > /dev/kmsg
> >
> > Outputs::
> >
> >  6.8.0-rc5-virtme,12,493,231373579,-;message
> >   test=3Dhello
> >   test2=3Dhello2
> >
> > And I confirmed all testing works as expected from the original patchse=
t
> >
> > Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string =
in netconsole_target")
> > Reviewed-by: Breno Leitao <leitao@debian.org>
>
> I guess the tag arrived off-list, because I can't see any sign of it on
> the ML?!?
>
> > Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> > ---
> >
> > v1 -> v2:
> > - Calculate 53 byte user data name from: entry length - formatting char=
s - value length
> > - Update docs to reflect 53 byte limit for user data name (director)
> > v2 -> v3:
> > - Added #define for userdata formatting character length (3)
> > - Matched all #defines indent level
> >
> >  Documentation/networking/netconsole.rst |  8 ++++----
> >  drivers/net/netconsole.c                | 14 +++++++++-----
> >  2 files changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/networking/netconsole.rst b/Documentation/ne=
tworking/netconsole.rst
> > index b28c525e5d1e..d55c2a22ec7a 100644
> > --- a/Documentation/networking/netconsole.rst
> > +++ b/Documentation/networking/netconsole.rst
> > @@ -180,7 +180,7 @@ Custom user data can be appended to the end of mess=
ages with netconsole
> >  dynamic configuration enabled. User data entries can be modified witho=
ut
> >  changing the "enabled" attribute of a target.
> >
> > -Directories (keys) under `userdata` are limited to 54 character length=
, and
> > +Directories (keys) under `userdata` are limited to 53 character length=
, and
> >  data in `userdata/<key>/value` are limited to 200 bytes::
> >
> >   cd /sys/kernel/config/netconsole && mkdir cmdline0
> > @@ -197,8 +197,8 @@ Messages will now include this additional user data=
::
> >  Sends::
> >
> >   12,607,22085407756,-;This is a message
> > - foo=3Dbar
> > - qux=3Dbaz
> > +  foo=3Dbar
> > +  qux=3Dbaz
> >
> >  Preview the userdata that will be appended with::
> >
> > @@ -218,7 +218,7 @@ The `qux` key is omitted since it has no value::
> >
> >   echo "This is a message" > /dev/kmsg
> >   12,607,22085407756,-;This is a message
> > - foo=3Dbar
> > +  foo=3Dbar
> >
> >  Delete `userdata` entries with `rmdir`::
> >
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 0de108a1c0c8..8cc28aec59c8 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -42,12 +42,16 @@ MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@seleni=
c.com>");
> >  MODULE_DESCRIPTION("Console driver for network interfaces");
> >  MODULE_LICENSE("GPL");
> >
> > -#define MAX_PARAM_LENGTH     256
> > -#define MAX_USERDATA_NAME_LENGTH     54
> > -#define MAX_USERDATA_VALUE_LENGTH    200
> > +#define MAX_PARAM_LENGTH             256
> > +/* characters used for formatting each userdata entry line (' ', '=3D'=
, '\n') */
> > +#define USERDATA_FORMAT_CHARS                3
> >  #define MAX_USERDATA_ENTRY_LENGTH    256
> > +#define MAX_USERDATA_VALUE_LENGTH    200
> > +#define MAX_USERDATA_NAME_LENGTH     MAX_USERDATA_ENTRY_LENGTH - \
> > +                                     MAX_USERDATA_VALUE_LENGTH - \
> > +                                     USERDATA_FORMAT_CHARS
>
> AFAICS this is not what Breno asked, and checkpatch complains
> rightfully. More importantly it's fragile: what will be the result of
>
>         MAX_USERDATA_NAME_LENGTH * 2
>
> ?
>
> At least some brackets are required:
>
> #define MAX_USERDATA_NAME_LENGTH        (MAX_USERDATA_ENTRY_LENGTH -
>                                          MAX_USERDATA_VALUE_LENGTH - \
>                                          USERDATA_FORMAT_CHARS)
>
> Thanks,
>
> Paolo
>

Thank you Paolo, great points. I will fix the macro and remove the
Reviewed-by tag so Breno can reply on the ML

