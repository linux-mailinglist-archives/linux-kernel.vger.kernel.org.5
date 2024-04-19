Return-Path: <linux-kernel+bounces-151478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01078AAF5E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A870A2819D6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D903A128833;
	Fri, 19 Apr 2024 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="Rb45dPPU"
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4368614B;
	Fri, 19 Apr 2024 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533520; cv=none; b=ESOq4x0QYv0/hSTSbbsXSrb4yu2tG6eLzOYeDUQw7nLTqb07VWFyBXZ3GBUgZdfx4nMzFEaT3tEsGZeNM/GUA85r/qd3n1AhRGroOtSlOA6S6PHpQsoqlkqrRhp5qRBR3MBiP5o2tgq/Nfn9unG+2algVnu2PMTEqZgR8WHh7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533520; c=relaxed/simple;
	bh=YtKnpbLT9sY4SRQfvv2LW+DsSby+9c+olA8R6cjoRRQ=;
	h=Subject:Message-ID:Date:MIME-Version:To:References:From:
	 In-Reply-To:Content-Type; b=VlnX1spDdJSPPsq56bEZdFgSE/MHVfPniKMD6GHQPB49dbqj87GV7Ien7HNYSkUz1W5N8zcKGsig7iLr+1QAtf5tF00cDm1Z0uWihImjDcS0fZUc0QABacoG+1NiYdUudPZcZipMhPXfX2gqhXCZ+1OtjN2zsGcXRol9QeiVNmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=Rb45dPPU; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1713533519; x=1745069519;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=YFRKM97PL1YLV8VV/GSpTXPtzgOIR33j9rSKn7zAI8Y=;
  b=Rb45dPPUtNs88ASpMhYdD6iy7YMzm5fubwcDIgVNxPLc9nj+TaXLHUix
   BygAPPEpkBzPUnskvq46bxNSplu3tkDg8X8MhCVzcFT4tfDhWWhAZb3Ca
   494WlxxE5+u2IOCxBS7WGljJYj1xv93cYLC+l+V42wGl7TM3H45Binq23
   c=;
X-IronPort-AV: E=Sophos;i="6.07,213,1708387200"; 
   d="scan'208";a="648820206"
Subject: Re: [PATCH v7 2/3] dt-bindings: rng: Add vmgenid support
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 13:31:56 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:62183]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.44.210:2525] with esmtp (Farcaster)
 id 57717580-066b-4e95-a903-589fe9f1465c; Fri, 19 Apr 2024 13:31:54 +0000 (UTC)
X-Farcaster-Flow-ID: 57717580-066b-4e95-a903-589fe9f1465c
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 19 Apr 2024 13:31:54 +0000
Received: from [10.95.129.79] (10.95.129.79) by EX19D036EUC002.ant.amazon.com
 (10.252.61.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 19 Apr
 2024 13:31:49 +0000
Message-ID: <bf9b59ed-a739-4a06-93db-facb0c89dab6@amazon.co.uk>
Date: Fri, 19 Apr 2024 14:31:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, <tytso@mit.edu>,
	<robh@kernel.org>, <krzk@kernel.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sudanl@amazon.com>, <graf@amazon.com>, <dwmw@amazon.co.uk>,
	<krzysztof.kozlowski@linaro.org>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
References: <20240418121249.42380-1-Jason@zx2c4.com>
 <20240418121249.42380-3-Jason@zx2c4.com>
Content-Language: en-US
From: "Landge, Sudan" <sudanl@amazon.co.uk>
In-Reply-To: <20240418121249.42380-3-Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)



On 18/04/2024 13:12, Jason A. Donenfeld wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> From: Sudan Landge <sudanl@amazon.com>
> 
> Virtual Machine Generation ID driver was introduced in commit
> af6b54e2b5ba ("virt: vmgenid: notify RNG of VM fork and supply
> generation ID"), as an ACPI only device.
> 
> VMGenID specification http://go.microsoft.com/fwlink/?LinkId=260709
> defines a mechanism for the BIOS/hypervisors to communicate to the
> virtual machine that it is executed with a different configuration (e.g.
> snapshot execution or creation from a template).  The guest operating
> system can use the notification for various purposes such as
> re-initializing its random number generator etc.
> 
> As per the specs, hypervisor should provide a globally unique
> identified, or GUID via ACPI.
> 
> This patch tries to mimic the mechanism to provide the same
> functionality which is for a hypervisor/BIOS to notify the virtual
> machine when it is executed with a different configuration.
> 
> As part of this support the devicetree bindings requires the hypervisors
> or BIOS to provide a memory address which holds the GUID and an IRQ
> which is used to notify when there is a change in the GUID.  The memory
> exposed in the DT should follow the rules defined in the vmgenid spec
> mentioned above.
> 
> Reason for this change: Chosing ACPI or devicetree is an intrinsic part
> of an hypervisor design.  Without going into details of why a hypervisor
> would chose DT over ACPI, we would like to highlight that the
> hypervisors that have chose devicetree and now want to make use of the
> vmgenid functionality cannot do so today because vmgenid is an ACPI only
> device.  This forces these hypervisors to change their design which
> could have undesirable impacts on their use-cases, test-scenarios etc.
> 
> The point of vmgenid is to provide a mechanism to discover a GUID when
> the execution state of a virtual machine changes and the simplest way to
> do it is pass a memory location and an interrupt via devicetree.  It
> would complicate things unnecessarily if instead of using devicetree, we
> try to implement a new protocol or modify other protocols to somehow
> provide the same functionility.
> 
> We believe that adding a devicetree binding for vmgenid is a simpler,
> better alternative to provide the same functionality and will allow such
> hypervisors as mentioned above to continue using devicetree.
> 
> More references to the vmgenid specs are found below.
> 
> Signed-off-by: Sudan Landge <sudanl@amazon.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Alexander Graf <graf@amazon.com>
> Link: https://www.qemu.org/docs/master/specs/vmgenid.html
> Link: https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-machine-generation-identifier
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   .../bindings/rng/microsoft,vmgenid.yaml       | 49 +++++++++++++++++++
>   MAINTAINERS                                   |  1 +
>   2 files changed, 50 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml b/Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
> new file mode 100644
> index 000000000000..8f20dee93e7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rng/microsoft,vmgenid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Virtual Machine Generation ID
> +
> +maintainers:
> +  - Jason A. Donenfeld <Jason@zx2c4.com>
> +
> +description:
> +  Firmwares or hypervisors can use this devicetree to describe an
> +  interrupt and a shared resource to inject a Virtual Machine Generation ID.
> +  Virtual Machine Generation ID is a globally unique identifier (GUID) and
> +  the devicetree binding follows VMGenID specification defined in
> +  http://go.microsoft.com/fwlink/?LinkId=260709.
> +
> +properties:
> +  compatible:
> +    const: microsoft,vmgenid
> +
> +  reg:
> +    description:
> +      Specifies a 16-byte VMGenID in endianness-agnostic hexadecimal format.
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Interrupt used to notify that a new VMGenID is available.
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
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    rng@80000000 {
> +      compatible = "microsoft,vmgenid";
> +      reg = <0x80000000 0x1000>;
> +      interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa3b947fb080..c84ac9258a48 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18463,6 +18463,7 @@ M:      "Theodore Ts'o" <tytso@mit.edu>
>   M:     Jason A. Donenfeld <Jason@zx2c4.com>
>   S:     Maintained
>   T:     git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
> +F:     Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
>   F:     drivers/char/random.c
>   F:     drivers/virt/vmgenid.c
> 
> --
> 2.44.0
> 
Since I am on leave, looping in Babis to review/verify the patches.

