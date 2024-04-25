Return-Path: <linux-kernel+bounces-158532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F468B21BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D1C1F22285
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD7B1494BE;
	Thu, 25 Apr 2024 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rax9chdB"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A424912BF04;
	Thu, 25 Apr 2024 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048666; cv=none; b=GOvpQ3gEzhzpOkpOD5d97vVuWWSEAjPvMSYdGnVkfc2nF4mG9sS4kP0B89/zwZNsf0BsiRVpBZ+0moupBmJYTOvTF1Y5P531swlM/bYJPBrVh/Qctqkum79FAooOOyxSs3eW4FxpN+WVIiiWPROXxp43KSMaNHtFo09jUcdWan8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048666; c=relaxed/simple;
	bh=S3lOyhz6DkqiOw/5d8g/aCQXAcDktxWVDYZdIIN5G/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtfPqnNJrzDYUgOThCHzZ5PFlakm0BB3zqVerkHadCBeMYlB6BEN0LYU9WjLJpmgukS3xhzj8pFxcF6nriRshpUQ3kd+vNFcBeY94XxW2897adiWfxg0k8rT7/MR2HMkPluVhmvP3QrCZodVp+b9Q+CX3OTNkBoFrdIVDzRIVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rax9chdB; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6eb86aeeb2cso519551a34.3;
        Thu, 25 Apr 2024 05:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714048663; x=1714653463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3lOyhz6DkqiOw/5d8g/aCQXAcDktxWVDYZdIIN5G/k=;
        b=Rax9chdBTg0/H9JFZVxGxd7lsvsuGIq3WSZoHPW2vI0/BRmq9G4keX6XNRCFcY0Xug
         91t2sdcnkfI+XXkIsdIbQqYqSUXULdljYOnVHZqfZYTFHk8LPoONkl7vPwLDGtr77nBg
         Hu7sAJBl1jEQZmA/BdkkWC/VN+987/QKdZ+xL6l/+tKZhA/r/eC3yGDOILsF6BM4FGU6
         S057WoQRIG1oebfEQDvppTh/GYQplT8jfdNL2W63153gZHculExgJiub+P4u7agRu3eh
         jH4iTMdo9lYDYZPk0mcpugvqxUnn4YIljj5iv3UiIwRpCN2h5Pcbn1C0jneN1FcIxSqn
         9xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714048663; x=1714653463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3lOyhz6DkqiOw/5d8g/aCQXAcDktxWVDYZdIIN5G/k=;
        b=WfJpU5WUxWAYY4iG4LapiUppwhSR6gBNAdKJjaagJEFijbO1vqsIzfMct+HCKfQVui
         0ALooDV4YgRd/TmQoWf+d/UpLWXvcH+yKGm/h5x9n5cJefqelQSGBqA1bAI8mWSGpFcL
         nR9jp4us2h0LjP7hPhBoghe4yTULqQkcnsvcfz1cC44cokcSrdAiVi9QtIWprw6nw54T
         2wbyU2NaSjmN6/ZNmzLq51wQHWrD7ri8sdVLucuCoCVLYh3RpihiFJBoYsSIxVSY2/bF
         o+yU5GakDtI0ZAGxKcBEj1HO5b2n72x2w7rlFkNpsV5Sf5Y2ZhQMC6IR2szhyYzQt3Yu
         a9OA==
X-Forwarded-Encrypted: i=1; AJvYcCUSO0uHwsymv4R7ouwJOLc7AVaJsOfF6xpzCaqtGY4f5Narqov6XaBnWstAOS4ZjpYwq9oEzwoo3pdYJzueHdxre0VfzALnLu6FPPxxjlnDIYQ4AGeosuOv6HBbnuMy/g34VTQjGg93F+w2+V1F01fTQhWdlJVXo8hxUAD3h63zRNHmkCdC4GONW2NwTA==
X-Gm-Message-State: AOJu0YzfD4g1r0SqLxv9Ss3XGkKc0x1tk3+QocajAdA4YkLGuT2TFQ1r
	qL++q2ffNJjTfNoRX8rbZbF51B335FWTPmdnWQfxfXxjgN+xcs69NrCgGEzlvBrTyLgNpSnVF9K
	ZcfcxhjhZMWupAyvUAU8X7Dv254E=
