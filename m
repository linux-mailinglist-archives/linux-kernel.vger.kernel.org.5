Return-Path: <linux-kernel+bounces-84479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D7C86A73E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F421F243B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7B3200C3;
	Wed, 28 Feb 2024 03:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="yCHFhW49"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FC4200AE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709091486; cv=none; b=uiiS3dUcHp76KmRqwqLMa6tqAj2Gq7trDHUZGpQGQdWfmArA17W0rBBc1fMzbWICHr73QS4ZAxmBAQyJnXp2hisjXEXu/9rZ38sxN0+sXFK+1wY88XzVXosUVNrO+CeWaSqbUEQfu8shyGr+v8xglGEx49JVcwEwuMEYMwi/ZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709091486; c=relaxed/simple;
	bh=U2++s3OeCJGOULSZUUZo8hHVoCQ6BAPgrUnJFwDAvIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDVr7I3k0gj/umq3fLjPYWGFIWu35DudZyfE+kuHhoX7V0PCTRMS6TYQHGX0mBJj51qUMkY2Hdvfi5nCsLoQONDuSCCg1pHQ+4YUjBBOjmPutMHSSCQCZ8EWShgzzWZrPtK8/dUPKbFccEaq89UeOhfaG4wchve2dvgT0xp7UwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=yCHFhW49; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d220e39907so78538951fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1709091483; x=1709696283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFvziemSaBFHTaih9BhhIY7C9Ip2c7a+1OQjYB8BekQ=;
        b=yCHFhW49rnI6mpSIOkBq2WPD3Wkw/s4P9vx4WcipSkfBq9E5dXzaMd0Ia7xC7iGvff
         MQsmP7teM8bcQzOgntdwoWQRv/jE45+Afzz08PPkcOqx/8b28ccXtxoI3hVf8TGjQj+i
         5zqVIIHJvcqX6PCRhPxM+pxsedCcMYjk0B97LO6l2fqkkmqqEuV2fPJEDJxMeDpqP+bI
         BlCgMJmQ9TkNXT0cYQ+g1NU6JnvOX/VRHW6jvLGvSXQD8oPf3pZ3vgS0fYh6Cr4NOpQa
         +R1UcTpnuT6eViioGG4E7+mSuAMobRL5o4Ja1C/N2Lfbd690eKZDcdm6YyiXcM7XZicX
         HpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709091483; x=1709696283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFvziemSaBFHTaih9BhhIY7C9Ip2c7a+1OQjYB8BekQ=;
        b=pqzPyljPeWOf2mNtlSWk1sw1O1iTyaOmO6dJ0LkcNK5IqlR6P6v8cvT5KWsIQYK0Iq
         zJ1PKPGAJvGolChiiE/92ch22THb4eebkrljqfXrH48hTq6zRvi+FZLv0DCJ2v1pwLnZ
         Faiikb0kHfjO6TmI5oQpUfUEA4ntfmoIpt12r93IMWIdiepRAaOF+7tAbwPv4C5Euc+z
         Ff0De1CLCWRlSZSqdQSbva797b7EEm0IO1g82NWjhu7g80MusRXVH2QQz47gind5/vbh
         oNFTZYT2GUvXS3j2XEF2gVEmg2WW3SZISbl9N+N1fy5qOJux1S/jjTIhT2Zlc6XMHj4F
         yYSA==
X-Forwarded-Encrypted: i=1; AJvYcCUqFWaBu7VU1uRMXkUUJKALI0Y+GYoJ6rGPAtO24J2Te+XRAnj/8X1lZanKlPzeMyzM+eWFwZ9m5FOKAEdRlgFWnakzMShZRIC5o0JN
X-Gm-Message-State: AOJu0YypHBk32LuW0P5nrjYoKbGE+rw+wj2TcdENx7agUWiYpSLdfDcn
	qhrbF4cj4xvaaJL2pp4OEj+EnYZIuOmgrnX9t6lUm1WaUXuCBFcc2+wetFAmIKXsHcX2L3ocWAz
	Vy/XN1dduaWSAjYaxgqrNwKn24QLZYjkhewQDjA==
