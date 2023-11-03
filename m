Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD18C7E0575
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjKCPVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKCPVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:21:37 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2046.outbound.protection.outlook.com [40.92.52.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CCD123;
        Fri,  3 Nov 2023 08:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cr+mIUI2RukHUBpaHr+99g4ZiyLVHm8+Rr7XVXpymE15EV9RhNra6i+3ODiKmVf6YLLPhC11Iri+BHY6q2gwec6CWU1j1PE8nTY6o3bCV3bWCMQyEjhGlFYLD3lm5giqUt3vfp7rPz3NMOkgHKv1jqWsTJHL7jyX57UYpha1ukpXSrQ9jE5Dmzh8rGd7AifTiKioR5wPfvuYOGq3aQM/Fp2B6mTs1qZpmYYt9P/hSl3HchQRSb+cqkQldPdKSCvB45apYIkhT2HC0MjRVOGXYxM5gWvI/rnmtxbanY9YPbfDRM7v1kxksKIsfB7faTFguZJA6ADv0MgEQArpDAiufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiRjf11LJKtz3ILd9vZodELe2ftB285NF66nUKCmyMI=;
 b=D1nFsM1FfNRGBjcCNGQ70bTQJzZBndP67XKxxuqYmibm9QRoDzvAu+YrqeOoLkOG86/torA/Cy+WkYnH60wKnT+IMaIqWwi6NF06DOK+O0hBtUdmk/kfbN3iCs07UT//P3OVmBJ8BbH8qdXFlb86tGmx4/PEwonMOgZLtNnODObFbCT2svC3Lka/EQMgguoFBjofJ+rDyWfFj5IrqIoD3Ch1Hrd3mo9+taoJ1/xK9l5m6voDU31uj2luzk4flbuR3OyL6EFCmHf1kt0M/OsNVBFCZbY1C8T8mG3Bmwblwl9LjfxedSaE7M5r74F/U5+ZIykep+AS0weTK8wgQxLPmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiRjf11LJKtz3ILd9vZodELe2ftB285NF66nUKCmyMI=;
 b=EMwvMUpNRgoowX4Y3qKVjToIp7LTXkDVvsiWV7mBbFxtd9SkQ04KGT+rUzHQB+t/CSRG/p0VxCfAs6N3mOL6zJ+mt/yiQ48yt9bs/jyKdUW/RXh+qMzb6gOSA/fkfH49oezGhdxrK6JqlF+SGwrRMv3rmtXMlTWHMd9ztUYPfUU+pm4QbgsrzQyjvF14bLjgDRBR31WxtTspTkZLwoDeaOIgoohDcW4m/OC0SKRbSzt7RP3ViTSF3pholPeAAoVs4GctZEuW2EMLY3ZqC45MjQ1ZNlsV6IFP+6F/iZfXwVGcf5O2z7TPHKCymKw3cNNQ6J1akyr9FkcMfKuf9T8CbA==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by SI2PR01MB4300.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1af::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 15:21:28 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::d870:7910:448d:fb6d]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::d870:7910:448d:fb6d%6]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 15:21:28 +0000
Message-ID: <TYZPR01MB555696309FE797E0F0C39D43C9A5A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date:   Fri, 3 Nov 2023 23:21:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] mmc: meson-mx-sdhc: Fix initialization frozen issue
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     ulf.hansson@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, yinxin_1989@aliyun.com,
        regressions@leemhuis.info, briannorris@chromium.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <TYZPR01MB5556B56D834E02F41C44D81DC95FA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556A3E71554A2EC08597EA4C9CDA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <CANAwSgTqm2-NsMjZWQwfc77CQhL_kCLnbQpm-ithOBS84UV=4w@mail.gmail.com>
