Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A16772567
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjHGNWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjHGNV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:21:58 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AC0E7;
        Mon,  7 Aug 2023 06:21:54 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377DLd8N018605;
        Mon, 7 Aug 2023 08:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691414499;
        bh=i+4mblcvdltevVmrqGuk4NDXd/pk6bZBqD9nS6WGZ34=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cnSWMJoqahZfP17Mj7LxNoe7ZVX7kHTCGhdXAKSEGQwcdUo8EkS19KPtgDJb92Jay
         7JN7dqldEDPnof1FIVK3rcvJUGtLLAoHAdCYCLgJMU7mI1/evY9HG8bCqMugCAMujB
         oMCbT9fizNbKocBFo8ifRaoH3aj/5e/s0UJx0rgs=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377DLdnW028166
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 08:21:39 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 08:21:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 08:21:38 -0500
Received: from [10.250.36.243] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377DLbin089934;
        Mon, 7 Aug 2023 08:21:38 -0500
Message-ID: <fcdb8ff2-2e78-10b0-c674-f18a0263d6d7@ti.com>
Date:   Mon, 7 Aug 2023 08:21:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-am64: Fix epwm_tbclk node name to
 generic name
To:     Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230802174521.236255-1-afd@ti.com>
 <20230802174521.236255-3-afd@ti.com>
 <ZM9a93OTLuwIKitA@francesco-nb.int.toradex.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <ZM9a93OTLuwIKitA@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/6/23 3:33 AM, Francesco Dolcini wrote:
> Hello Andrew, hello Nishanth
> 
> On Wed, Aug 02, 2023 at 12:45:21PM -0500, Andrew Davis wrote:
>> The name "clock" is not allowed for nodes, use "clock-controller" to
>> remove the DTS check warning.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> index e27eb2e585f14..4e3e450e4e4c8 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
>> @@ -61,7 +61,7 @@ phy_gmii_sel: phy@4044 {
>>   			#phy-cells = <1>;
>>   		};
>>   
>> -		epwm_tbclk: clock@4140 {
>> +		epwm_tbclk: clock-controller@4140 {
> 
> I was asked to do the exact same change here [1] by Nishanth, and I'm
> sending the updated patch in a short while.
> 
> However I have one question, according to the
> devicetree-specification-v0.4.pdf [2] "2.2.2 Generic Names
> Recommendation", clock is a valid node name.
> 
> While testing the DT (make CHECK_DTBS=y), I did not have any warning nor
> error.
> 
> What am I missing?
> 

These nodes are not just any nodes, they are part of "ti,j721e-system-controller"
(well not really, we have been just calling these areas that to sneak around
the restrictions on "syscon", "simple-mfd" devices), and so can only have the
node names specified by that binding [0].

I'm working to convert these areas to normal "simple-bus" nodes, when that is
complete then the name "clock" will be fine again here.

Andrew

[0] https://www.kernel.org/doc/Documentation/devicetree/bindings/mfd/ti%2Cj721e-system-controller.yaml

> In addition to that I guess we should also update the example in the dt
> bindings yaml file.
> 
> Francesco
> 
> 
> [1] https://lore.kernel.org/all/20230731142135.108477-2-francesco@dolcini.it/
> [2] https://github.com/devicetree-org/devicetree-specification/releases/download/v0.4/devicetree-specification-v0.4.pdf
