Return-Path: <linux-kernel+bounces-12581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1831881F72B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EC0281825
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0220CA70;
	Thu, 28 Dec 2023 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KSXYJ4HU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8263DC;
	Thu, 28 Dec 2023 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1bfdeb1ea56f11ee9e680517dc993faa-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nI6KrttaRM/LNaEDq5ru106Lo4sVpI71ZcgQf7QGbis=;
	b=KSXYJ4HUS+pInwMn/4OragY9BG2O0i+nNZ1qDUlhusC8yi7QbKhswncRIKG0bKgpMnahqlL/cmShJxDcb7Z0Ve1quSzgV+mh0mNXY5uI7N3SiUE9opRwDSjInYXMz3r1NL7yxn3tI7IERn6iO045WkZZuG3OAUjs250yVwKNu8I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:96f658e0-bbb5-4b07-9d38-712f83f326c4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:6452aa8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1bfdeb1ea56f11ee9e680517dc993faa-20231228
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 485193057; Thu, 28 Dec 2023 18:51:52 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Dec 2023 18:51:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Dec 2023 18:51:50 +0800
From: Yi-De Wu <yi-de.wu@mediatek.com>
To: Yingshiuan Pan <yingshiuan.pan@mediatek.com>, Ze-Yu Wang
	<ze-yu.wang@mediatek.com>, Yi-De Wu <yi-de.wu@mediatek.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
	Wihl Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-trace-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, David Bradil <dbrazdil@google.com>,
	Trilok Soni <quic_tsoni@quicinc.com>, Jade Shih <jades.shih@mediatek.com>,
	Ivan Tseng <ivan.tseng@mediatek.com>, My Chuang <my.chuang@mediatek.com>,
	Shawn Hsiao <shawn.hsiao@mediatek.com>, PeiLun Suei
	<peilun.suei@mediatek.com>, Liju Chen <liju-clr.chen@mediatek.com>, "Willix
 Yeh" <chi-shen.yeh@mediatek.com>, Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: [PATCH v8 01/20] docs: geniezone: Introduce GenieZone hypervisor
Date: Thu, 28 Dec 2023 18:51:28 +0800
Message-ID: <20231228105147.13752-2-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231228105147.13752-1-yi-de.wu@mediatek.com>
References: <20231228105147.13752-1-yi-de.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.623400-8.000000
X-TMASE-MatchedRID: WxZCKdO1VZMihjhlMTu+HHa57ruHAnHxFuNF4lJG6xs1LB46LFAAkkd0
	Rzx07LDVu1YWrIMJBFIUZ7mqlsLL7wAwGIAo3ShbyATMS/tDL5ipD1R7N5OROMA5YKm8dwM6jIZ
	02fRmyUctK7tHzSdmVLdnCNkrUAnN1ddezVny+QLiHyvyXeXh5qny79MYSKWc/uK0hv0lVwklHD
	ysIsZQz11tBKF7hhAzucwGRxuiOSoY1mlq1H5Z3ov2/i8VNqeOWOi4GPaBr7/FpA1uJFd1mtZho
	S9qxz0XFekDcD12A6u1XPxxyTBct3y3NtgjFBPrGLXhwJ3YV6NAq6/y5AEOOjvpyveVkrtEhCLR
	gWbx/Un1D9AzgdWivKIys8bfOtn9+hiRYeF7szVHoKp7fxLOV7ZvJfWpnfsSEoBacoHAF/+lBxI
	wyU8eVQMQDDSpB+BxYhdQng3DZoPhLW5g057g5cgc0seoKgtWFugFBW/IrRqNBRPxef1SsaPFjJ
	EFr+olwXCBO/GKkVr3FLeZXNZS4KBkcgGnJ4Wm4mr4jsefoybqLrr3+QO3xTOeYkMCfRSDfJ9ey
	qxGYOl+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.623400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: A97F132679FFB44938030EAF818E5B0C5D6D3597C1EAF770A3466D574814B1752000:8
X-MTK: N

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

GenieZone is MediaTek proprietary hypervisor solution, and it is running
in EL2 stand alone as a type-I hypervisor. It is a pure EL2
implementation which implies it does not rely any specific host VM, and
this behavior improves GenieZone's security as it limits its interface.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 Documentation/virt/geniezone/introduction.rst | 87 +++++++++++++++++++
 Documentation/virt/index.rst                  |  1 +
 MAINTAINERS                                   |  6 ++
 3 files changed, 94 insertions(+)
 create mode 100644 Documentation/virt/geniezone/introduction.rst

