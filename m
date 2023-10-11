Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3D87C4806
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344898AbjJKCzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344865AbjJKCzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:55:04 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B986591;
        Tue, 10 Oct 2023 19:54:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNoqznKNdxS1foOkPqGuxDL5u9GkfaruSkEElKoQ/jcnCyuJ5qc79INi+2vacHQKBqX1Azu7i7ykbthtkg/9TfbcasLGjEyO07KUjhEsItfwBONnCF6h4fWIMEba8lvBN2U6c7LIoUHpokEDaeZFkll+kYl7qyhvx/GxQ2/TnKxCy/jjpg12hj1x5ta0fDLokiiO35v9nW9ldm/gMxAdh4yA+iGvyo40Ll8X6CY+yjq3W7hIXPDnngm3/t4YoqY6QtUqKGwfrBs5871g+PW93EwfO6JoySToRH2I0qorAA+250AFbxKRipoVttczt7ziKBBTQC0cqlJHjFWrTQOK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFqrgEjuTykksK/MfUlhAZigFnxp/QyGP9jH3fDw8qI=;
 b=Mn39xa3ANAMyLf1V6ubIhdLLEdh8zQmkvywVM1Tb/AIuIEQy5uYYfQUCjrDZifZug1TIiQBT6o9SOomb7aLtORuGbvu476IprFpFMcnzAm46HF+WEcTqirbseqPJ0MVie8Ki+2DcqpZ/DHPAF6O1CzQFH6pWWfPpWlXhcztPfyW8PfHWWuRedUEvSKfeU/7farQFZbra02rMUec2ayzuqV8ltKFvdNFjbJyYIhxJgbn5AXkjSjO7//AoqiNtFAdpHsPatJevKKz4RcfSfeDJrwIAANZWcxBSXkccoGA4YczsIorhvO5SSNZB7jjW2YcTJbg/Y4/4qRL4TG8ka/7Jqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFqrgEjuTykksK/MfUlhAZigFnxp/QyGP9jH3fDw8qI=;
 b=O4gygWiq26vIaNLZxIIcaWgnRxBhlqOit71uvqYrP0Ea19staqEk3X9lcV3UYwtI8zguiZRLpBRYcBEA0AJQf5Srosh+QneD2LGDS3f44ieHeFzfxifO2ydi6Xe976iFGOnNN+F9tfpNyAtetfZwnL83qSrdgZ6Y5oo3r/d1PQM01YJV5vPZJMgV7+xgSVC6nTGv6RwAFacuhcqEh5DYoqa3bDgAPCTjWN/8/3+UIXLO56cKx1htoFh994vbg3hjvMdDwTRYBhd7ae45EUSrzPZ36LLCU6HhTEiWffGuVgvE78GjiPZerDaptDHjIsMs7xYrd90FK/ugIrsWQ4MnOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEYPR03MB6961.apcprd03.prod.outlook.com (2603:1096:101:bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 02:54:12 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::792a:209d:4919:5db6]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::792a:209d:4919:5db6%7]) with mapi id 15.20.6863.041; Wed, 11 Oct 2023
 02:54:11 +0000
Message-ID: <829038fe-4f83-0b78-2d6d-601c8aa6d1e2@amlogic.com>
Date:   Wed, 11 Oct 2023 10:54:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 2/4] dt-bindings: clock: add Amlogic C3 peripherals
 clock controller bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chuan Liu <chuan.liu@amlogic.com>
