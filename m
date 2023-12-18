Return-Path: <linux-kernel+bounces-4002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B9C817689
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853AC1F23DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50124FF80;
	Mon, 18 Dec 2023 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOC8Thm9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D100B4238B;
	Mon, 18 Dec 2023 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28b71490fbbso610517a91.0;
        Mon, 18 Dec 2023 07:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702915125; x=1703519925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1L/ez+Wv4K7wUuse7sZYv4iNUdOB14MYq1qAXqEUGk=;
        b=JOC8Thm9b0K6TK8vKxrKBwyahu+qXYYkjWEal1StL+jwTYm2Ibzq1LKR4J0e2j7TOz
         ekX1uZWLVjMMp9mbrTrpRNywcwK1ayZhRKDxbO3dOzVRSJ0fWhZE7QPEsFzx3ETawglP
         f8H9GrFvJ2dHRj8IdcrDZDbyMmCLOmiuA+KHeMA2x5w9+Y2rWVq3XhhmaC5qfnFNFdeE
         Z06jOI83xbSB+BhqHbkgecoqHgw7TPljgJQ4AOafhIv4yYBB7P6Xvcjus5CiSAhnDmrx
         ujOE1LAksJUEqKlGaE/5A2wGgWowrluQBbHJ29iq9AoEY3J6zziArLJk/+UJ/STCeHH4
         g30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915125; x=1703519925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1L/ez+Wv4K7wUuse7sZYv4iNUdOB14MYq1qAXqEUGk=;
        b=WgV3cOBnlsold0GCGhJzscItSMfsMrA9hw116VcMamXr5X91l/UAl5bzoy7lCUBUQc
         Mxf2ZX4k7u30Vyh9EbK3kPzpDRm5jnh+yUKzfqDebZ7VhclSl7FLIi2qboWvmay6hJ1v
         G3dS7GEBTvTJHwsc6sikvOw53cB+oZrls3fEAPvhm9vYhhcGWthvVC8oxbO1hn/WhVrS
         cfX0FwS7KJQ4+eysSd62INrCiPQUBHnWsxgoTpdNjFvZM1bXpyOG2nCkrGBr2rKq/Sun
         af/aoJPGe4ajP+waI0y7Gt90LD69rcEaGPW62XXc29XG8fpkkAXED8QgR+Z3RU0soeCg
         1EIw==
X-Gm-Message-State: AOJu0YzangxHkMnskjW7N3CxCEcgdv18R1HL6u6lhgPcFweae9h4OTb3
	5S9fkzDwnbeepZiGz/RgN/aEpqD0J1DgBwBIlRR8eQkk
X-Google-Smtp-Source: AGHT+IEv8eavEuw5TO6YbqO0CIa9S1vZ+DhDRS8y8ZGHNH845ST2fOLkih/5tge64KbKJSQ6tdCnQ9BubUxOVUVWoHY=
X-Received: by 2002:a17:90a:e657:b0:28b:95b0:d51b with SMTP id
 ep23-20020a17090ae65700b0028b95b0d51bmr587205pjb.82.1702915124936; Mon, 18
 Dec 2023 07:58:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218141645.2548743-1-alpic@google.com>
In-Reply-To: <20231218141645.2548743-1-alpic@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 Dec 2023 10:58:33 -0500
Message-ID: <CAEjxPJ40jPsBS5xZEgS1CCVYORDJhwNOrAj5Oepa3rK=Y1BnYg@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Introduce security_file_ioctl_compat hook
To: Alfred Piccioni <alpic@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>, stable@vger.kernel.org, 
	SElinux list <selinux@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 9:17=E2=80=AFAM Alfred Piccioni <alpic@google.com> =
wrote:
>
> Some ioctl commands do not require ioctl permission, but are routed to
> other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
> done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).
>
> However, if a 32-bit process is running on a 64-bit kernel, it emits
> 32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
> being checked erroneously, which leads to these ioctl operations being
> routed to the ioctl permission, rather than the correct file
> permissions.
>
> This was also noted in a RED-PEN finding from a while back -
> "/* RED-PEN how should LSM module know it's handling 32bit? */".
>
> This patch introduces a new hook, security_file_ioctl_compat, that is
> called from the compat ioctl syscal. All current LSMs have been changed

s/syscal/syscall/
Might to consider checking using codespell to catch such things
although it is imperfect.

> to support this hook.
>
> Reviewing the three places where we are currently using
> security_file_ioctl, it appears that only SELinux needs a dedicated
> compat change; TOMOYO and SMACK appear to be functional without any
> change.
>
> Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
> Signed-off-by: Alfred Piccioni <alpic@google.com>
> Cc: stable@vger.kernel.org
> ---

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2aa0e219d721..de96d156e6ea 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3731,6 +3731,31 @@ static int selinux_file_ioctl(struct file *file, u=
nsigned int cmd,
>         return error;
>  }
>
> +static int selinux_file_ioctl_compat(struct file *file, unsigned int cmd=
,
> +                             unsigned long arg)
> +{
> +       // If we are in a 64-bit kernel running 32-bit userspace, we need=
 to make
> +       // sure we don't compare 32-bit flags to 64-bit flags.

Paul doesn't like C++-style comments so rewrite using kernel coding
style for multi-line comments or drop.
I don't think kernel coding style strictly prohibits use for
single-line comments and it isn't detected by checkpatch.pl but he has
previously
raised this on other patches. I actually like the C++-style comments
for one-liners especially for comments at the end of a line of code
but Paul is the maintainer so he gets the final word.

> +       switch (cmd) {
> +       case FS_IOC32_GETFLAGS:
> +               cmd =3D FS_IOC_GETFLAGS;
> +               break;
> +       case FS_IOC32_SETFLAGS:
> +               cmd =3D FS_IOC_GETFLAGS;

Sorry, missed this the first time but cut-and-paste error above:
s/GETFLAGS/SETFLAGS/

I didn't do an audit but does anything need to be updated for the BPF
LSM or does it auto-magically pick up new hooks?

Also, IIRC, Paul prefers putting a pair of parentheses after function
names to distinguish them, so in the subject line
and description it should be security_file_ioctl_compat() and
security_file_ioctl(), and you should put a patch version
in the [PATCH] prefix e.g. [PATCH v3] to make clear that it is a later
version, and usually one doesn't capitalize SELinux
or the leading verb in the subject line (just "selinux: introduce").

