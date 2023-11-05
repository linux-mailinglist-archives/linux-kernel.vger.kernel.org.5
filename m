Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273E67E16D1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 22:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjKEVU6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 5 Nov 2023 16:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEVU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 16:20:56 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2081.outbound.protection.outlook.com [40.92.46.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ECCE0;
        Sun,  5 Nov 2023 13:20:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gj3oI3NlZDBVK1aUUMVz/7NnqdAdSK2JdoNySe/SxzdiJ98mETp2smALJ6hE7u6Ai3thjiylsWBUNXIM+eok/jv4Zss9dNI4AKaqdPO/r9Ei/pt6/bNnbzG1xppKtRZFaey276KOF3v5GZ3rWB1dogRoz1e07l1+rh0JhZOzhvT6tYq4zTvtU/W2VXtz8920712hEwiEdX0m/cIgbamrLNKoIfvTfnELUa9uXy+Qbzg2rMW+K4PFyiRfD6y1cXh9070B9c35yEeYTjETIEIcvBn5sraxVA0xOubqXD44KJWzFyEEFCJe0gJC2ADU5TLwL5twmHEL5JoOL6y7ayBGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj8oBW5Z1WV883J45tm10/a58Q2NBnepuFlqRvVxPdA=;
 b=hQqxxsw/q2zW4Uih+Krwmrplt2Tm7sup3AbZNp2yLZasUPXCafQQvSDf7t4iVu/dyJ6IuGvWhMIt+zi/nS5S2yCwRfldrBpBZFfktiwpsHkcAOovon+5LLXm1e6rMVSxp1qlvkHn9E9u1HEu3b06pQkSexJvySb+h/IQmAjTl4KAakpbR9DClpauUYPac7UifpnlDDUpH615XYmn03tdcinR+gzfp8RWw69OtJRl08ZSaZUQ95lAlB5GIx2h0HamcPKZIVe6sDuNx/k9dqiyB0Zq+WUUi0imLGF5Ojov9GGRhXKgW95wtybH0gOs4FJmx+IVz+Qjk7ySB58PIdYqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) by
 BN9PR12MB5066.namprd12.prod.outlook.com (2603:10b6:408:133::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Sun, 5 Nov
 2023 21:20:50 +0000
Received: from DS7PR12MB5765.namprd12.prod.outlook.com
 ([fe80::2493:49ba:b06b:fa80]) by DS7PR12MB5765.namprd12.prod.outlook.com
 ([fe80::2493:49ba:b06b:fa80%6]) with mapi id 15.20.6954.021; Sun, 5 Nov 2023
 21:20:50 +0000
X-Gm-Message-State: AOJu0YznZc5GHqGJlE44UPLuTuhA0o0vMs1AqTnV6SyHJAiQSt9gWwoj
        8hUilOAZGQxN9p4K+3NwGqCtRCnmo2uGRxe2tQs=
X-Google-Smtp-Source: AGHT+IG3nECb0gKMLk6bcCTgg5JIOEKs3Po2EY/hacYzyJwwhvoK4rtrquC8P+WzETEvftr6+CYdZgiF+4eHdGDlhvQ=
X-Received: by 2002:a1f:a754:0:b0:49d:fab:fa37 with SMTP id
 q81-20020a1fa754000000b0049d0fabfa37mr22304751vke.4.1699218838480; Sun, 05
 Nov 2023 13:13:58 -0800 (PST)
References: <cover.1699025537.git.tanyuan@tinylab.org> <f0ee9abfd8d7b27489a4efe3196813225ce5680f.1699025537.git.tanyuan@tinylab.org>
In-Reply-To: <f0ee9abfd8d7b27489a4efe3196813225ce5680f.1699025537.git.tanyuan@tinylab.org>
From:   Fangrui Song <i@maskray.me>
Date:   Sun, 5 Nov 2023 13:13:47 -0800
X-Gmail-Original-Message-ID: <CAN30aBER3MnxPztEGDO2NCg3FzGwf3-2jmE51timpcxwEiOORQ@mail.gmail.com>
Message-ID: <DS7PR12MB57652C7C17103B3FF729BD79CBABA@DS7PR12MB5765.namprd12.prod.outlook.com>
Subject: Re: [PATCH v1 10/14] DCE/DSE: riscv: make every ex_table's name unique
To:     Yuan Tan <tanyuan@tinylab.org>
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org,
        linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-TMN:  [oh3WIoIarCxItbmcK8JaFJD8Lj9YuFvn]
X-ClientProxiedBy: SA1P222CA0041.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::15) To DS7PR12MB5765.namprd12.prod.outlook.com
 (2603:10b6:8:74::19)
