Return-Path: <linux-kernel+bounces-109378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE440881841
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0570F1C23085
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED198592C;
	Wed, 20 Mar 2024 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="JIs94X+j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XcHANk71"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D13710FF;
	Wed, 20 Mar 2024 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965144; cv=none; b=tFxNOLk0dO13ngcziu7akjVVujWCNqRryIlRanqHC8WyO+aTjU25jHINUTdrwQ8GY17QAWZGEvj6MnHLBbyE8MUEwJdO3Fniwmpd3xzn56TXUY5iyuzsBY6FROe0Xicaa/h2gDMor8LzJlK7CC0HTV9YDpZa1u1neQCgjx69jiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965144; c=relaxed/simple;
	bh=MQBGGEOhgnc3mj+xCcQEezogIg6iT5/F4/Re4F02QaY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=VFp4+xzze6XCC6FJwh6WmDEhl5IroHmyKJCJG3qJi+qYbkTsVbHmcHZVhUPdROCL8IyDDe8mj5WhzIxgp5CFplUd6DRtIPp9ZXBb3RkI2UFbmYmVUEBPZifOHdRVWbUywcSBjmeHns1/vAKYemjIIJMsuL9iXqe1OMtsgX2FNao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=JIs94X+j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XcHANk71; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2DDD81140106;
	Wed, 20 Mar 2024 16:05:42 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Wed, 20 Mar 2024 16:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1710965142;
	 x=1711051542; bh=/Oc8U1y8l14/c0pXhzQh6BvDXRT/PDyn/rl7kM5uOLU=; b=
	JIs94X+jZHLj8blU41Mg23upZY9nf+JFZuByQKIF4C5mlFa0ElRj1x9o14sgCgNy
	hj8QQ+XZTV0INvI481qS9USaOUva3jYJUYqcK92efkLc5ElExeuxwDzofADvCzRx
	SI7BIjjNFikiePBNGcmLZOuOnsOPNld/MeDmqF05djs5iV7OLSgqlNvRBx98Ncy4
	ZBVI31wACeT8JkXt0w4/C/hQa8Yizl78FiKxnpj1UB+OVCjXug7LFdnA5zDYjcjP
	hyODe/aTjMZwY7Z+9bLLn67M3mZi3GH3umiF8YdC4Lqa9m6mGVXi5ML3LLVxHcZn
	13ONeldhh53DGicpXs9lhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710965142; x=
	1711051542; bh=/Oc8U1y8l14/c0pXhzQh6BvDXRT/PDyn/rl7kM5uOLU=; b=X
	cHANk71GcUI90QEzHbxNuvnfSy2yL3yZL9ZvWAMG6YmDbvrC8Wz7DyD8h413RkgU
	Or4AUr9GV1kOpLeqqof8Vpw9Szx1Uh+6Ief+EAteT/WHGVQFKXcqITVPKJxR/Ka0
	M8ey4EBhy9egKv8vZTTFvaDKgP0ezzrZUearDx1lmftwrSHoNKNxvDpx6hwhDpsx
	QVnG0AEKUPAiv3QqAayXNcItmpS9gtPoac1rOy5IieeGamos55spHXfuROQ6SS1q
	2yE6xq/O9rURc6vtfYd6wjz20LPXIoUo8un25BhiW7qsN01D036sqaEhKqHKaf7W
	wii0l1VV+gNR/C+b5Mi4w==
X-ME-Sender: <xms:lUH7ZRPRc4Q4OCfsjNblHHCfuz35awEZ66DbgQLbbg8NdHil3t7O-w>
    <xme:lUH7ZT8zofKJodaYRRKmREgp_ExdluavO8pexEqpvq5wbqlMZ_ndQUHRP6-8wMGw7
    JQhALNvRaB_zmxNUSs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeggddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfn
    uhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrth
    htvghrnhepfeeugffhvdeufeehieelvdegfeffveegleehtddvheegkeetueegtdegueeh
    vdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:lUH7ZQTEIfpVfGw1Q_FJbJeaP_SCaKvh3j6OuBaIofved_MX-vPt4Q>
    <xmx:lUH7Zdt5D0cW9V0VyJ7JFV9D8ylDkl1Or97r74fCTdLSWz79qCQsfA>
    <xmx:lUH7ZZdoOaXY8P2r2FsijEmfs2pjjdoGXRwwEVQIso1GXz6nwNhZxA>
    <xmx:lUH7ZZ3Og8uXCPDPTO3HNS4gZHhe7uPXCl03TlIrJiTEZljprit_SQ>
    <xmx:lkH7Zd6Kql7RNbLWi_4wcUCTUvvwPhuYkezYbLifWuhoiRDGWNsgDA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BB04B2340080; Wed, 20 Mar 2024 16:05:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e04bf262-e024-488a-ade4-698844af20e3@app.fastmail.com>
