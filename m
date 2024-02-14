Return-Path: <linux-kernel+bounces-65124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB92E854852
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D7728336F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE9B19BCA;
	Wed, 14 Feb 2024 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rGC/EBaz"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20A19472;
	Wed, 14 Feb 2024 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910139; cv=none; b=mU7q6RHQTtlARLtGMJDGTF3RdHCHRjSVhBWFCKL415rqjFHZGhRqQrQLemzpgfqg9++FH3NO6LN56MMkfcE4hw/vx7Avih7kyooGHeInYOfPu3SfeUhfXUqXD8D2w1PUGe3rQA0Zk2tbi4bG2sWF9XgExY82EogDo6hNmiwsG20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910139; c=relaxed/simple;
	bh=ph5MwR4wZUhns+fWbxn5cbHzQnuBV1jwQ2GdCM5AvlQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ryVRuncD+BjV6MMGpwsAyFZE7fCMvOfwBZymgrwdI+55eufiUssclerktZoMUyyoczdm5/eJxq6CWrcqmGkrKRbhKaPBh4GPdm4FAOhIqRpnh/R9b1pb5JX9Wra3i3gYhAqd91DT//+pZGq6RVXl5z3ufHoL44oLmpNIR3gJ/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rGC/EBaz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=46adwVyQv3HB2Wt144F36StIrysfPn+34+VT4eDKrEE=;
	t=1707910136; x=1709119736; b=rGC/EBaz8BZG0wvLMnZhCHRqAJ02HYyBUYDJDrmKfVCGACo
	i7j+vaGTKuESoM5dlbP+Nb6dTRGwcs55Rwhlw0ek2hP0D8/9h9Pt5VcNTshbylXlVBCHYu/z6caTP
	aDPrZ+ikglkbgtZE5GiR4KMFL7VbP2LsjAfv2veg8oh8wyHJXCrBMnUtx7kshW9PaHepwodDgVkmS
	IDxWP8WUe4ddwYQyK4CjMx2bDUTXvcQUe9bS68SLLc3U5b3EKJUPUel/ppAiRDzGIgKz6XnfH723d
	Sf491J85dygnNg9oqbj7JILorPe1IlUHLJiw4T6AiZIG/fMANG3yxLmpT7CVOGHw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1raDRc-000000094BW-22c4;
	Wed, 14 Feb 2024 12:28:52 +0100
Message-ID: <29a2374b9a92e09e247ec9eb3f98e93aef7614c2.camel@sipsolutions.net>
Subject: Re: drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42:
 sparse: sparse: incorrect type in assignment (different base types)
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexis =?ISO-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>, Kalle
	Valo <kvalo@kernel.org>, kernel test robot <lkp@intel.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Wed, 14 Feb 2024 12:28:51 +0100
In-Reply-To: <912f4e56-bd30-48c1-bf24-dd728188b1c5@bootlin.com>
References: <202308290615.lUTIgqUl-lkp@intel.com>
	 <877cpev0pn.fsf@kernel.org> <87a5uatfl1.fsf@kernel.org>
	 <09eeb7d4-c922-45ee-a1ac-59942153dbce@bootlin.com>
	 <e9501c13be127b8b9d0c769a27d8d38636875f0f.camel@sipsolutions.net>
	 <912f4e56-bd30-48c1-bf24-dd728188b1c5@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-02-14 at 12:03 +0100, Alexis Lothor=C3=A9 wrote:
> On 2/14/24 10:29, Johannes Berg wrote:
> > Hi,
> >=20
> > > > For reference here's the old discussion:
> > > >=20
> > > > https://patchwork.kernel.org/project/linux-wireless/patch/202207201=
60302.231516-1-ajay.kathat@microchip.com/
> > > >=20
> > > > Any volunteers to help fix this? I would prefers fixes for issues l=
ike
> > > > this compared to questionable random cleanups we always get.
> > >=20
> > > I'm bumping this old thread because it looks like the sparse warning =
is still
> > > present in WILC driver, and I would gladly help getting rid of it, bu=
t since
> > > there's already been a fair amount of discussions around it, I am not=
 sure what
> > > is expected/what should be done. Here is my understanding so far:
> > > - Ajay has proposed a patch ([1]) which indeed fixes the warning but =
involves
> > > many casts
> > > - Johannes and Jouni then gave details about the original issue leadi=
ng to those
> > > casts ([2]): wpa_supplicant somehow forces the AKM suites values to b=
e be32 at
> > > some point, while it should be treated in host endianness
> > > - as pointed by Ajay, the corresponding fix has been made since then =
by Jouni in
> > > wpa_supplicant ([3]). The fix make sure to handle key_mgmt_suite in h=
ost
> > > endianness AND to keep compatibility with current drivers having the =
be32 fix. -
> >=20
> > Am I confused, or is the change [3] in the other direction?
> >=20
> > From what I see, the code there (now changed again, btw) is about
> > reading the value *from the driver*.
>=20
> Ah, you are right, so [3] is rather about supporting drivers sending valu=
es with
> host endianness, while interface historically expects big endian :/

Well it was kind of documented  originally as host byte order, but
(some) drivers historically did big endian ...