X-Google-Smtp-Source: AGHT+IFgqWRE7+8ruy9Bs7eP4Hnf8aIDsWFTYLHWXpSqv/KsxJodL25li7C3tZo5n3TzkIc+pdJ5iLc6O5PT+aGu9jA=
X-Received: by 2002:a05:6359:4181:b0:186:1146:2385 with SMTP id
 ki1-20020a056359418100b0018611462385mr5804567rwc.8.1714048663464; Thu, 25 Apr
 2024 05:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422150651.2908169-1-stefanb@linux.ibm.com>
 <CAOQ4uxgvHjU-n56ryOp5yWQF=yKz0Cfo0ZieypWJhqsBV4g-2w@mail.gmail.com> <a8da6b9f57095be494b8c38ca46e2a102b8eafac.camel@huaweicloud.com>
In-Reply-To: <a8da6b9f57095be494b8c38ca46e2a102b8eafac.camel@huaweicloud.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 25 Apr 2024 15:37:30 +0300
Message-ID: <CAOQ4uxjODtbaWPHS3bQvnEKuYAWTJa6kqsXCSzcsF1hJdThcsw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] ima: Fix detection of read/write violations on
 stacked filesystems
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zohar@linux.ibm.com, roberto.sassu@huawei.com, miklos@szeredi.hu, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 2:30=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2024-04-23 at 09:02 +0300, Amir Goldstein wrote:
> > On Mon, Apr 22, 2024 at 6:07=E2=80=AFPM Stefan Berger <stefanb@linux.ib=
m.com> wrote:
> > >
> > > This series fixes the detection of read/write violations on stacked
> > > filesystems. To be able to access the relevant dentries necessary to
> > > detect files opened for writing on a stacked filesystem a new d_real_=
type
> > > D_REAL_FILEDATA is introduced that allows callers to access all relev=
ant
> > > files involved in a stacked filesystem while traversing the layers.
> > >
> >
> > Stefan,
> >
> > Both Miklos and myself objected to this solution:
> > https://lore.kernel.org/linux-unionfs/CAJfpeguctirEYECoigcAsJwpGPCX2Nyf=
MZ8H8GHGW-0UyKfjgg@mail.gmail.com/
> >
> > Not sure what you are hoping to achieve from re-posting the same soluti=
on.
> >
> > I stopped counting how many times I already argued that *all* IMA/EVM
> > assertions,
> > including rw-ro violations should be enforced only on the real inode.
> > I know this does not work - so you should find out why it does not work=
 and fix
> > the problem.
> >
> > Enforcing IMA/EVM on the overlayfs inode layer is just the wrong way IM=
O.
> > Not once have I heard an argument from IMA/EVM developers why it is rea=
lly
> > needed to enforce IMA/EVM on the overlayfs inode layer and not on the
> > real inode.
>
> Ok, I try to provide an example regarding this, and we see if it makes
> sense.
>
> # echo test > test-file
> # chown 2000 d/test-file
> # ls -l a/test-file
> -rw-r--r--. 1 2000 root 25 Apr 25 10:50 a/test-file
>
> Initially there is a file in the lower layer with UID 2000.
>
>
> # mount -t overlay -olowerdir=3Da,upperdir=3Db,workdir=3Dc,metacopy=3Don =
overlay d
> # chown 3000 d/test-file
> # ls -l d/test-file
> -rw-r--r--. 1 3000 root 25 Apr 25 10:50 d/test-file
> # ls -l a/test-file
> -rw-r--r--. 1 2000 root 25 Apr 25 10:50 a/test-file
> # ls -l b/test-file
> -rw-r--r--. 1 3000 root 25 Apr 25 10:50 b/test-file
>
> If I have a policy like this:
>
> # echo "measure fsname=3Doverlay fowner=3D3000" > /sys/kernel/security/im=
a/policy
>
> there won't be any match on the real file which still has UID 2000. But
> what is observable by the processes through overlayfs is UID 3000.
>

ok, it is simple to write an ima policy that is not respected by overlayfs.

My question is: under what circumstances is a policy like the above
useful in the real world?

Correct me if I am wrong, but AFAIK, the purpose of IMA/EVM is to
mitigate attack vectors of tampering with files offline or after the
file's data/metadata were measured. Is that a correct description?

AFAIK, IMA/EVM policy is system-wide and not namespace aware
so the policy has to be set on the container's host and not inside
containers. Is that correct?

If those statements are true then please try to explain to me what is
the thread model for tampering with overlayfs files, without tampering
with the real upper and/or lower files.

My thesis is that if an IMA/EVM policy is good enough to prevent
tampering with the real lower/upper files, then no extra measures
are needed to protect the virtual overlayfs files against tampering.

Is my thesis flawed?
I'm pretty sure that it is, but I never got a satisfying answer why.

Thanks,
Amir.

