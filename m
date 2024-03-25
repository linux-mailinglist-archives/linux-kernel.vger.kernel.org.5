Return-Path: <linux-kernel+bounces-117942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDC888B19C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07651FA5FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DD7524B4;
	Mon, 25 Mar 2024 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="QZSJ0LNe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iQ/rqh1+"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646C18EA2;
	Mon, 25 Mar 2024 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398968; cv=none; b=Jl62sR1GBx7hBnwfxy1eL6tdFnWagU9NAi2AFhmrqxJD+tY1e1O1xsR4Q+0mOScM92rOGdZDA+W8TBj1WjVQgHjuoGa3CPgyuOop5K03Y3U4kwUOyxlVJX3Be/Ww39iazJEnvj5ZjfTkI+TSz+LJ5XZ+D+KkM+hFmJ6JprLnOf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398968; c=relaxed/simple;
	bh=y6HSKXbk2LnvKJsz1qMq/c8WA8S7zxbpEE3VAgqsJTQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ZTkenkcXuoMn+VA75LV7vyr8zbyuNMFBi+51T+F4hIKNbb/Op+15JAriSAbPSBtJozZE/Pge2lVDfn6rQ6yznGi4z0CJHSnCdX7aawl2bjIuGBLfZfAZUx+5qsEyWWwQD/d5Fne7uUfG+VEOWG8vrMcOTRz5S4XFdbu2kWB1iQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=QZSJ0LNe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iQ/rqh1+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B233B114013C;
	Mon, 25 Mar 2024 16:36:04 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Mon, 25 Mar 2024 16:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711398964;
	 x=1711485364; bh=m2xPQEy5YYTJ6xUklP2AVFmhvWw/0rb5mHbcNfNRrGg=; b=
	QZSJ0LNe2EARQDscXCtYwnIcbm+pcYx6wBIKp79pYoJv6P7hR6eanTbOXGQDSXRr
	BNCt7mqwPZP4lfZBeWWEj5uz8vM5YslE0aLcdD2w74Xe7w9JKO1+NahiRTaMQG4t
	Es7kFFQ0qyct4kNNw2QJabWw5BHP+4bEF0qX2JlBZyuEG4Z6Wh+akC5EJn9WKwtq
	FtD99giaebLC32NGatnJNiKuAAa8uOkNreKSp54mGEyUBdCBRAS86O8XeZHfnXi/
	Q6OyoL/svp2QBi2h4aOR3NkDF12UMQrJEDfLZpaw2fdWC7FOz/FcuAHacyHfEKFG
	LHgCxcN7PCV0Do2v6fPenw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711398964; x=
	1711485364; bh=m2xPQEy5YYTJ6xUklP2AVFmhvWw/0rb5mHbcNfNRrGg=; b=i
	Q/rqh1+hFRI0ref2JGDFi+ZwvsSKiGbmQdqxrIi14qhEaMlrR9ublOF5lmoxAgV8
	hiOvpVnToY/Ua0kx7LOrGSRoKW/K6qPmXUJ/K6ypyGWIaJANFI57qZn3dWxpSQh4
	A5DyEbLWY0kaJr0ZbRP2EsYKOU6Xlh2In0z/fZ19ksqvAm3Yp8YobhUYpmTuHJ0v
	P2CuPoT/1ilLGXQnsOmfJ3dp8KR8nlOnxXXYnpC6Qh4VlPaZCnD3/5S66Eq4EiQn
	2iPibr0pfUhynSSIki9529R0u/eBjpMNF5BaFe3WthbihfLo7Cb/GnttEPK/sfvQ
	XB327zlDgrFfEEy/hqNtg==
X-ME-Sender: <xms:NOABZl66H2mOZg4MyYYcZzzu760DaBBksfnZ6bcyesrVaqknz8Mhlg>
    <xme:NOABZi7qkN4nGBLRaYi_GIIfszwqN0hcH7acYeQL6fExoZ5R4kPqZKJPPbSBKiFdt
    70t0LRZxVf5zzcetc4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfn
    uhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrth
    htvghrnhepfeeugffhvdeufeehieelvdegfeffveegleehtddvheegkeetueegtdegueeh
    vdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:NOABZsdh4bPxQYjeiznLWRa2uxFev8o_G5H163-efyuTXt3-GW7Zog>
    <xmx:NOABZuLXJg-LQ34_kK-dwXd3G1_WdYbctFQJHbrgaWcgQ-F0RRfgwA>
    <xmx:NOABZpK7GpZnwBo9zqqenBH3H9V294DhOIfomiO7L5EXOLBHbOIWRg>
    <xmx:NOABZnylZfUomci-6KAx5_dnJz3jJlgv56gmGokNB99gp4zEaFjvJA>
    <xmx:NOABZmHWH1FIGhmzJapDZI1k-q8DNq4sotdp1zB6uyhhFYZoZfZX3A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 47F4A2340080; Mon, 25 Mar 2024 16:36:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9962eb39-23b8-470c-aab9-698f10c80358@app.fastmail.com>
