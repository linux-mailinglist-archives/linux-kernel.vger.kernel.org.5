Return-Path: <linux-kernel+bounces-40157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874D083DB57
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F81C293ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54651BDC5;
	Fri, 26 Jan 2024 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNL+ytVt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989B1B95F;
	Fri, 26 Jan 2024 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277409; cv=none; b=s2r5+rIK3e/StK7JprXnnae1QN2AwOuVkBRxz8QV0hvn1rWzZXKfZlYshq7qkxKtJd4/1carzkxLWJKSm4ieGwNssKa3s8SjCbTtYAS3RMjRcleYpd064zk9qI/01rtzCZjJqkkxz8Jltbrb5ploVK2sxx0pE+0Uvhaw63Qi9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277409; c=relaxed/simple;
	bh=ik6BNC+e5RWBtEXfJ9qP+GL8xg3EKqy2nXgQher7oXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqm8JYafeg7hccpVPMnemtVkP/ldpq0H/n1cUV/15FRtEMPbmblLIYqIIfwSLLJkfyxkaBaDoGr2DUIpZkvtfrMiYaXEVQxm4REmlvPLmbSQdSDiKNmczBsCtMw1kFWGTERO5UG2vr4vQ8eNsf92bq6Qrbmrl/fBR3aym+aNWa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNL+ytVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFACC41612;
	Fri, 26 Jan 2024 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706277408;
	bh=ik6BNC+e5RWBtEXfJ9qP+GL8xg3EKqy2nXgQher7oXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SNL+ytVt+oDZujw02ndRHm1xjNuXyOMGfqC0opM91w8tpVEtXQ5iIRiyhFi0fghZi
	 nU5mhNbgQHSUMuaJN09sy/o/lsijjdHQKNjL+kf9NhJwsW55Di2rjMI6438iZMb+L3
	 E+SQwEj+d5Jk99Bl+0Y9svxiBuLvHPNurvXfpzNGOdKkWICMD1KCXNKI1y1v3/kNVX
	 uqekqI/xLRxmu7ZEcfThvQnuGRS1BLYmowL3VVaj+Gahl84h193BzvXlx4Mg94U+Ey
	 OXsw8MgqSEwhAPqjpcYFpfDKbTZV4akr0riaxGsMwvussQL9QPe0uy8G1+JcO8seY7
	 p98LlOVx+lKrg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2143a96d185so86328fac.3;
        Fri, 26 Jan 2024 05:56:48 -0800 (PST)
X-Gm-Message-State: AOJu0YxkBP6ko/wegaXpxJ+3NkhCVg+H4L1xsOfDPtanwMABJOyMXNlG
	XMem7WruwMz5fET5wtdvrgJ7qVaneK02EdchichHMADRdFOa6PQ/8qM2VgujLsFvraOX1t+y/xy
	53CtZ3Uvk6MymrXG6+ZMebm6PVrM=
X-Google-Smtp-Source: AGHT+IHD0FucQz5YB/Dnf29+PHG3Jo+GUOEakGbUWXKlFgjDV6mhWsxzLhrobNCcAI0gYzb/gmeXPQvc8dCHsskEveA=
X-Received: by 2002:a05:6870:c6a7:b0:214:273b:cd43 with SMTP id
 cv39-20020a056870c6a700b00214273bcd43mr1007557oab.74.1706277407979; Fri, 26
 Jan 2024 05:56:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215160637.842748-1-masahiroy@kernel.org> <20240122141203.CWe3n5rG@linutronix.de>
In-Reply-To: <20240122141203.CWe3n5rG@linutronix.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 26 Jan 2024 22:56:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNASSi78o-Tg24P2uDy1KhUKP8FBrzcn1JhvWrgpoR_mgpA@mail.gmail.com>
Message-ID: <CAK7LNASSi78o-Tg24P2uDy1KhUKP8FBrzcn1JhvWrgpoR_mgpA@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: resolve symlinks for O= properly
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kbuild@vger.kernel.org, Nicolas Schier <n.schier@avm.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:12=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-12-16 01:06:37 [+0900], Masahiro Yamada wrote:
> =E2=80=A6
> > Using the physical directory structure for the O=3D option seems more
> > reasonable.
> >
> > The comment says "expand a shell special character '~'", but it has
> > already been expanded to the home directory in the command line.
>
> It might have been expanded, it might have not been expanded. Having a
> shell script:
> | #!/bin/sh
> |
> | exec make O=3D~/scratch/mk-check defconfig
>
> with bin/sh =3D dash results in:
>
> | make[1]: Entering directory '/home/bigeasy/linux/~/scratch/mk-check'
>
> while bin/sh =3D bash expands the ~ properly before for O=3D. Would it be
> too much to ask, to expand the ~?



Not only O=3D.


If the shell does not expand the '~' character,
there are more variables that do not work as expected.

For example,


$ make CROSS_COMPILE=3D~/path/to/compiler/dir

$ make M=3D~/path/to/external/module/dir'



It is strange to require only O=3D to expand the '~' character.


So, Kbuild should be agnostic about '~'. This is consistent.




>
> Sebastian
>


--=20
Best Regards
Masahiro Yamada

