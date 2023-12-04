Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECDA803054
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjLDKeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLDKet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:34:49 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2050.outbound.protection.outlook.com [40.92.91.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A921AC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:34:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BS333gel5x0awehCbePu19XenBPFXu9U3Aoua+IjV1pZ/flLPgLOGdUApKAIWmDSjPMujXoc42wyZt8WdN3iQeso51G1+PXP+oTobj3SQvWzEwWcLrUJlHSs6Qg1E3rHSDqRzpWJE+vbwEMoheluT0xijeXPpGCNSRnZA8cBcWKfxtB+oqLLxNBxoi9ogrTwdA2TAUq/XMGNNZQlAxunhC8xGpQKjKGfFOBh+uS0EA7Wj26sizYkaqQDHuRQyXI7FJmLrg7cCxQSAcmFQo7zwVl4njl3E+DbxqbJ5/4FiDe3XAgwfVg+Cx7qPvrFAbs9vlweUHH2MG6T1X7wU5E6hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOULJufeN2S2Pm6WeKzkxqEXi2A4oOHBrGgbFuLoZvA=;
 b=bpuI9KlKB4Q6lbAGjfeaS/7JoiMkAApNJ97+taqx/C6+KQNpRfzQyxry0b+b3BHMJ5VSek5kzzmlFqixxEInY1d/Dq+YbbFBWYHJIIaXKTVCx637mZPRA3gTiunZICgPMfZkCYPz/U3RV7oVFrf9/pr74Fa2iIU98QCO34ApJMfDZpUaq55ILjCTsihUsYQ1U4dK23R8ag3FjjEg4YvBISp8Q5hk9aRY2ARI51lzs108jbq0IiD9tdjaKjUtLghpZMM1Q7dw/I4re/n2zSDlPZxhBQnmgufbLVQ+0Ne3jJLNSwzkYZcsmv970XC2ZNRcFJlDAWVFZjlowcqU8jjUFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOULJufeN2S2Pm6WeKzkxqEXi2A4oOHBrGgbFuLoZvA=;
 b=uO7frWpozzIVCbcFJpoYyz/jXAOoaJ78/TvFBuWwbnxpPzgJ+JWBI5hcYx8dbFbWSt6sSjigWW8YFLIwTn4VKuTaSKtFCnBOaytkIvnIDvRGiGjuv+6uJ8JUDl18gQieGn7hh9tiPJG3xz8Oo8C6trBHcmGe8p0UQzLyC6QFs52MFYLKSI7+j89xscPFfaL/oUzixiPL80gykplt5VwprqjdeC5MpoqpwFInxZX8ofcSRLIPRe9eGqkvg/pu1dZfbUXwJpd6YS4CcFQL+I1Kb5snoXZzjrk+VDit9ZiNjibhPHXulOM0um9NrDugdXBAwiBCjCFPR1MIq/BaccVbbg==
Received: from AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:172::24)
 by DB4PR10MB6189.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:387::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 10:34:53 +0000
Received: from AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1fc4:7df9:3d95:eb28]) by AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1fc4:7df9:3d95:eb28%6]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 10:34:52 +0000
Message-ID: <AM7PR10MB3923674B5CFF669DFCA46BAD8E86A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
Date:   Mon, 4 Dec 2023 11:34:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Nouveau] Kernel problem with multiseat on one card
Content-Language: nl
From:   Gert Vanhaerents <gert.vanhaerents@hotmail.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AM7PR10MB39235DD53D163910E88FDB938E82A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
 <AM7PR10MB3923E07D6024434077E95EBA8E82A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
 <ZWsuiq7zrYS-pDli@archie.me>
 <655a02097e9b49c2da7a2be60d7c154a48a916f4.camel@nvidia.com>
 <AM7PR10MB39235076485E2E3905F422508E86A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
 <d8dd837f-0d40-42a8-a580-29532fb1519a@hotmail.com>
