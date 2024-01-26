Return-Path: <linux-kernel+bounces-40096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4691983DA3C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31331F27104
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2981B5AC;
	Fri, 26 Jan 2024 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="bQ41PCyR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vg+MLw/n"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461271A726;
	Fri, 26 Jan 2024 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706272443; cv=none; b=heJMWgx4kWAk+tGTFcbeWPOcCWFSqsV/0TFaOpncMoQ4/XMPFvD44vcEHRMxMMh2YuGoGaq8BH7VJNiBB18dbfBLR6VRYUEaRZ4W3ytRNm8sOfrsYnuofwZxf50y40KtTv6EimvXrpy7FGxkJva/Js2HNtFBVdDPlwpyH/kK36Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706272443; c=relaxed/simple;
	bh=eFCWO1k8iWqR03mo4ZOrZ2bxtb9pRwS+IvtSVw+zg4o=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=nzhOA+zPHQNiOVoXFf6pFpGoqy07tQ9qxnRM6I3E5Yu3f+0JZcj3xoIHliZi8A9BtQgqLXv6bkSovIDnTfE8E/JSU6klPW8KuLNgeC+yrONeEaYsEC47Ob8HViFLqh9gBmWlMiPyr9T2Tka90CDQf3mtDBMhB4Ko6N+aANFLypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=bQ41PCyR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vg+MLw/n; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id D91663200B35;
	Fri, 26 Jan 2024 07:33:59 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Fri, 26 Jan 2024 07:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1706272439;
	 x=1706358839; bh=tBqGlsEjn/kPiobf5SqqLqz5w2BRrTChAdCUzax6B/E=; b=
	bQ41PCyRqkTGfAY3EcGz/E4+tr5J5nJYZVOYbWZvdqVmy2vPyGrY02Q9K3pLeLUW
	T4vI6n9ZC5ZZH2182wRzHoGH1DeZnWkmODohOMjnub5KDWfXiB4hv18qm+timODL
	7xYN2FJtsJL9sc/Y6B2b8G8rLqBvQsY1aRWvgpsP6aMcHw2tIWC1rpVPa26QZ4qR
	GGISiUJlUEltf1mGiL7RjvvHpSFSLGadQKjHaxSMLzTsOkGXqrgVVjcPyr3FGmST
	xLRGZGRF/gbXcfJUdY4D6tN0RehqT9ZYtlX3L9kpUpDKnisFutWSw2ykcyeZVpQX
	GIpQXOxIi7jrClXsb2S03A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706272439; x=
	1706358839; bh=tBqGlsEjn/kPiobf5SqqLqz5w2BRrTChAdCUzax6B/E=; b=V
	g+MLw/nPlLUnBcqi1A/jOsI9bXUZptHc+C3yWTx4RJ9N0ueSTvvQrgiM52AUuNIf
	Rb6q/sSg5bcfpSCxFN2KlEEM0FRcnzUOtoDnLfKjdQbvf7WpusKKwLsiF00aBenC
	hftxxF8Up878nl8Abw2JizzSb3GGeTrtUpDkEchklIwf/CJ9o1E0WENdpLbZux8D
	paVzl956Hq4EC5uidnJlH0H5ERI4xTnYGqi+uGwCTCVSi0MPnMLOlkj0OGKELnNf
	Hq2xM9KlMOyrvg3419cwaRSEICs9kgTnS7LSAPQB5HSqkUpS+3ufsAbRXb4+JdLh
	ZVTaKXGabwSax0Py+GmCQ==
X-ME-Sender: <xms:tqazZawoqJ7sd46qCMdPCiQUsBiA_0v77gNev0WoAs-5EcuN6fgXJw>
    <xme:tqazZWT1qZB0l2q5vIacrCH_-mkWoAH5ot6Hbh4m54IpkzJsR-uoZz_WmQTGDDDnd
    enQ-q0HNr8iJzzn4Zo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeelteevjeekfedvgedvleeuueeukeegleelledujeek
    ffekvefhueffffefkedvueenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgig
    uhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:t6azZcWrZTKaV6JYHorN_hIoNFbjKo24-7BBP_81rmLLcQgu4-NSoQ>
    <xmx:t6azZQiNHEJHMZTX1r0RXLAIm0AqTTY-gFGErRM43MbONIy5gU5FYQ>
    <xmx:t6azZcAAgfwaZ0DDwk5-iTtgfpdsc5r9Q-ExBFSA1YVRDW_l9RG3MQ>
    <xmx:t6azZfPDLUyG_7IMAMviv3FibMCgX46cBlD7Sw6CKof5uJ3Go1sCCg>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DA8D536A0076; Fri, 26 Jan 2024 07:33:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4b715c9f-6a9e-4496-8810-670080cb715a@app.fastmail.com>
In-Reply-To: <75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site>
References: <75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site>
Date: Fri, 26 Jan 2024 12:33:38 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Xi Ruoyao" <xry111@xry111.site>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, libc-alpha@sourceware.org,
 regressions@lists.linux.dev
Subject: Re: Strange EFAULT on mips64el returned by syscall when another thread is
 forking
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B41=E6=9C=8824=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8A=E5=
=8D=8810:42=EF=BC=8CXi Ruoyao=E5=86=99=E9=81=93=EF=BC=9A
> Hi,
>
> When I'm testing Glibc master branch for upcoming 2.39 release, I
> noticed an alarming test failure on mips64el:

So apparently it should be tracked as a regression.

#regzbot ^introduced 4bce37a68ff884e821a02a731897a8119e0c37b7

Should we revert it for now?

Thanks
- Jiaxun

>
> FAIL: stdlib/tst-arc4random-thread
>
> I've gathered some info about it and pasted my findings into
> https://sourceware.org/glibc/wiki/Testing/Tests/stdlib/tst-arc4random-=
thread.
>
> Finally I was able to reduce the test case into:
>
> #include <stdlib.h>
> #include <errno.h>
> #include <pthread.h>
> #include <unistd.h>
> #include <fcntl.h>
>
> void *
> test_thread (void *)
> {
>   char buf[16] =3D {};
>   int fd =3D open("/dev/zero", O_RDONLY);
>   while (1)
>     {
>       ssize_t ret =3D read (fd, buf, 7);
>       if (ret =3D=3D -1 && errno =3D=3D EFAULT)
> 	abort ();
>     }
> }
>
> void *
> fork_thread (void *)
> {
>   while (1)
>     {
>       if (!fork ())
> 	_exit (0);
>     }
> }
>
> int
> main (void)
> {
>   pthread_t test_th;
>   pthread_t fork_th;
>
>   pthread_create (&test_th, NULL, test_thread, NULL);
>   pthread_create (&fork_th, NULL, fork_thread, NULL);
>   pthread_join (test_th, NULL);
>   pthread_join (fork_th, NULL);
> }
>
> When running this on the mainline kernel (revision 6.8.0-rc1+-
> g7ed2632ec7d72e926b9e8bcc9ad1bb0cd37274bf) it fails in milliseconds.=20
> Some "interesting" aspects:
>
> 1. This is related to the size parameter passed to read ().  When it's
> less than 8 it fails, but when it's 8 or greater there is no failure.
> 2. This is not related to if "buf" is initialized or not.
>
> Now I'm suspecting this might be a kernel bug.  Any pointer to further
> triage?
>
> --=20
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

--=20
- Jiaxun

