Return-Path: <linux-kernel+bounces-160533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D058A8B3EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866282848F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B8416DEAE;
	Fri, 26 Apr 2024 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="QE+QogRD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cZ16Xyqj"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865B216D4CE;
	Fri, 26 Apr 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714154753; cv=none; b=P39FA0bZkRsvIpnVBhRKYoUU958hwMHjERr2/6lzrL9qhfyVgY+cCbcESGR9Npy5BIVrlJpAfbP287Fldo0P81SsEa6xJc569f0QxbiBbnNL3jJce2sqkU1+3/l/VReFfun/MT+x3Yltoif5dNIudKlJ81A6cw29BeOmk2TxbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714154753; c=relaxed/simple;
	bh=nT/oBBOjjNApvJlf7aRiQoZ6G2VijJYzRaV0cSow35I=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pu197jDAVTHD0PaAhpJWr5ALUJicfHANd6Sa11vc2J/DoyJvi4yLlagGPaiNJ+a6akn6pQQNXxtuJHBwl8NsCJY/EPslNnH3l6SUtUTzWxP83JTVNaLF5qZD2bTQXNL2COovQmowbJtOL3VDVcJJmiQBe/7ZISGB8eigR9ckqzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=QE+QogRD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cZ16Xyqj; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id B868B180007B;
	Fri, 26 Apr 2024 14:05:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 26 Apr 2024 14:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1714154749;
	 x=1714241149; bh=nPovvuf7k5MAjZUZqG7ireg2weJG8ZVQLCrzLgnFtK0=; b=
	QE+QogRDZrHEWEIk7sK+UYjH18TcZqf6JK6vXJW653Vq2EihijYbGHzHpBgEu4VH
	DdJpZuEphwEXQxtedQJsDl5HVAO2wR4JPpiDlbsRbD/K56/E1ek4pEGOZJO0n4nZ
	d+MEON6BKAkHTBdL+DY4XVXLgeAL2pZ6tBlDkUoVfSH4EGwg1bobkPa3eMoSMzoF
	DW4yozLEtDvC2RiLLn5XvkbtNY3vWy7aKDF2lrzSwHDHJg+FIsTAX38EUIxYvLkh
	dWjW2iu6+f/DF3PdxR865CokJiYyEcFGqwnGjFAKxrkUpE0I/GD+QBwJFag8dyLh
	4BRcKM9NJTE/lXiJdKsnhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714154749; x=
	1714241149; bh=nPovvuf7k5MAjZUZqG7ireg2weJG8ZVQLCrzLgnFtK0=; b=c
	Z16Xyqjk6QXPSrNSYa9fbl4w2Smfd9B2QYmS64QMVBGiyZpqqKNwaCon6nLB52Qu
	Rqte/4PMCCCj3NOXadN+xAO2vlRYb9E+IHuND5003I6C2UaXDEfI3NyMi5UZh6oQ
	Ja0s6h5MODFdeESYZMGiIr/GEmEat3Q3rLXuZT5CF5zvVaha9D5AUI6D2ewdm+0e
	0uYgquwdJOJ+Zv9W1Ai3TN/TGLAfS9QuFsdUP9FSmGla5zZXFkVjKcXb2HE32Gx8
	qsc5Y1MdLiNnPghfUX8H+H/ttY68LEHNaXOtiWWHTiV0Pq+dfyey+1FNxO88fqtB
	AlkzVx9+B8MKAGYR3F2Fw==
X-ME-Sender: <xms:_OwrZhVxmH5RaDkmPUXMyt5m7bzyM38Y-pP_uPTI1T3A_e5l613xGA>
    <xme:_OwrZhkg05lDn7v2rhAAXGd1OJFNlVfs--StDoY8V2vwy0h3l3n9frj3Yhf84rtus
    kJcurg6MSJ5XQHq1og>
