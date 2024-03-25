Return-Path: <linux-kernel+bounces-117955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F31E88B540
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC813B3BBA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F9B59B7A;
	Mon, 25 Mar 2024 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="QgbP9Zkr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fP0GsHuh"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6EA5339E;
	Mon, 25 Mar 2024 20:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399276; cv=none; b=APwyaTKr9kS887mlacWhqY5l1djhrAJS7FWrkHivCbMnGDIaPpLTVaRT/s7bKEMm2ecn0ISqQKcd3LhFalzSjUXTPdRxOlpmkeK5xODDy/WZXKDvt5A0r/5KwQ6tnbDZwxd3Nq+oTS28J4O9vOGIYh2cKGKiAfykJzSYsRrPq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399276; c=relaxed/simple;
	bh=AZfiX4U8udItCqwmlbGPFLCaBzhaoBqd8vYmueAmlpM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=IlhN1B+VbmeT6HIMdoMfPV9mhNazgLD64PgOAmfm3Z6ZYAosA10bh7fZv/7WcFm28xgFmv1kHey4PKQRlMWc13hWS3DBsEY1foySfN9Gv0PxN/xdOF8OVy7iK3YDtMuaCysr20TCGzutxdhPeOJw6j5kOWf04tAlj8gwUxWkeIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=QgbP9Zkr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fP0GsHuh; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 92B6F1140146;
	Mon, 25 Mar 2024 16:41:13 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Mon, 25 Mar 2024 16:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711399273;
	 x=1711485673; bh=gPru8m7xJxHam8/aqizU6Q6/6PJW4kfex+HnFyxOo+U=; b=
	QgbP9Zkrn66lhBcw7pM13jgn151lhUHcEeUSHa3ow9kx/ym9+qHluxLj9PJbqSTT
	Dl4Ef8Jdm9raryNRAFM1BWa284HrogxaBsqQLrg2h3fg4VCGwZPsgIezu5BI/6u2
	gFWF6rUlcZfoKyffqhLSx4GKiycq456GeMzYQ94HgZAkztt3ySIAo53fhy7K3/Qx
	rF6ImW84Pm1F7XOdJ3xxqUPHbuox/vn6O6vP6XBrQ+mF5+RN6grJU+oNAIb7M2AO
	DFkiBlFE3ZOJnSdaQzI0bEJWyYl7W46646T/sb6oppwcQxtJfCEF5xkb0Db310Q/
	v+XwLm38J29DikaBhlb0+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711399273; x=
	1711485673; bh=gPru8m7xJxHam8/aqizU6Q6/6PJW4kfex+HnFyxOo+U=; b=f
	P0GsHuheGzM/SoktDsTPEahGXvReX7tJHYIX4l7xl8S0zlUyzPrC7owGxrsJaC/E
	FBxZhlq+xxps4Tx3SadUT56lqbzi3uyzcgkdqmA5aq9wAEo15U18OY/HVilrtsz+
	kHFt+I6PkZ51HXJfh/vB74O5/ZUPwsRmvKDCUYsywwGe3DJJaglgM9HISP/lQkYy
	1VsQaXD4U2UGYIT9sdT1EeAj1l6aYrBCtQSNmHKc/L27OZ+IvacM/OIe7uDxUYG5
	gLAV0dQabGgwnYWuSSp0V8gj5QRuuslaK5CjYl2R5l8GvgJsKpDiH/aRBWxEUSag
	Y/O0lH3qSzbETMdnoI/rg==
X-ME-Sender: <xms:aeEBZvUniY0j_jDcVPl7kwqTwBan8JjTosXwjHeIBhM13baSfmJ19Q>
    <xme:aeEBZnk9HhEJSAsm1px65MO8GSa1u5LgLAIHxRzzDONHVUc3r0q-eB2pLpZ6yu3x9
    8dOVu2VNl1ZYKZo3uA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfn
    uhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrth
    htvghrnhepfeeugffhvdeufeehieelvdegfeffveegleehtddvheegkeetueegtdegueeh
    vdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:aeEBZrY6BwaQcgHYAldY79WYwcfkkyA8HryLsebfjIVYiAWwZKNoEw>
    <xmx:aeEBZqXvfki4ATXjzHsJgGpDVrsTHi6rdqZkMi7AUFgnUkyunSNoiw>
    <xmx:aeEBZpkLuifUt8B176uaPm2DAWIRZkWEPxSUF9mqfXv_n-8SmYM98w>
    <xmx:aeEBZncClfBsxjdFEqub4mCdXUBCVadfq7qa8rtLCxbw2UIiFbD4LQ>
    <xmx:aeEBZiCM6IZCAmD0QWl6m4L6RWdZUMIYQREGhMxNT-Q1X2bIUFS5bA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 59F742340080; Mon, 25 Mar 2024 16:41:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c64a0629-b8ea-4a7c-91e4-1caf627c26cc@app.fastmail.com>