In-Reply-To: <d8dd837f-0d40-42a8-a580-29532fb1519a@hotmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [KgjFO/ZIpZvH1J1p3+8SzFlZq/Fe9WLo]
X-ClientProxiedBy: AS4P250CA0003.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::19) To AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:172::24)
X-Microsoft-Original-Message-ID: <c9e385b3-bf2b-4c63-9025-4fdcf289f6ce@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3923:EE_|DB4PR10MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: d781932b-0385-434a-4a0b-08dbf4b4a668
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4mPXRp0xPJDTij0dhyw1eaqaIGdkJnGWXHxh+oKcLT6QRFZi/sUcWH5RQSLZsBdLDQgxFP7eUu9t1a1ttxal/YlsZmwdd5nomVf/Y7bzNEobd9pe3yx1dK5BvKL0sz+1ovUS908q77yv3we0VEaMQQep30IOoRgXdVP9wzFKVLM0obtnWwk+2vNLFTMvuKV59UVMeq1B6LhUzyAs74HbQGOsXu5tlcNrHTpdo+zZFbOUPsFEsdAOxAHQfldjJw2wLWeXv2NLdyEYGFjMux2IofkNeQIAy0dfdYBhka9Aj5urxmKEIf9cNBQ8cci4bz46WW9jMzqKk2jzu0lgPf9LynT7EyStOs/adoqVp/4eiPC5t89Vef5GLqIS4aIf+PG+YCLiDbPCSxBpWqkojxtz1cpO009U1pfNH2PPqUhTeLrC3JfHYlNkmwxhzLwBAi0/QSOhod2ABNPsq661abKHS+9GLuVFyEOXaQJKRX7B2SZhvhdz+gjtMmdNKBMhvvrBQrzm1hPhmdx6IZCqJqYiLcODGtRMsrxtSxs4qCXtcZyj0YtIv/mjYW8lboJwOrCxaH62BgYvK9rOSvwmFaPAxexRv1mdltC0DaGV6/PxiA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVZDVUl2RFJRMGhWTkJOd04yVTRNMnFhTXIzN3d6ODUrTGY5bTFRa25NbDlD?=
 =?utf-8?B?cUY0ZEc4VDd3MklQUmx5WW5oWllMOXFELzNlMDZBWjF3dmtuajFWcFhNeFBB?=
 =?utf-8?B?bEoxTHVFSnNVMkp3OHQyYVhZeWZGblhDZFpMY0psVUNXZ016SVYrZjlkY3Nu?=
 =?utf-8?B?ZllMb1ZXdUI1dWpIc0hGMEhLbUZ0T2tvME9ybUVPb25xNzZzRnVrSm1iMHl2?=
 =?utf-8?B?YjNEczBOMnpuSU1xR1QvRW9PekdVZUdESkNFSGl1YXVKTGhaZlVXUm1NbDdX?=
 =?utf-8?B?VDdrOUJmUk5DejQzdWhJTVdYVHpLUE0vd2lmeE1EdGtvbGlEMm1WRjlXNWE4?=
 =?utf-8?B?U1pobXN3aC9HYjVqNkFiMVhOZnhTUHFVdkwrRTJDUE1zVWYza1R0dmJBbEdW?=
 =?utf-8?B?QmpKZ2pqRUhNTlUxUm9WU1ZldGxPeTgwOTZjZFNLclNzRDJ3WWJTS3l5dEY2?=
 =?utf-8?B?emFraUd4VUdVbDc3bFRhenpUbHB2UTdLV1lzTUd5K0xBR2JhbitPZ2xDdzhB?=
 =?utf-8?B?YnlUS0ZJdElFSnZ1ZEVBMENqdGZmTlJ3eElRd0tsZUh4YU84cXIyblVxdkxk?=
 =?utf-8?B?U2g5ZmVibVkvNi9wbElvYjZQUVFYQTNKR0lRYUx4aGZvb1lPUUp0eEI0QXk0?=
 =?utf-8?B?bTZQYjAwMUdFeEpEWkVvU3ZQQnVTMGZpOFZNdlBqUHg0UmsrY2M0aWpFcUor?=
 =?utf-8?B?Yk5xdTMwNzZ1elZZSFE1TDl3bmlGd1E2YmdjT3NtWW9PMEV3Rm03THNUdEhF?=
 =?utf-8?B?TE5ycCtrS0hqZ2EvVmZ4VGszb20vc1VkVk9ROUJRVDh3MU92YXdyb0VwR2Nl?=
 =?utf-8?B?a1RHcWFLWVRiNTdMZkdSdGt5TElJaTZKL0RhcUpTbW80QTBCMzNyU2hwUDhJ?=
 =?utf-8?B?TkF5dDIyY2VhaDVONkcySmpBVjNhUmd6eVYya1VRcU9CbDFPamc0OGMvNkU5?=
 =?utf-8?B?T0V1T3E2SWt1M01pcFVva1hZc3BNWU1jLzZJcUlCRUpsdTNKMEZkNmFjU05E?=
 =?utf-8?B?S3VJNUNqbk1aV210a0pONlFRRW9McHRwL1JHa1BENHZXMktZUDdSOUlVRVJP?=
 =?utf-8?B?dHN5L3Y4dlc2SXBHOUtIVVVKalZILytoUEdNTVhxTWJ5cmkvMm40TUtZYk05?=
 =?utf-8?B?OUxNOTF4NEk3aC82ZXd6Vk9iTFFkSTZhWXB5SGZGTUdyVTlFeGlPY2s0ZXYx?=
 =?utf-8?B?NVZuZHFpWStxRmgrWGhMeG1JVDFMNHU5S0E4K2RMbEFvY1R5R1o2RjZtR3FG?=
 =?utf-8?B?VEpna2VzV1pyL041MXJPNzhTNzd3QkVIOWp3S3hURWJESktselFnTE1kaWly?=
 =?utf-8?B?SjlndmhiM1M5dmpQR1U0WEt5ekxLTGU5U0Y3TEh1cS8weGgxaElQaGNXT0dt?=
 =?utf-8?B?eGdyS0VBVjY0UzNha0kyQnhjRUs1QkVMYlJBSlk0a3oyMmVFN0dzSllDdVU4?=
 =?utf-8?B?dlR4cDF2Z0YzSzVRTTdkSVc2N0FUZFZCV3ZNOG1nTTczeDR1Qk1UM21zeU1M?=
 =?utf-8?B?aFJmc0loWEZzdGU3bnN2elhKRkVBREI2SGt6ZFVPWGM5dDJCUzF2N2Yzb0I1?=
 =?utf-8?B?SWRydlRSczJ0cXBTZUhGa2EvS21MVlFDZkVhMmU3UndtU2dnRWhFamVZVlEx?=
 =?utf-8?Q?TvACUg8jpBeaNQNnOjPYkOhXQ/r/fe6Knnh3/n/1u1eg=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d781932b-0385-434a-4a0b-08dbf4b4a668
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 10:34:52.8738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6189
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

