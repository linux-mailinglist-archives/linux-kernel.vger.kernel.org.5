Return-Path: <linux-kernel+bounces-117324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8A888AA03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CE71F683CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD6713BC2D;
	Mon, 25 Mar 2024 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rO1guDMr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65B61386AA;
	Mon, 25 Mar 2024 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379172; cv=none; b=kDqqkEnKc9INdCexLPLd5FMwKSnkCwaqApoWZBIpugbZAdd60/PYs/KZelOSIrejsH35EF5mSEpAHAPkizQH1gGvOFe7/u8C3vh9bCSVYB7iuDnjnj+DXNSk5IrnyMwxZdWZeANbev7cPuaKxenu2eF3lesRLEEbVpyd1Cg/6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379172; c=relaxed/simple;
	bh=XzL2EPuo80gTaTjOKJ5O1h54N1xpp8OnrwD3hF9mTqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz9d7ePcx0IiEj3f+E30KgG3624rtBDqgCIEc0jNLSkwNFzrIui40+Eei/AcTS9b1G1TAYVJMQPa0IHJmofXh755JVKrWpVQLGE4dkSc0aHzlR29RjTeRHD2fGrh66PMqkx0BCZJbv+v7UnWpC7grdQOkyLEtQM8yj9YdFiRvCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rO1guDMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12377C433C7;
	Mon, 25 Mar 2024 15:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711379172;
	bh=XzL2EPuo80gTaTjOKJ5O1h54N1xpp8OnrwD3hF9mTqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rO1guDMrW0qeIRhrGSgOb2PIA2ign9tsPDLC8TgculSQ547kJuyGrJ4KLf5jS2oBN
	 XFn2+KjZfbhtXUBT7AYgpc9yxTavVD0n3Lyelis2VDyKR0n1cKJnE/3xTwNWxblySr
	 F53oUzvq6DB0mD1YYd23Vo0U95GryW7VVnpNnwgh0meJ+cfVTMYNi7TFFTzU+OUaJ4
	 pX9gWryDlu9+TqBxeJ9blSxTdr7zliUshZKPBH5Ikq8Qm6FyHwZKgTqeOrB6xJZXQL
	 Od8FxVsnQ0edqAZYiIfKs9EMM2yYSWT0HT3wz7+SO6Vklx2XfA44eu9X5bwwihlkM1
	 cDoHrm1jIMpxw==
Date: Mon, 25 Mar 2024 10:06:09 -0500
From: Rob Herring <robh@kernel.org>
To: Sudan Landge <sudanl@amazon.com>
Cc: tytso@mit.edu, Jason@zx2c4.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	thomas.lendacky@amd.com, dan.j.williams@intel.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	graf@amazon.de, dwmw@amazon.co.uk, bchalios@amazon.es,
	xmarcalx@amazon.co.uk
Subject: Re: [PATCH v2 3/4] dt-bindings: rng: Add vmgenid support
Message-ID: <20240325150609.GA3477574-robh@kernel.org>
References: <20240321025105.53210-1-sudanl@amazon.com>
 <20240321025105.53210-4-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321025105.53210-4-sudanl@amazon.com>

