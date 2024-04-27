Return-Path: <linux-kernel+bounces-160969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6778B4543
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FA02828EE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CF545944;
	Sat, 27 Apr 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdPlvTPZ"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C7F3D72;
	Sat, 27 Apr 2024 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714208614; cv=none; b=GOWaGvf5URGsMNzHPQHd5/9WB0KDk7oduU64p6A5S7Jp4V5zW2xL98Qy2r7kplZJKl/MSmxFQarXgnyhfi2mHYni6a5Fa14pUzJxd28xgrttPBcDMSipvruG2rgiqvPitjFZDoILxKbojDYBQOXqBdjyxov9iSduAYNczPLWLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714208614; c=relaxed/simple;
	bh=v4BNkumgcK7r4rigaE/yRndOtENZtM/o9zp8DL4bluU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYnlLElKc47k5HMrt0wiL5h13bT9yK06McviRrQI1AWzz0rNFqMN3o0s4oLrcKAi5sV5N0G0q9vlcxa0U3W67Et6RLWkp88qYjDyfgoJn4iFx+LRZ4Nj1NPtLSsrnl9J2kDwbIaWNL6UQDnZW8i4faHInl65iJmlQZ7mNsOYEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdPlvTPZ; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c74abe247bso1758071b6e.3;
        Sat, 27 Apr 2024 02:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714208610; x=1714813410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4BNkumgcK7r4rigaE/yRndOtENZtM/o9zp8DL4bluU=;
        b=XdPlvTPZIeQK5EZmF8Vl88tPtY37W/TxiRDMa/NIhrAhOEVqXQXXvNTscwNHX1voS7
         128mxRGt4bnbfHEtCmQVBSO8u8bMk9hFCzV514HaJw1rSH+g3OkEyl+HaBWVZTgwzSOk
         hFNRWrIdIYyYUQx4PsebfUzlK0/09J6ka2Gasmp34PdyFMEmXF6+yikiYRnxrsLiAEHj
         JoRjZ2KxC+0nhEReGPqhivD4zhVyVf0gjJgofMLeHqewZlMetmGPrhtwAem3DO3qB2Xw
         I9GabWa/tFi0K2LbLDgnQR6QHv6/iU1jhBcd5x8Y+/AUOh/hkMkaIoWM+HDbO27o6HiB
         qmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714208610; x=1714813410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4BNkumgcK7r4rigaE/yRndOtENZtM/o9zp8DL4bluU=;
        b=RSDZF/QwmWRX0aJ+TpIFxWnEMxGdXvf7mVBpZecx1DfV1sYBWVChhviw1w8tdcyBDs
         J9E8fkYhjVdIOxBOdosxh2vYwWJn7RI0ZqNkGmR073Ca8wUDS2rrryvoI7JVeZ9jaC9O
         n+xDS5fPeRdeCCKTuVRe7n7jkkSuceBe5LflR0NiovmFlj15M7e7e4o0H4785D3BwF0Z
         GGdEaWiwWc/krnngktw50LrEosYBJrzyIqyUOzB7mX3NXeq/kDDqqinETNb+IVZKjNxp
         f6ONzKQ/n7gTke7B7Ca/rW+ggZY2yczVfGQ8UpXmpU4zzDMW9DwLAwJhrLGQG+6lTVmg
         J8lA==
X-Forwarded-Encrypted: i=1; AJvYcCWPPLjmwh+w1WLnhkUhCt1VG063MJNtaQy5wjibiPDpwzbCuQ1A3dxcnCVGOD9SGdWwkhOOPh4/lo8C6fd3r+3P8761C9I/arV0J4iRwr4DacrOjzsql4UF+AZ4T0jY+4qFN5XEnt8fEZ+CTfYIkz11JuDntkfeTZOSx35K07OebyMb5c0CFoNAoTQIOA==
X-Gm-Message-State: AOJu0YxmQvYYexW3E6IXKTV2A+r/IYML8uTlu2Z5UJDOfD5DNzqA++lU
	OnwTw5GSXPRXwjZfoKpY0FJwiKNWaaPgWCbffMV/qFC0PXzCn08Lf6OAELzL98nlGi4OsBUJQWR
	Pxsuq5lAro32jzIas3WoFwj9GGVo=
