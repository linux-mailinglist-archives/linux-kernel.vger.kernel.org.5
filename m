Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D4F7E3AC9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjKGLK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbjKGLKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:10:23 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E2991;
        Tue,  7 Nov 2023 03:10:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1E+b34CEthVDDUBcAia1UBitvY9qUFZ4jxbyKuPbXMt4FA6vWIp29E6VvtdD3in9ARj2vN0HFFX2MVNU2wO0aZbJE9Cpm46AanWBLMoNWDqDVAVgm0q4bgyiTiO0UJGqHjwrxzZqvHM9jGjeANBsZ1o0JLW4rEaOshucfqbxD8nH5sya3jTMQN1+G7YF8mt29Jhys4cUl+m46+Eust8J1GKuUr23ONXX8ZXxPVaylHF7ZotgTxALWtijm4B6r81CJUDqf1IQhiB6wESMJqQeZSWmTULeEIyOkmORabIQHBhvWDSF9NAVTrIHVZB2Vwbg2NPgp/zH9yRR6Uva7beZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br1AYWFxhpKOhLG5mHO3Sjetvq0Rkpp8h2N/KaB1j4M=;
 b=KS9VLw+g0+ZpGpSgfQTGf8f2khyy77MGDXdrBnrYSmV8sM6yNfHS5ylSbYavdxXie3Ln10R7aPkIWWJDALOOunoEhnNT+LpbqKlVar63kI5OB3hol2SFBHAuImFj9WcpHRGkqpKlJ11XWgkVSA2ews2+1DRu07Y0wro0/MJdSmvkJlhqG3C0KwwAoacAodQYB9KKMOVKUnWtWObT4HSxPiduXQ7oBFHaaudJxsCO/gsxvLFsi5p/rkXzzst3I+QAT13AyZC2geSc/jiSxQX5fZnWj6UfZ8f2hS9D6uBvxoNC1nb8VXyobepYmyZbSda4otzFdQWQkuVWUjkpWbRCbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br1AYWFxhpKOhLG5mHO3Sjetvq0Rkpp8h2N/KaB1j4M=;
 b=GQzhhTEUW4prIirDrwSfDxPisTAT617oJ3njcf+zz8jeN/8w1VfJ8CoJcEH5Yiu+xK8ny84LluEXLrO646yihU6l7PSnYGAQGFz7032rxJ7edzZEkVS1De5FmD1WINTVuPEfRbupg/4ukhvgiGxPVm1uUblDx/eDIYtAoVXahjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 11:10:17 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 11:10:16 +0000
