Return-Path: <linux-kernel+bounces-56346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA4784C8FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C401F25E7F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E9117BD6;
	Wed,  7 Feb 2024 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Uv0/hed8"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E4917582;
	Wed,  7 Feb 2024 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303135; cv=none; b=O5YnpmuWjJEpsx6wwioXi0ZVG21h1A0TazBTag7A4WVeyutyr1NzDPLVfiK9clTQ9nVeuPC5zklhWddY8t4Kxdh7q49BtpAJ1oictvOuvnk6GhLVf0ot5RgHbjfGHjRhCk7RTXvaKDAP9r/+Aspoum1q7x6SGHkW8zrQGBBzHJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303135; c=relaxed/simple;
	bh=HTW77sv4gHQlJ35myLHT4fY0jEm6BXDhen5KdxeYT5A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GZy+qkQ/j0qrc/siPrUCQfp9fMjpeJ9HNPJWW+5fmecsWUHK5EIN8ACTRJDYm/OoBRTTZIDX3xC1xT3UN+A7mA/RGwvGw9tT78Fxc8h72BjscNWfnoFGfWLs/YiSel/3I16lIwtMjSgOzMQ3SMuHz3AsVb9ieeS81wAKpPlRr+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Uv0/hed8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xIhBdBuB4+Irj+sDFGwSgr9BNo29FSMxovC23RovWA0=;
	t=1707303133; x=1708512733; b=Uv0/hed8jGA9DYZ0SjjF13vL/sjeJKME3LKjd8JMy8dAUGX
	EF2PIbUTmsXdC1R0KKqIMT6p5DymUFD/n7grIIiMjLnqW4qhhmb2n7HroPxrLRB7EZbVGITQYWYQD
	IMS+OoHEY7ycfi8FtmnY8fCoCBdHicIxxPA8ONzvxq1cu31OkmrRCbc6Uw9Zwi8crw8enZx7R2CQ6
	gNurO1O+kdVaS+gUm4SnrwCsyvU/Nl/Wbmk+2iA0GLXPcqLAm7jImnZZ2v24WrKrbzDeviNr3+528
	fPnbBgQQeCoc72ZlsyoCC6LibyKkKSgRdGYT7JMy2kDQkPXKoDSMKlPcz7N3J2eQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rXfXE-0000000FsHZ-0NYz;
	Wed, 07 Feb 2024 11:52:08 +0100
Message-ID: <cc9b25a584471699375d85f12e24a26098397ad5.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mt76: inititalize sband.band to correct value
From: Johannes Berg <johannes@sipsolutions.net>
To: Bert Karwatzki <spasswolf@web.de>, Lorenzo Bianconi
 <lorenzo@kernel.org>,  Felix Fietkau <nbd@nbd.name>, Ryder Lee
 <ryder.lee@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Wed, 07 Feb 2024 11:52:07 +0100
In-Reply-To: <20240207072253.4189-1-spasswolf@web.de>
References: <20240207072253.4189-1-spasswolf@web.de>
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

On Wed, 2024-02-07 at 08:22 +0100, Bert Karwatzki wrote:
> Set phy->sband_{2,5,6}g.sband.band to the correct enum value, otherwise
> the ieee80211_register_hw() will fail to register the device.

So turns out that technically, it wasn't needed before because cfg80211
*will* set sband->band, but *mac80211* now requires it to have been set
before ...

We could do a trivial fix in mac80211 as well:

--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1124,7 +1124,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			supp_he =3D supp_he || iftd->he_cap.has_he;
 			supp_eht =3D supp_eht || iftd->eht_cap.has_eht;
=20
-			if (sband->band =3D=3D NL80211_BAND_2GHZ)
+			if (band =3D=3D NL80211_BAND_2GHZ)
 				he_40_mhz_cap =3D
 					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
 			else


but seems like no other driver even likely needed this, and it's
probably less reliable in the long term?

Or do both?

johannes


