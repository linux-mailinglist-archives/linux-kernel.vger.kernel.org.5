Return-Path: <linux-kernel+bounces-36915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5B183A89E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4701F24388
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B87360DC9;
	Wed, 24 Jan 2024 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmGVDOk6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799F060DC0;
	Wed, 24 Jan 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097588; cv=none; b=owxy3roAry+v4O09GyxxQcY/kXVfnLz5f1S7v9i/JgcCuyQ8Q+Pm4tDimiZ8cj2LfCNKy0RU7pC8yqL+RCXyR7cEdu/f8sRVn2nkvp7xFPEUE3SQeh4E8ynLhrWjjMyymavpUDKrmNWV4+rowlOApi+oIzltkNc4yO5iEkP8ny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097588; c=relaxed/simple;
	bh=oarX1fEBRPBcI5XEhiEXf7uHfTjLyDcKLCnvwlckcXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nb2hPfU/8a3ySSLCevfKFOaBu0hvAwPCOuFIXcF6p+Tg0mgGU208H3HnyElIpe1Z2SDLz+AjUR7VVpAz0awksXqVI2PQNVu0OKh1H1/utV3iprRSelIOVNCuoXepzaZ8lQYPAy9igO2b77LVWsq6DE0gDqEUmRKerN34IiH2jak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmGVDOk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA57DC433C7;
	Wed, 24 Jan 2024 11:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706097588;
	bh=oarX1fEBRPBcI5XEhiEXf7uHfTjLyDcKLCnvwlckcXs=;
	h=References:In-Reply-To:From:Date:Subject:To:From;
	b=tmGVDOk6vAIgARhEPO6uqnyjz2VgVTyoTUqiOLvyv5fGrqBRG/g/l2rQ6J8a5Dhnu
	 MfycHEAbv4oOi/H48w8TD1XTVRcvVsBmyEWSJVL/fOR/y1Q5c8WTSD/FwoHCl+BtUN
	 8fSMby52xE3R4DaHY6zLBSrrQ8TTWLsga1RGaKp5Gdnslw1BEJS11NWgiVXke9c1ji
	 tHY1SaocR+9yigB5R/zRcTUgVawYu7CDiiIDCoM1Y5nW6Y+BoQpiPQ7fEVkjul6uye
	 8SEg3Wyb5kBPCth/5UXbJFyQ+7qDT6ekkwrRzcaA3z4naIz81KflbhRZUGzZg6gEDu
	 2NqAUYtZka+3Q==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-594cb19c5d9so2577566eaf.0;
        Wed, 24 Jan 2024 03:59:47 -0800 (PST)
X-Gm-Message-State: AOJu0YwqwSeoIveJHXaSrTZBAi6/bHdc5wg9Xuh7NR+SF8qTXePczyjk
	uUagtL9lnvAePlv3753MwHCgOvARXu/DSS3lK/N+4sDMEPZXxO9JU9NRQK3dKeN4lF37wItxur0
	SmsHLBM1zoeK43oB5zzyFTDL7bl4=
X-Google-Smtp-Source: AGHT+IFRnV323hQjxgtJU/VsUH5tXwMdr/gaNQrlgBSZy7mxmGPas1ccoR85KkChRda3o3h4p8l5AFyXWBX4M/gX/UA=
X-Received: by 2002:a05:6870:a686:b0:210:8e0f:43f0 with SMTP id
 i6-20020a056870a68600b002108e0f43f0mr457408oam.57.1706097587313; Wed, 24 Jan
 2024 03:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120083255.2757978-1-masahiroy@kernel.org> <Za6H2NfODGU419hX@buildd.core.avm.de>
In-Reply-To: <Za6H2NfODGU419hX@buildd.core.avm.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 24 Jan 2024 20:59:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNATABD0S40dnGznQNmPYAi_i0eh2ftYQfBm98teG7QPd5A@mail.gmail.com>
Message-ID: <CAK7LNATABD0S40dnGznQNmPYAi_i0eh2ftYQfBm98teG7QPd5A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix W= flags in the help message
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 12:21=E2=80=AFAM Nicolas Schier <n.schier@avm.de> w=
rote:
>
> On Sat, Jan 20, 2024 at 05:32:55PM +0900, Masahiro Yamada wrote:
> > W=3Dc and W=3De are supported.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index f288eb2dc8fd..8c6a935c62e6 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1653,7 +1653,7 @@ help:
> >       @echo  '                       (sparse by default)'
> >       @echo  '  make C=3D2   [targets] Force check of all c source with=
 $$CHECK'
> >       @echo  '  make RECORDMCOUNT_WARN=3D1 [targets] Warn about ignored=
 mcount sections'
> > -     @echo  '  make W=3Dn   [targets] Enable extra build checks, n=3D1=
,2,3 where'
> > +     @echo  '  make W=3Dn   [targets] Enable extra build checks, n=3D1=
,2,3,c,e where'
>
> In the top of scripts/Makefile.extrawarn we have kind of a duplication
> of this description.  Might you want to update that too?

W=3De is already mentioned in scripts/Makefile.extrawarn.
W=3Dc is handled in scripts/kconfig/Makefile.

So, I believe it is OK as-is.





> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>



--=20
Best Regards
Masahiro Yamada