X-Google-Smtp-Source: AGHT+IGuWhMPIZ2sg0pLZLqLPlZdB7C6gQOkXtDFGYhwRqS/xlI5mnTpmFYiIdAmH6iOdLraDOE0T0c5J+jFjERN3iE=
X-Received: by 2002:a05:651c:546:b0:2d2:5057:bbf4 with SMTP id
 q6-20020a05651c054600b002d25057bbf4mr9614633ljp.20.1709091482585; Tue, 27 Feb
 2024 19:38:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPKjjnrYvzH8hEk9boaBt-fETX3VD2cjjN-Z6iNgwZpHqYUjWw@mail.gmail.com>
 <77a58302766cb6c8fac45682ede63569df80cd5d.camel@hammerspace.com>
 <1179779e2f74e3e5cb2be30cf89e6362aaab706d.camel@kernel.org>
 <CAPKjjnrir1C8YYhhW10Nj6bAOTiz_YwWUOynEwXbjetMAuA1UA@mail.gmail.com> <170907814318.24797.17138350642031030344@noble.neil.brown.name>
In-Reply-To: <170907814318.24797.17138350642031030344@noble.neil.brown.name>
From: Zhitao Li <zhitao.li@smartx.com>
Date: Wed, 28 Feb 2024 11:37:49 +0800
Message-ID: <CAPKjjnpNV9Eq1bxFc3XLjLxFWqJ5_5a_vqC+aUK_t4dGBE7cxw@mail.gmail.com>
Subject: Re: PROBLEM: NFS client IO fails with ERESTARTSYS when another mount
 point with the same export is unmounted with force [NFS] [SUNRPC]
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@hammerspace.com>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "tom@talpey.com" <tom@talpey.com>, 
	"anna@kernel.org" <anna@kernel.org>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, 
	"kolga@netapp.com" <kolga@netapp.com>, "huangping@smartx.com" <huangping@smartx.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your help.

The fix does work in my cases. "dd" fails with EIO when its mount
point or another mount point with the same export is unmounted with
force.

1. Another mount point is unmounted with force:
[root@v6 zhitaoli]#   dd if=3D/dev/urandom of=3D/mnt/test/1G bs=3D1M
count=3D1024 oflag=3Ddirect
dd: error writing '/mnt/test/1G': Input/output error
100+0 records in
99+0 records out
103809024 bytes (104 MB, 99 MiB) copied, 5.05276 s, 20.5 MB/s

2. The mount point is unmounted with force:
[root@v6 zhitaoli]#   dd if=3D/dev/urandom of=3D/mnt/test/1G bs=3D1M
count=3D1024 oflag=3Ddirect
dd: error writing '/mnt/test/1G': Input/output error
60+0 records in
59+0 records out
61865984 bytes (62 MB, 59 MiB) copied, 2.13265 s, 29.0 MB/s

Best regards
Zhitao Li, at SmartX

