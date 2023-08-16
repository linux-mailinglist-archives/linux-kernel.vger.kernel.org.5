Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0819B77D957
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 06:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbjHPEBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 00:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241733AbjHPEAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 00:00:49 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4061FC3;
        Tue, 15 Aug 2023 21:00:47 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37G40ZMM109953;
        Tue, 15 Aug 2023 23:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692158435;
        bh=aUFTwOiJ4/lk8UbdCulZVY0zNqXiXpvsU5HWQtWQNUo=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=jnb2fYuiMu9NadMrpWBTEs82L9O++ZrE7wIgsDnoFpWdi4se3nxuO+lcA4KyYYtF3
         e6LMnsF9NiNIgqjnWoU9Z978r4Zr/KmuVCCEUgs4MJy/B8TuJGkUyBvPByyCdXW9aG
         WbCnQ3X+prjXA0PHyy4axpb+APIEK2ZG2HyVeuLA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37G40ZDn121284
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Aug 2023 23:00:35 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Aug 2023 23:00:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Aug 2023 23:00:35 -0500
Received: from [172.24.227.94] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37G40W7B025649;
        Tue, 15 Aug 2023 23:00:32 -0500
Message-ID: <8c6d3e52-17f0-b3a1-c8ab-aff6eec79dff@ti.com>
Date:   Wed, 16 Aug 2023 09:30:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/3] arm64: dts: ti: Introduce AM62P5 SoC and board
Content-Language: en-US
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Andrew Davis <afd@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230811184432.732215-1-vigneshr@ti.com>
 <169179403348.1346194.1236976094485793819.b4-ty@ti.com>
 <5a1ed797-d29a-e047-ccec-adb1dde6d74f@linaro.org>
 <696e95b2-59fa-136a-541e-edc86ef91715@ti.com>
 <222cafa8-1d29-7200-cbaa-781a012f4e4d@ti.com>
In-Reply-To: <222cafa8-1d29-7200-cbaa-781a012f4e4d@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/08/23 12:29, Vignesh Raghavendra wrote:
> 
> 
> On 15/08/23 02:24, Andrew Davis wrote:
>> On 8/14/23 2:26 PM, Krzysztof Kozlowski wrote:
>>> On 12/08/2023 00:49, Nishanth Menon wrote:
>>>> Hi Vignesh Raghavendra,
>>>>
>>>> On Sat, 12 Aug 2023 00:14:29 +0530, Vignesh Raghavendra wrote:
>>>>> This series adds basic support for AM62P family of SoCs and
>>>>> specifically
>>>>> AM62P5 variant. Also adds AM62P5-SK support with basic peripheral
>>>>> like UART.
>>>>>
>>>>> TRM at [0] and Schematics is at [1]
>>>>>
>>>>> [0]: https://www.ti.com/lit/pdf/spruj83
>>>>> [1]: https://www.ti.com/lit/zip/sprr487
>>>>>
>>>>> [...]
>>>>
>>>> Note: since the changes were trivial, I incorporated the cosmetic
>>>> fixup suggested by Andrew locally when I applied. I have also dropped
>>>> bootph property from board's reserved nodes inline with what we did
>>>> for j721s2[2]. Thanks for the bootlog.
>>>>
>>>> I have applied the following to branch ti-k3-dts-next on [1].
>>>> Thank you!
>>>>
>>>> [1/3] dt-bindings: arm: ti: Add bindings for AM62P5 SoCs
>>>>        commit: b57fc5cbdbdfd04d44697800a9d59aeb3be2f273
>>>> [2/3] arm64: dts: ti: Introduce AM62P5 family of SoCs
>>>>        commit: 29075cc09f43a024d962da66d2e4f9eb577713d0
>>>> [3/3] arm64: dts: ti: Add support for the AM62P5 Starter Kit
>>>>        commit: 935c4047d42e53a06ec768ddc495a44f6869209c
>>>>
>>>
>>> A bit too fast. simple-mfd *is not allowed* on its own.
>>>
>> We have the rule against ['syscon', 'simple-mfd'], which requires a 3rd
>> specific compatible, but it seems 'simple-mfd' is allowed in the same way
>> as "simple-bus" (not sure how or why, I would expect a `failed to match any
>> schema with compatible`, but I'm not getting that either?).
>>
> 
> Indeed, I didn't see any warnings from dtbs_check so far
> 
>> We can add something like simple-mfd.yaml for this to explicitly check that
>> the compatible has minItems: 2.
>>
>> But in this case these seem to be just a typo and we meant "simple-bus"
>> here,
>> then it got copy/pasted over our k3 tree.
>>
> 
> I dont think "simple-bus" is enough due to presence to TI specific
> property (ti,sci-dev-id). So this will warrant a separate yaml bindings.
>  I will work towards adding such a file.


Unfortunately that cannot be dropped, it indicates the navss instance to 
be used during PSIL pairing [0] (PSIL proxy to use). 

Looking again at simple-bus.yaml in dt-schema repo, I do see arbitrary 
properties are accepted [1]. But I am not sure if its means device
specific properties are acceptable?

[0] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_psil.html
[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/simple-bus.yaml#L60

> 

-- 
Regards
Vignesh
