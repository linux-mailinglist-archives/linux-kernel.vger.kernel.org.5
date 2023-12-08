Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EBA809CEA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjLHHGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjLHHGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:06:39 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A22210CF;
        Thu,  7 Dec 2023 23:06:41 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1426024E358;
        Fri,  8 Dec 2023 15:06:40 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 8 Dec
 2023 15:06:40 +0800
Received: from [192.168.125.88] (183.27.97.199) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 8 Dec
 2023 15:06:38 +0800
Message-ID: <19282a58-178f-442d-9d38-0eddf2bce9e4@starfivetech.com>
Date:   Fri, 8 Dec 2023 15:03:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: display: bridge: cdns: Add properties
 to support StarFive JH7110 SoC
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <tomi.valkeinen@ideasonboard.com>,
        <r-ravikumar@ti.com>, <rdunlap@infradead.org>,
        <u.kleine-koenig@pengutronix.de>, <bbrezillon@kernel.org>,
        <changhuang.liang@starfivetech.com>, <keith.zhao@starfivetech.com>,
        <jack.zhu@starfivetech.com>, <linux-kernel@vger.kernel.org>
References: <20231127113436.57361-1-shengyang.chen@starfivetech.com>
 <20231127113436.57361-2-shengyang.chen@starfivetech.com>
 <20231128155222.GA3319844-robh@kernel.org>
From:   Shengyang Chen <shengyang.chen@starfivetech.com>
In-Reply-To: <20231128155222.GA3319844-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.199]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rob

Thanks for review and comment.

On 2023/11/28 23:52, Rob Herring wrote:
> On Mon, Nov 27, 2023 at 07:34:35PM +0800, Shengyang Chen wrote:
>> From: Keith Zhao <keith.zhao@starfivetech.com>
>> 
>> Add properties in CDNS DSI yaml file to match with
>> CDNS DSI module in StarFive JH7110 SoC.
>> 
>> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
>> ---
>>  .../bindings/display/bridge/cdns,dsi.yaml     | 38 ++++++++++++++++++-
>>  1 file changed, 36 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
>> index 23060324d16e..3f02ee383aad 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
>> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
>> @@ -17,6 +17,7 @@ properties:
>>      enum:
>>        - cdns,dsi
>>        - ti,j721e-dsi
>> +      - starfive,cdns-dsi
>>  
>>    reg:
>>      minItems: 1
>> @@ -27,14 +28,20 @@ properties:
>>            Register block for wrapper settings registers in case of TI J7 SoCs.
>>  
>>    clocks:
>> +    minItems: 2
>>      items:
>>        - description: PSM clock, used by the IP
>>        - description: sys clock, used by the IP
>> +      - description: apb clock, used by the IP
>> +      - description: txesc clock, used by the IP
>>  
>>    clock-names:
>> +    minItems: 2
>>      items:
>>        - const: dsi_p_clk
>>        - const: dsi_sys_clk
>> +      - const: apb
>> +      - const: txesc
>>  
>>    phys:
>>      maxItems: 1
>> @@ -46,10 +53,21 @@ properties:
>>      maxItems: 1
>>  
>>    resets:
>> -    maxItems: 1
>> +    minItems: 1
>> +    items:
>> +      - description: dsi sys reset line
>> +      - description: dsi dpi reset line
>> +      - description: dsi apb reset line
>> +      - description: dsi txesc reset line
>> +      - description: dsi txbytehs reset line
>>  
>>    reset-names:
>> -    const: dsi_p_rst
>> +    items:
>> +      - const: dsi_p_rst
>> +      - const: dsi_dpi
>> +      - const: dsi_apb
>> +      - const: dsi_txesc
>> +      - const: dsi_txbytehs
> 
> Let's not continue the redundant 'dsi_' prefix. We're stuck with it for 
> the first one, but not the new ones.
> 

ok, "dsi_" will be dropped in next commit.

> Rob

thanks.

Best Regards,
Shengyang
