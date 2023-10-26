Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5337D80D9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbjJZKfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjJZKfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:35:41 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABD518A;
        Thu, 26 Oct 2023 03:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOhzkhev2q+PsGykN9l7ifNnv30PyMZ9HCtZIvjc7ZrkbaPBQmclyxJG1Qq1cLPgHRzEPri7SBp+0Y7Mh2s/8pssvsmFvKTHL4bZsZtgKP4PbJ+901dt/BsKlcctt3UntE/eDzlhcksMtCV8NV9WKRiixxmY9jdWKyocrrt6x0m7GAk3vx7mGZR5Y3eoUnbq19QH2YRuimqBuw5H/QlOoytLQj2r7loD400Nt0hBkpJX7jUH5Z29nsc8UO6TT0E4BQVKFeSyuWitDS3ZfVyR4RoJadrTws1R+i7EOqzoHerDf6iJ/aJ9vseBlz7fjk2aRmc76785TDX6AKjhs/ZYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROhD7u63+9O38SKf9KOBAmIDM+B49aYYL50KeiQ0i0U=;
 b=YACbRHGkBNCbVbzAx4+vW42y76a25GtHg8hW6zVkkn9cW6c6kaiUtfwex8eoNcrCb1ZFpCfoAHhTUblApz3HEXdXgHSS6osF7KMd+Kj+c0zTamNfbmjGus6WLJbEXinzgqO1PCmJ6yUOb9qu+KrtvDuRFKS3lvfl+K/GaG4yoXaNQ0TAECVJ3+xReFGA4eSbCffzGOyRN7U3XAjimpDD+FmDS0ubLHfFU+TVGJHC/7+xv1tahfkWi6COsI3mYpx0hKDw9hKCxK6wX7BmOW7RfttH9usAWpfwOZbJ9T/q2bzAKonfjya9H1nAE/jvln+1D4O5BlZsVSbeWwRqEYpcQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROhD7u63+9O38SKf9KOBAmIDM+B49aYYL50KeiQ0i0U=;
 b=rXNtloMHAsl71RS0VbhUDPCFxqjvLd+Fz1S/SjOC+fYJF/R4GOJvjJoNmS/PAfX9bZd1boSbcbaiBM5Cnij5LtcPU48taoY0dObsEBirvfGYyZV+ed22o58OydGsomyg+K8AstC7u+2iB5+iy04y9g9kckH1oK1VgNN2OhdmDZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PA6PR08MB10624.eurprd08.prod.outlook.com (2603:10a6:102:3d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 10:35:32 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b%6]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 10:35:32 +0000
