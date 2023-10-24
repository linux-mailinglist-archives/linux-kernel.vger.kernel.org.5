Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AAD7D46D9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 07:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjJXFRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 01:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJXFRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 01:17:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6605EE5;
        Mon, 23 Oct 2023 22:17:50 -0700 (PDT)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 689F966072AE;
        Tue, 24 Oct 2023 06:17:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698124668;
        bh=YUECIn9F7kjCAWXeysCb2OmHfTThMl1ioFSUYe3i6tY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VKyzA5BFMfTebKGTpgbXOHlBI4TOBKxspJ2gEp7Y4c06wJ1oQN9VUymRMw1Wuc6Fi
         dy1S3fuToU1nYW32KKfGvW3frKe7eOxhQADXeG6711QTInsixI7gaLmcrUfIZU4Z/R
         sM58MTgt2EyULA8Qo+LjmzzZse9eUuLg8Lib57V6ZTYeu8tX2LewKqpiFHGvX8zX63
         /ghgXZe4mEV/dnljf8Ar6HSgsK0dkPOpknoaIMTP2qQUqn9g0x9GTDRnse83rfwz9w
         VkpWvStRr8eSfPpHjdWjwOQxMWLeDnKChtWxuwFxclE0Xn2z17qiu4OG/VT1tG+NK4
         qw97avw+gd45g==
Date:   Tue, 24 Oct 2023 07:17:45 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@collabora.com, Robert Beckett <bob.beckett@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH v13 6/8] media: dt-bindings: wave5: add Chips&Media 521c
 codec IP support
Message-ID: <20231024051745.d663ekj7klrl4yzj@basti-XPS-13-9310>
References: <20230929-wave5_v13_media_master-v13-0-5ac60ccbf2ce@collabora.com>
 <20230929-wave5_v13_media_master-v13-6-5ac60ccbf2ce@collabora.com>
 <b94e3561-f5ef-443f-98c7-9b79a8bbceec@linaro.org>
 <20231016134720.GA2650973-robh@kernel.org>
 <20231021120526.eqe3esyxyi5b3e5d@basti-XPS-13-9310>
 <3d465d3c-386d-467b-87e9-806962464ac5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <3d465d3c-386d-467b-87e9-806962464ac5@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Krzysztof,

On 22.10.2023 18:01, Krzysztof Kozlowski wrote:
>On 21/10/2023 14:05, Sebastian Fricke wrote:
>> Hey Rob and Krzysztof,
>>
>> On 16.10.2023 08:47, Rob Herring wrote:
>>> On Thu, Oct 12, 2023 at 03:24:12PM +0200, Krzysztof Kozlowski wrote:
>>>> On 12/10/2023 13:01, Sebastian Fricke wrote:
>>>>> From: Robert Beckett <bob.beckett@collabora.com>
>>>>>
>>>>> Add bindings for the chips&media wave5 codec driver
>>>>>
>>>>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>>>>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>>>>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>>>>> ---
>>>>>  .../devicetree/bindings/media/cnm,wave5.yaml       | 60 ++++++++++++++++++++++
>>>>>  1 file changed, 60 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/media/cnm,wave5.yaml b/Documentation/devicetree/bindings/media/cnm,wave5.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..b31d34aec05b
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/media/cnm,wave5.yaml
>>>>> @@ -0,0 +1,60 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/media/cnm,wave5.yaml#
>>>>
>>>> Filename matching compatible, so: cnm,cm521c-vpu.yaml
>>
>> With which compatible should the filename match? (see below)
>> And just to be sure, this means that I rename the file to:
>> `.../devicetree/bindings/media/cnm,wave521c.yaml`
>
>With the fallback compatible.
>
>>
>>>>
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Chips&Media Wave 5 Series multi-standard codec IP
>>>>> +
>>>>> +maintainers:
>>>>> +  - Nas Chung <nas.chung@chipsnmedia.com>
>>>>> +  - Jackson Lee <jackson.lee@chipsnmedia.com>
>>>>> +
>>>>> +description:
>>>>> +  The Chips&Media WAVE codec IP is a multi format video encoder/decoder
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - cnm,cm521c-vpu
>>>>
>>>> Can this device be anything else? Why VPU suffix?
>>>
>>> It needs an SoC specific compatible (TI something...) as well (or
>>> instead). Unless there's a public spec with details on how many
>>> clocks, resets, interrupts, etc. there are.
>>
>> Okay so how about this, a bit similar to the Coda driver supplying both
>> a general option and a SoC specific version:
>
>Can generic compatible be used alone in board designs? If it is licensed
>block, then most likely you want a fallback.

Alright, so a fallback seems appropriate, how do you like this?

properties:
   compatible:
     items:
       - enum:
           - const: ti,k3-j721sX-wave521c
       - const: cnm,wave521c

Providing a fallback and adding a enum which can be extended later on.

>
>>
>> properties:
>>    compatible:
>>      enum:
>>        - ti,k3-j721sX-wave521c
>>        - cnm,wave521c
>>
>> (ti,k3-j721sX-wave521c = manufacturer,SoC-codec)
>> (tested on j721s2 but should work on other variations as well)
>>
>> Another alternative could be: ti,k3-wave521c (less specific on a single
>> SoC series but connected to a bigger range of devices)
>
>Best regards,
>Krzysztof

Greetings,
Sebastian
>
>_______________________________________________
>Kernel mailing list -- kernel@mailman.collabora.com
>To unsubscribe send an email to kernel-leave@mailman.collabora.com
