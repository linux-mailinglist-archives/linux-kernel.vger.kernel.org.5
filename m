Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148337E3C23
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjKGMMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjKGMMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:12:20 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0192324F;
        Tue,  7 Nov 2023 04:10:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFLsa86YGNoSmzVLVxqPTMdj5qxI7/Lx0vVl2Q3sThPk3B/9mcyp6U5n0h8X7kEt57LCO6ULqpi6WsnrO/in20TeVxKVlx8pWKo2EPIWjn1Eu49h6SnSj8jRKn674ITKwFxni9PTnnbH9sBoMDOAeJKfGF97hiqSmn8FhAraFFKHWY5lFnScWt1mYsmnGGmmeYVTrUheOn7GOOMi8FpAQvE9MVfoLjwoWC3LjXym/4NvEji6Kyzcr3Xlv2k2o37y+adfSHYs3x7SC/Lh6OY8EJb+ps2L/seGh9MeRntqjAw/MICizqOFvR5O1mYFmn944Zi30951QQuZBeojVkJ04w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yh95DnEO/9RHOPOzXIYLGsC+ZT38hNI9PwHv1cTyDmY=;
 b=LPx5B7W/TnohE8q5DI7ljDIz78fnWVTKtFs+0qEgKTGl9bACWf5bowFJ55moGj9Egd1OjoJJi2A6g8WOGuZqlRZYEXJrcKjxhj3Ztt0GRMFMmDs+j/wocGowvaKfo5kz9hprLyB1jZ0GTfRpSiuFa8pGth/PUyK+66yO9fCXD1zlAm+Bza01QBOsEV1Mn39Nl9frel1zbueh0IDzmeIPbR7x69HEOK87HrSpMNemN9xB0JbPwb7jvGcNdB5MuP6NfuaNDwjbRgLCI6+e1xEQUbOSGHZ7XUmvvLCpBcsywmqKE0bC0N+9DpFL60bGsSjDMt8Mb2xXgUu3DSvGOv5KmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yh95DnEO/9RHOPOzXIYLGsC+ZT38hNI9PwHv1cTyDmY=;
 b=b8XME6k6W7HBf4tPto//+wjqDXdQPrlp1XTuYxg6eGKSPgyLILTaKWAnBiqg/XVH8pTI0VngQsg54ixyKsyciY+f/lEi8Y74Gyco4M2R4m6cz/HwUgnu3R4cxReDP7SgtMCAaiEjmM/ToDw/+UHS7A+xctP0qvJU1C3Cyl7hA1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 12:10:00 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 12:10:00 +0000
Message-ID: <92d95425-5bae-4ada-8fc3-966e7bfbd815@amd.com>
Date:   Tue, 7 Nov 2023 13:09:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: Add new board description for
 MicroBlaze V
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com>
 <20231106-hangnail-prankster-a04e713bed35@spud>
 <4223470c-5596-4168-9c89-e701559fbbed@amd.com>
 <e9fef49e-c0ca-4f7d-9618-151216e25280@linaro.org>
