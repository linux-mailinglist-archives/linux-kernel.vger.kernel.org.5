Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848BF7E726C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345049AbjKITku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKITkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:40:47 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2073.outbound.protection.outlook.com [40.92.59.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1AA30EA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:40:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZbupBHvb92vBUFavxU4JKjZFGUxqcaDwHjwqhKqbAs05KFSlq0NqYCZgLupCmF2NqIhc9n67xgnZh6yNd1UvYzUeuS0RQI3rCVXciaER6HR+53Qm+hVogdYtNXnfIdX6O4fsrJOHFqSTQgxGQitPyRuCqNIVetQuEhuxva4YS83VelqHgXdhlZNQ7OD26biDE8GVIpZFhG0JEfA+xSMu+oeKoG0QL+MCx2okma7VoevzKrZFeX61pP9a0MZcOmz5uWPuLGuS092YNY85KCaKWk9naJFFXswawDJXg9YHlGCqd1pHSwEdIAwvzBJ7njg95ZpaQqtqluGAS2mRJW/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ju3R0st0ZQn+AXhm48Knsa6M6ne0uCfsimXRBRZj5Uo=;
 b=KFUKeQ+C1rF/BfS9DTqS+L8QjdnI7ZbuhQdG1bJeESHo9rgQRhzw9yPjb+W3b9XENgpuM/73yp0zQcPz7ZPKcAQVBWW0yYxIrJQ1/HjXTcf2hOZTbvM3gqZq0octq6O3IJwA7xFwn6vRe1cshx5vPsmSuvdIgFHdiYuEvkpmWaf7IZEjzU0sHDqSkDE77YSEZTDY7mLFkEd8ZQ1TvcEIB+0v4CJTM5DOzIXlFDnWdzNf0dMu7/7nN6EjBMMb+HFHFQVk+E+a59i7RRjTfGE7fgX3uisTo+hmmExoxmrHQBWvDGgcXflzfd9wJP7YZBMhdBJhA1+aVRM71xxFhYmFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ju3R0st0ZQn+AXhm48Knsa6M6ne0uCfsimXRBRZj5Uo=;
 b=FlJeYPUj3O2cLFZwOhisgdNXSummaSbW0bmi7x3tAbSpMp1txGyqcjtZg1PfPNDqn7gJUeXZ7tfYzahDQNwZ6PLAmjCOf9PlAlYR3+ndelTZp+zai36rB0/DzWKtxITSomaEmR8FiqE91DbLtX2+tLVA14010ZjiwuWyZXhZhoByVhw74f6WhZOWSuNuteuHgd87V9Ah1BzVudcyUEyn7nsP6lumSouqtVmGy1OcKGy2B6PRXqcUNNz8Ef6Akb34d+WbKIye6ORpcEiOhnEVFYn0cJbpNquXQwOmP1INw4ryau/Yt7cmNevJ3IztlaLAvPmliyMbvnzdnYPVx6XhMQ==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by DB9P193MB1274.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:250::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 19:40:42 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::2db3:2c11:bb43:c6e]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::2db3:2c11:bb43:c6e%6]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 19:40:42 +0000
Message-ID: <VI1P193MB07522256FD0E0F148F19947A99AFA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Date:   Fri, 10 Nov 2023 03:40:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mm/kasan: Add Allocation, Free, Error timestamps to KASAN
 report
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com,
        vincenzo.frascino@arm.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
References: <VI1P193MB075256E076A09E5B2EF7A16F99D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CA+fCnZfn0RnnhifNxctrUaLEptE=z9L=e3BY_8tRH2UXZWAO6Q@mail.gmail.com>
 <VI1P193MB07524EFBE97632D575A91EDB99A2A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CACT4Y+a+xfzXBgqVz3Gxv4Ri1CqHTV1m=i=h4j5KWxsmdP+t5A@mail.gmail.com>
 <VI1P193MB075221DDE87BE09A4E7CBB1A99A1A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CACT4Y+bxMKEVUhu-RDvOMcbah=iYCWdXFZDU0JN3D7OP26Q_Dw@mail.gmail.com>
 <VI1P193MB0752753CB059C9A4420C875799A1A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CACT4Y+ZS5cz9wZgxLVo2EsGtt-tkFXkFPA6CGAA8Gy7+sEyDUQ@mail.gmail.com>
 <CA+fCnZdRWs=P4EgzC9sSDLfO=Bxbs9FyeOcqAiY8pzvMLUX=Aw@mail.gmail.com>