On Wed, Feb 28, 2024 at 7:55=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
>
> On Fri, 23 Feb 2024, Zhitao Li wrote:
> > Thanks for Jeff's reply.
> >
> > I did see  ERESTARTSYS in userland. As described in the above
> > "Reproduction" chapter, "dd" fails with "dd: error writing
> > '/mnt/test1/1G': Unknown error 512".
> >
> > After strace "dd", it turns out that syscall WRITE fails with:
> > write(1, "4\303\31\211\316\237\333\r-\275g\370\233\374X\277\374Tb\202\2=
4\365\220\320\16\27o3\331q\344\364"...,
> > 1048576) =3D ? ERESTARTSYS (To be restarted if SA_RESTART is set)
> >
> > In fact, other syscalls related to file systems can also fail with
> > ERESTARTSYS in our cases, for example: mount, open, read, write and so
> > on.
> >
> > Maybe the reason is that on forced unmount, rpc_killall_tasks() in
> > net/sunrpc/clnt.c will set all inflight IO with ERESTARTSYS, while no
> > signal gets involved. So ERESTARTSYS is not handled before entering
> > userspace.
> >
> > Best regards,
> > Zhitao Li at SmartX.
> >
> > On Thu, Feb 22, 2024 at 7:05=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Wed, 2024-02-21 at 13:48 +0000, Trond Myklebust wrote:
> > > > On Wed, 2024-02-21 at 16:20 +0800, Zhitao Li wrote:
> > > > > [You don't often get email from zhitao.li@smartx.com. Learn why t=
his
> > > > > is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > >
> > > > > Hi, everyone,
> > > > >
> > > > > - Facts:
> > > > > I have a remote NFS export and I mount the same export on two
> > > > > different directories in my OS with the same options. There is an
> > > > > inflight IO under one mounted directory. And then I unmount anoth=
er
> > > > > mounted directory with force. The inflight IO ends up with "Unkno=
wn
> > > > > error 512", which is ERESTARTSYS.
> > > > >
> > > >
> > > > All of the above is well known. That's because forced umount affect=
s
> > > > the entire filesystem. Why are you using it here in the first place=
? It
> > > > is not intended for casual use.
> > > >
> > >
> > > While I agree Trond's above statement, the kernel is not supposed to
> > > leak error codes that high into userland. Are you seeing ERESTARTSYS
> > > being returned to system calls? If so, which ones?
> > > --
> > > Jeff Layton <jlayton@kernel.org>
> >
>
> I think this bug was introduced by
> Commit ae67bd3821bb ("SUNRPC: Fix up task signalling")
> in Linux v5.2.
>
> Prior to that commit, rpc_killall_tasks set the error to -EIO.
> After that commit it calls rpc_signal_task which always uses
> -ERESTARTSYS.
>
> This might be an appropriate fix.  Can you please test and confirm?
>
> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
> index 2d61987b3545..ed3a116efd5d 100644
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -222,7 +222,7 @@ void                rpc_put_task(struct rpc_task *);
>  void           rpc_put_task_async(struct rpc_task *);
>  bool           rpc_task_set_rpc_status(struct rpc_task *task, int rpc_st=
atus);
>  void           rpc_task_try_cancel(struct rpc_task *task, int error);
> -void           rpc_signal_task(struct rpc_task *);
> +void           rpc_signal_task(struct rpc_task *, int);
>  void           rpc_exit_task(struct rpc_task *);
>  void           rpc_exit(struct rpc_task *, int);
>  void           rpc_release_calldata(const struct rpc_call_ops *, void *)=
;
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index cda0935a68c9..cdbdfae13030 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -895,7 +895,7 @@ void rpc_killall_tasks(struct rpc_clnt *clnt)
>         trace_rpc_clnt_killall(clnt);
>         spin_lock(&clnt->cl_lock);
>         list_for_each_entry(rovr, &clnt->cl_tasks, tk_task)
> -               rpc_signal_task(rovr);
> +               rpc_signal_task(rovr, -EIO);
>         spin_unlock(&clnt->cl_lock);
>  }
>  EXPORT_SYMBOL_GPL(rpc_killall_tasks);
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index 6debf4fd42d4..e88621881036 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -852,14 +852,14 @@ void rpc_exit_task(struct rpc_task *task)
>         }
>  }
>
> -void rpc_signal_task(struct rpc_task *task)
> +void rpc_signal_task(struct rpc_task *task, int sig)
>  {
>         struct rpc_wait_queue *queue;
>
>         if (!RPC_IS_ACTIVATED(task))
>                 return;
>
> -       if (!rpc_task_set_rpc_status(task, -ERESTARTSYS))
> +       if (!rpc_task_set_rpc_status(task, sig))
>                 return;
>         trace_rpc_task_signalled(task, task->tk_action);
>         set_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
> @@ -992,7 +992,7 @@ static void __rpc_execute(struct rpc_task *task)
>                          * clean up after sleeping on some queue, we don'=
t
>                          * break the loop here, but go around once more.
>                          */
> -                       rpc_signal_task(task);
> +                       rpc_signal_task(task, -ERESTARTSYS);
>                 }
>                 trace_rpc_task_sync_wake(task, task->tk_action);
>         }

