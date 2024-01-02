Return-Path: <linux-kernel+bounces-14271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8E0821A9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B49E1C21A08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931CBDDC7;
	Tue,  2 Jan 2024 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="BocdAxcO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bIr9du0k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C4DDA6;
	Tue,  2 Jan 2024 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 4380C5C01B0;
	Tue,  2 Jan 2024 06:01:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 02 Jan 2024 06:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1704193316; x=1704279716; bh=ClsJU6F+GN
	ksCC5vz1p80RASe2HA56v4MNN8n0S25W0=; b=BocdAxcO6RbdX0By3niK+IwKWy
	JUaQDNhRPKOA3Bt4fnKbt+oXiW/EwJt1jUNDCW9pSZiYt/djv9dbJBWJFqLE5khD
	lDcPb4ZK728wmhAzUV5yIAoHOsc4YeYnY5mE5wAuA+Nw6M6xNg1CV/BabEFxlDng
	ri0cJIHQLDtY7DjwjyDIn16jnYDqWf0efMFCvDowdeQT0Hyxl65WKnhX7j4yagfG
	9Tc9H/02FkPZSQg7TIniVrXAtHx0l/XddVlQ2BFxD1+i6uCKWUn+5QiLySJZMN6n
	y2KVKA+1bFDQIIA7u1aIL6rXWoH56+vKEotD0dx1sTzV3u/yQzMMG7NFocKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704193316; x=1704279716; bh=ClsJU6F+GNksCC5vz1p80RASe2HA
	56v4MNN8n0S25W0=; b=bIr9du0kRzaXU08/SYCd/I+ppMoNRkecwXNvFGevy9w6
	zcifWzodcTXBsYVaqmWQ2JoigR1T/BNe99WXATI69AzFT3hT4Tcfi1yoZAu8GmwR
	qnLgRJV/6IYTDFGOPk16KiZ5eILRpjOqU4BKLkNqxON2mHVzoFHGuObG0rZaQu9B
	iKOiXOuwkHZlCqSyF2cWZKvEisCWTYDNQ5eTP/xHHMvdsJeBOVHs2DhYkTNI0vku
	NKoT5r++RFXYT6aKAxGjXUMuh7vvY9nhhLCFz89fKgSZ6qpCI3CAAIvL9FcBM8uy
	M/7IONBY3zuN4wekbOSFKAwyUGa7LL74bU0neSt0nQ==
X-ME-Sender: <xms:JO2TZR0L1foW2F5_jA6etfOs9gzmyosxxXbB4xd9ozoqIPgOhAExVw>
    <xme:JO2TZYHlY-FpsFJb2dVgOiUUbePjNs726Ao0QfJJF4EjffuQcOrfQ017rXz_EC6Rw
    5WJLO9m8z0m-_CR-Fc>
X-ME-Received: <xmr:JO2TZR72BiAuFvg49ZrWdaTdV4rlyiXe1sy2f9egyzEJpE0tXZKuXr8-LOt6_VhISIFfRGhnPGOngnGbkx8fKSW9zsbeKYFmxF2QRfXSwSj-0Zs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhephffvvefufffkofgggfes
    tdekredtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqth
    grkhgrshhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepgeei
    tdetvddtfeeuhffgfeffveefgfevtdduveevieettefgueeivdetvedugfeinecuffhomh
    grihhnpehsuhhsvgdrtghomhdpkhgvrhhnvghlrdhorhhgpdhsohhurhgtvghfohhrghgv
    rdhnvghtpdhrvgguhhgrthdrtghomhdplhgruhhntghhphgrugdrnhgvthenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:JO2TZe0qoRB1Hg2pjAs_J0bRMXZo951lSmDGPt4GvehLNTF_4HbEgw>
    <xmx:JO2TZUH57zX7m4NF1kCGn2a-5aLhALqUbE_IgNf4vXAC0DH9PnsQfg>
    <xmx:JO2TZf8i8DfeIj1sL63G3Az3f7L6uEkJjEBAqtOmXzEjr5QYfZF1Gg>
    <xmx:JO2TZZM4KVe8iPFoVveMXVPhJEJaPlfh-sZdK0W0FfWAFoOYPdK_KA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jan 2024 06:01:54 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com,
	stable@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Tobias Gruetzmacher <tobias-lists@23.gs>
Subject: [PATCH v2] firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards
Date: Tue,  2 Jan 2024 20:01:50 +0900
Message-Id: <20240102110150.244475-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VIA VT6306/6307/6308 provides PCI interface compliant to 1394 OHCI. When
the hardware is combined with Asmedia ASM1083/1085 PCIe-to-PCI bus bridge,
it appears that accesses to its 'Isochronous Cycle Timer' register (offset
0xf0 on PCI I/O space) often causes unexpected system reboot in any type
of AMD Ryzen machine (both 0x17 and 0x19 families). It does not appears in
the other type of machine (AMD pre-Ryzen machine, Intel machine, at least),
or in the other OHCI 1394 hardware (e.g. Texas Instruments).

