Return-Path: <linux-kernel+bounces-77496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8708860662
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F3EB21BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EA5224FB;
	Thu, 22 Feb 2024 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pEK+4GzJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41D21864A;
	Thu, 22 Feb 2024 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643822; cv=none; b=nasp6M4fk0HNlEK7pTIsujArcL2zrsGDFB3mqk4hDvM5ty3kZzNegBAlmK2gZAm5P0K0fyxZHFlmw0ZclaOGnP3A5SsXE/0nmy1IkKckyDnKM9eSNggp61vCOzpvno2wmg6h+WjagpRwTKQYpCnr9Mvc2KzBrsXf2PQPRZi4FB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643822; c=relaxed/simple;
	bh=kZLNOeOQ8cyypDHvnRAYU5cpknSgj65yTR79TeO4b3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nlGWmmjwVLuWuHgVShEB+4oWAn2wZNhDFWfRSnmxsJwnFWLsb0DHeP0rZRaK9viLL+U776Sl7FyCnPsBgL5OTDWY+ih2CcBAXtykbjrXPEX631omyNAOsPCd50j6a8Dvax/9aOlIV6zO9C5uNlXcjueyK+gwfR/puNSVebxOniU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pEK+4GzJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MMsXqN014811;
	Thu, 22 Feb 2024 23:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=v5Cp82ySxfsN2PrtsAgumsLlaAyDJCQKtLBCPd8HpWo
	=; b=pEK+4GzJjBQCK1sErKzRh7OLQuAogVY+p6WN4Km6+u75gRxEx9UJM4qNrLk
	5/8AqGxnHg7SSj9OdW7OtHLMoN6rESW8+Z89ZGEwySnq5Qv5FSTIBfEYnLD0zekY
	t7Au7W153WR1tasbqCYD7mt8YJj9ugVT8nD13JWj2DKzGiLsqDFTXKDV23q9slCO
	fpIvOZEHVH2jd0ISgHEkO+d7SE719bZImnmg6UNeUZmCJY954DGCfloL8Vgd/pe9
	ApoPCT5tCImClxpisa6El0tXqHpQPQ+epAaW8xz/sSZIcWQJnt3UUSwMitHW/QrX
	YITsFwLPbBZFCfUp+u92W9PJJ8g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdw13afve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:29 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGROA027655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:28 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:27 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:24 -0800
Subject: [PATCH v17 01/35] docs: gunyah: Introduce Gunyah Hypervisor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-1-1e9da6763d38@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
In-Reply-To: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
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
	<quic_eberman@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BmKGDWF2HL3902ISFPTZtRcFZK3Q9KrT
X-Proofpoint-GUID: BmKGDWF2HL3902ISFPTZtRcFZK3Q9KrT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402220179

Gunyah is an open-source Type-1 hypervisor developed by Qualcomm. It
does not depend on any lower-privileged OS/kernel code for its core
functionality. This increases its security and can support a smaller
trusted computing based when compared to Type-2 hypervisors.

Add documentation describing the Gunyah hypervisor and the main
components of the Gunyah hypervisor which are of interest to Linux
virtualization development.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/index.rst         | 135 ++++++++++++++++++++++++++++
 Documentation/virt/gunyah/message-queue.rst |  68 ++++++++++++++
 Documentation/virt/index.rst                |   1 +
 3 files changed, 204 insertions(+)

diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
new file mode 100644
index 0000000000000..fba2c7a11d0f8
--- /dev/null
+++ b/Documentation/virt/gunyah/index.rst
@@ -0,0 +1,135 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Gunyah Hypervisor
+=================
+
+.. toctree::
+   :maxdepth: 1
+
+   message-queue
+
+Gunyah is a Type-1 hypervisor which is independent of any OS kernel, and runs in
+a more privileged CPU level (EL2 on Aarch64). It does not depend on a less
+privileged operating system for its core functionality. This increases its
+security and can support a much smaller trusted computing base than a Type-2
+hypervisor.
+
+Gunyah is an open source hypervisor. The source repository is available at
+https://github.com/quic/gunyah-hypervisor.
+
+Gunyah provides these following features.
+
+- Scheduling:
+
+  A scheduler for virtual CPUs (vCPUs) on physical CPUs enables time-sharing
+  of the CPUs. Gunyah supports two models of scheduling which can coexist on
+  a running system:
+
+    1. Hypervisor vCPU scheduling in which Gunyah hypervisor schedules vCPUS on
+       its own. The default is a real-time priority with round-robin scheduler.
+    2. "Proxy" scheduling in which an owner-VM can donate the remainder of its
+       own vCPU's time slice to an owned-VM's vCPU via a hypercall.
+
+- Memory Management:
+
+  APIs handling memory, abstracted as objects, limiting direct use of physical
+  addresses. Memory ownership and usage tracking of all memory under its control.
+  Memory partitioning between VMs is a fundamental security feature.
+
+- Interrupt Virtualization:
+
+  Interrupt ownership is tracked and interrupt delivery is directly to the
+  assigned VM. Gunyah makes use of hardware interrupt virtualization where
+  possible.
+
+- Inter-VM Communication:
+
+  There are several different mechanisms provided for communicating between VMs.
+
+    1. Message queues
+    2. Doorbells
+    3. Virtio MMIO transport
+    4. Shared memory
+
+- Virtual platform:
+
+  Architectural devices such as interrupt controllers and CPU timers are
+  directly provided by the hypervisor as well as core virtual platform devices
+  and system APIs such as ARM PSCI.
+
+- Device Virtualization:
+
+  Para-virtualization of devices is supported using inter-VM communication and
+  virtio transport support. Select stage 2 faults by virtual machines that use
+  proxy-scheduled vCPUs can be handled directly by Linux to provide Type-2
+  hypervisor style on-demand paging and/or device emulation.
+
+Architectures supported
+=======================
+AArch64 with a GICv3 or GICv4.1
+
+Resources and Capabilities
+==========================
+
+Services/resources provided by the Gunyah hypervisor are accessible to a
+virtual machine through capabilities. A capability is an access control
+token granting the holder a set of permissions to operate on a specific
+hypervisor object (conceptually similar to a file-descriptor).
+For example, inter-VM communication using Gunyah doorbells and message queues
+is performed using hypercalls taking Capability ID arguments for the required
+IPC objects. These resources are described in Linux as a struct gunyah_resource.
+
+Unlike UNIX file descriptors, there is no path-based or similar lookup of
+an object to create a new Capability, meaning simpler security analysis.
+Creation of a new Capability requires the holding of a set of privileged
+Capabilities which are typically never given out by the Resource Manager (RM).
+
+Gunyah itself provides no APIs for Capability ID discovery. Enumeration of
+Capability IDs is provided by RM as a higher level service to VMs.
+
+Resource Manager
+================
+
+The Gunyah Resource Manager (RM) is a privileged application VM supporting the
+Gunyah Hypervisor. It provides policy enforcement aspects of the virtualization
+system. The resource manager can be treated as an extension of the Hypervisor
+but is separated to its own partition to ensure that the hypervisor layer itself
+remains small and secure and to maintain a separation of policy and mechanism in
+the platform. The resource manager runs at arm64 NS-EL1, similar to other
+virtual machines.
+
+Communication with the resource manager from other virtual machines happens as
+described in message-queue.rst. Details about the specific messages can be found
+in drivers/virt/gunyah/rsc_mgr.c
+
+::
+
+  +-------+   +--------+   +--------+
+  |  RM   |   |  VM_A  |   |  VM_B  |
+  +-.-.-.-+   +---.----+   +---.----+
+    | |           |            |
+  +-.-.-----------.------------.----+
+  | | \==========/             |    |
+  |  \========================/     |
+  |            Gunyah               |
+  +---------------------------------+
+
+The source for the resource manager is available at
+https://github.com/quic/gunyah-resource-manager.
+
+The resource manager provides the following features:
+
+- VM lifecycle management: allocating a VM, starting VMs, destruction of VMs
+- VM access control policy, including memory sharing and lending
+- Interrupt routing configuration
+- Forwarding of system-level events (e.g. VM shutdown) to owner VM
+- Resource (capability) discovery
+
+A VM requires boot configuration to establish communication with the resource
+manager. This is provided to VMs via a 'hypervisor' device tree node which is
+overlaid to the VMs DT by the RM. This node lets guests know they are running
+as a Gunyah guest VM, how to communicate with resource manager, and basic
+description and capabilities of this VM. See
+Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml for a
+description of this node.
diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
new file mode 100644
index 0000000000000..96864708f442e
--- /dev/null
+++ b/Documentation/virt/gunyah/message-queue.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Message Queues
+==============
+Message queue is a simple low-capacity IPC channel between two virtual machines.
+It is intended for sending small control and configuration messages. Each
+message queue is unidirectional and buffered in the hypervisor. A full-duplex
+IPC channel requires a pair of queues.
+
+The size of the queue and the maximum size of the message that can be passed is
+fixed at creation of the message queue. Resource manager is presently the only
+use case for message queues, and creates messages queues between itself and VMs
+with a fixed maximum message size of 240 bytes. Longer messages require a
+further protocol on top of the message queue messages themselves. For instance,
+communication with the resource manager adds a header field for sending longer
+messages which are split into smaller fragments.
+
+The diagram below shows how message queue works. A typical configuration
+involves 2 message queues. Message queue 1 allows VM_A to send messages to VM_B.
+Message queue 2 allows VM_B to send messages to VM_A.
+
+1. VM_A sends a message of up to 240 bytes in length. It makes a hypercall
+   with the message to request the hypervisor to add the message to
+   message queue 1's queue. The hypervisor copies memory into the internal
+   message queue buffer; the memory doesn't need to be shared between
+   VM_A and VM_B.
+
+2. Gunyah raises the corresponding interrupt for VM_B (Rx vIRQ) when any of
+   these happens:
+
+   a. gunyah_msgq_send() has PUSH flag. This is a typical case when the message
+      queue is being used to implement an RPC-like interface.
+   b. Explicitly with gunyah_msgq_push hypercall from VM_A.
+   c. Message queue has reached a threshold depth. Typically, this threshold
+      depth is the size of the queue (in other words: when queue is full, Rx
+      vIRQ is raised).
+
+3. VM_B calls gunyah_msgq_recv() and Gunyah copies message to requested buffer.
+
+4. Gunyah raises the corresponding interrupt for VM_A (Tx vIRQ) when the message
+   queue falls below a watermark depth. Typically, this is when the queue is
+   drained. Note the watermark depth and the threshold depth for the Rx vIRQ are
+   independent values. Coincidentally, this signal is conceptually similar to
+   Clear-to-Send.
+
+For VM_B to send a message to VM_A, the process is identical, except that
+hypercalls reference message queue 2's capability ID. The IRQ will be different
+for the second message queue.
+
+::
+
+      +-------------------+         +-----------------+         +-------------------+
+      |        VM_A       |         |Gunyah hypervisor|         |        VM_B       |
+      |                   |         |                 |         |                   |
+      |                   |         |                 |         |                   |
+      |                   |   Tx    |                 |         |                   |
+      |                   |-------->|                 | Rx vIRQ |                   |
+      |gunyah_msgq_send() | Tx vIRQ |Message queue 1  |-------->|gunyah_msgq_recv() |
+      |                   |<------- |                 |         |                   |
+      |                   |         |                 |         |                   |
+      |                   |         |                 |         |                   |
+      |                   |         |                 |   Tx    |                   |
+      |                   | Rx vIRQ |                 |<--------|                   |
+      |gunyah_msgq_recv() |<--------|Message queue 2  | Tx vIRQ |gunyah_msgq_send() |
+      |                   |         |                 |-------->|                   |
+      |                   |         |                 |         |                   |
+      |                   |         |                 |         |                   |
+      +-------------------+         +-----------------+         +---------------+
diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
index 7fb55ae08598d..15869ee059b35 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -16,6 +16,7 @@ Virtualization Support
    coco/sev-guest
    coco/tdx-guest
    hyperv/index
+   gunyah/index
 
 .. only:: html and subproject
 

-- 
2.34.1


