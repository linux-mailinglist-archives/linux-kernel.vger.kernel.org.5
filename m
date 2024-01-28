Return-Path: <linux-kernel+bounces-41624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF6C83F584
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA46283136
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE88E22F17;
	Sun, 28 Jan 2024 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+mGpzcd"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B121720B04;
	Sun, 28 Jan 2024 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706445521; cv=none; b=LHjFMkv5kxQJLdJwdbBuD8PB7q1tbTMl8/x3O1Ttdgy2h7eeOMznzvLL7iZKWOIzuchsXCFWxqhoPvaN/gjuE+EFLFS03CEH7wEaHjJfhhi2IAbupsqpO+tGCN+dqp5rSlHg4btO/PZUhJSvaV7jDHi3mcBraWnkQt2R7oetBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706445521; c=relaxed/simple;
	bh=tKwUFnxuzYj62IcC9B9LprzswbdAqj5/rvK4x50IGoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVqwMVS4/iWky1KMaukttHJnn1F5/jijBMeaVRH9eIB/PBVSVSU0Qabm3pP68I83RleF5eqzA+yz7kHJxQxDr5zPJH+CGCXUZrAG+cMkdlF+NgNkpJMkVmKq96YHsWEIR+1FYVV1jQSUIA0IY4AdHEHxqDWtpfdZ/ysWsowiFcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+mGpzcd; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cf3a095ba6so19409831fa.2;
        Sun, 28 Jan 2024 04:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706445518; x=1707050318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMoR8tdddP7YkCO+TVLJDCihWfN9qzXvX9tzIymJSa8=;
        b=A+mGpzcdNDVwsvPVG9QgWd6j+TQ7ftTwOUb0t5kkpj1zgsQJjFJ4imOL5fraOExJ+T
         Ch3UJFcR+bpEwykmO8X/w1QiQWG8xXAMNHW5X5yi+EJ4eQ5Bdnto0ORvTzPzeaJCLH6b
         xz2noknO1hrm5GvXSqaVKue/f8Py8nLLH8vXiu426y5Ku0nJ6nNCKgfa29eORWd/j9uv
         3RxJm62lEStwYKtn+BFHhmcV/lPOKqqZO6Ni46/tQf9wxEgluXpbVOxustyJQsqkkTL8
         qLeZR5xmxhCSOnAVn5ir0upWw89Xi5MduotzpalSpnSEtp5JMEFD2YRYyndq5P+PZv5y
         OmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706445518; x=1707050318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMoR8tdddP7YkCO+TVLJDCihWfN9qzXvX9tzIymJSa8=;
        b=A7aVxSpuRbZkGVMW0iXnrjMYrEbTuQLAxtLG6KaQfYnbC4erA+pI9Fb4OLADnP4MEu
         DrQXNfTmrgV6ITp3K4x+w4cWb8CgZQfEbnZ66fay3Fe5euSCEMAbkgPTTDBw2QW0ZFto
         bD2X05bhgSGzv3FobnKixVG2HHtHjfiohPJI0vCJc/9QxEuccvhfKh/IDW5kGDkDjl8i
         6zI6KCsyFYCA4r27Sor3BSdiJ/jPZVNTbrQ8XVLavwq6OBlrBfE55llr1F3DaXH/Uugs
         dsweBoy+mENiQB0aOTiVGiqoq1imzvV4MKWSa/BtdMFtfsu8mLQ49jee+JEMt8a1tqMm
         r70w==
X-Gm-Message-State: AOJu0YxLgze9QGq8kWSyn25Acb9+7agKVzcMV2JbLmLjs5nuQPlwQRcz
	7jnXaE2Vt/2yNB4ATP8BLgTFcxtIZIj7rRQtLC6U8ILvreP1dpHnfpTqQtjhyunS9l7RPwg+PIm
	X9kwKWuVU5d9mflA32g8wSrZVwtE=
X-Google-Smtp-Source: AGHT+IF+0nTXIboXcRryDkc5o2FJVgoAz88gONQuhrs/mEmLyEYrwuchszSkeAgN9zqOGUjOxCiAY3AmkAoImw9Iwa4=
X-Received: by 2002:a05:651c:1505:b0:2cd:f093:7939 with SMTP id
 e5-20020a05651c150500b002cdf0937939mr2414049ljf.32.1706445517369; Sun, 28 Jan
 2024 04:38:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128145626.53e7a0d3@canb.auug.org.au>
In-Reply-To: <20240128145626.53e7a0d3@canb.auug.org.au>
From: Steve French <smfrench@gmail.com>
Date: Sun, 28 Jan 2024 06:38:26 -0600
Message-ID: <CAH2r5mt5UJjP0nwE6k4uoN8UHdgs2xHTnP4-o0Z-jidX4=9umA@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the cifs tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: CIFS <linux-cifs@vger.kernel.org>, Steve French <stfrench@microsoft.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

fixed

On Sat, Jan 27, 2024 at 9:56=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi all,
>
> Commits
>
>   60c2fcda9c84 ("smb: client: add support for WSL reparse points")
>   f6819b9b72b5 ("smb: client: reduce number of parameters in smb2_compoun=
d_op()")
>   c08113706498 ("smb: client: fix potential broken compound request")
>   35f88f006a3f ("smb: client: move most of reparse point handling code to=
 common file")
>   985f1bce45c4 ("smb: client: introduce reparse mount option")
>
> are missing a Signed-off-by from their committer.
>
> --
> Cheers,
> Stephen Rothwell



--=20
Thanks,

Steve

