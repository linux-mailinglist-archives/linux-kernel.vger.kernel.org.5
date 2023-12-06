Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174EC806D4F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378060AbjLFLF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378045AbjLFLFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:05:09 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn20800.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::800])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0049C35B5;
        Wed,  6 Dec 2023 03:02:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtCedAzyJNA5JPSAeD09Nc6EUlkfF/yevQ21SnoCikFMZnLq6nLvDI4qIet+tfZoL5b1Hhuk8ZKs6r0+A/BHAmYnC5Mf1h5W86KBy1EiONaHYBLz3aRBP8Q/d6ozU7IX2uhtbShhyN4aaHsBQB6420GSVOTYAUoCrQWSzlGBKALWh6ypIJF3SysE9pwoWkN4t1phtYNSMcndPtl9Ma5xNnpAglbZyTWUfrL+kLex4v/EOKNXeHP0DTR9ZoHXGi1F2Ovt4EaBnQjLRCsS5mM1wdx/DBZKv53lU35aPpvDeYi8rB39YGvWsvfbde+73zphJ5PDAmjz93D9AN48zc4lPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7apL2HYT1nWApNnv/9FspLSiSQS9ch8iOfTconmBBw=;
 b=ArbdgwJx9g6Kym2FXa9EurK9jbzRRKZfTNTNRVvDVtfZMSpwUDtNjZoPgCq7CzvRN/WeY5ynfy2ZbvkUUZPixPbAGY4EsYkcG32dYRAcMQNVguOAys/aDV0jszHIZzZ9SFX3idD47pGGyuqwTVCiKGseN1bJQV+E9EBoZp5J3sEjhocSFgGPowUc/jiA2TvTdRcNxXoCbLJN48sdiKGs4ZGnyA2LsfCa5d3kvNylfdSpwGUtHnji0umOnkvCarvTqGL2uHC3keJt5IGdxjtbgO/PnVdNzny+YqwuVvcxkDsXjPmKjmSIpt6eBvxTpypgfEwwB3vs5RJ3fLAfr88zsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7apL2HYT1nWApNnv/9FspLSiSQS9ch8iOfTconmBBw=;
 b=rMAwFH01i0EvEwhsfSZGiiuhSw/L7ITCybPaqu491RBo3sUjndCqYFbjuFQm47qzbQgllHxeEzMIcN5jrBFzZmrJ+Q/uvM89qphbnkJD4cEzaVlF+tUZ3GGSDckjb0JvoPtrhpx4Gk489k7QAbr0XA+JRklK5uK17w6ZozxfNsL8sN41nmDg4mg5/2WhTZRgrAkQAv7rnyefBjk4FDbIoHK6os2GfqsUIDHxLDX2Ud4OkGmlCf65OfEeATFl/wQwNGgtYN6LYQJSAnK3zBQ3qfnXQy1qxixiIEe1prW9aV7TEBhOmfQbGoYuCeJCn0GOtPcNOoRTSMEe0ONTRmDiFw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB5238.namprd20.prod.outlook.com (2603:10b6:806:266::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 11:01:53 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Wed, 6 Dec 2023
 11:01:53 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/4] clk: sophgo: Add CV1800 series clock controller driver