The issue explicitly appears at a commit dcadfd7f7c74 ("firewire: core:
use union for callback of transaction completion") added to v6.5 kernel.
It changed 1394 OHCI driver to access to the register every time to
dispatch local asynchronous transaction. However, the issue exists in
older version of kernel as long as it runs in AMD Ryzen machine, since
the access to the register is required to maintain bus time. It is not
hard to imagine that users experience the unexpected system reboot when
generating bus reset by plugging any devices in, or reading the register
by time-aware application programs; e.g. audio sample processing.

This commit suppresses the unexpected system reboot in the combination of
hardware. It avoids the access itself. As a result, the software stack can
not provide the hardware time anymore to unit drivers, userspace
applications, and nodes in the same IEEE 1394 bus. It brings apparent
disadvantage since time-aware application programs require it, while
time-unaware applications are available again; e.g. sbp2.

Cc: stable@vger.kernel.org
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1215436
Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217994
Reported-by: Tobias Gruetzmacher <tobias-lists@23.gs>
Closes: https://sourceforge.net/p/linux1394/mailman/message/58711901/
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2240973
Closes: https://bugs.launchpad.net/linux/+bug/2043905
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 7e88fd489741..9db9290c3269 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -279,6 +279,51 @@ static char ohci_driver_name[] = KBUILD_MODNAME;
 #define QUIRK_TI_SLLZ059		0x20
 #define QUIRK_IR_WAKE			0x40
 
+// On PCI Express Root Complex in any type of AMD Ryzen machine, VIA VT6306/6307/6308 with Asmedia
+// ASM1083/1085 brings an inconvenience that the read accesses to 'Isochronous Cycle Timer' register
+// (at offset 0xf0 in PCI I/O space) often causes unexpected system reboot. The mechanism is not
+// clear, since the read access to the other registers is enough safe; e.g. 'Node ID' register,
+// while it is probable due to detection of any type of PCIe error.
+#define QUIRK_REBOOT_BY_CYCLE_TIMER_READ	0x80000000
+
+#if IS_ENABLED(CONFIG_X86)
+
+static bool has_reboot_by_cycle_timer_read_quirk(const struct fw_ohci *ohci)
+{
+	return !!(ohci->quirks & QUIRK_REBOOT_BY_CYCLE_TIMER_READ);
+}
+
+#define PCI_DEVICE_ID_ASMEDIA_ASM108X	0x1080
+
+static bool detect_vt630x_with_asm1083_on_amd_ryzen_machine(const struct pci_dev *pdev)
+{
+	const struct pci_dev *pcie_to_pci_bridge;
+
+	// Detect any type of AMD Ryzen machine.
+	if (!static_cpu_has(X86_FEATURE_ZEN))
+		return false;
+
+	// Detect VIA VT6306/6307/6308.
+	if (pdev->vendor != PCI_VENDOR_ID_VIA)
+		return false;
+	if (pdev->device != PCI_DEVICE_ID_VIA_VT630X)
+		return false;
+
+	// Detect Asmedia ASM1083/1085.
+	pcie_to_pci_bridge = pdev->bus->self;
+	if (pcie_to_pci_bridge->vendor != PCI_VENDOR_ID_ASMEDIA)
+		return false;
+	if (pcie_to_pci_bridge->device != PCI_DEVICE_ID_ASMEDIA_ASM108X)
+		return false;
+
+	return true;
+}
+
+#else
+#define has_reboot_by_cycle_timer_read_quirk(ohci) false
+#define detect_vt630x_with_asm1083_on_amd_ryzen_machine(pdev)	false
+#endif
+
 /* In case of multiple matches in ohci_quirks[], only the first one is used. */
 static const struct {
 	unsigned short vendor, device, revision, flags;
@@ -1724,6 +1769,9 @@ static u32 get_cycle_time(struct fw_ohci *ohci)
 	s32 diff01, diff12;
 	int i;
 
+	if (has_reboot_by_cycle_timer_read_quirk(ohci))
+		return 0;
+
 	c2 = reg_read(ohci, OHCI1394_IsochronousCycleTimer);
 
 	if (ohci->quirks & QUIRK_CYCLE_TIMER) {
@@ -3630,6 +3678,9 @@ static int pci_probe(struct pci_dev *dev,
 	if (param_quirks)
 		ohci->quirks = param_quirks;
 
+	if (detect_vt630x_with_asm1083_on_amd_ryzen_machine(dev))
+		ohci->quirks |= QUIRK_REBOOT_BY_CYCLE_TIMER_READ;
+
 	/*
 	 * Because dma_alloc_coherent() allocates at least one page,
 	 * we save space by using a common buffer for the AR request/
-- 
2.40.1


