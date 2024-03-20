Return-Path: <linux-kernel+bounces-109382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC32881850
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD1B28612F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F142A85637;
	Wed, 20 Mar 2024 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="EuqsUOuU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ya89ljFO"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FE485952;
	Wed, 20 Mar 2024 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965291; cv=none; b=D23kV8qBFk0p4I+1JnaT3xYACWWQtGRaumVD54Kx8hyMHe2Wx/DRXLcLS0crOUIBcbnHyzblGNIcPnQIY7L//4XK4E8IsBQ5lfqeR4yl+o5hg05VSQE1XcYi7yij5ZOzA73zwJPHOoej6o/gZivSORFgOkCODv1ho5Gos7ZN5is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965291; c=relaxed/simple;
	bh=uONFlkAf6NBbm48RNzUO1h/HcHk6fi3wX72Wz4wzAhk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=IkgGyAihfgO82Xhp0yhFOVY592AXZ5QqWCsRtly3cLZ5t2OAmg8necYSHjKIFEytRDFaB935Rs/6cpMEqQMwMD0MwPa0i0D0oPfqalkemLZMH2LAUGg4OAlYCm+rmwxFd7tial/ieMB36ebzm7A0k8B+uWKA1veYpkbVpl3sPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=EuqsUOuU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ya89ljFO; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2F9451140098;
	Wed, 20 Mar 2024 16:08:08 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Wed, 20 Mar 2024 16:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1710965288;
	 x=1711051688; bh=uONFlkAf6NBbm48RNzUO1h/HcHk6fi3wX72Wz4wzAhk=; b=
	EuqsUOuU9FQ3x/IbzxAeBnzrg/Ij+p01vhB05ZZzq24tsLgniogK5saaRf0CeOIY
	bHRUGfyo4wv0A+uQiSirqmDrvnykKEvnRA+vgFI9gWFAqtNusRmLBtlhxqB/vp1f
	OWg1lic044URU1SIrsz6giy/gbXdehZqFaZkYEoe1JzVRhsB1IjKMrgmV38g5oax
	AGaUEDI0s08jXT+2Ca1en8cX7x7g72O0wFDArt8QUOch4qeZCSlU4+LldfyTzU1T
	iDxztnfevEqek87svITDdN/3UOpyRtOwXG0BxjMoSud58kdqrJ0k0Knu8W3XfyHz
	S76kTswbG6OC6Dvkwh5S/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710965288; x=
	1711051688; bh=uONFlkAf6NBbm48RNzUO1h/HcHk6fi3wX72Wz4wzAhk=; b=Y
	a89ljFOmZUUpg6LjdS4ILN1TQ8qxcffWlosQ/JPkmuLZxpwdCvF4qkrAYcMm6wCY
	2tKlKHN4l8u6mN8U4JdukKZA7C6jdJZ24BhpBwnBLkALxmtwn3sFdaU3ieE+CzBe
	58CcafdnonlZX1sN7tL1TiMO5q1s+L2SJOretP9jnGBrjOjuKfIFTMDwZLzw3LIW
	NbFhyLSbH01PFlyYtlY2PJESsAGNBv+mJymz3bddNh8Q+t+iyrNzXLrxMA7tw9uA
	aBDF8klGYD//51LpjUxYeR1ybb7NdZZpaHF/t/Q7QbdIwAm5k4KoZ52VZh82cNVz
	EvsjDk4ihFYwXFT5NfyQg==
X-ME-Sender: <xms:J0L7ZZZMdjTpa2aWe1B1ZOcYLJ7CYe4_xakWA5R5EJbup5O15RyeHg>
    <xme:J0L7ZQZ8a5XyN7TcLTm-sPxnGnWmpxt8YWC-8z2mrPefFQoeN6WKqQxBsAmCYDb43
    jiL1Nlw2FqXxzHeIjM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeggddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfn
    uhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrth
    htvghrnhepfeeugffhvdeufeehieelvdegfeffveegleehtddvheegkeetueegtdegueeh
    vdelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:J0L7Zb-KGbFyOEg2ItUHEeFcb059W5D9s46YbWI3xlcJLX6CJk5FPQ>
    <xmx:J0L7ZXoZfylDo6-bOMTg_DZ-LkfvA533g4RhptRryRdBwei_qRV2Ww>
    <xmx:J0L7ZUo5vWA9DESUUHhHWs0tG-3AfScrGIIWNli-Sefn-p6zr4DusQ>
    <xmx:J0L7ZdR8KK-4p7xGymxBi_raN7Bt-AgDwJ1N0VftwimCw0CHSBkizQ>
    <xmx:KEL7ZfUoDFbj_3oZmFvufqlt6f2vWR6qxGyOuSFLJY48HGmyPArUaQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 874562340081; Wed, 20 Mar 2024 16:08:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <33a380bd-e3fd-4022-a707-1d14319f202a@app.fastmail.com>
In-Reply-To: <c7e375df-e709-a348-a240-0d6d8bde1840@linux.intel.com>
References: <20240310055312.11293-1-luke@ljones.dev>
 <20240310055312.11293-2-luke@ljones.dev>
 <0f35beb8-5453-63cb-0570-752b2693f6ec@linux.intel.com>
 <fbd2dc65-33d9-447e-9edb-78df370778be@app.fastmail.com>
 <c7e375df-e709-a348-a240-0d6d8bde1840@linux.intel.com>
Date: Thu, 21 Mar 2024 09:07:41 +1300
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
 "Hans de Goede" <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: add support for Vivobook GPU MUX
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Mar 2024, at 1:02 AM, Ilpo J=C3=A4rvinen wrote:
> On Wed, 20 Mar 2024, Luke Jones wrote:
>=20
> > On Wed, 20 Mar 2024, at 1:26 AM, Ilpo J=C3=A4rvinen wrote:
> > > On Sun, 10 Mar 2024, Luke D. Jones wrote:
> > >=20
> > > > Adjust existing MUX support to select whichever MUX support is a=
vailable
> > > > so that ASUS Vivobook MUX can also be used if detected.
> > >=20
> > > This description is a bit on the short side. It wouldn't have hurt=
 to=20
> > > first state that Vivobooks come with a GPU MUX WMI that has a diff=
erent=20
> > > WMI device ID. I can infer that after reading the diff but the des=
cription=20
> > > should not require reading the patch.
> >=20
> > Would you prefer I changed the commit message?
>=20
> I kind of tried to give some leeway for you and not sound like I'm=20
> enforcing you to do it but yes,

Hey it's not a problem at all. Part of the review and all feedback is va=
luable :)

