Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20837DABD7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 10:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjJ2JGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 05:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2JF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 05:05:59 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2036.outbound.protection.outlook.com [40.92.59.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77213CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 02:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTsRuNwZWOw9s/zmBwyVsdN7ICK0E5YNWi/TQgmgvsKI6RgPc1yngVCqULzDbnJ4B019xPGyrRhGEmTh5YX2pJXY4fXGkkVflsb9gXbfPD8z1ipuYQniG1E1mH2TUsa/TRVGUp0E9cgK2AVc+VP675N3tJOyCAJJXUkoklp06rSnZqHXNNNfPNLfz8/Ia5zy9QsqoAubq/FvAHh0pJNmejPGRMUgb8g2UTc0ToZSzdmaSF2EoRC/IJdDaHIcUYEWiM+vkEfClSC+69DId8DN8zF+Zduc50hDNCZfF+oHHx8ipRj/NZDVV297yAn22s9FY/9PjnY22jYNl0bP4CWi7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcwMR/IiMmMF1IndFxlrpqJNTzSSs2/w/qmy+PcxA3o=;
 b=COUz0dhvyYJ/5dim8K8HgeLiJoTM8VVn/5t5na1RT35gtRuhsYLd3YucEN/4Rs8P8YYV3h896EtdE7+tuZ/nS5v9xm8NcX/EQJUBLBc4zSNUjUtjSdqZdgYtlEfYwfQe+iyHLLaX8gt/Y6DnhscpsNFArM52Pp5y0NYJNSy7BYMsItWRu7p2ft3xigu53pGoOXYkJQOeU5d6k9DmymuMiOnIByZeRIyz7LGb5NXdm7elQMJQrlKNyn2VBVnDk9UcB3MomH4cAnjroTnQfE0/VzLVpD08s2ouzD3QLtBLTVi0ewp5cBvSVDaTxGg+1h3pw7AiQdiO8g2Pil+J5cM4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcwMR/IiMmMF1IndFxlrpqJNTzSSs2/w/qmy+PcxA3o=;
 b=Y6x7U5dJf1g8DPwt9h2ZpacBizQNc0GUPDCpzq16vgBXULOFVCV74UMlv3q+iJObdkBIGv1byhx5WKo0PD/MrK7A1yM7I0Dtydzrlf/qP2NWb7uqGvdVlFVKuBun0FPEEXIN8jgqBnIgKfLJcJNuxwprmuNF1+LResOH+AbyHL6B10v8ZD2kHQcSbXB3U55iYp/cjxvpBc0xgbs3wHQ0wmCI8GHBvdXLbYkPHfyVVRPK2t8YCkQZkHf+yKl32GSzTBbFob5VSmIffYh8+8zNcil27EIrR2yFtRMolhIXfS/81A53k6+0ZOk28QVrjOjztmLYPhIiWHuQFlY4Wdqtsw==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by AS8P193MB2301.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:446::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Sun, 29 Oct
 2023 09:05:54 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::2db3:2c11:bb43:c6e]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::2db3:2c11:bb43:c6e%5]) with mapi id 15.20.6933.025; Sun, 29 Oct 2023
 09:05:54 +0000
Message-ID: <VI1P193MB07524EFBE97632D575A91EDB99A2A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Date:   Sun, 29 Oct 2023 17:05:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mm/kasan: Add Allocation, Free, Error timestamps to KASAN
 report
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com,
        vincenzo.frascino@arm.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
