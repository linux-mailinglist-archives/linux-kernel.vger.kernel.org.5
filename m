Return-Path: <linux-kernel+bounces-95165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 840CD874A23
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4C81C231C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6702282D8A;
	Thu,  7 Mar 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="TshTFY4x"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622AE82D66;
	Thu,  7 Mar 2024 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801653; cv=none; b=HdRe++Yg5ejhjud9hpwHGawE40NOdVsTLXPwlDIOX3Gy/9wDi8mNtrVBV11ba3GwBEx1HYm+t8w6UYpWPzItz3DsQw4TTsWXuMGq9IjjQLR3ZPtkpK9n4CEuwL7LjX1iHL0/ZvAgMMazM0CYjRUswDGzs8n/15+YII8/AnaZwY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801653; c=relaxed/simple;
	bh=Vflm/mUgHb71U1m7y/LkoSIhEziKpesynel+Ocg/XBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NMTlnM9TFEPajqtee3HPbgoaAWcwsGdjqfY9w7YDCnB0Jf6GIXb+3v+ocvQAHaBKkkDdeKQXUy3G/79IAbJmYwb7VPmZ3hVEP3fpcnEiwHl89gnZYco3NlCa4Yfg0VpdE6GFBx+q9Q29LTtl17yWlFG8OjbXyPxtSGc0SeK50R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=TshTFY4x; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BF10C9C4AE1;
	Thu,  7 Mar 2024 03:54:08 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Iyi10FSpg5bx; Thu,  7 Mar 2024 03:54:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 25E449C4B62;
	Thu,  7 Mar 2024 03:54:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 25E449C4B62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1709801648; bh=6w5627jHRRWHFnARyzrVWPL3eoJu1ml06TuIJyV1DYw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=TshTFY4x89L20J0LvYfje/r2kNZUWqSw9eO91BtRuZTD5/G4MoL9BYCmebW6YAN1p
	 fERPo7SOelMNRasuSSp3KpAhzO4QicYL0ivYosXralCmRmAATsppk/rqNBHcRm1yYE
	 qK2zMhDLJT3vQGuA8rNnfSfPI93bJ50ai+SA8qwv+ok6UiI0KoCie9sSZEDnn7kFmh
	 BuuktQ2jmMk2tSRWLKS/RyFpmrbeV10pEE1vUK+nLQXsdWJ+q+/0xXLpc6cvTsK5t1
	 xCE/I9UzkKmcQTI49OZ3M4s/jRHXADtJg4A8oTJZw5gr93jtBFSzjKtHUsLaDnlyb0
	 BJ368301vOvVA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id sEdh0h4YpgU2; Thu,  7 Mar 2024 03:54:08 -0500 (EST)
Received: from gerard.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A19F69C4AE1;
	Thu,  7 Mar 2024 03:54:06 -0500 (EST)
From: =?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= <kevin.lhopital@savoirfairelinux.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dan Murphy <dmurphy@ti.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= <kevin.lhopital@savoirfairelinux.com>,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH] net: phy: fix phy_get_internal_delay accessing an empty array
Date: Thu,  7 Mar 2024 09:52:54 +0100
Message-Id: <20240307085254.183905-1-kevin.lhopital@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The phy_get_internal_delay function could try to access to an empty
array in the case that the driver is calling phy_get_internal_delay
without defining delay_values and rx-internal-delay-ps or
tx-internal-delay-ps is defined to 0 in the device-tree.
This will lead to "unable to handle kernel NULL pointer dereference at
virtual address 0". To avoid this kernel oops, the test should be delay
>=3D 0. As there is already delay < 0 test just before, the test could
only be size =3D=3D 0.

Fixes: 92252eec913b ("net: phy: Add a helper to return the index for of t=
he internal delay")
Signed-off-by: K=C3=A9vin L'h=C3=B4pital <kevin.lhopital@savoirfairelinux=
com>
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
 drivers/net/phy/phy_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3611ea64875e..3ad9bbf65cbe 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2959,7 +2959,7 @@ s32 phy_get_internal_delay(struct phy_device *phyde=
v, struct device *dev,
 	if (delay < 0)
 		return delay;
=20
-	if (delay && size =3D=3D 0)
+	if (size =3D=3D 0)
 		return delay;
=20
 	if (delay < delay_values[0] || delay > delay_values[size - 1]) {
--=20
2.34.1


