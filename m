Return-Path: <linux-kernel+bounces-109375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4B4881836
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7C71C22DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E381785927;
	Wed, 20 Mar 2024 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="TIlQOZ5j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UsiUIFyI"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A3885923;
	Wed, 20 Mar 2024 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710964893; cv=none; b=BEL8NKml+GSfrh0x3Wa77k8TYsBd/dWD5JhsHMWl5R8f7ePNxw+EboeDlIOnX9xMDMSlr1Z3R8CMqMvc9zUL+RdTfmIcXQZ4j31VYRn1YUk/xjKEjDj6jDWQuCQuLA4X3AtRSTAj0kKkJITwFFDg38vTR+IAOsZXiXBZPmAnr00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710964893; c=relaxed/simple;
	bh=IeLoxB+NsSJEWuKPkn/vovqzZ0GvfZSkvqANV6t7FIo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=DhNoW8Hcog6BTCsGQibLPlKmNlkOxemhGc6aEeXu70WWuuCZdQfACs0mR5usxOYV5YLGVkJFIGXMap3Zhl5Jeo+spuPSbN9Y6NRO8SpEohGCDdLDv+D7heBi7mYLuikyl8YOAArpBrMuV3NTDFhTiZ6jnybIEgK+D0SCPp/rHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=TIlQOZ5j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UsiUIFyI; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 9A2A05C006A;
	Wed, 20 Mar 2024 16:01:29 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Wed, 20 Mar 2024 16:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1710964889;
	 x=1711051289; bh=AZSqN4s5zsG3HqEikLmq10h58qPWmcD/hoS2dTSCdbg=; b=
	TIlQOZ5jXkvVFAJaxUGXZHmbWaqvKxcTFdabnmW+hJpcgxON9S58WfllXNNftVP8
	UJIXMiwQWEc3Ammu+nbGh6c5LG/YYbk4RrZ3CL2yO+ToLbSJF+DyZAudpRtabn8I
	3qcPD12ostETxRrKT/9f5SeIsM3Hcfsyn0MqOsFQWSXLjCZxnTLvgGQU7QyiyFyD
	650aD5TqWKgRVZKKe8riLBHrBb0KeJVDBCGDmY3mN9m2QO48vr9/J5znuunTGzgM
	GlGEaJVsQyONfIJ9pBHYg4taZHHAYWEDpHYMBchoz0IuZV1EapXGf/QP0BbYnudH
	LacqtH+56wpRqYk7dV99DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710964889; x=
	1711051289; bh=AZSqN4s5zsG3HqEikLmq10h58qPWmcD/hoS2dTSCdbg=; b=U
	siUIFyIzk2xcW4jJT+UvcbdFcli49JWvxKj0rmXNwbMxKqQEb6uCkKf1H22AX6JE
	lyvcReqVGy8pB//wa+8iwab4bRVTRP/EaABY0xXyGQjiLpCtwhSVkWKycr1HYIJH
	PuGZ8FdDaSPhAaIAxauAk3z8TN+cgl5wIMEiNA27KohcKqDDe+RxIiSBWFVBmy2P
	zxJS9kf4H6lSz3I8JF7lxVa6V7VqZT+VFQDIhYxCWV3q10Efuo3CUCv+pxNZnfAW
	j1XVSsl+LFUbUwIRyYnbSM+7hdWr5SaZLbbs18NXyRdQQE46bQCWJRO5D0wegqpz
	T1jN8FXSZBeAemr6K475g==
X-ME-Sender: <xms:mUD7ZSE6Oc306wJI2SS_c_XH4HuHaTIvnf-jPeFEgDDx6vbsPiRUsA>
    <xme:mUD7ZTWC-UfGp93_2p54aI335Y4XGVUcewEGr40paBk12O6JEnM-yC8-iQzWbxVw2
    0wtCYW2RFMP7JlDGi4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeggddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfn
    uhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrth
    htvghrnhepfeeugffhvdeufeehieelvdegfeffveegleehtddvheegkeetueegtdegueeh
    vdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:mUD7ZcJmdMZ8S7N6xDXIZ_65HYPOcLxDsGuGguIx7L9gcjsZpIylaQ>
    <xmx:mUD7ZcF4nU__0awuNlzv96B3uD98rjINlOS_cY_7rtTSjEoVvyPsOg>
    <xmx:mUD7ZYWUuUzmaRS3oC3hiqpLnI90lTM9yujJr9c4rdLM2wFegP9Iig>
    <xmx:mUD7ZfNW9ieQnMbPH-TTuXducPtmmHIO3mvtaM7mj3yuXqYQ7WDz8w>
    <xmx:mUD7ZfSHiYqzeTQXVqDUiJ2gcbsoH-HvvTIZjkYxwXLiSov7ib8dxA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 381572340080; Wed, 20 Mar 2024 16:01:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e67f4e91-56dd-471a-b2c6-46161c38883f@app.fastmail.com>
In-Reply-To: <5d5e8895-8843-a0bf-de97-b293528a0643@linux.intel.com>
References: <20240320011442.11608-1-luke@ljones.dev>
 <20240320011442.11608-2-luke@ljones.dev>
 <5d5e8895-8843-a0bf-de97-b293528a0643@linux.intel.com>
Date: Thu, 21 Mar 2024 09:01:07 +1300
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: add support variant of TUF RGB
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, 21 Mar 2024, at 12:36 AM, Ilpo J=C3=A4rvinen wrote:
> On Wed, 20 Mar 2024, Luke D. Jones wrote:
>=20
> > Adds support for a second TUF RGB wmi call that some versions of the=
 TUF
> > laptop come with. Also adjusts existing support to select whichever =
is
> > available.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >  drivers/platform/x86/asus-wmi.c            | 13 +++++++++++--
> >  include/linux/platform_data/x86/asus-wmi.h |  1 +
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/=
asus-wmi.c
> > index b9a2fb8007c0..0d8a2b82cc06 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
>=20
> > @@ -4544,6 +4545,14 @@ static int asus_wmi_add(struct platform_devic=
e *pdev)
> >  asus->gpu_mux_dev =3D ASUS_WMI_DEVID_GPU_MUX_VIVO;
> >  }
> > =20
> > + if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE)) {
>=20
> The patch itself is fine,
>=20
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> However,
>=20
> There's a major problem in the way you're submitting these. This patch=
 is=20
> built on top of the GPU_MUX_VIVO patch as can be seen from the context
> above. Yet, you're sending these independently instead of series. I=20
> suspect there are other similar problems among these patches that ther=
e's=20
> hidden dependency order in which these should be applied. This will ca=
use=20
> problems if maintainer applies the patches in wrong order (they may ev=
en=20
> misapply with fuzz).
>=20
> Only if the patches are truly independent, that is, focus on solving=20
> entirely differently thing (functional independency) and do not have a=
ny=20
> linewise conflicts (code locality independecy) either, it's fine to se=
nd=20
> patches as independent ones without making a series out of them. But=20
> clearly it's not the case here.

Honestly, yeah I should have made them a series. I was sick at the time =
of submission and shouldn't have been near a computer at all but I have =
a long backlog.

I'll go through your other reviews and then turn the lot in as a series =
to prevent any mishaps.

