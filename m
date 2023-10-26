Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343AA7D86CB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345187AbjJZQdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjJZQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:33:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D783D18A;
        Thu, 26 Oct 2023 09:33:44 -0700 (PDT)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7FC3B660732A;
        Thu, 26 Oct 2023 17:33:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698338022;
        bh=RxGzKjaqcqxuS0FirV3zeZru2nvyMZcNoxUgFAWaSIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISyTzMa0eeGyKSF0iGiAsBo4JqxXr1uU6AoYhn+BLXMWSJbEs++B3bT4wuhAptrI5
         UYuKv5hOo9f+vRc8K+UtO5jCAAFRrAFQUfmQsuBA4i9MCTDQ3HPIK3AtPxu5EqcJqp
         c6XUvQgAT2nIUOW9Nc6efsrUvUB1XmhZUWVSxeiMAcd+MVw596rtaB012tg/h4MeZ5
         6NMBZpGbVTFKjNesxlXJnjK5tNPO/Obf22RwipC+AyxqmPgq7eP17f8ti1dTLX/i2K
         yoMxJvu6V2n79ZmOF/W5i2pZr3lSWEei5otn32aPdaJIsv3ySO+tc74L3IvVDBjtNH
         bn+PewzhvciiA==
Date:   Thu, 26 Oct 2023 18:33:39 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Devarsh Thakkar <devarsht@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
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
        Darren Etheridge <detheridge@ti.com>,
        "Bajjuri, Praneeth" <praneeth@ti.com>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>,
        "Bhatia, Aradhya" <a-bhatia1@ti.com>,
        "Luthra, Jai" <j-luthra@ti.com>,
        "Brnich, Brandon" <b-brnich@ti.com>,
        "Pothukuchi, Vijay" <vijayp@ti.com>
Subject: Re: [PATCH v13 6/8] media: dt-bindings: wave5: add Chips&Media 521c
 codec IP support
Message-ID: <20231026163339.n6ngsleiycsn4jyw@basti-XPS-13-9310>
References: <20230929-wave5_v13_media_master-v13-0-5ac60ccbf2ce@collabora.com>
 <20230929-wave5_v13_media_master-v13-6-5ac60ccbf2ce@collabora.com>
 <4c557cbd-33e9-a0df-3431-04ade12b6f07@ti.com>
 <7d40c242-7779-45de-83c5-06db9983dae1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <7d40c242-7779-45de-83c5-06db9983dae1@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Krzysztof,

On 22.10.2023 18:12, Krzysztof Kozlowski wrote:
>On 17/10/2023 15:39, Devarsh Thakkar wrote:
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - clocks
>>> +  - interrupts
>>> +
>>
>> Is it possible to keep interrupts property as optional given HW can still work
>> without it if SW does polling of ISR using registers?
>>
>> The reason to ask is in TI AM62A SoC (which also uses this codec) there is an
>> SoC errata of missing interrupt line to A53 and we are using SW based polling
>> locally to run the driver.
>>
>> We were planning to upstream that SW based polling support patch in CnM driver
>> once this base initial driver patch series gets merged, but just wanted to
>> check if upfront it is possible to have interrupts property as optional so
>> that we don't have to change the binding doc again to make it optional later on.
>>
>> Also note that the polling patch won't be specific to AM62A, other SoC's too
>> which use this wave5 hardware if they want can enable polling by choice (by
>> removing interrupt property)
>>
>> Could you please share your opinion on this ?
>
>You know, if you do not have interrupt line connected, how could it be
>required, right? If the hardware does not require interrupt to be
>connected then bindings should not require it.

Alright, so I will make the interrupt optional in the DT binding.
By simply removing it from this list:

required:
   - compatible
   - reg
   - clocks
   - interrupts

Is it possible to make it required later on for certain SoC by adding
something along the lines of:

allOf:
   - if:
       properties:
         compatible:
           contains:
             enum:
               - soc_compatible...
               ...
     then:
       properties:
         interrupts: true

?

>
>Best regards,
>Krzysztof

Sincerely,
Sebastian

>
>_______________________________________________
>Kernel mailing list -- kernel@mailman.collabora.com
>To unsubscribe send an email to kernel-leave@mailman.collabora.com
