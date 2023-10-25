Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918747D668A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjJYJR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbjJYJRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:17:22 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A359318B;
        Wed, 25 Oct 2023 02:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCJWphc/BNmwBwIleFy0q28NdFsbTyxLQ0bldhiGQjVpQQR9AEtiXdjaEZ4HS4SWS/F/KWkhJJPq1XxlrR6mxNvVBDysweQPrnASM2gbnzxWX8jRVqw+LYTJdaFkr5nJHeJ9ebZ7hfbejx9BBlcoycZceZNLStMZbzCyL/tEPrBuFOPFE78u878Edq7mp1+WnnAjPOwr/sqmwYreQhsnM7vcqlZE2s8oRcNUkvxZcWF4MLvr0DBq7gmaDNvIIo+THiiWSYAeSgdAGACb/QLQpGsoAy9bQDw5Cx9Yruihxz5UtV845wAeRu8vuERwase7caB2Ir1awzvxvA3Y3KBjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03Mq5EbezvdJwXkCfqW6NzFfi1nenBBcIKQbS8gGZP4=;
 b=XFpew9jN2LN0tHa1Xq97ol4pO+Udrif9logJ+Ms2zBV1UlWlj9JrKbkNaZRJJMKAwEZOlNlW9d0PjXra87doxriO66JoHPt6w8ZKmQ/akkTR1SzyVQHPPpEm57/m+/Ce/ZA8RkFxPAfSlKD9SAKnImp+YE5X96lFi8kpVopqk1+E/u6tt9EmXuWBW1KAKP7AyqwFrAXZQMuu5UNa9jmiC03TaU8DdrV77EQ7fNiawwtV9xK8huesPoJ9tMw98R1Rpus/X/mtlK4cp8EOGQVj+3bwLwpuvss4NrzsdvPimX0TNUYGI6yC0aWHizcqpfi0kcvP6Ecw7xcamv/Mevv7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03Mq5EbezvdJwXkCfqW6NzFfi1nenBBcIKQbS8gGZP4=;
 b=AByPDnpkyjPelsTxoEztdOCMCG7y54iN0qhxEFvj2zyH7m22nVPTgd+ZKfrVMJqzmGMZJtcFwQsD8xcqRC2o7Sc+3poyTZClKFSrHxcaLRCsq2mC86aU/uaXZdU/8cq363ccUkiMwGAnBTba4U3PQOnReVvStl3US6KcKEN2GnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS2PR08MB8624.eurprd08.prod.outlook.com (2603:10a6:20b:55f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 09:17:14 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::87b4:3635:b89d:c07c]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::87b4:3635:b89d:c07c%6]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:17:14 +0000
Message-ID: <5438a194-7349-4a20-84d0-efe88b7ab396@wolfvision.net>
Date:   Wed, 25 Oct 2023 11:17:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Content-Language: en-US
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, ezequiel@vanguardiasur.com.ar,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com
References: <cover.1697446303.git.mehdi.djait@bootlin.com>
 <ZTFMR7PlcQXpeoQO@aptenodytes>
 <11cccad3-e665-41dc-89c2-5ddc22b1e2fe@wolfvision.net>
 <ZTjVOAPnXEj9LgOE@aptenodytes>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <ZTjVOAPnXEj9LgOE@aptenodytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0099.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::28) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS2PR08MB8624:EE_
