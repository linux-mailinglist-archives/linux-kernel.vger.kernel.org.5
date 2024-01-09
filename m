Return-Path: <linux-kernel+bounces-20263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF26E827C97
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98481C232EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2621C2F;
	Tue,  9 Jan 2024 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoYIohds"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6415AE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 01:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61852C43390
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 01:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704764420;
	bh=2x9g0HMaQU0iX9WQFIBG+M+vpIbfAwCaBiU+2zAJbBA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UoYIohdsLoCPJIdqIbXoPxXzpEL6lSppRCE5IjTooKUKIRVZWV5OotocomA60S8x7
	 eFjQ+7kp06Wd9EPpmofHQUocTeU7tk4N7S9liGRTHksaw0ntDZ2DKH8yP/VJwfKdLH
	 YTTUziIVV+hJUaNdIiappf1LO9KE+QWaoqxZ9IxDGv+EPC3kaicSuJsSGum4bIeugL
	 zAHi0WBkLYs7AeM/nTqpW996EvAWBpqzGk41puPSPAV3/Vgb8EIEhYlsDbpfnnTE0F
	 qLt9SpgNC6Ueo39lBEmTAb4yfzz2+jSaXuVOPwKpfC+0J7l7OGWcHP9Ry7Bf6uggvJ
	 AQ78Zl0X5BxrA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a28bf46ea11so428968966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 17:40:20 -0800 (PST)
X-Gm-Message-State: AOJu0Yxaai20rrTajNSXqOZXyhJg/H/hbvrhZIK4TqWDh5gvHeK87zay
	ps8+0O++z5LFTu043Rb9v1z7YfESLXKB+mAKJtQ=
X-Google-Smtp-Source: AGHT+IEvIuDP8zcop8SzbUdvV9GzexD3OinQ7Y7YhFFrUWA/qkv+rf74cFDWQudgpXUwaPjeO9x8r43pegbA0ch8QzY=
X-Received: by 2002:a17:906:3c50:b0:a28:f6a2:ca7c with SMTP id
 i16-20020a1709063c5000b00a28f6a2ca7cmr10082ejg.17.1704764418845; Mon, 08 Jan
 2024 17:40:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108033138.217032-1-wangrui@loongson.cn> <20240108163759.GA2899468@dev-arch.thelio-3990X>
In-Reply-To: <20240108163759.GA2899468@dev-arch.thelio-3990X>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 9 Jan 2024 09:40:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Qu9yj1d+fAcE3vL0=1FUOD8x0v+AhCr7Bj5yuQstndQ@mail.gmail.com>
Message-ID: <CAAhV-H7Qu9yj1d+fAcE3vL0=1FUOD8x0v+AhCr7Bj5yuQstndQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/min-tool-version.sh: Raise min clang version to
 18.0.0 for loongarch
To: Nathan Chancellor <nathan@kernel.org>
Cc: WANG Rui <wangrui@loongson.cn>, WANG Xuerui <kernel@xen0n.name>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	loongson-kernel@lists.loongnix.cn, Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied with R-b/A-b tags and fix typo together, thanks.

Huacai

On Tue, Jan 9, 2024 at 12:38=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Mon, Jan 08, 2024 at 11:31:38AM +0800, WANG Rui wrote:
> > The existing mainline clang development version encounters diffculties
> > compiling the LoongArch kernel module. It is anticipated that this issu=
e
> > will be resolved in the upcoming 18.0.0 release. To prevent user
> > confusion arising from broken builds, it is advisable to raise the
> > minimum required clang version for LoongArch to 18.0.0.
> >
> > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > Signed-off-by: WANG Rui <wangrui@loongson.cn>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> Thanks a lot for all the work driving getting everything to work
> properly with LLVM!
>
> > ---
> >  scripts/min-tool-version.sh | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> > index c62066825f53..9faa4d3d91e3 100755
> > --- a/scripts/min-tool-version.sh
> > +++ b/scripts/min-tool-version.sh
> > @@ -26,6 +26,8 @@ gcc)
> >  llvm)
> >       if [ "$SRCARCH" =3D s390 ]; then
> >               echo 15.0.0
> > +     elif [ "$SRCARCH" =3D loongarch ]; then
> > +             echo 18.0.0
> >       else
> >               echo 11.0.0
> >       fi
> > --
> > 2.43.0
> >
> >
>

