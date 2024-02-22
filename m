Return-Path: <linux-kernel+bounces-77525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5368F8606DB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47981F24C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897C6159588;
	Thu, 22 Feb 2024 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gi+hhLAU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828F1225AA;
	Thu, 22 Feb 2024 23:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643868; cv=none; b=X+9Rrd79Wm4puS1/ZwC3fpOP8iu0eIMAzmFeflfUwrz/2HVPLzLqo/1PQ7uD/QeiL6XJZezexkGKBfdtWHOFIQPl9Agzu5JIcdAFbyOoPZUa2UgbnSpvzQXW+Q85N6b7eub3089ZZYbysWHpLW5KRWpwYM03NFnhyBgrMv/9qDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643868; c=relaxed/simple;
	bh=AOXQpfud0y7B7Zjmjzynj1tmBM8+xLCEmeuqiuVG8tw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=TZSyox60IO3hLVj/VSDZVekkSyPIzc8JWsnEdq//j2Kl5PRBVxx9+Y5vGJn0wHljuxueUvwzYveCFUEKdHpHjMnaXhB7rVmtO3opRMOOwvTmd/6rSOX/1/5wB4XnguRBR/a2fbV37iVETRwV2eHPUcOaZbwNzmaNwJPcQiNv85M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gi+hhLAU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MLfm5Q007618;
	Thu, 22 Feb 2024 23:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=XU6+xTRmXZW3XB
	1dId8rJpRe/W6T12K0CbLCDLT5g18=; b=gi+hhLAU2ba3uIi3jOPhbJiXi3JWLN
	OAKUIhMifOStD6An+Dd1tQfIfZAysyQV4SsQwtfzcNjEvQxyd/Dx4hFLQPamlB5f
	DMm9gtjats81Z+CNFYB16f5mpljzepAFal7RuiERCZXRqZ02T0ad/OTehgp6KfCf
	Y6y3incHfCaL77Tjg8JEYeyHlSVsAS3/opB+UJLkPTHnGeCh+IEa7Cf1mjjuJFr3
	2cdOtwRBK76BknbWa5bNnITTqdoJsIbpOwIQ02C7TPTzp9W2yxocltuhdTdPt+il
	x8YfkybtAMBEaIL2FnnHKCsI6HKD20CgyUyYk6aB52AjWj899LNpVyIA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weasbs60q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGRL5018187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:27 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:26 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH v17 00/35] Drivers for Gunyah hypervisor
Date: Thu, 22 Feb 2024 15:16:23 -0800
Message-ID: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMfV12UC/1WMyw6CMBQFf4V0bc3tE+rK/zAuailwFxZthUgI/
 24hEuPyTM7MTJKP6BM5FTOJfsSEfciDlYeCuM6G1lOsMyAcuGAcKtoOYbIdNYpbZ0utKw8knx/
 RN/jeSpdr3h2mVx+nLTwyteJvg6m9kTkFygy3qq5KbgWcnwM6DO7o+jtZMyPTuyqBgfmpOqtaS
 APy1kjnzb+6LMsHogBeoNwAAAA=
To: Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri
	<quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Philip Derrin <quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu
	<quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Fuad
 Tabba" <tabba@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Andrew
 Morton" <akpm@linux-foundation.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hAraAheqf2O_bQQ1azDSjoPjnS7SSnde
X-Proofpoint-GUID: hAraAheqf2O_bQQ1azDSjoPjnS7SSnde
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220179

Gunyah is a Type-1 hypervisor independent of any high-level OS kernel,
and runs in a higher CPU privilege level. It does not depend on any
lower-privileged OS kernel/code for its core functionality. This
increases its security and can support a much smaller trusted computing
base than a Type-2 hypervisor. Gunyah is designed for isolated virtual
machine use cases and to support launching trusted+isolated virtual
machines from a relatively less trusted host virtual machine.

Gunyah is an open source hypervisor. The source repo is available at
https://github.com/quic/gunyah-hypervisor.

The diagram below shows the architecture for AArch64.