Content-Language: en-US
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <e9fef49e-c0ca-4f7d-9618-151216e25280@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0119.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::48) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: a078c99b-4d1c-4bf1-c4ea-08dbdf8a7725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Emb5u8Xd9fefYZzjXbHKJMBNApIJSBKdPI1/Nj06OXWIMyaNezL2rON2D1vFwUTB8mzONpY7BzgKvxcpoM8AfJCz/epB8K04GadeTlPpOKpI3bIQpd49LbRO391bda+QbHpNFouJTw8iXN/rJgIadNOesDhZMj1VJX8whN5Dg8aTm2vMNiydkNTUArp4eqZSICozMpbok1qvPG7x6k+lN3pMamjeCHCQFGy25UssDzkj1UFXn1WGrRByws4sx/euglpnXeQs3ncVRMpriE2sQROCVUMQwd41OZZV5tB+uhiB7JKJDgO5CtlxDtO+507QqHV+NGqylijJ1L5sffEXjH95xtNuMnWrehE/Pn4NgRNRWDNE6cGpF72JEGwnOfkRNJF3Mk3vMeyYg8m5Oel8txvvU8OdP1g/UXNX+WHzv4UrpB/oN/YBqIyo+/H9ISr+1kdOvWoo9XpWu+qZGJYEDCPMp25CqAcF4etYUpEG83ojpD//4GiIA6dTRHHeUtC/u0RLzWalbjHi5YCnc32AcovbLAVI6ohD32UjR9aVzY+yikfF3v1LS8QeL50QZ5z4cXpoTxrGh+//zviLJhnUZwIhTi7r05b0bqN/3+TIkqKo0UMdNyfWMkiBx438aGRihZWOQqjS7SnNaMK97rFYsL1aUnSHJDMLU0glPlSjRKTG7pECpbwvNhZncbKlz9vY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(53546011)(6512007)(6666004)(26005)(2616005)(6506007)(478600001)(54906003)(66946007)(316002)(66556008)(66476007)(4326008)(8936002)(8676002)(36756003)(38100700002)(110136005)(2906002)(41300700001)(44832011)(7416002)(31696002)(86362001)(5660300002)(966005)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXpVcys3OWN1YkM3UGRoSkxacWlYS0pCWm9rTVJ4dUl4ekJ0bHBxanVscXNk?=
 =?utf-8?B?eTg1L1YyMWYvQWo0NWxUMkFFR2Z2M2hiOXZKcG05dWhQTU5VWG1mb3M1T2NM?=
 =?utf-8?B?cURIK1F6dmpZVzVXTXl1d3RHenBKMTB0UjlvaHdoSHIyWTBmTFZDbEF5azZN?=
 =?utf-8?B?MFRLdmJHOFZ3TFdNaXJ3azQwN1lFU2dkRHZBaHM5ajR1RDBlWHRrVnRnU2Rk?=
 =?utf-8?B?dThqZDd3UHZxQ1J6ZVZJb21uRERORHlDUGdzSHF0NDYwK3V6R3crSjlMWkI1?=
 =?utf-8?B?MWdPR3JNZ1l2b0pBQ291SmtRTFRtRDg1K1krVTNwbm90MFFRRlFSVyt5emVL?=
 =?utf-8?B?OFViVGlaMGFZMjR2UTM5UCtlMVkrYUd5VjNTTUMyTFdveDBqZzlBTjBoZWZv?=
 =?utf-8?B?MGs0YXdMOWt6L2RENmRNYjk3Skpvb1lOTy95aFBiUTRFMUFCM1NhdzNFTnI5?=
 =?utf-8?B?Uk40M2VzeEdzZVhTMWhWMGZnRGRZRzgwSzZZUzBoSVIwM2puYmxwUDFhSDdo?=
 =?utf-8?B?bExiZlR6YkNZd1k5VmVKenVhU1Brb3g1dEw3UDI3RDJiOENBNTg1YUdxTmZ6?=
 =?utf-8?B?dXF1Ti9maVN3OEtuc2w2Qm5xSHFndEY2U0E1Z2V1Q0E2TUQ1L0RrRi84c1Qr?=
 =?utf-8?B?bC83aHphaVh1ZFBnbnFWdlhhQVRtRzlieWxVQU44Y05PR0Z0bU4yWTlKRjMv?=
 =?utf-8?B?MnU3MG83YjMrOFVWL1haUDV0eDd0U3pibnVWaVF0REVoWG1FbzZJOXRmWlpm?=
 =?utf-8?B?Zm5kNk9XTk1FOE9BOFhJbERoOTFKK0w3NkZ1VzVKblFoZWNHamprRC9uR0pt?=
 =?utf-8?B?R3dDSWE3bkFOUE43OW5xNmJ2UUkvck5xQ0xlNVZUUEJsYzZ4T0I4dVdYMnEz?=
 =?utf-8?B?MnFoYUpyQXFpRFpUaUxyU284dlVkZmRqa2FnUm9IMHBYYWdYRGExWGZodG9N?=
 =?utf-8?B?NXNOSjRYbFhpYlljQllMbk9PZGVmc2V1UHFHNXFYKzhwRmJDWmxXWEQxYUhM?=
 =?utf-8?B?bitJREE0OHlxU01BYmV5Z1JZTmpNWVN1MlFBYnlJWHRQamRobVAxcWV4YkN3?=
 =?utf-8?B?d2xKM1hPeXJ4ZDIxSi93RnVZdVhuOE9VenpUbkJqSkZ6bzdKVmNob2RCOHU4?=
 =?utf-8?B?MlFEZklnMmx2dEl3MktpZzI3TmN4Tlh1MFVBQnhtdUI4Qk8vbmRPUks4d2Vm?=
 =?utf-8?B?WWwyRk1YZWVhRTV3bWtHb2JXeHJ4Qm1UajA4TVVDOGNkMGUyTDUwdjY0Kzdr?=
 =?utf-8?B?M1ZmbnFuQXFqNGJoT3QwWTZRL1NDV01rRm0zVERtNDhiTnFKaDUrVWNPNlhF?=
 =?utf-8?B?YVhOazFEdlhrcGhlNUloRzRncm00ZzU0RHdwaVVlNHhzdms0dDZQb25RbUVq?=
 =?utf-8?B?dTRQVjdhZ2kzUE42OG1YSENyOUt4djhaUVVnZW9ISGpRN3NrVldBc0w4Njgz?=
 =?utf-8?B?VkRBM0RUdWR6VUp2a3Q1WE5hZWdQRFVGVVFpRlQvWU00amZ3YUp4UzZCQmhT?=
 =?utf-8?B?UmhGNWdyUWFMZTJqSEpiWDR6Y3EvcWt0VTBJcU1ySStocUQvYkozWjRWSjBV?=
 =?utf-8?B?c0VDR2hnckp6N1hNMjFVRnFOMVdsdTZaV1hKQjNFcnZ2cVdvN1BjTE9HOFRJ?=
 =?utf-8?B?NVVaa1lOM1ZKVFZaVkpLR1BHczE2azFUQ3k3NTdXbnRBN25wWUlJQ29yaXU0?=
 =?utf-8?B?OFlKZmVsa3NEMU4wbkpROXhZcmRHRFlBcXFEMkxKMnVtZ1dGQkhCcXRNbCtj?=
 =?utf-8?B?em5tSElrMWtQVDJ0WnZuSDIyMEtIdWI2MDY5Q1FYc2xielRUdTZFdDN1QU4v?=
 =?utf-8?B?S3pkUHZuMmNWV0JPZUhKTkhPbHorbTNyVzR3Z1dDZXREdUkxQm4xby9uSUtD?=
 =?utf-8?B?U2ZzTTlnUXhraDNhZGs1STl0TlpIaEhkY2dvazFHQ0VXUDF6ZmdVdEg2TThC?=
 =?utf-8?B?MWhwZ0RHREN6Y2ZWalQ4eUp4dzVyYm1PSnpuSm1za3NydjlKVlYrYnY1UFV4?=
 =?utf-8?B?M0JUWVlFemV5VFA0WFlzM2hLZCtvQ24vS044Ukg0STdscktva0N3TVVJTU9W?=
 =?utf-8?B?NUNycmt3UEFMa3Fzd3A5U29iKzhBY0MrU1hiaER6S3Z2RTJLRVhoYmN6RHVo?=
 =?utf-8?Q?IPYEb5kxo9w8t+tZoff94SGUN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a078c99b-4d1c-4bf1-c4ea-08dbdf8a7725
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 12:10:00.3504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIpeQxescFE9t6R6tPg5haoPmppzGxTpcTQ/jZ92d4Alb+w5EXz8JO4+CHJc2f4h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/23 12:27, Krzysztof Kozlowski wrote:
> On 07/11/2023 12:09, Michal Simek wrote:
>>
>>
>> On 11/6/23 18:07, Conor Dooley wrote:
>>> On Mon, Nov 06, 2023 at 12:53:40PM +0100, Michal Simek wrote:
>>>> MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
>>>> It is hardware compatible with classic MicroBlaze processor. Processor can
>>>> be used with standard AMD/Xilinx IPs including interrupt controller and
>>>> timer.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>>>
>>>>    .../devicetree/bindings/soc/amd/amd.yaml      | 26 +++++++++++++++++++
>>>
>>> Bindings for SoCs (and by extension boards with them) usually go to in
>>> $arch/$vendor.yaml not into soc/$vendor/$vendor.yaml. Why is this any
>>> different?
>>
>> I actually found it based on tracking renesas.yaml which describes one of risc-v
>> board. No problem to move it under bindings/riscv/
>>
>>>
>>>>    1 file changed, 26 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/soc/amd/amd.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/amd/amd.yaml b/Documentation/devicetree/bindings/soc/amd/amd.yaml
>>>> new file mode 100644
>>>> index 000000000000..21adf28756fa
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/amd/amd.yaml
>>>> @@ -0,0 +1,26 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/soc/amd/amd.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: AMD Platforms
>>>> +
>>>> +maintainers:
>>>> +  - Michal Simek <michal.simek@amd.com>
>>>> +
>>>> +description: |
>>>> +  AMD boards with MicroBlaze V SOC
>>>> +
>>>> +properties:
>>>> +  $nodename:
>>>> +    const: '/'
>>>> +  compatible:
>>>> +    oneOf:
>>>> +      - description: AMD MicroBlaze V
>>>> +        items:
>>>> +          - const: amd,mbv
>>>
>>> You don't actually list any boards here, but instead permit having only
>>> the SoC compatible and no board one. The SoC compatible is also
>>> incredibly generic. Personally I don't think this binding makes any
>>> sense as it appears to exist as a catch all for anything using your
>>> new cores in any combination.
>>
>> I think I need to define any string for compatibility because it is standard
>> property. Because this is soft core it can be added to any board with AMD/Xilinx
>> chip. I don't have really an option to list all boards.
> 
> Why? Either there is a product with this soft-core or there is not. It
> cannot be both.

I am doing basic enablement. I am not making product. Product will be done by 
our customers using this core.
There will be thousands of different configurations done by customers which will 
have products with it. Also there could be hundreds configurations done on the 
same board.

Does it make sense to have board related compatible string like this if this 
evaluation board is used by a lot of customers?
"amd,kcu105-mbv-ABC-vXYZ", "amd,kcu105-mbv", "amd,mbv"

Or I can define qemu one.
"amd,qemu-mbv", "amd,mbv"

I think customers should be adding their compatible string in front of generic one.

Years ago I have done the same thing with Microblaze where compatible is defined 
as xlnx,microblaze only. When customer take this soft core, put IPs around and 
create a product they should extend it to be for example like this.
"xyz,my-product-1.0", "xlnx,microblaze";

And over all of years I have never seen any single customer to try to push dt 
description for any Microblaze based product.

>>
>> I am happy to change it to something else but not sure to what.
> 
> Alone this compatible does not bring you anything.

I don't agree with it. It is standard property and I have to define it somehow.
If not, I get an error.
.../xilinx-mbv32.dtb: /: 'compatible' is a required property

And it tells me that this risc-v compatible core runs on AMD fpga and it is 
compatible with it.

Thanks,
Michal
