Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEC97EBAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 02:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjKOB10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 20:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjKOB1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 20:27:24 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2105.outbound.protection.outlook.com [40.92.102.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F851C9;
        Tue, 14 Nov 2023 17:27:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezcADoZGu/b8Osb63Ny8Q76SWxJwoC12xOOVGKw5afrxFnlsP6fNZ0Uzq0sQzzW0zoCCWaDCl3Hw7j0gKgSeTrLC5MlPZ1pZq0t/CVsC2NBt1R9y7pXW3Tk8Vi2jYjHu1Cn60OW40X8GwtKRfVF9lCCgJnA0c35V8QYBRaCRaecZlXTsQTrnXebQcLgWDNH4Xrz/aBAL39f31zvC+qluNoMXWSA174O6hc2s+KSCD2Pk+7ulU75cFoVRhlfZCuOkvoYYBznwkKNszEXCIJIIdYii/I8I4h4OheOD047G7UfMWR4U98OavwFdPsBq7Rz6awLruZE8Tek/3ASLLgKqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UyZHq7lvGQsKQ8zO2row1Zb8iCJBS4fecTloL3X4hQ=;
 b=EwsGsjc+9ONA2FF4hQvl8vk/yKIpXdRfMNvP22CEMuhFBpPH1g2nMuA8+DvWBuhNYYrdYg1NW46WYRx+NVId69geTpz3E55Bjqe8uyPP9cBRkYgVn2iMdgepdBE40m641IvACIe5jCe/j4U08/5xEjF/2FG5hnR9QMaD3Sy9b8GAjb+V+CHhcfOJ61npck+jgEKfXdjBtP1b2wQMBSG8q07uIvtGVkqIufHR4vaMTciBmxjqW8/3vcvCW0IxL+Z8u3AeVhDi4zw0+sETCCyQNrlXS8tD/tZ1umHI3FUlj6AGqWD8er73xjz4aoDY4v/4iXQJ7wIF8kVo0DzJo40ZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UyZHq7lvGQsKQ8zO2row1Zb8iCJBS4fecTloL3X4hQ=;
 b=XGw5WcwzrSMrvLhtSK6X971Y9t6SkOfbhO9aQLq1J/9te+euVqnquKIXPIkJ0PEtl5ttzd1wkfEtr3pCGhRPJsqIKwQBK9b6lHKnARRPldAveAsPV1IaOzv332JHNfxYelUMETmXuIV9cpUKym1Oivys8Jzm+a+iB+EeK7n4t6Qz/aH74iM6FYBU+DNre1HZwSSXkJk2XMmcBzhz5QCP3bgE3iAof017qxoRsa9HYdPr6H/TVAUMGqrZtSy+OneN3tMoj6sarKwRMppGGyz9RM8hYCYwgOXr4Ab+qkC5Fe8Tv0QF6smu1yYWQ1Ds5svTPONQllzW4uubG8Tvf2j51A==
Received: from PN3P287MB0324.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:d6::7) by
 PN3P287MB1815.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:19b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.19; Wed, 15 Nov 2023 01:27:13 +0000
