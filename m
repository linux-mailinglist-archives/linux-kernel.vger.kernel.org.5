Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28A7802901
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 00:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjLCXcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 18:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLCXcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 18:32:04 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2070.outbound.protection.outlook.com [40.92.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF07D5;
        Sun,  3 Dec 2023 15:32:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF7HCbCNkhVQPpqsuoSZgkF2HbF2U5JbUOdYimAnAIR4LmiHndLn25pGZ8x1zuYLj1rkO/9t2tc3gxuLCqoTrYS/ME31owPKnqDk3i6EfvX9zpjGgciIKTesAca6jKUuVWiaM4j5eNIPuV6wBQOSOKyaI7bD5s2hvSQ7+91PXY1kPs4rE5hRVckK9g+O5OEnGI4AiSEhd6PdSuhl9+8VEJHmM0Fzs9jacgzaq+MtJu6H9UsYLVLj3Cq6pjg57amTzaTL3zmQEBFHOQz9nUShE70ey9xFn0HZlvZ0jEHIH+7X/yws25JDvqhG4pIy7laZpCOab0yzy4IhVAzZ+g3iIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa7r0VUZGJTJpTEY9TLXk6hMzsXwZ1aWt1Ht6N5MHfw=;
 b=VVvwZlJi/sP/osJfxfXmwsOIq3FyJbxWufNFevU1uU5wXxzyEsHoXoDDbdbBeAHRG8Xb9wrt3M2EdYYYHW9faMBKUEAZ9yHplVD8YxiYJXo8xJLJwHDwKV0q1yo2PUDlta55teo7AkxfB5hKGXtUEQmElWEMUzU6BdRe2tS2V9pj6lxMVa16kDxSF/U0+2bqozM9BJk63OmEjvThbQ7QtILZCdwl2rHcttJAPtCIy47g4ULn0M8DVW7xOTGyXA4OpdzD0iDjx2d6gjBWNsgNxZqYI4/t8RkIcxx+MEJdJ5rT4QeJAdOdYLJ3y9auml4rwfKDOvMkNdC+4VIE1iwXYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa7r0VUZGJTJpTEY9TLXk6hMzsXwZ1aWt1Ht6N5MHfw=;
 b=UubtGahkXMyv6OlqFjqFq4e2+K4UXI4d/AQIgVIBQ58ewf32NHNsAw2mUMcU1GEtoouf4yvlBfccJscvEqQRhXF2cOnWfI+bz4sVY7wNPG27TE/O6dRP9t5IAPj2Nbm1SKwSzoCoG3VTAe0sQcWW2vuAyGnGGcQJEPkiXfqw64Kom2WZcqgD3QccoHPk27+zFTnQwGbE0NZ8jmHROBpapeUnh2Sse5exizhuZPBYGsQB5WGDS13vnVSkjzLV4rQxkuZu0hWaIw5gWVzJ+7z86gDMPoVGJm7qTEH2CyK7MIZ/G1Ufo3nZLi9+JGw0TqUUFGfuudnFxEVH35hfaGSafQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW3PR20MB3388.namprd20.prod.outlook.com (2603:10b6:303:54::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Sun, 3 Dec
 2023 23:32:07 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Sun, 3 Dec 2023
 23:32:07 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/7] Add Huashan Pi board support
Date:   Mon,  4 Dec 2023 07:32:02 +0800
Message-ID: <IA1PR20MB49537B177B6F3614D8D1E3E6BB87A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <MA0P287MB033290A6C8B15202E31E43CCFE80A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
References: <MA0P287MB033290A6C8B15202E31E43CCFE80A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [v20BKasDHHab6HSJdizV/LFdacPqoKQD/o2qTC7NaQc=]
X-ClientProxiedBy: BYAPR06CA0041.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::18) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231203233203.116267-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW3PR20MB3388:EE_
X-MS-Office365-Filtering-Correlation-Id: 630610d6-a61b-4006-c074-08dbf4581017
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q01thJSpzCoZL3WpEc8FGLfoXpv/ts3v+S9uw3bdK3j9Cd425rlATqFCkEzt+Igdjh93COi9w6Qdt01pDeda2XKu5eek7D6Pk7+cynTvBxHfLwq8bnCHCkviAhD10ZMLhywB7Fr1gm+EaKm+0q9qN124Xanha5TE5Va3Do6trEjBy78hpGix6XS+XBWG+AlzumHhuQxeY+XUuHhgClpI54OkrDESqWQeJWJzFoe61TWAMhDRxwB3C3KoF+kHhYj+Q/f5g4CWWAGQaZRNoHtytIEzzmE+jSaYsZkdDJINFq3Nrsg58/mWnhLVUdNx9Vw4aqDm/5yrDdFeSJ8XU4Ti8fdUWI8v8L6vcytolh1mSXvMrTMIZI6X7/xQ4YWp9R9JJIXU4hD3MQX1qw33T0vp32lskKMn2KBEsVqWJ6H7bKQOiqA6xvasPXgoAGuhNoUiEUEJLye3bSjNxeVvGV/CgZ5IdLe+Ad3jaFiTOvQ5BL1vIOjsPvnbRd4hb49dW96qacmkCsY18u9dAV+Itnu3vJxlRiLluS5LIosruUChdSKwstgYhp8Qu+F/PY5sWQGdd4ukoxg5JlPx6jtagjBybKSDAUV1dVejrChIYtSX6VcZ+HSFmZLroptdEP6zF3ZoDscnJF1/t4n+Vebcw40TwpO28VZx5lciMs35YOg8JsM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fb4i/UnWjvyDxEXxkr/0erm9mNjaRFo+5oiQmEv0FtbZGsqO+iEHnZEW0kf2?=
 =?us-ascii?Q?2GKVpAnSvKDRTK/Sy4rmpIakaF02TJGoo6dZF9BVj423KN2+r9v6SLQy7Vbx?=
 =?us-ascii?Q?yt3DhpcUB07766PNh+jO/lxjtY8DytdHb2vI6MhcNubhzHncy8K0wcGHta1+?=
 =?us-ascii?Q?XY08CPNYWkusePydcdJMp3Sz8Wz3aXLGQy1IMm+ouVVPTjyrOMtK/rdn6/Aa?=
 =?us-ascii?Q?qu81QY2x0KuP+2dmCK2vlxRcBx0nJjJE4CmGwdSazR1VJbDqpKNMmsiPMdzE?=
 =?us-ascii?Q?FTV610wO7rOKZapznhhnzvp/ScxvHHzzfmgZXc7TOPPX0H2Qi7wsFStrXvw9?=
 =?us-ascii?Q?8cMxLrC8NSJEIR/RtvVrp+9eSIInWwXm+fR/eEQWg+qt05uNfqPTiKG2ec7k?=
 =?us-ascii?Q?ykOMVZibb/nv6W0JV4XIyqpr9vaXYK7Rdg25wJcf8S2AzPJB17Y8K3nLQ4IX?=
 =?us-ascii?Q?ZUc4KrH7xEAnNytIrltoR+Yr/mZWz0rFgmErfNHtbTXsvr3NH3KbxbeYxAXc?=
 =?us-ascii?Q?GhPAnl3kQTwJaB92r/0fvaiQ8bzqlut0tmiNH23I8si8NxPRx5zJ4rOcEEy2?=
 =?us-ascii?Q?o+FnqiW32oFodCckoLidIqJzcj78HGPb2vwypvCUQHjLIZR7D97eowmc4e7B?=
 =?us-ascii?Q?96d1P737ksC5fJ2UOuvX4ZmQy6njquW8EQTeQVAVTzd5AIepxsbC/3kVYtIM?=
 =?us-ascii?Q?/7T16sSdQA0mdLQHhUNa4gXZPwCEV44yo83i6VArkArH6ZiCkUQekQ3Rp4Ys?=
 =?us-ascii?Q?zB8DSJneBqNp/kEBNKOiGTEkUywXZHixRikjpAuEwzyt/jEwtcuFxCuCsakU?=
 =?us-ascii?Q?/iNH5T7d0luEFQDg1C08RmtYV0txzKjciHZz0/qaXRoDT1IVC31UJtAn+wBf?=
 =?us-ascii?Q?L/Kx08CPEtG9w2/BNevT9Xtnj4v5KTAE6bSUfKRTWfARG9Zw9Hn0wsFG4Nc0?=
 =?us-ascii?Q?nf6TPinsVzYCupuIc6oxIdM4gWwzvc7nNFJvc/hOI4REZ/y1o6EqRnSfvewB?=
 =?us-ascii?Q?jsCubYwIOL24NBWrlWzL54llxBKZZbPfK/J6EZcbiP2IJnfPkPmf3ZfRh9U7?=
 =?us-ascii?Q?4DMyP2wqvBWs2ueIkQv4Jq2tuIORhzpS/+3J3B2vYn4xp9ibLIJTFytqnqvg?=
 =?us-ascii?Q?+5gVklFj11EnHQQEZD1kqriWetzq6EbFhtbJ2Zn/PrlQUEaR9znz+S1jewfz?=
 =?us-ascii?Q?5CNXraAXjgWsUfjZz9qAz7t/gA/Bd2jptSSLLHFXj/fiB5Qv+xNdtvifOpQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630610d6-a61b-4006-c074-08dbf4581017
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 23:32:07.2184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR20MB3388
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 2023/12/2 0:21, Conor Dooley wrote:
>> On Fri, Dec 01, 2023 at 04:31:38PM +0800, Inochi Amaoto wrote:
>>>> On Fri, Dec 01, 2023 at 09:02:59AM +0800, Inochi Amaoto wrote:
>>>>>> On Fri, Dec 01, 2023 at 07:21:29AM +0800, Inochi Amaoto wrote:
>>>>>>>> On Thu, 19 Oct 2023 07:18:00 +0800, Inochi Amaoto wrote:
>>>>>>>>> Huashan Pi board is an embedded development platform based on the
>>>>>>>>> CV1812H chip. Add minimal device tree files for this board.
>>>>>>>>> Currently, it can boot to a basic shell.
>>>>>>>>>
>>>>>>>>> NOTE: this series is based on the Jisheng's Milk-V Duo patch.
>>>>>>>>>
>>>>>>>>> Link: https://en.sophgo.com/product/introduce/huashan.html
>>>>>>>>> Link: https://en.sophgo.com/product/introduce/cv181xH.html
>>>>>>>>> Link: https://lore.kernel.org/linux-riscv/20231006121449.721-1-jszhang@kernel.org/
>>>>>>>>>
>>>>>>>>> [...]
>>>>>>>> Applied to riscv-dt-for-next, thanks! LMK if something looks not as
>>>>>>>> expected.
>>>>>>>>
>>>>>>>> [1/7] dt-bindings: interrupt-controller: Add SOPHGO CV1812H plic
>>>>>>>>       https://git.kernel.org/conor/c/21a34e63afcc
>>>>>>>> [2/7] dt-bindings: timer: Add SOPHGO CV1812H clint
>>>>>>>>       https://git.kernel.org/conor/c/06ea2a1968a9
>>>>>>>> [3/7] dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
>>>>>>>>       https://git.kernel.org/conor/c/d7b92027834e
>>>>>>>> [4/7] riscv: dts: sophgo: Separate compatible specific for CV1800B soc
>>>>>>>>       https://git.kernel.org/conor/c/5b5dce3951b2
>>>>>>>> [5/7] riscv: dts: sophgo: cv18xx: Add gpio devices
>>>>>>>>       https://git.kernel.org/conor/c/dd791b45c866
>>>>>>>> [6/7] riscv: dts: sophgo: add initial CV1812H SoC device tree
>>>>>>>>       https://git.kernel.org/conor/c/681ec684a741
>>>>>>>> [7/7] riscv: dts: sophgo: add Huashan Pi board device tree
>>>>>>>>       https://git.kernel.org/conor/c/2c36b0cfb408
>>>>>>> Thanks for the confirmation. But I suggest to revert these patches.
>>>>>>> Several days ago, Sophgo informed me that CV1810 series will be
>>>>>>> renamed. And the Huashan Pi will switch to the chip with new name.
>>>>>>> To avoid unnecessary conflict, please drop these patch and I will
>>>>>>> prepare a new patch once the renamed chip is launched.
>>>>>> This is a board that exists, that you (and possibly others) have, right?
>>>>>>
>>>>> Yes, of course.
>>>> I dunno then. It sounds from your message that this is purely a rebrand
>>>> of the SoCs,
>>> IIRC, it is.
>>> FYI, Chen and Chao. Maybe you know something more.
>>>
>>>> so since people already have these boards, I'd rather not.
>>>> We should be able to support both since it's just a naming change,
>>>> right?
>>> I agree with this. If the above is true, we can just reuse the exists code
>>> with a different compatible name, right?
>> I think so? I'm not sure what the precedent really is for pure
>> rebrandings of an SoC.
>> I say for now, assume we can do that, and we can discuss it with Rob and
>> Krzysztof when the time comes if there is no difference between the SoCs
>> and boards.
>>
>> Cheers,
>> Conor.
>
>As far as I know, sophgo's SoC product names all start with "sg", while products starting with "cv" come from CVITEK (another chip company). CVITEK was acquired by sophgo a year ago, so now many SOC product names that originally started with "cv" are being repackaged and changed to start with "sg".
>
>For the cv1800b adopted by Duo, Sophgo has made it clear that it will not change its codename.
>
>But I heard that for other products, such as the cv1812h used by Huashanpi, sophgo may change their names in the future, but sophgo has not officially confirmed it yet. Looks like sophgo themselves are still in the process of digesting cv's products, ;)
>
>Since we have just started to support cv1812h and have not done much work yet, I suggest not to merge this patch into the mainline, and wait until there is clear news before doing this to avoid introducing unnecessary modifications later.
>

Hi Chen,

There is a update for you. The cv1812h does not have the A53 core as the
sg200x does. Maybe we should treat cv1812h as a trim of sg200x, not just
a reband.

According to this information, I suggest to preserve these code for
cv1812h, it can make upstream the new soc eaiser. Also, adding a new
compatible is not too hard, and it is necessary if we have new soc.
Otherwise, the one with Huashan Pi now may be confused because it have
a old version.

>Thanks,
>
>Chen
>
