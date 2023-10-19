Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4455F7CF187
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbjJSHov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjJSHos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:44:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A4AF7;
        Thu, 19 Oct 2023 00:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgUTGmRppPOp8np5QI1QUNoFdjfh4qFH2g5sLfY4fArAW9EOkvFxGPnRp+0qENvBESJ8Vq0RDKxufrtgj7N2lV2xXz5rVCIiWNxLVfckfxHPz6TLzfNJAAKAHmRUeWHlQ5iVzSxLN+DLWfvRYmm0TiJ/nvQFmMqm8BbyAXSnCAx8ugNB3NQiz8HBk9bJCi0k9Fmdg0EHg/0xtnIC+OEfNiu3seaO/ToLfiklQLRnzc/oVfOElF0rFuLg81UegzuKvnLVbtb8J51lOl7fnoUK/tS+R1AQSCiqRvkt15VbK9goc6mFJEi4CfPDx3eZw+bj17K+JEIqqyrjFmJz7gAEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xm2RJ0FxJtIS/bPQmzyHcpy1WxLGcnCgidG4xjxPEk=;
 b=RMggIP5PG52Kldrh0G3XeyFq4djGbofZKpDgq48bYxH1c8AgCX+g/zo1EB2YH/mRH+Ae1z7EerrevBxmUyI9U8R542osz+/h9XsGd5CxrrlSuHFG27LovJne1F5btydG10nVk2la8v3TrwIzhSPWRZ7UaCcN5ccRQEV/+w4cVLS9m070JqcLmt8nCrfErtUwQlytJkACDyRFh59ME1rM21gYZHgFb6mAr1PBjFNY/Ra4cpYvGalcuJbREInuiarMb5D5Kpvp9/aAB2Kr5K6WmvyquV4QXkIftfDfDq+cEPYVoO7ZtqwWuaGaCax89Kf85BvIfmSLejbSNZ7caLDfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xm2RJ0FxJtIS/bPQmzyHcpy1WxLGcnCgidG4xjxPEk=;
 b=kKM+IKt8UBGej0J8z03MecFUOJ0+6OrzugsbCN9rMXThSAizO1TFnxh5igtagixv+fqDa3Y1Yu5mvzLqyBQ/zGjL0ultIpZ26+YvJS0+8JjmAIb6xtUOxchwnpmIgGS+1TdxM0Op71HyTyXm2JOHQNXEQx4+5qT2AwZpJoRsmdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS8PR04MB7624.eurprd04.prod.outlook.com (2603:10a6:20b:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Thu, 19 Oct
 2023 07:44:42 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5%4]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 07:44:42 +0000
Message-ID: <c2eb3a37-eadb-4ec6-a6c1-075d71127ac2@oss.nxp.com>
Date:   Thu, 19 Oct 2023 15:47:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: media: imx-jpeg: Assign slot for imx
 jpeg encoder/decoder
