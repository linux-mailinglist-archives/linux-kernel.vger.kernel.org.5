Return-Path: <linux-kernel+bounces-4178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D328178DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0FF1C25257
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633EA5BFB2;
	Mon, 18 Dec 2023 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhAv2Xdc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809AC498B4;
	Mon, 18 Dec 2023 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d728c75240so1305194b3a.1;
        Mon, 18 Dec 2023 09:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921003; x=1703525803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGhfp7gmzYvPgDOx9Jk6h3Gpd+Z4OEn2fO5WRaWtC6k=;
        b=AhAv2Xdc+RBU4LGn15IqaYkr78pCY8shKY1loH70HSN2htGPHkzleb8DtI9ogxwmbI
         H6K7uqHI+24oUapebnv/y1JHdQ9haA6lUE87bmogoN0r5oto6xxvdGBADV7UysjvxnTM
         wp5dJ4HKE/R2G0LlxFUj+ZOa7mVQpVDFJOduTCxqdaHuPBfHyTD2NcCK3vskACezUXwY
         CZNCeBVZIL507bvCMmj4yFoGNck7W5t6z07XQ7x9MbURg+h5/mAF2kSgVKmf9x/3Te8K
         b0lnJ7r9+zfUBwgbw6c1AsQxkP9Klwz8TwLAim5x7MoOAWzEqoYuJSCuNre4GWGjNb84
         IKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921003; x=1703525803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGhfp7gmzYvPgDOx9Jk6h3Gpd+Z4OEn2fO5WRaWtC6k=;
        b=TjC0i01QuWnxJMkSamk3wgpUsEMUZOu7XmiySgJIHIXH3INDSHUT8Xtv77ukfMSxgK
         UqrPV4RHmCVHxjuvCJtkVDJ0HtL/IbT/Qz30m/656Rmg4WmXjrxNOGvRuBVYQO3EJo7t
         o7XDrSeTRoN1dhCE8dqdA1avXSTrq83dg7iSLhsyzbNhyixUUwzB+tJzN62Ya5eF9IrI
         PDIb6GdVicbl+rPW5OwudRMmXyVas1A2uksDPP2csVseDt3w2fWdCLClnARApmk9eqe7
         /gj05urTgY39HiXqzASvkGyTnWO4aBcdPAjpUUJlCADNFqw7kfnTt7NUdJoHPEXntWFp
         Pwsw==
X-Gm-Message-State: AOJu0Yw4GoGbmbErtAYrzbe6k+hDflxo0NdevkKszWPO4HwrtjGv2Rc5
	iVf/PMCmtaV3csht3N5usAvYeFRP9fNXR+Jcgbk=
X-Google-Smtp-Source: AGHT+IGFH6NC/VbWIOxGeQzth4/JK4wPgKzplt2ExS/F9myqeh5kM+roWD0j9O0HcbBzlhjNDDPTuJ+qyRy/ey3vUIg=
X-Received: by 2002:a05:6a21:a58e:b0:194:967f:3213 with SMTP id
 gd14-20020a056a21a58e00b00194967f3213mr47225pzc.73.1702921002664; Mon, 18 Dec
 2023 09:36:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218141645.2548743-1-alpic@google.com> <6dce3020-14f0-471b-9b6a-c9dc761cfa19@schaufler-ca.com>
In-Reply-To: <6dce3020-14f0-471b-9b6a-c9dc761cfa19@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 Dec 2023 12:36:31 -0500
Message-ID: <CAEjxPJ4tZAvch50i7Ve_7dPYUzCXK8ckDtmhwq81vjCf7pweQw@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Introduce security_file_ioctl_compat hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Alfred Piccioni <alpic@google.com>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@parisplace.org>, stable@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 12:11=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> On 12/18/2023 6:16 AM, Alfred Piccioni wrote:
>
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
>
> This *really* needs to go the the LSM email list:
>         linux-security-module@vger.kernel.org

Yep, pointed that out a little earlier in this thread.

> > ---
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> > index ac962c4cb44b..626aa8cf930d 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -171,6 +171,8 @@ LSM_HOOK(int, 0, file_alloc_security, struct file *=
file)
> >  LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
> >  LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
> >        unsigned long arg)
> > +LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cm=
d,
> > +      unsigned long arg)
>
> Please add a flags parameter to file_ioctl() rather than a new hook.

Paul told him the opposite earlier.