References: <20231010062917.3624223-1-xianwei.zhao@amlogic.com>
 <20231010062917.3624223-3-xianwei.zhao@amlogic.com>
 <20231010132520.GB557938-robh@kernel.org>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20231010132520.GB557938-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEYPR03MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7dc77f-6f88-4236-b9e8-08dbca0558d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ig6UeE5BbUWYfTWTMaeQfHJOhOLoJ5gXnz4zGs+pQVQWohSxbleDx8wPspy6B56JmTO/kgj/+KhSF/gmqGCj55TIcLdEcRKnCoUMPH14Px/t2pv2evMHGnF6oY+gMVuwH9/QOSO0/Klx6dj6mMIIsPBQi80sdwmEizrbXVbVBYqqLoyq36PbsmsWU762fgsvlDHEoyr2RpuiFJJX0yDZOnn8MNxAX6rtkAa1C9vnFqADSY+LbIsUN/Th4EwtP0swneplJnog1KTqnmrl1uAC5TWzqla7AG7+dP4H+7XagQhdb6iUWNFZJivpEqsaKotflwsxqGHPdPS0BBP+jQShO/rdu2OojAyY4ZVdWhkabQ6a0k+nz7Q/V4NJKiAQRehhXbGKz8LaHuFtrSVeIAk02E+VBqi3iUhJNEUGOG5OikCCZt9mpdxRiLhm6niCCWk8JkT+eR34hF1/JkRHdpUriGaRvKO2qtScQHkcfE28y32FMkOHIil9AmheKnuGRcG8penhsGT4LEr79t/zzBaltsbPRtBsOpCFsEzSjj0Hbsd6+MQz+FjmHT7m3DJwYRlaNQaAzNv0k+LquHm8YQFLpp1KArHRfSncsQDQwJ+Jz/pIpIjJIwAY+Kg7rzN4mojCpWIcPUV0Nu6FGSwsGXDtS4mbNyqVbtJN9hFwX0bs2h9E36ORV5y3beOKV6Q88byT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39850400004)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(26005)(2616005)(53546011)(6512007)(83380400001)(6666004)(508600001)(8936002)(7416002)(8676002)(30864003)(4326008)(2906002)(6916009)(66946007)(66556008)(66476007)(54906003)(41300700001)(44832011)(6486002)(5660300002)(966005)(107886003)(316002)(38100700002)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3R3WFRYMW9ZY1V4SlI2VGlNdndkd01idGpyNjNkenNKVHFFY1ZyL3g5di9K?=
 =?utf-8?B?d01aOG1vOW5NcngrWkpEYWVzUldKVTYyRG9YRnhYeDBCNEpadkhCK2o4M21J?=
 =?utf-8?B?RUY1K0NVaGxzWVovY1FNbGxsNEJSVDhLd3JYRTFLSmppajl4dkhjOUVVRDBi?=
 =?utf-8?B?dkRSRk9YdnprcURaUlFUd0pyd0M4NWVqNEdRemJtR3p1SUZ3YzhQQUZJcU50?=
 =?utf-8?B?MjR3WFJXekxNSjBUakNjQnpHanFQTDRoL2VQQU4vczdsTXd4R3YzNHV2cVRh?=
 =?utf-8?B?dG90aGwwWGZCVnVKNXhsQjJIWjl2d2NJVkRMSVU2TktuaTRHclNxYlhvdVFC?=
 =?utf-8?B?N0xJWUI1RXM5SkszRXh1bUxJaUhtWmdKUG1pclQwMnZmZUZxUjBnYVY4UXg1?=
 =?utf-8?B?OEh0TlVxUFUweW8ybmdwa0FIQ3FLTHNVclRPODRwWDh6QWNzWFpMdUUrYVVj?=
 =?utf-8?B?ZWhHNHMreHJ0NHBSQURaYmIxaUFDZG9hNmpyMmdOaU83VzhxNlhwbGFDblRR?=
 =?utf-8?B?OWRuMjFWRHFBZzE3bVJPUDVpUzVreTNDOWhoU0hoY0VVUVBzYmZWK0V6aC9o?=
 =?utf-8?B?ZnNGZUcyaVQrcG5DTDBIcTZaMnc1VjZ0dDI1ZVprTDNsQmpwNEh4SWZCNVFs?=
 =?utf-8?B?VEdpSGtaT01tOGxUbFRkNVhiMjV2S2gvcGh6SVUrMUVqUVpXZjREYy8vSGEv?=
 =?utf-8?B?ZldNTmx0d2NodkNMU1dpcDdJK0JLZnFQL2toUjN5U29XejA4VElFN29lZHVa?=
 =?utf-8?B?QVd6ZHhycXJGYUxJSzJFdEtoKzBXbTNTaVRiUW5oQ3Y3ajdIeEZxeURqMk1X?=
 =?utf-8?B?RnNqZmtxT1Irb3NYSE1pWmlxKy92a0dkU2o4QjlUU3Bpa0h3VzV2ZDNMWVVS?=
 =?utf-8?B?OThXVUJIbVFwcmRxU04wanBEajBDTzhSWnE2S1lyaEkwa2VQN05oUkFRTUVp?=
 =?utf-8?B?WmkyYkloRXpaRlpFL212RTlDWGNodzdSeTZMUUdnM2ozUkhKcDlaSkF4YUpL?=
 =?utf-8?B?UW4zNUljYU9iTW8zL1NWMVFXajVSVGdNUEZpSThHWEFGMWRxdHM4WnAxek54?=
 =?utf-8?B?U1ZOYmxpVjllK0RYU2JKNFBsV0N5dUdYNk9JSHhTMHAxMzVnRmhUb0NJenhr?=
 =?utf-8?B?OFlEd2dUNDNrK0lHc0s5SXpWb0dXTis1TXZiNW4zL2RpSXA4eDNaWmNua0ZX?=
 =?utf-8?B?VHA4SnpjOVNvemoxeUZuMUorb3ArWnUrYm1LR0ErYk5oT3RRdlZPN3dacGNH?=
 =?utf-8?B?WllqcWlrb1FuaG1tYXgzSDZLWm9UbElZMDRIOXY5TWxmd1NOcHB2TmpSSEEw?=
 =?utf-8?B?RWZ5NTFycVJNTTF1VElRV0YvZFlnZTlwR0lOMlozZjNiQ1VhcjA0RDRVWVFS?=
 =?utf-8?B?dHBoWVRjc25SK2l4aDVtRFh4TURpNDJDRUtyV2RSRzBYLzU2MmFkalQzdTFu?=
 =?utf-8?B?VVpIV0pPUDZob3k4YjNmMFh4NUp2R293WEl5QUMyeEx1cUV0c2JlY3NBdXI4?=
 =?utf-8?B?MWQzTnBCTElHb3pxdUpvZGI0enFKRE1VK3Y4UzhEOFE5dXlwNDg5SmFrbmtt?=
 =?utf-8?B?UVVVWmtrQmxweXgxUWNFWlFNTUhtWGNNeGxHZHpXRERpaENEY0tiekZMMHF3?=
 =?utf-8?B?eEV0bXY1cjNkbTN3bXByMldXM2FMQnVqUWJmRVREN2FySTZuYjdnb2tlNkdz?=
 =?utf-8?B?N21TSk04R0RoMmwvT1B6bGxDekU3OUxTNkxLUmd4dk5qYUdORGhUbS9XVnk3?=
 =?utf-8?B?RlpYUGZ1NE1Ydlc0QUpZdmZ1eUt1elNHY05XTkFUVUR6cmxwQzVPS3Z6bjM0?=
 =?utf-8?B?MnNneWhvWmd6aUM4VVJmN0NVNzhkaGRPRy96UnloTkpKSGl2S2JiSndmWG1y?=
 =?utf-8?B?ZlNOZzR5NTNPTkI4Y3hHdkVWUFZYeDNZUjhhMVlpcHNhM2lPcnh4cVpFc2ZW?=
 =?utf-8?B?eFYyNXBFdTRHYUhBbjBLdm1BV0V6ZzYxdnE2OExlNkVwWkFHeWMrMUxUMG8y?=
 =?utf-8?B?Qm13bCtHdnIvQVVnMHRkb1BuUGFJcm9GcUV2UTJ0R3ZuUWZWd1phODUraHBR?=
 =?utf-8?B?VDNhMGxpU3dFZGZUVFJUM21obGZ6dTdvQVkxVFo5V0FIUEgwR2RFOWtvb0JL?=
 =?utf-8?B?dHRwbmFwSjJjQlRlZHVXYXIvM1Y2Q0JTczFzUnRGZzJ6UHA3WTJRRWU4dFA0?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7dc77f-6f88-4236-b9e8-08dbca0558d1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 02:54:11.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKtM/rH2pvqo1Uu1apscZ0sBlS4dIgxpnuuF7XUgO/OrRE8HZeRDSyMz3hWFqH3I0zqx2afLVfPdhpA7Nq6tzBRSJAG2+dxAha9zkklduDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6961
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
     Thanks for your advise.