X-Google-Smtp-Source: AGHT+IFieseYJH5MvcOXnNDmSqiQWAx/xRXteYE5G0LRIzNSjJTJxqGDhJ6IdMiM2efVOe9N4MtNiJ/Wyj76aSk/1tA=
X-Received: by 2002:a05:6808:1249:b0:3c7:4976:7953 with SMTP id
 o9-20020a056808124900b003c749767953mr7445673oiv.3.1714208610449; Sat, 27 Apr
 2024 02:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422150651.2908169-1-stefanb@linux.ibm.com>
 <CAOQ4uxgvHjU-n56ryOp5yWQF=yKz0Cfo0ZieypWJhqsBV4g-2w@mail.gmail.com>
 <a8da6b9f57095be494b8c38ca46e2a102b8eafac.camel@huaweicloud.com>
 <CAOQ4uxjODtbaWPHS3bQvnEKuYAWTJa6kqsXCSzcsF1hJdThcsw@mail.gmail.com> <2b28414a7c7e4c53057ef8e527f85c05eb225d85.camel@huaweicloud.com>
In-Reply-To: <2b28414a7c7e4c53057ef8e527f85c05eb225d85.camel@huaweicloud.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 27 Apr 2024 12:03:18 +0300
Message-ID: <CAOQ4uxjd3e2M4_dF4_jVhghMCmtuZT01hWCMeiuA_=1HFfrS1w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] ima: Fix detection of read/write violations on
 stacked filesystems
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zohar@linux.ibm.com, roberto.sassu@huawei.com, miklos@szeredi.hu, 
	brauner@kernel.org, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 10:34=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Thu, 2024-04-25 at 15:37 +0300, Amir Goldstein wrote:
> > > On Thu, Apr 25, 2024 at 2:30=E2=80=AFPM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > >
> > > > > On Tue, 2024-04-23 at 09:02 +0300, Amir Goldstein wrote:
> > > > > > > On Mon, Apr 22, 2024 at 6:07=E2=80=AFPM Stefan Berger <stefan=
b@linux.ibm.com> wrote:
> > > > > > > > >
> > > > > > > > > This series fixes the detection of read/write violations =
on stacked
> > > > > > > > > filesystems. To be able to access the relevant dentries n=
ecessary to
> > > > > > > > > detect files opened for writing on a stacked filesystem a=
 new d_real_type
> > > > > > > > > D_REAL_FILEDATA is introduced that allows callers to acce=
ss all relevant
> > > > > > > > > files involved in a stacked filesystem while traversing t=
he layers.
> > > > > > > > >
> > > > > > >
> > > > > > > Stefan,
> > > > > > >
> > > > > > > Both Miklos and myself objected to this solution:
> > > > > > > https://lore.kernel.org/linux-unionfs/CAJfpeguctirEYECoigcAsJ=
wpGPCX2NyfMZ8H8GHGW-0UyKfjgg@mail.gmail.com/
> > > > > > >
> > > > > > > Not sure what you are hoping to achieve from re-posting the s=
ame solution.
> > > > > > >
> > > > > > > I stopped counting how many times I already argued that *all*=
 IMA/EVM
> > > > > > > assertions,
> > > > > > > including rw-ro violations should be enforced only on the rea=
l inode.
> > > > > > > I know this does not work - so you should find out why it doe=
s not work and fix
> > > > > > > the problem.
> > > > > > >
> > > > > > > Enforcing IMA/EVM on the overlayfs inode layer is just the wr=
ong way IMO.
> > > > > > > Not once have I heard an argument from IMA/EVM developers why=
 it is really
