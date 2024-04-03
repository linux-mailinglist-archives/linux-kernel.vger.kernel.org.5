Return-Path: <linux-kernel+bounces-129328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F37689689E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445821F2920B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7666BFCE;
	Wed,  3 Apr 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="PMCfSvDi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1E7dnUo"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF26773B;
	Wed,  3 Apr 2024 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132717; cv=none; b=rn0o5X9NkhaCdFNg6+PChfFjjFDc+8LunVvLJew9dxJSaLcT5hVTCGlnSVIqDw3S1v7xrO1SUWRWt1Sfi3WjnUNl/wwogNejGZk0RkJvlEmkXKSXJ9G8LwYexu1RQ7aNeCBkICW0dKXn/PWcDJ+9GfEC6eFZSREXjNryhNdAObg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132717; c=relaxed/simple;
	bh=eDMSGeYKsWweu456Jo9u7QgAQKWHGkUYnY4GIJaQvzA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Ph2wu2ghnDl4bSGYqi2XQo8s8Fw/IG5mLst/UT6SOkeN/1f7JTD0Heik6vhDMeEejGDAybRpBH+NzCzxENCLP48kbwrQD2HgBj+bVDw4kgLNzvYDcu39rtU9fCeRt65NIpv0IBmWf6rHlled1CsRy6y55iMRehA1eIbemsv37Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=PMCfSvDi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F1E7dnUo; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2356F18000AC;
	Wed,  3 Apr 2024 04:25:14 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Wed, 03 Apr 2024 04:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712132713;
	 x=1712219113; bh=eDMSGeYKsWweu456Jo9u7QgAQKWHGkUYnY4GIJaQvzA=; b=
	PMCfSvDi56urkReUUrEASAtbEneww3GcjqzSxZP0uLqJDXJNbyQv9XNjl+uj+8eI
	CPVVtOMg9Qr6QIY9w2S81nmBsycCP+8hcT76FlXFt+RX0gx7SdiCHrweWL4K3WCr
	JV1C/+b5PcfRV+X1AMH9ePv6hob48ultKNAOxl28tOMjYBnvUF5VOG8oYV6BsjZW
	W8YvVTKtMnL5nDRocvqX27Zr7g7xUKuqwOJXl8duEneGx6/RLNo5wLvqv2ASqxy0
	4038ULSU0+jLRgv3QXeMpBfmDryjFnwweMpicXfiK0ikrKLigSTRCCHP8kmG7lo8
	55Qe1iZ9E2Nek4VgOOIj0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712132713; x=
	1712219113; bh=eDMSGeYKsWweu456Jo9u7QgAQKWHGkUYnY4GIJaQvzA=; b=F
	1E7dnUoqOoX6pT1h674HmvhLZjf72WHuJj92JEEL+Gazlma6dn9XGEYVKUhk1MH6
	+LLLmoCgYtts+zotII7vFwIr0xnpQ1ZFk6anCnFXh1jkVRPAsvoeWcleBP8uupRH
	NTUsuV2RzzF4e0HxehU3vqd7n0YHWHJSMao+2kfGzFKX0GZoiGJ9CMWjUJquhGds
	HF50/Utr1wgaEzGNshnn0c2yv5HfZ2nrjZ9tNU8WzgeXB50oP7EG5IGFa0fJI3HB
	gG9BLU5pOKZUBsPbSjQWNfOlRyqNW8vT2cguxxAbSHosIeCXrCnDSbwY8ZYQDtEy
	WHFv/RM4WuRp0KpKNyJBQ==
X-ME-Sender: <xms:aRINZkE-iuha8qIqIgRxvWKPTjGr_ScjF-Gg27CyX9DI31TFaYricQ>
    <xme:aRINZtUDrUAsafbizR6l5HuTk9zG4PZ4_TR5sQBcaJkb6Rzte_rVf39oK9zVeCxgY
    IQ9Uf7s5z6MmNiaxyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfn
    uhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrth
    htvghrnhepfeeugffhvdeufeehieelvdegfeffveegleehtddvheegkeetueegtdegueeh
    vdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:aRINZuJX2DCKDf49-4ySfItQm1kgdRJfoFs08zIpH6Br2yJAEOheiA>
    <xmx:aRINZmHjTXApn9mXZd-M7xnylVN3W444m7fSf63qtf7bOtUnQ19EXg>
    <xmx:aRINZqW6IsP-puRgXc64_Qx6ojTKp48o_8GqRLyM7_lu2Di5rrQ9yg>
    <xmx:aRINZpNSfPB8-TpUDoxtNg1L-bZ37PI7LzJCulLBW_tiKaY3iAEXQQ>
    <xmx:aRINZozhQqJnSUx1gF-Og0pVIJ-6mbKSaYHtr4M-ugKEE6J2J6Bgxw4u>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3D2972340080; Wed,  3 Apr 2024 04:25:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a64cd887-423a-4dd7-92eb-42d9485aea3d@app.fastmail.com>
In-Reply-To: <e48c5226-9a25-ff24-45d8-5cc73d7d914e@linux.intel.com>
References: <20240403002917.2870959-1-luke@ljones.dev>
 <20240403002917.2870959-6-luke@ljones.dev>
 <e48c5226-9a25-ff24-45d8-5cc73d7d914e@linux.intel.com>
Date: Wed, 03 Apr 2024 21:24:53 +1300
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/9] platform/x86: asus-wmi: store a min default for ppt options
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Apr 2024, at 9:23 PM, Ilpo J=C3=A4rvinen wrote:
> On Wed, 3 Apr 2024, Luke D. Jones wrote:
>=20
> > Laptops with any of the ppt or nv tunables default to the minimum se=
tting
> > on boot so we can safely assume a stored value is correct.
> >=20
> > This patch adds storing of those values in the local struct, and ena=
bles
> > reading of those values back. To prevent creating a series of byte h=
oles
> > in the struct the "<name>_available" bool is removed and
> > `asus_sysfs_is_visible()` uses the `ASUS_WMI_DEVID_<name>` directly.
> >=20
> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
>=20
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> (I know it is already among the tags but I had not given it until now.)
>=20
> --=20
> i.
>=20

Understood, very sorry about making that assumption.

Luke.

