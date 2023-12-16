Return-Path: <linux-kernel+bounces-1875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B838F815515
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC60B22FFF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF56749B;
	Sat, 16 Dec 2023 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XPoA5V4z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6381FDA;
	Sat, 16 Dec 2023 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG0CIxv003255;
	Sat, 16 Dec 2023 00:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=yHRLEF1Q7CLaiU
	KP7iLZAAGU/XNksepOM642VrluW9I=; b=XPoA5V4z860BF1msUlpwLPiSG+1pMn
	dxx5jNTVcnb7gaZupolkjKbRvYfKRpinBBcfBF/L4rnLjlG3P126O4PWyqNNdAMr
	mnZkpfhcvePqR4GLjz6mIH7QeIZXOzzZ4Jmii7c0/pnP8ZAMCffhxefp3HzhA6gO
	SNV6kvLHSao1NX1bWjAfRkXZlV+15V+BluaBtmBUAKTvTSOmgnI3HlTKzSD/9OwZ
	ItjbD7drMFIVmdfwYuTpGa6Wz66P0vhJfErp1qJUkHyGlcE9fWcFxKcENoPlGIXz
	MNfZugiPF66SgfhydcIyLp3AbI4cMyygaguMYO6tporuLbEkR+oSSbDQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0vv9ghhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0L0Hl004285
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:00 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:20:59 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH RFC v15 00/30] Drivers for Gunyah hypervisor
Date: Fri, 15 Dec 2023 16:20:41 -0800
Message-ID: <20231215-gunyah-v15-0-192a5d872a30@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFrtfGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDE11FJSSM
 xLz0lN1M1OAAkpGBkbGhkYGFrrppXmViRm6lqZGicmJ5mZmFqkGSkDFBUWpaZkVYJOilYLcnJV
 ia2sBkji7814AAAA=
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
        Sean Christopherson <seanjc@google.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Rob Herring
	<robh@kernel.org>
X-Mailer: b4 0.13-dev
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aMoFG05f5-YAhy3FgL7XNNqFl2ehk82m
X-Proofpoint-ORIG-GUID: aMoFG05f5-YAhy3FgL7XNNqFl2ehk82m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1011 adultscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312160001

Hello all,

There is significant architecture change in the latest version to
support demand paging. Demand paging allows Linux to provide memory to
the guest when it wants -- only when guest tries to access the memory.
I wanted to post a version to collect some early feedback.

In particular, our implementation of guestmemfd is similar to KVM's
guest memfd: I'm curious to get community's thoughts on how (if at all)
to refactor both to share the common, generic bits. In particular, the
primary difference I see between KVM and Gunyah's implementation is how
we determine whether a page can be mapped to userspace, so I think there
is strong case here to share at least some of the implementation.

Also, I wanted to get any feedback if how folios are tracked for a
virtual machine seems correct: folios are initially allocated using
the filemap associated with the guest memfd. When guest tries to access
them, I use a maple tree to track folios that have been shares: the
indices are guest frame number and values are folio pointers. The
folio's ->private field is used to note whether the folio is available
to be mapped by Linux.

Some areas that still need testing/work is multi-threading and memory
reclaim while VM is running; the important bits are present in the
implementation and design, but not fully tested. The series is
capable of booting a Linux virtual machine, so while some areas aren't
finished, it is fairly complete.
-

Gunyah is a Type-1 hypervisor independent of any high-level OS kernel,
and runs in a higher CPU privilege level. It does not depend on any
lower-privileged OS kernel/code for its core functionality. This
increases its security and can support a much smaller trusted computing
base than a Type-2 hypervisor. Gunyah is designed for isolated virtual
machine use cases and to support launching trusted+isolated virtual
machines from a relatively less trusted host virtual machine.

Gunyah is an open source hypervisor. The source repo is available at
https://github.com/quic/gunyah-hypervisor.

The diagram below shows the architecture.

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
  memory under its control. Memory partitioning between VMs is a
  fundamental security feature.
- Interrupt Virtualization: All interrupts are handled in the hypervisor
   and routed to the assigned VM.
- Inter-VM Communication: There are several different mechanisms
  provided for communicating between VMs.
- Device Virtualization: Para-virtualization of devices is supported
  using inter-VM communication. Low level system features and devices such
  as interrupt controllers are supported with emulation where required.

This series adds the basic framework for detecting that Linux is running
under Gunyah as a virtual machine, communication with the Gunyah
Resource Manager, and a sample virtual machine manager capable of
launching virtual machines.

