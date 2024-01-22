Return-Path: <linux-kernel+bounces-33669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E021836CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB621F23AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22A350276;
	Mon, 22 Jan 2024 16:23:45 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2045950279
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940625; cv=none; b=L8u/CkixWUnA5t/0jW80N1FGem17HRJbzQk1P59Ozip0Hfq6jJfEHmpOLTY2PlAffXyJsae1OG5t86B3iMLkG3ZkVWV1Q+BlN0LU6czVC5iopgkE+XKpXndEn9wDznMENSfGX2LTDm+QWVJSUqPaHOJZghbV3kOkyeq3xUqwNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940625; c=relaxed/simple;
	bh=c0H9liQF42kYYjnyU5bGVzPjbfrN47cBLV6R6UQye7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lK8dPPdrBv17D/pWQwiofMzTWD6c77Ieoh6O8qb7j5znqu65tCfy0Vd5CIbv2RIkFoOohrkRUPRP6qxrKskVe9PRYh490eQOPEozThU5bSKfsYzdXhDvjPhBmo5Drz8tyUhtrPdYJ7i60FXSNYbZXclLJr5rpq/gF+nImlH8cgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ffcb478512so10134937b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705940622; x=1706545422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INU9vArO42qrhmolv23n3E/VOPnDfYhkPQzxpEJtYN0=;
        b=mkSZsoe5qbGO5k2qd/u6v5Dox4ssARlQhPQiD1++WCJ6g4/EjEf3QUxfpqA7kPJxTr
         RBKMb23aizcS1YaBb3JTTiwnlo9l7pPet8iaW82Ed2hR623I1nnLhFJTP/z5hTwc2cHB
         eABl4OxEmZR45fRJi3VPVQufYsb0zZIhboYnllxhwEM5jYC/1t0BlFJiRhUFno0NVrHx
         c6Y16RG78hQ6BrnLiL9VzOfa4W1eHJUG2Q9/RGkRVnAO46LidLSGl8uqwl19/ovMaARM
         GzrMfWS2KgocHxkHlYkUNZL1Ww82n3dSRw2RF8PjqdI/B6qARCoZwdT6/Y1RhsQJfj/T
         KSaw==
X-Gm-Message-State: AOJu0YzgVFcZCGOzPRiHSJEnhh6Z9Byulp7JFqy7dm9di4hVNTcVsEb7
	HdtIEi1om+H1WtPvLPyqbQ+CZTNSinpxDqW6Oc1tmo0o0AiY8a9X7YldJIsrGJ4=
X-Google-Smtp-Source: AGHT+IG9cH4MBsjUMDaVxNJCPrCkWNYaVWLckX1uTnrWXUWm2/FtwvGwJnyW/dM7mkupuB3OXQ4Vdg==
X-Received: by 2002:a81:4ad6:0:b0:5ff:7e39:69a0 with SMTP id x205-20020a814ad6000000b005ff7e3969a0mr3757274ywa.31.1705940621721;
        Mon, 22 Jan 2024 08:23:41 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id s4-20020a0dd004000000b005fb0d1afc7csm9587092ywd.120.2024.01.22.08.23.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 08:23:41 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5ffa694d8e5so21004847b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:23:40 -0800 (PST)
X-Received: by 2002:a81:8347:0:b0:5ff:a344:a669 with SMTP id
 t68-20020a818347000000b005ffa344a669mr2851668ywf.33.1705940620739; Mon, 22
 Jan 2024 08:23:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117143548.595884070@goodmis.org> <20240117143810.531966508@goodmis.org>
 <CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com> <20240122100630.6a400dd3@gandalf.local.home>
In-Reply-To: <20240122100630.6a400dd3@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Jan 2024 17:23:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
Message-ID: <CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files and
 directories all be the same
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Mon, Jan 22, 2024 at 4:05=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
> On Mon, 22 Jan 2024 11:38:52 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> > Hi Stephen,
>
> I don't know who "Stephen" is, but I'll reply to this message.

My apologies (too many different spellings in too many languages)...

