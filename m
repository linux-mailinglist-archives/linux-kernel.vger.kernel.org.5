Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F0D7710C1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjHERFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjHERFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31754213;
        Sat,  5 Aug 2023 10:04:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28C2E60B58;
        Sat,  5 Aug 2023 17:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E3FC433C7;
        Sat,  5 Aug 2023 17:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691255083;
        bh=KZwDH4cX9T6AR/DnDa9TV9uUhNgFrBvkHFVPfCIx90Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLBJ2QgAUWENSI4Mq4JuAMpb4wZZF3CxKUjao5jYhyEZNje3XJvz0DysQT7KiQt8K
         4/G3XfF/dL0a4MZE1dIeDCd6lzwbPmmePcWIE1EtK4x7GlZvxcOWfW2gLdxVhNovDa
         0pLVNLrt/JPjTx2PSKSUg/CYttQyZA/o+HsBEBxVV27ZCnusqjEO9IPcxnJ2QiRQ29
         N/kU21Lz7TMTHzFt9cC15EjeEJhCE0tb3O7ezvA62TYe+KY7Lndf/Qcm46XH2HieuN
         HLV1E7EdGZIPnWZ7dKvnCfGbPxRDdsuV8tdnVL6KxjsLGJpxBDejUStVNiuAHTYaMO
         KdVKcsjijuO+w==
Date:   Sat, 5 Aug 2023 10:07:40 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v14 01/25] docs: gunyah: Introduce Gunyah Hypervisor
Message-ID: <v43in3gy7hgxmev3ttxx7whaoczppmpnzzdvdyk5eeohq3nhwx@2shpc57fy5b3>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-2-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613172054.3959700-2-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:20:29AM -0700, Elliot Berman wrote:
> Gunyah is an open-source Type-1 hypervisor developed by Qualcomm. It
> does not depend on any lower-privileged OS/kernel code for its core
> functionality. This increases its security and can support a smaller
> trusted computing based when compared to Type-2 hypervisors.
> 
> Add documentation describing the Gunyah hypervisor and the main
> components of the Gunyah hypervisor which are of interest to Linux
> virtualization development.
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  Documentation/virt/gunyah/index.rst         | 113 ++++++++++++++++++++
>  Documentation/virt/gunyah/message-queue.rst |  63 +++++++++++
>  Documentation/virt/index.rst                |   1 +
>  3 files changed, 177 insertions(+)
>  create mode 100644 Documentation/virt/gunyah/index.rst
>  create mode 100644 Documentation/virt/gunyah/message-queue.rst
> 
> diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
> new file mode 100644
> index 0000000000000..74aa345e0a144
> --- /dev/null
> +++ b/Documentation/virt/gunyah/index.rst
> @@ -0,0 +1,113 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +Gunyah Hypervisor
> +=================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   message-queue
> +
> +Gunyah is a Type-1 hypervisor which is independent of any OS kernel, and runs in
> +a higher CPU privilege level. It does not depend on any lower-privileged operating system
> +for its core functionality. This increases its security and can support a much smaller
> +trusted computing base than a Type-2 hypervisor.

Wrap your lines at 80 characters please.

> +
> +Gunyah is an open source hypervisor. The source repo is available at
> +https://github.com/quic/gunyah-hypervisor.
> +
> +Gunyah provides these following features.
> +
> +- Scheduling:
> +
> +  A scheduler for virtual CPUs (vCPUs) on physical CPUs enables time-sharing
> +  of the CPUs. Gunyah supports two models of scheduling:
> +
> +    1. "Behind the back" scheduling in which Gunyah hypervisor schedules vCPUS on its own.
> +    2. "Proxy" scheduling in which a delegated VM can donate part of one of its vCPU slice
> +       to another VM's vCPU via a hypercall.
> +
> +- Memory Management:
> +
> +  APIs handling memory, abstracted as objects, limiting direct use of physical
> +  addresses. Memory ownership and usage tracking of all memory under its control.
> +  Memory partitioning between VMs is a fundamental security feature.
> +
> +- Interrupt Virtualization:
> +
> +  Uses CPU hardware interrupt virtualization capabilities. Interrupts are handled
> +  in the hypervisor and routed to the assigned VM.
> +
> +- Inter-VM Communication:
> +
> +  There are several different mechanisms provided for communicating between VMs.
> +
> +- Virtual platform:
> +
> +  Architectural devices such as interrupt controllers and CPU timers are directly provided
> +  by the hypervisor as well as core virtual platform devices and system APIs such as ARM PSCI.
> +
> +- Device Virtualization:
> +
> +  Para-virtualization of devices is supported using inter-VM communication.
> +
> +Architectures supported
> +=======================
> +AArch64 with a GIC
> +
> +Resources and Capabilities
> +==========================
> +
> +Some services or resources provided by the Gunyah hypervisor are described to a virtual machine by

