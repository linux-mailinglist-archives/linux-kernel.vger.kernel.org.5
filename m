Return-Path: <linux-kernel+bounces-167419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB418BA94D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546241C21D3D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEA214E2FD;
	Fri,  3 May 2024 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOIWqWVl"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA4A14D446;
	Fri,  3 May 2024 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714726896; cv=none; b=I9RIeEwxmK5SGAEXfxiuLL+Ze55cjW8JZFh2HOGZL4NoOl9j1Ho+wEg36FQoxItZLxy0GAqMtsNezpx7PwnJlU4sPfVQlPUuvI038ucCMDELdMb7YsukUoXj3lvZGcc623yvsRWdbRjUFZ1obgbhk74HyDhCCp8G6S6pOMOToB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714726896; c=relaxed/simple;
	bh=u5aZ5ipEo3sZMpL59dkvKjOGLqG20DnDPQajCwv//Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJK3NOfvGd+2LzP4yIPsfz2WZdf7gaAX3cTZfPG/QfWKPKN41wDBbD5MjNez/YAuJjMizQNNwDL9W0BYwiw5VQnpyouaZtIJrdQeWUa2kRmyNuKst6WRm/1fD9OrZ1GFy7omzqQaFOwLzHpgORYw+T4Hp7ulFANKeZiCf1lKQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOIWqWVl; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de46da8ced2so9974376276.0;
        Fri, 03 May 2024 02:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714726894; x=1715331694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkGVDEWe+Eb6TEpNRfPQCdPoBlVyFk9pNDKSkhdvzdM=;
        b=FOIWqWVlN+7BGAAFHogCPRirMPPK1q6xxO9CXoFzZVdOecXwp5Ejyb5Jn1kXuJ0ibd
         8F0L8HMYJEPQENaZyyHDZoy2QAIoUMqfUSRlrT/B1FKah17nJRK0EPZq5+72O/rJwRTr
         wti/O/qmIXBGesysxr+bRZHru3z5lkmT7494AGRyNQw6wnmgpEJWNJM2kp+zCFSbkDoP
         Aho8W3emiFi6nNk+a5LCPdTJutrHSt42T+09bRZX5v4igkoWYKYhq44wp8QgcwC2tRs6
         +vTLbhfZTska8tReQycHdI+Q39e7CZ/MXr3xCBp1XJIYWqgne5kwWK7OIKNXdAZ6zXif
         WGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714726894; x=1715331694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkGVDEWe+Eb6TEpNRfPQCdPoBlVyFk9pNDKSkhdvzdM=;
        b=bW8W8ShJEDxgKwza+Vkk+zed1vPnS336+Tb3RDb4bDHhCsI4NVJsJL+AWxSYCBLGO7
         FqhCbxpDjvAhdp3Lc4GjC94HbtiYLZr7VcadQrCC8C4OFNNoOUKezmbl2PImRRXK4LEt
         4eI53sEAk/9Utu3jSF/FiExt2cT539DYhTQ6O/G7mWzzmCoz9k9bXYZBKDHx0Uj9i1G/
         ELrol6sf3NgV1lhudJ8/R7/ammH52Ed94/OqykDghPf9fRrKWSo4MLco4wh925BP8AXw
         gk7JWUHELiGhi5l9ONsAwNJ3+icXFqsji4INjZz74Na/ZMlS+ZhsI594ytYKF7OFgJEz
         bsDw==
X-Forwarded-Encrypted: i=1; AJvYcCXlE/nvAnw2jAuvMng+OC69bKFWR9vzHSecfOa6b/5fuApAk5Z22ZdMBGScf/WSI21I++WptG7jaBwCterNskqhAzEZiMDJeuoXd8pGBWONo5KWmjXwoYkFvzR2xrTW6t6C3zfeo2Sr7YtyEcAXM2MAF/rAhuXSXfKjFxG1nnYCfzgogE2TYQ==
X-Gm-Message-State: AOJu0Yybzr0RMWF9WuFNd7+Kz7cH1STlWHQrFG5WCPe9qt/UEtYK+let
	xpOd8idZS9WtaRvo0V2q64LrB5viNRXgv5QJrcZjeYAWaYnFcvEl2DDZd2tiy9a/KsqG5uHOvJi
	z4sU+qEegBcCE8a5SgDE+ZJ/LCDs=
X-Google-Smtp-Source: AGHT+IFn82EPy+JQW20yMvW5rRI+OPX1TAUiG082KOHrrEp3VW6buI2A7Zzw7E0HNx2IVj6osbOIG0rJKuAhFonyozI=
X-Received: by 2002:a05:6902:2510:b0:dc8:5e26:f501 with SMTP id
 dt16-20020a056902251000b00dc85e26f501mr2505239ybb.61.1714726894369; Fri, 03
 May 2024 02:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501084110.4165-2-shresthprasad7@gmail.com>
 <f1707254-ec32-4884-275a-c3c85b48d7d5@linux.intel.com> <CAE8VWiJy-2x6sKCAmN69Uq9Kf1cTRnaJezOoLDyZ0SbgPWuHAQ@mail.gmail.com>
 <2024050357-shading-fedora-2d4f@gregkh>
In-Reply-To: <2024050357-shading-fedora-2d4f@gregkh>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Fri, 3 May 2024 14:31:22 +0530
Message-ID: <CAE8VWi+-HVuGo-ojGPwKubpLweBmJ4-L097nh03QkezcsciorA@mail.gmail.com>
Subject: Re: [PATCH v2][next] tty: sunsu: Simplify device_node cleanup by
 using __free
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	davem@davemloft.net, jirislaby@kernel.org, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	javier.carrasco.cruz@gmail.com, skhan@linuxfoundation.org, 
	Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:04=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, May 02, 2024 at 10:21:16PM +0530, Shresth Prasad wrote:
> > On Thu, May 2, 2024 at 9:35=E2=80=AFPM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Wed, 1 May 2024, Shresth Prasad wrote:
> > >
> > > > Add `__free` function attribute to `ap` and `match` pointer
> > > > initialisations which ensure that the pointers are freed as soon as=
 they
> > > > go out of scope, thus removing the need to manually free them using
> > > > `of_node_put`.
> > > >
> > > > This also removes the need for the `goto` statement and the `rc`
> > > > variable.
> > > >
> > > > Tested using a qemu x86_64 virtual machine.
> > >
> > > Eh, how can you test this with an x86_64 VM ???
> > >
> > > config SERIAL_SUNSU
> > >         tristate "Sun SU serial support"
> > >         depends on SPARC && PCI
> > >
> >
> > By that, I mean that I compiled the kernel and ran the produced bzImage
> > on a x86_64 qemu machine.
>
> But you didn't include the driver you were testing :(
>
> > I unfortunately don't have the hardware to test it on, but I don't
> > think the change is complex enough to require testing on real hardware
> > (unless I'm assuming incorrectly).
>
> That's why I asked if you had tested this or not...
>

Really sorry about that, I thought compiling and booting would qualify
as testing. What should I be doing then?

Regards,
Shresth

