Return-Path: <linux-kernel+bounces-7729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8D881AC48
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FAB4B24C86
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F347D1864;
	Thu, 21 Dec 2023 01:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="qP4ZUHgO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VcXLEK9g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FC41115;
	Thu, 21 Dec 2023 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 254E45C0341;
	Wed, 20 Dec 2023 20:41:07 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Wed, 20 Dec 2023 20:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1703122867;
	 x=1703209267; bh=5O5AQ0+tqOBAkYTlZ0FO8VXCTltW/nIkbjRn79BnPxk=; b=
	qP4ZUHgOxW/4Uzclh5jlJQisbZKURwt/X3Rjg5ZF21GmwOpmmG1+7oAqu1o845lx
	SpObjMkUbatyHnNNMTWKxP07wfvyJZNn5DQzQ2/3Fu588Vca6QnogUOnSPdzqLaI
	3r00n8dCtT1wWDNVL6FdaY9jXFTWwUZvLBHEMvjhiBEcOkom+jDEEj7A//JgQUWF
	aWMyGc9tSrwdSJ1e84b8KxZ2crsB0BAhBOix0oNmr8uYAy0IiHBVWJgPNVsftWP8
	dB81XouA/kekll+E/Ayyxo3sLg7rl27Ce3XHPISk/AiVBuGijkjBuDUjUcOuggZv
	FRCNe5FziENZTu3xp0IKCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703122867; x=
	1703209267; bh=5O5AQ0+tqOBAkYTlZ0FO8VXCTltW/nIkbjRn79BnPxk=; b=V
	cXLEK9g9Ehrm8LlFPzGhYu+lfNq3N4JwZEAxL9Q9GUEvV+QufaDDrh27LOkXBIAl
	+zL8AGE0eR8WJHqm6pviV5Nn0ntHDFdFm1T2VgtVRFNnjzt2ca9F3QSnMSDq/Wdp
	vsKILgcE4C9ICuUXXp72uBU5E15flfsKYzq1qZVe7evrlwAYo4EaOcSbyIq14wNI
	+RmeX+mX5WRmWcDqfzomV4MffVvEzP25tAWRZ/w65tGebiaMG8G6/AKgMMoHVySq
	LHa/tPahvWC3VnSQbdo/s+w0Ozdl+Cq9Xj4cSPCuMb2EB97H58UhZDAQ1kBtP6LP
	Jh17Io7zfK4xwIY8gB8Jg==
X-ME-Sender: <xms:speDZTUFNeh03S8F_bbAZ1gtIT9pl8UbMsEAR6GEM4JkicNHuAmMHA>
    <xme:speDZbnxEoxphbv-dXg3yHWhw2oWmb66dwi1_7DcvaqB5DiSPXbmctl8mIXtioy6m
    ZaySIPOklXWbG9GrwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddufedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeeihfdukeelvdduiedtieetieekvdegjefhteelhfdv
    veelvddvffeflefglefhueenucffohhmrghinhepgihktggurdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:speDZfZ5KeV_fmVoHCO1jSR5jxVITFDXA240TX9Fc2lAkbLRc7mIoA>
    <xmx:speDZeVd592AUFYWlnghFcYAkICBmiIcPa_4sqeTQtttpWzG5IP9Qw>
    <xmx:speDZdl8Prv4zSwTZPO0LonhA4Qd7LV_JtVoGu0ky--spyHvsdkOAg>
    <xmx:s5eDZcuf8994_vG9PGiECBlfQp53OPbtenC5IZcM2Qq5DxiTNkqftA>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 93C1936A0076; Wed, 20 Dec 2023 20:41:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2a2f69f9-f987-4f96-9c5b-3aaaea29bbbc@app.fastmail.com>
In-Reply-To: <ZYNaFhFp/+q+/Z0Z@alpha.franken.de>
References: <20231029-mips_debug_ll-v1-0-d7a491e8c278@flygoat.com>
 <ZYNaFhFp/+q+/Z0Z@alpha.franken.de>
Date: Thu, 21 Dec 2023 01:40:46 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc: "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] MIPS: Unify low-level debugging functionalities
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82023=E5=B9=B412=E6=9C=8820=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8B=E5=8D=889:18=EF=BC=8CThomas Bogendoerfer=E5=86=99=E9=81=93=EF=BC=9A
> On Sun, Oct 29, 2023 at 02:53:01AM +0000, Jiaxun Yang wrote:
>> The plan is to elimiate platform specific early_printk and
>> cps-vec-ns16550 by debug_ll and earlycon.
>
> https://xkcd.com/927/ ?
>
> sorry I don't think that just another new function is good approach.
> Doing this will end up with another method for early debugging and
> all other will stay.
All others will go (one of two already gone).

The thing is, I tried to get cps-vec-16550 and zboot work with UHI
semihosting, and soon find out that they are doing exactly the same
thing. So I tried to unify them.

I miss the good old day on Arm system that I can use handy debug_ll
functions for every low level debugging purpose, thus I just copied the
whole design.

There won't be any new debugging functions, zboot one already merged
into debug_ll in this series, cps-vec-ns16550 will be merged as well,
I've got patches prepared locally but depending on my XKPHYS changes.

We have extra functionality to debug early exception as well, that will
certainly make bring-up process easier.

Thanks.
>
> Thomas.
>
> --=20
> Crap can work. Given enough thrust pigs will fly, but it's not necessa=
rily a
> good idea.                                                [ RFC1925, 2=
.3 ]

--=20
- Jiaxun

