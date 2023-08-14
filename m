Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0451677C1DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjHNUzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjHNUzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:55:04 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5ACE5E;
        Mon, 14 Aug 2023 13:55:02 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37EKstj4044673;
        Mon, 14 Aug 2023 15:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692046495;
        bh=eu5v6HMGBi1Ct4gNKjZo21YVhoIN6ZLN5lyMmT4bfdQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=oRcPSnI9LBYxjcaNq5gsWGtvOzQP9Iygy5/1BCyeWZUERpMue+Dpyp7PA/lSs45QJ
         i4BuUUBYA0xdvCH+sh5bmi4tkxz9n9t8suJ/rL11MsNNKZ/YkejUNqtKFFag4ERtsS
         w8EzThuJLWqs1GEZpSibgYvM5JfzGsTQEUW60A58=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37EKstIg113666
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Aug 2023 15:54:55 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Aug 2023 15:54:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Aug 2023 15:54:55 -0500
Received: from [10.250.38.120] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37EKssM0107763;
        Mon, 14 Aug 2023 15:54:54 -0500
Message-ID: <696e95b2-59fa-136a-541e-edc86ef91715@ti.com>
Date:   Mon, 14 Aug 2023 15:54:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/3] arm64: dts: ti: Introduce AM62P5 SoC and board
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230811184432.732215-1-vigneshr@ti.com>
 <169179403348.1346194.1236976094485793819.b4-ty@ti.com>
 <5a1ed797-d29a-e047-ccec-adb1dde6d74f@linaro.org>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <5a1ed797-d29a-e047-ccec-adb1dde6d74f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 2:26 PM, Krzysztof Kozlowski wrote:
> On 12/08/2023 00:49, Nishanth Menon wrote:
>> Hi Vignesh Raghavendra,
>>
>> On Sat, 12 Aug 2023 00:14:29 +0530, Vignesh Raghavendra wrote:
>>> This series adds basic support for AM62P family of SoCs and specifically
>>> AM62P5 variant. Also adds AM62P5-SK support with basic peripheral
>>> like UART.
>>>
>>> TRM at [0] and Schematics is at [1]
>>>
>>> [0]: https://www.ti.com/lit/pdf/spruj83
>>> [1]: https://www.ti.com/lit/zip/sprr487
>>>
>>> [...]
>>
>> Note: since the changes were trivial, I incorporated the cosmetic
>> fixup suggested by Andrew locally when I applied. I have also dropped
>> bootph property from board's reserved nodes inline with what we did
>> for j721s2[2]. Thanks for the bootlog.
>>
>> I have applied the following to branch ti-k3-dts-next on [1].
>> Thank you!
>>
>> [1/3] dt-bindings: arm: ti: Add bindings for AM62P5 SoCs
>>        commit: b57fc5cbdbdfd04d44697800a9d59aeb3be2f273
>> [2/3] arm64: dts: ti: Introduce AM62P5 family of SoCs
>>        commit: 29075cc09f43a024d962da66d2e4f9eb577713d0
>> [3/3] arm64: dts: ti: Add support for the AM62P5 Starter Kit
>>        commit: 935c4047d42e53a06ec768ddc495a44f6869209c
>>
> 
> A bit too fast. simple-mfd *is not allowed* on its own.
> 
We have the rule against ['syscon', 'simple-mfd'], which requires a 3rd
specific compatible, but it seems 'simple-mfd' is allowed in the same way
as "simple-bus" (not sure how or why, I would expect a `failed to match any
schema with compatible`, but I'm not getting that either?).

We can add something like simple-mfd.yaml for this to explicitly check that
the compatible has minItems: 2.

But in this case these seem to be just a typo and we meant "simple-bus" here,
then it got copy/pasted over our k3 tree.

So as Nishanth suggested, we can clean this up first thing next cycle, then
add a rule to prevent it from happening for anyone else again while we are at it.

Andrew

> Best regards,
> Krzysztof
> 