Received: from PN3P287MB0324.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a24:3fd5:dd38:3ecd]) by PN3P287MB0324.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a24:3fd5:dd38:3ecd%4]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 01:27:13 +0000
Message-ID: <PN3P287MB03247B3C149A6C14E5326A23FEB1A@PN3P287MB0324.INDP287.PROD.OUTLOOK.COM>
Date:   Wed, 15 Nov 2023 09:27:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: soc: sophgo: Add Sophgo syscon module
To:     Conor Dooley <conor@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com
References: <cover.1699879741.git.unicorn_wang@outlook.com>
 <3c286171af30101b88f0aaf645fb0a7d5880ac0a.1699879741.git.unicorn_wang@outlook.com>
 <20231114-timid-habitat-a06e52e59c9c@squawk>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231114-timid-habitat-a06e52e59c9c@squawk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [vUNqgdIBvElvZLn7WKwYEkAjfidVtjGk]
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To PN3P287MB0324.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:d6::7)
X-Microsoft-Original-Message-ID: <bbe168a8-4867-4590-8a58-9b7ebaad344a@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB0324:EE_|PN3P287MB1815:EE_
X-MS-Office365-Filtering-Correlation-Id: 67102e2c-a6a7-4b15-3fad-08dbe579fe4a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NqSXksgKIC/2gxK/6qSxjHAYctc67LkZld71JKjFyxVgrZqWlBwAT91U6vVVUFLzT/5xgXK0irNt3B2Z+GHEqB0RN2QSfOE85uf7Ej3A6VvX0dRtBSLrKRXg2UyUabzj6Y3K1J5woEOnrrmRCQAyuONUS8jLCh8L09E/Q1njoQLV1pNoHRQ0PavKc3m3J4GOXHgNW9uBID9k3Bp0ia66vITxiV44MWLgrI0mnQ6cvuHZPiJKn0D0HktaN8fYy1lcnOYpkQxXqaq/fsPzo+3f7K/nD5p48cbYPYPiQLvzJv3CFxqXa5gsJ0+iLKdJUjow6Yl1MEeax051gIRrXI0vpnnJu1IwYq5fcnPuCZEeHFDHYiL40UrLt+BiHDGTpTCuLsnYby7E/BpjOiT3qRLfUn2FimMZX3yvd7GaO2bTsKPut9q0te+69wvFRDK9GZyQG5WdmDCWQa/tCaZ86kRWNU6mKVeoOv8MCW9+412VhaqCPqROKaVoBS9BWyk5nro90zNss9KFua9hR0KWU2J3Skx+hOffUuuYwJ5P+2Wu06Tfe90/S55BJWbtkiIe8Px7F5lI1ooHrhMxYGtYJFZgR2M1JfQOztTXFX87xWrXAe0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1NGWUVCTjBUSmt2WEl4VEowbHpjdW1yV3ZMN2wxMUpGT1RNa1FTK2p6SCtF?=
 =?utf-8?B?VWlKYkd1MFVrc0ZnUDZiWm9kWXVGT0JzN0VYUy9VWEp5KzJhOWtKNGl1T1BY?=
 =?utf-8?B?bXZhSFhEbENXaEpHd3ZDRXN3Z0dIRll6aUFTT2dCQWFkQlh6NXJ0TWVuY2Ew?=
 =?utf-8?B?T0R6aWt0SlNwSVNMaTRpWGRMM000dGVxL3dVWGdkMi9OTWovOG1jZ3BRQ1FW?=
 =?utf-8?B?SDdBR1Z3cjNsQVYyZ3RUVE1SUktkSjAyNHpZL1gwOFNHdHNXNjEyeTU3N1Rl?=
 =?utf-8?B?bE9KOTFnbUkreXVFSlcvQVd0T0plTU1GNG92OEFUenlua005MWR6bjFxTDhN?=
 =?utf-8?B?RS9QL0RQVjFLRGI3TjQrMjZ4TWFlRytwdVZxYW1EV3ZTcEkwdTB3cCs0TEIw?=
 =?utf-8?B?QlAyNU5qVjFNbWExR2t1R0hFMlNSczZKaysxNCthUUh2SnFjMTdRTzlGTjdL?=
 =?utf-8?B?ZXZVQlU4eDdjblhiNU5OZVVidy9XTFpMWVZueDF5RGJ4OHVPM09LVmNwWFRO?=
 =?utf-8?B?clAxZUFkUk81ZWh6OFhXVml5YVZzcE40QWtZNWpjR2NUZWQ0aWcyaEZoMjFX?=
 =?utf-8?B?VHgxWGtiMnlqWkpYaDYvcHV1aGJhbFZEbnFYWTQ3YlFyaFA0M0luR1ZxQWFm?=
 =?utf-8?B?WVFuU1krcmRmK0E0T2RwanptaHdPTjJTNnF4Qnh3T3BNK1lFL1BCN0l5MEE3?=
 =?utf-8?B?ZTVyMFNXQUlVaW1Iazk3dmVsU0hJd0tBNjZVVzhsdlJUbFFDcmVkb2dZd3Z2?=
 =?utf-8?B?eHdMam92eWMwR1k1WE91bVJXN2xSamRsRHAvU01yWkMrUGhwTjBCeXpEbW90?=
 =?utf-8?B?UGVVbFRWdytMNTBLQlZrazltd2NiYWJWWUZLR2dCeWdudHFNVS96SEhvK09Z?=
 =?utf-8?B?RWcvL0YvU0RCMk0yYVFONjdvcjRVWVgwTm1MRGk3T3FNMDVyY2hhZ0ovRTBU?=
 =?utf-8?B?N0lxYzd1OGZUaVE1Qlc1dkRFRW4wbFk5R3hIbWxIYS90YVpackUza3NlN1hx?=
 =?utf-8?B?SnRoeWtuTTFOMlpOYnFhTTF2Qi9xZG9oWEtmNVVSdWdRNEdSMlN3Z2ZpS2dQ?=
 =?utf-8?B?NkFBK2tJeDZkK3lpN2RCb0hNd2JyUEVadmNPV0l0dXZQWXpaRUVEakFXbEJC?=
 =?utf-8?B?c0JJT29iWk94OFhVeWx3L1ZkT3ZwUmJCR0lIc25HNW9DcTNKb3NzSFh5VEFC?=
 =?utf-8?B?dHZuK1RBdW4weFg1NTF3aHEvOGZBb2NPVi9zV2RidktSQStuS0hsQXlVZE13?=
 =?utf-8?B?aTFMaHhOWkIzbTl5cUJTSC92SlpYQ3lqVEFtdUFCOWp0M09iUTh4T21PTzdY?=
 =?utf-8?B?Z3RvMXRwWWUzYVhlSkpQUGZZVlFaeTFRMzVpLzRubzBoUFFIV3NLK3VSdTBv?=
 =?utf-8?B?azV3emUrRm53NUFacnkvZ29sdk82VjdadHNZSFp6dElHUDJraGxua2dMU29H?=
 =?utf-8?B?OXpBUENHcElqM2g5SGE1RVNFOWIxZC9iOThPeGlUeHR1MXNDRTB1WmVDb1Vi?=
 =?utf-8?B?dWVTdExRNGNXVUtHQklmOEdISzRiczdURzdQODd5T3R4anh5Y1pIQ2JQK2Rh?=
 =?utf-8?B?b0FvMUtyemJkWEFzMnRVcURFbGFKWmpWWW5mSndiVDFRM1M5SjEzakRLQURQ?=
 =?utf-8?Q?LtKsU0sAvwEPsfuqplVr3RLeBp/9dG5pdXpU4chSLtHE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67102e2c-a6a7-4b15-3fad-08dbe579fe4a
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB0324.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 01:27:13.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1815
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/15 1:40, Conor Dooley wrote:
> On Mon, Nov 13, 2023 at 09:19:02PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add documentation to describe Sophgo System Controller Registers for
>> SG2042.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   .../soc/sophgo/sophgo,sg2042-syscon.yaml      | 38 +++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml
>> new file mode 100644
>> index 000000000000..829abede4fd5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml
>> @@ -0,0 +1,38 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-syscon.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sophgo SG2042 SoC system controller
>> +
>> +maintainers:
>> +  - Chen Wang <unicorn_wang@outlook.com>
>> +
>> +description:
>> +  The Sophgo SG2042 SoC system controller provides register information such
>> +  as offset, mask and shift to configure related modules.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - sophgo,sg2042-syscon
>> +          - const: syscon
> THere's only one option here, so the oneOf should be removed. Similarly,
> since there's only one SoC, and it sounds like the next large sophgo
> system is going to be using an entirely different core provider, I think
> should just simplify this to a pair of "const:" entries.

Yes, "oneOf" should be removed.

Regarding the "enum", I heard from Sophgo people, that they will 
announce a new SG2044 chip next year and it will share some modules from 
SG2042, including syscon, clock ...

So it is better keeping the "enum" here and we may add another 
"sophgo,sg2044-syscon" later.

Regarding the next large sophgo system you mentioned, yes, there is 
anther chip, I think you are talking about SG2380, it will use 
core(P670) from SiFive. Maybe we can see it in next year also.

More news, I find a report from web: 
https://www.hpcwire.com/2023/11/13/chinese-company-developing-64-core-risc-v-chip-with-tech-from-u-s/, 
FYI.


>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    syscon@30010000 {
>> +        compatible = "sophgo,sg2042-syscon", "syscon";
>> +        reg = <0x30010000 0x1000>;
>> +    };
> Per my comments elsewhere, I think the clock controller should be a
> child of this node, rather than an unrelated node, linked by a phandle.

Agree, I will correct this in next revision.


>
> Cheers,
> Conor.