X-Microsoft-Original-Message-ID: <CAN30aBER3MnxPztEGDO2NCg3FzGwf3-2jmE51timpcxwEiOORQ@mail.gmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5765:EE_|BN9PR12MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b975e2-e9aa-4aa0-5fd7-08dbde4515b8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khlidg3yExkjJy9j9TeHbg9Ev1xn7gNumpUS2l8shYe4HWLUCt/e5kGmMemORf+wIdcRONEk9FGYgsSyQu67LDRM6e4B7ZSowiduwOqycRn/ae/EYUUdggXpUnBz1GPYoIZRaj3ezZb42M0Jjegq8CaYnbgQVsnUMVOKxZ9WaiK8eS17FBc3Awuy27wb9AJw3N1PsVdbiHxibl23gOhDWBW0EuPlRNcX6ogzjuYMHXrhMdA3p4ww2Ft4GKL+bvXU2kKDTDj2Q36x42DPTLIHgLRnM02i9uvuJgKgYlAp0+8TKlKNzzHydC9mLVuLHcD51mm4o5k4bSr/CQ006AQuzwxAfmDIJ96rdyi4aPi+eckXncL7oSIlthdKGicU5jz9SZ+DOeWYiNXX7e/yExLfPMbR4JlC7oT3vG6iiIK2CVCjMbKtkvqEsDCpAchDxcHIAH9ClJpVxxmkJ3KkUV5rMTkh00jiF5CHFOjbXIo40Aoe2AQTnEYZF+7yRpwlP6S3NyWdo4vNC1dGwtxHLPOFDCzW9SWh6TAuKmeFurGRjGadd7zCJOJNYB32N0ukfy3iBQDaGgXbg3VC//Ul7B7z/iyM28p48UFlWbpFI7VXFgM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2ZlY1dlY1lPVTIrS0YzVmFxNXJjRWVUT21Ra3A2aWM3ZmFXdFdSaXNGcjJN?=
 =?utf-8?B?WUVUQXFyQVFIK1kyWWZaY0k5ejA4dXh6WXE5b1EwbVdiamMyZEIrZy9HaVpS?=
 =?utf-8?B?bWpBOXVDYUpieXpMbk1tbUdQUS9FaDUzOFNSVlFCK25hcGgveDRJbUhVSTc1?=
 =?utf-8?B?a1pydXc0UDF1WnNucEJ5VWU5L05hL3dEVDR2QzFsaU5VU2dCVnNMM1J6QU03?=
 =?utf-8?B?U2pmQis5RkxKbncwRmVBdjRDRXV3WGxORTJ0am1tUnk5Q1cyMktGdUJ4K1k2?=
 =?utf-8?B?ZS9oVk1hRHgvU2U0U20xbFcrc1pQN1F5U2hlUlBDY0orQjlESWlzUHBtU21N?=
 =?utf-8?B?TE5DeUN3VXhvaS94b2xJTkpHSlBGaHorbVNxL2FZY256YWxyOXEwY3dlVWFK?=
 =?utf-8?B?T1d0M3RXTnFMT0FqeWU5ZDdLQkUyVmJzQmZlL0I5MjR1SUREZVJhSXZDNEMz?=
 =?utf-8?B?ajVNVU81RlV2UVR0bzVhb1RWcmhmcitCV3NzaWlWTGs3c0RyRlZDVzR1eHcz?=
 =?utf-8?B?RFl0RXZZYmVVd0Y5RFY3U1hWZXIwdU1yQ0tYQTRLUE5BejdkTi9TdjM1K2d4?=
 =?utf-8?B?SzFKUXFESTBraVRQNHJSRkZEdGtVR0d1TTVYc2hGc0lOZER0VGdLZEg3UXZZ?=
 =?utf-8?B?ZWQwTXdwZHFBOWxFRWlxNmVRZmFMaWVpZHJ6Rlo2Z2FRN3FQZURrSlhmUEs3?=
 =?utf-8?B?d3NIYTU5N29sTlRJY0dBNlE3aHBkMmh0VE42b0s3RHdlVmNMbjd2YVBtdmpW?=
 =?utf-8?B?bzRGQVhWZklsZ0FpNWZkQ1I5R3FuajZaK2xFRFZZTEFWbzVnNFJ1UUhpTElM?=
 =?utf-8?B?N2oyYzNNZFRmZG1PL3hGcUxTY1E1WlVNaVJKOS82VHNOMUxIVzlrcVJLK2ta?=
 =?utf-8?B?YTh0N3Y5SmJFOHVGV0lFM2Rvampodjl3enhTT2VJSDJuSDVSTG4xT2F6MzFB?=
 =?utf-8?B?THJDc3FyK0JuTjdXcFJQZlc2MHRmZWZtYVIrK1psZmE0aGxhMXBBRzJFMnpo?=
 =?utf-8?B?TngrYlhEeldVYXBHM20rcW5mV3JybGF5WmlQY0dMR2kyUGlIMzRTSWwrVzJw?=
 =?utf-8?B?YldyNE8zTDhJTTVFL0RMeWJJbHUvMEQ1RVo2YmFaUjFxYUYzbytQclcwVFlv?=
 =?utf-8?B?a0IzRG4zaXZld1JpQmJEdEZVN2xwMFJITzAvNGwxWUlQTExWenBjSi9GeGRJ?=
 =?utf-8?B?ZmhuNFZsYWFvRGJkNlNaRnVUNEF3Nitwb3hFMHQ5VkdPZ08zcnRPYUk2MmFy?=
 =?utf-8?B?UTdTc21LS3h5RENaSmNrR2hrOVQ1OFloL1ZiaGo2cjhVa0JlQWFsRkZPa3Z5?=
 =?utf-8?B?ZitMOTlWRHBhWmR2UWFWUFcrd05LNzA2N1cxVUQwSUZzUHd2SmRYQTFjb2tq?=
 =?utf-8?B?cEFzbXhLQ3NGc1Y3SndsbW1FYlEyWWVGcjJmcWFtUFFlV1J6VlFoU3lqdEtz?=
 =?utf-8?B?ODdzc0ZMSGtxUGtGdjFibkxqUXFlNlpDQU4yRlQ2VW93VFMxUGdBNUZhdnky?=
 =?utf-8?B?dlBwVmZqcjNmVVJLZHFTaDlZZE5MNVJhWHQ4WUVsTmphekhhMzVRaGRUOHJx?=
 =?utf-8?Q?qDnoO2669L1uqCCjWekFgpFZAG23gl6h7cQ7PdN/2WWCFK?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-5183d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b975e2-e9aa-4aa0-5fd7-08dbde4515b8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2023 21:20:50.4264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5066
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 9:02 AM Yuan Tan <tanyuan@tinylab.org> wrote:
>
> gc-sections require section names to be unique.