In-Reply-To: <88b7d5b0-23af-37e0-6122-fc790ae57053@linux.intel.com>
References: <20240325054938.489732-1-luke@ljones.dev>
 <20240325054938.489732-5-luke@ljones.dev>
 <88b7d5b0-23af-37e0-6122-fc790ae57053@linux.intel.com>
Date: Tue, 26 Mar 2024 09:40:52 +1300
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] platform/x86: asus-wmi: support toggling POST sound
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Mar 2024, at 3:02 AM, Ilpo J=C3=A4rvinen wrote:
> On Mon, 25 Mar 2024, Luke D. Jones wrote:
>=20
> > Add support for toggling the BIOS POST sound on some ASUS laptops.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >  .../ABI/testing/sysfs-platform-asus-wmi       |  9 ++++
> >  drivers/platform/x86/asus-wmi.c               | 51 ++++++++++++++++=
+++
> >  include/linux/platform_data/x86/asus-wmi.h    |  3 ++
> >  3 files changed, 63 insertions(+)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Doc=
umentation/ABI/testing/sysfs-platform-asus-wmi
> > index 61a745d2476f..5645dbac4ce8 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > @@ -194,3 +194,12 @@ Contact: "Luke Jones" <luke@ljones.dev>
> >  Description:
> >  Set the target temperature limit of the Nvidia dGPU:
> >  * min=3D75, max=3D87
> > +
> > +What: /sys/devices/platform/<platform>/boot_sound
> > +Date: Jun 2023
> > +KernelVersion: 6.10
> > +Contact: "Luke Jones" <luke@ljones.dev>
> > +Description:
> > + Set if the BIOS POST sound is played on boot.
> > + * 0 - False,
> > + * 1 - True
> > \ No newline at end of file
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/=
asus-wmi.c
> > index 094a93f24667..6cac9c3eb8b2 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -2106,6 +2106,54 @@ static ssize_t panel_od_store(struct device *=
dev,
> >  }
> >  static DEVICE_ATTR_RW(panel_od);
> > =20
> > +/* Bootup sound ***************************************************=
************/
> > +
> > +static ssize_t boot_sound_show(struct device *dev,
> > +      struct device_attribute *attr, char *buf)
> > +{
> > + struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > + int result;
> > +
> > + result =3D asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_BOOT_=
SOUND);
> > + if (result < 0)
> > + return result;
> > +
> > + return sysfs_emit(buf, "%d\n", result);
> > +}
> > +
> > +static ssize_t boot_sound_store(struct device *dev,
> > +       struct device_attribute *attr,
> > +       const char *buf, size_t count)
> > +{
> > + int result, err;
> > + u32 snd;
> > +
> > + struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > +
> > + result =3D kstrtou32(buf, 10, &snd);
> > + if (result)
> > + return result;
> > +
> > + if (snd > 1)
> > + return -EINVAL;
> > +
> > + err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_BOOT_SOUND, snd, &res=
ult);
> > + if (err) {
> > + pr_warn("Failed to set boot sound: %d\n", err);
> > + return err;
> > + }
> > +
> > + if (result > 1) {
> > + pr_warn("Failed to set panel boot sound (result): 0x%x\n", result);
> > + return -EIO;
> > + }
> > +
> > + sysfs_notify(&asus->platform_device->dev.kobj, NULL, "boot_sound");
> > +
> > + return count;
> > +}
> > +static DEVICE_ATTR_RW(boot_sound);
>=20
> I started to think that perhaps these would be a way to create helper =
for=20
> these sysfs functions to call as they are quite similar, only the wmi =
id,=20
> strings and the range check change (the GPU functions do a few extra=20
> checks and could remain standalone functions but the rest look very=20
> similar to each other).

I absolutely agree. In rust I would have written function or macro by no=
w. I'm working on this but won't submit until we've been through the exi=
sting chain and applied.

Looks like the entire asus-wmi could use some maintenance tbh, I'll do w=
hat I can.

Cheers,
Luke.