> > On Wed, Jan 17, 2024 at 3:37=E2=80=AFPM Steven Rostedt <rostedt@goodmis=
org> wrote:
> > > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > >
> > > The dentries and inodes are created in the readdir for the sole purpo=
se of
> > > getting a consistent inode number. Linus stated that is unnecessary, =
and
> > > that all inodes can have the same inode number. For a virtual file sy=
stem
> > > they are pretty meaningless.
> > >
> > > Instead use a single unique inode number for all files and one for al=
l
> > > directories.
> > >
> > > Link: https://lore.kernel.org/all/20240116133753.2808d45e@gandalf.loc=
al.home/
>
> Yeah, Linus wanted me to try this first and see if there's any regression=
s.
> Well, I guess you just answered that.
>
> The above link has me saying to Linus:
>
>   It was me being paranoid that using the same inode number would break u=
ser
>   space. If that is not a concern, then I'm happy to just make it either =
the
>   same, or maybe just hash the ei and name that it is associated with.
>
> > > Link: https://lore.kernel.org/linux-trace-kernel/20240116211353.41218=
0363@goodmis.org
> > >
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Al  Viro <viro@ZenIV.linux.org.uk>
> > > Cc: Ajay Kaher <ajay.kaher@broadcom.com>
> > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> >
> > Thanks for your patch, which is now commit 53c41052ba312176 ("eventfs:
> > Have the inodes all for files and directories all be the same") in
> > v6.8-rc1, to which I have bisected the issue below.

> > This confuses "find".
> > Running "find /sys/" now prints lots of error messages to stderr:
> >
> > find: File system loop detected;
> > =E2=80=98/sys/kernel/debug/tracing/events/initcall/initcall_finish=E2=
=80=99 is part of
> > the same file system loop as
> > =E2=80=98/sys/kernel/debug/tracing/events/initcall=E2=80=99.
>
> So at a minimum, the directories need to have unique inode numbers.
>
>
> > find: File system loop detected;
> > =E2=80=98/sys/kernel/debug/tracing/events/initcall/initcall_start=E2=80=
=99 is part of
> > the same file system loop as
> > =E2=80=98/sys/kernel/debug/tracing/events/initcall=E2=80=99.
> > find: File system loop detected;
> > =E2=80=98/sys/kernel/debug/tracing/events/initcall/initcall_level=E2=80=
=99 is part of
> > the same file system loop as
> > =E2=80=98/sys/kernel/debug/tracing/events/initcall=E2=80=99.
> > [...]
>
> Does this fix it for you? It hashes the eventfs_inode data structure afte=
r
> adding some salt to it.
>
> Kees,
>
> I'm using the eventfs_inode pointer to create a unique value for the inod=
e.
> But it's being salted, hashed and then truncated. As it is very easy to
> read inodes (although by default, only root has access to read these
> inodes), the inode numbers themselves shouldn't be able to leak kernel
> addresses via the results of these inode numbers, would it?
>
> -- Steve

Gotya ;-)

>
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 6795fda2af19..d54897b84596 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c

> @@ -36,6 +37,31 @@ static DEFINE_MUTEX(eventfs_mutex);
>  #define EVENTFS_FILE_INODE_INO         0x12c4e37
>  #define EVENTFS_DIR_INODE_INO          0x134b2f5
>
> +/* Used for making inode numbers */
> +static siphash_key_t inode_key;
> +
> +/* Copied from scripts/kconfig/symbol.c */
> +static unsigned strhash(const char *s)
> +{
> +       /* fnv32 hash */
> +       unsigned hash =3D 2166136261U;
> +       for (; *s; s++)
> +               hash =3D (hash ^ *s) * 0x01000193;
> +       return hash;
> +}
> +
> +/* Just try to make something consistent and unique */
> +static int eventfs_dir_ino(struct event_inode *ei, const char *name)

eventfs_inode

> +{
> +       unsigned long sip =3D (unsigned long)ei;
> +
> +       sip +=3D strhash(name) + EVENTFS_DIR_INODE_INO;
> +       sip =3D siphash_1u32((int)sip, &inode_key);
> +
> +       /* keep it positive */
> +       return sip & ((1U << 31) - 1);
> +}
> +
>  /*
>   * The eventfs_inode (ei) itself is protected by SRCU. It is released fr=
om
>   * its parent's list and will have is_freed set (under eventfs_mutex).

Thanks, find is happy now the directories have different inode numbers.
The files still have identical inodes numbers, I hope that doesn't cause
any issues...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