Content-Language: en-US
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
From:   ming qian <ming.qian@oss.nxp.com>
In-Reply-To: <d640f5c2-8af5-4402-a981-0e962d4f2aca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AS8PR04MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0636f9-8e10-4bed-2f92-08dbd07741c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WI84gJQRNBzFH0/mVEkkEj2MLVT1n3ojOMgdYCQmlNGAV2o30WVcnrFPdmyLnFhAKpXXu5WfjCMH9QrvlxdgkEIJ3dO60Cs00OOs9qOpPg4uTgoSfpoGFfvS2WTT3W3zssfbo9eKGKx0NuH++y8/kmqEPKdJ1k7Ye88mNZAEVtAyRhRGM4fCtjzxPo1wDqBHOIKNVC9TKUymroJQr2FeUycMwSXpwjzgtDJ3wWZenf3aVlCjdWyqB599l8hNccGp+T6dVfUOEyUQx8loBEA8QNUMR4wbUEemQveb5O1WtcQpU04VZKFYrYPDzu5iP/Utn8AtLCykUwAT7RVCPJkRFGM++yCyC/1vWsPb1ut4W7jK7AXXpcoKx5awbBvD5BJBklwOzRO0YY6bpnDolTEVZckysyDaP5X3nnmluJc3rflrG6QLYWYWZ5ncHXd5gJ2OuHmYoZslKi5TCi0J63WIoNkmv3LA1QMY/nckzaZszQXjXh9gGMujfVZX7uwRGCaE4unCqjZ9j0iD2OLGbdHWxs/7vNV74nuodcPa386AXrYQcz0D0Hd97qfC790MxiBmBcsNTrCOUMZQhyrdNjIhONiWczqfxig/JPVweoPogSLhucPL+JcV7VP0EYWtmoBYxLITX8Wtwzxe5GQV01uaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(7416002)(2616005)(26005)(2906002)(66476007)(41300700001)(8936002)(8676002)(66946007)(4326008)(66556008)(316002)(6512007)(6506007)(5660300002)(6666004)(478600001)(6486002)(31696002)(86362001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekZHMC9yYi93UDJYTW82dm1BZmIyajMwOURFVXAwRW1UNC9CWW0zNnlWYkw3?=
 =?utf-8?B?b3RKdTVpb283U1dlalpyNUZSUmtQTGwwZzFyZzVpOWwvcjRudEtUQWRIN2t5?=
 =?utf-8?B?Q0swaXVGNHZDMzBlaFR5RTNkWisxR01kNFRwR3M0NEUwNmhzdmg3VG9ablhC?=
 =?utf-8?B?S296S3ROTStZVTNGdWdSdVB1QkxDcHlTSnNRYWxKSElLajhGQ3djam1JR0FM?=
 =?utf-8?B?ZkFFMUpWNzVzZFJFamR5dE5obklUZEVvNFJmSVBVZzRjamZOazB5cXNGdTRP?=
 =?utf-8?B?WG1XMnlNaEE4Z1RpbXBFRHlIQ0NnVDZHK3U4ZDgrRzhsZjRLZXlZN3JlWUoy?=
 =?utf-8?B?MzI1RTlmelQ2SVZDaDVFMldUc2ZpbVNMUmEybjlQUWlVUmp6SHU2WGswTnE1?=
 =?utf-8?B?QytPdFVTUzg3Uk9uRDhKdW5hbkVGQkJ3RWE5WFVidGpjRVA5R2ZvcVlueGVx?=
 =?utf-8?B?S2Fvajk5Zk1teUdITHdBSXVLcEJYZ2JBdlJPNXY5aFUzL2gxNWFXRktLUThy?=
 =?utf-8?B?SC9mMVJJZXNyL1JVeGtiN1VhWEJYQVVnQzdGNHN1ZXVqZEc4UXFPY2dTU0Nh?=
 =?utf-8?B?dU9RdzFiVFgrWkxqSnVMVDkvdUNnTmJWYjdIakxSQ1B2YmoyZnpIS2hXYmxP?=
 =?utf-8?B?MnVrSHRHb0dHRlJpZDkwZXJDYWs0R21IbkcxRC9OYk5jQTMvTEczNHRSVVlE?=
 =?utf-8?B?N3cxNHkzMHR2KzBZdnJzVHlRL2pEYnQ0TUwrQm9oQWx5NkVyN0FGZ0d6UjFF?=
 =?utf-8?B?RCsyWEpPTEFGVjV2YXArdXRVL094Z1grK3hLSkVJc1VOREY1R2txMllSWkds?=
 =?utf-8?B?QVMzSGkxTS9YWWdYNlVranlvbWhjRWhRU0R6R2F6VmFZaFBqWXR4ckZNc1Br?=
 =?utf-8?B?V0l2cHkrMXlNNGdQb3ZXUU1zZlRXL3FhcE4vWXpKU0dxcjBOMGVCbFpsbUdj?=
 =?utf-8?B?c2ExeWF2Wm9wckpsTEhWZjh3dWw1NURFNWtNVXg3Ny9wakZvQmVaUHl3c05G?=
 =?utf-8?B?K3krUFM4RDJLTXJSWGJEU2h6MEtJejMyTmZoekhGNlo3cEdwdk1QejBSSDZo?=
 =?utf-8?B?bHp2bitBZHRBZ2RBcHU5Q2FoVUxZaVM4ckdjeHhXSExqWVdMMWlBeVhDVzBH?=
 =?utf-8?B?SGxmT0xCN2JBTGkybFU4RkY0QWhYTnViTHdGQ0twWHRGejZVSnUyaGNyMm1n?=
 =?utf-8?B?bjdIZ0MzN3I2YUJPVm9YWXVwbEp5MXdSYTVvMElIVTM2Mm5BRTFmZ2F4N1Za?=
 =?utf-8?B?UVNpbWJnYjZwWWFEbC8vVERsT09SOGFMaFlHeXg0dmZQZmxid2Y2THFHUjlR?=
 =?utf-8?B?bWxJYUZZQ3ovUUZVcEJOb3J3VmZjdDhlUDBWMHpEckJaQmdlQ1hzMzBNcVRq?=
 =?utf-8?B?ck1kVmdlTnFsQURSMlRNU3NTV0pLZm42TE1EQUcwQlRucnl0SU8rOGFUYnhp?=
 =?utf-8?B?VTcyS1R4cHh1WnBYanpvRTZwdjNzQm5IZ3grRDFtTWFzQUV6NVBpSndQWFhn?=
 =?utf-8?B?aG5UM1dHRGZOM3NqeUxaWVVkU0lrZ3pYM1YvY1JGZEh2K3RueVdKV0NaTEFG?=
 =?utf-8?B?bXFLL2pkaFpmTWhVcXBhZXI1TUN4YlA4S3B6MDZ3dlBiSVJOUFZxS2xSbWZp?=
 =?utf-8?B?dDJPNWh5OXhuaC9TQmQ0ZnJLK1YxZG9vUmxVZCtjZ3l1NWtxOGE5KzRwaTEv?=
 =?utf-8?B?Q2hOZWF0cVNpVmRRVGREMXhmWURCZzhFSm9LclVKenA3SEI5UEsvZVhaamkr?=
 =?utf-8?B?TTk4Wlh6bG1GOGM3bVFacWg0QlpUVFZtMWhVMmdEdjhhbzByUGk4RVdmZ2RL?=
 =?utf-8?B?NzgzUDJRSi9WaEM5RDVZeDJLTDdTQkdOVkNoTkFjTVJyRksrQkNnRmk2Nzhz?=
 =?utf-8?B?OTM4NG9hWURuMytsdERiMFBzWlN2NC9rUm9kY1d6TzdhZ3ducFNTaTlKNHhx?=
 =?utf-8?B?bHozMW1BRWdjY0RIYnpEanRrdit5NVRoNEpGQm5hZTZ2T3gwU0ZBK0lNS083?=
 =?utf-8?B?aXF3TnMwTVdOaW5YUUlsdUJzUlNmREJIT0R0cVYrdk43aW9PWTA0bU16YUJD?=
 =?utf-8?B?VjdBTEk1b1IrSmZ4NTYrMmV6Y05wa2U1U1dsNndlcytKU0wyRVZ1TXl1ZHNh?=
 =?utf-8?Q?SQLskHGMEEwa9w1cZfQfEXdCr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0636f9-8e10-4bed-2f92-08dbd07741c5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 07:44:42.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhzV0msVQYu8zZEWUrljNYhX2n2WWrG9eFsvwPs09GUkpBi480IaIOneAO2v8AVroiCmbjkd401oQc0vC7l3lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7624
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Krzysztof,

>> From: Ming Qian <ming.qian@nxp.com>
>>
>> This IP includes a jpeg wrapper and a jpeg engine, the wrapper is
>> working on descriptor based manner. It supports up to 4 slots, each slot
>> can have its own chained descriptors. Host won't configure the engine
>> directly, but fill some descriptors to encode or decode one jpeg
>> picture. Then configure the descriptors to certain slot register. The
>> jpeg wrapper will schedule between different slots. When some slot is
>> finished, the slot interrupt will be triggered. The purpose of slot is
>> that engine can be shared across multiple VMS and os.
>>
>> Currently, power domains and interrupts are enabled for all 4 slots, but
>> only one slot is used. There is no benefit in using more that one slot
>> from within the same OS, as the slots are scheduled in round-robin
>> manner and not executed in parallel.
>>
>> Use the property "nxp,slot" to assign a single slot, and just expose the
>> parts of the h/w for the assigned slot. For example, only put slot 1's
>> power-domains entry in the DT when slot 1 is assigned. If not specified,
>> 0 is used by default.
>>
>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>> ---
>> v5
>> - improve commit message
>> - improve property description
>>
>> v4
>> - improve commit message
>> - drop line making the property required, to avoid ABI break
>>
>> v3
>> - add vender prefix, change property slot to nxp,slot
>> - add type for property slot
>>
>> v2
>> - add a new property in bindings document
>>
>>   .../bindings/media/nxp,imx8-jpeg.yaml         | 46 +++++++++----------
>>   1 file changed, 22 insertions(+), 24 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>> index 3d9d1db37040..0961856bdcab 100644
>> --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>> +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>> @@ -32,19 +32,27 @@ properties:
>>       maxItems: 1
>>   
>>     interrupts:
>> -    description: |
>> -      There are 4 slots available in the IP, which the driver may use
>> -      If a certain slot is used, it should have an associated interrupt
>> -      The interrupt with index i is assumed to be for slot i
>> -    minItems: 1               # At least one slot is needed by the driver
>> -    maxItems: 4               # The IP has 4 slots available for use
>> +    description:
>> +      Interrupt number for slot
>> +    maxItems: 1
> 
> The device still has four interrupts, so we should allow up to four of
> them. One given OS might want to use two or all four slots.
> 
> 
Got it, I will fix it in v6 patch.

>>   
>>     power-domains:
>>       description:
>>         List of phandle and PM domain specifier as documented in
>>         Documentation/devicetree/bindings/power/power_domain.txt
>> -    minItems: 2               # Wrapper and 1 slot
>> -    maxItems: 5               # Wrapper and 4 slots
>> +    minItems: 1               # Mixed power domain
>> +    maxItems: 2               # Wrapper and 1 slot
>> +
>> +  nxp,slot:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Integer number of slot index used. This IP includes a jpeg wrapper, the
>> +      wrapper is working on descriptor based manner. It supports up to 4 slots,
>> +      each slot can have its own chained descriptors. The purpose is to share
>> +      the jpeg engine across multiple VMS and os. We use this property to
>> +      assign a single slot. If not specified, 0 is used by default.
>> +    minimum: 0
>> +    maximum: 3
> 
> default: 0
> 
Got it.

Best regards,
Ming
> 
> 
> Best regards,
> Krzysztof
> 
