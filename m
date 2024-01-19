Return-Path: <linux-kernel+bounces-30830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 983E58324C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC2228379F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876846FA9;
	Fri, 19 Jan 2024 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="O7qv4Ew5"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ECE3C17;
	Fri, 19 Jan 2024 06:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705647356; cv=none; b=A2Q7BpbwodUO3fJPxSLzcWNf/IQQetk9jkTbxjXn9hdfQAEuccaOLkXRFlGbSnjMdIPSlNo4dM5G1Z++dVP4OBuTir6vufDvhW224930jZ/R2kQGhsK7/3HDZXsIAy9uUIkDPRzFJte3N7pUBVlRtkS4LAI52qtDBV68CPgEKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705647356; c=relaxed/simple;
	bh=EzdJOK/zJZATzSg79oEE1SrvYSP+J0rhqwg1XzobUgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXyc5jB/crTlcSOp/L3taLLrTNy8OHAi8Siriv5N7NQ4i7SHrA4y/M1pw09oCJlZvX+hA4N2T8dPa2MVd6tyHxQYBaLu+8RuJCUpzfuFVg1oCggCETKTH/+hRz7xQ7mhJyDlUhDRQJS/VZhEFeoGI1tHzIrBW8bA7Ggq7RNF1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=O7qv4Ew5; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 995539400107;
	Fri, 19 Jan 2024 07:55:52 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id NI2KU7HkxeRZ; Fri, 19 Jan 2024 07:55:52 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 681EF940010D;
	Fri, 19 Jan 2024 07:55:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 681EF940010D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1705647352; bh=1bp2JHVqKgh6eV2IyrM4+ZNotlv2F+x5CxIeVH2IOsE=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=O7qv4Ew521oxlL4dPIzgD2fJ00EIUXUZpOtTBtAwgLrp90Wv972QV3KCnR3rZKOdq
	 M6XA/Z5GJ3Q8q/8uFVie/VDg1hAIRwYKyzaTRvWzBzRssFygL4hXCoVAwlDC0TxlNW
	 9+NHqfQwQzYZBiz4bg/P/YC85LJhHIWWCfjy5n2ICtHpojlx6SAyPM+gUFUx8ipSjB
	 aHckHevMEhlWL+NjLAmsj1DkniwZ+pE/6NyhTFZfyCSBkHIz5w7O/dEcJIEMx8H2fd
	 s66N1lDndC2c9LlbedgBwiaPUFWJyHP45OUeiuq1nP667wxdwrssou0h4UVZw9Y/+L
	 Jt59zDeihlG4g==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 71MDglRghmsS; Fri, 19 Jan 2024 07:55:52 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 0C5879400107;
	Fri, 19 Jan 2024 07:55:52 +0100 (CET)
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
Subject: [RFC net-next v2 1/2] net: phy: phy_device Prevent nullptr exceptions on ISR
Date: Fri, 19 Jan 2024 07:51:13 +0100
Message-ID: <20240119065542.30279-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If phydev->irq is set unconditionally by MAC drivers, check
for valid interrupt handler or fall back to polling mode to prevent
nullptr exceptions.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---

It was exact the way described by Heiner Kallweit. The Kernel Oops
looked as follows:

