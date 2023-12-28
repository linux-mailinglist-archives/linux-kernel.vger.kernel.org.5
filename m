Return-Path: <linux-kernel+bounces-12592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD0681F75A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E1428270D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD8E12B88;
	Thu, 28 Dec 2023 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MzsC9WWq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6EB8820;
	Thu, 28 Dec 2023 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1c18978ea56f11eea2298b7352fd921d-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/mZ0uh7s9p7RHjYr43LMl/7o/rrNa9ex576kVdLVp1Y=;
	b=MzsC9WWqyz19SEPVDMlIDFX/wNkcZDsSyCOMFu2/jGEF+uBcRdqEqWv5q4jW2t5b08XYuadhfeNOIJG0TDlgIOxhqqhDeKuNaX7C8QD6DqSiOWl8jqid0kNG7Qf/vhb3fGhNcUFaOj+DBYGCQdYWNeS50RXqW4VOGnNJRT0AhUc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:9d8836ae-b1ce-4a7c-96c9-bd280760f4c0,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:ac694382-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 1c18978ea56f11eea2298b7352fd921d-20231228
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1531708491; Thu, 28 Dec 2023 18:51:52 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
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
Subject: [PATCH v8 00/20] GenieZone hypervisor drivers
Date: Thu, 28 Dec 2023 18:51:27 +0800
Message-ID: <20231228105147.13752-1-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.802000-8.000000
X-TMASE-MatchedRID: dVTrdeyNEqXe5qus620rkNcjCbPZgQnFqQ9UezeTkTjAOWCpvHcDOoyG
	dNn0ZslHLSu7R80nZlQhcnM8qCdEam2EnshdEio2Ojf3A4DTYuGU47NCrvBdqRwuKjWkK2ZvxAa
	Y6MFYVEd5DzCqPSy3yCOt3SHiJm8blIvx78wYCllPuMJi/ZAk8TFcf92WG8u/mOTQRu2CG1cyr5
	6f45o269gKxB3iRV6rxf/R2axx4hz44oqneGTNCJdc7I2df+mstm8l9amd+xJrEoFtNYg0C1e68
	CLW9GuwprhPLBzR/tE2eI0UsdredEHWbmeNr66RLTHwnYOikQ3Sde/CNbaZJUENV4Lwnu7BleOI
	lW3xn/cVn0hYuL9l/YqzhSsGiK9ti3jdTHwj02rsg74oZqk6fEyQ5fRSh265YmQk5BUIinAwrAJ
	nuG4aIS/rjK1CMnpuX7bicKxRIU2No+PRbWqfRMprJP8FBOIauzOGlHUYCTK9ji4ZLs2JstDgoi
	yvFEJ0xYM4TJ4nh3Cp3/MlfovP4L7ic6bocDfR5B2cfIuO7yCa84LcyIpZAFv4unVhH6j1NpdRa
	j6wxth4W/rV0NGdh/RzmpSOCosq9iVB5TfGsfRe0YmbY3/fIg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.802000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C95FC48CFB02FC919E15791F431B10D8AF47E7CE1AB025424D70DE027FB4B4532000:8
X-MTK: N

This series is based on linux-next, tag: next-20231222.

GenieZone hypervisor(gzvm) is a type-1 hypervisor that supports various virtual
machine types and provides security features such as TEE-like scenarios and
secure boot. It can create guest VMs for security use cases and has
virtualization capabilities for both platform and interrupt. Although the
hypervisor can be booted independently, it requires the assistance of GenieZone
hypervisor kernel driver(gzvm-ko) to leverage the ability of Linux kernel for
vCPU scheduling, memory management, inter-VM communication and virtio backend
support.

Changes in v8:
- Add reasons for using dt solution in dt-bindings.
- Add locks for memory pin/unpin and relinquish operations.
- Add VM memory stats in debugfs.
- Add tracing support for hypercall and vcpu exit reasons.
- Enable PTP for timing synchronization between host and guests.
- Optimize memory performance for protected VMs.
- Refactor wording and titles in documentation.

