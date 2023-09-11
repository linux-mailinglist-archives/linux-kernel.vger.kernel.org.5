Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBFC79A371
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjIKGX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjIKGX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:23:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30262109;
        Sun, 10 Sep 2023 23:23:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A62DC433C7;
        Mon, 11 Sep 2023 06:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694413402;
        bh=FYOki8zkUBTLpZudZIQoxjbaH31iT+OS5RrD9yP7Kjs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uiFv+//HeqADmL8H5TS0Iy8FkNOSv/bmVwihFdrYebWrRVWAcS1iEXSoF2U+ThkDG
         j5H+gPhy0eBm/XjW3YD2etMjvEnL0xgTT/NMHffSuVeIm236NDkeqqDFfiuU9SECii
         dUsg8/pIm13Dszlj05tn8lEvkz2XSOMHrBb2H7sHosg3vlExILYMCZ0GpCL47rH2Iz
         mi1q7QRunmblyKo/YlJBTVMwWM9vI5KpnjVZss3ZFW+fxgk2OHfFJkXykHSGnP6U2r
         LbkiEUc9ZvR4rzvkPtbIa30EvENHRaAWbac9ozU9TcMJzx8K8zzRQhfR+7ZSebhtMT
         upxgBMRwE/bYg==
Message-ID: <e2a776f7-411e-a027-f0a8-3b0615c7f06e@kernel.org>
Date:   Mon, 11 Sep 2023 08:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 1/3] dt-bindings: Add beaglecc1352
Content-Language: en-US
To:     Ayush Singh <ayushdevel1325@gmail.com>,
        greybus-dev@lists.linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Nishanth Menon <nm@ti.com>
References: <20230902182845.1840620-1-ayushdevel1325@gmail.com>
 <20230902182845.1840620-2-ayushdevel1325@gmail.com>
 <937ea540-09e1-65f2-7165-662bbee2542b@kernel.org>
 <8c4717f1-36f3-96dc-2335-ec323e3f46df@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <8c4717f1-36f3-96dc-2335-ec323e3f46df@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 18:47, Ayush Singh wrote:
> On 9/4/23 12:44, Krzysztof Kozlowski wrote:
>> On 02/09/2023 20:28, Ayush Singh wrote:
>>> Add DT bindings for BeagleCC1352 co-processor UART.
>> This does not look like UART controller.
>>
>>
>>> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
>>> ---
>>>   .../bindings/serial/beaglecc1352.yaml         | 25 +++++++++++++++++++
>> It's not a serial driver. Don't put it in unrelated directory.
>>
>>> @@ -0,0 +1,25 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/serial/beaglecc1352.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: BeaglePlay CC1352 serial UART
>> How is this serial UART? Of what? The SoC? Do not describe interface but
>> the device.
>>
>>> +
>>> +maintainers:
>>> +  - Ayush Singh <ayushdevel1325@gmail.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: beagle,cc1352
>> No resources? This does not seem useful... Put it then only in trivial
>> devices if your hardware - hardware, not driver - does not have any
>> pins, interrupts or other resources.
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    beaglecc1352 {
>> Node names should be generic. See also an explanation and list of
>> examples (not exhaustive) in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>
>> Best regards,
>> Krzysztof
> 
> I would like to get some help on how to tackle this particular device 
> since I cannot seem to find anything similar to this setup. First let me 
> go over the setup.
> 
> The BeaglePlay board has 2 processors. AM625 processor which is the main 
> processor. This runs the main Linux system. This processor does not have 
> direct access to SubG.
> 
> It also contains a CC1352P7 MCU with it's own flash program memory, ROM 
> and SRAM. This processor has SubG antenna. It runs it's own OS (Zephyr 
> by default).
> 
> The only way for CC1352P7 and AM625 to communicate is by using that 
> particular UART which is just a standard 8250 UART. The setup pretty 
> much looks like 2 boards connected over UART except the UART will always 
> be static.
> 
> I guess it would make most sense to write a CC1352P7 binding in this 
> case? However, I am not sure how accurate that is since anything from 
> the Linux side will be interacting with the Zephyr application, and not 
> the processor. So in all actuality, the processor itself does not matter 
> at all.

I think the bindings require specific name and give you proper hint what
should it be. If you still wonder, it means you still did not test your
DTS. Such testing is a requirement.

Best regards,
Krzysztof

