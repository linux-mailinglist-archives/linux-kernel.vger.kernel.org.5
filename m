Return-Path: <linux-kernel+bounces-128848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FC789607C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6011E1C23341
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2979310FD;
	Wed,  3 Apr 2024 00:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="QzfXb/zc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="usJob1th"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57C1360;
	Wed,  3 Apr 2024 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712102787; cv=none; b=DYQpH2JWjJ4EYEqoCCgQIxeAhheAIZJT7UGRVyWFjS5IgcFLjjZx1HzgGa09QT4XeOc2AhsaXyNoPrrZ5h5E+5tAD4G6JCaTRyvTx9LPyt7LFm46KhCyh7ZrDsKDfiqkooBER1KN8rJeyIHriioeVhkXoeOTwJCjjqWKglt3UQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712102787; c=relaxed/simple;
	bh=XcfrTHhJLvglQbqn87aogUGV5RFe2AjR6lsNjkf5dgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loNg+dMK1avAeVDYaGnEBSm5lXoKmR4RtwBi0cIHWpd1GrRDWNsrLmfQXnFdwz1tMOV5AVCz1UkAS9HIEgeTEfQxonKJO/8s5WdCJ9/95Fpf1YUtURbzep1MwhxiivuDgdin6lOIr+TN9M+yRZzsKa4rU/OmDqG3aShuijR0RHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=QzfXb/zc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=usJob1th; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id DD50813800C2;
	Tue,  2 Apr 2024 20:06:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 02 Apr 2024 20:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712102783;
	 x=1712189183; bh=hWNF6G5rsIjaO+N+prGyi6w41Topwik2A6vIksJO8Yc=; b=
	QzfXb/zc2FfrfJjTbO9sOBr9WZSwsBIqKt2F20QXxzxKR9fRVZNjgwumAktWjdg+
	YZnzVq2rg9U3llCzWORnhvpQZZOzfZwKgjqyt/oIEePyNFGp4KAtMgNnmwojwzTe
	9FBGFi6jMrbekaIYlutD1RqTNe/ny3qfH6b6XLwHV9TlRE81xz6feRGdrKEfGC2W
	qYjQ8ESPc7hkm95Wt41IO1VCF/TYMLBKciZONvVtWpE01/GMsd2KwlH4IaFtKte9
	FkcBluwOhTBgiPBjsHKDO0iezOVzs+c2JGpYEKotkCWzq5R28rrPabcKBtdZ7Ew9
	WR6qSseRmEh9Sp+N8lfAcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712102783; x=
	1712189183; bh=hWNF6G5rsIjaO+N+prGyi6w41Topwik2A6vIksJO8Yc=; b=u
	sJob1thWBv9QyrRvwXAtDevVJFy1qF/uGhBoxmsB77qaLg7u8tdRMXkygUulimen
	oLfZXEeaXyh7sF3cANy6nIqB/POjVT8mydfqY6WzkzMVxkevPi56lIt3h75PGQGt
	OkFDXDRz86gZ0rWyZTUkCe+HJIyBKMSIa9cj5qp25OkpxwgIM6LaoYn9RdLUoYFf
	zJ7TeYFTpeZ9xpH51ui6709jLmSeKz8H6Ag36IuT4Pv3pUUHpSdIjgw9/7A7El0T
	pwrOAnP7/y3GnMQCNmhpM6UlJ0AevFM/xpfa5AuGE29F2xVH/BZ9YdlUe5KLbn2t
	inGKmw0UdpXDwW7YziGBA==
X-ME-Sender: <xms:f50MZs0UbzdX4VkEDigd-XnCAx_xQRvZbMMHCS--QN_eP7LJpG5fnw>
    <xme:f50MZnEl7qFgNm_FCm7U4LykA7Dl1jVsYnqLfydw1c1w4b8QRQidxCn7C5JDbgkd-
    qMEYoosn8_hTSZJo4k>
X-ME-Received: <xmr:f50MZk7PlWF0sxTzKKvh7Sl-KlTobXbLxAoOgJEEu6sH8War3_U_vPyFiFPzCvvL6mcqcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    ephfeugfegvdeitdefgeevvdelgedutdejueefkeffieevueduhedtueektdffjeeunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:f50MZl3E1CklCvRVW99ZMMQJfgducM51oX46eM0ZOVrcowzuaokBpw>
    <xmx:f50MZvHtAuB8k9d0aekBBCvswnA0gSCQpr43E94N3McRovE04IBpvQ>
    <xmx:f50MZu9xGNz_dxLQ0zhvNUhWi0qCu11N0MUjhDQn0Qn8iwpOf9YQlw>
    <xmx:f50MZknOtmkHf8bCy3OpaV9guC4VnoeYMtY0lLJ14EwdLojnwfziPQ>
    <xmx:f50MZgOXNCfIxHYBisPUUI5Ri2VGqIFjz0zHssI9zfhJwQqOBoTIEnhp>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 20:06:21 -0400 (EDT)
From: Luke Jones <luke@ljones.dev>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH v2 4/9] platform/x86: asus-wmi: support toggling POST sound
Date: Wed, 03 Apr 2024 13:06:17 +1300
Message-ID: <21854739.fSG56mABFh@fedora>
In-Reply-To: <0c8635b9-db16-9125-63bc-7761800e3e96@linux.intel.com>
References:
 <20240402022607.34625-1-luke@ljones.dev>
 <20240402022607.34625-5-luke@ljones.dev>
 <0c8635b9-db16-9125-63bc-7761800e3e96@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 2 April 2024 11:47:08=E2=80=AFPM NZDT Ilpo J=C3=A4rvinen wrote:
> On Tue, 2 Apr 2024, Luke D. Jones wrote:
> > Add support for toggling the BIOS POST sound on some ASUS laptops.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >=20
> >  .../ABI/testing/sysfs-platform-asus-wmi       |  9 ++++
> >  drivers/platform/x86/asus-wmi.c               | 51 +++++++++++++++++++
> >  include/linux/platform_data/x86/asus-wmi.h    |  3 ++
> >  3 files changed, 63 insertions(+)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > b/Documentation/ABI/testing/sysfs-platform-asus-wmi index
> > ef1ac1a20a71..41b92e53e88a 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > @@ -194,3 +194,12 @@ Contact:	"Luke Jones" <luke@ljones.dev>
> >=20
> >  Description:
> >  		Set the target temperature limit of the Nvidia dGPU:
> >  			* min=3D75, max=3D87
> >=20
> > +
> > +What:		/sys/devices/platform/<platform>/boot_sound
> > +Date:		Apr 2024
> > +KernelVersion:	6.10
> > +Contact:	"Luke Jones" <luke@ljones.dev>
> > +Description:
> > +		Set if the BIOS POST sound is played on boot.
> > +			* 0 - False,
> > +			* 1 - True
> > \ No newline at end of file
>=20
> Add the last newline please.

Editor removed :(

>=20
> After fixing that, please add:
>=20
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Done and done.



