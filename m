Return-Path: <linux-kernel+bounces-152771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E1B8AC40B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDF74B22158
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903CC3FB9A;
	Mon, 22 Apr 2024 06:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="AeLgzfaS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Dks0CRfJ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EBD3F9ED;
	Mon, 22 Apr 2024 06:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713766334; cv=none; b=rqHu3bDoqK543QJb3sUHfosU1YjLHGtKwC/T7BgZiBOq4A9+lOiCsDHaWRfohfzeKmd8AAfVTQuVB6myOgqHfnYhI2UxuxjcnUsqgs5PSQfl6ijeDIBkYGwpllblggwBj7iWfVVv6Y+O4LdYeVBxHwfBPVcVTWmStXBfMKjooic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713766334; c=relaxed/simple;
	bh=pGtJ9gIGV7seB/e/mwOpRG7Axiz9HjSbo6N/rMMhZZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsU2j4claP81+adw10a5U8pvOV11A0vwVV2kCrMq4QqpVCKdec0As5oLrj0pAg7N1kO3yo4pJKz55iA4dtN2hukTLN4ZVPFBJiIgrbd2EWHevPEojb+aAkWOpFacrumZ53YJ/sSPMTRq2Vyirc6vA+cSG+v3R3RQZh/q9CcwhH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=AeLgzfaS; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Dks0CRfJ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713766332; x=1745302332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pGtJ9gIGV7seB/e/mwOpRG7Axiz9HjSbo6N/rMMhZZ8=;
  b=AeLgzfaS2+3zSwifqfGk7ocGwzJj1w6AX72IKfO0ukwHzHKQe1wH2JD+
   VEBmpcfClXAhpLxPb29lKiGMqwc6doA9LvaLe/YQ0SIcvyqiHDUaOFZFK
   T/SIWYweNs9eK3jKFo+osyHwcLBroglZBywrypSGpGZGPGX1yaYQB2cW0
   ZAbdrd9ixufBIItoHc9POIUpOqSsti4OovOKAK/kBM9OVy7+6rvIYedmz
   JIymUQE71ttrzCP4PAe9CgGRAXj/QybK2hpVzJBGOFg3i9itY9bBUDPQ3
   CugZ5gjnybMjU9vU/EeVe+Kq3s2KLRA9G7Ixjwvc7yPknhomoRBhhjOwh
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,219,1708383600"; 
   d="scan'208";a="36530830"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 Apr 2024 08:12:03 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22A2E16E19D;
	Mon, 22 Apr 2024 08:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713766319;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pGtJ9gIGV7seB/e/mwOpRG7Axiz9HjSbo6N/rMMhZZ8=;
	b=Dks0CRfJTKw3nkuqdncHwWoHYoWhiwZW80AKiiKVkA2Vjma88IkuyYLHWQ0+orbYBB2r9k
	rbaZ85/RMsQC9kYIz0648p16O73AFzLsTUeboxekEDPSQdmD8F1lYZyhF9igs7I/eYxFgj
	7FoFTCBeYdCaUQesGZmgTSpBT60xey8qPWuZ87wYW1pM7kijwwx6O8oDVUusA9CPqjNfQD
	nPEH1t4TgJGARgL9tZ0XkT+rBt6iKSrRsUTuuFJGkrzMSYLTp1pq4jnPPdmE4I0fiNHwdP
	t/QTSMH/LUv39mvslYF4QvInLHidnVwCUwDvYoSo/cmBe914bc19C53nyO4o0w==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux@ew.tq-group.com, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: tqma8mnql: Add EASRC support
Date: Mon, 22 Apr 2024 08:11:44 +0200
Message-ID: <2731133.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <ZiX4S/H98e/lQXR5@dragon>
References: <20240412132021.520666-1-alexander.stein@ew.tq-group.com> <ZiX4S/H98e/lQXR5@dragon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Shawn,

Am Montag, 22. April 2024, 07:40:27 CEST schrieb Shawn Guo:
> On Fri, Apr 12, 2024 at 03:20:21PM +0200, Alexander Stein wrote:
> > Enable EASRC support in tlv320aic32x4 sound card.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>=20
> Hmm, it doesn't apply to imx/dt64 branch.

Thanks for that information. As you need a dedicated firmware, which is not
included in linux-firmware, I will withhold/drop this patch for now.

Thanks
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