From:   Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CA+fCnZdRWs=P4EgzC9sSDLfO=Bxbs9FyeOcqAiY8pzvMLUX=Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [VN+pHvkej8G0MIcQwQqeCZ+1nXckMvoM]
X-ClientProxiedBy: LO6P123CA0048.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::15) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <d5686cc4-27ba-43d3-84a6-2baee5d50f46@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|DB9P193MB1274:EE_
X-MS-Office365-Filtering-Correlation-Id: bd965661-6d58-4290-49ea-08dbe15bc230
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3N3czyPIgl66vrLWbawbkOJIeGIf98lKKi9PFKtwUeJCNHKPSVqXpBG2iTTWwoO5o6woUk0KTsujwOLL+PEVuJ8H7W9c+3YKB+OfY/WsNKPZlDEqKmqX27CJ5BowtkKud8p7SphK9RODQLe3pyCc1uOyQVjH/XnfiuSu/qYbBebhGaRmtyHwGpKE2DJkP7FF7KoCMdoSu1DesH20ZYRjn61IAZdBoCGL5a0Jayz+aEKa37d0F1d0iRW7NXUBVHIWNvTNW+AJgQwWC5lFK6H+93purst4ZUuLdbFLkRdkzJcEjD4KuLo9+ZpLb+pCK/o8EgkfxhC0tyCt9KbMJ59eDZI6gXpuukiTcwNz09bgaHOMbqhrPFuQyYcka7o7t6W8lElCq9MIHNkvnEt/XZuHZvTOQI6yiSLJxrTkEArp0IoqT7jaonmzmT1ROOp8q5Ru5eLy+gNW9KL0+FSPgcYJrvE1a1rDxBmeU+m3CjmELxJ66q86p1Ims+lh0S1DQ9NRS8TNfvTwZBl7xIwN89z5QF6gDfCZucKJ/hQPh3XncDuy5ApZY2b8rSNOMhnUEsc
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTRIa3IyTHBFYzVpaEhOUmU3eGIwcmxhQUN4VHI0SklTQVgzc1BaUTZ0RFZE?=
 =?utf-8?B?eWtPamp0ek5nSnBndnMzcjFtRzF6VXVhNjRpZ1JVbzNRSFBKM3ZmallkaENO?=
 =?utf-8?B?YktrM3NVWUUrd205K0JTb1FGUFBFZ3pweTJNSFJmcUVyNmJvMTQ4a3N0bHJQ?=
 =?utf-8?B?RVR1aS93WkFpait1Qm80UGc3ZlI2WGsrTEVFR2RjMXBGNDFJTXhldFZibjdw?=
 =?utf-8?B?Tks1RURQQ0tOdkNGR0g5cWNCL2dpT09FYzRmcHhFZEJlZm9aUDdEOU4zTFkx?=
 =?utf-8?B?Q3dhcHVoa2hteW01Z0pFTzRBbVk0c1VwYkVWVTZEQklZcnhzRzRyM3IwWkw0?=
 =?utf-8?B?Vm5LdVF5TTZ1VlJOTGFSbXhFeHNUK2V1OWpOdnJJbUNnVnFOZXE1ckVmWXhz?=
 =?utf-8?B?QWg1NkZ5S2FLbUtybEdkdVc3TzNzRzlZU2wzMGdtYS8vWmJCSGdkQ3Q4cW04?=
 =?utf-8?B?QVFlQWV5bGRTQmR5ZVhNNnM3YTZiVUJVa0RVWW8vTG0rYVMyVU1HZ2lGM0lx?=
 =?utf-8?B?aHgvdm13V1U0NWM1ZmNQQlRMNnUxeWQ1ZUZlRURiSmV5Vks4eDZ1REtnaGt6?=
 =?utf-8?B?a2JrMjJFZmI3SktvMmxuRVFnSDdJRmFuM09zOGtVcEYrL0ZPakVCV1Vaclph?=
 =?utf-8?B?R1E5YlhLY2RRWmQybG4rYjc3Q0xxUEhpcVBGR0dzeEg1dVl1K1k2YkkxNzlG?=
 =?utf-8?B?aDgwNG4wMFFFa1BEL0g2Zlo0TDMvZmhmN2pacEJpeGM3OGREWkNxcVVWQzVp?=
 =?utf-8?B?aEFhUU1semJ2L0k1L3ZZUzYzdWd3eENRQUp3endrcmJCQnpzY05GVy9MZ3dP?=
 =?utf-8?B?MmsxQkJJU1Q3KzNIT0o3MHJmYzZyT1kzbnBJNERqZEpJdlB3cjdVM2FURWtX?=
 =?utf-8?B?K0sxZmpXN1N3WVhxT2dabTJKT3pnSC9zSUlVY1pobWViU1NWSDUyQ2tXZjNs?=
 =?utf-8?B?TE02V0NPOGNMallBaXBCdFNwenlvblRkOWZQd25XYllGaVcyYmVvWFlUa1cw?=
 =?utf-8?B?U2hQNjJHRW9yNlplSzRyZWNwVzN2VnhhanJ1b29ldlh5Q3c2SThTZm9YUWtJ?=
 =?utf-8?B?RXJpSUF4RGU3V3k2T2ZFYVFxL0JBSE9MblpHUDQxVkJqenovOXBlbFNlNG1F?=
 =?utf-8?B?WmpHVEE3OUxmNHVRSTI0aFA3ZW5sK3lnK2pkQ2NvSEw3QjNNUXJkS2kvSHdJ?=
 =?utf-8?B?WmUzUm83K0d2Q0FocG1Da3hHV2NSZG9pSDB2WVBaWFIwNC9aa25EMC9BaCsv?=
 =?utf-8?B?cDdnRjhoSHQ2NTdMNnFmb2drdUpHb3E1Sm1vcTcxT3dETmpQSzB0OHBIL2pG?=
 =?utf-8?B?bjM4Uk1hWFRHdmtBaWdLeE1ybDROeFd1bndqUkVPdE5ZdjhJRHFmZGtSTEtW?=
 =?utf-8?B?dDl0bVFOUTc1WDAvb3dPYnM1RzJPVkJaYUtxV2VYa0RoeDhTZkFJMzdnb1BI?=
 =?utf-8?B?TXJ0dnZiVHNvTGxmZFE4N3VyM2EvMDdEQ1M2RjI4dUhUNVBwb3FxYUZoWS9U?=
 =?utf-8?B?a0Z3dXJwVCs5VTJYN3RuUHpSbU9nUXByeGtUS0d5VGc3VzR1Q1B1cU1keHlh?=
 =?utf-8?B?UG5PQ21nZkNPSVBoQmtnOGNXT2RRaFM1UHAyVUUyYUJaSmxEYkY4MHVCYWtp?=
 =?utf-8?Q?jlRxX+bYmueb2aavr9LbRT7BZLPODcLGy5gCZDCep6Dk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd965661-6d58-4290-49ea-08dbe15bc230
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 19:40:42.4396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1274
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/2 22:58, Andrey Konovalov wrote:
> On Tue, Oct 31, 2023 at 10:46 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>>>>>> There is also an aspect of memory consumption. KASAN headers increase
>>>>>> the size of every heap object. So we tried to keep them as compact as
>>>>>> possible. At some point CPU numbers and timestamps (IIRC) were already
>>>>>> part of the header, but we removed them to shrink the header to 16
>>>>>> bytes.
> 
>>> Do you think it is worth using the extra bytes to record more
>>> information? If this is a user-configurable feature.
>>
>> If it's user-configurable, then it is OK.
> 
> FWIW, Generic KASAN already stores the auxiliary stack handles in the
> redzone, so the size of the redzone header is 24 bytes. Perhaps, we
> should hide them under a config as well.
> 
> However, the increase of the redzone header size will only affect
> small kmalloc allocations (<= 16 bytes, as kmalloc allocations are
> aligned to the size of the object and the redzone is thus as big as
> the object anyway) and small non-kmalloc slab allocations (<= 64
> bytes, for which optimal_redzone returns 16). So I don't think adding
> new fields to the redzone will increase the memory usage by much. But
> this needs to be tested to make sure.

Yes, I read the design documentation and source code of KASAN
in depth today.

Currently in Generic mode, the alloc meta is stored in the redzone
(unless it doesn't fit) and the free meta is stored in the object
(or in the redzone if it cannot be stored in the object).

Therefore, I also think that using a few extra bytes to record more
information may consume less extra memory than we expected.

I am trying to implement the feature to let KASAN record more
information (configurable) and test it, I will send an PATCH RFC
when I am done.

Thanks.
