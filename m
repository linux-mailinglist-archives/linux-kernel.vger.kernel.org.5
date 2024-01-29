Return-Path: <linux-kernel+bounces-42848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4BF8407AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA98A2885BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C9165BD6;
	Mon, 29 Jan 2024 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="mVHx17SK"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3165BBE;
	Mon, 29 Jan 2024 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536664; cv=none; b=TQlYZVbnCz3COIslZAL4UAO+QI/oa/7U2Pvd4nVj90RuTzpBLVtzJzsbRwpCyU4AY1ptk/uo2sSBmlCaxxUEROLgdggItaONqdHrtwFYBeGkpLeYFCNLepKg5blwU81XdOtpUIZNo+Ktj6MXRCkicSTHE9Qnfu8bhHKRcwnFvBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536664; c=relaxed/simple;
	bh=Lgn/MXuIjRnOzJxKkgXVhM9eDsr6eamWFql+Ayt6Ysc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QMXXAaYqJ7JPWqkCrECTAAJ87LYNnrziK2uJ+lLmhMvPXmxdfmq36xz90fFGceCWJyrjnusqOcIwRFJyj/nv/kuVBOY2RA/rOKOgSRXfxB5r08+fgw+jceKm6Eol2/4c/TE41aaTe6c7TolQkNKO/mhvs6ZDjpFbDScj5Fys6WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=mVHx17SK; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id D1378941A5D6;
	Mon, 29 Jan 2024 14:57:39 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id B51Lp-FHcuvy; Mon, 29 Jan 2024 14:57:39 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 9F4FB941A5D5;
	Mon, 29 Jan 2024 14:57:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 9F4FB941A5D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1706536659; bh=BTpD3ri/kp+9GXI4Ho471yIWvsi+FB9vUd2lUCI+AaY=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=mVHx17SK6Gu7c58TEL2lG6YIkazxPddGq6QhKz9qahCHiXlelWjTbTiH6NjJSOqCU
	 PRBrWiybIc0uRJK95XeNBc8V2jP4qxsAW0jX+ENUCevV1yNwfkVHqZBCuSyn30UTSp
	 zx8ciWzwOvCER/qE69SSCqzwtmjRQRRRlFLr1cIF2tChcR8XcAzzi/g1awFiqDdiEu
	 56XhVFT9/26dBW/FE1m6HaGzaKS7bFDVHSHybfXV4IajhGRse+m7ZePFrTxzzoPyYO
	 iyAGjaFBaCQ9pY2gXHzmpZW0x9j7QBlIcTifpJWb+RKbV0DOQEodPm1I8g7dVqc8dr
	 D9B7zlZUK0aWQ==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 6yJ13G-wB26w; Mon, 29 Jan 2024 14:57:39 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 41555941A5CF;
	Mon, 29 Jan 2024 14:57:39 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andre Werner <andre.werner@systec-electronic.com>
Subject: [net-next v5 0/2] Prevent nullptr exceptions in ISR
Date: Mon, 29 Jan 2024 14:55:03 +0100
Message-ID: <20240129135734.18975-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case phydev->irq is modified unconditionally to a valid IRQ, handling
the IRQ may lead to a nullptr exception if no interrupt handler is
registered to the phy driver. phy_interrupt calls a
phy_device->handle_interrupt unconditionally. And interrupts are enabled
in phy_connect_direct if phydev->irq is not equal to PHY_POLL or
PHY_MAC_INTERRUPT, so it does not check for a phy driver providing an ISR=
.

Adding an additonal check for a valid interrupt handler in phy_attach_dir=
ect
function, and falling back to polling mode if not, should prevent for
such nullptr exceptions.

Moreover, the ADIN1100 phy driver is extended with an interrupt handler
for changes in the link status.

Andre Werner (2):
  net: phy: phy_device: Prevent nullptr exceptions on ISR
  net: phy: adin1100: Add interrupt support for link change

 drivers/net/phy/adin1100.c   | 55 ++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c | 13 +++++----
 2 files changed, 63 insertions(+), 5 deletions(-)

--=20
2.43.0


