Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C26F7D07A7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbjJTFgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbjJTFge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:36:34 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2049.outbound.protection.outlook.com [40.107.6.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D34C9;
        Thu, 19 Oct 2023 22:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuF02Nc1kdUBwIMAo+eXxGbQRQJiH7LpYZMB4G9CrEWsq2MJl599gqf31o7h39NWqgs4oDCIS5CLYJDlhSbQw9BkJ0lI5ebWcrkQZEsstV52OZ2rBJO/Gsmsb06KOqBNGqU43n5dcclinmg0QYGUu2hYh5DGJIlWkxqlkR5U+B4CKQbblyB+R9dEnJHJzPjh7Iq+J9T16zN0W4/RSRBCN7kD2fKG/lTCpVcYPkzRZ2njBDKC44E3iaF698h5OiI+QRGeoqdDKuqI3HL7m9VOSujhPkARe6PTLNIuGtGQjTvZnxPS0fjg3bAZ64zUCn3sWwL+psI9j3fL8IDZHcmoug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BlfwJY3I2+SSw4EVPPGq4z3YdlMPRqvCBUd+APhTag=;
 b=L/oxdJHoyOiPmfWs2tpDqKq2uZFRU7ylnPBY0RgWXrvaAwmVkYYhWEl0Bs10wP2CfNmzZkXgkOrBvLh9a5Xq7T7/69/RY36277ccyWczh+LnMPF+0nJt76Wauxa8WyNxZh8v13F0lKbD26+tXbmrAZw+U8W7eEmfeitx/1XRFdjOmp6BarJp0Wr1SMIl9hxPtGkOL/sXtP7RuDmFFP4phOEtWLupBGWNgQ4gcQjBhp9E/55sFH/MdxjtgwEjnbkt6wN0l6XpDbHAz6NH1yNY4JDl54bOji++Wt594TwPci3OojYDGpcg0Q/6xqtrAf/ZZmAMLnjhI/+Fep5nTTEiEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BlfwJY3I2+SSw4EVPPGq4z3YdlMPRqvCBUd+APhTag=;
 b=YpjG7kGTJPc+7XKtG2QG/BOG3/puSPuHx0JrMuHlPZO0PAHJAQNgD7Us1tVYTrtPH0bVEeLV7IXEdcZW+4oH8H2cBD8hieVHz+Rjxhg6O2H0WRhfXX95loMwN/bTBdAXvV+tcAF1XCusCms4VV8Nu2Tnj+ySYJgQXYSQmL6lxaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB9138.eurprd04.prod.outlook.com (2603:10a6:102:22d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 05:36:28 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5%5]) with mapi id 15.20.6933.011; Fri, 20 Oct 2023
 05:36:28 +0000
Message-ID: <46f5f4ce-5033-44f1-bd4b-aef87535e4e3@oss.nxp.com>
Date:   Fri, 20 Oct 2023 13:38:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: media: imx-jpeg: Assign slot for imx
 jpeg encoder/decoder
From:   ming qian <ming.qian@oss.nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mirela.rabulea@oss.nxp.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        ming.qian@nxp.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1697597713.git.ming.qian@nxp.com>
 <c7995af1f91733626ff4e86f0575dea5d2ff0bb8.1697597713.git.ming.qian@nxp.com>
 <d640f5c2-8af5-4402-a981-0e962d4f2aca@linaro.org>
 <c2eb3a37-eadb-4ec6-a6c1-075d71127ac2@oss.nxp.com>