In-Reply-To: <2cadcf26-7b99-3b32-8441-1b3939cf93b4@linux.intel.com>
References: <20240325054938.489732-1-luke@ljones.dev>
 <20240325054938.489732-2-luke@ljones.dev>
 <2cadcf26-7b99-3b32-8441-1b3939cf93b4@linux.intel.com>
Date: Tue, 26 Mar 2024 09:35:44 +1300
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] platform/x86: asus-wmi: add support for 2024 ROG Mini-LED
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, 26 Mar 2024, at 2:47 AM, Ilpo J=C3=A4rvinen wrote:
> On Mon, 25 Mar 2024, Luke D. Jones wrote:
>=20
> > Support the 2024 mini-led backlight and adjust the related functions
> > to select the relevant dev-id. Also add `available_mini_led_mode` to=
 the
> > platform sysfs since the available mini-led levels can be different.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >  .../ABI/testing/sysfs-platform-asus-wmi       |  8 ++
> >  drivers/platform/x86/asus-wmi.c               | 74 ++++++++++++++++=
+--
> >  include/linux/platform_data/x86/asus-wmi.h    |  1 +
> >  3 files changed, 76 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Doc=
umentation/ABI/testing/sysfs-platform-asus-wmi
> > index 8a7e25bde085..61a745d2476f 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > @@ -126,6 +126,14 @@ Description:
> >  Change the mini-LED mode:
> >  * 0 - Single-zone,
> >  * 1 - Multi-zone
> > + * 2 - Multi-zone strong (available on newer generation mini-led)
> > +
> > +What: /sys/devices/platform/<platform>/available_mini_led_mode
> > +Date: Jun 2023
> > +KernelVersion: 6.10
> > +Contact: "Luke Jones" <luke@ljones.dev>
> > +Description:
> > + List the available mini-led modes.
> > =20
> >  What: /sys/devices/platform/<platform>/ppt_pl1_spl
> >  Date: Jun 2023
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/=
asus-wmi.c
> > index 18be35fdb381..54ce0fb26f42 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -297,6 +297,7 @@ struct asus_wmi {
> > =20
> >  bool panel_overdrive_available;
> >  bool mini_led_mode_available;
> > + u32 mini_led_dev_id;
> > =20
> >  struct hotplug_slot hotplug_slot;
> >  struct mutex hotplug_lock;
> > @@ -2109,10 +2110,27 @@ static ssize_t mini_led_mode_show(struct dev=
ice *dev,
> >  struct asus_wmi *asus =3D dev_get_drvdata(dev);
> >  int result;
> > =20
> > - result =3D asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MINI_=
LED_MODE);
> > - if (result < 0)
> > - return result;
> > + result =3D asus_wmi_get_devstate_simple(asus, asus->mini_led_dev_i=
d);
> > =20
> > + /* Remap the mode values to match previous generation mini-led.
> > + * Some BIOSes return -19 instead of 2, which is "mini-LED off", th=
is
> > + * appears to be a  BIOS bug.
> > + */
> > + if (asus->mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2) {
> > + switch (result) {
> > + case 0:
> > + result =3D 1;
> > + break;
> > + case 1:
> > + result =3D 2;
> > + break;
> > + case 2:
> > + case -19:
>=20
> Can you confirm this -19 really does come from BIOS? Because I suspect=20
> it's -ENODEV error code from from one of the functions on the driver s=
ide
> (which is why I asked you to change it into -ENODEV).

Yes it does. It is rather annoying. What happens in this case is that `2=
` is written to the WMI endpoint to turn off the MINI-Led feature, this =
works fine and it is turned off, there are no errors from the write at a=
ll - verifying the accepted limits in dsdt also shows it is correct.

However, after that, the read fails once. And only if that `2` was writt=
en. `0` and `1` write fine, and read fine also. I hope I've managed to d=
escribe and clarify what I'm seeing here.

I'm happy to change -ENODEV. No problem, queued on my todo list.

Cheers,
Luke.