On Thu, Mar 21, 2024 at 02:51:04AM +0000, Sudan Landge wrote:
> Virtual Machine Generation ID driver was introduced in commit af6b54e2b5ba
> ("virt: vmgenid: notify RNG of VM fork and supply generation ID"), as an
> ACPI only device.
> 
> VMGenID specification http://go.microsoft.com/fwlink/?LinkId=260709 defines
> a mechanism for the BIOS/hypervisors to communicate to the virtual machine
> that it is executed with a different configuration (e.g. snapshot execution
> or creation from a template).
> The guest operating system can use the notification for various purposes
> such as re-initializing its random number generator etc.
> 
> As per the specs, hypervisor should provide a globally unique identified,
> or GUID via ACPI.
> 
> This patch tries to mimic the mechanism to provide the same functionality
> which is for a hypervisor/BIOS to notify the virtual machine when it is
> executed with a different configuration.
> 
> As part of this support the devicetree bindings requires the hypervisors or
> BIOS to provide a memory address which holds the GUID and an IRQ which is
> used to notify when there is a change in the GUID.
> The memory exposed in the DT should follow the rules defined in the
> vmgenid spec mentioned above.
> 
> *Reason for this change*:
> Chosing ACPI or devicetree is an intrinsic part of an hypervisor design.
> Without going into details of why a hypervisor would chose DT over ACPI,
> we would like to highlight that the hypervisors that have chose devicetree
> and now want to make use of the vmgenid functionality cannot do so today
> because vmgenid is an ACPI only device.
> This forces these hypervisors to change their design which could have
> undesirable impacts on their use-cases, test-scenarios etc.
> 
> The point of vmgenid is to provide a mechanism to discover a GUID when
> the execution state of a virtual machine changes and the simplest
> way to do it is pass a memory location and an interrupt via devicetree.
> It would complicate things unnecessarily if instead of using devicetree,
> we try to implement a new protocol or modify other protocols to somehow
> provide the same functionility.
> 
> We believe that adding a devicetree binding for vmgenid is a simpler,
> better alternative to provide the same functionality and will allow
> such hypervisors as mentioned above to continue using devicetree.
> 
> More references to vmgenid specs:
>  - https://www.qemu.org/docs/master/specs/vmgenid.html
>  - https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-machine-generation-identifier
> 
> Signed-off-by: Sudan Landge <sudanl@amazon.com>
> ---
>  .../devicetree/bindings/rng/vmgenid.yaml      | 57 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/vmgenid.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rng/vmgenid.yaml b/Documentation/devicetree/bindings/rng/vmgenid.yaml
> new file mode 100644
> index 000000000000..4b6ab62cc2ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rng/vmgenid.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rng/vmgenid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Virtual Machine Generation Counter ID device
> +
> +maintainers:
> +  - Jason A. Donenfeld <Jason@zx2c4.com>
> +
> +description:
> +  Firmwares or hypervisors can use this devicetree to describe
> +  interrupts and the shared resources to inject a Virtual Machine Generation
> +  counter.
> +
> +properties:
> +  compatible:
> +    const: linux,vmgenctr

Why 'linux'? It should be named for a particular host implementation 
(and that implementation's bugs/quirks). However, this thing is simple 
enough we can perhaps avoid that here. As the interface is defined by 
Microsoft, then perhaps they should be the vendor here.

> +
> +  "#interrupt-cells":
> +    const: 3
> +    description: |
> +      The 1st cell is the interrupt type.
> +      The 2nd cell contains the interrupt number for the interrupt type.
> +      The 3rd cell is for trigger type and level flags.
> +
> +  interrupt-controller: true

Why is this device an interrupt controller?

> +
> +  reg:
> +    description: |
> +      specifies the base physical address and
> +      size of the regions in memory which holds the VMGenID counter.

Odd wrapping, but drop unless you have something specific to say about 
region like perhaps the layout of the registers. Or maybe thats defined 
somewhere else?

Does the spec say anything about endianness or access size? DT assumes 
native endianness by default. We have properties to deal these, but 
would be better to be explicit if that's defined already.

> +    maxItems: 1
> +
> +  interrupts:
> +    description: |

Don't need '|' if no formatting.

> +      interrupt used to notify that a new VMGenID counter is available.
> +      The interrupt should be Edge triggered.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rng@80000000 {
> +      compatible = "linux,vmgenctr";
> +      reg = <0x80000000 0x1000>;
> +      interrupts = <0x00 0x23 0x01>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 43b39956694a..cf4b2e10fb49 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18431,6 +18431,7 @@ M:	"Theodore Ts'o" <tytso@mit.edu>
>  M:	Jason A. Donenfeld <Jason@zx2c4.com>
>  S:	Maintained
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
> +F:	Documentation/devicetree/bindings/rng/vmgenid.yaml
>  F:	drivers/char/random.c
>  F:	drivers/virt/vmgenid.c
>  
> -- 
> 2.40.1
> 
> 

