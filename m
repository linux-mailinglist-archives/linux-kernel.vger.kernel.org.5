Return-Path: <linux-kernel+bounces-7749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB03881AC95
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330161C2288B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3571FCF;
	Thu, 21 Dec 2023 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="eBwbc/vS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="9b+5WMMO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE451843;
	Thu, 21 Dec 2023 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A2DC55C02BB;
	Wed, 20 Dec 2023 21:21:46 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Wed, 20 Dec 2023 21:21:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1703125306;
	 x=1703211706; bh=u4Mi26pZJKyRO9fetP7V1s8Zt2g/ERIujlW54YGgiXg=; b=
	eBwbc/vSeN+oifqqPfn4rQ/wC99kqiy8XKqgN9vcENnhpxuZ8mnCTDfv6tmg1C1h
	W2Nh7VL9JRYhls71S8OhCWLnNJ++aGMBEUjotmCXGdb5aqkeRtYcp9QRN2z5lbSf
	rvEPMkfELnbPokg7TndubGCSNpeX29e9WnA4b6rG6+xKBDtPzz1teZq5JHn7Lpii
	PU0Apxl8D2oifv4LqwVOW5+urQxuCi8xhvYW935HXzXypsC7iOzAho0T02PSgk02
	kNE1Q6NTLzsaapCb1ftPAEc8/T+B3RqVuln7QpS0Gei1SKgbclBLGFvRhJrO0gsw
	93Mt5Uy6HeZGcSI3exjUIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703125306; x=
	1703211706; bh=u4Mi26pZJKyRO9fetP7V1s8Zt2g/ERIujlW54YGgiXg=; b=9
	b+5WMMODPhB1eHvwmjFnIAKgsdqhCJoNNOMCKPcjBrCAxSwg8RAWkgs0O/zuGKtQ
	qDWqoc7fNqNuDxSnO+FDUaJpp1Nv/0OyYd0UVcgw4GJiFZSfDxhxJ1jdZmAD4PUU
	pILlpUJDDwb55rFNLJO9ZEMEY90qXqUevrgVzBV6KoQPe1HJ/R/Zy8gVXlBeGzsR
	NhWE22gslYkkzPTIgXTqiaJIL7m/djwFZHWFKLdm+7kQCrwCznWJF4LK59ch+JNW
	SiO50nvhFXU0osca0XuXBZcMpn5bHlgybkeRTugL8et5XhZ5veHY76xxLucQZ2Hd
	RwiumlKRu9NKuPPIzSsqw==
X-ME-Sender: <xms:OqGDZWM-GmB7838DFkcktNeym6sytM6YqSrhbzYqSFbzXbH0UOXc6Q>
    <xme:OqGDZU-ecyRMcl_wKWF_yY0ON3cz0OKnrFTKkA3b3pcxJcKp-e4i2U-_c6TtJeQSL
    _5XaiOUxK0dZ_QZBSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddufedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeeihfdukeelvdduiedtieetieekvdegjefhteelhfdv
    veelvddvffeflefglefhueenucffohhmrghinhepgihktggurdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:OqGDZdS5qc_S8fpjFlX-7R1PZL3gxzNI3TcVs8Dv_UbazI0ScI9a7A>
    <xmx:OqGDZWsDjFQ14oKk9kTCBMswB_MKLbly-RhP6cyf0_xdAvDwhIG3CA>
    <xmx:OqGDZedal_fSklLlz7YQPyahX5HqMfpjW9RkWyMyhj43DqiK_gkVlg>
    <xmx:OqGDZWm9PN--iWvz5YLej6wTUrCsVG7OCMIi0jX_iRGlcOGgCfllPw>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5C2BD36A0076; Wed, 20 Dec 2023 21:21:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <96543d4c-f08e-443d-9a85-9257fc4f4b6c@app.fastmail.com>
In-Reply-To: <ZYNaFhFp/+q+/Z0Z@alpha.franken.de>
References: <20231029-mips_debug_ll-v1-0-d7a491e8c278@flygoat.com>
 <ZYNaFhFp/+q+/Z0Z@alpha.franken.de>
Date: Thu, 21 Dec 2023 02:21:26 +0000
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

To summarize how are we going to handle low-level debugging after this s=
eries:
1. You are lucky enough that the problem happens after console system in=
itialized
   and you have stack working: go earlycon, or on very few old platforms=
 with platform
   early_printk
2. You are debugging zboot: debug_ll
3. You are debugging SMP bootstrap code like cps-vec: debug_ll
4. Your kernel crashed at the middle of no where before trap_init: debug=
_ll

Thanks
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

