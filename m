Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9B08018DD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441955AbjLBAWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjLBAWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:22:05 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2063.outbound.protection.outlook.com [40.92.15.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342D5DD;
        Fri,  1 Dec 2023 16:22:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIwrGDVNdFkKVLGhJgNSpWvv6TYBcg/KwnWGtgmQxLSX1CG2b4E/8FuQVF/HU6CnsHZGeua6Jl3ht5YiSZlHgK20G+sKcm9s6h1MTk97p/wId9vx7c6/TpwXEbxLLjvJZyWlo9N/Vz7HXpfuQ7v79quf+sVWA3F/0Ivh2USuQNQ3lQdeYDLRaxsX5x6/zdkeV5RrNlCwHz+bMWcG7lr8d971J1jC7AkylDYBrsBF10xmpiPNs1GsMOLcvhg0XVu4Mp7gtJcmceGpE02LpXBPy11+uZ8Z42YiVnuEPe2f2NoaJOvdo33LH8bdRzxDsAcnJZo+KgyqaMcynxCY1Fpb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lu4Jv1AZZOddcM6G8gAOnhsOeoDgm1QiVkgyrwRKl80=;
 b=DgwT6qcaKtm4cgeSUbP/4k3/OnYD/IsvpRDeMXGYMzAE0Xq+erPdYpsp/GSTudjl16lUSXCUvfAQbvxQotVdIAp5LY6vDl+zdktHSoSHiOKm+xJNYeJ7+2D3GHSyrTZvNPULWyiYsZmrz6HIc579LOOmz9LVHruwKagBApfBbxyMa+INSh5N8eyPqKWI8djAkduTWt1Cuz7ThZys9hZMPXg2ayfkWQU9q5GIysF9LdciwA8F6zaoXJOqiANMKi81ZuZ0tEi4uLRsLc2H3Mwx74BU5fMLqXKXbpxrcEpH0cMbP/wCqWn+iH6bzeJ0nXMGIcNIyLlI5J9K1jPtS0MWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lu4Jv1AZZOddcM6G8gAOnhsOeoDgm1QiVkgyrwRKl80=;
 b=kxiN3nZ9xZpzJXDleQ7b5Wy4ll11bQ8TjPl4KSCK9bZ8V85bOZK0/B0hhZt8JFlIz0Hb4K3XtFrCqvGrDWOCi9KdnHMBVQgKwpFDDyY+3ExSkvIBJXPiaLAJ8MJzM1HH7XZNlAj7ftjCUAMKGxFlfyR9E2qd//UCHEA95dbGAYWzC24Cqdikr2EUjr0T5sXviCn5UejjbVWHXRlrjuznrseC8QMpMsevWD8poqijMQ6Kw7gwNOnEjjmkTAvhErZQ7lcbkASfeOPg0qvxxpuF3k4C3iWD5obs8Ea+sXzS3neN7NnInoe9JJP/CDMUMmYcJOaskrCRO8d4cTPG1U30ew==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB6719.namprd20.prod.outlook.com (2603:10b6:208:456::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Sat, 2 Dec
 2023 00:22:09 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Sat, 2 Dec 2023
 00:22:08 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/7] Add Huashan Pi board support