>>>>> When i install the proprietary Nvidia drivers, i have the following:
>>>>>
>>>>> [MASTER] pci:0000:08:00.0
>>>>>            │ ├─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0
>>>>>            │ │ [MASTER] drm:card0
>>>>>            │
>>>>> └─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/renderD128
>>>>>            │   drm:renderD128
>>>>>
>>>>> ─/sys/devices/platform/efi-framebuffer.0/graphics/fb0
>>>>>            │ graphics:fb0 "EFI VGA"
>>>>>
>>>>> So no VGA, DVI or HDMI items.
>>>> Then report to the GitHub tracker [1].
>>>>
>>>> Thanks.
>>>>
>>>> [1]:https://github.com/NVIDIA/open-gpu-kernel-modules/issues
>>>>
>>> No, do NOT report this on the Github tracker!
>>>
>>> That github tracker is ONLY for bugs that occur with OpenRM (the "Open GPU
>>> Kernel Module") but not with the the proprietary driver.  If you have a bug
>>> with the the Nvidia proprietary driver, that must be reported on the Nvidia
>>> forum instead:
>>>
>>> https://forums.developer.nvidia.com/c/gpu-graphics/linux/148
>>
>> OK  i will report it to nvidia. But with the nouveau drivers it's 
>> also not working. Are you sure it's not a kernel problem?
>>
>> Because according to systemd it would be a kernel problem.  
>> (personaly i am also thinking it's a driver problem)
>>
