Return-Path: <linux-kernel+bounces-4465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEB8817DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645451C219B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ED3760B0;
	Mon, 18 Dec 2023 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F95aym8v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA47608B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbccbdacb9eso3147980276.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702940798; x=1703545598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ISbTIIGiRfCmq/xufZ2VhS6krg/p4Uisq2A0AgAr0o=;
        b=F95aym8v+e/B7FHOGKUzdNBrNJ4LU0XQODj6QLv6aSqDo1YrmjywRZfTWtthIi/ZnJ
         jl7fUBacAyUKKNaR90UvTFVrgI6O+zFHCl+UshXYXmm2XAoZM6c2YTDYOaHG+yHBmNQm
         pc3gkptqarYRjJZ0xul48F98hspNKqpHejgIx2CBCyDfIzV3oP+bB3Fi4ucGqdc+pJf3
         Z+kZW/W5fxp5zHLSN/YcyXQXqBkvKzK4Fcc35XGLiF7tRat+DrACuduTn0O6ZtRmbs87
         akAL6FDi5+Z8/ghkg8TMsod+4G5PwvaH1cokErMCuDQhoUYJQ0fjhAYtgDEGIpQ7ZcB5
         oGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702940798; x=1703545598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ISbTIIGiRfCmq/xufZ2VhS6krg/p4Uisq2A0AgAr0o=;
        b=e5bchtEA8fDLKJChGAoFhW5qxXng0EmGBijS5pJwijdF8jJPuN+jYmyrBynf28J4gl
         NMCn8VYu5/YZ+TO/F0aRs0uoh3kamT6ZrxTn9f+06ol6RQw3F2GGMAewSv2KE0UyL6TU
         eNc0Iz38sK/aykQBZGmvWJiwmcPJJclh5vmVriKrfIu6PD7ElHUs3zqfX6+PneeoTTsK
         tCT7q3aktIl/vQj0kgIL/3LhnVPU90smc3rm00yUHz3nDZ4Syt08Qcio0RwYrlwKNahG
         rYjfBayLifsVzI+Yk5hw3MkO2gSPkNgg/zPi37SnqtG01rYhTKAQPQ3PbPJ4DYpIsInS
         XqAw==
X-Gm-Message-State: AOJu0YzYNhsfoNI3WDl85/F7siZM71RxnoupYS2wer89/ECIVe7ZObwH
	Oy99p5wGncP2T87Lp/lmqtR5z71mb6jvj6mkVs34
X-Google-Smtp-Source: AGHT+IF9tvbbBtBESqqHaSUt2obipOpR1nDsNFSA0VBd9FiKyVi8ta2GbNjZyjCOzpO6p39Z4BPWa3ZnsyADLzk/ssU=
X-Received: by 2002:a5b:5cf:0:b0:db5:4532:8ea6 with SMTP id
 w15-20020a5b05cf000000b00db545328ea6mr10626822ybp.51.1702940798137; Mon, 18
 Dec 2023 15:06:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADN=F_ke996vNXDNz6vZ_As0Ms5Q2X7aT3t-SSGRiqdeKd6gCQ@mail.gmail.com>
 <20231216041116.GA78578@mail.hallyn.com>
In-Reply-To: <20231216041116.GA78578@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 18 Dec 2023 18:06:27 -0500
Message-ID: <CAHC9VhRmaT=gYM1qNaZ2D=9mz7vyhZLxU32gx11SpS2dNj_w5Q@mail.gmail.com>
Subject: Re: [PATCH] fixing userspace memory dereference in security.c
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: "T. Williams" <tdwilliamsiv@gmail.com>, jmorris@namei.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 11:11=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> On Wed, Oct 06, 2021 at 07:03:56PM -0400, T. Williams wrote:
> >  security/security.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/security/security.c b/security/security.c
> > index 9ffa9e9c5c55..7c41b5d732ab 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1737,6 +1737,8 @@ int security_kernel_read_file(struct file *file, =
enum
> > kernel_read_file_id id,
> >         int ret;
> >
> >         ret =3D call_int_hook(kernel_read_file, 0, file, id, contents);
> > +       if (ret > 0)
> > +               return -EINVAL;
> >         if (ret)
> >                 return ret;
> >         return ima_read_file(file, id, contents);
> > --
> > 2.25.1
> >
> > This commit is to fix a userspace address dereference found by
> > syzkaller.
> > The crash is triggered by passing a file descriptor to an incorrectly
> > formed kernel module to finit_module.
> >
> > Kernel/module.c:4175 : Within the finit_module, info.len is set to the
> > return value from kernel_read_file_from_fd. This value is then
> > dereferenced by memcmp within module_sig_check from inside load_module.
> > The value is 0xb000000 so the kernel dereferences user memory and kerne=
l
> > panics.
>
> Hi,
>
> thanks for sending this.  For some reason, I can't seem to find this
> message-id in lore.kernel.org to see if there were ever any replies.

I'm not sure where the original email/patch was sent, but I don't seem
to have a copy in my inbox either.  Odd.

> There is indeed a problem, although I think a more concise explanation
> is:
>
> 1. security_kernel_read_file() returns any non-zero return value to mean
> permission denied
> 2. kernel_read_file() returns > 0 meaning number of bytes read
> 3. hen kernel_read_file() gets any non-zero rv from security_kernel_read_=
file(),
> it returns that value unchanged.
>
> Since kernel_read_file() is the only caller of security_kernel_read_file(=
),
> I think your patch is good, except you should also change the comment abo=
ve
> it to read
>
>  * Return: Returns 0 if permission is granted, < 0 on error.
>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
>
> I think the reason it's not been a practical problem is because while
> security_kernel_read_file() will honor a >0 error from an LSM, no
> LSM implementation of that hook does that.  (Only loadpin and selinux
> implement it)

The SELinux implementation should only ever return 0 or a negative
value, and based on a quick look at Loadpin I would say the same
applies there as well.  This patch doesn't address the IMA hook, but
according to the comments in the IMA code, it too should only return 0
or a negative value.  While it is theoretically possible that
security_kernel_read_file() could return a positive value, I'm missing
where/how that might happen.  Help?

That said, I agree with Serge that this is worth fixing, and in
addition to the comment suggestion from Serge, I would ask that you
fix the IMA hook too.  I would expect the patch to look something like
this:

diff --git a/security/security.c b/security/security.c
index dcb3e7014f9b..dd8bdda166f3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3043,7 +3043,7 @@ int security_kernel_module_request(char *kmod_name)
 *
 * Read a file specified by userspace.
 *
- * Return: Returns 0 if permission is granted.
+ * Return: Returns 0 if permission is granted, negative values on failure.
 */
int security_kernel_read_file(struct file *file, enum kernel_read_file_id i=
d,
                             bool contents)
@@ -3052,8 +3052,15 @@ int security_kernel_read_file(struct file *file, enu=
m ker
nel_read_file_id id,

       ret =3D call_int_hook(kernel_read_file, 0, file, id, contents);
       if (ret)
+               goto out;
+       ret =3D ima_read_file(file, id, contents);
+
+out:
+       if (ret > 0)
+               return -EINVAL;
+       if (ret < 0)
               return ret;
-       return ima_read_file(file, id, contents);
+       return 0;
}
EXPORT_SYMBOL_GPL(security_kernel_read_file);

--=20
paul-moore.com

