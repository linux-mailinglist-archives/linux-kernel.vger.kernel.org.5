Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B8752A53
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjGMSb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGMSb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:31:57 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC07F2D46;
        Thu, 13 Jul 2023 11:31:56 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DIVnni085033;
        Thu, 13 Jul 2023 13:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689273109;
        bh=cbufHtKmT1x2klHfrhnZCmt3cAyIK/2Lga1xIZFOMgM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=VlIJo0iX028Ucxb1LYXBud0VvJeH8HDKDq81QFgBdoEa9iit8ODBU4YJXyyAcB5dW
         IEje4Jlu1mcn+rq0rCUpJAZu0W1h6ketxWtXdn3KPcneKqtoymj5wFir5qQ0o0tJF+
         p2XHZBZ3fUQPqoj+J5jRB6dGE9EeO5GD5NgFp94E=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DIVnTP012497
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 13:31:49 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 13:31:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 13:31:49 -0500
Received: from [10.250.32.50] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DIVmA1019630;
        Thu, 13 Jul 2023 13:31:48 -0500
Message-ID: <af071a46-2e8e-a107-b0d8-d0bb2f845486@ti.com>
Date:   Thu, 13 Jul 2023 13:31:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 3/5] arm64: dts: ti: k3-j784s4: Add WIZ and SERDES PHY
 nodes
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
CC:     <vigneshr@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230710101705.154119-1-j-choudhary@ti.com>
 <20230710101705.154119-4-j-choudhary@ti.com>
 <20230712141828.lnpo4mhd5dv34rlz@census>
 <18310450-05f3-172c-e4bc-fda114f333a4@ti.com>
 <20230713182107.ashuygyg4x4j77s5@backboard>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230713182107.ashuygyg4x4j77s5@backboard>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/23 1:21 PM, Nishanth Menon wrote:
> On 21:01-20230713, Jayesh Choudhary wrote:
>>
>>
>> On 12/07/23 19:48, Nishanth Menon wrote:
>>> On 15:47-20230710, Jayesh Choudhary wrote:
>>>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>>
>>>> J784S4 SoC has 4 Serdes instances along with their respective WIZ
>>>> instances. Add device-tree nodes for them and disable them by default.
>>>>
>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> [j-choudhary@ti.com: fix serdes_wiz clock order]
>>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>>> ---
>>> NAK. This patch introduces the following dtbs_check warning.
>>> arch/arm64/boot/dts/ti/k3-am69-sk.dtb: serdes-refclk: 'clock-frequency' is a required property
>>>
>>
>> Sorry for this. This property was added in the final board file.
>> I will fix it in the next revision.
>> I will add '0' as clock-property in the main file similar to j721e[1]
>> which will be overridden in the board file with required value to get
>> rid of this warning.
> 
> That would follow what renesas (r8a774a1.dtsi) and imx
> (imx8dxl-ss-conn.dtsi) seem to be doing as well. Just make sure to add
> documentation to the property to indicate expectation. Unless someone
> has objections to this approach.
> 

Would it work better to disable these nodes, only enabling them in the
board files when a real clock-frequency can be provided?

My initial reaction would be to move the whole external reference clock
node to the board file since that is where it is provided, but seems
that would cause more churn in serdes_wiz* nodes than we would want..

Andrew
