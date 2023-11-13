Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6507E96C4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 07:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjKMGsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 01:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKMGsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 01:48:36 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2123.outbound.protection.outlook.com [40.107.215.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB7910E0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 22:47:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLic8fKK2PWuqIVOMgG/EQkM9i2t3ao7cDtuOPsg9VRF9cplvtCA9oY4sOzt6tPOvat2IV9cPQ10HkvOYIQF64YfhWEIPePuwLxblr0F9MHlR1uv2qFg0nGq8TiIsnTJsf/zWW80bqKssplH+uarRbr4oDB5yF3vLAuKNd3pzovrRJArwXLyjhB++SF42+MJuvUvC/xp8D19sJjlS8lP4k3i6VsegY6gMDnfvt06I5HM9WBvdliyYUH/+nF221gAJj83Cyqe90uU8N79MrLJ7jcWtmc4kfhqqRqKkimfINHKliF9W37coe6dviUO/2QuRgeRxBNCzRIHXMoylH4Vng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BD+v7gQUuIgqDPAHyZY5xi4cuPxoLKwbFZbE0+BIrUM=;
 b=KuPC8USs5XF1j7wkIG+eGJw2STT+3AoNaYmPBzd9KWVKixBcY61Ll1RCNXYww7qpA7TpzXBhKnZHYwg61kQT4PrcTEq4yeF8neBBUZq8ZsVquFHhywtXyryj1C3yjrAinZMb+UpdqN/9Lsw1UfFYSIuVDxHU06DqZxWmiALqj04x2pOFP6/49slcxuZvHniq+mJ1zO/wnnQoEBYdkNNLgnb5MeUtBdJEWAD5a8csc7DGNCfpngAEIiajmbwOTy4SCsgWaWLsKJABn0OCLaEp2/i6L7RVgCqOlBKO4ptsIaHinbI6YmvLWdqjJrbX1j9eJK0/HOFnQnfh6+tEZ9aFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD+v7gQUuIgqDPAHyZY5xi4cuPxoLKwbFZbE0+BIrUM=;
 b=mTLEdp5RGwbVUOV1EZdQqY0I68RBnWe8iFlUpD+B1VMCf9O8c/aHa/V3vijXRzsOfvEueTP/cVsLvDP/5eQ6zDq2GvxywW5fZz7RcylYqBYnZCN1TMRC2/Gh7EE6/Y+eRteQc6d7hiJMcagy/q2NUvfTCcHczFq81ty1tJooMVZWErAit/VCiI24BAl60MZf4HvOD4x/KumbKVXATIHv0BSrDPy9tBMPk8xUBrjacH5M7eUk3JGFqKTgeHVaLhXjnu+hZ6epG7AtacHQBGZTn9JQZLMFcIIIWb7/e1zT8ZQeNRqi15KOLdiDQXA8MNwMRPb14nN1F2e8SlCnhgYMtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7495.apcprd03.prod.outlook.com (2603:1096:990:9::6) by
 PUZPR03MB5877.apcprd03.prod.outlook.com (2603:1096:301:a5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.29; Mon, 13 Nov 2023 06:47:37 +0000
Received: from JH0PR03MB7495.apcprd03.prod.outlook.com
 ([fe80::3947:63b3:219a:f6fd]) by JH0PR03MB7495.apcprd03.prod.outlook.com
 ([fe80::3947:63b3:219a:f6fd%3]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 06:47:36 +0000
Message-ID: <5fce2ebd-0325-4826-99c5-4289efca366f@amlogic.com>
Date:   Mon, 13 Nov 2023 14:47:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mtd: rawnand: meson: initialize clock register
Content-Language: en-US
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231109054037.3864802-1-avkrasnov@salutedevices.com>
 <2d3a1d7c-7bf2-f8af-6019-85f07fee491e@salutedevices.com>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <2d3a1d7c-7bf2-f8af-6019-85f07fee491e@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0109.jpnprd01.prod.outlook.com
 (2603:1096:405:4::25) To JH0PR03MB7495.apcprd03.prod.outlook.com
 (2603:1096:990:9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7495:EE_|PUZPR03MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e27081-18ac-453d-272f-08dbe4146b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSFQosYVgi0xMfQKPJZsADjB07BwHbuHD47BW5FmevqRok3JjItTYzwnqEDYvoDgmi3w0IO2pDcEiaW+GQvfDH081GEk5U6xmFRUzPS22wObWkjbbSZRU4vhuMo5LaQ+F4RmjZPg+B0hktoSxr5iJWRW7a3vGHxDlQiNzTTZ8k/uBvk1o4e36tBuMTcB9JW6pAbDS6bN4jHrUXRCKSrai4bmza/isge4/ZRI08PrPL4dB4DOwsMRhvyxb6pI+EIla/akn9yzSyox5orVLX/LuFtfHuvAvVwLC91hoHFxdFbdJX6EpwYP546gvbz07QoTywe2QcE3LXmWZJQHGy21dg2dXvUgY+nbtFUnynoiyVhoZHmzVTLEx8TmSPXxVHDwrT4DPY/egMMLfrGaboFgkiKKMQ3PjHnWZnSmCv5WHIVfD4LSvmb4cg5SPca9nyCZB99+uPv5JAXyD/by+VoIsCXV0ZM6w1Zj+iosw8ousLYUhrkptxQVJEpzXmONMjQgZXZr9HkgfArtQF+G1esWtfxKq0VdSoOwOOIMduDsBi2Ta05bGNSFi4gc6DQ9dH+4wOxYjqODIU6SBAG3YERW9qbwrmJJIs6woB9cg9vHqUorCzCfvVm3ed9njgeCVbbrw/yCqVwP29o6kSPsplmpWw8WdsMUFbfvWcuSlumoPHZtI0Rdvj48wGDi6fcx6Fg+yKWJ2LMjT0ZsM+M81aDtJlJjLDn44IhKHdKwkT7CebU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7495.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(346002)(366004)(396003)(376002)(230173577357003)(230922051799003)(230273577357003)(1800799009)(451199024)(186009)(64100799003)(2616005)(6512007)(26005)(6486002)(478600001)(31696002)(44832011)(36756003)(4326008)(8676002)(8936002)(86362001)(5660300002)(41300700001)(2906002)(7416002)(66476007)(66556008)(66946007)(316002)(110136005)(53546011)(6506007)(6666004)(38100700002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czQrYld4TVRSaktrQldSOVdnRnlJWlFpKzFMV1FKSC9DelE3RXJwS2JMTkZt?=
 =?utf-8?B?b1E5Q1ora082RUEwbVYvTzB0K29lQkJacDBmMWNqTGs4aGNVYm11TjNuMTFO?=
 =?utf-8?B?WXUxV280WVRYSkNPNlNBekdaWklxTWtQYWlJcCtEZVkrdWpCK25LNUpYTkNL?=
 =?utf-8?B?VFRqcFhJMDJPdUVDcEtQL291ZGd6V0VEL283REZsSW5HdEsyY2V1U2tiVXRu?=
 =?utf-8?B?ZzFJUkRQeUNzOUdJb2xQL094NXZzNHJwWXpoNHUwNkYzcHNGYXVHVjNDZDlh?=
 =?utf-8?B?dXVERjh3N3ptemk3YWFreEJVMkFGbzhiSWh4L1FONC9Gd1dVSEFDeThVVktv?=
 =?utf-8?B?R1ZWNm5ldFR5QW5VMEwvUFpBc1NtK0hjeEhCWEJ0UUZ0cVNGRElhNjdzWEFl?=
 =?utf-8?B?aWg0VEpGYXZCanQyL0FOZFZLUzNHbjVpZktnNnFWTyt2NXEwK1ZIMHBNY3B3?=
 =?utf-8?B?SCtPcGJGU2JGWUhoZW1qci8vTjg1UFp1VnFQcGpheWp3Zm13UHlIcUd2ZlQr?=
 =?utf-8?B?cUtCUGhrb0E0cG5DckRaL0EzeldWbkNINEhNTTNweU1hczFWSVc4MkhrSkps?=
 =?utf-8?B?VGFoa2p0Z3UwTUVtRGVCbWJNK1RYak5FUzRqeWlIQm5OejI5bFJabkw0Q1V6?=
 =?utf-8?B?WEJmVnJ0M2lMRzhoT0R6K3lWWGdwMDFyVG5jRUhaVFlFNDRWOGU4OVQ2bW5v?=
 =?utf-8?B?YkRXUzFLZXNoTDNHQXFmQnRpVXNCemloRFJZQmIyN2dvd1pPejlFMlh1TDVJ?=
 =?utf-8?B?cUUrcGJIWmx4ZjFUL09FVVVqeVg4eHdTdU5aY3VtaXpzYThCdHAzNHl1Y2J1?=
 =?utf-8?B?NGRPOFRmRjJYdFZ5Z2dwVlJZRkR3U01hUWovaDBuMVllQkszWWZsWXdyS3BM?=
 =?utf-8?B?L000dm03NVoxUEp4QnVzUE1FSGY2di8wdEFqc2h0dmRlQnFUUi80NnB6b2c4?=
 =?utf-8?B?Rk40bEI5SmRqYWJhamZjcXVZNXdxWjUrOE9URE5wdTlTOUpNQVp1VFU4WldO?=
 =?utf-8?B?ZWNBdExjempaUzA2V1F5VTNzUG1NTENleVBzSDFaQXg3dnlYaWdtM3grcGxC?=
 =?utf-8?B?QXZmZVdqa2tZUHQ0ckRnT1Q0QTV6Wll6aXl1Y1JCdGNKUjZDUTM1TW9SZDJG?=
 =?utf-8?B?dGhhc0NsOUYxdTN5aHhiZEJraHg4ZUpVTFBJci9JalNaN3IxUjZEeUFnUFpl?=
 =?utf-8?B?VUZ0aFlHVThHcFlFMFlqSGQyUE1uM2l6UFFldTQ2MS9DZGYxZzBHajZNS0lG?=
 =?utf-8?B?YWdDam4xZ3FSK0JINCtQbXJGek5xdCtKaW9VemdhRjgxZE9GTXAyb1FHOUVZ?=
 =?utf-8?B?QnF3Y3NLb2FBc2RjRGx6YUVKNE5KdWxLQ1ptSk1BTm50Ukg2b2twckJDVEgv?=
 =?utf-8?B?Y0RXQ3FuZ3hlNGNVN2JhS2lFNUlybG5DaVo0ZG41M3g5d09uTjJqMEJFcGNO?=
 =?utf-8?B?U21LVjRqL3ovVXV1a3oyNWFCajNGS1BvdzNvRHh0SEJ1Nm1VT3BmZW8vWnpF?=
 =?utf-8?B?SitrWHNaQU1nYy95U1MvQ2hua2FyTUsrNzR3ajVBbllnRDdyRGdzcVpzbGJX?=
 =?utf-8?B?cVdtaERXTnEwdStWcTg0NzRSSnF2L1FmeU54cTEwOGNuQTk4QjgxOWw1WDVE?=
 =?utf-8?B?REh0WXlmTVhqNGFzUVhHUTEvdXJ3ejNJKzh1SUlXQVBXVXUzRURQaXhOaDdG?=
 =?utf-8?B?T0hRb3piaWZUVm5HYTJwZGhSVjlaQkhIYWpTc1l4WURNSHAyNGRwc1lKQm4r?=
 =?utf-8?B?MlVOK1Y3MG00QkgyQytobERRajRDR0sxelJiWk5zMkJ2bGFVbFhlZGZUQmEy?=
 =?utf-8?B?cHFwMlo0S2RqNUl6QkJxRVVtQmVwNkJJMy9WSGZ1Vy9CbDZYNDBlbmNDRllD?=
 =?utf-8?B?dy9xcXJTZGQ2VzBoQ1M1aUJJMldzMm8zTWZRbEZkSEVMTVJkWHlaS0t1NDh3?=
 =?utf-8?B?MVZRdG5pOEZnOUoybEtuMlRsbU5HMWNkQjlSaVprc3dtK2NVTHRnUDB3SnhL?=
 =?utf-8?B?ZW5mZkRqak1pZElHeUhmTUp3a0hmUGxCY0RUNlpsa0hxQUJEM2hGMjlQc2cy?=
 =?utf-8?B?QTZTUVNmaS85NnVKNlhhRkl1N1J1SC8ycFpoRm1QOUxQVkxLazhiOFY1b056?=
 =?utf-8?B?MTZLcnBHMVlPNjNFaitoSDdHWWVKbzhSRGdEaC9Vb2t1U2IydnZJaUtXOE4r?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e27081-18ac-453d-272f-08dbe4146b52
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7495.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 06:47:35.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SO7Dt+CATlTYgPWba0vVfs6zk8a6KrcwFug4eSkGwLFt07jeYUF4K+ai21hzn7D2o3a50/XcGTcQip7aEnzk+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB5877
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

I remember that you asked it in another email, but i forgot to reply. Sorry

On 2023/11/12 18:08, Arseniy Krasnov wrote:
> [ EXTERNAL EMAIL ]
> 
> On 09.11.2023 08:40, Arseniy Krasnov wrote:
>> Clock register must be also initialized during controller probing. If
>> this is not performed (for example by bootloader before) - controller
>> will not work.
>>
>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> ---
>>   drivers/mtd/nand/raw/meson_nand.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>> index 0d4d358152d7..4e7fa943928c 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -91,6 +91,8 @@
>>
>>   /* eMMC clock register, misc control */
>>   #define CLK_SELECT_NAND              BIT(31)
>> +#define CLK_ALWAYS_ON_NAND      BIT(24)
>> +#define CLK_ENABLE_VALUE        0x245
>                                     ^^^^^^
> 
> Hi,
> 
> @Liang, it will be great, if You'll give some details about this magic value. I get it
> from vendor's driver and it makes NAND controller alive, but I don't have any docs.


Bit 7:6 is used to select the clock source for NAND controller.
	00 : more clock source
	01 : fix pll is select, commonly 1GHZ in Amlogic soc chips.

The implementation in meson nfc driver should select '01', so you could 
do like this :
#define CLK_SELECT_FIX_PLL2		BIT(6)
writel(CLK_ALWAYS_ON_NAND | CLK_SELECT_NAND | CLK_SELECT_FIX_PLL2,
	 nfc->reg_clk);

Bit 5:0 is the clock divider.

> 
> Thanks, Arseniy
> 
>>
>>   #define NFC_CLK_CYCLE                6
>>
>> @@ -1152,7 +1154,7 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
>>                return PTR_ERR(nfc->nand_clk);
>>
>>        /* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
>> -     writel(CLK_SELECT_NAND | readl(nfc->reg_clk),
>> +     writel(CLK_ALWAYS_ON_NAND | CLK_SELECT_NAND | CLK_ENABLE_VALUE,
>>               nfc->reg_clk);
>>
>>        ret = clk_prepare_enable(nfc->core_clk);

-- 
Thanks,
Liang