Anyway, same thing - but note it's only doing the big endian check for a
single value.

> > The driver change is about getting the value *from the supplicant*.
> >=20
> > And the _outgoing_ code (sending it to the driver) from the supplicant
> > has - as far as I can tell - been putting it into the attribute in host
> > byte order forever? See commit cfaab58007b4 ("nl80211: Connect API
> > support").
> >=20
> >=20
> > Aha! So, I'm not _completely_ confused,=20
>=20
> So I am the one confused :) Thanks for the clarification. I did not dig e=
nough,
> and since the cast is done right at connect message reception, I assumed =
wrongly
> that the issue was on the supplicant->driver path.

Yeah it's confusing ...

> > however, the only use of this value in this driver is sending it back t=
o the supplicant!
> > Which seems entirely wrong, since the supplicant assumes basically anyt=
hing
> > will be handled?
>=20
> Not sure to fully understand why its wrong (supplicant seems to expect AK=
M
> suites to be provided) , but I may be lacking more general understanding =
about
> the external auth process.

Well the firmware cannot support arbitrary AKM here, I'd think? And
anyway it's not even sent to the firmware at all, so it has to be
assuming it's SAE or so?

> Or do you mean that AKM suites should be enforced to RSN_AUTH_KEY_MGMT_SA=
E only
> in this driver->supplicant call (and so, not forward any possible value ?=
)

Well it's more a question of what the firmware will actually be able to
do here, I'd think. IIUC the whole point of this is to let firmware know
what it's expected to do.

> > Also note that the supplicant will *only* read RSN_AUTH_KEY_MGMT_SAE in
> > big endian, so you've already lost here pretty much?
>=20
> So we have to keep some big endian conversion on the driver/nl80211 ->
> supplicant path, IIUC

If we were to drop support for old wpa_supplicant, then no, we could
just use host byte order everywhere.

As we want to continue supporting old wpa_supplicant, which really just
checked for RSN_AUTH_KEY_MGMT_SAE in big endian (before [3], when it
started checking for both big endian and host byte order), then we have
to send *that particular value* in big endian. For every other value we
have to send it in host byte order, because either it doesn't matter
(old wpa_s) or is checked in host byte order (new wpa_s, after later
patches to this code checking for other values.)

But! That actually also means the driver is wrong now, because it sends
_any_ value back in big endian, when wpa_s - new or old - only checks
for this one value in big endian. It's OK with old since it only checks
for this value in the first place, but broken for new!

> > > - apply the same fix as for wpa_supplicant ([3]), not in wilc but in =
nl80211
> > > (may need to update not only wilc but any driver having trailing be32=
 cast on
> > > AKM suites)
>=20
> So to fix my initial suggestion, it is not "doing the same fix" but rathe=
r "move
> the be conversion from the driver to nl80211 layer". Which matches in fac=
t what
> you are suggesting below.

Well you could do the exact same thing in the driver.

But it's probably cleaner to handle the backward compat issue in nl80211
and let the driver(s) just use host byte order generally, as intended?

> > That might even work? Well, not the same fix, since again input vs.
> > output, but something like this:
> >=20
> > --- a/net/wireless/nl80211.c
> > +++ b/net/wireless/nl80211.c
> > @@ -20136,9 +20136,27 @@ int cfg80211_external_auth_request(struct net_=
device *dev,
> >  	if (!hdr)
> >  		goto nla_put_failure;
> > =20
> > +	/*
> > +	 * Some drivers and due to that userspace (wpa_supplicant) were
> > +	 * in the past interpreting this value as a big-endian value,
> > +	 * at a time where only WLAN_AKM_SUITE_SAE was used. This is now
> > +	 * fixed, but for the benefit of older wpa_supplicant versions,
> > +	 * send this particular value in big-endian. Note that newer
> > +	 * wpa_supplicant will also detect this particular value in big
> > +	 * endian still, so it all continues to work.
> > +	 */
> > +	if (params->key_mgmt_suite =3D=3D WLAN_AKM_SUITE_SAE) {
> > +		if (nla_put_be32(msg, NL80211_ATTR_AKM_SUITES,
> > +				 cpu_to_be32(WLAN_AKM_SUITE_SAE))
> > +			goto nla_put_failure;
> > +	} else {
> > +		if (nla_put_u32(msg, NL80211_ATTR_AKM_SUITES,
> > +				params->key_mgmt_suite)))
> > +			goto nla_put_failure;
> > +	}
> > +
> >  	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
> >  	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
> > -	    nla_put_u32(msg, NL80211_ATTR_AKM_SUITES, params->key_mgmt_suite)=
 ||
> >  	    nla_put_u32(msg, NL80211_ATTR_EXTERNAL_AUTH_ACTION,
> >  			params->action) ||
> >  	    nla_put(msg, NL80211_ATTR_BSSID, ETH_ALEN, params->bssid)
> > > >=20
>=20
> If this kind of fix is ok in nl80211, I can do some tests with it, see ho=
w it
> would affect other drivers ( I think there's only Quantenna driver which =
would
> be affected)

I'm happy with that, sure. Please do check.

Thanks!

johannes

