Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949B4806D66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378004AbjLFLIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378038AbjLFLH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:07:57 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2076.outbound.protection.outlook.com [40.92.18.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66CED45;
        Wed,  6 Dec 2023 03:08:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0q9QhAiTpiWhZTd2duCRCCh0oUArI06pA6E/f8j70My5A5aHfIrjEKPOF94KKBue65Vew4rrkrhjV+s26tXsA4bS6v4KagWzOQNkun2fDc9mWPHJUFVu3mpKq797DSoA3ah+qwkHTw6BlKfjjyunyAIXaSZ0u0vMMHW/cQ1X3kAH0bQhFyiuVsOziOrbO75bUnGemdPCLagsSlIBYWv3iMQTvkRlsHmgk3FqkBcOnIdCdrk3pBvrvyClJ+5gYoU76rL0QtWEUqs83OZhhW6n1qYy0v6xJHEr3LTSkM2SHmEHsLRJUlF0H5DD8apwMyRgnoDuRejryU4nj6FI0EwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5icMAGXlHZ5PIwD6QwaHUCnOn/Y5mVkeir7r1ajCQCo=;
 b=B8Pt5jbXx1LlbAIhoNa2I7SrGZjHCqwZmY1c7acRsQyyxec/6DOyYnrf9iLS0FV3MG2wysdb6LGPtwhVGNZwi/ivzseC8o715XM7/5en03fHiGPUfMaTPX17D3YOL5T2SY5DFi023QYUlFPdu+cxhlnzEn8odfCbP21aGe/nFv43ss+bws4elGkILBkj0YaOJFeFXkj7qbtAuZ3kM6DQFylqS6cBnLZyZBvAfoDQXUyV6seXe4GgpyDkg/PYOskMbtCX6QV6cFHMfeNBnNpCuUew+iig0ICcTbejifHIduxdZbi/MbXKH1pO2fCbvILmAZrnySHM7qfxw2pYYgPRqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5icMAGXlHZ5PIwD6QwaHUCnOn/Y5mVkeir7r1ajCQCo=;
 b=mEtc+gxf9Or7iTPzKaNZT6/3rA7lC1f7uNSV/QPmRJ/jicOIRZENOGZG2h+yfKMPi317Y4XGQ3QLc9wI4gUghW97xjlL1p/rve8BXnWnfp9UmatuNmB5mWg5XoGGZCsjb63VcbSO9QABrKxBXr9VsITZXs3WSM81cjRXXSNuJX8j69KUCNTdNllasTf+jVdztCvmW+NIVR1EKkQypJKBBJ3F22lVFjNF+C1B7zm+X/fT6zuftlB6gacx4fhLWEVFY6/jvf5zUbTlxq+glAYRt/jzmdd9fGbO10KeTMGvZFN0wn0l8iHZ9vdV10rk1GS1L9Pj4I2453TuV6Nyluo2Lw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH0PR20MB3868.namprd20.prod.outlook.com (2603:10b6:610:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 11:07:59 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Wed, 6 Dec 2023
 11:07:59 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Inochi Amaoto <inochiama@outlook.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/4] riscv: sophgo: add clock support for Sophgo CV1800 SoCs
Date:   Wed,  6 Dec 2023 19:07:55 +0800
Message-ID: <IA1PR20MB4953EAE3F3B7F8B3CB659716BB84A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJM55Z-hCzuw+eQ-ABXoBYX7oSScXTKHwUzEe_2k6eSyy5HqKQ@mail.gmail.com>
References: <CAJM55Z-hCzuw+eQ-ABXoBYX7oSScXTKHwUzEe_2k6eSyy5HqKQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [efj7rrDA26Avtp4DQcpmS5Z658Gc/7txVEtGDoKMs6M=]
X-ClientProxiedBy: BY3PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:217::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231206110755.790348-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH0PR20MB3868:EE_
X-MS-Office365-Filtering-Correlation-Id: 294d2484-58f6-4deb-5b9e-08dbf64b9b3c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujnu5nbv3oyjCornR/y5abOmjFdaJ1hPYm9IHG6Pc+T4RiapE4uW50vaNhM16VpGg6X2gv9ffBpSdvN2qEwPDrapJNeKJk3YmCo7R/jrpMyydXTlQhwcSsLtQnmx6ULsShMHpIP3aVoAI1tH6icse3GM5PXj70LOEgs4ewwQqaoneG8zecnu1Ya0P93r5DTFKkLr6IAyb0RMlKHEqYx6XPjqufaxUXOumxgJiXu9zfe+9qPD7Th9QQbkPRJuWDyw7Vojtm4UmEVUqXARt7Pqtm97KV/88h6ng0zX5yrYqN+IoecKL7IWKxyNnQTOhKJSmzK7CeVDdWB+HsO7Y4wg1qEpB4kue57F2Dt8RAUEIDztcWVkpxejufyzgvmw15GsuxuHlmdAb+G3TzRQ2TjqUArjcPomPjHBvb/qEyVXEjakYGBqaySuXkjmUH1KrwCi+/ihW+nJdadcuMiObh5GWetf/GGjhMwbGVfk997z7AhvqQ4yogIx8JhVuiG6uwQ6awLCmMnUQciQyEKOM5WDIS6kSMABW2dBEjYRKsPj18Bvhj0fyIemXSj6Ew2ShyiXpw/8BCNBnRT1et5ENquCB/gj9TUQ2C7DD1pOuRcr0qAHyzY4WI2GTGH3K4KNvVLE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+5NvDBL4Jl4UUl7cwMGbQWFS9SdTeihqWRL58TUedCU9rN7hj4MfU4oTdPqS?=
 =?us-ascii?Q?+acKSO/45J7BFwRsXlQXFBZgpomdOzV5UyRMc7497ILfLQKRPbtYsPzIF9T5?=
 =?us-ascii?Q?v/ZVl1XrbTLV29pJO/fcqJLZK7ckzRRkLNg7uub1BmQde96GdX9F2N2emmaM?=
 =?us-ascii?Q?TLuxU95abvcriYu2QTyJJMKXETGMvQEGVFrdr+aEXr1ketCURCIW8YntbXCH?=
 =?us-ascii?Q?zrEpP2mAc8ZScTxNWp85X5YQ9gytFsh5JyQcBIEplvRPYduemt69oKdwtLgE?=
 =?us-ascii?Q?bOhPJSL7Vi+DkHJrJH4yct/02WzOB14yh8vrna0YtS7d0MC6S9S9W7laukgz?=
 =?us-ascii?Q?R1bMFdW6xJgX9iZsSR20pzfzwlVuqHviSkHefIyiWd/s9iMWi5VPbWg/dQJi?=
 =?us-ascii?Q?e18x+J3gEhBjZaY6A4qVgrbCgKHWOJnFQBGaa0oGdgdnINF/yM5TYtLf6kmq?=
 =?us-ascii?Q?Mk0RzjNh+EhXV7Ujw6CI4PIgM+vJ/x1CE7kA4HfN1LaZ/QfA0vvW34G20LSz?=
 =?us-ascii?Q?VLAO4a315ass1tlPaMJfosrgu/gSWMFMfK0KoFoDMZ0hyuYtr9QxUy1S5Szc?=
 =?us-ascii?Q?nZyHZyEnbbkxkI/A59xbjKxwSdPpZR4E352jqYcYgtb8S8ToIWi1IoOL2aIO?=
 =?us-ascii?Q?eWAPD3YTe5y+bVDaAzrvGyFQUKToyqGqBj+ZtH0myPUT+/I7VS/Tcr9Rp8+2?=
 =?us-ascii?Q?3Y4jqIiwp2bJ80xtr2hDy9OMSywNuCNW/hUGjMCmDTagVo+W2nTSnSJOhMjM?=
 =?us-ascii?Q?60xLv1jBNr8wfZyZQSUIUpqrSi7z/opscc9xTm4wBrqHTkov8Wh15OLbtJeR?=
 =?us-ascii?Q?3rTfOTy1pIt+ocl2EVQ3mx4YbHqARqY7d3WKdHKyWw3EyzvS8gF6ELlzaIgj?=
 =?us-ascii?Q?T3s+EMaSN0XCZWaG3PljYKEL3qG7sJZqGwIBooAGqf3MjSEFZ/SnelymNxuI?=
 =?us-ascii?Q?6vo+kctzIybANOx0HXvp93J8hbN5GJOpxzmDuLj9zXPxUMlwFIqoEGHFhZX8?=
 =?us-ascii?Q?5oliCQMqgsy+hIS9dZImRZ0JwLnksFXxV5Px64lgFhBNq4QFJP1KvnSiG2zx?=
 =?us-ascii?Q?ma4rO6MWr/tje15mh8mg0dlZU0GLYx6Z2r5pC9KHYwm1wc1aos1olKKUH2Xx?=
 =?us-ascii?Q?xO9S599rwSO9yKmQ91GOJEdqJ86A/rGe6I6mbz4XEFCnOpAt6z3kK6TKUUC9?=
 =?us-ascii?Q?BnpkLhlB3vVom6w7MgoEoIqD5N7yJ2YUnovKMRcdQhEiSCkQyTVLlgBeTLA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294d2484-58f6-4deb-5b9e-08dbf64b9b3c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 11:07:59.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB3868
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Inochi Amaoto wrote:
>>> Inochi Amaoto wrote:
>>>> Add clock controller support for the Sophgo CV1800B and CV1812H.
>>>>
>>>> This patch follow this patch series:
>>>> https://lore.kernel.org/all/IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com/
>>>>
>>>> Changed from v1:
>>>> 1. fix license issues.
>>>>
>>>> Inochi Amaoto (4):
>>>>   dt-bindings: clock: sophgo: Add clock controller of CV1800 series SoC
>>>>   clk: sophgo: Add CV1800 series clock controller driver
>>>>   riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
>>>>   riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
>>>
>>> Hi Inochi,
>>>
>>> This series seems to be missing patch 1 and 2. If you did send them, but just
>>> omitted linux-riscv from those patches, please don't do that. Having the whole
>>> series makes it a lot easier to review without having to hunt down all the
>>> missing parts on lore.kernel.org.
>>>
>>> scripts/get_maintainer.pl does support muliple patches as input
>>>
>>> /Emil
>>>
>>
>> Hi Emil,
>>
>> The get_maintainer.pl does not give me linux-riscv mail list for the first
>> and second patch. I have added this to the second one, but the patch is
>> held by the mail list since is too big. Anyway, I will add this mail list
>> manually if you need. Sorry for this inconvenience.
>
>No worries. Yeah, that's what I meant by get_maintainer.pl supporting multiple
>patches.  You can do something like
>
>  git format-patch <starting point>..
>  ./scripts/get_maintainer.pl *.patch
>
>..to get a list of recipients for the whole series.
>
>/Emil
>

I have known this. But I only do this for cover.
Anyway, I will send this patch in the way your mentioned.
