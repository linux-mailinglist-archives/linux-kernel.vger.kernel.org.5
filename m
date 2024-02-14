Return-Path: <linux-kernel+bounces-64965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0925E85453A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2AD1C22010
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0A616436;
	Wed, 14 Feb 2024 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gePLS812"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613CC14AA1;
	Wed, 14 Feb 2024 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902969; cv=none; b=O3PmMVfW5yF0WH6VHXrCTHPwkcGrx/WMATPrhhvYVQalwkXEJr+bu2BLByWHnepsAA51FMdf7d5miBmrLGqtuMQ8rC7iw9CEMbFoo4tT+6axINzzYjtCSvldZAUgllO+VpaabTPyTZVDDt4Pv7hwc1Uqh7Nfnd5crJ9VSH46dWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902969; c=relaxed/simple;
	bh=0XiNv1KotziqYARAAWkFR/MQpfouLSDecrGXQaDA/QI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k7ravIiNkblBZDSkadRJyw1eRvwk8ar/Ajy3vIpEhPp4XKzcNmnn6YxM6GVwPNa60XO7hV3cOASJupTMe4XIpCVhWaBcEej8QHEJs79bGxgqh511nrdvS37t8w6eLk4oXWb5l6iUkIQBTxZOpBcv2MUI2FW0NaPNEv2+sgu+twQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gePLS812; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DMsNNekkWJ/JjHoe0kWlBpHaMMDBXiGlZ3fjhE/cR8Q=;
	t=1707902966; x=1709112566; b=gePLS812Z0KxvSLnzPSdX4U6mkZN1coznXNxRFqQhZfGntw
	+EkSRn6b0DkNSv5ZJ6tiJBhX+JcPZYM+uafUUG7R4Oe3Lh4hWeHscOrASqYeEBgpBm7fITLM+z1f3
	1LxgcD/RYqb72N/zha3lAwpiYI3ADQMtTPSCnX6YKbdTeHCUGYhT8GFQQKDawcbUoRbrvvI+M2LwS
	M2a6zbLCOXnXjlnWvASri3/5O3GmNmCMRKQ0KejHvBzUiN+ZmsekJ2YSZ71KYrSDybrf/d4DJgEYo
	u1DvP+RHoE6780HdeYb+wr+RmmU7i0MxDUgkqHZTa2i2NwM9PiQosAzS9pGwGS7g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1raBZr-00000008zts-30gi;
	Wed, 14 Feb 2024 10:29:15 +0100
Message-ID: <e9501c13be127b8b9d0c769a27d8d38636875f0f.camel@sipsolutions.net>
Subject: Re: drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42:
 sparse: sparse: incorrect type in assignment (different base types)
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexis =?ISO-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>, Kalle
	Valo <kvalo@kernel.org>, kernel test robot <lkp@intel.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Wed, 14 Feb 2024 10:29:14 +0100
In-Reply-To: <09eeb7d4-c922-45ee-a1ac-59942153dbce@bootlin.com>
References: <202308290615.lUTIgqUl-lkp@intel.com>
	 <877cpev0pn.fsf@kernel.org> <87a5uatfl1.fsf@kernel.org>
	 <09eeb7d4-c922-45ee-a1ac-59942153dbce@bootlin.com>
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

Hi,

> > For reference here's the old discussion:
> >=20
> > https://patchwork.kernel.org/project/linux-wireless/patch/2022072016030=
2.231516-1-ajay.kathat@microchip.com/
> >=20
> > Any volunteers to help fix this? I would prefers fixes for issues like
> > this compared to questionable random cleanups we always get.
>=20
> I'm bumping this old thread because it looks like the sparse warning is s=
till
> present in WILC driver, and I would gladly help getting rid of it, but si=
nce
> there's already been a fair amount of discussions around it, I am not sur=
e what
> is expected/what should be done. Here is my understanding so far:
> - Ajay has proposed a patch ([1]) which indeed fixes the warning but invo=
lves
> many casts
> - Johannes and Jouni then gave details about the original issue leading t=
o those
> casts ([2]): wpa_supplicant somehow forces the AKM suites values to be be=
32 at
> some point, while it should be treated in host endianness
> - as pointed by Ajay, the corresponding fix has been made since then by J=
ouni in
> wpa_supplicant ([3]). The fix make sure to handle key_mgmt_suite in host
> endianness AND to keep compatibility with current drivers having the be32=
 fix. -

Am I confused, or is the change [3] in the other direction?

From what I see, the code there (now changed again, btw) is about
reading the value *from the driver*.

The driver change is about getting the value *from the supplicant*.

And the _outgoing_ code (sending it to the driver) from the supplicant
has - as far as I can tell - been putting it into the attribute in host
byte order forever? See commit cfaab58007b4 ("nl80211: Connect API
support").


Aha! So, I'm not _completely_ confused, however, the only use of this
value in this driver is sending it back to the supplicant! Which seems
entirely wrong, since the supplicant assumes basically anything will be
handled?

(But - the firmware also has a parameter key_mgmt_suites [in struct
wilc_external_auth_param] which is never even set in
wilc_set_external_auth_param??)


Also note that the supplicant will *only* read RSN_AUTH_KEY_MGMT_SAE in
big endian, so you've already lost here pretty much?

>  - It could have allowed to simply get rid of the all casts on AKM suites=
 in
> wilc driver ([4]), but then new kernel/drivers would break with existing
> userspace, so it is not an option

I am wondering if it works at all ...

> Now, I see multiple options to fix the sparse warning:
> - apply the same fix as for wpa_supplicant ([3]) in wilc driver (so basic=
ally,
> become compatible with both endianness)

But this cannot be done! On input to the driver, the value is in host
byte order always. The question is on output - and there you cannot
detect it.

> - apply the same fix as for wpa_supplicant ([3]), not in wilc but in nl80=
211
> (may need to update not only wilc but any driver having trailing be32 cas=
t on
> AKM suites)

That might even work? Well, not the same fix, since again input vs.
output, but something like this:

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -20136,9 +20136,27 @@ int cfg80211_external_auth_request(struct net_devi=
ce *dev,
 	if (!hdr)
 		goto nla_put_failure;
=20
+	/*
+	 * Some drivers and due to that userspace (wpa_supplicant) were
+	 * in the past interpreting this value as a big-endian value,
+	 * at a time where only WLAN_AKM_SUITE_SAE was used. This is now
+	 * fixed, but for the benefit of older wpa_supplicant versions,
+	 * send this particular value in big-endian. Note that newer
+	 * wpa_supplicant will also detect this particular value in big
+	 * endian still, so it all continues to work.
+	 */
+	if (params->key_mgmt_suite =3D=3D WLAN_AKM_SUITE_SAE) {
+		if (nla_put_be32(msg, NL80211_ATTR_AKM_SUITES,
+				 cpu_to_be32(WLAN_AKM_SUITE_SAE))
+			goto nla_put_failure;
+	} else {
+		if (nla_put_u32(msg, NL80211_ATTR_AKM_SUITES,
+				params->key_mgmt_suite)))
+			goto nla_put_failure;
+	}
+
 	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
 	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
-	    nla_put_u32(msg, NL80211_ATTR_AKM_SUITES, params->key_mgmt_suite) ||
 	    nla_put_u32(msg, NL80211_ATTR_EXTERNAL_AUTH_ACTION,
 			params->action) ||
 	    nla_put(msg, NL80211_ATTR_BSSID, ETH_ALEN, params->bssid)
||


> - take the initial quick but not-so-nice double cast fix and call it a da=
y

but that doesn't actually work for anything other than
WLAN_AKM_SUITE_SAE...

johannes

