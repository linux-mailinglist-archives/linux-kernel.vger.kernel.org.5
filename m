Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06379791153
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 08:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352334AbjIDGZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 02:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbjIDGZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:25:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCA1D9;
        Sun,  3 Sep 2023 23:25:08 -0700 (PDT)
Received: from localhost (89-26-75-29.dyn.cablelink.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B6E33660716C;
        Mon,  4 Sep 2023 07:25:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693808705;
        bh=mXRRDOmNtrA4MRanC4rykngazFEjqU3XBXr0ln7fHAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zn6IPdlA1hgFcTNo0i3RL27CAhcehH/UCdsqyxxZzY513Q74Y03zzQw4eykSBYnNh
         jP5atZCjymGqthSEVPAaFX/YAKeX3gbUeBob9xRMLqkE38JZyT1gfc5ZXVzkYEqMGq
         Wb0RtkziY7wHI2fMkhx5CHRY5r944jE/NnyuXyRSDCYpYAfF4mz0QvRosvtBdcifzW
         hia6C3k5mwPcOUN9cMW6Az0J4mbi6v6Kl30urGtkHTsdbEw+jxXq6RUVpVejhuMe8S
         dkoMbtdO1Ky8xL9qf0YocqwbjoRi6fiNNQLT3Tv/DgDnBFZtAYNusT7KumTgBKcYE7
         Dyq64ueQkRKuQ==
Date:   Mon, 4 Sep 2023 08:25:02 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        kernel@collabora.com, bob.beckett@collabora.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com,
        nas.chung@chipsnmedia.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 5/6] dt-bindings: media: wave5: add yaml devicetree
 bindings
Message-ID: <20230904062502.qtajep4zyslnouxv@basti-XPS-13-9310>
References: <20221207121350.66217-1-sebastian.fricke@collabora.com>
 <20221207121350.66217-6-sebastian.fricke@collabora.com>
 <48d60bd0-4de1-4a5e-eca1-1f8a9303cce0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <48d60bd0-4de1-4a5e-eca1-1f8a9303cce0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Krzysztof,

sorry for digging this mail out of the tombs.
We have worked for quite a while on a new version of the driver and we
are currently finishing it up. I have a few questions before I can
finish the patchset.

Please see below...

On 07.12.2022 13:31, Krzysztof Kozlowski wrote:
>On 07/12/2022 13:13, Sebastian Fricke wrote:
>> From: Robert Beckett <bob.beckett@collabora.com>
>>
>> Add bindings for the wave5 chips&media codec driver
>>
>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>
>What's happening with this patch? Where is the changelog? Why it is v11
>and first time I see it? And why it is v11 with basic mistakes and lack
>of testing?!? I would assume that v11 was already seen and tested...
>
>
>> ---
>>  .../devicetree/bindings/cnm,wave5.yml         | 72 +++++++++++++++++++
>>  1 file changed, 72 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/cnm,wave5.yml
>
>Wrong directory. It wasn't here at all before, so I am really confused
>how this could happen.
>
>Subject: drop redundant pieces: yaml, devicetree and bindings.
>
>
>>
>> diff --git a/Documentation/devicetree/bindings/cnm,wave5.yml b/Documentation/devicetree/bindings/cnm,wave5.yml
>> new file mode 100644
>> index 000000000000..01dddebb162e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cnm,wave5.yml
>> @@ -0,0 +1,72 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/wave5.yaml#
>
>You clearly did not test them before sending.
>
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Chips&Media Wave 5 Series multi-standard codec IP
>> +
>> +maintainers:
>> +  - Nas Chung <nas.chung@chipsnmedia.com>
>> +  - Robert Beckett <bob.beckett@collabora.com>
>> +  - Sebastian Fricke <sebastian.fricke@collabora.com>
>> +
>> +description: |-
>> +  The Chips&Media WAVE codec IP is a multi format video encoder/decoder
>> +
>> +properties:
>> +  compatible:
>> +    anyOf:
>
>Please start from example-schema or other recently approved bindings. No
>anyOf.
>
>> +      - items:
>
>No items...
>
>> +        - enum:
>> +            - cnm,cm511-vpu
>> +            - cnm,cm517-vpu
>> +            - cnm,cm521-vpu
>> +            - cnm,cm521c-vpu
>> +            - cnm,cm521c-dual-vpu
>
>What's the difference between this and one above?
>
>> +            - cnm,cm521e1-vpu
>> +            - cnm,cm537-vpu
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 1
>> +    maxItems: 4
>
>This has to be specific.
>
>> +
>> +  clock-names:
>> +    minItems: 1
>> +    maxItems: 4
>
>You need to list the names.
>
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  sram:
>
>Missing vendor prefix.

After some discussion with the the manufacturer of this CODEC chip, the SRAM
is not fixed to the CODEC chip but instead part of the SoC, thus the
vendor can vary. It sounds like the policy is to use the vendor prefix
of the SoC, that was used for upstreaming. But that policy sounds a bit
like a potential for future confusion to me, so I wanted to ask what you
would like to see. The SoC we develop on is from TI and the CODEC chip is from
C&M, so I could either call it: `ti,sram` or `cnm,sram`

>
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: phandle pointing to the SRAM device node
>
>And what is it for? Why do you need SRAM?

I would write the following here:
The VPU uses the SRAM to store some of the reference data instead of storing it on DMA memory. It is mainly used for the purpose of reducing bandwidth.

Sincerely,
Sebastian

>
>> +    maxItems: 1
>
>Drop
>
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    vpu: video-codec@12345678 {
>> +        compatible = "cnm,cm521-vpu";
>> +        reg = <0x12345678 0x1000>;
>> +        interrupts = <42>;
>> +        clocks = <&clks 42>;
>> +        clock-names = "vcodec";
>> +        sram = <&sram>;
>> +    };
>
>Best regards,
>Krzysztof
>
