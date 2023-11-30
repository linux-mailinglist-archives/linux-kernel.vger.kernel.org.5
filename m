Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2714C7FEC73
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjK3KDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjK3KDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:03:14 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C10CC;
        Thu, 30 Nov 2023 02:03:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im+U1cuDEp8Ep+ozIlCXIIlzqbGA8JcQfJ2pA978bDhQ+Jp/sgfIyGAz5E0pN9Pv8wUwVOW5tyCaR9uoTACcPIWXKtQOiYAQcGDZ6nEb98B0F3WkPPadW4+mq52FOmKnAX7bepTbjFRW8mMSWvd2Pexs6jLPz0Ug3SbfftkZV5w0+aB62Y6FKVz2OGPVBmBhut6BCR5ZJb3jChQTqtKRU2E4W0qjTP+t7PwBmaD52TJsKbh+j4EOotEvcJ7Q+3L+ep1Uz5ITiHASxyH3Ly+KQS/D8nTpNGN05peU0b5Ct8geAiGdCj5S08uAiI9hTvbNM3f2Um0/Td5Z6OISKGrcvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOKsy94PqnOLQgGAFRotCrXa1D0+3BM7Ab0Y65x2I+E=;
 b=kvwAjyjLLFiswQg1duSzWtNbBZwLWMWDVtY5tXzQDjcxgtLPF/kS7XMCIhKt91c/Nnjuh6ecuibt4QThG0SjT/UPu/aIEgIoF2PXlUGYYhbqObwaOIDQukRTJlJIKUvEYn19RJlJVJemKjFZOeXSTUcH3j257dYUigT+vPvp25dMyWlAkbt/m5c3h053Nain8jlOpog7U1SkUzgV+LXjT4Jh963j9MvzRr3TGVdMxoGwxlD0pC5KAUyactBomF56JDjwsymbf7nuBEaUhaIDWTZDdu0uUope0P7kL+JhoAYcTAyWEEa2d8Zyou2MMST7mKXNIzIBj4M/U7hcLx05xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOKsy94PqnOLQgGAFRotCrXa1D0+3BM7Ab0Y65x2I+E=;
 b=UzHmqVSrwiGQVoA7PcF5wegCJPttc7+0PxYZcNXxyAbHiNirTkIYpRo+jBpLQFZUKbYpkeHzR7okRqqLi+x7l0KzwqpNpnEgSvrFfwtheexIl5ilH9F+AfL2Xdga6abP6UplhJJSeJnwKc+EAngIv+drsn7v1ESlhLBsuBK6UGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 10:03:17 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7025.022; Thu, 30 Nov 2023
 10:03:17 +0000