References: <VI1P193MB075256E076A09E5B2EF7A16F99D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CA+fCnZfn0RnnhifNxctrUaLEptE=z9L=e3BY_8tRH2UXZWAO6Q@mail.gmail.com>
From:   Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CA+fCnZfn0RnnhifNxctrUaLEptE=z9L=e3BY_8tRH2UXZWAO6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [X5MALjLVTbXzlHngHlRqibWkaWE/JXzO]
X-ClientProxiedBy: LO2P265CA0140.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::32) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <c973be13-6cad-48b8-9dd3-8fd1ab737a38@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|AS8P193MB2301:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e62cf3-f40d-4a8c-1997-08dbd85e4166
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uR4YyAFowSATC08xdLw6JLLMjjBxztUZ4zgUEcgVueiKgEafB+LzlhlIwGW8rhWQMlyatYtmNdSzMsJZwk6VkgrXePDuhFo6mA2g7RtAZeFN3Iv6Wj5Jen4htN/nQjc6gKwmR+b5xt1aQMEr4qPElidviKWho4Q4n0I/2CwfFJr1U+QPVl5jmWJG73rcZJnKjq4GGI6a2FvbKkEAVvhw7ziO0TilLdVGItvYaWA+NkWkLTRWBbVmIJfUPgvS+PHpVtGj583Nc4Z+4j4nULhE0WvlD8O6azFcGXVoYesfCR/wybB+VwtLffdRSAeBGAqqj70VHlq9hT3cLFCe4gRBL9qMu2A0Xw+407gOr0c+ABRmEEmN/QqJOepfA9zP5vPRLqmqsliTUuBPWYDkK0xuTHWr0RX9C5+k/b+iDkLsxYJMAbMWxXOGL43Mgtw8zUOhPGCsFMZAoYXfN8drFK0utryFgDGy45wEX+EUIgI3PYkEgDM+9OBxE2UlizCypZdCY7mUeck291PsQOkbtIE9r0+26SMJRRlZzSZzW7yDnp2egGqEiX8M1/1cqt9VnFvf
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjhkT2hkNm9IMFM0WG1LVXdtRStRWlVJWnpTQk5vRkdvRkcxaHJsV1Yzd2tZ?=
 =?utf-8?B?WlB6ZGs4NWdFM0VEc1FSd3Zzc3JpL0p4cE1zOUI4WHhSZitsUktBWi9RMXB6?=
 =?utf-8?B?WnJhUUt2Yk9xRlA1d2REWGVlSFNSN3Jna3dtaXBCaHo4MmkrN3liOTNsaWNM?=
 =?utf-8?B?TTBRdDlkL0Mza3R3S05PSFJoMit4aGhxR3FIbkhVVjA3NlpFN1dVbEhzakJR?=
 =?utf-8?B?Mi9YdExyeHFiMVdCR2pBMWJPeENUUDBYRk54Q2RBSmJNN2ZhQ0ZxeHZmMEND?=
 =?utf-8?B?Q25wSzVQdEVnNTJKMytubitvdmxYeEQvTjJqR0Z4R0MrMTRmTE5ZNTkrL2dU?=
 =?utf-8?B?blR5T2RBSTJ4Z1paUGROME9GNjBwUnN5b25CSXVkcmVSckE1UEtTamw5bDBi?=
 =?utf-8?B?R1ZtYkVNenFYdVRwL2xuMFA1SHpwVm1ZcVh4dUFhdWFxMXpFQXo3bHhZQkpa?=
 =?utf-8?B?R1hNYW1vazhhR3I3YlNvWUh4eWhHajQ3a2h0Rjhuc0dLaVJFaEdNSnBCbnBa?=
 =?utf-8?B?YUx4YlZjRmt5ZUJLa3RZRXlaaG0yWUxld2hWUUxCZUFJaUhSdjBzL3dwREJE?=
 =?utf-8?B?dE5mbzVTZGVzTDRtTktrT1lhZEtMOXBOSmZxdDY0cWJyTWJoU3luVnJMcWxJ?=
 =?utf-8?B?MXVDd2R4L0cvNnlPV0I1MEpZRUNnMXcyZkQzNWFYMjU2M1REaVhySTdZYy82?=
 =?utf-8?B?REJ2S0w4VHFENmtST1ZkM1dFN2hCczkrZkdPay9pWFEwVVFDMXRlV3dqYitP?=
 =?utf-8?B?Z1VLTE0yUG1yY0ZzSGF0ZjlZemRKTFFQREE2NDFZSnlPcnFMREN3YVY5UWdQ?=
 =?utf-8?B?K1RPSEsxb0lBL3Q5OHhkbThOQmFhRE83N0JLLzQ3bXViRGgwcjdhU0Rpc01s?=
 =?utf-8?B?aG4xNzNGNmhObVBLUlRJZ0RPUzZBL09NZnRIN2l0NDQwVVJSYkY4c09sc0Vm?=
 =?utf-8?B?eTR3OWp1bDlEbDVrT2pKVmtTSDhZYkRqKzFuc2lyS2sycW1JbjJZLy90V1U1?=
 =?utf-8?B?K1Q3UEdob3laelZTM2lYbmdjK3R3czhjUktidkxhZ1ZTeUhBTUJqaitkNTMw?=
 =?utf-8?B?ZlUwblEraUY3OWFqRENwWFI5c0xzSG9rRlBrSWhhMEI0UVF6RkNLMUt0ZTMz?=
 =?utf-8?B?bzBYQWhuNlBORVJscWFzN1FEVFN5RDdUaERmSTFDdDh6K1NQR1lWQlN6Z3dw?=
 =?utf-8?B?SFdHMGlrK0F4M3NpUVhjbi9Qem1LbTc3ZHVWY0ZYdERvWVVBRzJTS1hESWJP?=
 =?utf-8?B?cjJHQXdobWUreEJCMXl3ZWtpVVBTaXZwdUx1RFFodmpHdzhtekRhZlNxaXBr?=
 =?utf-8?B?ZDVYMy9naW5lTy9UckJTNG5wTm5DeWFoMEE4QXpMMHhidURsVnBmY21BOHhF?=
 =?utf-8?B?emdkTitGUTNsYUI4a0tNcGRMM3lqZVVKNGpMOWtnQVFhendGNENRa2ZjUjdN?=
 =?utf-8?B?RE9CS2VlNm1uYk44dm5oOXFYOWdKVjVKUVY0T2NUdjV6ZVR1OUo1aVcrcENS?=
 =?utf-8?B?RUFWZ0tja0FpNkdrajV0Vzk1dFZQNnFqT2d5NXRvNWcrN3JtQWl6bDF3bkdO?=
 =?utf-8?B?YlBsSndFeFRBQ3pxRkdOakVQWldNNUQ2TmRKaUhkTWV1emZwK0NNTTVoZXJk?=
 =?utf-8?Q?XyCnZoD6MmDboJxROAGwAZwvdvlEctRhI7szVah+gSN0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e62cf3-f40d-4a8c-1997-08dbd85e4166
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2023 09:05:54.2744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2301
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/26 3:22, Andrey Konovalov wrote:
> On Tue, Oct 17, 2023 at 9:40 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> The idea came from the bug I was fixing recently,
>> 'KASAN: slab-use-after-free Read in tls_encrypt_done'.
>>
>> This bug is caused by subtle race condition, where the data structure
>> is freed early on another CPU, resulting in use-after-free.
>>
>> Like this bug, some of the use-after-free bugs are caused by race
>> condition, but it is not easy to quickly conclude that the cause of the
>> use-after-free is race condition if only looking at the stack trace.
>>
>> I did not think this use-after-free was caused by race condition at the
>> beginning, it took me some time to read the source code carefully and
>> think about it to determine that it was caused by race condition.
>>
>> By adding timestamps for Allocation, Free, and Error to the KASAN
>> report, it will be much easier to determine if use-after-free is
>> caused by race condition.
> 
> An alternative would be to add the CPU number to the alloc/free stack
> traces. Something like:
> 
> Allocated by task 42 on CPU 2:
> (stack trace)
> 
> The bad access stack trace already prints the CPU number.

Yes, that is a great idea and the CPU number would help a lot.

But I think the CPU number cannot completely replace the free timestamp,
because some freeing really should be done at another CPU.

We need the free timestamp to help us distinguish whether it was freed
a long time ago or whether it was caused to be freed during the
current operation.

I think both the CPU number and the timestamp should be displayed, more
information would help us find the real cause of the error faster.

Should I implement these features?
