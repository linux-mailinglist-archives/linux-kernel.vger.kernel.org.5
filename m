Return-Path: <linux-kernel+bounces-34049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 213A883728F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1178B227BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F9940C1E;
	Mon, 22 Jan 2024 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="I1iZon7X"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB3405EC;
	Mon, 22 Jan 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951461; cv=none; b=ZfjI4RGWfcSkVs2ByDGfRzJXmB5Opd3CgGdFFt/XHtoFludp9PPHi4weJmvPVGH7xN5W2BfxHCtuNm0XslPjR+asYScD8NKW0DSPr9i0gr6cgsBqThqmecNPxcZLjTnHsUwMHiOlBTTczTr1l28VRLbJIvqAOeR0kqmnuV2eybQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951461; c=relaxed/simple;
	bh=Lgn/MXuIjRnOzJxKkgXVhM9eDsr6eamWFql+Ayt6Ysc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NEc/o7C8GcuSz7CJQsgOx/AMZTB3eQ3iMHZgAPIfi5GXq3EwYKeg7Gsdi/aciwUY1tkEVqx8tU8ZUAa0BnNnSuBQwEUS5UCbvWfjpqDYSTXuFwag4cAd2iC7S7gMiSrYrSmtNSQV55GxYU7J0F3VOISHMrDllKbQITT9eCNSEAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=I1iZon7X; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 3FE499400107;
	Mon, 22 Jan 2024 20:24:16 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id JEl9PL90j9wg; Mon, 22 Jan 2024 20:24:16 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 14B9D9401683;
	Mon, 22 Jan 2024 20:24:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 14B9D9401683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1705951456; bh=BTpD3ri/kp+9GXI4Ho471yIWvsi+FB9vUd2lUCI+AaY=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=I1iZon7XtJnxNly0mB0Sdl/Uxo2WYoxtccpmXwuagSSCc3A3lJX+9EaQqf6qnfE4s
	 EvQKtfbAVs1Csngrsq/vvFc+5F7hNvZnZ5rQ36KaonBidyb10fe2JgnrVX1l7ZqyPZ
	 J6KJm9lqVwBn+ufNjaQRImGi2Gsj7LxtQxctxYQmPRIuPbSDqxbq4pZso6BDM1elIK
	 U3akAkwarAeT/h7i1KiIoSm/Ng1FkuTgvDgylva2hUSr5at02kI0QIg8pJ/XQFVKVx
	 LV99kR7VHY9YkZ5RiJMnIXpvjOIsKYFY+pKt2Qe+hAD16f6jY+Ye9abEVU225nk0fg
	 bmIyAEGq++csg==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id OjDNvI_ozQCU; Mon, 22 Jan 2024 20:24:15 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id B28039400107;
	Mon, 22 Jan 2024 20:24:15 +0100 (CET)
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
Subject: [RFC net-next v5 0/2] Prevent nullptr exceptions in ISR
Date: Mon, 22 Jan 2024 20:17:14 +0100
Message-ID: <20240122192401.26836-1-andre.werner@systec-electronic.com>
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