::

         VM A                    VM B
     +-----+ +-----+  | +-----+ +-----+ +-----+
     |     | |     |  | |     | |     | |     |
 EL0 | APP | | APP |  | | APP | | APP | | APP |
     |     | |     |  | |     | |     | |     |
     +-----+ +-----+  | +-----+ +-----+ +-----+
 ---------------------|-------------------------
     +--------------+ | +----------------------+
     |              | | |                      |
 EL1 | Linux Kernel | | |Linux kernel/Other OS |   ...
     |              | | |                      |
     +--------------+ | +----------------------+
 --------hvc/smc------|------hvc/smc------------

     +----------------------------------------+
     |                                        |
 EL2 |            Gunyah Hypervisor           |
     |                                        |
     +----------------------------------------+

Gunyah provides these following features.

- Threads and Scheduling: The scheduler schedules virtual CPUs (VCPUs)
  on physical CPUs and enables time-sharing of the CPUs.
- Memory Management: Gunyah tracks memory ownership and use of all
  memory under its control. It provides low level dynamic memory
  management APIs on top of which higher level donation, lending and sharing
  is built. Gunyah provides strong VM memory isolation for trusted VMs.
- Interrupt Virtualization: Interrupts are managed by the hypervisor
  and are routed directly to the assigned VM.
- Inter-VM Communication: There are several different mechanisms
  provided for communicating between VMs.
- Device Virtualization: Para-virtualization of devices is supported
  using inter-VM communication and virtio primitives. Low level architecture
  features and devices such as cpu timers, interrupt controllers are supported
  with hardware virtualization and emulation where required.
- Resource Manager: Gunyah supports a "root" VM that initially owns all
  VM memory and IO resources. The Gunyah Resource Manager is the default
  bundled root VM and provides high-level services including dynamic VM
  management and secure memory donation, lending and sharing.

This series adds the basic framework for detecting that Linux is running
under Gunyah as a virtual machine, communication with the Gunyah
Resource Manager, and a sample virtual machine manager capable of
launching virtual machines.

Changes in v17:
 - Replace RM's irq_chip with irq_create_fwspec_mapping
 - Unmap lent memory from kernel logical map
 - Small optimization to unlock folio earlier to allow vCPUs racing for
   the same folio to run sooner
 - Add missed "safe to lend" checks for a folio when constructing mem
   parcel

Changes in v16:
https://lore.kernel.org/r/20240109-gunyah-v16-0-634904bf4ce9@quicinc.com
 - Fleshed out memory reclaim while VM is running
 - Documentation and comments

Changes in v15:
https://lore.kernel.org/r/20231215-gunyah-v15-0-192a5d872a30@quicinc.com
 - First implementation of virtual machines backed by guestmemfd and
using demand paging to provide memory instead of all up front.
 - Use message queue hypercalls directly instead of traversing through
mailbox framework.

Changes in v14: https://lore.kernel.org/all/20230613172054.3959700-1-quic_eberman@quicinc.com/
 - Coding/cosmetic tweaks suggested by Alex
 - Mark IRQs as wake-up capable

Changes in v13:
https://lore.kernel.org/all/20230509204801.2824351-1-quic_eberman@quicinc.com/
 - Tweaks to message queue driver to address race condition between IRQ
and mailbox registration
 - Allow removal of VM functions by function-specific comparison --
specifically to allow
   removing irqfd by label only and not requiring original FD to be
provided.

Changes in v12:
https://lore.kernel.org/all/20230424231558.70911-1-quic_eberman@quicinc.com/
 - Stylistic/cosmetic tweaks suggested by Alex
 - Remove patch "virt: gunyah: Identify hypervisor version" and squash
the
   check that we're running under a reasonable Gunyah hypervisor into RM
driver
 - Refactor platform hooks into a separate module per suggestion from
Srini
 - GFP_KERNEL_ACCOUNT and account_locked_vm() for page pinning
 - enum-ify related constants

Changes in v11:
https://lore.kernel.org/all/20230304010632.2127470-1-quic_eberman@quicinc.com/
 - Rename struct gh_vm_dtb_config:gpa -> guest_phys_addr & overflow
checks for this
 - More docstrings throughout
 - Make resp_buf and resp_buf_size optional
 - Replace deprecated idr with xarray
 - Refconting on misc device instead of RM's platform device
 - Renaming variables, structs, etc. from gunyah_ -> gh_
 - Drop removal of user mem regions
 - Drop mem_lend functionality; to converge with restricted_memfd later