X-ME-Received: <xmr:_OwrZtZ4J2qW6od58rCeQAK65UtFtOU_syc8QTsOcWIxRmgG5X2dpgrPMs_MH_kP3lkhB2ZT3yol0Nmc4E0VXIW2r13z6WwfkXUr0zQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffuvfevkfgjfhfogggtgfesthhqredtredtudenucfhrhhomhepnfih
    nhguohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhihnuggvnhhordgtrgeqnecugg
    ftrfgrthhtvghrnheptddvfedvteefgeegjeegjedvveetjedvheehtdeuuefglefhueei
    ffeiheffteehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:_OwrZkUjiudZZu876SUQX4EFZGeHdHAE_SbyCgTSyq3y1aFlBizHFA>
    <xmx:_OwrZrnGYEfFDEY6mA22gTphwUj3jKIPwEsQ4opUJ7yeYB6Fw4FO4Q>
    <xmx:_OwrZhdvMXjyXVGVXB2oJjmH6MWR58v6qYPc-KzoGcLbA_aBUU73pw>
    <xmx:_OwrZlGIrGSsxbt114v6rjQVOivKiy7L3b0iUgIodWKei3_5u325mQ>
    <xmx:_ewrZkd5Wt2020nARb5BvvNuhIncq_4yKEH8iXp6ZMaAX1qh4Re8ay3t>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Apr 2024 14:05:45 -0400 (EDT)
Date: Fri, 26 Apr 2024 12:05:36 -0600
From: Lyndon Sanche <lsanche@lyndeno.ca>
Subject: Re: [PATCH v2] platform/x86: dell-laptop: Implement platform_profile
To: Ilpo =?iso-8859-1?q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: mario.limonciello@amd.com, pali@kernel.org, W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com, Matthew Garrett <mjg59@srcf.ucam.org>,
	Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com
Message-Id: <C9AKCS.CKJOJZMUUKSZ1@lyndeno.ca>
In-Reply-To: <e861d645-0908-d68b-87ad-0b8b8999fc06@linux.intel.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
	<20240426020448.10862-1-lsanche@lyndeno.ca>
	<e861d645-0908-d68b-87ad-0b8b8999fc06@linux.intel.com>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable



On Fri, Apr 26 2024 at 12:23:00 PM +03:00:00, Ilpo J=E4rvinen=20
<ilpo.jarvinen@linux.intel.com> wrote:
> On Thu, 25 Apr 2024, Lyndon Sanche wrote:
>=20
>>  Some Dell laptops support configuration of preset
>>  fan modes through smbios tables.
>>=20
>>  If the platform supports these fan modes, set up
>>  platform_profile to change these modes. If not
>>  supported, skip enabling platform_profile.
>>=20
>>  Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
>>  ---
>=20
> Two things:
> - You're missing patch version history (put it below the --- line)
> - Don't send updates so soon, give people time to comment. When I saw=20
> v1
>   for the first time, you had already posted the next version.
>=20
>>  +void thermal_cleanup(void)
>>  +{
>>  +	platform_profile_remove();
>>  +	kfree(thermal_handler);
>>  +}
>>  +
>>   static struct led_classdev mute_led_cdev =3D {
>>   	.name =3D "platform::mute",
>>   	.max_brightness =3D 1,
>>  @@ -2238,6 +2452,12 @@ static int __init dell_init(void)
>>   		goto fail_rfkill;
>>   	}
>>=20
>>  +	// Do not fail module if thermal modes not supported,
>>  +	// just skip
>>  +	ret =3D thermal_init();
>>  +	if (ret)
>>  +		goto fail_thermal;
>>  +
>>   	if (quirks && quirks->touchpad_led)
>>   		touchpad_led_init(&platform_device->dev);
>>=20
>>  @@ -2317,6 +2537,8 @@ static int __init dell_init(void)
>>   		led_classdev_unregister(&mute_led_cdev);
>>   fail_led:
>>   	dell_cleanup_rfkill();
>>  +fail_thermal:
>>  +	thermal_cleanup();
>>   fail_rfkill:
>>   	platform_device_del(platform_device);
>>   fail_platform_device2:
>>  @@ -2344,6 +2566,7 @@ static void __exit dell_exit(void)
>>   		platform_device_unregister(platform_device);
>>   		platform_driver_unregister(&platform_driver);
>>   	}
>>  +	thermal_cleanup();
>=20
> This is still not right, you'll still platform_profile_remove() even=20
> if
> the init side call failed.
>=20
> --
>  i.
>=20

Thank you for your feedback. I agree with your comments and will add=20
more checking on whether certain cleanup actions are necessary.

Lyndon



