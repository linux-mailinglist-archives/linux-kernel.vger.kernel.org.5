Return-Path: <linux-kernel+bounces-117947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B430288B1A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB08320280
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A8D5A7A8;
	Mon, 25 Mar 2024 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="pxMsXck5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CqZwB9Vp"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA14F613;
	Mon, 25 Mar 2024 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399054; cv=none; b=f8SbmEn5PSPEa9k2VsbdBjeBq0fNLg70vyGvD4aWEOdShmSO2YaM1bmrgvzKTKXtjskaQBM9gKJ2N9HgUy9EqZEJLnLqG8AjS+sBpPaXrY3szH/sgSA5kw/HRoTfbIM9U3ebCt4VZgq1ITcb8RtQJHDYzOE6cFhNUrD33arpXwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399054; c=relaxed/simple;
	bh=WIGBVbd9/72zbWjlxGvBczupXWiNdFGp7+Km1R5+Lgs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=e+Lu464BgEC7EZzpVwFwQtpGkB2fifosdbXh9VW2/7R+MAri60B6pe3f/mDYbIYjp83z8flZQnvWDwItAqXa/IHj+D9du9GAl7UHKfrXFxuaxrcYFHP8NdEN4YxbL1+tJlZuLsZZPCg4dvFPyOlfv2l3TunG12Bd1sPx1ZAV14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=pxMsXck5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CqZwB9Vp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F24501140127;
	Mon, 25 Mar 2024 16:37:30 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Mon, 25 Mar 2024 16:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711399050;
	 x=1711485450; bh=/1ewNf3pPqZE/DUxXn7y0rr2dSez/NzpjgjFKKloEb4=; b=
	pxMsXck5a92pelsnCruwRew+1ywO2Bg5xl7n2xqFDYrZuGs3akbSJVYTc/roS4Ua
	fXMMouVpdrbEFRqaTVhsQ2e9ipe3CJzy8SOJBISWk5GEljPtWYPxnxbhF3sO/2e3
	/SdBvTKi4x/1FBvMhNW6C1hTFxvHHlAb0wxaDuh07C+vwgthVzVfEE8XLNxLWdoq
	4Ps3cvqw9Qh7GlkBMmYbWR0k4nFW7iNYeSbKhnpPMuTQC/dF3zyRAEI9WcCOVI1/
	wuooJLr0Nz60dGpccr7azwgx6pfPdpMA6akXyrzcNKiEKq/U0KtWQLPcAv53QLGh
	He67mq0RBH06hOSkoOrOIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711399050; x=
	1711485450; bh=/1ewNf3pPqZE/DUxXn7y0rr2dSez/NzpjgjFKKloEb4=; b=C
	qZwB9VpPA6gzuH0jRzeMYEs1+JcHGmlIVciFDYXTR3gJ0S+7rhwgHwEoqESmGLct
	4YvGhbA/lPnmjghTnmz8wqjgrGttWXIw8P795KAiEQDNuXZ9ev+RsLLD795xx1w+
	ab4ueKXLkzhdnEDCss/73PQNKxcwgWPkd2Ch8sTP3TBjxUDvxPwZeRt0mg1dfwqz
	rK8yupuxM50D2zej9Nntdi2usknJxmw6AotLFJsn0G9G5/6qKG+2pq3cjkYB6A0q
	3aI1vmUyzyTlfJo5b1m27meK314HMQ/vd+upSxvzDCjG9PzGVNp5e7fbSXTbW+Lw
	2wfc4sUs2d3AOZvOZFSaQ==
X-ME-Sender: <xms:iuABZuiOdwhoVh6ZDahJ8x3i5b_3UVi5REVaGOilcjnQWfvfsYihLA>
    <xme:iuABZvBkIjsFRIbgVVFJvLjYinU9xtp9aw_64y8848tKIE3aAdRk0yEaEj4-p8F9w
    1DktNqB9v27gVOoTKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfn
    uhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrth
    htvghrnhepfeeugffhvdeufeehieelvdegfeffveegleehtddvheegkeetueegtdegueeh
    vdelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:iuABZmHy9DhILsU_WF7FdaJ62J4kT4OLX54w2Y-myZd54KNTXQ3FzA>
    <xmx:iuABZnTFXSbxlNuIhnMAswc6xhtFCOIucDZLq0DWCfBDFmXAMuoA8w>
    <xmx:iuABZrwOh3BEtvISf-k4WLfhhG51MnVqaY0q0BgBdIG0IzRDxnKbWw>
    <xmx:iuABZl7K9F6URiQ-ByxMK1uwR20KjmQwvd6Q9sH7nJrv6ODRqm28Rg>
    <xmx:iuABZtujCwHhA51fZFcQJ3om1YQBEUihb39a9SjuDeaqIpwrMPCjqw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B912F2340080; Mon, 25 Mar 2024 16:37:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2cb42269-789d-4fbc-8399-0de178e640cc@app.fastmail.com>
In-Reply-To: <cddf60d7-1523-2f22-252a-3c22d399addb@linux.intel.com>
References: <20240325054938.489732-1-luke@ljones.dev>
 <20240325054938.489732-9-luke@ljones.dev>
 <cddf60d7-1523-2f22-252a-3c22d399addb@linux.intel.com>
Date: Tue, 26 Mar 2024 09:36:54 +1300
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] platform/x86: asus-wmi: Add support for MCU powersave
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, 26 Mar 2024, at 2:53 AM, Ilpo J=C3=A4rvinen wrote:
> On Mon, 25 Mar 2024, Luke D. Jones wrote:
>=20
> > Add support for an MCU powersave WMI call. This is intended to set t=
he
> > MCU in to a low-power mode when sleeping. This mode can cut sleep po=
wer
> > use by around half.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >  .../ABI/testing/sysfs-platform-asus-wmi       | 11 +++-
> >  drivers/platform/x86/asus-wmi.c               | 50 ++++++++++++++++=
+++
> >  2 files changed, 60 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Doc=
umentation/ABI/testing/sysfs-platform-asus-wmi
> > index 5645dbac4ce8..ab8e5ab1bba9 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > @@ -202,4 +202,13 @@ Contact: "Luke Jones" <luke@ljones.dev>
> >  Description:
> >  Set if the BIOS POST sound is played on boot.
> >  * 0 - False,
> > - * 1 - True
> > \ No newline at end of file
> > + * 1 - True
> > +
> > +What: /sys/devices/platform/<platform>/mcu_powersave
> > +Date: Mar 2023
>=20
> 2024.

Always something with me... even proof-read my own patches.

Done.

Luke.