On 2023/10/10 21:25, Rob Herring wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue, Oct 10, 2023 at 02:29:15PM +0800, Xianwei Zhao wrote:
>> Add the peripherals clock controller dt-bindings for Amlogic C3 SoC family
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>> V1 -> V2: Fix errors when check binding use "make dt_binding_check"
>> ---
>>   .../clock/amlogic,c3-peripherals-clkc.yaml    |  92 +++++++
>>   .../clock/amlogic,c3-peripherals-clkc.h       | 230 ++++++++++++++++++
>>   2 files changed, 322 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
>>   create mode 100644 include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
>> new file mode 100644
>> index 000000000000..a165f447ec41
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
>> @@ -0,0 +1,92 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2022-2023 Amlogic, Inc. All rights reserved
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/amlogic,c3-peripherals-clkc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic C serials Peripherals Clock Controller
> 
> C3?
> 
> Serials. Or just Serial as Peripherals is already plural?
>
Will fix it.

>> +
>> +maintainers:
>> +  - Chuan Liu <chuan.liu@amlogic.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: amlogic,c3-peripherals-clkc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 9
>> +    items:
>> +      - description: input oscillator (usually at 24MHz)
>> +      - description: input fixed pll
>> +      - description: input fixed pll div2
>> +      - description: input fixed pll div2p5
>> +      - description: input fixed pll div3
>> +      - description: input fixed pll div4
>> +      - description: input fixed pll div5
>> +      - description: input fixed pll div7
>> +      - description: input gp0 pll
>> +      - description: input hifi pll
>> +
>> +  clock-names:
>> +    minItems: 9
>> +    items:
>> +      - const: xtal
>> +      - const: fixed_pll
>> +      - const: fclk_div2
>> +      - const: fclk_div2p5
>> +      - const: fclk_div3
>> +      - const: fclk_div4
>> +      - const: fclk_div5
>> +      - const: fclk_div7
>> +      - const: gp0_pll
>> +      - const: hifi_pll
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - "#clock-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/amlogic,c3-pll-clkc.h>
>> +    apb {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        clkc_periphs: clock-controller@0 {
>> +          compatible = "amlogic,c3-peripherals-clkc";
>> +          reg = <0x0 0x0 0x0 0x49c>;
>> +          #clock-cells = <1>;
>> +          clocks = <&xtal>,
>> +                   <&clkc_pll CLKID_FIXED_PLL>,
>> +                   <&clkc_pll CLKID_FCLK_DIV2>,
>> +                   <&clkc_pll CLKID_FCLK_DIV2P5>,
>> +                   <&clkc_pll CLKID_FCLK_DIV3>,
>> +                   <&clkc_pll CLKID_FCLK_DIV4>,
>> +                   <&clkc_pll CLKID_FCLK_DIV5>,
>> +                   <&clkc_pll CLKID_FCLK_DIV7>,
>> +                   <&clkc_pll CLKID_GP0_PLL>,
>> +                   <&clkc_pll CLKID_HIFI_PLL>;
>> +          clock-names = "xtal",
>> +                        "fixed_pll",
>> +                        "fclk_div2",
>> +                        "fclk_div2p5",
>> +                        "fclk_div3",
>> +                        "fclk_div4",
>> +                        "fclk_div5",
>> +                        "fclk_div7",
>> +                        "gp0_pll",
>> +                        "hifi_pll";
>> +        };
>> +    };
>> diff --git a/include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h
>> new file mode 100644
>> index 000000000000..82f9bf683ea0
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h
>> @@ -0,0 +1,230 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>> +/*
>> + * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
> 
> Should have a Co-developed-by tag if the author is different.
> 
Will add Co-developed-by tag.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_C3_PERIPHERALS_CLKC_H
>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_C3_PERIPHERALS_CLKC_H
>> +
>> +#define CLKID_PLL_IN                         0
>> +#define CLKID_MCLK_PLL_IN                    1
>> +#define CLKID_RTC_XTAL_CLKIN                 2
>> +#define CLKID_RTC_32K_DIV                    3
>> +#define CLKID_RTC_32K_MUX                    4
>> +#define CLKID_RTC_32K                                5
>> +#define CLKID_RTC_CLK                                6
>> +#define CLKID_SYS_A_SEL                              7
>> +#define CLKID_SYS_A_DIV                              8
>> +#define CLKID_SYS_A                          9
>> +#define CLKID_SYS_B_SEL                              10
>> +#define CLKID_SYS_B_DIV                              11
>> +#define CLKID_SYS_B                          12
>> +#define CLKID_SYS_CLK                                13
>> +#define CLKID_AXI_A_SEL                              14
>> +#define CLKID_AXI_A_DIV                              15
>> +#define CLKID_AXI_A                          16
>> +#define CLKID_AXI_B_SEL                              17
>> +#define CLKID_AXI_B_DIV                              18
>> +#define CLKID_AXI_B                          19
>> +#define CLKID_AXI_CLK                                20
>> +#define CLKID_SYS_RESET_CTRL                 21
>> +#define CLKID_SYS_PWR_CTRL                   22
>> +#define CLKID_SYS_PAD_CTRL                   23
>> +#define CLKID_SYS_CTRL                               24
>> +#define CLKID_SYS_TS_PLL                     25
>> +#define CLKID_SYS_DEV_ARB                    26
>> +#define CLKID_SYS_MMC_PCLK                   27
>> +#define CLKID_SYS_CAPU                               28
>> +#define CLKID_SYS_CPU_CTRL                   29
>> +#define CLKID_SYS_JTAG_CTRL                  30
>> +#define CLKID_SYS_IR_CTRL                    31
>> +#define CLKID_SYS_IRQ_CTRL                   32
>> +#define CLKID_SYS_MSR_CLK                    33
>> +#define CLKID_SYS_ROM                                34
>> +#define CLKID_SYS_UART_F                     35
>> +#define CLKID_SYS_CPU_ARB                    36
>> +#define CLKID_SYS_RSA                                37
>> +#define CLKID_SYS_SAR_ADC                    38
>> +#define CLKID_SYS_STARTUP                    39
>> +#define CLKID_SYS_SECURE                     40
>> +#define CLKID_SYS_SPIFC                              41
>> +#define CLKID_SYS_NNA                                42
>> +#define CLKID_SYS_ETH_MAC                    43
>> +#define CLKID_SYS_GIC                                44
>> +#define CLKID_SYS_RAMA                               45
>> +#define CLKID_SYS_BIG_NIC                    46
>> +#define CLKID_SYS_RAMB                               47
>> +#define CLKID_SYS_AUDIO_PCLK                 48
>> +#define CLKID_SYS_PWM_KL                     49
>> +#define CLKID_SYS_PWM_IJ                     50
>> +#define CLKID_SYS_USB                                51
>> +#define CLKID_SYS_SD_EMMC_A                  52
>> +#define CLKID_SYS_SD_EMMC_C                  53
>> +#define CLKID_SYS_PWM_AB                     54
>> +#define CLKID_SYS_PWM_CD                     55
>> +#define CLKID_SYS_PWM_EF                     56
>> +#define CLKID_SYS_PWM_GH                     57
>> +#define CLKID_SYS_SPICC_1                    58
>> +#define CLKID_SYS_SPICC_0                    59
>> +#define CLKID_SYS_UART_A                     60
>> +#define CLKID_SYS_UART_B                     61
>> +#define CLKID_SYS_UART_C                     62
>> +#define CLKID_SYS_UART_D                     63
>> +#define CLKID_SYS_UART_E                     64
>> +#define CLKID_SYS_I2C_M_A                    65
>> +#define CLKID_SYS_I2C_M_B                    66
>> +#define CLKID_SYS_I2C_M_C                    67
>> +#define CLKID_SYS_I2C_M_D                    68
>> +#define CLKID_SYS_I2S_S_A                    69
>> +#define CLKID_SYS_RTC                                70
>> +#define CLKID_SYS_GE2D                               71
>> +#define CLKID_SYS_ISP                                72
>> +#define CLKID_SYS_GPV_ISP_NIC                        73
>> +#define CLKID_SYS_GPV_CVE_NIC                        74
>> +#define CLKID_SYS_MIPI_DSI_HOST                      75
>> +#define CLKID_SYS_MIPI_DSI_PHY                       76
>> +#define CLKID_SYS_ETH_PHY                    77
>> +#define CLKID_SYS_ACODEC                     78
>> +#define CLKID_SYS_DWAP                               79
>> +#define CLKID_SYS_DOS                                80
>> +#define CLKID_SYS_CVE                                81
>> +#define CLKID_SYS_VOUT                               82
>> +#define CLKID_SYS_VC9000E                    83
>> +#define CLKID_SYS_PWM_MN                     84
>> +#define CLKID_SYS_SD_EMMC_B                  85
>> +#define CLKID_AXI_SYS_NIC                    86
>> +#define CLKID_AXI_ISP_NIC                    87
>> +#define CLKID_AXI_CVE_NIC                    88
>> +#define CLKID_AXI_RAMB                               89
>> +#define CLKID_AXI_RAMA                               90
>> +#define CLKID_AXI_CPU_DMC                    91
>> +#define CLKID_AXI_NIC                                92
>> +#define CLKID_AXI_DMA                                93
>> +#define CLKID_AXI_MUX_NIC                    94
>> +#define CLKID_AXI_CAPU                               95
>> +#define CLKID_AXI_CVE                                96
>> +#define CLKID_AXI_DEV1_DMC                   97
>> +#define CLKID_AXI_DEV0_DMC                   98
>> +#define CLKID_AXI_DSP_DMC                    99
>> +#define CLKID_12_24M_IN                              100
>> +#define CLKID_12M_24M                                101
>> +#define CLKID_FCLK_25M_DIV                   102
>> +#define CLKID_FCLK_25M                               103
>> +#define CLKID_GEN_SEL                                104
>> +#define CLKID_GEN_DIV                                105
>> +#define CLKID_GEN                            106
>> +#define CLKID_SARADC_SEL                     107
>> +#define CLKID_SARADC_DIV                     108
>> +#define CLKID_SARADC                         109
>> +#define CLKID_PWM_A_SEL                              110
>> +#define CLKID_PWM_A_DIV                              111
>> +#define CLKID_PWM_A                          112
>> +#define CLKID_PWM_B_SEL                              113
>> +#define CLKID_PWM_B_DIV                              114
>> +#define CLKID_PWM_B                          115
>> +#define CLKID_PWM_C_SEL                              116
>> +#define CLKID_PWM_C_DIV                              117
>> +#define CLKID_PWM_C                          118
>> +#define CLKID_PWM_D_SEL                              119
>> +#define CLKID_PWM_D_DIV                              120
>> +#define CLKID_PWM_D                          121
>> +#define CLKID_PWM_E_SEL                              122
>> +#define CLKID_PWM_E_DIV                              123
>> +#define CLKID_PWM_E                          124
>> +#define CLKID_PWM_F_SEL                              125
>> +#define CLKID_PWM_F_DIV                              126
>> +#define CLKID_PWM_F                          127
>> +#define CLKID_PWM_G_SEL                              128
>> +#define CLKID_PWM_G_DIV                              129
>> +#define CLKID_PWM_G                          130
>> +#define CLKID_PWM_H_SEL                              131
>> +#define CLKID_PWM_H_DIV                              132
>> +#define CLKID_PWM_H                          133
>> +#define CLKID_PWM_I_SEL                              134
>> +#define CLKID_PWM_I_DIV                              135
>> +#define CLKID_PWM_I                          136
>> +#define CLKID_PWM_J_SEL                              137
>> +#define CLKID_PWM_J_DIV                              138
>> +#define CLKID_PWM_J                          139
>> +#define CLKID_PWM_K_SEL                              140
>> +#define CLKID_PWM_K_DIV                              141
>> +#define CLKID_PWM_K                          142
>> +#define CLKID_PWM_L_SEL                              143
>> +#define CLKID_PWM_L_DIV                              144
>> +#define CLKID_PWM_L                          145
>> +#define CLKID_PWM_M_SEL                              146
>> +#define CLKID_PWM_M_DIV                              147
>> +#define CLKID_PWM_M                          148
>> +#define CLKID_PWM_N_SEL                              149
>> +#define CLKID_PWM_N_DIV                              150
>> +#define CLKID_PWM_N                          151
>> +#define CLKID_SPICC_A_SEL                    152
>> +#define CLKID_SPICC_A_DIV                    153
>> +#define CLKID_SPICC_A                                154
>> +#define CLKID_SPICC_B_SEL                    155
>> +#define CLKID_SPICC_B_DIV                    156
>> +#define CLKID_SPICC_B                                157
>> +#define CLKID_SPIFC_SEL                              158
>> +#define CLKID_SPIFC_DIV                              159
>> +#define CLKID_SPIFC                          160
>> +#define CLKID_SD_EMMC_A_SEL                  161
>> +#define CLKID_SD_EMMC_A_DIV                  162
>> +#define CLKID_SD_EMMC_A                              163
>> +#define CLKID_SD_EMMC_B_SEL                  164
>> +#define CLKID_SD_EMMC_B_DIV                  165
>> +#define CLKID_SD_EMMC_B                              166
>> +#define CLKID_SD_EMMC_C_SEL                  167
>> +#define CLKID_SD_EMMC_C_DIV                  168
>> +#define CLKID_SD_EMMC_C                              169
>> +#define CLKID_TS_DIV                         170
>> +#define CLKID_TS                             171
>> +#define CLKID_ETH_125M_DIV                   172
>> +#define CLKID_ETH_125M                               173
>> +#define CLKID_ETH_RMII_DIV                   174
>> +#define CLKID_ETH_RMII                               175
>> +#define CLKID_MIPI_DSI_MEAS_SEL                      176
>> +#define CLKID_MIPI_DSI_MEAS_DIV                      177
>> +#define CLKID_MIPI_DSI_MEAS                  178
>> +#define CLKID_DSI_PHY_SEL                    179
>> +#define CLKID_DSI_PHY_DIV                    180
>> +#define CLKID_DSI_PHY                                181
>> +#define CLKID_VOUT_MCLK_SEL                  182
>> +#define CLKID_VOUT_MCLK_DIV                  183
>> +#define CLKID_VOUT_MCLK                              184
>> +#define CLKID_VOUT_ENC_SEL                   185
>> +#define CLKID_VOUT_ENC_DIV                   186
>> +#define CLKID_VOUT_ENC                               187
>> +#define CLKID_HCODEC_0_SEL                   188
>> +#define CLKID_HCODEC_0_DIV                   189
>> +#define CLKID_HCODEC_0                               190
>> +#define CLKID_HCODEC_1_SEL                   191
>> +#define CLKID_HCODEC_1_DIV                   192
>> +#define CLKID_HCODEC_1                               193
>> +#define CLKID_HCODEC                         194
>> +#define CLKID_VC9000E_ACLK_SEL                       195
>> +#define CLKID_VC9000E_ACLK_DIV                       196
>> +#define CLKID_VC9000E_ACLK                   197
>> +#define CLKID_VC9000E_CORE_SEL                       198
>> +#define CLKID_VC9000E_CORE_DIV                       199
>> +#define CLKID_VC9000E_CORE                   200
>> +#define CLKID_CSI_PHY0_SEL                   201
>> +#define CLKID_CSI_PHY0_DIV                   202
>> +#define CLKID_CSI_PHY0                               203
>> +#define CLKID_DEWARPA_SEL                    204
>> +#define CLKID_DEWARPA_DIV                    205
>> +#define CLKID_DEWARPA                                206
>> +#define CLKID_ISP0_SEL                               207
>> +#define CLKID_ISP0_DIV                               208
>> +#define CLKID_ISP0                           209
>> +#define CLKID_NNA_CORE_SEL                   210
>> +#define CLKID_NNA_CORE_DIV                   211
>> +#define CLKID_NNA_CORE                               212
>> +#define CLKID_GE2D_SEL                               213
>> +#define CLKID_GE2D_DIV                               214
>> +#define CLKID_GE2D                           215
>> +#define CLKID_VAPB_SEL                               216
>> +#define CLKID_VAPB_DIV                               217
>> +#define CLKID_VAPB                           218
>> +
>> +#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_C3_PERIPHERALS_CLKC_H */
>> --
>> 2.37.1
>>