To my understanding neither resources, nor services are "described", but
rather "exposed through capability IDs"

Is it really "some services or resource", isn't everything in Gunyah
exposed to the VMs as a capability?

> +capability IDs. For instance, inter-VM communication is performed with doorbells and message queues.
> +Gunyah allows access to manipulate that doorbell via the capability ID. These resources are

s/manipulate/interact with/ ?

> +described in Linux as a struct gh_resource.
> +
> +High level management of these resources is performed by the resource manager VM. RM informs a
> +guest VM about resources it can access through either the device tree or via guest-initiated RPC.
> +
> +For each virtual machine, Gunyah maintains a table of resources which can be accessed by that VM.
> +An entry in this table is called a "capability" and VMs can only access resources via this
> +capability table. Hence, virtual Gunyah resources are referenced by a "capability IDs" and not
> +"resource IDs". If 2 VMs have access to the same resource, they might not be using the same
> +capability ID to access that resource since the capability tables are independent per VM.

I think you can rewrite this section more succinctly by saying that Gunyah
handles resources, which are selectively exposed to each VM through
VM-specific capability ids.

> +
> +Resource Manager
> +================
> +
> +The resource manager (RM) is a privileged application VM supporting the Gunyah Hypervisor.
> +It provides policy enforcement aspects of the virtualization system. The resource manager can
> +be treated as an extension of the Hypervisor but is separated to its own partition to ensure
> +that the hypervisor layer itself remains small and secure and to maintain a separation of policy
> +and mechanism in the platform. RM runs at arm64 NS-EL1 similar to other virtual machines.

s/RM/The resource manager/ and a ',' after EL1, please.

> +
> +Communication with the resource manager from each guest VM happens with message-queue.rst. Details

s/each guest VM/other VMs/ or perhaps even spell out virtual machines.

> +about the specific messages can be found in drivers/virt/gunyah/rsc_mgr.c
> +
> +::
> +
> +  +-------+   +--------+   +--------+
> +  |  RM   |   |  VM_A  |   |  VM_B  |
> +  +-.-.-.-+   +---.----+   +---.----+
> +    | |           |            |
> +  +-.-.-----------.------------.----+
> +  | | \==========/             |    |
> +  |  \========================/     |
> +  |            Gunyah               |
> +  +---------------------------------+
> +
> +The source for the resource manager is available at https://github.com/quic/gunyah-resource-manager.
> +
> +The resource manager provides the following features:
> +
> +- VM lifecycle management: allocating a VM, starting VMs, destruction of VMs
> +- VM access control policy, including memory sharing and lending
> +- Interrupt routing configuration
> +- Forwarding of system-level events (e.g. VM shutdown) to owner VM
> +
> +When booting a virtual machine which uses a devicetree such as Linux, resource manager overlays a

You can omit "such as Linux" without loosing information. Also, "the
resource manager".

> +/hypervisor node. This node can let Linux know it is running as a Gunyah guest VM,

"can"? Looking at the implementation that doesn't seem to be how you
detect that you're running under Gunyah.

> +how to communicate with resource manager, and basic description and capabilities of

When it comes to RM, it doesn't seem to be "can" anymore. Here it _is_
the way you inform the OS about how to communicate with the resource
manager.

> +this VM. See Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml for a description
> +of this node.
> diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
> new file mode 100644
> index 0000000000000..b352918ae54b4
> --- /dev/null
> +++ b/Documentation/virt/gunyah/message-queue.rst
> @@ -0,0 +1,63 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Message Queues
> +==============
> +Message queue is a simple low-capacity IPC channel between two VMs. It is

s/VMs/virtual machines/

