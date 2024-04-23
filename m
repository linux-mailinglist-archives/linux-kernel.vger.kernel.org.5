Return-Path: <linux-kernel+bounces-154870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3C88AE23A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAAF21F25D06
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12C41C68;
	Tue, 23 Apr 2024 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="APdWQ1Qm"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F423322A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868277; cv=none; b=RQ2S76BUvVYCiFTfoPrjSwJkQNIkTL3vn62eRrcSt/dkfWX+bJjl6e+88h0r7gCtaxsKSMfeTOvjzMpXb08Mxko32FTCMBZ2/hnZCT8c4jlYMkKTU8JDke11TGBIX5s1NSWsLWwyodVMI3a6adhiz4a7CaIk78kP9UOeh6uX2rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868277; c=relaxed/simple;
	bh=PcYcuOSqV46II7BrnvYB4EZcNEFix5aZnqwwbCmOXwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBy83xYIniKoP5wMLauKjDyTqzlFhIFOHMs2LpBrIlZZFl9FQMKCdxO1T2bYvvHoO8O3OSQ5vRh0u09/+ywSZuGb0gwmFIBS/u7eA+oAyVZV5wcltJ7O8JbTj5iyBX3rzkj2h9cZLwREqw9aGc/VDYusMfDJpVNlg2vXS0w8vIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=APdWQ1Qm; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=+BiW
	rOl4aTAOc1VnI1B/z0NAIf4Z3F6xH/jaErmcQ58=; b=APdWQ1QmCzLI1UD1i+o1
	StQ0NgUo36536UILLaH6VOCZ5YMm9TBz7hB1hDN/kNslvngBYWyLkUw1gTY0y/PH
	IAIhyiNJbIIizTdtDr6IKLDJfYD59W99O9MKIpsI4YxXle+KjbwI6ec9+JZkaXLq
	ZaV3DYVvnYckhg7NOM0vJHaUYiMevjieD7duhqSUHLYK6s58PsaNCtOwl5E2H5Bw
	9sLsyjNmRUmkLxAcWXIrbRRauup6GMbWRfNHHdW2YLcQ2e3nSwls8K0xzfFXJ6Gr
	tIF+a1lmUR6QtjDHwwjQ9LITEC8pECzzzM1ODhJ+VMHvVbD2OhoH9QSChYAOp7li
	jA==
Received: (qmail 185780 invoked from network); 23 Apr 2024 12:31:05 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Apr 2024 12:31:05 +0200
X-UD-Smtp-Session: l3s3148p1@oJsfDcEWcLIgAwDPXxiyACzheF6dGXh7
Date: Tue, 23 Apr 2024 12:31:04 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: info@sang-engineering.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC] staging: ks7010: How to proceed with Spectec SDW-823
 microSD driver
Message-ID: <igi27iwrzg3ovgj3sym4gsi45timpkt4vkl5ss5dbftdzat6p4@ctxcjocvunpt>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Philipp Hortmann <philipp.g.hortmann@gmail.com>, info@sang-engineering.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <f82fffbf-a983-4ab4-897b-b5a810426f04@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zuedaelil5upwm7o"
Content-Disposition: inline
In-Reply-To: <f82fffbf-a983-4ab4-897b-b5a810426f04@gmail.com>


--zuedaelil5upwm7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Philipp,

> In the first commit description you stated that you have not been able to
> connect to a WPA-protected network. Did you manage to connect to a
> WPA-protected network at a later time? Have you done any tests with this
> hardware in the years up to today?

I was about to say I never connected to a WPA-network, but my
documentation says I actually did. Good documentation :)

https://elinux.org/Tests:SDIO-KS7010

About testing, when the first set of staging-cleanup patches came in, I
actually tested them. But after some weeks, I stopped doing that because
the amount of patches was just too high and the developers mostly too
inexperienced to understand potential side-effects of their changes. I
didn't have the bandwidth to educate them.

> I am asking because I tried to find a test device to test it. That is
> difficult in 2024.

I still have one or two cards. You could have one if you want. That
doesn't change the whole situation, of course.

> Do you think the driver can be removed or should it stay in the mainline
> kernel?

Frankly, I think it can be removed. When I upstreamed the code, it
served two purposes:

a) I needed to test SDIO communication on my back then recent boards.
   That worked, but I have other hardware now with SDIO on board.

b) there were different versions of KS7010 drivers floating on the net.
   I combined them into one and made sure it was easy to compile with
   upstream Linux. We have that definitive version in the history now.

As both purposes are fulfilled, I don't think we need to maintain this
code anymore. I couldn't imagine someone wants to convert it from WEXT
to cfg80211/nl80211 which would be needed for mainline.

Thanks and happy hacking,

   Wolfram


--zuedaelil5upwm7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYnjeQACgkQFA3kzBSg
KbZqEg//b63DJYhIsukBE1hpx7vPMe9PZomTCos6N8WctT24S9r8A30eR+NPb/0R
kb7LjDriwOhYYxWFmSBrxChVTCfaYOZPV8i9WI/DixoaNUPNWlTl45omNmbDyFUb
SlYAHqyXXxyKcUQbDR6hhJ1Apnd5NfFKBZRKIRECr3xH7KHZsdPfkPnGiVYnevmO
kzIzbCSze3SK3josSpSceIIpfUSNYRNltM8sjEGLTCRrqLRP2CYND/GqgdKc757m
4GFh2LamzEbAktFae2Ko1I9kPF5LyTqBaHphoDoG6o50HNJhSmncuvrqQFSA0nDN
nR1opXSy2y1S/+GUwVRZxdiMvrtkDpDQrBC3ij3jfG4i2OtUvxHTJ7BXTzBN6IBs
5aIExGNlrKCM6ic9eb6QMrQMAl4lE2Wv0w4BvwGBuKn7ZrLVHPxwoecTE47bYhkV
+QmOR60Vtmi1hDnun8akSWKy/v2NCLMqbf3fzqtLeApawXIdZYuZD7PqO2hnW1ri
TvoV52G+Uk1swU1I5jpo/3W4mxt4qte8P7/e1bthQ6dDcisGTsZT9mI0mQRUM8qU
+vkj0tMxYJ7347aN1TSxzfZYsec/mq45XAmZ40rAekZatZx7LhXtzHgFKwRIb3sk
EQBNOt422HKtrhuBFMN79fGaYmKBTkMchO6BmqVkBtAQ6Ug+rPM=
=YzvD
-----END PGP SIGNATURE-----

--zuedaelil5upwm7o--

