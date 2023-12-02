Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8BA801FCB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 00:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjLBXtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 18:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLBXtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 18:49:12 -0500
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0894B188;
        Sat,  2 Dec 2023 15:49:18 -0800 (PST)
Received: from [10.0.0.200] (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 7FE6C1611F5;
        Sun,  3 Dec 2023 00:49:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1701560956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=IUya9+EVB2sfwK1alv344yonCPHy3E28ZcbG1mZseBQ=;
        b=LKYtlQhnq44UsrPEA9Qkp9IsuDkh3UypoZmmvGhGZWd384yeo1PwzMGNpUTguseA0irHWz
        cXlyLqoBbLMiPUx9LXLbArV0JTWqrF1YfgG0ZbJY7+QYfjuwjHewOrf3A9ACnSoUVD8Ro9
        aqRCTWDjWfdUolvlE/guDe2yhTRkxcw=
Message-ID: <5e0603d4-cfbe-431f-9636-1e48d942c12e@ixit.cz>
Date:   Sun, 3 Dec 2023 00:49:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: arm: merge qcom,idle-state with
 idle-state
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211224144835.39193-1-david@ixit.cz>
 <YdSyxY2SVXAqvNmS@robh.at.kernel.org>
Content-Language: en-US
From:   David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <YdSyxY2SVXAqvNmS@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the feedback, I tried to incorporate it and sent V4.

David

On 04/01/2022 21:49, Rob Herring wrote:
> On Fri, Dec 24, 2021 at 03:48:34PM +0100, David Heidelberg wrote:
>> Merge Qualcomm specific idle-state binding with generic one.
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>
>> ---
>> v3:
>>   - integrate into idle-state.yml
>>   - orig. patch name was:
>>     "[v2] dt-bindings: arm/msm/qcom,idle-state convert to YAML"
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>>   .../devicetree/bindings/arm/idle-states.yaml  | 107 ++++++++++++++++++
>>   .../bindings/arm/msm/qcom,idle-state.txt      |  84 --------------
>>   2 files changed, 107 insertions(+), 84 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/idle-states.yaml b/Documentation/devicetree/bindings/arm/idle-states.yaml
>> index 52bce5dbb11f..fde1557f2332 100644
>> --- a/Documentation/devicetree/bindings/arm/idle-states.yaml
>> +++ b/Documentation/devicetree/bindings/arm/idle-states.yaml
>> @@ -241,6 +241,64 @@ description: |+
>>     [6] ARM Linux Kernel documentation - Booting AArch64 Linux
>>         Documentation/arm64/booting.rst
>>   
>> +  ===========================================
>> +  5 - Qualcomm specific STATES
>> +  ===========================================
>> +
>> +  cpuidle-qcom is the cpuidle driver for Qualcomm SoCs and uses these idle
> What's cpuidle?
>
> (Linux detail doesn't belong here)
>
>> +  states. Idle states have different enter/exit latency and residency values.
>> +  The idle states supported by the QCOM SoC are defined as -
>> +
>> +    * Standby
>> +    * Retention
>> +    * Standalone Power Collapse (Standalone PC or SPC)
>> +    * Power Collapse (PC)
>> +
>> +  Standby: Standby does a little more in addition to architectural clock gating.
>> +  When the WFI instruction is executed the ARM core would gate its internal
>> +  clocks. In addition to gating the clocks, QCOM cpus use this instruction as a
>> +  trigger to execute the SPM state machine. The SPM state machine waits for the
>> +  interrupt to trigger the core back in to active. This triggers the cache
>> +  hierarchy to enter standby states, when all cpus are idle. An interrupt brings
>> +  the SPM state machine out of its wait, the next step is to ensure that the
>> +  cache hierarchy is also out of standby, and then the cpu is allowed to resume
>> +  execution. This state is defined as a generic ARM WFI state by the ARM cpuidle
>> +  driver and is not defined in the DT. The SPM state machine should be
>> +  configured to execute this state by default and after executing every other
>> +  state below.
>> +
>> +  Retention: Retention is a low power state where the core is clock gated and
>> +  the memory and the registers associated with the core are retained. The
>> +  voltage may be reduced to the minimum value needed to keep the processor
>> +  registers active. The SPM should be configured to execute the retention
>> +  sequence and would wait for interrupt, before restoring the cpu to execution
>> +  state. Retention may have a slightly higher latency than Standby.
>> +
>> +  Standalone PC: A cpu can power down and warmboot if there is a sufficient time
>> +  between the time it enters idle and the next known wake up. SPC mode is used
>> +  to indicate a core entering a power down state without consulting any other
>> +  cpu or the system resources. This helps save power only on that core.  The SPM
>> +  sequence for this idle state is programmed to power down the supply to the
>> +  core, wait for the interrupt, restore power to the core, and ensure the
>> +  system state including cache hierarchy is ready before allowing core to
>> +  resume. Applying power and resetting the core causes the core to warmboot
>> +  back into Elevation Level (EL) which trampolines the control back to the
>> +  kernel. Entering a power down state for the cpu, needs to be done by trapping
>> +  into a EL. Failing to do so, would result in a crash enforced by the warm boot
>> +  code in the EL for the SoC. On SoCs with write-back L1 cache, the cache has to
>> +  be flushed in s/w, before powering down the core.
>> +
>> +  Power Collapse: This state is similar to the SPC mode, but distinguishes
>> +  itself in that the cpu acknowledges and permits the SoC to enter deeper sleep
>> +  modes. In a hierarchical power domain SoC, this means L2 and other caches can
>> +  be flushed, system bus, clocks - lowered, and SoC main XO clock gated and
>> +  voltages reduced, provided all cpus enter this state.  Since the span of low
>> +  power modes possible at this state is vast, the exit latency and the residency
>> +  of this low power mode would be considered high even though at a cpu level,
>> +  this essentially is cpu power down. The SPM in this state also may handshake
>> +  with the Resource power manager (RPM) processor in the SoC to indicate a
>> +  complete application processor subsystem shut down.
> I'm on the fence whether any of this belongs here... But I don't have a
> better suggestion.
>
>> +
>>   properties:
>>     $nodename:
>>       const: idle-states
>> @@ -323,6 +381,44 @@ patternProperties:
>>         - exit-latency-us
>>         - min-residency-us
>>   
>> +  "^(ret|spc|pc)$":
> Either these need to be added to the existing pattern for node names or
> the node names in the dts files be changed to match the existing
> binding. I think it is safe to do the latter as the driver doesn't care
> about node names.
>
> And then you just need to update the 'compatible' schema.
>
>> +    type: object
>> +    description:
>> +      Each state node represents a domain idle state description.
>> +
>> +    properties:
>> +      compatible:
>> +        items:
>> +          - enum:
>> +              - qcom,idle-state-ret
>> +              - qcom,idle-state-spc
>> +              - qcom,idle-state-pc
>> +          - const: arm,idle-state
>> +
>> +      entry-latency-us:
>> +        description:
>> +          The worst case latency in microseconds required to enter the idle
>> +          state. Note that, the exit-latency-us duration may be guaranteed only
>> +          after the entry-latency-us has passed.
>> +
>> +      exit-latency-us:
>> +        description:
>> +          The worst case latency in microseconds required to exit the idle
>> +          state.
>> +
>> +      min-residency-us:
>> +        description:
>> +          The minimum residency duration in microseconds after which the idle
>> +          state will yield power benefits, after overcoming the overhead while
>> +          entering the idle state.
>> +
>> +    required:
>> +      - compatible
>> +      - entry-latency-us
>> +      - exit-latency-us
>> +      - min-residency-us
>> +
>> +
>>   additionalProperties: false
>>   
>>   examples:
>> @@ -658,4 +754,15 @@ examples:
>>           };
>>       };
>>   
>> +  - |
>> +    // Example 3 - QCOM SPC
>> +    idle-states {
>> +      cpu_spc: spc {
>> +        compatible = "qcom,idle-state-spc", "arm,idle-state";
>> +        entry-latency-us = <150>;
>> +        exit-latency-us = <200>;
>> +        min-residency-us = <2000>;
>> +      };
>> +    };
>> +
>>   ...

-- 
David Heidelberg