> +intended for sending small control and configuration messages. Each message
> +queue is unidirectional, so a full-duplex IPC channel requires a pair of queues.
> +
> +Messages can be up to 240 bytes in length. Longer messages require a further
> +protocol on top of the message queue messages themselves. For instance, communication
> +with the resource manager adds a header field for sending longer messages via multiple
> +message fragments.
> +
> +The diagram below shows how message queue works. A typical configuration involves
> +2 message queues. Message queue 1 allows VM_A to send messages to VM_B. Message
> +queue 2 allows VM_B to send messages to VM_A.

What is described below all relates to one message queue, I think it
would be clearer if you remove the second message queue from the example
below and simply state that each direction need its own queue (as you
do here).

> +
> +1. VM_A sends a message of up to 240 bytes in length. It raises a hypercall
> +   with the message to inform the hypervisor to add the message to
> +   message queue 1's queue. The hypervisor copies memory into the internal
> +   message queue representation; the memory doesn't need to be shared between
> +   VM_A and VM_B.
> +
> +2. Gunyah raises the corresponding interrupt for VM_B (Rx vIRQ) when any of
> +   these happens:
> +
> +   a. gh_msgq_send() has PUSH flag. Queue is immediately flushed. This is the typical case.

Funny when the description of the unusual word "push" directly grabs the
word "flush" which everyone understands the meaning of. But I guess this
is Gunyah nomenclature.

On the other hand, if you consider the PUSH flag to just mean "push a RX
interrupt", then the naming isn't so strange. But it wouldn't
necessarily imply that "the queue is flushed", it's simply raising the
rx irq for the receiving side to drain the queue - at it's own pace.

I wouldn't be surprised to see that pushed messages denotes the "typical
case", but I don't think it's relevant details for the rx irq
description.


> +   b. Explicility with gh_msgq_push command from VM_A.

There's no function named gh_msgq_send(), and the gh_msgq_push is
lacking parenthesis. Please refer to these consistently with references
to functions, or perhaps capitalize them to refer to the hypercall?

> +   c. Message queue has reached a threshold depth.
> +
> +3. VM_B calls gh_msgq_recv() and Gunyah copies message to requested buffer.

s/requested/a provided/

> +
> +4. Gunyah buffers messages in the queue. If the queue became full when VM_A added a message,

s/the/a/

> +   the return values for gh_msgq_send() include a flag that indicates the queue is full.
> +   Once VM_B receives the message and, thus, there is space in the queue, Gunyah

"Once messages are drained from the queue, Gunyah will raise the..."

> +   will raise the Tx vIRQ on VM_A to indicate it can continue sending messages.
> +
> +For VM_B to send a message to VM_A, the process is identical, except that hypercalls
> +reference message queue 2's capability ID. Each message queue has its own independent
> +vIRQ: two TX message queues will have two vIRQs (and two capability IDs).
> +
> +::
> +
> +      +---------------+         +-----------------+         +---------------+
> +      |      VM_A     |         |Gunyah hypervisor|         |      VM_B     |
> +      |               |         |                 |         |               |
> +      |               |         |                 |         |               |
> +      |               |   Tx    |                 |         |               |
> +      |               |-------->|                 | Rx vIRQ |               |
> +      |gh_msgq_send() | Tx vIRQ |Message queue 1  |-------->|gh_msgq_recv() |
> +      |               |<------- |                 |         |               |
> +      |               |         |                 |         |               |
> +      | Message Queue |         |                 |         | Message Queue |
> +      | driver        |         |                 |         | driver        |
> +      |               |         |                 |         |               |
> +      |               |         |                 |         |               |
> +      |               |         |                 |   Tx    |               |
> +      |               | Rx vIRQ |                 |<--------|               |
> +      |gh_msgq_recv() |<--------|Message queue 2  | Tx vIRQ |gh_msgq_send() |
> +      |               |         |                 |-------->|               |
> +      |               |         |                 |         |               |
> +      |               |         |                 |         |               |
> +      +---------------+         +-----------------+         +---------------+
> diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
> index 7fb55ae08598d..15869ee059b35 100644
> --- a/Documentation/virt/index.rst
> +++ b/Documentation/virt/index.rst
> @@ -16,6 +16,7 @@ Virtualization Support
>     coco/sev-guest
>     coco/tdx-guest
>     hyperv/index
> +   gunyah/index

'g' < 'h'

Regards,
Bjorn
