Return-Path: <linux-kernel+bounces-1873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D808815513
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D15282552
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288896FAA;
	Sat, 16 Dec 2023 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qtu6pkZ7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E11C38;
	Sat, 16 Dec 2023 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFNTBdt030894;
	Sat, 16 Dec 2023 00:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=jJkNpJRL7neQYiQYByTs6pHgdXtbYBZe+qazKy/T5cY
	=; b=Qtu6pkZ7K9L02b1XhF6cSfa7SGpz8W4JyLCTM06ODBU9+ifB90RJCKImt99
	wTz4gEj55tr84sK1wav/ZnXeljQHI//IGhMsbpcaO0w53qh6EpHQCY3yJu9uxN1T
	Dfav75HJxS0DT5lMVjKoApbevGmtQLz1DkZ7EwtcZS0PxaRqy7oAsXlK+9J8de9C
	VU+T0B3hZ7JJhPF6lQnpbKVGErbf7U20Igmw+fDocWKHmGBeEISN5krbwJrgzmvS
	Cb1nYLm98PJAjpPtylKqEin7NbBy5I00YZVPgau1QGvszH0PPgnT+4ugEukB4c1t
	FJgp7ukjv4XsdT2gaIqllUN2TiQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0hb02g6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0L1p0015403
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:01 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:00 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:20:42 -0800
Subject: [PATCH RFC v15 01/30] docs: gunyah: Introduce Gunyah Hypervisor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-1-192a5d872a30@quicinc.com>
References: <20231215-gunyah-v15-0-192a5d872a30@quicinc.com>
In-Reply-To: <20231215-gunyah-v15-0-192a5d872a30@quicinc.com>
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
        Bagas Sanjaya <bagasdotme@gmail.com>
X-Mailer: b4 0.13-dev
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S5I5G5ENmKdxv0-QTcb4uoK6CKOVLNQJ
X-Proofpoint-GUID: S5I5G5ENmKdxv0-QTcb4uoK6CKOVLNQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 spamscore=0 mlxlogscore=952
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160000

Gunyah is an open-source Type-1 hypervisor developed by Qualcomm. It
does not depend on any lower-privileged OS/kernel code for its core
functionality. This increases its security and can support a smaller
trusted computing based when compared to Type-2 hypervisors.

Add documentation describing the Gunyah hypervisor and the main
components of the Gunyah hypervisor which are of interest to Linux
virtualization development.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/index.rst         | 121 ++++++++++++++++++++++++++++
 Documentation/virt/gunyah/message-queue.rst |  69 ++++++++++++++++
 Documentation/virt/index.rst                |   1 +
 3 files changed, 191 insertions(+)

diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
new file mode 100644
index 000000000000..fe3f4192b836
--- /dev/null
+++ b/Documentation/virt/gunyah/index.rst
@@ -0,0 +1,121 @@
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
+a higher CPU privilege level. It does not depend on any lower-privileged
+operating system for its core functionality. This increases its security and can
+support a much smaller trusted computing base than a Type-2 hypervisor.
+
+Gunyah is an open source hypervisor. The source repo is available at
+https://github.com/quic/gunyah-hypervisor.
+
+Gunyah provides these following features.
+
+- Scheduling:
+
+  A scheduler for virtual CPUs (vCPUs) on physical CPUs enables time-sharing
+  of the CPUs. Gunyah supports two models of scheduling:
+
+    1. "Behind the back" scheduling in which Gunyah hypervisor schedules vCPUS
+       on its own.
+    2. "Proxy" scheduling in which a delegated VM can donate part of one of its
+       vCPU slice to another VM's vCPU via a hypercall.
+
+- Memory Management:
+
+  APIs handling memory, abstracted as objects, limiting direct use of physical
+  addresses. Memory ownership and usage tracking of all memory under its control.
+  Memory partitioning between VMs is a fundamental security feature.
+
+- Interrupt Virtualization:
+
+  Uses CPU hardware interrupt virtualization capabilities. Interrupts are
+   handled in the hypervisor and routed to the assigned VM.
+
+- Inter-VM Communication:
+
+  There are several different mechanisms provided for communicating between VMs.
+
+- Virtual platform:
+
+  Architectural devices such as interrupt controllers and CPU timers are
+  directly provided by the hypervisor as well as core virtual platform devices
+  and system APIs such as ARM PSCI.
+
+- Device Virtualization:
+
+  Para-virtualization of devices is supported using inter-VM communication.
+
+Architectures supported
+=======================
+AArch64 with a GIC
+
+Resources and Capabilities
+==========================
+
+Services/resources provide by the Gunyah hypervisor are described to a
+virtual machine by capability IDs. For instance, inter-VM communication is
+performed with doorbells and message queues. Gunyah allows access to interact
+with that doorbell via the capability ID. These resources are described in Linux
+as a struct gunyah_resource.
+
+High level management of these resources is performed by the resource manager
+VM. RM informs a guest VM about resources it can access through either the
+device tree or via guest-initiated RPC.
+
+Gunyah tracks all resources and selectively makes them available to some VMs via
+VM-specific capability IDs.
+
+Resource Manager
+================
+
+The resource manager (RM) is a privileged application VM supporting the Gunyah
+Hypervisor. It provides policy enforcement aspects of the virtualization system.
+The resource manager can be treated as an extension of the Hypervisor but is
+separated to its own partition to ensure that the hypervisor layer itself
+remains small and secure and to maintain a separation of policy and mechanism in
+the platform. The resource manager runs at arm64 NS-EL1, similar to other
+virtual machines.
+
+Communication with the resource manager from other virtual machines happens with
+message-queue.rst. Details about the specific messages can be found in
+drivers/virt/gunyah/rsc_mgr.c
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
+Resource manager presently requires the guest virtual machines uses a device
+tree to describe its configuration. The resource manager applies an overlay to
+the/hypervisor node. This node lets guests know they are running as a Gunyah
+guest VM, how to communicate with resource manager, and basic description and
+capabilities of this VM. See
+Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml for a
+description of this node.
diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
new file mode 100644
index 000000000000..bd9947240c2a
--- /dev/null
+++ b/Documentation/virt/gunyah/message-queue.rst
@@ -0,0 +1,69 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Message Queues
+==============
+Message queue is a simple low-capacity IPC channel between two virtual machines.
+It is intended for sending small control and configuration messages. Each
+message queue is unidirectional, so a full-duplex IPC channel requires a pair of
+queues.
+
+Messages can be up to 240 bytes in length. Longer messages require a further
+protocol on top of the message queue messages themselves. For instance,
+communication with the resource manager adds a header field for sending longer
+messages via multiple message fragments.
+
+The diagram below shows how message queue works. A typical configuration
+involves 2 message queues. Message queue 1 allows VM_A to send messages to VM_B.
+Message queue 2 allows VM_B to send messages to VM_A.
+
+1. VM_A sends a message of up to 240 bytes in length. It raises a hypercall
+   with the message to inform the hypervisor to add the message to
+   message queue 1's queue. The hypervisor copies memory into the internal
+   message queue representation; the memory doesn't need to be shared between
+   VM_A and VM_B.
+
+2. Gunyah raises the corresponding interrupt for VM_B (Rx vIRQ) when any of
+   these happens:
+
+   a. gunyah_msgq_send() has PUSH flag. This is a typical case.
+   b. Explicility with gunyah_msgq_push command from VM_A.
+   c. Message queue has reached a threshold depth. Typically, this threshold
+      depth is the size of the queue (in other words: when queue is full, Rx
+      vIRQ raised).
+
+3. VM_B calls gunyah_msgq_recv() and Gunyah copies message to requested buffer.
+
+4. Gunyah raises the corresponding interrupt for VM_A (Tx vIRQ) when the message
+   queue falls below a watermark depth. Typically, this is the size of the queue
+   (in other words: when the queue is no longer full, Tx vIRQ raised). Note the
+   watermark depth and the threshold depth for the Rx vIRQ are independent
+   values, although they are both typically the size of the queue.
+   Coincidentally, this signal is conceptually similar to Clear-to-Send.
+
+For VM_B to send a message to VM_A, the process is identical, except that
+hypercalls reference message queue 2's capability ID. Each message queue has its
+own independent vIRQ: two TX message queues will have two vIRQs (and two
+capability IDs).
+
+::
+
+      +---------------+         +-----------------+         +---------------+
+      |      VM_A     |         |Gunyah hypervisor|         |      VM_B     |
+      |               |         |                 |         |               |
+      |               |         |                 |         |               |
+      |               |   Tx    |                 |         |               |
+      |               |-------->|                 | Rx vIRQ |               |
+      |gunyah_msgq_send() | Tx vIRQ |Message queue 1  |-------->|gunyah_msgq_recv() |
+      |               |<------- |                 |         |               |
+      |               |         |                 |         |               |
+      | Message Queue |         |                 |         | Message Queue |
+      | driver        |         |                 |         | driver        |
+      |               |         |                 |         |               |
+      |               |         |                 |         |               |
+      |               |         |                 |   Tx    |               |
+      |               | Rx vIRQ |                 |<--------|               |
+      |gunyah_msgq_recv() |<--------|Message queue 2  | Tx vIRQ |gunyah_msgq_send() |
+      |               |         |                 |-------->|               |
+      |               |         |                 |         |               |
+      |               |         |                 |         |               |
+      +---------------+         +-----------------+         +---------------+
diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
index 7fb55ae08598..15869ee059b3 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -16,6 +16,7 @@ Virtualization Support
    coco/sev-guest
    coco/tdx-guest
    hyperv/index
+   gunyah/index
 
 .. only:: html and subproject
 

-- 
2.43.0