> > > > > > > needed to enforce IMA/EVM on the overlayfs inode layer and no=
t on the
> > > > > > > real inode.
> > > > >
> > > > > Ok, I try to provide an example regarding this, and we see if it =
makes
> > > > > sense.
> > > > >
> > > > > # echo test > test-file
> > > > > # chown 2000 d/test-file
> > > > > # ls -l a/test-file
> > > > > -rw-r--r--. 1 2000 root 25 Apr 25 10:50 a/test-file
> > > > >
> > > > > Initially there is a file in the lower layer with UID 2000.
> > > > >
> > > > >
> > > > > # mount -t overlay -olowerdir=3Da,upperdir=3Db,workdir=3Dc,metaco=
py=3Don overlay d
> > > > > # chown 3000 d/test-file
> > > > > # ls -l d/test-file
> > > > > -rw-r--r--. 1 3000 root 25 Apr 25 10:50 d/test-file
> > > > > # ls -l a/test-file
> > > > > -rw-r--r--. 1 2000 root 25 Apr 25 10:50 a/test-file
> > > > > # ls -l b/test-file
> > > > > -rw-r--r--. 1 3000 root 25 Apr 25 10:50 b/test-file
> > > > >
> > > > > If I have a policy like this:
> > > > >
> > > > > # echo "measure fsname=3Doverlay fowner=3D3000" > /sys/kernel/sec=
urity/ima/policy
> > > > >
> > > > > there won't be any match on the real file which still has UID 200=
0. But
> > > > > what is observable by the processes through overlayfs is UID 3000=
.
> > > > >
> > >
> > > ok, it is simple to write an ima policy that is not respected by over=
layfs.
> > >
> > > My question is: under what circumstances is a policy like the above
> > > useful in the real world?
> > >
> > > Correct me if I am wrong, but AFAIK, the purpose of IMA/EVM is to
> > > mitigate attack vectors of tampering with files offline or after the
> > > file's data/metadata were measured. Is that a correct description?
>
> (For now I would talk about IMA, EVM can be considered separately).
>
> The main purpose of IMA is to evaluate files being accessed, and record
> the access together with a file digest in a measurement list,
> allow/deny access to the file (appraisal), or add a new event to audit
> logs.
>
> How files are selected depends on the IMA policy. A rule can be
> subject-based or object-based, depending on whether respectively
> process or file attributes are matched. It can also be both.
>
> A subject-based rule means that you identify a process/set of
> processes, and you evaluate everything it/they read.
>
> An object-based rule means that you identify a file/set of files, and
> you evaluate any process accessing them.
>
> Since processes normally would access the top most layer (overlayfs),
> the IMA policy should be written in terms of metadata seen in that
> layer (but not necessarily).
>
> This is just for identifying the set of files to
> measure/appraise/audit, not which file is going to be evaluated, which
> will be always the persistent one.
>
> I have to admit, things are not very clear also to me.
>
> Suppose you have a file in the lower filesystem with SELinux label
> user_t, and then on overlayfs with metadata copy, you change the label
> of this file to unconfined_t.
>
> What will happen exactly? On the overlayfs layer, you will have a
> permission request with the new label unconfined_t, but when overlayfs
> calls vfs_open(), there will be another permission request with the old
> label.

CC Vivek who was involved with ovl+selinux, but I think the answer is
that ovl sepolicy is expected to be associated with the mount ctx and
not the objects and there was a need to implement the security hook
security_inode_copy_up() to be able to compose a safe sepolicy for
overlayfs.

>
> It is kind of the same challenge we are facing with IMA, we can observe
> the file operations at different layers. That is why I think having
> stacked IMA calls is a good idea (other than really fixing the
> violations).
>
> The current problem, that is very difficult to solve, is that the
> policy should cover all layers, or some events will be missed. Now we
> have overlayfs-specific code to detect changes in the backing inode,
> while with stacked IMA calls, we can detect the change at the layer
> where it happened (and we can remove the overlayfs-specific code).
>
> Ideally, what I would do to cover all layers is that if there is a
> match at one layer, the lower layers should automatically match too,
> but it is not that easy since after the vfs_open() recursive calls we
> start calling IMA in the botton most layer first.
>
> (What I did with the stacked IMA calls is just an experiment to see how
> far we can go, but still we didn't make any decision with Mimi).
>
> > > AFAIK, IMA/EVM policy is system-wide and not namespace aware
> > > so the policy has to be set on the container's host and not inside
> > > containers. Is that correct?
>
> I know that overlayfs is primarily aiming at containers, but I would
> suggest to not add that complexity yet and just consider the host.
>
> > > If those statements are true then please try to explain to me what is
> > > the thread model for tampering with overlayfs files, without tamperin=
g
> > > with the real upper and/or lower files.
>
> I hope at this point is clear that what we care about is that, or the
> process is reading the content of the file whose digest is recorded in
> the measurement list, or we must signal to remote verifiers concurrent
> accesses that make the statement above false.
>
> > > My thesis is that if an IMA/EVM policy is good enough to prevent
> > > tampering with the real lower/upper files, then no extra measures
> > > are needed to protect the virtual overlayfs files against tampering.
>
> What you say is correct, but the way you identify files to
> measure/appraise/audit can be different.
>

IIUC, the problem as you described it, is similar to the problem
of how to display the overlayfs path of mmaped files in /proc/self/maps
when the actual inode mapped to memory is the real inode.

The solution for this problem was the somewhat awkward
"file with fake path" - it was recently changed to use the new
file_user_path() helper.

I'm not sure how this can help IMA, but in theory, you could
always attach iint state to the real inode and only the the real inode
but the rules that filter by path/object in the IMA hooks that take a file
argument could take file_user_path() into account.

For example, if you have security_file_post_open(f) in
backing_file_open(), then you can use d_real_inode()
in process_measurement to get to the IMA state and check the
rules referring to the real inode and you can use file_user_path(file)
to check the rules referring to "front object".

In case of a nested overlayfs, you should get two post_open
hook, both will refer to the same IMA state on the real inode, but
each hook with have a different file_user_path(), so you will have
an opportunity to apply the path/object based rules on every layer
in the nested overlayfs.

I hope what I tried to explain is clear and I hope there are not
many traps down this road, but you won't know unless you try...

Thanks,
Amir.

