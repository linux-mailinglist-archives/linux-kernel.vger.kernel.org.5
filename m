Return-Path: <linux-kernel+bounces-100144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350FC879281
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAFF2848B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6CA78691;
	Tue, 12 Mar 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFi+yl0P"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7AA69D19;
	Tue, 12 Mar 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240788; cv=none; b=iPRVnI+t8r8+hlr6vX4UXkz7DnU0FWqrvJFyCs/P0q2YhdZFltNiL+E6ssWiSiIU4Zs6fRsNxmu2nEgbb3OX7+BVaebOVSJoYs0+MzTr/b02mRqYUniQfCuToMcYLkPPwnJ7gX2fz4AZan9UuBzTAXXrZyYfeXWRrc2Biguu5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240788; c=relaxed/simple;
	bh=21sPzVqCpe9Bu6E5sNlUPDDKaI+J6n1hzyLr6L7M8XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQ05XeloKmm2Mo8BLTMWvA6Gye2OQJvoaRIYOWUrnc4wdCxBl+9AUnPd2NI32SMJPcF/WkEgLO0g3jIdUk9N12dOUyf9NSJNPmoRixuz/ecm3++25KrE4QzSfINEvHOT88jxr08sQXMbCZ5ZhNY00/Opt98T+Qomt/SuEBRBJ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFi+yl0P; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6ac58fceaso187513b3a.1;
        Tue, 12 Mar 2024 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710240786; x=1710845586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZznXNjVeq+b2FHapg7fwjhxTSL0Z+swW5s5prYsEekk=;
        b=OFi+yl0PTHyyF5jxT5QSBAzwFhGdcorPip+9dmNGNO81jtJRR2Q2PEGoqga08KTRoO
         y50DzEn186upSoIYRVjz2HRnnc3wuEvvxd0Ro2SZ2JAOcGEwgktspqklV1fi/Rs8VuRM
         5u5Rt9Szj0pMPgoW7tn3mpXdSc4dRyX0ryKLLm7r7isPxeqMzSNjK5wrGsuLjkdwfrK6
         nWYxrO5CoFWKSrx6TZ1iNZtC9mxATcf9Lq8NgFdzxNQ/xcbpMkbwboqx+0DTvLUNtXnL
         oJqS+qDDG0w37DV2MMfoKzgpnfnO8CXJG02+n0HbHZWdI1rLcTMqrVKveM7XmI9wazRH
         cLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710240786; x=1710845586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZznXNjVeq+b2FHapg7fwjhxTSL0Z+swW5s5prYsEekk=;
        b=StD/8D0NtdqaH3kbP+PptbfqcBaswdoayJPRJyoJktySJCuyb2Z/k24VVgkxRDtHqC
         vpk+LYVPUye8hR4Cd0v9HmUVm77A63RMXVDWOg3G85jx7r2tQaTB4EKT/th9CEZPEBo9
         zAPEHHxpwGPowCgP6hzYCpHJPzH8IVRAanJ7b59pZg6JhvL0HVq266DwFpWTTaWGluRm
         kQ25NsKNFop89GlzdvIFd37pqPlUuSmxi+XvaALT+5bJBm06vox2DD6yVBqXU8s4kO9e
         luUM1sXQBDQZlRFAp3PKCnSkRWGHwDXhAyKcQjZpXOvn9CNnvsEh/WU2buwaO3zm9Jos
         ULjw==
X-Forwarded-Encrypted: i=1; AJvYcCU3IZV6F0mtnPYK6TrkLWzGt5qgAmcWmLwze4W9KLLghZqQwsYRQ8yPAEvnjDHVPSiZmKWALLRTHoPpr9vOTzs++IrroeZnjwSN5n7l8xb66QrR9INe1a557hstC9X/nGXamWRWLI2iPA==
X-Gm-Message-State: AOJu0YyIUkbmA2ybj2KbKSv9Ikwgs92VGQpmHJXjsGxhBwPWghvWNIDf
	x7EzloiP535rV3ZYZtKoXhUMXDVN9wquqZ6PY4EprIFJ+43rvYdPrnZtfKTDUzyXmn+ZQNaeFGd
	ntxidd/Ltg3cvLFaHh9voJtVdtVnwg89wa8U=
X-Google-Smtp-Source: AGHT+IFjHeY6HhfTuyFgKpYo/k58yJNIp27rE2z2gfm/QYKl2MRNnv00rkGRH6uGW5byN3mqcujjs/Vhpgm63vaBfRg=
X-Received: by 2002:a05:6a20:5484:b0:1a1:6a75:143b with SMTP id
 i4-20020a056a20548400b001a16a75143bmr1412598pzk.5.1710240786479; Tue, 12 Mar
 2024 03:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129133352.25a3ee19@canb.auug.org.au> <20240312085301.66009b5f@canb.auug.org.au>
In-Reply-To: <20240312085301.66009b5f@canb.auug.org.au>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 12 Mar 2024 11:52:54 +0100
Message-ID: <CANiq72mPv2bKA5_MGGdOAi7rdGs+5P892JwvXAn+JbeFoMkRDA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 10:53=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>
> On Mon, 29 Jan 2024 13:33:52 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > diff --cc Documentation/process/changes.rst
> > index d7306b8cad13,eab7e2f8c196..000000000000
> > --- a/Documentation/process/changes.rst
> > +++ b/Documentation/process/changes.rst
> > @@@ -30,8 -30,8 +30,8 @@@ you probably needn't concern yourself w
> >           Program        Minimal version       Command to check the ver=
sion
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >   GNU C                  5.1              gcc --version
> >  -Clang/LLVM (optional)  11.0.0           clang --version
> >  +Clang/LLVM (optional)  13.0.1           clang --version
> > - Rust (optional)        1.74.1           rustc --version
> > + Rust (optional)        1.75.0           rustc --version
> >   bindgen (optional)     0.65.1           bindgen --version
> >   GNU make               3.82             make --version
> >   bash                   4.2              bash --version
>
> This is now a conflict between the mm-nonmm-stable tree and Linus' tree.

Thanks Stephen -- the resolution is correct in next-20240312.

(The one above in January's quote is the previous resolution, i.e.
before we had the second update to the version in rust-next).

Cheers,
Miguel

