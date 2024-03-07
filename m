Return-Path: <linux-kernel+bounces-95406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6783E874D41
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082EEB218FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F77128836;
	Thu,  7 Mar 2024 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="GMAzmmP3"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BAA839E3;
	Thu,  7 Mar 2024 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810395; cv=none; b=HRGnPid+o57ThiFR88Dwh4XEwDBp1ojHA2fZniJmxMkN+D7ouqbwHhYDsV4JPdHZ5l3vlwU3A3UqdeHldxB7+kGdHsRpg/QFiBIBhopfewOsi4nkq8RZI1ZptDG58fQ+rE1h5hzfChOoL1RgDDjIePBRnBd23TlZ6XDWjNLCgw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810395; c=relaxed/simple;
	bh=QbV5WjqAjW2pbLLQ+buUKTQxRQ8ErN6ci83Pq7iTb6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qBw0QFBfwQluBiY3d9Ftz6lJb1DbK+UNzEQ7ypZvQom5wUv2IkQPuviyQkjyKRT1X9Q/qCUpp++IiuKXcJIstTSF3pAsEWJlyWpeDVzL6QdE2mXz1IgnA8Z2FxnkC5zDtYx2K32hevkG/Azt/4Fbf5vE/OBMRVv9vSNCgPCHZ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=GMAzmmP3; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 037A29C498B;
	Thu,  7 Mar 2024 06:19:51 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 2WSTG1iEmFg8; Thu,  7 Mar 2024 06:19:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4DCE59C4AC5;
	Thu,  7 Mar 2024 06:19:50 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 4DCE59C4AC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1709810390; bh=ZL5kJeBt2AJwIW7XKBPvdhgd1Q+WZ+LRmadNaYy5kfU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=GMAzmmP3afMD5YbbLFlL9s9JzhNRXr8c7HaXOlDrM8JHgqMqEj4ftSJoQAZxFWXet
	 bWFuBntAVjH5QVHvyqpV13M43k0cljoVebk9e/7NXg+lVZZ8iKCXG+5OCAylUjxSOG
	 KmXAf6xR3qKD66FRBPl7SnC7C5cZR540P4faERS6dOmXZKWZYxWLob+MnHWmwI1mp6
	 DSrLRvNlYeWTHf2YX6d9oniTMHJ8aps6yNl8bR8daUA4JxvCvzRWvNVqEAtM4cJKJk
	 MIEX3l0I/TyTrj702sV0jrSjDsAwsPjX9CHhwuTQRKWIsvqhF3U7QvDrYmZ8iOQkO1
	 8q3stLix4j+mg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id g5bDPnKGjSwG; Thu,  7 Mar 2024 06:19:50 -0500 (EST)
Received: from gerard.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id ADD7F9C498B;
	Thu,  7 Mar 2024 06:19:48 -0500 (EST)
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
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v2] net: phy: fix phy_get_internal_delay accessing an empty array
Date: Thu,  7 Mar 2024 12:19:06 +0100
Message-Id: <20240307111906.297749-1-kevin.lhopital@savoirfairelinux.com>
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
Co-developed-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoi=
rfairelinux.com>
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
Signed-off-by: K=C3=A9vin L'h=C3=B4pital <kevin.lhopital@savoirfairelinux=
com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
V1 -> V2: Fixed Signed-off-by tags

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