Message-ID: <656a0186-e06f-4518-adc2-68dfb2970157@amd.com>
Date:   Thu, 30 Nov 2023 11:02:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add missing destination mailbox compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Varalaxmi Bingi <varalaxmi.bingi@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <96460adbb99ea829a2a95c72a40118f81946a559.1701335951.git.michal.simek@amd.com>
 <79f65b96-9015-41c4-b4ee-a82526c9eefc@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <79f65b96-9015-41c4-b4ee-a82526c9eefc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0044.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::33) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM4PR12MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: 917e8697-946e-4b51-b8cf-08dbf18b9310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hiG2WX+sCcstAtTOlCYAsuK5NtWC9X7xUYOW7JH2lq2uHvde4wFgMFosAuIE0ATlsWgzTQDzySASpzXCiLK2Qk4w9kFMl+T80La+uGcr1U1ba63zUDYbEeRv6bQuj+8W3JzHZUmPFF+YsT9dYzs1r5qcfV1ROoevYZriKythThE60eHQVj0dI7pKAyiKMj9SoY5Q81Axx14XCFzaqrFefr01peoGdTCSH00tbTNCpoHVUBJhP41SJZIhdnFxmqkTZdutXveV0CF9sRqmmmo8JTDxXDY+GZ958IOcqzvepU13yH8YiaNw6VKTZWuSblqTy1fYj9gJtD++HsS9urhqBjfHIT3GN73k497IA/QGLHEb8htZ1cjRur3Jo3GkuKkPqNNchmQqgoBcVw8qACzO8JZWyu3r7i0RXPW6x6Ex7cdQjgsQXsMjT68AUgk+b+j2sCCqF0xcg95yW4EKMipLyq8cLVNf/VBdxH1dliR5jOslG/e/Vrrf2TUv8x08mVTjcL3Bn+pHelXnnYMHT38t5SNxAZUxDBLj2tKUtCKYI5pHKm3drkMeSf4PACYf/5vZHVJUQ+rb6h49rwZ3aof0cG7pwxBESHbcPTZflTP0QR3XZlJ+YDGX1WewA5sKETwb79PxraxooIrp8LtWcrWOI7m9Hg5B9DCb8fXzTogtAJgJ8o8DunLSdlR5KHGqO7XW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(2616005)(6666004)(6506007)(6512007)(53546011)(83380400001)(5660300002)(15650500001)(7416002)(44832011)(41300700001)(2906002)(478600001)(6486002)(8676002)(8936002)(66556008)(66476007)(4326008)(66946007)(54906003)(316002)(31696002)(86362001)(38100700002)(36756003)(202311291699003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXNuU2haM09OMUppUjBqWnM4eVdNMjFPajlvUHRIZTdaQUZydVcwMklRN3BT?=
 =?utf-8?B?ZXV2UWRIbmdDSFNUOXVha29GR09YazlTNDhmNDZEcEdqc1o0VURMRVpnVlBN?=
 =?utf-8?B?bVlValZMeWEwbGpqT3BRU1VqVGVIQVF5a2YzSEZqajZvMjZDUWl2UFlZSU9T?=
 =?utf-8?B?YnljQWhETUpaRUs1NTBleWphTzV0MHhudUZsTkNkMk43SGFOSHNVaEcwUjFN?=
 =?utf-8?B?cng2d1FKQUR0R0xhNkpCRmwyT05yNnE3ZEgwcG01aVVYeUdwUlV2MStVNWlq?=
 =?utf-8?B?N2R4N0pqYnpkRnUwL0FWaTZHTzI0dVVxTU45TnVWblFNTjhIc0ZSVnJHaHY5?=
 =?utf-8?B?TlkybFJkNHVGS3dTRjM3VU03RXp2ZXR5OHFDSEZFWHNKTDFyVTZWcVJCOXV6?=
 =?utf-8?B?MU15R0s3R0U3TEhSZjkyM1gyMVRsQzgrcWRUQUI1NWw1TitYM3pUa3pIdzNQ?=
 =?utf-8?B?UVRueWZFWU5tbFZiaGNSM1RzOGZTSjBKaDIyZXdtZG1meGdpM0xzN1VHaUIy?=
 =?utf-8?B?N0ViRVdtWXFxS3NlOHpxTFFDYk9sMFoyeTI3N09XTm10cWJTa21kZ3Z2M0RN?=
 =?utf-8?B?bUpZT3pSeW8yYzFHbFF3UkVNeVVIOHdBdnBXYS9QQWNxekEyTGJjWWhYLzZ3?=
 =?utf-8?B?aVAraVhpZU1SRDByZ29RaEhYSy92RFJNVHBxNG9hRWtTd1AxYm45czFQa3Ra?=
 =?utf-8?B?TG5CU2pzRzZkQ2NaQUdhRFRuNU02cVVVaGtQTGtWblBiYnRBRXhUckg5ckFG?=
 =?utf-8?B?VEY1SXowYS92T0w5ajJvWWNwZ3k3THZvaG1BajhCY1lUWkphVFoyY3hwZms5?=
 =?utf-8?B?UEVVb1Z4TElmeU4zM2RoMzAzTHJ3NEsyUGNicjZmc1BiQVRSV3QyM2UzR2Va?=
 =?utf-8?B?M1BWZWVBKy96SDlXNG5hWHkzc3E0NVNZU21kU3BSZFFMbE1oK1VaLyt2Mlgx?=
 =?utf-8?B?VVBVRS9DL0NuTGt0d2IyblEveVphR3ZwVjJuZGJGUkNLakZRNVgyTVZ3MCs0?=
 =?utf-8?B?UDZPb3N4dmdWMldGWGtRdlVuMU1XVWhwOWVuWVRJcTJ2Nk03YmNYc2V2VVJG?=
 =?utf-8?B?WnJUODdQMzIwbWdUd1Jzc0hVNXJCSWpOb2xoUUpRYkMrUStKT0U2UmZaTU9w?=
 =?utf-8?B?YjN1TEoydnc0eVp1RVdEVitCWFRadFlqd1hFTWdwT1FIdnBsVDlTRktqa0R6?=
 =?utf-8?B?OGh1WjJRQzFyZ25ENkY2QW1lQlhqRHhSYzVuOTdXUUpYNFBoUmZEcG9Bdml3?=
 =?utf-8?B?anZod3lkQ0IzbkF4by9aNE05eGdoN3pRVVFMRVRCZVNlTzZLL0ZLYnZwSWMz?=
 =?utf-8?B?d0FxWG12UW5IYytqR2h4anlVYWQwUjNBSzZuWFNVbE5oeERvRE1JaWd3NEhT?=
 =?utf-8?B?MjJicFA4eDhUUlJIM1RKaUliRkRvdGRHWGtHa0dxWFM5K1p0VGNKS2dNWlpR?=
 =?utf-8?B?T215dnJWeGpGMUROOERrYnc2U0RHZnQvWEhLZWEzTWozRWxlTjZMQXIzZkpN?=
 =?utf-8?B?S0NEcVVrUmlFMVlacitRWUlJWnVJYVFFSUNSV1AybFlrN29LL2N6ekQvYmJI?=
 =?utf-8?B?a0ljWFhoOGFCM3ErN1o1TzNJbkZzL2VqNklyMGt5R2tBRHg4NFRNdERjdGRt?=
 =?utf-8?B?dEliMUdPQzczSGVmRjd4cHN3UnJCczIrS05IRldXLy9ZQ0xZRnREaHhQdUhM?=
 =?utf-8?B?dDhGalZYc3FuNnpLSk9IVzZNdjhSYkdWRkhuU1ZhVUdyaWh2UnZuUUdXZjB1?=
 =?utf-8?B?b2ltSFlsNnhZYXlPWlE1aHVIWXZ1aVdnYU5KeGxaSmRYRG1jS01iREhQbVVp?=
 =?utf-8?B?R1hac2p5UnJCOVNQU2l4ZFcvMEdTOWErN0E4STJWRFlSY256NHZ5U3U5WERo?=
 =?utf-8?B?dTdvL2R5Y0E2UnZWNVRpa21JSkFmeTc3TnQ2N3NMRnJKQnNJRG9sSHlYRTRi?=
 =?utf-8?B?amNibGdYTk1Pc2Fpd3VZcUI1T0YvS3M0RzkxUUpSU2o1T0xseHRGZkFpZG5i?=
 =?utf-8?B?TUxzdzArdFJEVzYrMG9UcTdRdHFwMzdlRkJhbUpqRnNubjhERFNLdHR3dk9L?=
 =?utf-8?B?bUtMSGJ4SzNOeEJEZURwVGd0Q29tanQ4dHZTT3lGT1JQRlBkMVVjQ1c2Yjlt?=
 =?utf-8?Q?y+VTtaBpSkdXelAr12lZ40PMz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917e8697-946e-4b51-b8cf-08dbf18b9310
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 10:03:17.5634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ncnlj9uwnArhQFxAWBTUZ14Kl6y2yioVcfNFPNc0GDMD4lws/YWWbMfc3tWwjIZw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5103
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/23 10:29, Krzysztof Kozlowski wrote:
> On 30/11/2023 10:19, Michal Simek wrote:
>> The commit 81186dc16101 ("dt-bindings: zynqmp: add destination mailbox
>> compatible") make compatible string for child nodes mandatory that's why
>> add it.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index f5e1eb8cb3b7..eaba466804bc 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -141,6 +141,7 @@ zynqmp_ipi: zynqmp-ipi {
>>   
>>   		ipi_mailbox_pmu1: mailbox@ff9905c0 {
>>   			bootph-all;
>> +			compatible = "xlnx,zynqmp-ipi-dest-mailbox";
> 
> Probably you want it as first property. Although then reg is also placed
> odd, but it's all because bootph-all was put at the beginning.

When DTS conding style is approved I will need to resort all that nodes based on 
it. I did this change to be aligned with current style which this file has.
What do you think?

Thanks,
Michal
