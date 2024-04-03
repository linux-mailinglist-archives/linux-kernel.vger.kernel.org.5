Return-Path: <linux-kernel+bounces-129335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D46E8968B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4451F2A46D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BB36E5FE;
	Wed,  3 Apr 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cz+GR88/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC11C44C8C;
	Wed,  3 Apr 2024 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133083; cv=none; b=UMUtt0Zb542jaNANEKaYqYBhCNoEM6VHIFI0DoZS+Hn0S2V/CmQbehoQOfiLSIjFFKYq/zAREdiX+593HC8RvcRr/ZWJZF+emjnuPMPTmdYVyrEVCi4HaUxik3NI4LIKO0PreVO9QzHe9m9pamBOepfX58RJNjyV6xFaEIoeGPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133083; c=relaxed/simple;
	bh=RqJyN0hEVHVjcA8Rbw9SFpPLwpA2ggCDucLROXLaXQ4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nV8QVvexYwAHDpOVzRHuwIWtsQ2OmqSKQCq6KPcHSaoz3ww/ASqUVIcU8Pse99DNWnXwhWh+H+MmCr9o5dvRA3XOT3+FkEYYT8fB59Ti8psx31ZkGRCAeZkkaguooZxLvd+5Zr1ZdJGd2/Ssle5Lzz72gesbTiVHFhAszqu5vzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cz+GR88/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712133082; x=1743669082;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RqJyN0hEVHVjcA8Rbw9SFpPLwpA2ggCDucLROXLaXQ4=;
  b=Cz+GR88/fjWWCKV0GjyMSNfleXAwL63pKweMVHuL88/TFY6Y4izr6YnR
   MCstiGpG9etDR6+5COt8psUqePUoVqp3DC2hFRmi3iC2wltAE3gMorwU6
   8UGj6upsd8nuzQ/0R60KHuDgPeTxKUUlWqs4oYYaK86rC/IERCpkj51YL
   x3NrwSgmyy94bsQuZFTEA+mXfXZGwJ1lwMeIBJEbuUG60OvqJquZkU1wr
   lMhI6S6eAI1RW7T+gd15WqVncvkhuj27pNkDxHhQrsiDFltMBTwr/F0MV
   +CpSRn2jHx5xAJK5+g+oGfj+9nJ8v8uIoijAbFpSdAqHHXBHOU1s3NJcl
   w==;
X-CSE-ConnectionGUID: KWdGFPKIROaXnGA7rHzfiQ==
X-CSE-MsgGUID: NziOSNovSYSC4HbJG3FHjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18793076"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18793076"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 01:31:21 -0700
X-CSE-ConnectionGUID: NHfEeCZOQ1SykuOzeFUjsg==
X-CSE-MsgGUID: iWbmClEmQQaHdHi5bL9GaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18398328"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.24])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 01:31:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 3 Apr 2024 11:31:14 +0300 (EEST)
To: Luke Jones <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 8/9] platform/x86: asus-wmi: Add support for MCU
 powersave
In-Reply-To: <24071185.4csPzL39Zc@fedora>
Message-ID: <42f09e54-5669-2242-28db-240405e7c4bc@linux.intel.com>
References: <20240402022607.34625-1-luke@ljones.dev> <20240402022607.34625-9-luke@ljones.dev> <71426f4c-a44a-cf87-7045-b3f2b3fc240e@linux.intel.com> <24071185.4csPzL39Zc@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-687975693-1712133074=:1449"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-687975693-1712133074=:1449
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 3 Apr 2024, Luke Jones wrote:

> On Wednesday, 3 April 2024 12:01:15=E2=80=AFAM NZDT Ilpo J=C3=A4rvinen wr=
ote:
> > On Tue, 2 Apr 2024, Luke D. Jones wrote:
> > > Add support for an MCU powersave WMI call. This is intended to set th=
e
> > > MCU in to a low-power mode when sleeping. This mode can cut sleep pow=
er
> > > use by around half.
> > >=20
> > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> >=20
> > Hi,
> >=20
> > I fail to follow the logic of the patch here. This patch makes it
> > configurable which is not bad in itself but what is the reason why a us=
er
> > would not always want to cut sleep power usage down? So this sounds lik=
e a
> > feature that the user wants always enabled if available.
> >=20
> > So what are the downsides of enabling it if it's supported?
>=20
> Honestly, I'm not sure. Previously it was a source of issues but with rec=
ent=20
> bios and more work in the various gaming-handheld distros it's much less =
of a=20
> problem. The issue before was that the MCU would appear every second susp=
end=20
> due to the suspend sequence being more parallel compared to windows being=
=20
> sequential - the acpi calls related to this would "unplug" the USB device=
s=20
> that are related to the n-key (keyboard, same internal dev as laptops) an=
d not=20
> complete it before suspend. And then on resume it was unreliable.
>=20
> I worked around this by calling the unplug very early, and trying to "plu=
g"=20
> super early also so that subsystems wouldn't notice the absence of the de=
vice=20
> and create new devices + paths on add. Most of the requirement for that c=
ame=20
> from some userspace programs unable to handle the unplug/plug part, but a=
lso=20
> bad device state occurring.
>=20
> But now with the forced wait for the device to finish its task, and then =
the=20
> forced wait before letting it add itself back everything is fine - althou=
gh it=20
> does mean everything sees a device properly unplugged and plugged.
>=20
> All of the above is to say that the "powersave" function was also part of=
 the=20
> issue as delayed things further and we couldn't add the device back befor=
e=20
> subsystems noticed.
>=20
> Distros like bazzite and chimeraOS are now using this patch, and I'd like=
 to=20
> leave it to them to set a default for now. If it turns out everything is=
=20
> indeed safe as houses then we can adjust the kernel default.
>=20
> A side-note I think is that because there is a forced wait time due to un=
able=20
> to use the right acpi path, the old excuse of "but users might want the d=
evice=20
> to wake faster by turning off powersave" doesn't really apply now.
>=20
> I will discuss with the main stakeholders, but for now can we accept as i=
s? If=20
> changes are required we'll get them done before the merge window.

Yes, I think it is okay to make it configurable first and then look=20
separately into making it default on.

--=20
 i.

--8323328-687975693-1712133074=:1449--