This is not precise, since a monolithic section can be garbage
collected as well.

https://maskray.me/blog/2021-02-28-linker-garbage-collection

"Without the options, the compiler tends to produce monolithic text
and data sections. The large sections make the GC coarse-grained and
they will likely be retained as a whole. ld --gc-sections can still
discard some sections, but the effect is likely very poor."


> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  arch/riscv/include/asm/asm-extable.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/asm-extable.h b/arch/riscv/include/asm/asm-extable.h
> index 00a96e7a9664..d0be5a838242 100644
> --- a/arch/riscv/include/asm/asm-extable.h
> +++ b/arch/riscv/include/asm/asm-extable.h
> @@ -9,10 +9,12 @@
>
>  #ifdef CONFIG_MMU
>
> +#include <linux/compiler.h>
> +
>  #ifdef __ASSEMBLY__
>
>  #define __ASM_EXTABLE_RAW(insn, fixup, type, data)     \
> -       .pushsection    __ex_table, "a";                \
> +       .pushsection    __SECTION_NAME(__ex_table), "a";                \
>         .balign         4;                              \
>         .long           ((insn) - .);                   \
>         .long           ((fixup) - .);                  \
> @@ -31,7 +33,7 @@
>  #include <asm/gpr-num.h>

__SECTION_NAME is probably added by a previous patch.
An alternative is to use the .section directive's `unique` feature
(binutils>=2.35).

>  #define __ASM_EXTABLE_RAW(insn, fixup, type, data)     \
> -       ".pushsection   __ex_table, \"a\"\n"            \
> +       ".pushsection " __SECTION_NAME(__ex_table) ", \"a\"\n"          \
>         ".balign        4\n"                            \
>         ".long          ((" insn ") - .)\n"             \
>         ".long          ((" fixup ") - .)\n"            \
> --
> 2.34.1
>
