Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4007A60D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjISLNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjISLM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:12:57 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C193F1;
        Tue, 19 Sep 2023 04:12:49 -0700 (PDT)
X-UUID: 7294f6b056dd11ee8051498923ad61e6-20230919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1jvjjzw4AS24CCKpJjJwLW1RVXK5JBfjv7SdIIaHTYk=;
        b=Ll/hZYKGEYRpDHzoj0DNx6kCiGoDrpJPwoFM1hpeJWT+tHXJYWKPeK/C7MKmQxzHZXZS4Y+8I2gSeDbLRmzK1bM3XDo3c5Gu3EKWDIOy5f4dt7sr8MMYDY8ay2p6LdAucrJB6quPDG1osuYskDa8bNiSMjC5+qisyD+yPYGP+98=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:510aed20-c586-44aa-96b1-228c9ec68769,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:5f78ec9,CLOUDID:63581e14-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 7294f6b056dd11ee8051498923ad61e6-20230919
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 954853373; Tue, 19 Sep 2023 19:12:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Sep 2023 19:12:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Sep 2023 19:12:39 +0800
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
        Kevenny Hsieh <kevenny.hsieh@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>
Subject: [PATCH v6 00/15] GenieZone hypervisor drivers
Date:   Tue, 19 Sep 2023 19:11:55 +0800
Message-ID: <20230919111210.19615-1-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on linux-next, tag: next-20230919.

GenieZone hypervisor(gzvm) is a type-1 hypervisor that supports various virtual
machine types and provides security features such as TEE-like scenarios and
secure boot. It can create guest VMs for security use cases and has
virtualization capabilities for both platform and interrupt. Although the
hypervisor can be booted independently, it requires the assistance of GenieZone
hypervisor kernel driver(gzvm-ko) to leverage the ability of Linux kernel for
vCPU scheduling, memory management, inter-VM communication and virtio backend
support.

Changes in v6:
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
https://lore.kernel.org/lkml/20230609085214.31071-1-yi-de.wu@mediatek.com/
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

Yi-De Wu (15):
  docs: geniezone: Introduce GenieZone hypervisor
  dt-bindings: hypervisor: Add MediaTek GenieZone hypervisor
  virt: geniezone: Add GenieZone hypervisor driver
  virt: geniezone: Add vm support
  virt: geniezone: Add set_user_memory_region for vm
  virt: geniezone: Add vm capability check
  virt: geniezone: Add vcpu support
  virt: geniezone: Add irqchip support for virtual interrupt injection
  virt: geniezone: Add irqfd support
  virt: geniezone: Add ioeventfd support
  virt: geniezone: Add memory region support
  virt: geniezone: Add dtb config support
  virt: geniezone: Add demand paging support
  virt: geniezone: Add memory pin/unpin support
  virt: geniezone: Add block-based demand paging support

 .../hypervisor/mediatek,geniezone-hyp.yaml    |  31 ++
 Documentation/virt/geniezone/introduction.rst |  86 ++++
 Documentation/virt/index.rst                  |   1 +
 MAINTAINERS                                   |  11 +
 arch/arm64/Kbuild                             |   1 +
 arch/arm64/geniezone/Makefile                 |   9 +
 arch/arm64/geniezone/gzvm_arch_common.h       | 114 +++++
 arch/arm64/geniezone/vcpu.c                   |  80 +++
 arch/arm64/geniezone/vgic.c                   |  50 ++
 arch/arm64/geniezone/vm.c                     | 380 ++++++++++++++
 drivers/virt/Kconfig                          |   2 +
 drivers/virt/geniezone/Kconfig                |  16 +
 drivers/virt/geniezone/Makefile               |  12 +
 drivers/virt/geniezone/gzvm_common.h          |  12 +
 drivers/virt/geniezone/gzvm_exception.c       |  67 +++
 drivers/virt/geniezone/gzvm_ioeventfd.c       | 276 +++++++++++
 drivers/virt/geniezone/gzvm_irqfd.c           | 382 ++++++++++++++
 drivers/virt/geniezone/gzvm_main.c            | 147 ++++++
 drivers/virt/geniezone/gzvm_mmu.c             | 277 +++++++++++
 drivers/virt/geniezone/gzvm_vcpu.c            | 281 +++++++++++
 drivers/virt/geniezone/gzvm_vm.c              | 468 ++++++++++++++++++
 include/linux/gzvm_drv.h                      | 204 ++++++++
 include/uapi/linux/gzvm.h                     | 395 +++++++++++++++
 23 files changed, 3302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml
 create mode 100644 Documentation/virt/geniezone/introduction.rst
 create mode 100644 arch/arm64/geniezone/Makefile
 create mode 100644 arch/arm64/geniezone/gzvm_arch_common.h
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
 create mode 100644 include/uapi/linux/gzvm.h

-- 
2.18.0

