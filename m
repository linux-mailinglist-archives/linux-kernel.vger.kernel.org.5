Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD0B79FE3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbjINIZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjINIZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:25:17 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFC3CD8;
        Thu, 14 Sep 2023 01:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpwfTiEvbAMKGbVi5SSuIaeE110GRYQ+snh+8gAoiehexyllA2Ac5lWDdiEM85AJxdRTDoVSx5RtlwnrsPVbMGd68Fr22aIXyDA2Ndo0PhqpICTrbkkxovNYx952pZeDjetUv6UUDYmhT5IGZLlI3aqUAS5QviSSfFocBbtdVyCUcs5dINNgHp+UE1hiTvT5s8cArWWPPGuMLHuC1RSgKkMYD4qP3NP5w8bWgXM7jcUB8FbfD1p98NuJNawE3RPj64CfYBcf1Pv1/mv4LohTiLOiXehB14hR0jHBjvyILh1p/3ApsUBs58UKMspFYW5A4dmUz+WrEYlm4GMrY527kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEe2zblQeHjVc/fksVlQTg2mbk+F3sx4RFaxRFn/cHk=;
 b=llzM/fVdx96SulBYGUPrxMwPIry9yQSP4NhXH5Rl0xlY6Sq5vfdIrXQyLeVxt2+Dc7w8v4TVYBnbDqZ/BTaleI9B6aK9zgLpJ7jpzn/As3UBGFLX41dBvKFDQ6QyapnQ5wVJAKRX1e6439Wr+sUyEQvN40HZ5GrSjr+C0CXlP0huHyWFKnNh+VjU73AcVGKa+832bTtCnqigOIqJxeFBSefEA59n+bv+5VBIIPichDMFG39iPrz7IDz+9vjobc+McHLaeiFdwBDZD8eODG1QxEJqpHn/aBBMUfApPgUWOPBcHVm2jnrAiowUzr2WtBzHgcfed7jfuRoBIGiiGxeWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEe2zblQeHjVc/fksVlQTg2mbk+F3sx4RFaxRFn/cHk=;
 b=DnKxwgHZmMajbv7D1gw68GX5AA+/1Pv8do03VdIJELuwPxzDr5i/mwvVATYZXOdaIRQuN97dsljxWOS/UBq/KNHjPiXpz6Qf48cO0xD0oAvan0iILomHzl28FZdVU/EhakqELhNbffLqtqgdTEl+Vp7n4WFnVDQfwiw61VJYV4okkkvDuEJmhd8nWgfeZu+Tghf7KViOJQj5VhzM4yEMHpLov7+5OT+KfB0Sh1KJC/W3ucMYJYPgfZq+crAZE3RArxrJGVNd24Aoc4h3/dbRangh6I4NGaZvNceBYizn+qzUyPh0delABob70Sex7AklNIGy+PlRAvb0p3stjpk+eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SEZPR03MB7220.apcprd03.prod.outlook.com (2603:1096:101:ec::16)
 by KL1PR03MB5555.apcprd03.prod.outlook.com (2603:1096:820:52::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 08:24:26 +0000
Received: from SEZPR03MB7220.apcprd03.prod.outlook.com
 ([fe80::76a:707f:e748:75f3]) by SEZPR03MB7220.apcprd03.prod.outlook.com
 ([fe80::76a:707f:e748:75f3%3]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 08:24:25 +0000
Message-ID: <bdc71fcc-2d72-a958-bb52-84f3fabb49cb@amlogic.com>
Date:   Thu, 14 Sep 2023 16:24:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: Add compatibles for Amlogic T7
 SoCs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        brgl@bgdev.pl, andy@kernel.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230914054525.1180595-1-huqiang.qin@amlogic.com>
 <20230914054525.1180595-2-huqiang.qin@amlogic.com>
 <45637012-0972-fc7b-1276-163da363b962@linaro.org>
 <cde944c4-acfe-b3fb-32b8-072740475e35@amlogic.com>
 <ff4f2b93-7e22-8b15-aaad-b7d6f8b5517d@linaro.org>
Content-Language: en-US
From:   Huqiang Qin <huqiang.qin@amlogic.com>
In-Reply-To: <ff4f2b93-7e22-8b15-aaad-b7d6f8b5517d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0284.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::15) To SEZPR03MB7220.apcprd03.prod.outlook.com
 (2603:1096:101:ec::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR03MB7220:EE_|KL1PR03MB5555:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ccea7c-7446-49e0-c6aa-08dbb4fc00ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfz3EWJv+b5KjTFHow2TZZsJPtZXb0pGGe0O1C1ZU4qidfgClp34+xj+M2wUa4TYp/+hQVoZEgbl786faidCW5ivqiewr94ga2aKUGyFi5xxfCohRUY3baGWJY7wNgYKgiuCLp/dIoKD19kpecnDz8dQQcxPE0ZKjKOVcsV2SYZ0Z7kwA+dNR/qKXQgVWdTx3Enyl3UzbIG5BOr8EovALkLH7ltaxx7OR4vpjYn7j4OrjSv4YGvR5rGDv8LbiuObz6j1xbFQDegnX9PTD7IiqHflwtUo/uc9psn8jHw94t7fSllpKb5up9MOIjoZafzhvXJQbdyFzlY1sos4iKmDiEkbRQLTiNwuqFDxHmHFIe2Rp5jhoVlWdPvX9pij7aN+sZXR1G/h+V4e3E8eNjdJfI2nBSLCLODkUUjgv2l9AFVQ/wRnnIZar8pijBAlYDO4Z4nzI13rkW7bZrkUJvaB6r7Nt0pQ2p5HdGy/DHUuMAa68En8FTjJwoS8BQBoaXoiuHIjdRLezEWMGhr+Pn5/uCk9yBbSjlEI5Iw3FDTjZ4PYQNt7o71pPWG4DEUMouXNQblNAidKMmQFsslFNb3bcyxzSNSN9t/H4TUczOV3ieyg4nIB+E3hkCJR2Mz00cowiMKChsC/jzppMH+w2Xk5lC7IQ0XWAWTWTSGDHsKN1mcXQFythQFk+/X1EU5Kwg5Ugrv8a/CCRWiegwkE1Mh938k2WuA0pTz01oOzMvI4rNXy2pQ4CySihUZMBHH+ItUF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7220.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(376002)(346002)(136003)(366004)(39850400004)(396003)(186009)(451199024)(1800799009)(31686004)(5660300002)(41300700001)(2616005)(26005)(2906002)(4744005)(4326008)(8936002)(8676002)(7416002)(44832011)(36756003)(31696002)(6512007)(6506007)(6486002)(6666004)(38350700002)(38100700002)(86362001)(53546011)(316002)(478600001)(66556008)(66946007)(66476007)(921005)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzZaNzJUMUtkY3BKL3cyaDIyTENKbmVETVdoaithRzg5UnA3T2ROckhYZGRS?=
 =?utf-8?B?NFQzd3Iwd3FTSXd0NkUwN2RzNHlFekwwNEVGMWt3VVhhMmYyMnlHekJQeEhu?=
 =?utf-8?B?emJkODA3QnFiMTYrU0EvVVZMM0JVbFZqaFVsYjJ0MWI4OEd3blBxU1dEaWNW?=
 =?utf-8?B?WTRObVBiM0VvMDVNYlFEOEJacGVjazRGVS9oMnJkcnlmZlhsOFhkbmxzNGxm?=
 =?utf-8?B?cGtYYkxXUE5uVU9GRHhyVG1OdytWcFN1bFJROTNTZFE5dGdGcGVzWFZ2czNS?=
 =?utf-8?B?ZzhNamRIS2tLNGc1U3QrZTdrOXEzdzVyQVRKRTRmaFNjS2NWSW9IWmhCOG03?=
 =?utf-8?B?M1VTSlhsVFhwbUV6WFNBZEQwbFV0Z0R5SHhBR3lLNitGVDZncEZRcnJ2amNE?=
 =?utf-8?B?QVV2MzRXOHdFOVJOMklwQTc2MzBsTFF3U3ZaSUxJZzV5TXl5MVE1RFZ5Q0NY?=
 =?utf-8?B?SmViOXV1K3c1cXU3NzJmcjRpaDZoWG5rWUpkY01tQkJRSUE2MkwvbTlQT0U1?=
 =?utf-8?B?dGUzbGFYcmZialRnbitWL2xENDYxeTIrVnhaWmNvcVhwYndoT2VQc3hNTDBT?=
 =?utf-8?B?UHVvbU9wWFdBclQvYmNWb0tkWktESEdsSTdWR0lEVmdtcm1FUmo1WnBQZldp?=
 =?utf-8?B?ZjY3Ri9tZExLcU9jZ0xKWDJIS256VWdqMEVMa2FaTjFEMHVIVWJMdzc3cEhq?=
 =?utf-8?B?SlJpSHRibDl0aVdSU0FncFkrWGQyRkQveFV1VC8yZVMvNnpIVTNLRktWWEo4?=
 =?utf-8?B?dklGV3VHazlvOTNtR2haUlJHNlNoTm51Z3A2cFdCaE82S0t5QWJOS0FKclF0?=
 =?utf-8?B?SmRrekZMVklmaWFnUTIyc2J5dnAvNkhMV2VkMHFmZkN4dWFDSFJTbGFBcSs3?=
 =?utf-8?B?dWl3eHA2UEV0SER6Yy9XNE5iYnU2QlNRVmxpMkJmbWNIWk1IRXp0MEJrM2Nx?=
 =?utf-8?B?SDVIODJMNUJCWXh3WTVFeDdFZWJtcWYxSU94UWViYXJIeVRWMG9PL0RjSTV2?=
 =?utf-8?B?dG1pQUk2T2pBWWlOU2NsbGp2M1VjV0xubklUWldlTFlaTERoM1daYWltUWtK?=
 =?utf-8?B?akJKU2wwSzJFRGxuSWF1WmxzMGtUTXYrT2hCRVpOSlp1NU8wTUcycEFocW9R?=
 =?utf-8?B?RXRsS2VKQk1sTmNnSHcrSVhnOS9FWTk1M0Vjd21MYWcxNGE5RG1oUytyeWZR?=
 =?utf-8?B?LzduSXpHSzVtMmJpWHI1Y1lrR0xMdTRpdVNHVjZ4ci9USWtIUEpTY3d2eERC?=
 =?utf-8?B?ZVhOUWJETytDeThRUjdITUdLZHRGMm92bWNwZFRBbVA1bCtlZUlnZWhsY1Jl?=
 =?utf-8?B?MmNscmFKV05wem1mTVhzdmg5aHdIU3B4UExLU21pbjdZNXdjQmRZeFJ5WXd0?=
 =?utf-8?B?RDNFWWthUDZmWEpkdFQ5ZjVsM01aZXBxNmtHbktLZlY0UGJtNVREZW5WeG5M?=
 =?utf-8?B?UU5QZTJUQ213ZVBvYjJ2VVJTZ0IxcEswN1ZOaTNpSjRXeWY4bnJuTHl1SGNK?=
 =?utf-8?B?MmQxU1hzaFo1elJ2NlljSyt4Wlh6K0c4c1hLd0wrZG1ERDlWdTBFazZjdUJB?=
 =?utf-8?B?VVU4UVNVb2JjU0JNVGthN1M1ZGk3ZEhiYW9GWW1kaktZWjJBL1BSc1dmMWUz?=
 =?utf-8?B?UCsvejhBUTAzNnljV0FROER3SmF2QVhWR1VXSkVYbTRpT0d0M0xOSUQ5all4?=
 =?utf-8?B?NHRaTTFRU1MzU2hoZXVuVUZIZVdab3VjcU15Z1l5S0NETGVkUEUzazQzZzhh?=
 =?utf-8?B?MkdyaHA0dzJDQW1UZGw5TmFjSnUxbkU1Q0lGTS9lZUlYanhlbFFxTGhNTTZ3?=
 =?utf-8?B?aFdMYTY2a2xwR3ZMbHJXSkxwNmMzcGlLcndzdzU5UitWTWhyUThzd0c0SFI0?=
 =?utf-8?B?SkYycXVUd25vVXZnVmtkdUQyRE9PcjF4V05KVDlMSXloM2dVamVva2tKM05k?=
 =?utf-8?B?UzUwenhOQ3lFWlI5K2czeWhrNGM5WU01aU9MVCs5MCtqOU5UYU80ZWRNN2Mw?=
 =?utf-8?B?REVRYUNTQWxVdjFXYmF6WkVndlA4cDFrdUxhQ0trUnkzdlNzR2NFb1hwblZr?=
 =?utf-8?B?eUlpdW1pMEpQOTVRQjJsTlc5bjUwcXAvZlNTcmVBakkwMUNrYmNyUTdCeS8y?=
 =?utf-8?B?UDd3ZUgxZnZjcnFTTUxjeEJtQ0p4c0dyWU8wVWhqeWl5ZUNrYlpLSjZ5WUM3?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ccea7c-7446-49e0-c6aa-08dbb4fc00ec
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 08:24:25.2087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQicvrZx353I+PO/2BMWDcI5jEGfWYisFf+oKxbRnviWCU9qTmLnM3DXer4H2xYEqXl5zES1POiGR/6kIuOekg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5555
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/14 15:19, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 14/09/2023 09:00, Huqiang Qin wrote:
>> Hi Krzysztof,
>>
>> On 2023/9/14 14:16, Krzysztof Kozlowski wrote:
>> ...
>>>> diff --git a/include/dt-bindings/gpio/amlogic-t7-gpio.h b/include/dt-bindings/gpio/amlogic-t7-gpio.h
>>>> new file mode 100644
>>>> index 000000000000..2bab9a99501a
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/gpio/amlogic-t7-gpio.h
>>>
>>> Use compatible syntax.
>>
>> The amlogic-t7-gpio.h is not a file in the dt-bindings/pinctrl/ directory.
>> Does it also need to be named according to the compatible name of pinctrl?
> 
> The convention, which we introduced since ~1-2 years, is to use the
> device compatible or binding filename as the headers filename. Now,
> where you put what does not affect it.
> 

Okay, got it, I will modify it in the next version.

Thanks


Best regards,
Huqiang Qin