From:   Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <CANAwSgTqm2-NsMjZWQwfc77CQhL_kCLnbQpm-ithOBS84UV=4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [R2jALOy0GfheUgjSJoqoh2FRTbcgE6yZ]
X-ClientProxiedBy: TYCP286CA0064.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::11) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <bf40dbb9-5b7d-1ee1-f654-2a674dca87fe@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|SI2PR01MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 04df2f89-6ea7-4516-556d-08dbdc808cc1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpKp6IDSszHDC6nU3M8UU9X7ic24beuuIOZRy3+K0zfd7PLjKtlM+zw+H38c3a33VjpBGi/f1EgCKrP45ViLeU6ClXDYpXoLbckAF98Vtx29gs8607MhHD78oW4iuRNET0vCfYQgFDx0VWftuU6JYUajHfO4hwr2USHKG4eiy9hdZIYYp6kJHqL3gFQqzE7XbUSMyzxKxsBluICi/xMmypRp1hI5R//MGOTekv9/XWXx9/1kGZW2zKxDwgkFR11rMk67PbxK/Y++GCvbIyVQETYQJE58bWOvCpiibl+DAyPw6+h3uvemlKIHWgEExFiXCiuc93/gahd9iBNPGnbenNqz3R+CqmXWvYAyvdukzvWEmHMXmx2VPjtmt9+t/eEJfkW3n8vZBvx+K8+77OD7p2rS4GHnq4y5l8+5/pupcjwxnNGtBoTNpkFVTvJb3XlVolkfvuC73UTfC34oXDzFfs9dkbwCCyuSIjUbo74xdvhqYiYk+KxtKn0gHQCxTApSAshNRAkJq2zzDa/iNJ3B8GQ4PyziMhegNU292aN1h17yCqmpJZZwSG95giX1qbGK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjNZYWkzNlR2blo5NWJMdHlEU05HUHEyaHMzYjE5Z2ZKbGJSdUVrRHBINVJC?=
 =?utf-8?B?SWxadlNqNnVXUWQ1WVl1Mnk5R21JL2RZTTFBci8vQW1SQ2NoK1g3TllhTHNn?=
 =?utf-8?B?MzFTRVhJVkIzaEttREVPMXdUL1k4SExEMS9RMVB4VHdIUjIzOXdpNzNyTjhB?=
 =?utf-8?B?ZVhEWnFqT1k2TE9Ia1ZKK0l0d1JQQ0I3TjNvdFRKYkRjM25VMU1rZ1l1OHVY?=
 =?utf-8?B?M3AwbDdrd3MrUWZOUFRqdEFwNDRaYmJhYkR0Zmd5NWFsSlNWTGZCSnNIV1RL?=
 =?utf-8?B?OWRwY3JzV3lOaHVEcnJTMmNqUG91NmxxN3VubE03WUVhdjJqSzk0Z0lxZ092?=
 =?utf-8?B?Zlo3ZGxEeGdLTk8zV0g1NC9GbGhETFRqQmR3Q3RDYTNzYmNEWFBKbm84U2sv?=
 =?utf-8?B?QUZkUkNSK0ZlUklnZlE3QzUxRVM0eUVTNlZMWWxFdk0vNG9mMnZpRCtkSjk0?=
 =?utf-8?B?SWtVUUttMEg1S0k1V3ZSYXcweVVxSjY4RTRFOGdJVGlIZVpBR3gvUnFJV1Bu?=
 =?utf-8?B?YnAvc0l1WE55ZnMwMlVDMDhhZlRsNmQwTy9vVmRTZUpObDRLYnd5eG5pd3FG?=
 =?utf-8?B?cFhmNmgwekVVNnF3QVZwenhoTjZ1Ly8wQkl0bFJLcUs5OXdKNXhIVGtDVnVU?=
 =?utf-8?B?R3JDbDRuSS9rZDlJbXREMGhQUzBabkoyMGcxUm4xM28rSEtLVXp0LzhoZTF3?=
 =?utf-8?B?aVNkaklsek9HV29sclNXV3lCaDAyaXhiNWpvT1JHT2ZRR3V1azVpU0NOWFYz?=
 =?utf-8?B?eW03dVZ6bVVCTVdFb0ZUbk9zcXJQaHRnazEzbHpwVjRKSFNodXdJbGpzakNz?=
 =?utf-8?B?bU5Ka0w5cjExMXRBNHBMYVI5TEp4a2hMUTlYMlhteUJQa2Q4VFpyNG10dlFT?=
 =?utf-8?B?WUxBSGVXQm1acCtKWHFRZzJUU2RWeUZDdnZ4Rzd6ZWlrcm1KRzE3Wi9oRTdR?=
 =?utf-8?B?Q0VPa2JXekxCSzJCcmNhUDBBUm9Najlxczh2V1pQS2g4SnYwZlNZVm5jdXkw?=
 =?utf-8?B?NnZ4Qmp4KzZxY0J6aVVweDRvZWtaYWVpN29JcURmMXlpcitkejU3S2NpWVVi?=
 =?utf-8?B?TkIzbDJaUUoxdzVOU2M2YmtTWnoxZ3FFd0YrS2l4Q1poKzVTYTAwUm1rb2h0?=
 =?utf-8?B?M201U1VwWnk0d1g2ZGk5a3RtRTlzQmZCY08vcGcxb0F2S1VLRjBLTTlPTnhE?=
 =?utf-8?B?clV4cUhDeWlVRVRJZzR3RVAyTDI5N2UvL2Z4ZjI3d3A4ZG9XeGhtQ01HSTJr?=
 =?utf-8?B?N3dTT1kvUDdDSHhyRFZZQVIvWk9KVGRTY3M5aEtMV3UzT2x5Yk5nTlJTRU1O?=
 =?utf-8?B?d3NXNWNkN1Q0QjQxb3ViSm9HNkRaVFkrS25qWjZ1dk42QnU1QnQ3Z0ljZ24r?=
 =?utf-8?B?S0RpaktDSWcxQjE5NFgrVFhCa3JZM1hIQ0RvR1JSVGdudkJlV0prbWlmMU9B?=
 =?utf-8?B?aUJxU3VMdWMyczFMYUJLbEV3QlcvczV6NlJkUjFmRStKcTJ1Z0lnVm0wZVFz?=
 =?utf-8?B?Q1ZhNkZTck1Ga1Q4OGZhOVpxUjZCYlBzK2gzb1lwaVAraW5memMrQkpPZDBy?=
 =?utf-8?B?b1hteFZwYm9pWTFpUWZVYm5aK3lBYy9PQm5XejNSNmtNc2RPRlpVbGFKKzFh?=
 =?utf-8?B?cmJXSklxanNxQjFnMjkvYVY0Y1hWZnc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04df2f89-6ea7-4516-556d-08dbdc808cc1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 15:21:28.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4300
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/10/29 21:08, Anand Moon 写道:
> Hi Ziyang,
> 
> On Tue, 10 Oct 2023 at 22:15, Ziyang Huang <hzyitc@outlook.com> wrote:
>>
>> Commit 4bc31edebde5 ("mmc: core: Set HS clock speed before sending
>> HS CMD13") set HS clock (52MHz) before switching to HS mode. For this
>> freq, FCLK_DIV5 will be selected and div value is 10 (reg value is 9).
>> Then we set rx_clk_phase to 11 or 15 which is out of range and make
>> hardware frozen. After we send command request, no irq will be
>> interrupted and the mmc driver will keep to wait for request finished,
>> even durning rebooting.
>>
>> So let's set it to Phase 90 which should work in most cases. Then let
>> meson_mx_sdhc_execute_tuning() to find the accurate value for data
>> transfer.
>>
>> If this doesn't work, maybe need to define a factor in dts.
>>
>> Fixes: e4bf1b0970ef ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
>> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
>> ---
>> Changes since v1:
>>    Use Phase 90 instand of value 1
>>
> 
> I have tested this patch on my Odroid C1+ board.
> Please add my
> 
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> 
> [alarm@alarm ~]$ sudo cat /sys/kernel/debug/mmc1/ios
> clock:          100000000 Hz
> actual clock:   94444445 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    9 (mmc HS200)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> [alarm@alarm ~]$ sync && dd if=/dev/zero of=~/testfile bs=100M count=1
> oflag=dsync && sync
> 1+0 records in
> 1+0 records out
> 104857600 bytes (105 MB, 100 MiB) copied, 5.70235 s, 18.4 MB/s
> [alarm@alarm ~]$ sync && dd if=~/testfile of=/dev/null bs=100M count=1
> iflag=dsync && sync
> 1+0 records in
> 1+0 records out
> 104857600 bytes (105 MB, 100 MiB) copied, 0.20267 s, 517 MB/s
> 
> Thanks
> -Anand
> 

Oh, thank you.