Date:   Sat,  2 Dec 2023 08:22:10 +0800
Message-ID: <IA1PR20MB49539388196F08BBA969B522BB80A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201-nutshell-uptake-48161193c6e7@spud>
References: <20231201-nutshell-uptake-48161193c6e7@spud>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [J9agLOqYWGkli9c3J9N6m5+awxRiV36nnBr53jPbDqg=]
X-ClientProxiedBy: SJ0PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::23) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231202002211.104625-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a04d93-5d9b-4134-05f9-08dbf2ccb83f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blGWXRImeEdO8T0HrSEiaf68Y+cjiQCeJnXTWI88x5/u+JSl7AuwhM15O5XcoO0JZTJaOa9VSuMqPomhEoToEkjkfOMIzq+y0B53sNjoTLSEsnp720kR0OpOugpJ48O66K7/3yWPRiulVbw4v8UlarLDgVCw+O64PIKRLUOGiSZ6GYeF0NM1nmJ5r8FRlMAqiVCWxFWfYoKl9hjchTXhMDEGDgN7xR8Bbn3EwzrRGAJsGJPriy+qnwMZSng2dwGWHa+zwzCI4VwMtANuIWK6nspumMcEkzGdMT4XDmzbdnl4/2ekFTkGaccocg3JLi8I7GtvN6KEfz8+w5U4QwH8ege2NWG4Jzv2a5arDLE0ABKyYyW3aLPh7gtZbIWcSlGmEz1T+WsiwauDRQodNVaR7ezlBb4oAleLT5F9v1jw3Kebz7kCrVUkuWW/5MBXilk6yhyYKQ+5Z1Yl3cjH7CbYaDm8eGg14ZtGiiRBTuuJoz2De8bbvEcLx/HTE4kpxuzB1ZCtAFcVIlC/PQdj69MEFFkerOyA/ZXX6dRZOsyw1vNPOd0jBRXhdhHTZjQ57NGuXNU2iO2cXgAsbbUw0WSW9/SgDBg9CdVWDyuvddtPbpJgVjoGHnqONcaNRGP77siG
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X9RCQOMwJvkIFxgQxZ9cUN/zm24FTDecDHmTtMFqB4fwzdMFHACdX/pn8imY?=
 =?us-ascii?Q?LpSxzFywTzvzLInpvupn/V+D/pXTcCqWhhlfNhpge8VHgHAo88o62IvnhXFp?=
 =?us-ascii?Q?o8FI5pIV7ENDS+Bbp3j/PY02kGdDiCaUL772KxjrTif6k5F4r8StNohVVD2v?=
 =?us-ascii?Q?UvbF1qbiNwbqVcpTu6hEkWpzmxodszTlYqPIJ93qrfZqImaJweVqOfpS6OdV?=
 =?us-ascii?Q?cfKZW+zPiDXDjAsFird3vIhD8MUlMBQXtaGsX0sgMba6eYvwlGTX/CVlN91t?=
 =?us-ascii?Q?zD3V6Tj2YJcqrjHNtatBiR9bTAgkidSwPGf2iBhk5V5sz3IEVyow8hiO/vVY?=
 =?us-ascii?Q?FqAP/fXCfh2YYsuRPAagpGB1WHJ0l+1eXyxbXeWrd5JO8B14twrG3SFzqoEi?=
 =?us-ascii?Q?pH2np0TOW4RlsmMNwXV8JCj42XisRUHaQBnAn96aQALy+mRaE3OEZKdxYYLz?=
 =?us-ascii?Q?dsRFaByCUxwvQq7u83bWkjwMR8V/2P7DDMADuPxglFzcfqR7yVDQBZgxzVUv?=
 =?us-ascii?Q?Qynk9V2wTy1yHuB1GTjM1nebax2xTFYtiNlFYy9YV1viPgI67Ue+VeG+rsFw?=
 =?us-ascii?Q?52X3ploxVvSqAQjdqCGG+YED/RGB/Qkff1b6DlKQpQgt/g+XX5xCGKMabXFt?=
 =?us-ascii?Q?u3IA0LjMumX4wh7cMZRcNkJkm4Z2S6gFSFtxTVMoygfNN8UzQqcprN10qdOn?=
 =?us-ascii?Q?26M1OoMgjEgAIbPe7EpYawJPhoGCVmZraPLFDZY2HWGneI/qU/nxkLB6ldkx?=
 =?us-ascii?Q?4fyVddEo8u07alazZTE/4VEE6IDTyfUw3sBGXM2Gr56RBCRep/1Y92YW5ZPE?=
 =?us-ascii?Q?kOXiOD+EUenB761dsijJHcOYGsgBoi8ZQomEvrfZ161iX5LDascV4HgjDn8f?=
 =?us-ascii?Q?VHQ32juEV0U0BGuch22VhBM421odkQHtu1LWCYC/tCwXmI7Rm5lwdMHGSyat?=
 =?us-ascii?Q?KIhjDrHM0TAgTTEIxbitVH7iJVuKlYK4yjfFItnVqIelBsL31NaSHz5GRz4+?=
 =?us-ascii?Q?imP7zZ2Pw2lZ/YPt8umedHN6GMcnLi6JbMqXR1WjM4ZENQ3N1qHfWD1wEJ40?=
 =?us-ascii?Q?goKkZpy0Fu+6B3YtKRs7MJauepB29ITPjONvHtjg6uq3fJSvgwExIp3hR+r+?=
 =?us-ascii?Q?xiMk6Tns8rmCxUjR1X82hIcJVAYjVmc4QIUg0eVdM4Tb7qt0ZHPoQPKTfK5l?=
 =?us-ascii?Q?dFL75kFS3cArE3Kt6+yrDATIqs5/4FffzYdwETJZIoUfo5cKNWYjohWn7ok?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a04d93-5d9b-4134-05f9-08dbf2ccb83f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2023 00:22:08.8583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB6719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Fri, Dec 01, 2023 at 04:31:38PM +0800, Inochi Amaoto wrote:
>>>
>>> On Fri, Dec 01, 2023 at 09:02:59AM +0800, Inochi Amaoto wrote:
>>>>>
>>>>> On Fri, Dec 01, 2023 at 07:21:29AM +0800, Inochi Amaoto wrote:
>>>>>>>
>>>>>>> On Thu, 19 Oct 2023 07:18:00 +0800, Inochi Amaoto wrote:
>>>>>>>> Huashan Pi board is an embedded development platform based on the
>>>>>>>> CV1812H chip. Add minimal device tree files for this board.
>>>>>>>> Currently, it can boot to a basic shell.
>>>>>>>>
>>>>>>>> NOTE: this series is based on the Jisheng's Milk-V Duo patch.
>>>>>>>>
>>>>>>>> Link: https://en.sophgo.com/product/introduce/huashan.html
>>>>>>>> Link: https://en.sophgo.com/product/introduce/cv181xH.html
>>>>>>>> Link: https://lore.kernel.org/linux-riscv/20231006121449.721-1-jszhang@kernel.org/
>>>>>>>>
>>>>>>>> [...]
>>>>>>>
>>>>>>> Applied to riscv-dt-for-next, thanks! LMK if something looks not as
>>>>>>> expected.
>>>>>>>
>>>>>>> [1/7] dt-bindings: interrupt-controller: Add SOPHGO CV1812H plic
>>>>>>>      https://git.kernel.org/conor/c/21a34e63afcc
>>>>>>> [2/7] dt-bindings: timer: Add SOPHGO CV1812H clint
>>>>>>>      https://git.kernel.org/conor/c/06ea2a1968a9
>>>>>>> [3/7] dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
>>>>>>>      https://git.kernel.org/conor/c/d7b92027834e
>>>>>>> [4/7] riscv: dts: sophgo: Separate compatible specific for CV1800B soc
>>>>>>>      https://git.kernel.org/conor/c/5b5dce3951b2
>>>>>>> [5/7] riscv: dts: sophgo: cv18xx: Add gpio devices
>>>>>>>      https://git.kernel.org/conor/c/dd791b45c866
>>>>>>> [6/7] riscv: dts: sophgo: add initial CV1812H SoC device tree
>>>>>>>      https://git.kernel.org/conor/c/681ec684a741
>>>>>>> [7/7] riscv: dts: sophgo: add Huashan Pi board device tree
>>>>>>>      https://git.kernel.org/conor/c/2c36b0cfb408
>>>
>>>>>> Thanks for the confirmation. But I suggest to revert these patches.
>>>>>> Several days ago, Sophgo informed me that CV1810 series will be
>>>>>> renamed. And the Huashan Pi will switch to the chip with new name.
>>>>>> To avoid unnecessary conflict, please drop these patch and I will
>>>>>> prepare a new patch once the renamed chip is launched.
>>>>>
>>>>> This is a board that exists, that you (and possibly others) have, right?
>>>>>
>>>>
>>>> Yes, of course.
>>>
>>> I dunno then. It sounds from your message that this is purely a rebrand
>>> of the SoCs,
>>
>> IIRC, it is.
>> FYI, Chen and Chao. Maybe you know something more.
>>
>>> so since people already have these boards, I'd rather not.
>>> We should be able to support both since it's just a naming change,
>>> right?
>>
>> I agree with this. If the above is true, we can just reuse the exists code
>> with a different compatible name, right?
>
>I think so? I'm not sure what the precedent really is for pure
>rebrandings of an SoC.
>I say for now, assume we can do that, and we can discuss it with Rob and
>Krzysztof when the time comes if there is no difference between the SoCs
>and boards.
>

OK, now let's reserve these code and discuss when the board with
those SoCs come. Thanks for your explanation.

>Cheers,
>Conor.
>
>