Message-ID: <4223470c-5596-4168-9c89-e701559fbbed@amd.com>
Date:   Tue, 7 Nov 2023 12:09:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: Add new board description for
 MicroBlaze V
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com>
 <20231106-hangnail-prankster-a04e713bed35@spud>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231106-hangnail-prankster-a04e713bed35@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0245.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::18) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: d064c812-f974-4da3-f32a-08dbdf821ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mg7nkD6xhfND0UBMxbrtHIpPSkXnLH1AKPOHnd3ejjXy3T/db6BE9fqxI8pwejDipCm6uPbI4pRxsBsQRe6SQQge7+XW6Op+I9dnWW0g2SmE4+l0ywUtMgzTm+El7KkmD5d7gpoiar4xNlR0s8r+DhC9OEvEECsux7ZE6/Hfr+judfYh9BFTW2rNguWxpwG9VDgtzc2CPi+lIyaYfe/Lys661Rhzhs8qtmZqUQDriceml/98XO360LrycCtyFNPz0WwOr7xR4BZCkS/MkBoLVFbhca/fuNoDBArrrmSTHkm3IHnBdeVr81seULgHXXhcw3ZLGsR7IopNYZQK68tHjfPReLEYnRs3sz7OiYiEOA0E3agCurWfso8Ry2scuz/AXBMDggc7+F1jl+bvm//A7z2iQmdsNMZF7fDbwtx77uo5gCSMYRnLVr8Ur0eKAVgALFZRrgo4AfjxFXcgX0aHndvsykAERVgKqZXC4Sb222Ymev2lCvhkhWjmEcV2Oggx+hWqDv3OzILTdWs+L8cLhwTEk7yaDR+PUfgb3J2mZ3P1Izw/1uCRCQYbHmR+pDYEjL3kfv8pCI8th6vq9K0oQkCT7XPu2UPJgQpOJkzBAqUDEl5owgK652BxZOiiOy4ycu1rQS+EJ++vNQpIWOwTGRv3eZphALEYWVxQmXpdgoGKbqNxYOHUUr8Ie+vXElq4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(31686004)(53546011)(66946007)(6512007)(26005)(2616005)(478600001)(6506007)(8936002)(4326008)(8676002)(316002)(66556008)(54906003)(6916009)(66476007)(966005)(6666004)(44832011)(6486002)(5660300002)(41300700001)(38100700002)(86362001)(31696002)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGtWbVRrY0dIVFNXMHc1bmtYUDNzVVdwZDNTM0hNRFc4Q21VYmR6MnRSQ0Vh?=
 =?utf-8?B?bWFIRW41RUx3MHFRQWduL0lHTHRXTnJVOTBHZWMvT2dIa2ZrRC9oUEVlOGFy?=
 =?utf-8?B?MExwQUZCTVZvSi9ha2VHWXQwZC9YQzlFZjBScTB1Mys1UldkWVU0TkE4ZmJr?=
 =?utf-8?B?R1pNME1JN2xhbEdKYlB2VGNtSUFZUWJ4eGNOb2lnKzZSSDRQQ28yMzBxY0or?=
 =?utf-8?B?elpnZlgyOFJyUFpFdUtRWFhLYWFpMGxNa1BHd3laUkhIZVZSejdsT0I2blF2?=
 =?utf-8?B?SXVseGNUU2hoY2NleE5QUy9Mb1VQaythb1Y1eEZzMS9kaUpQNFhscURRRDB4?=
 =?utf-8?B?UHRwaWQ4TmozNVlta3pRWjM5QnUyWHJXTTkybHJYajJrdUVyTHEweDJwQ3BG?=
 =?utf-8?B?OHJZM3ZKa2NWL2hIRXlzcWxzV0hVa2VyMDVjeVV4c2dvak5vN2NZQ0x6WVZB?=
 =?utf-8?B?WUM4RFUxclhReWNNSjdIWkxqdnJJZGRNdTEzN0NoTEM1TmdUM0FrQVhnV0V3?=
 =?utf-8?B?Sjh6QWlray8xT3pYVmZkbzM1T3pMaitCMGU1R2J3WTNvZGoyMEZLV1BiNmt5?=
 =?utf-8?B?UzB2VHNnQWVxSlpadHNuUDVkTUNXU0MzdlBrb2MzYzRybi9aejNJZndlMXM1?=
 =?utf-8?B?d2FMS2xKYm9hVk1WMkpxb2d4dTh6aXBsdVJGZnpCa25RbjRMNGVWbHlzSGNo?=
 =?utf-8?B?eW9NSzFBN1kva29HNDYzYktWVElJajNoWC8zOU5CL081WDljaGVyUWhlUTNH?=
 =?utf-8?B?K2pON3htZXJQTTNHbERRTGJsYWdZVnpLNGIzNm9zL1IvbnFqbXZmSTJrQU5r?=
 =?utf-8?B?V1dGMExLd1RLUFVmWCtqUDF5QmExbzl2eDBlREpNZzZQRTdINXdBVTdvejNh?=
 =?utf-8?B?anJpa212ZXovcGNlZTdHSkU0Q1ZtQ3lJcnZjQjNGamgzNEpXR3hsY3JKTE4x?=
 =?utf-8?B?dXU3RHg1WEJoUW9FVDI2Nk82QnVzMDJxSnFrUjhDcTkvcXpJS08reTNOSGpq?=
 =?utf-8?B?TDlGMy8zSmdZQjNBQTBKSm9OcUYxdytkRUtDbEpGdTYvR3JDSDQzRDNBbzFV?=
 =?utf-8?B?YzlDdXhYdXJLU3dkdkNlNnFGU0RVamYyZXZKRHJzcFgxMit5Sk13YWtySWUw?=
 =?utf-8?B?QjBTT09HMzNZU291SVY1NElUaVczWGFOckJ2MklQRGZCSXFsNWZhaTBlUU8x?=
 =?utf-8?B?dG9mNWJmNjdxdzZLMlFKTDFyWXdsRG53RndDWU1GTGs4VFIvT0NQZUV4cWlI?=
 =?utf-8?B?WDY5dUVzdkkxOTJmREdLdkt5ckoxTkVPOGZCMDlveGdJM3pXT3hXMFNxcDRX?=
 =?utf-8?B?dWtpZm5KSDBiVDIwcGZLZVVnUWxRc3NkSC9LSkJ3QzE5TjZYemMzM01KSkhj?=
 =?utf-8?B?Q3hNbE1id1JxSlU2dXRzMEZ4VEQ2L1IrWWxYR1pVNTRQaXdtMGFXODZ6QW5E?=
 =?utf-8?B?WDBpL2xPSGg3ZTZjWUp1eWU5ZUpreUQrUXpqZEhHZldOLzdlQ0cvUENENXc3?=
 =?utf-8?B?Vi82ZXhxV252ZURaUG1kbVgyTktUMkx0NkMwNWdBc3FoNG5aWlgyMmVhRUR6?=
 =?utf-8?B?d2hCOExqYnJzcjl2YllnbU1jcUFEdkh1b0lCNzZ5RU1nZnVIWG5ROE9UOFR6?=
 =?utf-8?B?YUFUK29mZlhWeXlScFI0bWFlcFkrMnFDcTJmSGh4K3BoWTJXdG9DY0liYmh4?=
 =?utf-8?B?cDkyVmZ0WE1OcCtMbmxvYmNOVG5hMmtsVGFxL0QzMVVkQlhuL2pyS3RTZGRU?=
 =?utf-8?B?V0NBcmlqSDUyUlMrcHJQWTRkVm91QWZxdzJXM0xjMjF0UWNPbzJGQTE4dkJY?=
 =?utf-8?B?UnZadkREdC9wZHpKRm9meU1BMEFhODkxUThxQzk0ZjQ4ZjJyTjcwb3p2SlFF?=
 =?utf-8?B?MWFIakFuZk5xVnpmSlNkSnp4eFpRMDJzam4zYk1iSUlGTnB2ZXJhQ1NwUkhJ?=
 =?utf-8?B?RTNFZS9Sd1Y2aVAybVZFd0liVTVPS3FtY0Y5L1lCcTc3K3c3cWFGL0VPMUd3?=
 =?utf-8?B?UGdFZklWZ0xaZW4zWXhNd0xmUGVzNWtsTWtJM1V1YnpSZmNDN2lvQzVRWVF3?=
 =?utf-8?B?dDBFY3RrSVpPdEY5VjhQTHR2YUlTUll6bjFURFRPTmtINmtPdEVIZmIrMU9w?=
 =?utf-8?Q?oo+ZUmgDQMZ3VPZqEYVonTZzl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d064c812-f974-4da3-f32a-08dbdf821ef8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 11:10:16.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwqMahc2jVhNULzHF/jMBaQ88HFV6GTkk6POqWk2OaGgrX9ZAR6JiYcbcoe3kJpu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/23 18:07, Conor Dooley wrote:
> On Mon, Nov 06, 2023 at 12:53:40PM +0100, Michal Simek wrote:
>> MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
>> It is hardware compatible with classic MicroBlaze processor. Processor can
>> be used with standard AMD/Xilinx IPs including interrupt controller and
>> timer.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   .../devicetree/bindings/soc/amd/amd.yaml      | 26 +++++++++++++++++++
> 
> Bindings for SoCs (and by extension boards with them) usually go to in
> $arch/$vendor.yaml not into soc/$vendor/$vendor.yaml. Why is this any
> different?

I actually found it based on tracking renesas.yaml which describes one of risc-v 
board. No problem to move it under bindings/riscv/

> 
>>   1 file changed, 26 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/amd/amd.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/amd/amd.yaml b/Documentation/devicetree/bindings/soc/amd/amd.yaml
>> new file mode 100644
>> index 000000000000..21adf28756fa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/amd/amd.yaml
>> @@ -0,0 +1,26 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/amd/amd.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: AMD Platforms
>> +
>> +maintainers:
>> +  - Michal Simek <michal.simek@amd.com>
>> +
>> +description: |
>> +  AMD boards with MicroBlaze V SOC
>> +
>> +properties:
>> +  $nodename:
>> +    const: '/'
>> +  compatible:
>> +    oneOf:
>> +      - description: AMD MicroBlaze V
>> +        items:
>> +          - const: amd,mbv
> 
> You don't actually list any boards here, but instead permit having only
> the SoC compatible and no board one. The SoC compatible is also
> incredibly generic. Personally I don't think this binding makes any
> sense as it appears to exist as a catch all for anything using your
> new cores in any combination.

I think I need to define any string for compatibility because it is standard 
property. Because this is soft core it can be added to any board with AMD/Xilinx 
chip. I don't have really an option to list all boards.

I am happy to change it to something else but not sure to what.

Thanks,
Michal