[  +0.004455] smsc95xx v2.0.0
[  +0.578343] ADIN1100 usb-001:007:00: attached PHY driver (mii_bus:phy_a=
ddr=3Dusb-001:007:00, irq=3D149)
[  +0.000526] smsc95xx 1-4:1.0 eth0: register 'smsc95xx' at usb-0000:00:1=
4.0-4, smsc95xx USB 2.0 Ethernet, 44:d5:f2:a0:4d:bc
[  +0.027107] smsc95xx 1-4:1.0 enp0s20f0u4: renamed from eth0
[  +0.073992] smsc95xx 1-4:1.0 enp0s20f0u4: Link is Down
[  +9.559260] BUG: kernel NULL pointer dereference, address: 000000000000=
0000
[  +0.000020] #PF: supervisor instruction fetch in kernel mode
[  +0.000008] #PF: error_code(0x0010) - not-present page
[  +0.000009] PGD 0 P4D 0
[  +0.000011] Oops: 0010 [#1] PREEMPT SMP NOPTI
[  +0.000013] CPU: 4 PID: 2073 Comm: irq/149-usb-001 Tainted: G          =
 OE      6.5.5-arch1-1 #1 d82a0f532dd8cfe67d5795c1738d9c01059a0c62
[  +0.000014] Hardware name: LENOVO 20RD001CGE/20RD001CGE, BIOS R16ET29W =
(1.15 ) 12/03/2020
[  +0.000006] RIP: 0010:0x0
[  +0.000100] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  +0.000007] RSP: 0018:ffffb3b8c35b3e58 EFLAGS: 00010246
[  +0.000011] RAX: 0000000000000000 RBX: ffff8e5a84d10800 RCX: 0000000000=
000002
[  +0.000007] RDX: ffff8e5aeba52100 RSI: ffff8e5a84d10800 RDI: ffff8e5a84=
d10800
[  +0.000007] RBP: ffff8e5a84d10d48 R08: 0000000000000000 R09: 0000000000=
000000
[  +0.000007] R10: 0000000000000001 R11: 0000000000000100 R12: ffffffffc2=
2720a0
[  +0.000007] R13: ffff8e5a8a0a0c80 R14: ffffffff983505e0 R15: ffff8e5aed=
177940
[  +0.000006] FS:  0000000000000000(0000) GS:ffff8e5dd1500000(0000) knlGS=
:0000000000000000
[  +0.000009] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000007] CR2: ffffffffffffffd6 CR3: 000000025b020004 CR4: 0000000000=
3706e0
[  +0.000007] Call Trace:
[  +0.000006]  <TASK>
[  +0.000008]  ? __die+0x23/0x70
[  +0.000018]  ? page_fault_oops+0x171/0x4e0
[  +0.000017]  ? sched_clock+0x10/0x30
[  +0.000010]  ? sched_clock_cpu+0xf/0x190
[  +0.000015]  ? exc_page_fault+0x7f/0x180
[  +0.000018]  ? asm_exc_page_fault+0x26/0x30
[  +0.000014]  ? __pfx_irq_thread_fn+0x10/0x10
[  +0.000031]  phy_interrupt+0xac/0xf0 [libphy 6d44c9178d1bba7d6a381c1347=
a9242562ba5983]
[  +0.000097]  irq_thread_fn+0x20/0x60
[  +0.000014]  irq_thread+0xfb/0x1c0
[  +0.000012]  ? __pfx_irq_thread_dtor+0x10/0x10
[  +0.000013]  ? __pfx_irq_thread+0x10/0x10
[  +0.000011]  kthread+0xe5/0x120
[  +0.000013]  ? __pfx_kthread+0x10/0x10
[  +0.000012]  ret_from_fork+0x31/0x50
[  +0.000010]  ? __pfx_kthread+0x10/0x10
[  +0.000011]  ret_from_fork_asm+0x1b/0x30
[  +0.000022]  </TASK>
[  +0.000005] Modules linked in: adin1100 smsc95xx selftests usbnet [..]
[  +0.000082] CR2: 0000000000000000
[  +0.000007] ---[ end trace 0000000000000000 ]---

v2:
- Added the workaround to phy_attach_direct as discussed in first patch
  submission.
  TODO: Make phy_device->irq private and add access function that proves
  availability of interrupt handler in phy driver.

---
 drivers/net/phy/phy_device.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3611ea64875e..3986e103d25e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1413,6 +1413,11 @@ int phy_sfp_probe(struct phy_device *phydev,
 }
 EXPORT_SYMBOL(phy_sfp_probe);
=20
+static bool phy_drv_supports_irq(struct phy_driver *phydrv)
+{
+	return phydrv->config_intr && phydrv->handle_interrupt;
+}
+
 /**
  * phy_attach_direct - attach a network device to a given PHY device poi=
nter
  * @dev: network device to attach
@@ -1527,6 +1532,18 @@ int phy_attach_direct(struct net_device *dev, stru=
ct phy_device *phydev,
 	if (phydev->dev_flags & PHY_F_NO_IRQ)
 		phydev->irq =3D PHY_POLL;
=20
+	/*
+	 * Some drivers may add IRQ numbers unconditionally to a phy device tha=
t does
+	 * not implement an interrupt handler after phy_probe is already done.
+	 * Reset to PHY_POLL to prevent nullptr exceptions in that case.
+	 */
+	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev=
)) {
+		phydev_warn(phydev,
+			    "No handler for IRQ=3D%d available. Falling back to polling mode\=
n",
+			    phydev->irq);
+		phydev->irq =3D PHY_POLL;
+	}
+
 	/* Port is set to PORT_TP by default and the actual PHY driver will set
 	 * it to different value depending on the PHY configuration. If we have
 	 * the generic PHY driver we can't figure it out, thus set the old
@@ -2992,11 +3009,6 @@ s32 phy_get_internal_delay(struct phy_device *phyd=
ev, struct device *dev,
 }
 EXPORT_SYMBOL(phy_get_internal_delay);
=20
-static bool phy_drv_supports_irq(struct phy_driver *phydrv)
-{
-	return phydrv->config_intr && phydrv->handle_interrupt;
-}
-
 static int phy_led_set_brightness(struct led_classdev *led_cdev,
 				  enum led_brightness value)
 {
--=20
2.43.0