Changes in v10:
https://lore.kernel.org/all/20230214211229.3239350-1-quic_eberman@quicinc.com/
 - Fix bisectability (end result of series is same, --fixups applied to
wrong commits)
 - Convert GH_ERROR_* and GH_RM_ERROR_* to enums
 - Correct race condition between allocating/freeing user memory
 - Replace offsetof with struct_size
 - Series-wide renaming of functions to be more consistent
 - VM shutdown & restart support added in vCPU and VM Manager patches
 - Convert VM function name (string) to type (number)
 - Convert VM function argument to value (which could be a pointer) to
remove memory wastage for arguments
 - Remove defensive checks of hypervisor correctness
 - Clean ups to ioeventfd as suggested by Srivatsa

Changes in v9:
https://lore.kernel.org/all/20230120224627.4053418-1-quic_eberman@quicinc.com/
 - Refactor Gunyah API flags to be exposed as feature flags at kernel
level
 - Move mbox client cleanup into gunyah_msgq_remove()
 - Simplify gh_rm_call return value and response payload
 - Missing clean-up/error handling/little endian fixes as suggested by
Srivatsa and Alex in v8 series

Changes in v8:
https://lore.kernel.org/all/20221219225850.2397345-1-quic_eberman@quicinc.com/
 - Treat VM manager as a library of RM
 - Add patches 21-28 as RFC to support proxy-scheduled vCPUs and
necessary bits to support virtio
   from Gunyah userspace

Changes in v7:
https://lore.kernel.org/all/20221121140009.2353512-1-quic_eberman@quicinc.com/
 - Refactor to remove gunyah RM bus
 - Refactor allow multiple RM device instances
 - Bump UAPI to start at 0x0
 - Refactor QCOM SCM's platform hooks to allow
CONFIG_QCOM_SCM=Y/CONFIG_GUNYAH=M combinations

Changes in v6:
https://lore.kernel.org/all/20221026185846.3983888-1-quic_eberman@quicinc.com/
 - *Replace gunyah-console with gunyah VM Manager*
 - Move include/asm-generic/gunyah.h into include/linux/gunyah.h
 - s/gunyah_msgq/gh_msgq/
 - Minor tweaks and documentation tidying based on comments from Jiri,
Greg, Arnd, Dmitry, and Bagas.

Changes in v5
https://lore.kernel.org/all/20221011000840.289033-1-quic_eberman@quicinc.com/
 - Dropped sysfs nodes
 - Switch from aux bus to Gunyah RM bus for the subdevices
 - Cleaning up RM console

Changes in v4:
https://lore.kernel.org/all/20220928195633.2348848-1-quic_eberman@quicinc.com/
 - Tidied up documentation throughout based on questions/feedback received
 - Switched message queue implementation to use mailboxes
 - Renamed "gunyah_device" as "gunyah_resource"

Changes in v3:
https://lore.kernel.org/all/20220811214107.1074343-1-quic_eberman@quicinc.com/
 - /Maintained/Supported/ in MAINTAINERS
 - Tidied up documentation throughout based on questions/feedback received
 - Moved hypercalls into arch/arm64/gunyah/; following hyper-v's implementation
 - Drop opaque typedefs
 - Move sysfs nodes under /sys/hypervisor/gunyah/
 - Moved Gunyah console driver to drivers/tty/
 - Reworked gh_device design to drop the Gunyah bus.

Changes in v2: https://lore.kernel.org/all/20220801211240.597859-1-quic_eberman@quicinc.com/
 - DT bindings clean up
 - Switch hypercalls to follow SMCCC 

