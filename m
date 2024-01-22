Return-Path: <linux-kernel+bounces-32768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EB6835FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0921C228FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952333A1A9;
	Mon, 22 Jan 2024 10:39:09 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B683A1A5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919949; cv=none; b=TB2+GyWsjP+b0C0cNgX3iN+/CcmCM7g6kx+vKVVuGT+6cOa+RJQau4TVKJ8TiDakWKGWw1EZy5scLGhYpcPvpUvqLnaZGmPrtTHeypDdGwyLYeI6EMHy3RZktrE29T9Do1jJ88gnelvRjAMYBJooiajUXP2hIoa51LdVzUEbGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919949; c=relaxed/simple;
	bh=e4ZNh0t5m8mNFdYjsZkQomsZVBuev49+S8UF/acXUh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyNMmZe5JDSXZigrkG1ilWqtRz4RZpVB5Tm0KiiDEQzHaK2lz6LP4qJPuq1hbPr3U10+qXlFA/byu8x6CkbmrEwTpSpRaQqPw9cnC1VMKguWY+vmhUbFFYFeGhufCZ78Ob8MACoDi4bRy7hXWnvlbAuPb1fRJVHMCsue/bQEAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ec7a5a4b34so27202177b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705919946; x=1706524746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTkrQdMsguybEbxdmAQd2brBEIw95bzdMTfoE/2G8gA=;
        b=XLejVs+mYtQo5XHZdHBBvrJ/q21b9lo5cIVjiD6H6dxpHiQtKvtwEGqijAv5HHPjy6
         soFXhLhkQtGjzKBaA/gvy52P8aJPgpsGDpLd1teHKY2FSXYKh8q+p+GjN3Hiwz/Zpbps
         yvZr4hYRfBIQx0Rg7yjstp0BadTqnk6SbXofSUwlCcrkrJ0rPeFvfoepHOYZMU8oxwdH
         qikecqlKSxJBBRnAGiXQbMVE3u395P6XjxV9PKEWwN9rWiMlPwkcaaL7fuj267r3YnNF
         HACga6izgtxuDzy/ZY3KTyZF2bMEc9347WRPpk6ajN1mnFpi+CREx4ydSJwLPEBGsRfU
         Kx2Q==
X-Gm-Message-State: AOJu0YzId1hMj/gAXE0jMuAnaDofG76wB76OQMbNtmB8vl1JhpprZrre
	vki9ShR8wMBfPrgS+dNLqgx5X3r/3JdLHwcLc7B9WYbItGK7FUOAgmDpETqcNzA=
X-Google-Smtp-Source: AGHT+IFUq0U0zJ1bVLpE1cIDp+MbCVooj67AJMLu/heHZU4uTv9cilTvQzt6Qj43xEjxs/KB+VZIaw==
X-Received: by 2002:a0d:fe07:0:b0:5de:83bf:39d9 with SMTP id o7-20020a0dfe07000000b005de83bf39d9mr3010469ywf.98.1705919944909;
        Mon, 22 Jan 2024 02:39:04 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id x65-20020a0dd544000000b005ff7cda85c5sm3519178ywd.69.2024.01.22.02.39.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 02:39:04 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5ec7a5a4b34so27202037b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:39:04 -0800 (PST)
X-Received: by 2002:a25:81c7:0:b0:dbe:a175:3440 with SMTP id
 n7-20020a2581c7000000b00dbea1753440mr1730878ybm.92.1705919944453; Mon, 22 Jan
 2024 02:39:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117143548.595884070@goodmis.org> <20240117143810.531966508@goodmis.org>
In-Reply-To: <20240117143810.531966508@goodmis.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Jan 2024 11:38:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
Message-ID: <CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files and
 directories all be the same
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Wed, Jan 17, 2024 at 3:37=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> The dentries and inodes are created in the readdir for the sole purpose o=
f
> getting a consistent inode number. Linus stated that is unnecessary, and
> that all inodes can have the same inode number. For a virtual file system
> they are pretty meaningless.
>
> Instead use a single unique inode number for all files and one for all
> directories.
>
> Link: https://lore.kernel.org/all/20240116133753.2808d45e@gandalf.local.h=
ome/
> Link: https://lore.kernel.org/linux-trace-kernel/20240116211353.412180363=
@goodmis.org
>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Al  Viro <viro@ZenIV.linux.org.uk>
> Cc: Ajay Kaher <ajay.kaher@broadcom.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks for your patch, which is now commit 53c41052ba312176 ("eventfs:
Have the inodes all for files and directories all be the same") in
v6.8-rc1, to which I have bisected the issue below.

> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -32,6 +32,10 @@
>   */
>  static DEFINE_MUTEX(eventfs_mutex);
>
> +/* Choose something "unique" ;-) */
> +#define EVENTFS_FILE_INODE_INO         0x12c4e37
> +#define EVENTFS_DIR_INODE_INO          0x134b2f5
> +
>  /*
>   * The eventfs_inode (ei) itself is protected by SRCU. It is released fr=
om
>   * its parent's list and will have is_freed set (under eventfs_mutex).
> @@ -352,6 +356,9 @@ static struct dentry *create_file(const char *name, u=
mode_t mode,
>         inode->i_fop =3D fop;
>         inode->i_private =3D data;
>
> +       /* All files will have the same inode number */
> +       inode->i_ino =3D EVENTFS_FILE_INODE_INO;
> +
>         ti =3D get_tracefs(inode);
>         ti->flags |=3D TRACEFS_EVENT_INODE;
>         d_instantiate(dentry, inode);
> @@ -388,6 +395,9 @@ static struct dentry *create_dir(struct eventfs_inode=
 *ei, struct dentry *parent
>         inode->i_op =3D &eventfs_root_dir_inode_operations;
>         inode->i_fop =3D &eventfs_file_operations;
>
> +       /* All directories will have the same inode number */
> +       inode->i_ino =3D EVENTFS_DIR_INODE_INO;
> +
>         ti =3D get_tracefs(inode);
>         ti->flags |=3D TRACEFS_EVENT_INODE;

This confuses "find".
Running "find /sys/" now prints lots of error messages to stderr:

find: File system loop detected;
=E2=80=98/sys/kernel/debug/tracing/events/initcall/initcall_finish=E2=80=99=
 is part of
the same file system loop as
=E2=80=98/sys/kernel/debug/tracing/events/initcall=E2=80=99.
find: File system loop detected;
=E2=80=98/sys/kernel/debug/tracing/events/initcall/initcall_start=E2=80=99 =
is part of
the same file system loop as
=E2=80=98/sys/kernel/debug/tracing/events/initcall=E2=80=99.
find: File system loop detected;
=E2=80=98/sys/kernel/debug/tracing/events/initcall/initcall_level=E2=80=99 =
is part of
the same file system loop as
=E2=80=98/sys/kernel/debug/tracing/events/initcall=E2=80=99.
[...]

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

