Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BC37E16D9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 22:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjKEVf3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 5 Nov 2023 16:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKEVf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 16:35:28 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2083.outbound.protection.outlook.com [40.92.19.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E384CC;
        Sun,  5 Nov 2023 13:35:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXBvO8LphVKxg08UhPpXrAtlbtDwND8MPBcj32R/yL7vdHrzuC0lb6v6TKcRO1DLsfVHbY+47BfspTv39OiskgIdi26xCo8xHWU3mCft8VeyjZSyEUNh6i8qY/mn4X/02yav8m2HCE6u4pJmX9B63pgXXYwAPfkhBBMmUQ0xSM0jFP38Q+TyfiA+3NIZ2mPDYqy6+bX8XwZTtnvToNG+nheIqQ+ERfhXmr9HcW5oz2nuXGA2wGRBNzivnxxXqdjagi7HTJnou07Qv+ft3Zc9EMf8zjN3638FYnVtKl2xO4PwWH81tUiT9L0pEx7bCc1Wa9g2i7CsduJk7AGO/rO9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fee2/nkaXARA2Lmk9RPO8HmODWLL6RsgiqxXirb3E0=;
 b=kknJvgiqTkStVN5uBKVIw5wA5C3sFj7s9IjobdG2PO+ALM/AwJ3fk5UCaf4LhxVS1F0Dpq01+8aUFuNKQWSynocVpYnvIHF5AfTYKxNSC9esp1mslg36fjTyVmh1MrN1dWS5X00A67Gvz+rVcMJhAUYiFBGulyiwp7zGmYgzzVTIIFuQRwIFFJ43wFqnY+DOmTAEnK8Pw+JW/pGDg75F17rge5rzfgqZ2jxXNaXSWIAipdz1JAaDtYqAgsCUWanaHLdXDnk/M/vlEIT925ewNdyXSDIREzEjsnAKJn+tGbYa7xOfDTo7LnsCKkXF+BQbTyBWyJHNdMwtQ0Ws/NhdFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) by
 BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Sun, 5 Nov
 2023 21:35:24 +0000
Received: from DS7PR12MB5765.namprd12.prod.outlook.com
 ([fe80::2493:49ba:b06b:fa80]) by DS7PR12MB5765.namprd12.prod.outlook.com
 ([fe80::2493:49ba:b06b:fa80%6]) with mapi id 15.20.6954.021; Sun, 5 Nov 2023
 21:35:24 +0000
X-Gm-Message-State: AOJu0YwnCG6sXnwtdB+/qSv9qTbe2c+AotQEB0DFzhb9ExAYkCSD7y66
        hV/8PBtj7qoj8qvti7sUYa8TRn+Qn6OPv4DnCaY=
X-Google-Smtp-Source: AGHT+IH3aZvI1eMGpsPB0I0COnDVTcvduEhLb1O+mnH4PM006GzrEh2MBuKBL8Iojm22/7/4gs0xvlBWSf/uTbMQS/c=
X-Received: by 2002:a05:6808:655:b0:3b2:db86:209 with SMTP id
 z21-20020a056808065500b003b2db860209mr24066073oih.38.1699220122158; Sun, 05
 Nov 2023 13:35:22 -0800 (PST)
References: <cover.1699025537.git.tanyuan@tinylab.org> <c1c9913c0974b96faaab664ef354cf8775cd7554.1699025537.git.tanyuan@tinylab.org>
In-Reply-To: <c1c9913c0974b96faaab664ef354cf8775cd7554.1699025537.git.tanyuan@tinylab.org>
From:   Fangrui Song <i@maskray.me>
Date:   Sun, 5 Nov 2023 13:35:11 -0800
X-Gmail-Original-Message-ID: <CAN30aBF68V5OLa1DkpFgEjt2Pc3n3J=bKLvtZCXCD12JHtUB5A@mail.gmail.com>
Message-ID: <DS7PR12MB576555798778F91D449FD5C9CBABA@DS7PR12MB5765.namprd12.prod.outlook.com>
Subject: Re: [PATCH v1 08/14] DCE/DSE: add choice of methods to build
 reference for orphan sections
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
X-TMN:  [ct2+A/8QVOjgmSquHoUdCc/EAIt5Iv/1]
X-ClientProxiedBy: SN7PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:806:125::21) To DS7PR12MB5765.namprd12.prod.outlook.com
 (2603:10b6:8:74::19)
