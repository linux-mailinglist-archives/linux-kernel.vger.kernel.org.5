Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529A77E5C90
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjKHRlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjKHRlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:41:44 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654EA1BEB;
        Wed,  8 Nov 2023 09:41:42 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ce37683cf6so4235727a34.3;
        Wed, 08 Nov 2023 09:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699465301; x=1700070101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMG/0PoSeUv8+GtzpYfiSBWL8BztOuyiTF9fdbSo1LQ=;
        b=oNE7hhCV2Rx1k9Dfc2DlYWKHKz6QyPYAhsAUzM9PWel64/aL1DAYQ4PT0Gya2J+LgF
         i0sHHW/0W3g3ZYZjq2wtGnP4oLwTZnfwFtlURFCJ+XEVRw0zzB1gY4I1KIVhUXxXS9og
         MNJwK83yTf5cZRYLhGCf/kLF7KtuoczxDrVfLJZa7a87spR7eC42P8v3bs6m1xn+9bYa
         WbqZWuc8kl1ProXD5GDpE2s5iOvCcY6hoxgFfve/2yts/b5ju4SfCyQqVmIxLJO+LDCO
         B8TZJbDlHf749Jv0F1eWqgna2br/VMos6ZtgGXwt8YiFxCFoJIXn+vAip+CxiSDBE86T
         3F0A==
X-Gm-Message-State: AOJu0Yz6dfAtVdTGbzew+vZzDelSMOo68kmATGPu6qYXQ1FW4ZJtL7S0
        zCdbr74+J8EqKWijbsIruA==
X-Google-Smtp-Source: AGHT+IFTttXnMCmbDF/OfTZ9eKrHb0JNjsrpgyGxTLR0++d1/rwsFkGnx9Mf8IFRM4ThG/CmdTwCrg==
X-Received: by 2002:a05:6808:3c8d:b0:3af:8050:369f with SMTP id gs13-20020a0568083c8d00b003af8050369fmr3564543oib.6.1699465301587;
        Wed, 08 Nov 2023 09:41:41 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bk31-20020a0568081a1f00b003a7a34a4ed8sm1957459oib.33.2023.11.08.09.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:41:40 -0800 (PST)
Received: (nullmailer pid 2547190 invoked by uid 1000);
        Wed, 08 Nov 2023 17:41:40 -0000
Date:   Wed, 8 Nov 2023 11:41:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michal Simek <michal.simek@amd.com>,
        Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: Add new board description for
 MicroBlaze V
Message-ID: <20231108174140.GA2494040-robh@kernel.org>
References: <50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com>
 <20231106-hangnail-prankster-a04e713bed35@spud>
 <4223470c-5596-4168-9c89-e701559fbbed@amd.com>
 <e9fef49e-c0ca-4f7d-9618-151216e25280@linaro.org>
 <92d95425-5bae-4ada-8fc3-966e7bfbd815@amd.com>
 <90f9991e-26a3-498e-9449-c96663987459@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f9991e-26a3-498e-9449-c96663987459@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:38:15PM +0100, Krzysztof Kozlowski wrote:
> On 07/11/2023 13:09, Michal Simek wrote:
> > 
> > 
> > On 11/7/23 12:27, Krzysztof Kozlowski wrote:
> >> On 07/11/2023 12:09, Michal Simek wrote:
> >>>
> >>>
> >>> On 11/6/23 18:07, Conor Dooley wrote:
> >>>> On Mon, Nov 06, 2023 at 12:53:40PM +0100, Michal Simek wrote:
> >>>>> MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
> >>>>> It is hardware compatible with classic MicroBlaze processor. Processor can
> >>>>> be used with standard AMD/Xilinx IPs including interrupt controller and
> >>>>> timer.
> >>>>>
> >>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >>>>> ---
> >>>>>
> >>>>>    .../devicetree/bindings/soc/amd/amd.yaml      | 26 +++++++++++++++++++
> >>>>
> >>>> Bindings for SoCs (and by extension boards with them) usually go to in
> >>>> $arch/$vendor.yaml not into soc/$vendor/$vendor.yaml. Why is this any
> >>>> different?
> >>>
> >>> I actually found it based on tracking renesas.yaml which describes one of risc-v
> >>> board. No problem to move it under bindings/riscv/
> >>>
> >>>>
> >>>>>    1 file changed, 26 insertions(+)
> >>>>>    create mode 100644 Documentation/devicetree/bindings/soc/amd/amd.yaml
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/soc/amd/amd.yaml b/Documentation/devicetree/bindings/soc/amd/amd.yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..21adf28756fa
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/soc/amd/amd.yaml
> >>>>> @@ -0,0 +1,26 @@
> >>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id: http://devicetree.org/schemas/soc/amd/amd.yaml#
> >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>> +
> >>>>> +title: AMD Platforms
> >>>>> +
> >>>>> +maintainers:
> >>>>> +  - Michal Simek <michal.simek@amd.com>
> >>>>> +
> >>>>> +description: |
> >>>>> +  AMD boards with MicroBlaze V SOC
> >>>>> +
> >>>>> +properties:
> >>>>> +  $nodename:
> >>>>> +    const: '/'
> >>>>> +  compatible:
> >>>>> +    oneOf:
> >>>>> +      - description: AMD MicroBlaze V
> >>>>> +        items:
> >>>>> +          - const: amd,mbv
> >>>>
> >>>> You don't actually list any boards here, but instead permit having only
> >>>> the SoC compatible and no board one. The SoC compatible is also
> >>>> incredibly generic. Personally I don't think this binding makes any
> >>>> sense as it appears to exist as a catch all for anything using your
> >>>> new cores in any combination.
> >>>
> >>> I think I need to define any string for compatibility because it is standard
> >>> property. Because this is soft core it can be added to any board with AMD/Xilinx
> >>> chip. I don't have really an option to list all boards.
> >>
> >> Why? Either there is a product with this soft-core or there is not. It
> >> cannot be both.
> > 
> > I am doing basic enablement. I am not making product. Product will be done by 
> > our customers using this core.
> > There will be thousands of different configurations done by customers which will 
> > have products with it. Also there could be hundreds configurations done on the 
> > same board.
> 
> If this is the same board, then why there is compatible for it?
> 
> > 
> > Does it make sense to have board related compatible string like this if this 
> > evaluation board is used by a lot of customers?
> > "amd,kcu105-mbv-ABC-vXYZ", "amd,kcu105-mbv", "amd,mbv"
> 
> I miss the point what is the hardware. Evaluation board is the hardware.
> If someone changes it and makes a new product, it is a new product.
> 
> > 
> > Or I can define qemu one.
> > "amd,qemu-mbv", "amd,mbv"
> 
> QEMU is not hardware, so not.

But QEMU is an implementation with its own quirks and implementation 
details, and compatibles are tied to specific implementations. I'm fine 
with it and IIRC we already have some cases. I prefer saying 'qemu' here 
rather than just allowing a "generic" compatible alone because folks 
will tend to not think they can just reuse the qemu compatible when they 
will do that for a generic compatible. 

nit: qemu,mbv or something as 'qemu' is the vendor.

> 
> > 
> > I think customers should be adding their compatible string in front of generic one.
> 
> To what? To evaluation board? Why?
> 
> > 
> > Years ago I have done the same thing with Microblaze where compatible is defined 
> > as xlnx,microblaze only. 
> 
> Again, what is the use of such binding?
> 
> > When customer take this soft core, put IPs around and 
> > create a product they should extend it to be for example like this.
> > "xyz,my-product-1.0", "xlnx,microblaze";
> 
> So there is a product, not evaluation board.
> 
> > 
> > And over all of years I have never seen any single customer to try to push dt 
> > description for any Microblaze based product.

I think this FPGA stuff is all a bit special. I would ignore the 
customer product aspect because as Michal says here, we'll never see it. 
For upstream, just define something for what you are testing upstream 
with. 

Rob