diff --git a/Documentation/virt/geniezone/introduction.rst b/Documentation/virt/geniezone/introduction.rst
new file mode 100644
index 000000000000..f280476228b3
--- /dev/null
+++ b/Documentation/virt/geniezone/introduction.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+GenieZone Introduction
+======================
+
+Overview
+========
+GenieZone hypervisor (gzvm) is a type-1 hypervisor that supports various virtual
+machine types and provides security features such as TEE-like scenarios and
+secure boot. It can create guest VMs for security use cases and has
+virtualization capabilities for both platform and interrupt. Although the
+hypervisor can be booted independently, it requires the assistance of GenieZone
+hypervisor kernel driver(also named gzvm) to leverage the ability of Linux
+kernel for vCPU scheduling, memory management, inter-VM communication and virtio
+backend support.
+
+Supported Architecture
+======================
+GenieZone now only supports MediaTek ARM64 SoC.
+
+Features
+========
+
+- vCPU Management
+
+  VM manager aims to provide vCPUs on the basis of time sharing on physical
+  CPUs. It requires Linux kernel in host VM for vCPU scheduling and VM power
+  management.
+
+- Memory Management
+
+  Direct use of physical memory from VMs is forbidden and designed to be
+  dictated to the privilege models managed by GenieZone hypervisor for security
+  reason. With the help of gzvm module, the hypervisor would be able to manipulate
+  memory as objects.
+
+- Virtual Platform
+
+  We manage to emulate a virtual mobile platform for guest OS running on guest
+  VM. The platform supports various architecture-defined devices, such as
+  virtual arch timer, GIC, MMIO, PSCI, and exception watching...etc.
+
+- Inter-VM Communication
+
+  Communication among guest VMs was provided mainly on RPC. More communication
+  mechanisms were to be provided in the future based on VirtIO-vsock.
+
+- Device Virtualization
+
+  The solution is provided using the well-known VirtIO. The gzvm module would
+  redirect MMIO traps back to VMM where the virtual devices are mostly emulated.
+  Ioeventfd is implemented using eventfd for signaling host VM that some IO
+  events in guest VMs need to be processed.
+
+- Interrupt virtualization
+
+  All Interrupts during some guest VMs running would be handled by GenieZone
+  hypervisor with the help of gzvm module, both virtual and physical ones.
+  In case there's no guest VM running out there, physical interrupts would be
+  handled by host VM directly for performance reason. Irqfd is also implemented
+  using eventfd for accepting vIRQ requests in gzvm module.
+
+Platform architecture component
+===============================
+
+- vm
+
+  The vm component is responsible for setting up the capability and memory
+  management for the protected VMs. The capability is mainly about the lifecycle
+  control and boot context initialization. And the memory management is highly
+  integrated with ARM 2-stage translation tables to convert VA to IPA to PA
+  under proper security measures required by protected VMs.
+
+- vcpu
+
+  The vcpu component is the core of virtualizing aarch64 physical CPU runnable,
+  and it controls the vCPU lifecycle including creating, running and destroying.
+  With self-defined exit handler, the vm component would be able to act
+  accordingly before terminated.
+
+- vgic
+
+  The vgic component exposes control interfaces to Linux kernel via irqchip, and
+  we intend to support all SPI, PPI, and SGI. When it comes to virtual
+  interrupts, the GenieZone hypervisor would write to list registers and trigger
+  vIRQ injection in guest VMs via GIC.
diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
index 7fb55ae08598..cf12444db336 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -16,6 +16,7 @@ Virtualization Support
    coco/sev-guest
    coco/tdx-guest
    hyperv/index
+   geniezone/introduction
 
 .. only:: html and subproject
 
diff --git a/MAINTAINERS b/MAINTAINERS
index d1af56dc3113..184a16268032 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8979,6 +8979,12 @@ F:	include/vdso/
 F:	kernel/time/vsyscall.c
 F:	lib/vdso/
 
+GENIEZONE HYPERVISOR DRIVER
+M:	Yingshiuan Pan <yingshiuan.pan@mediatek.com>
+M:	Ze-Yu Wang <ze-yu.wang@mediatek.com>
+M:	Yi-De Wu <yi-de.wu@mediatek.com>
+F:	Documentation/virt/geniezone/
+
 GENWQE (IBM Generic Workqueue Card)
 M:	Frank Haverkamp <haver@linux.ibm.com>
 S:	Supported
-- 
2.18.0


