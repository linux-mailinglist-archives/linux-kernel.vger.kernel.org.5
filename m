Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D641C7729C4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjHGPta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjHGPtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:49:23 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111C610F6;
        Mon,  7 Aug 2023 08:49:19 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377FnAv0061280;
        Mon, 7 Aug 2023 10:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691423350;
        bh=js/5Btocp/jI3NsE8gBFGMCGftxxL2Ay3tcjFATyy2o=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Yp+4LKXQuakQMJzlFIaluVV75YvZwwS+HvqPIDRSsOEJZKBtIDTLie/S5Z8qz/61d
         uhRyZAG8BoCwuCIW8Ie5P3bWVjrA4G4cAyjw9g7NltU+fX9b9r5vIKKZHSZmqvjcKu
         K1qdD9GQsoI5d0KqLMiuYwPsl2YvW+zsnjgLo8+I=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377FnADv112806
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 10:49:10 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 10:49:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 10:49:09 -0500
Received: from [10.250.36.243] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377Fn8SI045354;
        Mon, 7 Aug 2023 10:49:08 -0500
Message-ID: <7c2b0f22-95d3-2976-7999-7e65c6d9801b@ti.com>
Date:   Mon, 7 Aug 2023 10:49:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 4/5] arm64: dts: ti: k3-j784s4-evm: Enable
 DisplayPort-0
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <r-ravikumar@ti.com>, <sabiya.d@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rogerq@kernel.org>
References: <20230803080441.367341-1-j-choudhary@ti.com>
 <20230803080441.367341-5-j-choudhary@ti.com>
 <9f19e01e-6211-16eb-c911-998ee2d46161@ti.com>
 <2ddc34f9-92ad-9a0c-8044-0ec671e55e9e@ti.com>
 <06708b12-34af-bcb5-7b65-c9bdd830b9f0@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <06708b12-34af-bcb5-7b65-c9bdd830b9f0@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/23 7:56 AM, Aradhya Bhatia wrote:
> Hi Jayesh,
> 
> On 07-Aug-23 17:54, Jayesh Choudhary wrote:
>> Hello Aradhya,
>>
>> Thank you for the review.
>>
>> On 05/08/23 00:52, Aradhya Bhatia wrote:
>>> Hi Jayesh,
>>>
>>>
>>> On 03-Aug-23 13:34, Jayesh Choudhary wrote:
>>>> From: Rahul T R <r-ravikumar@ti.com>
>>>>
>>>> Enable display for J784S4 EVM.
>>>>
>>>> Add assigned clocks for DSS, DT node for DisplayPort PHY and pinmux for
>>>> DP HPD. Add the clock frequency for serdes_refclk.
>>>>
>>>> Add the endpoint nodes to describe connection from:
>>>> DSS => MHDP => DisplayPort connector.
>>>>
>>>> Also add the GPIO expander-4 node and pinmux for main_i2c4 which is
>>>> required for controlling DP power. Set status for all required nodes
>>>> for DP-0 as "okay".
>>>>
>>>> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
>>>> [j-choudhary@ti.com: move all the changes together to enable DP-0 in
>>>> EVM]
>>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>>> ---
>>>>    arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 119 +++++++++++++++++++++++
>>>>    1 file changed, 119 insertions(+)
>>
>> [...]
>>
>>>> +        reg = <0>;
>>>> +        cdns,num-lanes = <4>;
>>>> +        #phy-cells = <0>;
>>>> +        cdns,phy-type = <PHY_TYPE_DP>;
>>>> +        resets = <&serdes_wiz4 1>, <&serdes_wiz4 2>,
>>>> +             <&serdes_wiz4 3>, <&serdes_wiz4 4>;
>>>> +    };
>>>> +};
>>>> +
>>>> +&mhdp {
>>>> +    status = "okay";
>>>> +    pinctrl-names = "default";
>>>> +    pinctrl-0 = <&dp0_pins_default>;
>>>> +    phys = <&serdes4_dp_link>;
>>>> +    phy-names = "dpphy";
>>>> +};
>>>> +
>>>> +&dss_ports {
>>>> +    port {
>>>
>>> Port index has not been added here. Since this port outputs to MHDP
>>> bridge, this should be "port@0", and a "reg = <0>;" property should be
>>> added below (along with the address and size cells properties).
>>>
>>> I suppose this works functionally in this case, because the port gets
>>> defaulted to "0" by the driver. But in future, when we add support for
>>> other dss output(s) on j784s4-evm, the driver will need indices to
>>> distinguish among them.
>>>
>>
>> Okay. It makes sense.
>> Just one thing here. Adding reg here would require it to have #address-
>> cells and #size-cell but since we have only single child port that too
>> at reg=<0>, it would throw dtbs_check warning:
>>
>> arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi:1828.20-1831.5: Warning
>> (graph_child_address): /bus@100000/dss@4a00000/ports: graph node has
>> single child node 'port@0', #address-cells/#size-cells are not necessary
>>    also defined at arch/arm64/boot/dts/ti/k3-j784s4-evm.dts:911.12-919.3
>>
> 
> Okay! Was not aware about this. I still think "port@0" should be
> specified instead of just "port" and the warning should be ignored, if
> possible.
> 

Do not ignore new DT check warnings, if you go with "port@0" (which you
need to do as the "ti,j721e-dss" binding requires it) you must also add
the #address-cells/#size-cells.

Andrew

> If there were only a "port@1" child node, this warning would not have
> come up, and I believe "port@0" should be treated just the same.
> 
> Moreover, while we can add these properties at a later stage as an
> incremental patch, adding the size and address cells in the dtsi would
> affect other platform dts files as well, that use this SoC.
> 
> For e.g., the patch 5/5 of this series, on AM69-SK will still require
> the size and address cells for its ports. The clean up then will be that
> much more, when adding those incremental patches.
> 
> Anyway, I will let Nishanth and Vignesh take the final call on this.
> 
> Regards
> Aradhya
> 
>>
>>>> +        dpi0_out: endpoint {
>>>> +            remote-endpoint = <&dp0_in>;
>>
>>
>> [...]
> 