Date:   Wed,  6 Dec 2023 19:01:34 +0800
Message-ID: <IA1PR20MB4953D20414ECD451EC2F388CBB84A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJM55Z9CCH3n5g4_cRid-inr0SU_Kk39AhbrCavGJKhOoz=asw@mail.gmail.com>
References: <CAJM55Z9CCH3n5g4_cRid-inr0SU_Kk39AhbrCavGJKhOoz=asw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [v4RNplijF9hWM15A0rIG3bMPBMyGDwA4F8KBs3KasMc=]
X-ClientProxiedBy: TY1PR01CA0184.jpnprd01.prod.outlook.com (2603:1096:403::14)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231206110135.786328-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d4004d-53ea-43de-48be-08dbf64ac10f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6GvgOC+UMjxsjv4MICbOc+tvXZG2ii3JhDDglkFaV7N5BxlfA9viiUZ99+5Gs8FRz/EKUT9rNsp5/AXH5PDvKc+59IpvnR2OrPWvP20/EaYRRp4F+R9wFcdyLnOqQdofud/IcTsx/GwDsZvR01CBqcIqgGafJR1B6gsA9LrApm7nQsAry+t/blA2fXfc4RMkdYUIaFLznifCOWrtgcay/Ai3sa/VhTFVqY3Tntao9H8tlCsxhZ3ZwtXYu5T92oucoXe5GqMj5GwybNf8x5tEyoBiiVdLg5lMmRGMMpm4tHrgAIar90TP8TG4fi/+QRnrbUGWGOoM3F4h+5K1oH5LZcL0hLyDLmQSgZ9JjiT3Bot8WlHr9SOMmx+XS2Eazx3s0N0uNtAfseXcJP3p33WbWY1RBoWDEfciEhkyYMs69x1PwM4N3bDdkJWJhaxF+Mw9GZq50uGaIfG7zipV1VYQKdf0oqS12Ec/3ixBnFgujT7HxvX4y4L22F5zMj23WFsBWF9DfMrhjPP4by3VEjoSnHDEP0B97IG2DUAf6BTMu+fv+UKMbPAskYKkQzfYnxk++eFcvRI08reHMTTOPgpgFJONQxaTuUvzu2d6YS+gqAwc/skeMjzTsJ8fJ3moImKoOswrtrq7gBbcUL6jipYHGbdQUOHkEdAh5MrtAYtzoG8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ZT+eenRFomfa9ROvzl+wTuFymQAAuDUXB0ickYrbkjN16Eb5uZwsvUO3aI0?=
 =?us-ascii?Q?aAY6ToStog4pzqfzbroyS+5/oBk588KQ9S7WoMgBefDxtFuyips2UzQMDDnT?=
 =?us-ascii?Q?6NlEln32tGa/8HKtCVKRBqV/E3O6HOcsgcQbhvaLNxYeOQNnNTKM2w7ytfqT?=
 =?us-ascii?Q?oOE9Pi+Cmt3pQO4/EgDvQT0vrhZhMyyTGgfhjmd9RZzxfm8k8kgei+uWGmBg?=
 =?us-ascii?Q?JmHPndYmjZfQEXyHvJO/pLg5I6ma6MWVGNsUG6/F5WOTaBKykiBnEAqX1Zw+?=
 =?us-ascii?Q?D6RauWqtzbrhr9HErbKyRLFKpOz/Uob8pUyvZbjsdRQgNV8M7BIbcW8Yxb4o?=
 =?us-ascii?Q?9K4nXy2MSf/MEXvC3zAzirol6MEmHxKw2b+r87oL1z04vSZMT4fS2g6Wr/4u?=
 =?us-ascii?Q?JIrv4oFm75JI/lex/fuXKvBkoNP6gBNXIGjw+xzHzntzEqStSMkisLAZc0tj?=
 =?us-ascii?Q?CgYu8R9fFyd1avtW5fw33AREOO8nreOohAwL2zZgI9hRtZA3HgLBmXJ7Mc6/?=
 =?us-ascii?Q?dF8mF3wjFlE61VaaSfdeX1V749M28D336FbB0J5tEGcDHXmwUrGg6dncdpgl?=
 =?us-ascii?Q?Mq9qsYDlX0kT/LRAWof+/2UVkAiQx3f0CBjlTF1//KGvByaLyRPHqirOgbdi?=
 =?us-ascii?Q?cU59f4QLQnKoYaSGMHmxVyLjCSwnnn+4cUL1I0lOnuwdkK6vcNEPUfk18a/B?=
 =?us-ascii?Q?vckY0Koazz5ow6O5ENLR1YAK81Bpd2YUBnDjE3fgqsoLVYlIZBCJbIYd3bAS?=
 =?us-ascii?Q?AVv3E1cIOegSsaKKfo9RQqTqUGmgyA4cgPa1p90I59fVOxvop4t0Ydwi3a9q?=
 =?us-ascii?Q?VWBZmO9TxUnNid6SBcKQ7jUrl0DC0wMj5xN7NT+LrF8Chvxh0bOCyIGl3r7m?=
 =?us-ascii?Q?eTPzmnYKe/3IBEgGjxmm6/Tdrf9uFWmGcKXOabspD+L71Gj+hahhS7x90YKq?=
 =?us-ascii?Q?2LBcIG6R573m+yWw9a0xunQBbAbnojeBKWBN34xf7azITBVq1UBWZLq3UFTI?=
 =?us-ascii?Q?djEnUXwbS6qvJK8xYgWBOA98Jo7rUjom4LdTp/0Ki40vbfdkEe7JRRgsUNz6?=
 =?us-ascii?Q?VAWf/kpRpJTfoml27dMzxclpjSUY2O6l+TNixbDJ/tiyeYvdH60t49gIDRNF?=
 =?us-ascii?Q?OXRhLnpE1KQSvN/6tEFhQEa4vI/OUZNDNfT8TNcpsqEi+rcAAM9c5HPtFdzX?=
 =?us-ascii?Q?pRUZYTuUDiDI+cyndIdnO6F1PhkMdJWwQ2mOdAQAYdWn2jLTsYl3KkvWDVg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d4004d-53ea-43de-48be-08dbf64ac10f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 11:01:53.2691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5238
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Inochi Amaoto wrote:
>>>
>>> On 2023/12/5 19:55, Inochi Amaoto wrote:
>>>> Add driver for CV1800 series clock controller.
>>> Add more clarification on your changes. Seems you add several files with different names for different products, what's your design idea, please add some brief introduction.
>>
>> In fact, it just adds the driver for the whole CV18XX series. I do not
>> think its clock controller has something different for different product.
>> The CV181X does have more clock, but it shares the same driver code of
>> CV180X. All the things just follow the manual and are for the hardware
>> design. Anyway, I will have a try.
>>
>>>>
>>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>>> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV180X-Clock-v1.xlsx
>>>> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
>>>> ---
>>>> ......
>>>> diff --git a/drivers/clk/sophgo/Kconfig b/drivers/clk/sophgo/Kconfig
>>>> new file mode 100644
>>>> index 000000000000..243d58a30117
>>>> --- /dev/null
>>>> +++ b/drivers/clk/sophgo/Kconfig
>>>> @@ -0,0 +1,7 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# common clock support for SOPHGO SoC family.
>>> Drop this comment line, moving forward, this Kconfig file will be re-used for more different sophgo products.
>>
>> Why? I do not think this have some impact on reuse.
>>
>>>> +
>>>> +config CLK_SOPHGO_CV1800
>>>> +    tristate "Support for the Sophgo CV1800 series SoCs clock controller"
>>>> +    default y
>>>> +    depends on ARCH_SOPHGO || COMPILE_TEST
>>> Suggest to add some help words for this config item.
>>>
>>
>> There is no extra information other than this title.
>> In fact, I think the description title is enough to describe this. Add
>> a duplicate help is useless.
>
>I'd also like to see some more information here. Eg. what are examples of SoC's
>in the CV1800 series. checkpatch also complains:
>
>WARNING: please write a help paragraph that fully describes the config symbol
>#337: FILE: drivers/clk/sophgo/Kconfig:4:
>+config CLK_SOPHGO_CV1800
>+	tristate "Support for the Sophgo CV1800 series SoCs clock controller"
>+	default y
>+	depends on ARCH_SOPHGO || COMPILE_TEST
>

OK, thanks for your advice, I will add this help.

>
>Also the driver says "tristate" here, but defaults to built-in. If it works as
>a module it should be default m to not waste memory on systems not needing this.
>If it can't work properly as a module then tristate should be bool and the
>driver should be updated for that.
>
>/Emil
>

I will have a try and determine the right value. Thanks.