Content-Language: en-US
In-Reply-To: <c2eb3a37-eadb-4ec6-a6c1-075d71127ac2@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b56ab3-6807-4199-f9c4-08dbd12e81ab
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxubqSCqK0Cun0Lq4Y7UCIKC45Xt8V99kO2sv1m7nJ+/2vb8nV7ko+iKMGba/W0RQX2rD/xMlUzUOmjGeMOX7g8HXe9tFdBFHl3jY2AWeC+cuQzOtgZIjEbJzmtJrz2PoVk29WQV+j3NQPWBfHcvELPWCRKqDFcDQKY1iPBMKpsPcLbiwyWrPvX0yZBkT9ML26dxxEmYShMwFVGKG3pFL6++cxQasj6FYnMnydNj7/RVY+IlzywzwH+HVYHi6EEHS1/36PZAP0+Er0qNwbbuPwtVWT+rIEXWu5lUw8rAVYU4USngTGTcwSDDiSl6YSMnJAx8C392sjI2j86Wx8uSpykvbZoqATGBFR0KNs7gxm/vBoES2taMVphJIuZwpThCF8H7m3WrVtPZ3vy6Z1SVo1XgFB8WOV66IbJ8ia5jD0mEjuxFgyFsHWz4S6EUci4g4/aPrveOx32DX4u/H6Q1QYyfEQNQ27fbN36rQmT8qbJlfbhyrEvPioVZ/wERuSsIyjuOwh1NngfgxSi2fENv9cm8BYpDdMD1NousRqS6TBgtnKdfH/6xZytUCCgeJ89wRoKmx7l+fnHutmu6wGckP9ZeI7x2qWWbQhbBlYfd9o68XNnXaAZZCiC3994fnIQc3oblqegirsmfUrlvLtlNYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(86362001)(31696002)(6666004)(7416002)(2616005)(26005)(6512007)(6506007)(4326008)(8936002)(8676002)(83380400001)(2906002)(66946007)(66556008)(66476007)(6486002)(31686004)(41300700001)(478600001)(316002)(38100700002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L21aeWpyTHJmMTFaYWRZTDJlQlJZLzl0cGNHRzNtUk5FajJJWGRqeVhBQjRr?=
 =?utf-8?B?emFpTVVLYngzOEhDZE1PNW1oa0wrVndXQ1pabE5zMWQwU1VpbStpVVhjQ2pT?=
 =?utf-8?B?cGw5OWo2VGFtbXY5dEVGYjNzM0NBSEwxMS9WaTE3L0RGcXd3YlRzb01Da3Fk?=
 =?utf-8?B?MllkcWVxSGRTTHlxQVRpc2UvMnN5bEs5bFR1Nk83WWN0WlN2RnJqNytqSUM4?=
 =?utf-8?B?cGVkT2ViYWFFWGpScUVuWWkzTzhlbkh2cTJwdE5DaFYxaTVoN1pKY25EQmV3?=
 =?utf-8?B?Y3d0SFJnNkVqcm9sSUJOMmJibnJMeGJrNi9CNGhVajNzQ2NSM2N6bjFQVERD?=
 =?utf-8?B?YXFra2pja2h4THcxb2IwMzF4cFhScE5hUjZMTlNzREN6YlpKOEVCQnJ4RFl1?=
 =?utf-8?B?VnhjRkVpczRrYlpHeUVBSVVnT1MrZlVTYVlOQ1p3V3dwMGRMaGtiZHhXYWtD?=
 =?utf-8?B?c2pJaVF2bjhzVllreUxnT3lKZmRqc05IQlJFVWgzRSt2Z1Raa1FXSzdNcVcz?=
 =?utf-8?B?ZVhpZ0JQT0E1UVJaWUZzQVJHcUt1T1VUdWJpWktlbFAvZmJISFUyR05ob0NM?=
 =?utf-8?B?N01HQS9Za3p1WGRpS0w2bHM5cDZ3SURoQitmM0x0ZnRzOWdELzh4NjRNZENG?=
 =?utf-8?B?NkRYZm9MZUtnZ0ZoTy9xWTlId25tNHpwcjB6TGw4YkxKcnNoU1Z0Sm44aURR?=
 =?utf-8?B?bko0NVd3MnhoNUJBanFxVzlDWkhxZlZMZVJ2YUNtRzRKMVFMR2M2TnFURU1D?=
 =?utf-8?B?UkRPY0RrQVhoUmpJZ3NpNDY1VWo0MVpoMEtkN2htMHdtSEtXRkU0aHkvemRp?=
 =?utf-8?B?Q1lWZGVIaCs5ZHJzSjAyckR0TUM5SGJCeWdCSWNVUkNDa2hhbEVFWGhxZXBy?=
 =?utf-8?B?SExUTFBkMDJYZVZJUDI3cTZqWi9vSTZ6WHJaWnIzMTZCaFNEejNMdzZlSVBo?=
 =?utf-8?B?NFAyU2dzYjNoVGtrdEZEc1lKVHJnZnVabkNZMVg2T20wdjRuRjZvWTJYbnht?=
 =?utf-8?B?NElBZUdSNUtVM08vZkdqNGQyaElDN2svNEFOZUZod2JGbCsyZGNmZHl1aHhr?=
 =?utf-8?B?SWpITDY3UFZuRzlhcHFDcitjRWRsV3c2U0IvMkkxcmJsdVI5ZWcxK3lqZTFT?=
 =?utf-8?B?Vy9tZjBsSEs4TGtCaGphajZOOCt3QVZlTFlEY3ErcGNsU0hYblhGY3ZNcEZl?=
 =?utf-8?B?VlE2TDBzRUl6TEdFRWpSTFJpSGV0Um1ZK0xUb0VhaFRZeHZFNVA4STd5NmJ5?=
 =?utf-8?B?d21ZWk5waXMzZktldlJLOXJweWtKR244aVM5NmZWcktGYTJOR2RTbGtjSkE5?=
 =?utf-8?B?cHhkeWdzaU9zUW1nTW1Ud3dMK09jQnQyN1F1NThNa2VlU04zYTZOckVVU1Az?=
 =?utf-8?B?TUQ2eUIrWmZyMXVTc3M1NGtmOExkNFVvUmhjY1BXbTZMTWhnK3c4OFlBek9i?=
 =?utf-8?B?VTFuY2lXaFRpZFllOFNHdW1uWTRjbmc2NnZGbWNoRFZsZENTVWozWXFIczA3?=
 =?utf-8?B?Z2hlQ3NyMXU1T1AzM3BFLy83S0dQNzRIb1BsemNqdlJBdTZZSFVYd3laOUsv?=
 =?utf-8?B?aUVPM3dzN05rQ3M3MnZnNnRSVnM3L0o0K1JWNmxGQnFYR3RhYXBhcDE0QzV6?=
 =?utf-8?B?VG54OGhIZGRRQmxtOGR2SkVwaHBZT3hlZW1hQzhoK1dHOGpWd0ljUFh4UlRH?=
 =?utf-8?B?QTJQd2lmL05aOGh5V0h3eUMvZDdDdnBTbDM2M3lNNTZaclZpenpFLzF2WDdM?=
 =?utf-8?B?ZWxoaytvNGNTb2JiSTMwQkE2aWFqSitFTk9OOEJhc252OUlKU25taU1aeGlZ?=
 =?utf-8?B?U1hUMHY1Rk1CU3NheElmdnUwbmg1MWRGT0twbjhaWXduaUErYzFFQTRCSGhB?=
 =?utf-8?B?SVpZWTA1WVUrcW1rSSt3TEJ1TnMwTWRHUmtYa1JGSlJxcElUSUlseU80blY0?=
 =?utf-8?B?cTNuRFM0MlFpekxaUlVYekVDMlVyN3ZnOElMb3FPV3RtMzNQMlYyOWcwMUh3?=
 =?utf-8?B?VkVRcmpXc0pldUc1VU0zSEdFckNEek9odk5td3JFV05Wa2xRbkxKeWhTakIr?=
 =?utf-8?B?YUhMaE1PTlNxSU1mb1AwemNHVm5jYm1CbkJTSTR6NTFnYWxKT1dMSzRCN3Qy?=
 =?utf-8?Q?FkdYaJYNFH4XK2Sk5/sam+Cwg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b56ab3-6807-4199-f9c4-08dbd12e81ab
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 05:36:28.1036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPXNiwBWIBy6YUhXgFV+QAZHJOxNgxN8pjEq6H5JSrmRldjrPGWKHR/5ohRMBvwPfaW+j5ARcGxo+JG8rdWB/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9138
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> 
>>> From: Ming Qian <ming.qian@nxp.com>
>>>
>>> This IP includes a jpeg wrapper and a jpeg engine, the wrapper is
>>> working on descriptor based manner. It supports up to 4 slots, each slot
>>> can have its own chained descriptors. Host won't configure the engine
>>> directly, but fill some descriptors to encode or decode one jpeg
>>> picture. Then configure the descriptors to certain slot register. The
>>> jpeg wrapper will schedule between different slots. When some slot is
>>> finished, the slot interrupt will be triggered. The purpose of slot is
>>> that engine can be shared across multiple VMS and os.
>>>
>>> Currently, power domains and interrupts are enabled for all 4 slots, but
>>> only one slot is used. There is no benefit in using more that one slot
>>> from within the same OS, as the slots are scheduled in round-robin
>>> manner and not executed in parallel.
>>>
>>> Use the property "nxp,slot" to assign a single slot, and just expose the
>>> parts of the h/w for the assigned slot. For example, only put slot 1's
>>> power-domains entry in the DT when slot 1 is assigned. If not specified,
>>> 0 is used by default.
>>>
>>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>>> ---
>>> v5
>>> - improve commit message
>>> - improve property description
>>>
>>> v4
>>> - improve commit message
>>> - drop line making the property required, to avoid ABI break
>>>
>>> v3
>>> - add vender prefix, change property slot to nxp,slot
>>> - add type for property slot
>>>
>>> v2
>>> - add a new property in bindings document
>>>
>>>   .../bindings/media/nxp,imx8-jpeg.yaml         | 46 +++++++++----------
>>>   1 file changed, 22 insertions(+), 24 deletions(-)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml 
>>> b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>> index 3d9d1db37040..0961856bdcab 100644
>>> --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>> +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>> @@ -32,19 +32,27 @@ properties:
>>>       maxItems: 1
>>>     interrupts:
>>> -    description: |
>>> -      There are 4 slots available in the IP, which the driver may use
>>> -      If a certain slot is used, it should have an associated interrupt
>>> -      The interrupt with index i is assumed to be for slot i
>>> -    minItems: 1               # At least one slot is needed by the 
>>> driver
>>> -    maxItems: 4               # The IP has 4 slots available for use
>>> +    description:
>>> +      Interrupt number for slot
>>> +    maxItems: 1
>>
>> The device still has four interrupts, so we should allow up to four of
>> them. One given OS might want to use two or all four slots.
>>
>>
> Got it, I will fix it in v6 patch.
> 

We made an internal discussion about this, current approach of the
bindings implies that one dts node is for one slot only, and the slot
property is integer, not a list of slots. Whoever wants to use 2 or more
slots, should put more nodes in the dts, one for each slot. Therefor,
there is no point in allowing more than one interrupt in one node. Or,
if we do, for the sake of allowing one OS to use more slots within the
same dts node, we must also allow more power domains, in any case, we do
not have multiple slots functionality in the driver anymore.

Best regards,
Ming

>>>     power-domains:
>>>       description:
>>>         List of phandle and PM domain specifier as documented in
>>>         Documentation/devicetree/bindings/power/power_domain.txt
>>> -    minItems: 2               # Wrapper and 1 slot
>>> -    maxItems: 5               # Wrapper and 4 slots
>>> +    minItems: 1               # Mixed power domain
>>> +    maxItems: 2               # Wrapper and 1 slot
>>> +
>>> +  nxp,slot:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      Integer number of slot index used. This IP includes a jpeg 
>>> wrapper, the
>>> +      wrapper is working on descriptor based manner. It supports up 
>>> to 4 slots,
>>> +      each slot can have its own chained descriptors. The purpose is 
>>> to share
>>> +      the jpeg engine across multiple VMS and os. We use this 
>>> property to
>>> +      assign a single slot. If not specified, 0 is used by default.
>>> +    minimum: 0
>>> +    maximum: 3
>>
>> default: 0
>>
> Got it.
> 
> Best regards,
> Ming
>>
>>
>> Best regards,
>> Krzysztof
>>
