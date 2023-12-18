Return-Path: <linux-kernel+bounces-4027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A078176F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF5E28510D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2DA4988E;
	Mon, 18 Dec 2023 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfWVc16o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF44F42372;
	Mon, 18 Dec 2023 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cdaa16ada8so386198a12.2;
        Mon, 18 Dec 2023 08:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702915394; x=1703520194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klP/QIEQB2txi/t4qMw4N7xlc5FDeatCwjV9oSadSfk=;
        b=EfWVc16oTZQN+FUgwcE5jvr4ZzsoNyMSmPiXB8xeWXlDvj6KaUuDwHoOUgmAwWfLmV
         KgEhsQlkvwSVAJN2MAy38koHk7J6M3iiSkO8FpJpHL0k9wFi7W5V2gRj1vgwWlwBN2a9
         VJ1Hww2GUZPa7ufB+k04KTIn5+0IQjbo9D9ucX/VZXZNVO3ZesevND5SPZy3z/VS+drS
         MSv6HWGJqNMYPA5FG9nz5vo7XtP0lzlYHjIc9dfp8cq9lBqG6twKE23dOsmu9uZskE9C
         T1wqq79sEp2rOBDmXBmPtIwtQgRvHI/dKgFp2H1Ns/pAcO91PfZFMHYbrKDg+CrbqebK
         kttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915394; x=1703520194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klP/QIEQB2txi/t4qMw4N7xlc5FDeatCwjV9oSadSfk=;
        b=Txa5QSvD/hMFFuzgb20xqzsm0VVCqYx5zNghP8gzPRoCvsDZo175gdMo/ro5JmvEDE
         tscjfpMoZbYoIRLm1KajfP4sbLkZGZhPPveLTTkfDUgDizWeAKVkVLXpDzZTihpS1Vnb
         7hmOPOfjo1shyWuYVaJ12fyrXwCPQIl/qp4P6uT6NDUCEEFgC0SjjiitbpgpD9a0l5xT
         fM+5qjBaHULBD8IqVSVe6B3iftwSOgsFik97W0B5tqXjkp1NrvWqyiiF32ogFL9eeKv9
         oiTaUKl/AJsnifhmT6kFt4NsSrkf7cuTzt4/o++v95E2exrPPkDofr8D2uUiI9WOQEQM
         F54w==
X-Gm-Message-State: AOJu0YwIM1PGUDfiStW5HRhYAIDQ2mjETDsU/lGv1r9eruINimoRvk/A
	ugpBUKPEAkeuCaTKHYbDGsfjbW4eHOa0JLyxvCo=
X-Google-Smtp-Source: AGHT+IHJnD6l4xR9mF/3xa7tQfQNGVkYZeTqTkevWp07LZzQjJuLiUCx9BnVqJxvl2lspHIZk9TOL7Mkk2X3AfvB/SQ=
X-Received: by 2002:a17:90a:f3d3:b0:28b:6ebc:d15b with SMTP id
 ha19-20020a17090af3d300b0028b6ebcd15bmr749550pjb.68.1702915393949; Mon, 18
 Dec 2023 08:03:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218141645.2548743-1-alpic@google.com> <CAEjxPJ40jPsBS5xZEgS1CCVYORDJhwNOrAj5Oepa3rK=Y1BnYg@mail.gmail.com>
In-Reply-To: <CAEjxPJ40jPsBS5xZEgS1CCVYORDJhwNOrAj5Oepa3rK=Y1BnYg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 Dec 2023 11:03:02 -0500
Message-ID: <CAEjxPJ7xVgp+4V-OnGRgdWTd6fV0dQr32S=8H41F2-J6Snygmw@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Introduce security_file_ioctl_compat hook
To: Alfred Piccioni <alpic@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>, stable@vger.kernel.org, 
	SElinux list <selinux@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 10:58=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Dec 18, 2023 at 9:17=E2=80=AFAM Alfred Piccioni <alpic@google.com=
> wrote:
> >
> > Some ioctl commands do not require ioctl permission, but are routed to
> > other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
> > done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).
> >
> > However, if a 32-bit process is running on a 64-bit kernel, it emits
> > 32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
> > being checked erroneously, which leads to these ioctl operations being
> > routed to the ioctl permission, rather than the correct file
> > permissions.
> >
> > This was also noted in a RED-PEN finding from a while back -
> > "/* RED-PEN how should LSM module know it's handling 32bit? */".
> >
> > This patch introduces a new hook, security_file_ioctl_compat, that is
> > called from the compat ioctl syscal. All current LSMs have been changed
>
> s/syscal/syscall/
> Might to consider checking using codespell to catch such things
> although it is imperfect.
>
> > to support this hook.
> >
> > Reviewing the three places where we are currently using
> > security_file_ioctl, it appears that only SELinux needs a dedicated
> > compat change; TOMOYO and SMACK appear to be functional without any
> > change.
> >
> > Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
> > Signed-off-by: Alfred Piccioni <alpic@google.com>
> > Cc: stable@vger.kernel.org
> > ---
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 2aa0e219d721..de96d156e6ea 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3731,6 +3731,31 @@ static int selinux_file_ioctl(struct file *file,=
 unsigned int cmd,
> >         return error;
> >  }
> >
> > +static int selinux_file_ioctl_compat(struct file *file, unsigned int c=
md,
> > +                             unsigned long arg)
> > +{
> > +       // If we are in a 64-bit kernel running 32-bit userspace, we ne=
ed to make
> > +       // sure we don't compare 32-bit flags to 64-bit flags.
>
> Paul doesn't like C++-style comments so rewrite using kernel coding
> style for multi-line comments or drop.
> I don't think kernel coding style strictly prohibits use for
> single-line comments and it isn't detected by checkpatch.pl but he has
> previously
> raised this on other patches. I actually like the C++-style comments
> for one-liners especially for comments at the end of a line of code
> but Paul is the maintainer so he gets the final word.
>
> > +       switch (cmd) {
> > +       case FS_IOC32_GETFLAGS:
> > +               cmd =3D FS_IOC_GETFLAGS;
> > +               break;
> > +       case FS_IOC32_SETFLAGS:
> > +               cmd =3D FS_IOC_GETFLAGS;
>
> Sorry, missed this the first time but cut-and-paste error above:
> s/GETFLAGS/SETFLAGS/
>
> I didn't do an audit but does anything need to be updated for the BPF
> LSM or does it auto-magically pick up new hooks?
>
> Also, IIRC, Paul prefers putting a pair of parentheses after function
> names to distinguish them, so in the subject line
> and description it should be security_file_ioctl_compat() and
> security_file_ioctl(), and you should put a patch version
> in the [PATCH] prefix e.g. [PATCH v3] to make clear that it is a later
> version, and usually one doesn't capitalize SELinux
> or the leading verb in the subject line (just "selinux: introduce").

Actually, since this spans more than just SELinux, the prefix likely
needs to reflect that (e.g. security: introduce ...)
and the patch should go to the linux-security-module mailing list too
and perhaps linux-fsdevel for the ioctl change.