Changes in v7:
https://lore.kernel.org/all/20231116152756.4250-1-yi-de.wu@mediatek.com/
- Rebase these patches to the Linux 6.7-rc1 release.
- Refactor patches 1 to 15 to improve coding style while ensuring they do not
  violate the majority of the changes made in v6
- Provide individual VM memory statistics within debugfs in patch 16.
- Add tracing support for hyper call and vcpu exit_reason.

Changes in v6:
https://lore.kernel.org/all/20230919111210.19615-1-yi-de.wu@mediatek.com/
- Rebase based on kernel 6.6-rc1
- Keep dt solution and leave the reasons in the commit message
- Remove arch/arm64/include/uapi/asm/gzvm_arch.h due to simplicity
- Remove resampler in drivers/virt/geniezone/gzvm_irqfd.c due to defeature for
  now
- Remove PPI in arch/arm64/geniezone/vgic.c
- Refactor vm related components into 3 smaller patches, namely adding vm
  support, setting user memory region and checking vm capability 
- Refactor vcpu and vm component to remove unnecessary ARM prefix 
- Add demand paging to fix crash on destroying memory page, acclerate on booting
  and support ballooning deflate
- Add memory pin/unpin memory mechanism to support protected VM
- Add block-based demand paging for performance concern
- Response to reviewers and fix coding style accordingly

Changes in v5:
https://lore.kernel.org/all/20230727080005.14474-1-yi-de.wu@mediatek.com/
- Add dt solution back for device initialization
- Add GZVM_EXIT_GZ reason for gzvm_vcpu_run()
- Add patch for guest page fault handler
- Add patch for supporitng pin/unpin memory
- Remove unused enum members, namely GZVM_FUNC_GET_REGS and GZVM_FUNC_SET_REGS
- Use dev_debug() for debugging when platform device is available, and use
  pr_debug() otherwise
- Response to reviewers and fix bugs accordingly


Changes in v4:
https://lore.kernel.org/all/20230609085214.31071-1-yi-de.wu@mediatek.com/
- Add macro to set VM as protected without triggering pvmfw in AVF.
- Add support to pass dtb config to hypervisor.
- Add support for virtual timer.
- Add UAPI to pass memory region metadata to hypervisor.
- Define our own macros for ARM's interrupt number
- Elaborate more on GenieZone hyperivsor in documentation
- Fix coding style.
- Implement our own module for coverting ipa to pa
- Modify the way of initializing device from dt to a more discoverable way
- Move refactoring changes into indepedent patches.

Changes in v3:
https://lore.kernel.org/all/20230512080405.12043-1-yi-de.wu@mediatek.com/
- Refactor: separate arch/arm64/geniezone/gzvm_arch.c into vm.c/vcpu.c/vgic.c
- Remove redundant functions
- Fix reviewer's comments

Changes in v2:
https://lore.kernel.org/all/20230428103622.18291-1-yi-de.wu@mediatek.com/
- Refactor: move to drivers/virt/geniezone
- Refactor: decouple arch-dependent and arch-independent
- Check pending signal before entering guest context
- Fix reviewer's comments

Initial Commit in v1:
https://lore.kernel.org/all/20230413090735.4182-1-yi-de.wu@mediatek.com/