X-MS-Office365-Filtering-Correlation-Id: 60501bbc-256d-40fb-7a3b-08dbd53b2d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMTRgJoNzEf8wmZ7xTnIJl/46wrqzOyeCO6u6iOEOdt/PIbZ4BDGp9gJqgOx0jIKJ4Cc4z24pICOaUoDlFc3H6irvGDR61K2vJykt6uXGVvi+gBxp7ojUO+AKUPju8sXYgtlV/lm4bjLa8hCYr/EJFo99bcISqALb8JpDlW5W6rdtfOXW0bHmQua0cxtvEBcVCJcILWTY1T04Dk8WQcIsH63qcxLBKu1urm4QaOUjM0dt5v7sv9T9kwz3vqek0sHF7hAPRBfUTn2w/BJyWM5SyYFY9Md5nWSzIuPlwxfPGPj1v1ah3j8Cc6cbytJb+vJXnLEIjSLtxOQP0UN46KZgpxxt9uRpSMd9NeCh1DGChCEcfI9QTosGSiooSmrMq2/OOwiREGu/SVCdAo1MBAfpOu/U5AfwVmJiaT30pmXGnR5mxXkfTQUEFz7SJnJfhU9cv/fGYpl0y6BhuIqotV+OW6UMQe5DQyqHdkvk86mz1Xik//o2JNTQH4ZlTy8bnJTmptNH0eVBm/DhO1he+4bHAodPEdalPOnaKhzu4KEQxycKCIcOOL81YeJrZYJyt5KZxNcSlHhjWONp+k188feqI5lQYYdEkdI5SghhMvBL62OZh3nOr69j/tUO6mzNmhu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(366004)(376002)(346002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(44832011)(41300700001)(6506007)(6666004)(36916002)(53546011)(478600001)(2616005)(6512007)(66556008)(66476007)(66946007)(36756003)(6916009)(316002)(31696002)(6486002)(966005)(86362001)(26005)(83380400001)(38100700002)(8676002)(8936002)(4326008)(7416002)(5660300002)(31686004)(2906002)(30864003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1VIbjJTM3RHVThDZlU1Rm14ektjSnVNRkpzamFOb1drUlFEQUdPMDdualJT?=
 =?utf-8?B?ODFWeDNkSnFMNGt5SXA4MVpsMFFEczM5S1NCVlNKZjVJRzAvOVB2M2owTUcz?=
 =?utf-8?B?Q1FDekdkd244Y0NTQkhHWVZtWU5yNnpveSsvMkJwbWFOQnpoOWg1Mk9pS0o1?=
 =?utf-8?B?WjNFY09ZZHJ5dVRKOUdXUFB3RU52QVpmOEN4MnZ5WWhZbnBycHN6Z201T01Y?=
 =?utf-8?B?cFhJdzl3MDdPY1hHam5jeXMzQ2dBeVc5NlRnTUxYRDBIcjhIVHFZYUovYTkx?=
 =?utf-8?B?K0NzT1NDb2grQ0tyYW9jakYzZi9rbHByNVZZdzhLYXVjOVBFK25Ja1pFYmJ4?=
 =?utf-8?B?SlNZK29qeSs0d0l3bnJwVC9Hd1U2Y1FUTVVmbDR0TDVzdXMrTWFGV24vU2po?=
 =?utf-8?B?S1V2OXdoSXVEWUYyeHU5NjZTUEY4Sk1QVlk1bHBvTXJ1ajJJRkU1U2NuenQ3?=
 =?utf-8?B?RGRFNy9HK2xCYlE0eHpGbTl6bEFIZjBwbUk5d0IzVEpzR292K2d0T1Q2TWdv?=
 =?utf-8?B?MHJmN3JuMUhKZCtNSE1UOFlxL1VmUUxjOG13Vk9SNHljRmQvakZnVDlrTHhI?=
 =?utf-8?B?T0xEZmFKTlllbHRMQ3pUQllHWlI0NUNxVVUxdExTY2FOSTJhU0ttemlCb1Z1?=
 =?utf-8?B?QUxoUFNLZUxmUzlOV0RMZG91RUpBYktFeWoxS1VMaFBZWmM3OHl0WWY5cXJI?=
 =?utf-8?B?UnFmYjJSeVFCOGxsTSswR2wyQ0F4aEFEbW11NHNrQWpXdTFNbko2bCtOcFZ5?=
 =?utf-8?B?SWNVcmtzR29xUW02aEJJRy9wREFrVWdmc3RVMjRlNG4vNlJxNlZleDVkdkFE?=
 =?utf-8?B?bnRqYXJEZkR4dVJDeGhyU0FZUENLclo1N3p1c2ZhVnpITnpTQjB6dk42U1Fl?=
 =?utf-8?B?eWswcWdHdnVDcnY1emtxRHp3M0hsWlBsUXorbzhEWEFaQndHNE8ybXcwMEpY?=
 =?utf-8?B?d2RoVUdlSDllQzE5bHByc1QvMFFYUzRZck43R2pQUEJuMlJGNEV2eloxeGMx?=
 =?utf-8?B?SkdONnpkQTV1MXNLUE80Ry9NcVArOTVxZmQ2MWFMcjl2eVhMR1RBeWU1Y01m?=
 =?utf-8?B?SHF0OHNhZVJSR1UxZGUxdExGWjE2bUpEUHduZFF2S2hRVCs3L2lrbEJFRGg2?=
 =?utf-8?B?NnRpbkpkTFg1UitTY3BYS1k2dmY1T3dBRzJydmU4dkdEaWE3NHJyY0RVSWda?=
 =?utf-8?B?L3hleGRtci9LWDBaZjNXc1FSVFlLSWJxNVA4eGxER3BSeWRYV1RLZkg0ancv?=
 =?utf-8?B?OTMramdvdkx2dVhvOTZFbkRTK1A1OGZrM2RMQWhDRC9xbWpKak5iWlltL2lD?=
 =?utf-8?B?VHJxOVRBMG85UzU2NGx2c3N5N09ETHJENHZBUnVJRGRYakk1eGJQR1BsWFdt?=
 =?utf-8?B?WlRHd2t5bDk1QWlXZytjSGVpdjhEUzhhaHpLdlExTS9tMnMzb21VU1pXUEM5?=
 =?utf-8?B?UHlTT3d4bkFWTVVXSmp6em1MbUdmdUdyZERseCtFVng3dUpPTk12TDlCOTZu?=
 =?utf-8?B?RzhjKzZrK1d4NWp1M05pM1VMRDg0SHV5c1Z1a1RXVk9mZlZTanV0SlhoZGhQ?=
 =?utf-8?B?QStwWTJpS3daVW5oWUkxUHB4YXBsd1lHWkg1emZXa2ZnRk93ZzltV2wvbVVy?=
 =?utf-8?B?cHJOckR6NXVoY3QrUTRVKzRJaE45bDhIZ2lpWDZoS2NYQ0RqOEZNaHJEOW8y?=
 =?utf-8?B?amJJWUZyRmFZUWtLOFFaWS8rWnF1eHZXV0R5R01haW0wK2FmTE9vT0NGaFNa?=
 =?utf-8?B?MkRteEYvQ2hFVmovMmlNcGxGcTBLSFc1Nk9tbzh2OTVpd3NCMjJKTGFhcjUv?=
 =?utf-8?B?Q0ZJSTF3eGpmT2l4QUsxK2ptT1BIZ1pYa0p6NGRLd2hTZm1XWi9rWFdoTlZq?=
 =?utf-8?B?ZWlrOVkzd3BsTVlPREh3bkh6amZzN3Z1M1lsQU5CenZBSXNCeVhnNk5XNGg4?=
 =?utf-8?B?TDB3QlRtd0hiRFUrajdlQWVpSm9rZUdnNGtXY01oZXVEM1IxbTVIazlTYWhJ?=
 =?utf-8?B?Z0JkRmhtbkNrczFmQitHRXJ3YW9ZWVFHMkVDcWRFalQ0MmZyalhVMlZmNXR0?=
 =?utf-8?B?WUkvdmprSk8xU09aZmdqOElKVGdrQ0JJdko5czZoZm1kajZpNEZRdWNrQlVZ?=
 =?utf-8?B?V3NTNmJLd1ZJbDFVa2hXOU9JeVNyU2ZzeThuQXA4MTgzdFB4TjY4OXVENFR5?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 60501bbc-256d-40fb-7a3b-08dbd53b2d0a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:17:13.9760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LW0iTcM5y/ieTyY3SxatTNi80QvN0jN6wlIGu4uVr59tu9D+2AQHvQr7bggMJtjkNI3kknDLFVWvV9zMsdOcSqM+0mpO709A6K+ZkYE4fDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8624
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URI_HEX
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 10/25/23 10:43, Paul Kocialkowski wrote:
> [...]
>>> Here is the detail of my research on the concerned chips. The + at the beginning
>>> of the line indicate support in Rockchip's 4.4 tree:
>>>
>>> - RK3566/RK3568 (2020): CIF pins + VICAP terminology
>>> + RK1808 (2019): CIF pins + VIP registers + VIP_MIPI registers
>>> + PX30 (2017): VIP pins + VIP registers
>>> + RK3328 (2017): CIF pins + VIP terminology
>>> - RK3326 (2017): CIF pins + VIP terminology
>>> - RK3399 (2016): CIF pins
>>> - RK3368 (2015): CIF pins
>>> - PX2 (2014-11): CIF pins + CIF registers
>>> + RK3126/RK3128 (2014-10): CIF pins + registers
>>> + RK3288 (2014-05): CIF pins + VIP terminology
>>> - RK3026 (2013): CIF pins + CIF registers
>>> - RK3168/RK3188/PX3 (2012): CIF pins + CIF registers
>>> - RK3066 (2012): CIF pins + CIF registers
>>>
>>> Note that there are a few variations over time (added/removed registers), but
>>> the offsets of crucial registers are always the same, so we can safely
>>> assume this is the same unit in different generations.
>>>
>>> Since the RK3066 is the first model starting the RK30 lineup I think we can
>>> safely use that for the "base" compatible to be used for e.g. the bindings
>>> document, instead of px30 which is just one of the many SoCs that use this unit.
>>
>> Once the name of the driver is defined and adjusted in v9, I can try to
>> give the series a shot on my RK3568 board. First attempts to do so
>> basing on Maxime's v5 showed that with a few modifications the DVP
>> feature works fine. In a subsequent step, we could discuss the inclusion
>> of the MIPI CSI-2 things in order to keep the driver sufficiently general.
> 
> Nice! I guess there will be a need to introduce a variant structure associated
> to each compatible to express the differences betweens these different
> generations.