X-Microsoft-Original-Message-ID: <CAN30aBF68V5OLa1DkpFgEjt2Pc3n3J=bKLvtZCXCD12JHtUB5A@mail.gmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5765:EE_|BL1PR12MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: bb571626-f9eb-4feb-962e-08dbde471e2a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tN6w1tOmr7JOqiEWEv9YH+rsPevOWTi1/7vB0/LOu4cYXTH0jjeaoXuuqryuz7MylJcGSnItjCP2ZyHUHcp8BJ+BjL6NSeGTRWuiRHOO2tpVvy4D7xoJ3MOW3wY9h6B07kcMuHyEOhWEXfirMetUu0JWN7F+hDsyknlZc46LhD+fL/4OTkMrlCZmVbtgtPkyiGl/cQadF4Cr6G+AHWKPTYpZAWR0joQu1PVKf2POsyIeO7ANosUUY/nNN7aCliqjF5xnyUMUgw2v20yinG5dkeOk7MTk61pXL6riNswli9peB1cloU+iaxuUaJ6S6DfK0425RYwJTvVDmJOVybQn6SQmDsicdX4/u3eqEhXuOd2MMjYokzQ17KiOZ/uMKNBIUoqESyqcTInFICCq3A+3O8eDBlj7xg+iMbXAvMLUu6WRgEPVPRBsrS+uGp92ZI1uwub7lrCMxZA5ShhQX0Wl5c2T1ObmkdH54smAboRP8zHKgks7wocTuz129EzOKMTPCY6JMnxVt9T+D2klHvgU39MqgdrY4aFCJujUzb3T6LexOn3Nd8okxzKNb8kv/iExScwicl3KkwIS48r6mI5V4k2oZY9WeM9M7GpiUU4ntJ4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnF6T1NoTWEzR1B0dTdoZjFhZ0ZtR0lpZ0NPOWR0a1IxM1lYMlFzckg1Q2Mw?=
 =?utf-8?B?TU0wWTVBempBK2VJOFBqL05yZmUwNGdvMGdXUmZXZXh4NC9ZamdlMnZkQ3Fw?=
 =?utf-8?B?ZlJzbFpPMUkvQVB5L1NTQTdYQmk3Z05yM0FXK2QwWWh4SmdncHNINFkwbXdV?=
 =?utf-8?B?cnpLQjFLS3NYYVZGbmJKYm43WGM3aWhjbFhzRnJodnhaeWxEeGZpdjVvbVRm?=
 =?utf-8?B?ZHAvZ1kzTUNaL0psT2Zkd2p6QU56SHpESi9UUmNENkJPRHVmZ2d1RWFnT2lq?=
 =?utf-8?B?NlY3ZXh4MlRGTDloK2FkOW14eU80ZW12OFhwOElhRmovVlltMkUrWWpOZzF5?=
 =?utf-8?B?endSaW8xTkVwWmljb3Npb3JPOTVBcm1iekFlc0cxTFg4cW1GbTRiSWsrUEMv?=
 =?utf-8?B?aXMzaWdONTFyWnJzcVZ4Q3AvN0IyV0RvdTRLSHNvQUF5YjRVV2w5cUR2VkVB?=
 =?utf-8?B?OGtFengvRWgxc0lMZG1VYXBaN1kvSEFCVzMxMGFFRFMrSjZCckNNckJ6YUNy?=
 =?utf-8?B?VFdKaWdXSUZEK1hjc09kaHJISjk2VTg3WVFXYzROajZ6eHFWSHJNZU91bC9X?=
 =?utf-8?B?S04ra1VBTXRQTWJNcmVoTjA3NENPTWJXTktncE1hTi9XeXNkNkx4OHZTNlkr?=
 =?utf-8?B?cmM4YzdvSmhSRUc3NGFHdGQ3L1UvU1VyWjFVZXFtbGJ1QWwwTUtvN2pWMVB1?=
 =?utf-8?B?WjZUREJCeVQ3MlZ4K3J1L01xbWlBdU5IaEx5T0FENzVPYXJ5MWJqU1V1Z1J4?=
 =?utf-8?B?aFM0ODNYRkx1NmNLcGttYVRxWW1SWmZzUTZPR3BPc2x3NXBRa294dUZTTkFX?=
 =?utf-8?B?VFJoR05aNlBFMWlWRENibHEvbGZ0Vm4wYVlrd0orNnFXWWZjUVpUcWozTEtW?=
 =?utf-8?B?dkdXMDJTcEpUMURLSHpOWFB1M0prb1FvRW9hY24rVElSMGgvMG9iWXJjZ1N3?=
 =?utf-8?B?Q0FoWWRicGhvVkFXZzdGV0VDWVd6UzREQ0RaSkhOMStKQTdKQTV4YWFTOVJM?=
 =?utf-8?B?dFdCYlhFaHlWZ2tZNStiS2hOTmF0aWNYUEFwODJlN3VPS0ZtL2pLVjhiQnh4?=
 =?utf-8?B?MFhGeFdTUHJTaFMwbHhlUDQrWVpzQnVrV3BZM0VUcGVBZ3U5bW9ZNzJlY2Yr?=
 =?utf-8?B?MGdteGwwY0lZRmF4V3gwUmo2UUk2aDlTTW03bXVTQmNydVNUM0Y5ZFc3MWlR?=
 =?utf-8?B?emN3VzRBTkhxc2F5L3hydTRzMjAxcGc0NWp3d2N5eUFzN1BWaFpuL2g1KzRE?=
 =?utf-8?B?cjgzN3Q5a0hJTmNQR2ErU08waUJEb3BJM3dYanNCU2U3MzI4T0dMU3ZzTVB1?=
 =?utf-8?B?SVNDeW9DUW9UZ0VWRXpIRzRHU3FTWlk1ZStsVmFFL1U5NG8vZ002dnI2UVJP?=
 =?utf-8?B?VGdJb1pyNmdSTjYzSWhQWWNEUGowSDNKUG5iOGhSbVY1RkRTMjFwNDhKdkti?=
 =?utf-8?B?WjAyM3RDQUxEUzYrVWhLc01BNGtFS3NSdnB2eWMvQzA3N3pCMUJkTGcyWXQy?=
 =?utf-8?B?VjVtejlxcTJlQlJNYTRYWjBOemVlcXhCZU9IU3ROdzFnQTZaWHRoQm10djFC?=
 =?utf-8?Q?No598uQWaJmb2p1mJVM7YSDIQSydTSPLDclgTuIn0BvHev?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-5183d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bb571626-f9eb-4feb-962e-08dbde471e2a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2023 21:35:23.6173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 9:01 AM Yuan Tan <tanyuan@tinylab.org> wrote:
>
> Due to .pushsection producing orphan sections, the kernel currently uses
> `KEEP()` in the linker script to address this issue.
>
> Here we purpose two methods to build reference for pushed section,
> SHF_LINK_ORDER method and SECTION_SHF_GROUP method.
>
> The binary files compiled using both methods turn out to be identical,
> and it doesn't produce any side effects.
>
> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  init/Kconfig | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 9834dbb0ddae..9599d2de44e8 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1740,6 +1740,56 @@ config USED_SYSCALLS
>
>           If unsure, please disable TRIM_UNUSED_SYSCALLS.
>
> +choice
> +       prompt "Trim methods" if EXPERT
> +       default RESTRICTED_TRIM_UNUSED_SYSCALLS
> +       depends on TRIM_UNUSED_SYSCALLS
> +       help
> +         This option selects the method to trim unused syscall wrongly kept.
> +
> +         The binary files compiled using both methods are identical.
> +
> +         If the trim methods is not specified, some syscalls are kept by
> +         linker script and can not be trimmed.
> +
> +config RESTRICTED_TRIM_UNUSED_SYSCALLS
> +       bool "Leave some kept syscalls (EXPERIMENTAL)" if EXPERT
> +       help
> +         Say Y here to trim 'unused' syscalls wrongly kept by __ex_table
> +         like sections in kernel space.
> +
> +         Some syscalls are kept by linker script and can not be trimmed.
> +
> +         If unsure, choose this.
> +
> +config SECTION_SHF_LINK_ORDER_SUPPORT
> +       bool "Using SHF_LINK_ORDER attribute (EXPERIMENTAL)" if EXPERT
> +       depends on HAVE_SECTION_SHF_LINK_ORDER_SUPPORT
> +       help
> +         Say Y here to trim more 'unused' syscalls wrongly kept by __ex_table
> +         like sections in kernel space.

SHF_LINK_ORDER can be used for other metadata sections. The help
message reads as that __ex_table is the only use case.
It can be rephrased to us __ex_table as an example.

> +         This option uses the SHF_LINK_ORDER attribute to build references for
> +         orphan sections. Therefore, these sections are no longer kept in the
> +         linker script.

https://sourceware.org/binutils/docs/ld/Orphan-Sections.html
"Orphan sections are sections present in the input files which are not
explicitly placed into the output file by the linker script."

If the linker script still references the relevant sections, they are
not orphan.
I think it's best to focus on the semantics (metadata sections),
rather than the linker input property (orphan).

Suggest:

This option allows the use of SHF_LINK_ORDER to mark a metadata
section as discardable when the linker discards its referenced
section.
The linker semantics require that the metadata section is not
referenced by any other section.

> +         If unsure, not choose this.
> +


> +config SECTION_SHF_GROUP_SUPPORT
> +       bool "Using SHF_GROUP attribute (EXPERIMENTAL)" if EXPERT
> +       depends on HAVE_SECTION_SHF_GROUP_SUPPORT
> +       help
> +         Say Y here to trim more 'unused' syscalls wrongly kept by __ex_table
> +         like sections in kernel space.
> +
> +         This option uses the SHF_GROUP attribute to build references for
> +         orphan sections. Therefore, these sections are no longer kept in the
> +         linker script.
> +
> +         If unsure, not choose this.
> +
> +endchoice
> +

SHF_GROUP has size overhead in relocatable object files. If
SHF_LINK_ORDER works for __extable, I suggest that we postpone
SECTION_SHF_GROUP_SUPPORT until it is absolutely needed.

As I mentioned in a binutils thread, .attach_to_group is not supported
by LLVM integrated assembler and it could be tricky to implement.
The toolchain requirement (2020) is no better than SHF_LINK_ORDER.

>  config KALLSYMS
>         bool "Load all symbols for debugging/ksymoops" if EXPERT
>         default y
> --
> 2.34.1
>