Yi-De Wu (20):
  docs: geniezone: Introduce GenieZone hypervisor
  dt-bindings: hypervisor: Add MediaTek GenieZone hypervisor
  virt: geniezone: Add GenieZone hypervisor driver
  virt: geniezone: Add vm support
  virt: geniezone: Add set_user_memory_region for vm
  virt: geniezone: Add vm capability check
  virt: geniezone: Optimize performance of protected VM memory
  virt: geniezone: Add vcpu support
  virt: geniezone: Add irqchip support for virtual interrupt injection
  virt: geniezone: Add irqfd support
  virt: geniezone: Add ioeventfd support
  virt: geniezone: Add memory region support
  virt: geniezone: Add dtb config support
  virt: geniezone: Add demand paging support
  virt: geniezone: Add block-based demand paging support
  virt: geniezone: Add memory pin/unpin support
  virt: geniezone: Add memory relinquish support
  virt: geniezone: Provide individual VM memory statistics within
    debugfs
  virt: geniezone: Add tracing support for hyp call and vcpu exit_reason
  virt: geniezone: Enable PTP for synchronizing time between host and
    guest VMs

 .../hypervisor/mediatek,geniezone-hyp.yaml    |  31 +
 Documentation/virt/geniezone/introduction.rst |  87 +++
 Documentation/virt/index.rst                  |   1 +
 MAINTAINERS                                   |  11 +
 arch/arm64/Kbuild                             |   1 +
 arch/arm64/geniezone/Makefile                 |   9 +
 arch/arm64/geniezone/gzvm_arch_common.h       | 122 ++++
 arch/arm64/geniezone/hvc.c                    |  73 +++
 arch/arm64/geniezone/vcpu.c                   |  80 +++
 arch/arm64/geniezone/vgic.c                   |  50 ++
 arch/arm64/geniezone/vm.c                     | 424 ++++++++++++
 drivers/virt/Kconfig                          |   2 +
 drivers/virt/geniezone/Kconfig                |  16 +
 drivers/virt/geniezone/Makefile               |  12 +
 drivers/virt/geniezone/gzvm_common.h          |  12 +
 drivers/virt/geniezone/gzvm_exception.c       |  61 ++
 drivers/virt/geniezone/gzvm_ioeventfd.c       | 276 ++++++++
 drivers/virt/geniezone/gzvm_irqfd.c           | 382 +++++++++++
 drivers/virt/geniezone/gzvm_main.c            | 153 +++++
 drivers/virt/geniezone/gzvm_mmu.c             | 300 +++++++++
 drivers/virt/geniezone/gzvm_vcpu.c            | 284 ++++++++
 drivers/virt/geniezone/gzvm_vm.c              | 608 ++++++++++++++++++
 include/linux/gzvm_drv.h                      | 221 +++++++
 include/trace/events/geniezone.h              |  54 ++
 include/uapi/linux/gzvm.h                     | 396 ++++++++++++
 25 files changed, 3666 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml
 create mode 100644 Documentation/virt/geniezone/introduction.rst
 create mode 100644 arch/arm64/geniezone/Makefile
 create mode 100644 arch/arm64/geniezone/gzvm_arch_common.h
 create mode 100644 arch/arm64/geniezone/hvc.c
 create mode 100644 arch/arm64/geniezone/vcpu.c
 create mode 100644 arch/arm64/geniezone/vgic.c
 create mode 100644 arch/arm64/geniezone/vm.c
 create mode 100644 drivers/virt/geniezone/Kconfig
 create mode 100644 drivers/virt/geniezone/Makefile
 create mode 100644 drivers/virt/geniezone/gzvm_common.h
 create mode 100644 drivers/virt/geniezone/gzvm_exception.c
 create mode 100644 drivers/virt/geniezone/gzvm_ioeventfd.c
 create mode 100644 drivers/virt/geniezone/gzvm_irqfd.c
 create mode 100644 drivers/virt/geniezone/gzvm_main.c
 create mode 100644 drivers/virt/geniezone/gzvm_mmu.c
 create mode 100644 drivers/virt/geniezone/gzvm_vcpu.c
 create mode 100644 drivers/virt/geniezone/gzvm_vm.c
 create mode 100644 include/linux/gzvm_drv.h
 create mode 100644 include/trace/events/geniezone.h
 create mode 100644 include/uapi/linux/gzvm.h

-- 
2.18.0