Changes in v15:
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
Elliot Berman (30):
      docs: gunyah: Introduce Gunyah Hypervisor
      dt-bindings: Add binding for gunyah hypervisor
      gunyah: Common types and error codes for Gunyah hypercalls
      virt: gunyah: Add hypercalls to identify Gunyah
      virt: gunyah: Add hypervisor driver
      virt: gunyah: msgq: Add hypercalls to send and receive messages
      gunyah: rsc_mgr: Add resource manager RPC core
      gunyah: rsc_mgr: Add VM lifecycle RPC
      gunyah: vm_mgr: Introduce basic VM Manager
      gunyah: vm_mgr: Add ioctls to support basic non-proxy VM boot
      gunyah: vm_mgr: Add framework for VM Functions
      virt: gunyah: Translate gh_rm_hyp_resource into gunyah_resource
      virt: gunyah: Add resource tickets
      virt: gunyah: Add IO handlers
      gunyah: Add hypercalls for demand paging
      virt: gunyah: Add interfaces to map memory into guest address space
      gunyah: rsc_mgr: Add platform ops on mem_lend/mem_reclaim
      virt: gunyah: Add IO handlers
      virt: gunyah: Add proxy-scheduled vCPUs
      virt: gunyah: Implement guestmemfd
      virt: gunyah: Add ioctl to bind guestmem to VMs
      virt: gunyah: guestmem: Initialize RM mem parcels from guestmem
      virt: gunyah: Allow userspace to initialize context of primary vCPU
      virt: gunyah: Share guest VM dtb configuration to Gunyah
      virt: gunyah: Enable demand paging
      virt: gunyah: Add Qualcomm Gunyah platform ops
      virt: gunyah: Add hypercalls for sending doorbell
      virt: gunyah: Add irqfd interface
      virt: gunyah: Add ioeventfd
      MAINTAINERS: Add Gunyah hypervisor drivers section

 .../bindings/firmware/gunyah-hypervisor.yaml       |  82 ++
 Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
 Documentation/virt/gunyah/index.rst                | 121 +++
 Documentation/virt/gunyah/message-queue.rst        |  69 ++
 Documentation/virt/index.rst                       |   1 +
 MAINTAINERS                                        |  13 +
 arch/arm64/Kbuild                                  |   1 +
 arch/arm64/gunyah/Makefile                         |   3 +
 arch/arm64/gunyah/gunyah_hypercall.c               | 209 +++++
 arch/arm64/include/asm/gunyah.h                    |  57 ++
 drivers/virt/Kconfig                               |   2 +
 drivers/virt/Makefile                              |   1 +
 drivers/virt/gunyah/Kconfig                        |  47 +
 drivers/virt/gunyah/Makefile                       |   9 +
 drivers/virt/gunyah/guest_memfd.c                  | 826 ++++++++++++++++++
 drivers/virt/gunyah/gunyah.c                       |  52 ++
 drivers/virt/gunyah/gunyah_ioeventfd.c             | 132 +++
 drivers/virt/gunyah/gunyah_irqfd.c                 | 191 ++++
 drivers/virt/gunyah/gunyah_platform_hooks.c        | 115 +++
 drivers/virt/gunyah/gunyah_qcom.c                  | 218 +++++
 drivers/virt/gunyah/gunyah_vcpu.c                  | 579 +++++++++++++
 drivers/virt/gunyah/rsc_mgr.c                      | 948 ++++++++++++++++++++
 drivers/virt/gunyah/rsc_mgr.h                      |  28 +
 drivers/virt/gunyah/rsc_mgr_rpc.c                  | 584 +++++++++++++
 drivers/virt/gunyah/vm_mgr.c                       | 963 +++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h                       | 104 +++
 drivers/virt/gunyah/vm_mgr_mem.c                   | 326 +++++++
 include/linux/gunyah.h                             | 250 ++++++
 include/linux/gunyah_rsc_mgr.h                     | 208 +++++
 include/linux/gunyah_vm_mgr.h                      | 165 ++++
 include/uapi/linux/gunyah.h                        | 378 ++++++++
 31 files changed, 6683 insertions(+)
---
base-commit: 17cb8a20bde66a520a2ca7aad1063e1ce7382240
change-id: 20231208-gunyah-952aca7668e0

Best regards,
-- 
Elliot Berman <quic_eberman@quicinc.com>


