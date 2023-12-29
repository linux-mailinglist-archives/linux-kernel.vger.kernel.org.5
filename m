Return-Path: <linux-kernel+bounces-12939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B881FCEE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 04:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB60E2834F3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6B81FC6;
	Fri, 29 Dec 2023 03:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="noC2c9zp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZDgM8txC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE81C1FA2;
	Fri, 29 Dec 2023 03:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id DFDFD5C0211;
	Thu, 28 Dec 2023 22:57:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 22:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1703822261; x=1703908661; bh=32++MlctQn
	piXBMjonb/FCIOqh7Sk/QwQuAJH3L64QI=; b=noC2c9zp6dlW33tHRBdtekLw5j
	p64qKqU0ZPR6qdxn5YS/mzz3CICrzakekT2phhmVlR64rQPWllOM9hGj/DOLH3wV
	DYRunWlOs0XvMr180ksbJ7CVXCI1FnRYbDMxZ34qMl1PmzYfoLbBRyJ5/WwqYhOY
	j9aqyH3nOWvCTa9Jx6yEcyE6cPnkVhv2hRAqFNqYPqcp4tDQXyuajDeL+3HHbMR+
	Aidr6w8v+CJmegzn2bmdNyoamxW4d9Trh2ng+skpxJRQfjbsQO/PdOETfwaD4k0t
	5S7sTu1BRA2e7YpLKZlD4TifGSpP5n5CfWamXWu3G9czHEh3yq+7nCIpI9Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703822261; x=1703908661; bh=32++MlctQnpiXBMjonb/FCIOqh7S
	k/QwQuAJH3L64QI=; b=ZDgM8txCIAcfUcnJF/LiSWZtVWZ6wGfDFpY4/5s8H9VH
	2q45HpF8Rf1SNY4TqYl+/PiQlFm01TiFJgY3rWzkJtTdGiwY4gxOI+6pPk6a/dT4
	LZCjpUHfd2nH/rR4Ll/ne+4XuRJBM6cD2aV2mkisQDjnvhhuCzScL1XgzSvlJNZA
	zR6ArOo0A1i9V/2QwUT8cdeEd2jvDehm2ObGSktiubuqfX2cif2Rx0VQP1kzkZhN
	kqC08LNu2duM2zySRqLtcaUFWqeCrhXvAUW+YblRFHto7pdAS064etBec8z8f7oe
	YA2BFqFWWDMF4CtrRyU5NPRX7J9SCz8KD8HAhr4ouA==
X-ME-Sender: <xms:tUOOZYwl_oYfi5V42ndoyYORHya1wpXrAxc5p_jqVcaioJ2IOq37nA>
    <xme:tUOOZcTg9xzO4E6viyJHlwvPjUPrnx9lAEQW7xDqoJiptNoGUuVQ-oBdbYFIrzOqk
    GkT11sY12ngBmoQCyo>
X-ME-Received: <xmr:tUOOZaUjiy1ZcG-CwLxjB4neEhwoZqdeuKaYG62qbKW71s-DE0tNkmQe0y4prxEX62pcpH0Qb05RjqhmlEtgkYR1i_-_AFImALsglMPyt2Wk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefvddgieeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:tUOOZWjXQ50HGXErigUlxdHBuIDgrWMYA7e1XdrhG8BwMZZ4ecOYAA>
    <xmx:tUOOZaDrjek2KQdF7B1jOaCahqrzgBBHdwkcKIFkyB2cEbUZN1VFhA>
    <xmx:tUOOZXKvhWuzQT-eyszVRdL6b5nfQIGGRwRfS4Wjdn77lWmCutM_CQ>
    <xmx:tUOOZR4sWBEVA0kj7kgq9X6GSOqRlRaKQsG6W1LAiW9uIyJgM6fkxg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 22:57:39 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com,
	stable@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Tobias Gruetzmacher <tobias-lists@23.gs>
Subject: [PATCH] firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards
Date: Fri, 29 Dec 2023 12:57:35 +0900
Message-Id: <20231229035735.11127-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
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

Well, this commit suppresses the system reboot in the combination of
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
 drivers/firewire/ohci.c | 49 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 7e88fd489741..62af3fa39a70 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -279,6 +279,8 @@ static char ohci_driver_name[] = KBUILD_MODNAME;
 #define QUIRK_TI_SLLZ059		0x20
 #define QUIRK_IR_WAKE			0x40
 
+#define QUIRK_REBOOT_BY_CYCLE_TIMER_READ	0x80000000
+
 /* In case of multiple matches in ohci_quirks[], only the first one is used. */
 static const struct {
 	unsigned short vendor, device, revision, flags;
@@ -1724,6 +1726,11 @@ static u32 get_cycle_time(struct fw_ohci *ohci)
 	s32 diff01, diff12;
 	int i;
 
+#if IS_ENABLED(CONFIG_X86)
+	if (ohci->quirks & QUIRK_REBOOT_BY_CYCLE_TIMER_READ)
+		return 0;
+#endif
+
 	c2 = reg_read(ohci, OHCI1394_IsochronousCycleTimer);
 
 	if (ohci->quirks & QUIRK_CYCLE_TIMER) {
@@ -3527,6 +3534,45 @@ static const struct fw_card_driver ohci_driver = {
 	.stop_iso		= ohci_stop_iso,
 };
 
+// On PCI Express Root Complex in any type of AMD Ryzen machine, VIA VT6306/6307/6308 with Asmedia
+// ASM1083/1085 brings an inconvenience that read accesses to 'Isochronous Cycle Timer' register
+// (at offset 0xf0 in PCI I/O space) often causes unexpected system reboot. The mechanism is not
+// clear, since the read access to the other registers is enough safe; e.g. 'Node ID' register,
+// while it is probable due to detection of any type of PCIe error.
+#if IS_ENABLED(CONFIG_X86)
+
+#define PCI_DEVICE_ID_ASMEDIA_ASM108X	0x1080
+
+static bool detect_vt630x_with_asm1083_on_amd_ryzen_machine(const struct pci_dev *pdev,
+							    struct fw_ohci *ohci)
+{
+	const struct pci_dev *pcie_to_pci_bridge;
+	const struct cpuinfo_x86 *cinfo = &cpu_data(0);
+
+	// Detect any type of AMD Ryzen machine.
+	if (cinfo->x86_vendor != X86_VENDOR_AMD || cinfo->x86 < 0x17)
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
+#define detect_vt630x_with_asm1083_on_amd_ryzen_machine(pdev)	false
+#endif
+
 #ifdef CONFIG_PPC_PMAC
 static void pmac_ohci_on(struct pci_dev *dev)
 {
@@ -3630,6 +3676,9 @@ static int pci_probe(struct pci_dev *dev,
 	if (param_quirks)
 		ohci->quirks = param_quirks;
 
+	if (detect_vt630x_with_asm1083_on_amd_ryzen_machine(dev, ohci))
+		ohci->quirks |= QUIRK_REBOOT_BY_CYCLE_TIMER_READ;
+
 	/*
 	 * Because dma_alloc_coherent() allocates at least one page,
 	 * we save space by using a common buffer for the AR request/
-- 
2.39.2