v1: https://lore.kernel.org/all/20220223233729.1571114-1-quic_eberman@quicinc.com/

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
Elliot Berman (35):
      docs: gunyah: Introduce Gunyah Hypervisor
      dt-bindings: Add binding for gunyah hypervisor
      gunyah: Common types and error codes for Gunyah hypercalls
      virt: gunyah: Add hypercalls to identify Gunyah
      virt: gunyah: Add hypervisor driver
      virt: gunyah: msgq: Add hypercalls to send and receive messages
      gunyah: rsc_mgr: Add resource manager RPC core
      gunyah: vm_mgr: Introduce basic VM Manager
      gunyah: rsc_mgr: Add VM lifecycle RPC
      gunyah: vm_mgr: Add VM start/stop
      virt: gunyah: Translate gh_rm_hyp_resource into gunyah_resource
      virt: gunyah: Add resource tickets
      gunyah: vm_mgr: Add framework for VM Functions
      virt: gunyah: Add hypercalls for running a vCPU
      virt: gunyah: Add proxy-scheduled vCPUs
      gunyah: Add hypercalls for demand paging
      gunyah: rsc_mgr: Add memory parcel RPC
      mm/interval_tree: Export iter_first/iter_next
      arch/mm: Export direct {un,}map functions
      virt: gunyah: Add interfaces to map memory into guest address space
      gunyah: rsc_mgr: Add platform ops on mem_lend/mem_reclaim
      virt: gunyah: Add Qualcomm Gunyah platform ops
      virt: gunyah: Implement guestmemfd
      virt: gunyah: Add ioctl to bind guestmem to VMs
      virt: gunyah: guestmem: Initialize RM mem parcels from guestmem
      virt: gunyah: Share guest VM dtb configuration to Gunyah
      gunyah: rsc_mgr: Add RPC to enable demand paging
      virt: gunyah: Enable demand paging
      gunyah: rsc_mgr: Add RPC to set VM boot context
      virt: gunyah: Allow userspace to initialize context of primary vCPU
      virt: gunyah: Add hypercalls for sending doorbell
      virt: gunyah: Add irqfd interface
      virt: gunyah: Add IO handlers
      virt: gunyah: Add ioeventfd
      MAINTAINERS: Add Gunyah hypervisor drivers section

 .../bindings/firmware/gunyah-hypervisor.yaml       |  82 ++
 Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
 Documentation/virt/gunyah/index.rst                | 135 +++
 Documentation/virt/gunyah/message-queue.rst        |  68 ++
 Documentation/virt/index.rst                       |   1 +
 MAINTAINERS                                        |  12 +
 arch/arm64/Kbuild                                  |   1 +
 arch/arm64/gunyah/Makefile                         |   3 +
 arch/arm64/gunyah/gunyah_hypercall.c               | 279 ++++++
 arch/arm64/include/asm/gunyah.h                    |  57 ++
 arch/arm64/mm/pageattr.c                           |   3 +
 drivers/virt/Kconfig                               |   2 +
 drivers/virt/Makefile                              |   1 +
 drivers/virt/gunyah/Kconfig                        |  47 +
 drivers/virt/gunyah/Makefile                       |   9 +
 drivers/virt/gunyah/guest_memfd.c                  | 987 ++++++++++++++++++++
 drivers/virt/gunyah/gunyah.c                       |  52 ++
 drivers/virt/gunyah/gunyah_ioeventfd.c             | 139 +++
 drivers/virt/gunyah/gunyah_irqfd.c                 | 187 ++++
 drivers/virt/gunyah/gunyah_platform_hooks.c        | 117 +++
 drivers/virt/gunyah/gunyah_qcom.c                  | 220 +++++
 drivers/virt/gunyah/gunyah_vcpu.c                  | 590 ++++++++++++
 drivers/virt/gunyah/rsc_mgr.c                      | 836 +++++++++++++++++
 drivers/virt/gunyah/rsc_mgr.h                      | 144 +++
 drivers/virt/gunyah/rsc_mgr_rpc.c                  | 602 +++++++++++++
 drivers/virt/gunyah/vm_mgr.c                       | 993 +++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h                       | 215 +++++
 drivers/virt/gunyah/vm_mgr_mem.c                   | 356 ++++++++
 include/linux/gunyah.h                             | 483 ++++++++++
 include/uapi/linux/gunyah.h                        | 378 ++++++++
 mm/interval_tree.c                                 |   3 +
 31 files changed, 7003 insertions(+)
---
base-commit: ffd2cb6b718e189e7e2d5d0c19c25611f92e061a
change-id: 20231208-gunyah-952aca7668e0

Best regards,
-- 
Elliot Berman <quic_eberman@quicinc.com>


