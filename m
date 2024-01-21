Return-Path: <linux-kernel+bounces-32174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8C78357AD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13BF1C21473
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C5D383BA;
	Sun, 21 Jan 2024 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="H0iOuG3Z"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9253839F;
	Sun, 21 Jan 2024 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705868127; cv=none; b=CnTHLnC1c7sQF8szOdGmn39WoyWeMRI7Lj6Q6/EyE+6lx3CQq2hh7C8WoMkqBBZ5bfUUwVEgjHoxF6p5O8lZVH1CY3gqq6pKc/ZcBdWq0USb3iKFTw8np2bYxnB5XY7Ne55LV40xIfEMvSJE5z1cXM3BfwETQl9sAlrpgS1S7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705868127; c=relaxed/simple;
	bh=rH0PbQBftNfkw5tsbtKA8e404fXcbWu0wSHlI3qpAzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UeSy0EXLqTLRIiZp0+Y8qnwM6OkQQKus1ZXvRsDCFzUBdQ7TQg3X77sb8KMYrHGx6xpCOGvNipov5nN2PAxqGVcyeLoKfPSM1KBBp2fkmeSNYV0CxKH6y9iMv58RhnMVJRwwbNZQwdOPghAE9BLrLh6wXgrPUAS6sYxwblCR2MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=H0iOuG3Z; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id DB1DE940168B;
	Sun, 21 Jan 2024 21:15:15 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id jS0yKLNnfhDq; Sun, 21 Jan 2024 21:15:15 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 05D06941A5CE;
	Sun, 21 Jan 2024 21:15:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 05D06941A5CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1705868115; bh=H94dlLGm07RAcjBuXFK9TZPqcv0CLYgf7F2nSJtNTy4=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=H0iOuG3ZGRGxQWPo4gvsM0Kj9Zz9BGlPkrdoalT9v3GI9I5WwApWxZTCadK3O+J8d
	 MIssKkSz67ga3QS3W+3FLfupkhze1wRdxtKOHFc2EH0hhhpwZ8maVJ2QhaBOeaQsO/
	 gKhBuxnxFLs499EZGQe4xmbejSlp8eEhaqERS9bG16v/6v87pYnSWNfbQ1Brjh8t21
	 LbS1sz/bwtYki0ojprnN+Vu/Bb43wjYIcUbhLPXorCt21qYKkhW0MB8hcAa9NWbMEK
	 BWDH9z5FiC24XzC9YUi6H4eNHGD3xlWGuYMFeD1MITt+aHlifv0ETZdcuhYDKNr5ty
	 jcFBiAGqa3h+Q==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id HOeT28NNFi3R; Sun, 21 Jan 2024 21:15:14 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id A0F0D9400107;
	Sun, 21 Jan 2024 21:15:14 +0100 (CET)
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
Subject: [RFC net-next v4 0/2] Prevent nullptr exceptions in ISR
Date: Sun, 21 Jan 2024 20:54:47 +0100
Message-ID: <20240121201511.8997-1-andre.werner@systec-electronic.com>
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

 drivers/net/phy/adin1100.c   | 56 ++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c | 13 +++++----
 2 files changed, 64 insertions(+), 5 deletions(-)

--=20
2.43.0