Message-ID: <94113169-710b-4088-a2d0-ad70842bb887@wolfvision.net>
Date:   Thu, 26 Oct 2023 12:35:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: rtc: nxp,pcf8563: add hiz-output
 property
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20231024-topic-pcf85363_hiz_output-v1-0-50908aff0e52@wolfvision.net>
 <20231024-topic-pcf85363_hiz_output-v1-2-50908aff0e52@wolfvision.net>
 <20231025222327c0b5d460@mail.local>
 <2f17c031-30f6-4242-b2a1-1628402b3091@wolfvision.net>
 <1c4a6185-fe09-45d1-900a-10abf48e3fc9@wolfvision.net>
 <20231026005008b8255799@mail.local>
 <8fec6c89-548b-43b5-8361-869663a58573@wolfvision.net>
 <202310260956166bdcb845@mail.local>
 <d3dcb034-f589-41bb-8a67-1de8ce51db8c@wolfvision.net>
 <202310261021467b56f131@mail.local>
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <202310261021467b56f131@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0050.eurprd04.prod.outlook.com
 (2603:10a6:802:2::21) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PA6PR08MB10624:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d3aea8-7288-4503-d7ba-08dbd60f4793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVDB1WwtmYycKVvhmsc0bg8dLGpDoO0ErIN/nFHzYXWXAyuZ0UMH0vbdRgcEi8JJnsmKscEEJCeRAMiz4PvAFF+jZUJTcSfs5z69hnw3fgwQ37310ZY1vDNryCVmgn+E76Hgpo1h4+EvPKPyIJLK5FaiyudK5wEGPdvXypFgRZ/BQj5r7sjgxF5NKn3d4wCtrUz+9xQb/eKQNzYUUdnH5QemCdRS8WfZwJIVFTQBIRkUSPyYH0bjzg+HG0cldwZK9z/c0fTjAZLQGmMzyQkKLj3JBmdahhpFfEt/R3g4rbWQlO+EELDezNqQ95tsr0o+9TplarwkmWZLNoFn/OjmZ2J8dBtyLuklzh1byRfP+HEyf90bNfSa3tD1eMjgnWjwVjDTDr/WwBDtIJqYS3TScTpQKY72l8HXfIZctgZMMfhn1JfMMoRpP741+rqEtzS579vhqQBXrfLSxJpmj0fRbK1u9e/kdqhIBUC3FSIC8fVI2SjdGuPhrNASIzowrjf010wutTvL499nWzw3k6rCUNN701t0gSM8IBSxApOupQLKX9Og6mdfg0bp/lMWAcrjI9WX+FjAhYcVTgzRyUlLfTgiv7ndH+ZGFs3uZWGhZW8zIb+zotVa5OvfOG8Ik8/H+O2+MfpYYgkg4J2lb0zdOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39850400004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(5660300002)(38100700002)(2906002)(44832011)(41300700001)(31696002)(36756003)(86362001)(8676002)(8936002)(4326008)(478600001)(2616005)(6916009)(66556008)(6506007)(316002)(66476007)(6666004)(66946007)(54906003)(83380400001)(6486002)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHNmblA3RzhBTk54elN1YUpRM2hENDBOMXcxaktXMUxkZ3hhaEo4aFNSL01m?=
 =?utf-8?B?OFVQY1JzaVFCUTNDcS83TkV5K25mQ0FnWGlMRndXQ0hULzd5QXU2d2FHc3pQ?=
 =?utf-8?B?NzVFb1JBVm5MckpDc1lUMllOMytBNTBycFE5TFVPemJKNDlOR3lPWXF2eTBl?=
 =?utf-8?B?ak1WdTJ3R3JhckpPUC9tM1VOOTNxS1RRQjgyMjNqVUduV0o0eTZ0Qjh1aHhO?=
 =?utf-8?B?TWszc2daWXJ2SW91cTIxM0Q0YlphTEZvc1VNYklpM2tVd0VrYnpvcTZkdnB0?=
 =?utf-8?B?aDA5eks2NVl0YVBsbDdNVk9hVDk0Y0R0K1hrQTBLdldNM1ppWnIybXdOU0VY?=
 =?utf-8?B?dFp1ang3SEY3MDN4SjVBWGxlaHRUb0ZiOFJZOGZaclFwVXhQbERGY01LM3Fz?=
 =?utf-8?B?U0xmckU5TFJvWmtNUU5oSjFaVjA3Smk0SStXWXdRbUN4OU5YMHhmQzFuMVkv?=
 =?utf-8?B?MHFBaUI4T2l1VzZ2d0s4bFhkV0JHK1NZVlh1emJGVldVQ0JsbFFJdTJjSTEz?=
 =?utf-8?B?bHVYTzJYU0NWMGQ3V0xOeVRVTEJ3RVovdUtVbmlTaWh3N2s1bDVrNU43NWJ4?=
 =?utf-8?B?NjF2VXlJOVEvRUsreERxVGk3Q1RZUjZXRGx0clpNSTc3aDdpYnhrWUVHWi9z?=
 =?utf-8?B?RGhpVWJRUmR5dnlPK2JZeGJJc25OU2UwVzA0WWZXc2JLSXhuUmFuLytvd0No?=
 =?utf-8?B?d3l4ejdqdER5dFAxWjQ2WERlNWE1TmtRVSs1Nk1GMGtwUlF6ZHZkQVQ5dTgr?=
 =?utf-8?B?SzZMYnlBZlZheFpiUW9SU3hXdnZmWDZPQlZXV0t4Wkc1MitncFVGU1FScDRD?=
 =?utf-8?B?VkUxZk1UNlBBVGpSRVNLbktwM2ttRWExdGJBUGJYM0pVdXRsald2a0JPY0tr?=
 =?utf-8?B?NitYMkpmZ2EweEF5bnRQaStCVXpXZnRSdTh6QlNxajlQdEU2TDJrVXR3ZXlu?=
 =?utf-8?B?b3MzWitCOVhBT1RZRzBmVDV0ZUdES2VPUy83SmRHTHlBMmJhaWVxNXVQYVNP?=
 =?utf-8?B?Q21EK3d6cmxpSk1kSENyNlVGQUJSSTFUKzJWdFUxRWxxNmM2eSs2VWlwUlF1?=
 =?utf-8?B?Wm92WFg0UkF1RnNJSEp3NDI2NURjdWwzNmZ6RzVIeXhGbHVMS1FVRk5BY0M3?=
 =?utf-8?B?Mnh2TTFudGwvL1c5UFZvbSt2VDMrbFZLdXB1dU1BYXVxL0pQNjVNbnlIclZL?=
 =?utf-8?B?UjcyUjNOQnBtR3p6dDhXYjlzYWsrdUlmNmJ0STh3ZEZmbzdhdlg2UkxvTUZs?=
 =?utf-8?B?TjB3OWNLZVlNVjBZZ21iZUpneXdXMHU2VWdteWxWOSt0WGQ4am5HLzlteGp1?=
 =?utf-8?B?YU9hQ1lHSjgrRStxRlJWaFFRaVZkM00rYWcvUFJXOE11dTdOUmRGczdhS1BJ?=
 =?utf-8?B?d20rUmxrOHJSOUduS1BvOHBaTDdISG5VcnRNRGRkY0R3cnVEOGxWMWRPcTBr?=
 =?utf-8?B?RllqYXVjSmp6U29PKzd0YUlmL0xia2M2NVpGMnYyRlZSbHkyS0hBV0xBUFNl?=
 =?utf-8?B?U0wxQ1NZdG5XbHp6UXoyeTU0a3MxSXh1UlZ3bHRaakVKdVV6dCtJZ2tNb3I5?=
 =?utf-8?B?M3Y3aFJ4SGw5U1MyRFBsYUd6aTluVmlGVVYyNHZWMXZ4Smh5UVlWWFdKWDVN?=
 =?utf-8?B?MnlLMzVqL01vckFhVmo0Qjd5d3JzRUZPdmJZYktrTjBGNUp1MmlISEJjRklD?=
 =?utf-8?B?OVpGWjhUUUNSQjFJUDZuLzg4SWhBVC93dE1yTStqdFdYbWVLendsSm1kUGUv?=
 =?utf-8?B?M25tM2dXZS9QQTd2L0FMM29oQk1wQXZRUDN5U3FUQmwyOEdpSU9YdUpvZ3Jl?=
 =?utf-8?B?OTFGMUJFc2lvYWM4c29NY3RhT2U1RUkvV3ZsNCtRV0Z2V29MODdab3BQUHMr?=
 =?utf-8?B?UzJoN2NqQnUveWM0ZytLT2tocG9ud1BmdkJzaEQyU3YrUGt2czFkYXQ5aXVx?=
 =?utf-8?B?YW9MR3RmZUpsbGo5NWpETSsxRWIrMkVLeTNXN2JWellsSWxZc01ZNmVsb1No?=
 =?utf-8?B?VVhHSVVZdmhxLzBVSVJDNWh4djhZYnY4UnRsK2pmdDFYNkRwQnRKYTYrZkwr?=
 =?utf-8?B?WUNNVWtKTjI2Q21qbkZiZnpLTjlnYU9ZS3dRbktKMFYxZ0hCT2gvbTBXM2Fa?=
 =?utf-8?B?MVA4T3VveTF1SXFSQ2lERjgwRG4vTHVkWVBSaEo1ZW5vaEtIelJDQThWWmZU?=
 =?utf-8?B?VG5reXVKMmd4VWk4N3gyaGdUSDVHUXpIZE1QbWhQWVMvUGhOcXJHOW1pZFdE?=
 =?utf-8?Q?Eaw3gSFcw2dtjUdAe5ChJefyD+IGAZjPUOG9Dnnk18=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d3aea8-7288-4503-d7ba-08dbd60f4793
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 10:35:31.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4Rhuu2arZRweZJdcHGR9EcJJLJHnYGXk0frjc/Tc6ESD/7uLoCFkEMbER735f7TLnN4AuNZog6Wy3qVBQjYdte9+0QOCOvj92Yk3sEgbmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.23 12:21, Alexandre Belloni wrote:
> On 26/10/2023 12:13:23+0200, Javier Carrasco wrote:
>> I want to model the INTA pin as a clock source that only should run in
>> sleep mode because its clock is only used in that mode. Therefore I want
>> the pin to stay in hi-Z during normal operation.
> 
> Can you disclose what is the user of the clock, do you have a driver for
> this device?
> 
It is a Rockchip PMU through its CLK32K_IN pin. I can't disclose the
exact model (yet) though, but the use case is that the PMU can run with
the RTC clock connected to that pin in low-power modes.
That pin is configured in the proper mode and maybe it could be
configured differently with pinctrl in "default" mode, but the RTC INTA
would still output the clock, which is what I want to avoid in this
particular case.
I just want to stop the clock at the RTC end i.e. write PIN_IO_INTA_HIZ
into the PIN_IO_INTAPM.
>>
>> I do not want to get any interrupts from the INTA pin and the battery
>> mode indication is not relevant for me either. I do not know the CCF
>> mechanism in other RTCs though, but I think that the hi-Z mode
>> accomplishes exactly what I described.The assumption about the battery
>> mode is therefore beyond my knowledge, but my first reaction is that we
>> already have the hi-Z for that.
>>
>> So in the end I just need a mechanism to configure INTA as hi-Z, which
>> the driver still does not support. There is another application where
>> the clock output is not required even though it is physically connected,
>> so hi-Z is again an interesting mode and the battery mode would be
>> available if it ever becomes relevant for anyone.
>>
> 
