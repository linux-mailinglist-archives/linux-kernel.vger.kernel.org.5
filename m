Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285117EE438
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjKPP30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjKPP3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:29:23 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6B618B;
        Thu, 16 Nov 2023 07:29:16 -0800 (PST)
X-UUID: e3852b08849411ee8051498923ad61e6-20231116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TAULPHkOdLk0sIcSE32SUJPJrWyPc3mcQD4zckgNoOE=;
        b=rrkIkr3kGIpvXtIRREAoylEpyUG9iP32Yqp5o0zEHQhT0Rc3ALFQ/MQ7G96v6npdtNBM0URbuYxwwdTuGr0Sg5flZFVcjXAJzf4yBDtW+WJe8+HEO+dyPhljeTPB6PXl58mpv/wRKyFt38CsKngx9ZSJR3jOyaeW10zIfltbDA8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:c3c04f5c-cd2a-4364-a8f3-ab31c2e32c66,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:f0b79cfc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e3852b08849411ee8051498923ad61e6-20231116
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1725635505; Thu, 16 Nov 2023 23:29:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 16 Nov 2023 23:29:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 16 Nov 2023 23:29:08 +0800
From:   Yi-De Wu <yi-de.wu@mediatek.com>
To:     Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Yi-De Wu <yi-de.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Arnd Bergmann <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        David Bradil <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>,
        Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: [PATCH v7 01/16] docs: geniezone: Introduce GenieZone hypervisor
Date:   Thu, 16 Nov 2023 23:27:41 +0800
Message-ID: <20231116152756.4250-2-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231116152756.4250-1-yi-de.wu@mediatek.com>
References: <20231116152756.4250-1-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

GenieZone is MediaTek proprietary hypervisor solution, and it is running
in EL2 stand alone as a type-I hypervisor. It is a pure EL2
implementation which implies it does not rely any specific host VM, and
this behavior improves GenieZone's security as it limits its interface.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 Documentation/virt/geniezone/introduction.rst | 86 +++++++++++++++++++
 Documentation/virt/index.rst                  |  1 +
 MAINTAINERS                                   |  6 ++
 3 files changed, 93 insertions(+)
 create mode 100644 Documentation/virt/geniezone/introduction.rst

diff --git a/Documentation/virt/geniezone/introduction.rst b/Documentation/virt/geniezone/introduction.rst
new file mode 100644
index 000000000000..fb9fa41bcfb8
--- /dev/null
+++ b/Documentation/virt/geniezone/introduction.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+GenieZone Introduction
+======================
+
+Overview
+========
+GenieZone hypervisor(gzvm) is a type-1 hypervisor that supports various virtual
+machine types and provides security features such as TEE-like scenarios and
+secure boot. It can create guest VMs for security use cases and has
+virtualization capabilities for both platform and interrupt. Although the
+hypervisor can be booted independently, it requires the assistance of GenieZone
+hypervisor kernel driver(gzvm-ko) to leverage the ability of Linux kernel for
+vCPU scheduling, memory management, inter-VM communication and virtio backend
+support.
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
+VM manager aims to provide vCPUs on the basis of time sharing on physical CPUs.
+It requires Linux kernel in host VM for vCPU scheduling and VM power management.
+
+- Memory Management
+
+Direct use of physical memory from VMs is forbidden and designed to be dictated
+to the privilege models managed by GenieZone hypervisor for security reason.
+With the help of gzvm-ko, the hypervisor would be able to manipulate memory as
+objects.
+
+- Virtual Platform
+
+We manage to emulate a virtual mobile platform for guest OS running on guest
+VM. The platform supports various architecture-defined devices, such as
+virtual arch timer, GIC, MMIO, PSCI, and exception watching...etc.
+
+- Inter-VM Communication
+
+Communication among guest VMs was provided mainly on RPC. More communication
+mechanisms were to be provided in the future based on VirtIO-vsock.
+
+- Device Virtualization
+
+The solution is provided using the well-known VirtIO. The gzvm-ko would
+redirect MMIO traps back to VMM where the virtual devices are mostly emulated.
+Ioeventfd is implemented using eventfd for signaling host VM that some IO
+events in guest VMs need to be processed.
+
+- Interrupt virtualization
+
+All Interrupts during some guest VMs running would be handled by GenieZone
+hypervisor with the help of gzvm-ko, both virtual and physical ones. In case
+there's no guest VM running out there, physical interrupts would be handled by
+host VM directly for performance reason. Irqfd is also implemented using
+eventfd for accepting vIRQ requests in gzvm-ko.
+
+Platform architecture component
+===============================
+
+- vm
+
+The vm component is responsible for setting up the capability and memory
+management for the protected VMs. The capability is mainly about the lifecycle
+control and boot context initialization. And the memory management is highly
+integrated with ARM 2-stage translation tables to convert VA to IPA to PA under
+proper security measures required by protected VMs.
+
+- vcpu
+
+The vcpu component is the core of virtualizing aarch64 physical CPU runnable,
+and it controls the vCPU lifecycle including creating, running and destroying.
+With self-defined exit handler, the vm component would be able to act
+accordingly before terminated.
+
+- vgic
+
+The vgic component exposes control interfaces to Linux kernel via irqchip, and
+we intend to support all SPI, PPI, and SGI. When it comes to virtual
+interrupts, the GenieZone hypervisor would write to list registers and trigger
+vIRQ injection in guest VMs via GIC.
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
index b294edaf5698..b4f7ff186619 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8942,6 +8942,12 @@ F:	include/vdso/
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

