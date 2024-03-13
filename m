Return-Path: <linux-kernel+bounces-101226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC2B87A444
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1EDBB21431
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F101B5BB;
	Wed, 13 Mar 2024 08:52:21 +0000 (UTC)
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311912E73;
	Wed, 13 Mar 2024 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710319941; cv=none; b=ho1gzQ+Q8wj1jSxBMVrPkOQMo3lRxo9+SnVlNFaFIYXLjzSqUZxHUXzWX25sTof/Xqgn9Np2T2szmn1Kq+FDSCUk1+Ab3JHWjKZe6ILZLZa5+R4SZ7RbYgcIayUKM0w49kwe7BXF+n5xF5FJP4TeFY72Bu7/7ojvaVhi8TtYSmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710319941; c=relaxed/simple;
	bh=+NePArLWJMB57UThWlpn3BKXqneliUUo+Wa39GBb6SQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 In-Reply-To; b=HXQ6SUGto9CJzXQDIifpc0tJNK/1/aqdmypyOYL0oZEQ3srdY5TXDjd2A4QgHcMDeBMPaS2+cofvuxoXo/TOaaOGm3+RAJHj4koN4wyvpkkWL+2Lm6ssjEHHHlRq0VPqgCuuSgO6xiFyKA6hyNMvv0piwY67oNLzx7ujR1g1XqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
Received: from localhost (koleje-wifi-0013.koleje.cuni.cz [78.128.191.13])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42D8neSJ059445
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 09:49:41 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Mar 2024 09:50:11 +0100
Message-Id: <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz>
Cc: <alexandre.torgue@foss.st.com>, <davem@davemloft.net>,
        <dhowells@redhat.com>, <herbert@gondor.apana.org.au>,
        <keyrings@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-modules@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <mcgrof@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [REGRESSION] Re: [PATCH] crypto: pkcs7: remove sha1 support
To: <dimitri.ledkov@canonical.com>,
        "Johannes Berg"
 <johannes@sipsolutions.net>
From: "Karel Balej" <balejk@matfyz.cz>
In-Reply-To: <20231010212240.61637-1-dimitri.ledkov@canonical.com>

Dimitri, Johannes,

ever since upgrading to Linux v6.7 I am unable to connect to a 802.1X
wireless network (specifically, eduroam). In my dmesg, the following
messages appear:

	[   68.161621] wlan0: authenticate with xx:xx:xx:xx:xx:xx (local address=
=3Dxx:xx:xx:xx:xx:xx)
	[   68.163733] wlan0: send auth to xx:xx:xx:xx:xx:xx (try 1/3)
	[   68.165773] wlan0: authenticated
	[   68.166785] wlan0: associate with xx:xx:xx:xx:xx:xx (try 1/3)
	[   68.168498] wlan0: RX AssocResp from xx:xx:xx:xx:xx:xx (capab=3D0x1411 =
status=3D0 aid=3D4)
	[   68.172445] wlan0: associated
	[   68.204956] wlan0: Limiting TX power to 23 (23 - 0) dBm as advertised b=
y xx:xx:xx:xx:xx:xx
	[   70.262032] wlan0: deauthenticated from xx:xx:xx:xx:xx:xx (Reason: 23=
=3DIEEE8021X_FAILED)
	[   73.065966] wlan0: authenticate with xx:xx:xx:xx:xx:xx (local address=
=3Dxx:xx:xx:xx:xx:xx)
	[   73.068006] wlan0: send auth to xx:xx:xx:xx:xx:xx (try 1/3)
	[   73.070166] wlan0: authenticated
	[   73.070756] wlan0: associate with xx:xx:xx:xx:xx:xx (try 1/3)
	[   73.072807] wlan0: RX AssocResp from xx:xx:xx:xx:xx:xx (capab=3D0x1411 =
status=3D0 aid=3D4)
	[   73.076676] wlan0: associated
	[   73.120396] wlan0: Limiting TX power to 23 (23 - 0) dBm as advertised b=
y xx:xx:xx:xx:xx:xx
	[   75.148376] wlan0: deauthenticating from xx:xx:xx:xx:xx:xx by local cho=
ice (Reason: 23=3DIEEE8021X_FAILED)
	[   77.718016] wlan0: authenticate with xx:xx:xx:xx:xx:xx (local address=
=3Dxx:xx:xx:xx:xx:xx)
	[   77.720137] wlan0: send auth to xx:xx:xx:xx:xx:xx (try 1/3)
	[   77.722670] wlan0: authenticated
	[   77.724737] wlan0: associate with xx:xx:xx:xx:xx:xx (try 1/3)
	[   77.726172] wlan0: RX AssocResp from xx:xx:xx:xx:xx:xx (capab=3D0x1411 =
status=3D0 aid=3D4)
	[   77.730822] wlan0: associated
	[   77.830763] wlan0: Limiting TX power to 23 (23 - 0) dBm as advertised b=
y xx:xx:xx:xx:xx:xx
	[   79.784199] wlan0: deauthenticating from xx:xx:xx:xx:xx:xx by local cho=
ice (Reason: 23=3DIEEE8021X_FAILED)

The connection works fine with v6.6 and I have bisected the problem to
the revision introduced by this patch (16ab7cb5825f mainline).

My wireless kernel driver is iwlwifi and I use iwd. I started the bisect
with a config copied from my distribution package [1].

Would you please help me with this? Please let me know if I forgot to
mention something which could be helpful in resolving this.

[1] https://raw.githubusercontent.com/void-linux/void-packages/master/srcpk=
gs/linux6.6/files/x86_64-dotconfig

Thank you very much, kind regards,
K. B.