Indeed. If Mehdi and you suggest something, I'd be happy to review.
Otherwise, I'll try to come up with something reasonable. IMHO it would
make sense (as a first step) to have the clocks and the resets in this
structure, as well as a sub-structure that describes the DVP. The latter
consists of registers mainly, but maybe supported input/output formats
and other things should go in there as well. Also, downstream code has a
significant number of
    if (some condition including chip_id) A; else B;
things that we should probably get rid of with this variant structure.

As next step, a sub-structure for MIPI CSI-2 could be defined. RK356X
will have one of those, RK3588 will feature even six of them. So we
should add a const array to the variant structure.

> Note that we will also probably need to convert the driver over to a MC-centric
> approach, but this is of course outside of the scope of this series.

That would absolutely make sense. What is missing, though? (I was
wondering that the driver calls media_device_(un)register but no
/dev/mediaX device pops up.)

Best regards,
Michael

> 
> Cheers,
> 
> Paul
> 
>> @Mehdi: If you could Cc: me when you send out v9 it'd be much appreciated.
>>
>> Best regards,
>> Michael
>>
>> [0]
>> https://github.com/rockchip-linux/kernel/blob/develop-5.10/drivers/media/platform/rockchip/cif/hw.c#L968
>>
>>>
>>>> This version of the driver supports ONLY the parallel interface BT656
>>>> and was tested/implemented using an SDTV video decoder
>>>>
>>>> media_tree, base-commit: 2c1bae27df787c9535e48cc27bbd11c3c3e0a235
>>>>
>>>> V7 => V8:
>>>> vip/capture.c:
>>>> - fixed a warning: unused variable reported by the kernel test robot
>>>>
>>>> V6 => V7:
>>>> vip/capture.c vip/dev.c vip/dev.h
>>>> - renamed all struct rk_vip_dev dev => struct rk_vip_dev vip_dev
>>>> - added some error when rk_vip_get_buffer() returns NULL
>>>> - removed a WARN_ON
>>>> - made the irq NOT shared
>>>> - dropped of_match_ptr
>>>> - added the rk_vip_get_resource() function
>>>>
>>>> rockchip,px30-vip.yaml:
>>>> - changed filename to match the compatible
>>>> - dropped the mention of the other rockchip SoC in the dt-binding
>>>>   description and added a more detailed description of VIP
>>>> - removed unused labels in the example
>>>>
>>>>
>>>> V5 [1] => V6:
>>>> vip/capture.c vip/dev.c vip/dev.h
>>>> - added a video g_input_status subdev call, V4L2_IN_CAP_STD and the
>>>>   supported stds in rk_vip_enum_input callback
>>>> - added rk_vip_g_std, rk_vip_s_std and rk_vip_querystd callbacks
>>>> - added the supported video_device->tvnorms
>>>> - s_std will now update the format as this depends on the standard
>>>>   NTSC/PAL (as suggested by Hans in [1])
>>>> - removed STD_ATSC
>>>> - moved the colorimetry information to come from the subdev
>>>> - removed the core s_power subdev calls
>>>> - dropped cropping in rk_vip_stream struct
>>>>
>>>> rockchip-vip.yaml:
>>>> - fixed a mistake in the name of third clock plckin -> plck
>>>> - changed the reg maxItems 2 -> 1
>>>>
>>>> [1] https://lore.kernel.org/linux-media/20201229161724.511102-1-maxime.chevallier@bootlin.com/
>>>>
>>>> I used v4l-utils with HEAD: commit 1ee258e5bb91a12df378e19eb255c5219d6bc36b
>>>>
>>>> # v4l2-compliance 
>>>> v4l2-compliance 1.25.0, 64 bits, 64-bit time_t
>>>>
>>>> Compliance test for rk_vip device /dev/video0:
>>>>
>>>> Driver Info:
>>>>         Driver name      : rk_vip
>>>>         Card type        : rk_vip
>>>>         Bus info         : platform:ff490000.vip
>>>>         Driver version   : 6.6.0
>>>>         Capabilities     : 0x84201000
>>>>                 Video Capture Multiplanar
>>>>                 Streaming
>>>>                 Extended Pix Format
>>>>                 Device Capabilities
>>>>         Device Caps      : 0x04201000
>>>>                 Video Capture Multiplanar
>>>>                 Streaming
>>>>                 Extended Pix Format
>>>> Media Driver Info:
>>>>         Driver name      : rk_vip
>>>>         Model            : rk_vip
>>>>         Serial           : 
>>>>         Bus info         : platform:ff490000.vip
>>>>         Media version    : 6.6.0
>>>>         Hardware revision: 0x00000000 (0)
>>>>         Driver version   : 6.6.0
>>>> Interface Info:
>>>>         ID               : 0x03000002
>>>>         Type             : V4L Video
>>>> Entity Info:
>>>>         ID               : 0x00000001 (1)
>>>>         Name             : video_rkvip
>>>>         Function         : V4L2 I/O
>>>>         Pad 0x01000004   : 0: Sink
>>>>           Link 0x02000009: from remote pad 0x1000006 of entity 'tw9900 2-0044' (Digital Video Decoder): Data, Enabled
>>>>
>>>> Required ioctls:
>>>>         test MC information (see 'Media Driver Info' above): OK
>>>>         test VIDIOC_QUERYCAP: OK
>>>>         test invalid ioctls: OK
>>>>
>>>> Allow for multiple opens:
>>>>         test second /dev/video0 open: OK
>>>>         test VIDIOC_QUERYCAP: OK
>>>>         test VIDIOC_G/S_PRIORITY: OK
>>>>         test for unlimited opens: OK
>>>>
>>>> Debug ioctls:
>>>>         test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>>>>         test VIDIOC_LOG_STATUS: OK (Not Supported)
>>>>
>>>> Input ioctls:
>>>>         test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>>>>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>>>>         test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>>>>         test VIDIOC_ENUMAUDIO: OK (Not Supported)
>>>>         test VIDIOC_G/S/ENUMINPUT: OK
>>>>         test VIDIOC_G/S_AUDIO: OK (Not Supported)
>>>>         Inputs: 1 Audio Inputs: 0 Tuners: 0
>>>>
>>>> Output ioctls:
>>>>         test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>>>>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>>>>         test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>>>>         test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>>>>         test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>>>>         Outputs: 0 Audio Outputs: 0 Modulators: 0
>>>>
>>>> Input/Output configuration ioctls:
>>>>         test VIDIOC_ENUM/G/S/QUERY_STD: OK
>>>>         test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>>>>         test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>>>>         test VIDIOC_G/S_EDID: OK (Not Supported)
>>>>
>>>> Control ioctls (Input 0):
>>>>         test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
>>>>         test VIDIOC_QUERYCTRL: OK (Not Supported)
>>>>         test VIDIOC_G/S_CTRL: OK (Not Supported)
>>>>         test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
>>>>         test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
>>>>         test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>>>>         Standard Controls: 0 Private Controls: 0
>>>>
>>>> Format ioctls (Input 0):
>>>>         test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>>>>         test VIDIOC_G/S_PARM: OK (Not Supported)
>>>>         test VIDIOC_G_FBUF: OK (Not Supported)
>>>>         test VIDIOC_G_FMT: OK
>>>>         test VIDIOC_TRY_FMT: OK
>>>>         test VIDIOC_S_FMT: OK
>>>>         test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>>>>         test Cropping: OK (Not Supported)
>>>>         test Composing: OK (Not Supported)
>>>>         test Scaling: OK (Not Supported)
>>>>
>>>> Codec ioctls (Input 0):
>>>>         test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>>>>         test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>>>>         test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
>>>>
>>>> Buffer ioctls (Input 0):
>>>>         test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>>>>         test VIDIOC_EXPBUF: OK
>>>>         test Requests: OK (Not Supported)
>>>>
>>>> Total for rk_vip device /dev/video0: 46, Succeeded: 46, Failed: 0, Warnings: 0
>>>>
>>>> Mehdi Djait (3):
>>>>   media: dt-bindings: media: add bindings for Rockchip VIP
>>>>   media: rockchip: Add a driver for Rockhip's camera interface
>>>>   arm64: dts: rockchip: Add the camera interface
>>>>
>>>>  .../bindings/media/rockchip,px30-vip.yaml     |   93 ++
>>>>  arch/arm64/boot/dts/rockchip/px30.dtsi        |   12 +
>>>>  drivers/media/platform/rockchip/Kconfig       |    1 +
>>>>  drivers/media/platform/rockchip/Makefile      |    1 +
>>>>  drivers/media/platform/rockchip/vip/Kconfig   |   14 +
>>>>  drivers/media/platform/rockchip/vip/Makefile  |    3 +
>>>>  drivers/media/platform/rockchip/vip/capture.c | 1210 +++++++++++++++++
>>>>  drivers/media/platform/rockchip/vip/dev.c     |  346 +++++
>>>>  drivers/media/platform/rockchip/vip/dev.h     |  163 +++
>>>>  drivers/media/platform/rockchip/vip/regs.h    |  260 ++++
>>>>  10 files changed, 2103 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
>>>>  create mode 100644 drivers/media/platform/rockchip/vip/Kconfig
>>>>  create mode 100644 drivers/media/platform/rockchip/vip/Makefile
>>>>  create mode 100644 drivers/media/platform/rockchip/vip/capture.c
>>>>  create mode 100644 drivers/media/platform/rockchip/vip/dev.c
>>>>  create mode 100644 drivers/media/platform/rockchip/vip/dev.h
>>>>  create mode 100644 drivers/media/platform/rockchip/vip/regs.h
>>>>
>>>> -- 
>>>> 2.41.0
>>>>
>>>
> 