In-Reply-To: <bdcc3052-1403-8c2f-f703-66180394c461@linux.intel.com>
References: <20240310061715.16531-1-luke@ljones.dev>
 <5f853562-cbe0-32d7-2644-d42d2bb9e060@linux.intel.com>
 <7276ec7b-9b00-4241-a4eb-a8997daeba5c@app.fastmail.com>
 <bdcc3052-1403-8c2f-f703-66180394c461@linux.intel.com>
Date: Thu, 21 Mar 2024 09:05:21 +1300
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
 "Hans de Goede" <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: asus-wmi: support toggling POST sound
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Mar 2024, at 12:55 AM, Ilpo J=C3=A4rvinen wrote:
> On Wed, 20 Mar 2024, Luke Jones wrote:
> > On Wed, 20 Mar 2024, at 6:48 AM, Ilpo J=C3=A4rvinen wrote:
> > > On Sun, 10 Mar 2024, Luke D. Jones wrote:
> > >=20
> > > > Add support for toggling the BIOS POST sound on some ASUS laptop=
s.
> > > >=20
> > > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > > ---
> > > >  .../ABI/testing/sysfs-platform-asus-wmi       |  7 +++
> > > >  drivers/platform/x86/asus-wmi.c               | 54 ++++++++++++=
+++++++
> > > >  include/linux/platform_data/x86/asus-wmi.h    |  3 ++
> > > >  3 files changed, 64 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b=
/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > > > index e32b4f0ae15f..f3c53b7453f0 100644
> > > > --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > > > +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > > > @@ -194,3 +194,10 @@ Contact: "Luke Jones" <luke@ljones.dev>
> > > >  Description:
> > > >  Set the target temperature limit of the Nvidia dGPU:
> > > >  * min=3D75, max=3D87
> > > > +
> > > > +What: /sys/devices/platform/<platform>/boot_sound
> > > > +Date: Jun 2023
> > > > +KernelVersion: 6.9
> > > > +Contact: "Luke Jones" <luke@ljones.dev>
> > > > +Description:
> > > > + Set if the BIOS POST sound is played on boot.
>=20
> > > > @@ -2106,6 +2107,55 @@ static ssize_t panel_od_store(struct devi=
ce *dev,
> > > >  }
> > > >  static DEVICE_ATTR_RW(panel_od);
> > > > =20
> > > > +/* Bootup sound ***********************************************=
****************/
> > > > +
> > > > +static ssize_t boot_sound_show(struct device *dev,
> > > > +      struct device_attribute *attr, char *buf)
> > > > +{
> > > > + struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > > > + int result;
> > > > +
> > > > + result =3D asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_B=
OOT_SOUND);
> > > > + if (result < 0)
> > > > + return result;
> > > > +
> > > > + return sysfs_emit(buf, "%d\n", result);
> > > > +}
> > > > +
> > > > +static ssize_t boot_sound_store(struct device *dev,
> > > > +       struct device_attribute *attr,
> > > > +       const char *buf, size_t count)
> > > > +{
> > > > + int result, err;
> > > > + u32 snd;
> > > > +
> > > > + struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > > > +
> > > > + result =3D kstrtou32(buf, 10, &snd);
> > > > + if (result)
> > > > + return result;
> > > > +
> > > > + if (snd > 1)
> > > > + return -EINVAL;
> > >=20
> > > Why not just use kstrtobool()?
> >=20
> > Consistency with other methods mostly. Plus the possibility that asu=
s=20
> > might do something like add different sounds. I'll change it if a re=
vert=20
> > back to kstrtou32 later doesn't break things.
>=20
> Hi Luke,
>=20
> I'd tend to think it's not the most likely scenario. But if they still=
 do=20
> something like that, the code could do both kstrtou32() and kstrtobool=
()=20
> to keep the sysfs interface backwards compatible.
>=20
> But it isn't end of the world for me if you want to keep it as=20
> kstrtou32().
>=20
> Annoyingly the other kstrtou32()s may not be easily converted over to=20
> kstrtobool() because u32 formatting accepts 16-based values too such as
> 0x0. Perhaps hex format wouldn't be used by anyone but the risk is sti=
ll=20
> there and the benefits are not that high.

Understood, yeah. I suppose one of the reasons I preferred using kstrtou=
32 in the first place was no need for casting when making the WMI call. =
Plus all the other code I've written here is similar to this (you might =
notice that a large chunk of what is in asus-wmi now is from me).

