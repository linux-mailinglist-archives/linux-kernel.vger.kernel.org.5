Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2157A7548
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjITIGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjITIGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:06:23 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2081.outbound.protection.outlook.com [40.92.103.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012E097;
        Wed, 20 Sep 2023 01:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIp4hNFVs6wev7tHOHDskj0fySsxhslq8dHpEOuTysfL7DXpfTflDJLxYQBc8uth47Vjzh4FEKD0Tv3nMbsJcKrtgD3HDSLYmJwxkwCvPdBYPefIzEnmSjecqPkwd/niePe5NUpCFiEoAvMEuSLMgP3HhXtfSbyrSAsXgaxeUzcm2mTRCphP+D93BVMD9+bIYfUFWcjRRreqFXb669R8DT+YSBIxc2hT7rN+CPZwJidXRUoS5Nt2/tx5RYMLr29+f7SiHtJQQm9Lx64St+c3sRgwUXAjAvvaL+taoPtdl++7NrSTxgdS9rQQ1VfKvfCd2NJQTD3rTV8+ixOFx73Z2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uwh6beZ0vfKKt1GDsnkJxAdAyCZe50c8EWO/0QUE6yE=;
 b=AIToCDbi7yUUWWqAczOE97MghwG6zp9yfYx7SXv88Y8BTfiRQgxCwuFDGc5kyIIunfaik1Kaio2JyauXIQONGryrr4QYWSf3bnTB/DHfwQscrz2g1Sa4eQW5638IL4KV9BsxAV14+pJZqUNFuQKCdsUrf52NlgN57THcEOgEVTMZk77ym8gjSWdH9lXtIEBDTX9Wp3u6+Se3svCyLZRPnsI+OrGumKLzJaP5UTFQAEYgsqlN6tLz4DapQyH4A1AH1Bg0Ugg6rbeQ79xF67CIDl/O5PnoYhuKp3KSFU0FZoYAaY6Q/Jgv6Mhq5Ah9vybWJlN5eSk1Nfr0XHu+VsDdkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uwh6beZ0vfKKt1GDsnkJxAdAyCZe50c8EWO/0QUE6yE=;
 b=dXoaqiJZAvMm/iryx1a2gmHx6i84/jbQZa9gzQu5dT/BYiDPlkqLP1/cgvIitXF7aCqIKKZ4QtYoILrwTqWW7nImZtg8taKvFYOvWr08F0oQj/rgaYJtBHDvMF/OfaohR8ubXnZQNl0eQdYa5WitGkP9qnMwPhOXgSQeRl5aP//eLj+ctgO+LlNbgmD5eZnIK2VwuIZ84GNtKqRoU0otwMXbY0U1R3hSPIi7D9mSz5v4WWn/RSJ/SLjO4eyOIes5g2gqbAWi17Yhq3K+stZMczbKf9f3MSQRlSe6tdJGeeeC5n1+eNjkgPizFTD2Xdr5fv8Ndk/TdFNHonj8gkk9lQ==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN0P287MB1762.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:188::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.26; Wed, 20 Sep 2023 08:06:09 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::efe9:8d54:281b:23f7%3]) with mapi id 15.20.6813.018; Wed, 20 Sep 2023
 08:06:09 +0000
Message-ID: <MA0P287MB03320173BB92D2C54FD659A7FEF9A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Wed, 20 Sep 2023 16:05:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] serial: 8250_dw: Add Sophgo SG2042 support
To:     Guo Ren <guoren@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <888d57a2d5e62affb8e29e0098402e428facd969.1695189879.git.wangchen20@iscas.ac.cn>
 <CAJF2gTR7xzGvQeewuhRLHE2yjH8zeDMj4qfE4_W-yb71-Zx6Zg@mail.gmail.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <CAJF2gTR7xzGvQeewuhRLHE2yjH8zeDMj4qfE4_W-yb71-Zx6Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [VS56gddIBcbXUl6rq7ErTcSoMp+Tzily]
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <725586a0-cf65-4fd3-ae15-0d25f096ae1b@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN0P287MB1762:EE_
X-MS-Office365-Filtering-Correlation-Id: 4986e25d-2017-43a3-076a-08dbb9b07286
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Eg3YBkEkzogZggDEbFtiQC+vxk7kKT7DnJZzPgBQmunY43VUbVkAr9nxc9sE7NhK6J01LEFy/OSps9swy77Ereya5sQQ9DesR9cEGGZkubp1HFtfNnP2VEoDLgRmHs6zCU1RMDdOVA1H9SxTKuhsOR4S1KgVRAsjBalo/nGtHP+KY7ooLncy30X2S2U4ddH+zIHtSKJilZjLyo43mKW94WRqhNVF2WMaMGxHHoTanJG8NMnl8fJ04+2MJNqY6c30lQn8vu32nTeCVPnS7nN552+o8yiAHkY+TUumjmoFJacXTL3ByjIYAWeEFz9b+Ug6AKnfN/zr8bT6tO+8sc73VkjM47PzNh2XcrWq8yxQJ05tAmcOP6RUGs82L2rkfHtNLiKFr7b3CL9dpfIUn54Io0KAcTW60Z/BIBlZJL2ZWoLHY7koTJF1h0Js4g07yAJtI+0P8NEx9wt2c0n7UBfhiZzeHMwSRsdeJI5EUg3uJLaLtm3evmuzg4X6W5QXKJ3EIaElZyZFNttyz0/78pE/3FIPFvc5z/PDzDOTQJThOEhp6n9E5mbgELl5r35MiE+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1JTNUlwcVhKNlpxejNNU1hZb0ZMMXhKaHNVbDFCa1M1YTNmc2VXMGluVVpj?=
 =?utf-8?B?a1VPTk9tS2NraXZoRGdYNVRSQ0JGV0sxblJMRTI3dXFZTHlhMjdQa0E3Slhq?=
 =?utf-8?B?RFgxS2ZmVG9uOXhaeXBTL29UMjdmNURVTzVhdW53cW9xemdrYzYrY1UvTS9Y?=
 =?utf-8?B?WmVOSElqM1M0Tlg5RFFxSVRXcENyVzluUzNaekhYbUJxSnNmU25qWDl2N21B?=
 =?utf-8?B?RG5waGxKekFVUGUzcmw0bThvcVNVL0RiVkI1N3J2eTUxbjBXOWVKbktTTGl3?=
 =?utf-8?B?bGdZNUROYVhzZngvMk5acWJnUkx2QzNnd0FFaXBLNlB0WURzUFZZaFZmSEtZ?=
 =?utf-8?B?aEdpNzh0aDBqS0FzMHVKMHczbmhBNDNMenN5TnAwYnlteFpVUmZ1bFZkVExy?=
 =?utf-8?B?R2xxL1daRzhrOU9TaEhsc0pTQ1FicmUzSk41SjVvcFpiRDZJRjUyRCswQzRa?=
 =?utf-8?B?UEY4M0F1b0ZpbGx6bWZGVGsxYXUvZlk3UDdnalFZTTI5SHJtamk2b0ptbk5R?=
 =?utf-8?B?b2VYbzdEeENmS2Q4d1MrY3FHazhZWGREQ1Vja2Y4RjdzeEJyZWFkQ1NSQ0V6?=
 =?utf-8?B?UkJnMGIzeEwwaTVSSGNYMmhoa3l0Z3ByU0htVzh1eHZ4UkpwR3VIeXpML3RY?=
 =?utf-8?B?MXl5bWl1WmVlbTNpZ295d3RqUE14UE1TT1RnYldyRmcrd2trNUNOUWphZUFI?=
 =?utf-8?B?aDJQMTJHWDA2RTlrdkNqK2g3amlNRUZpR2x0T01MUGdsa2poTWxqTXFnVTJl?=
 =?utf-8?B?b1JsdjRMUXZCS3JqSTVNay9JL3haRXV0QW9hbnozRWNrQmhrRno0eFRDdXJ5?=
 =?utf-8?B?QnJsUmVheEo1TEh4ZndLQkUvMW1zRGRCWFU3MWNDVVE0MVRuMWZzcG55L0dN?=
 =?utf-8?B?ZjZHN0RJcHl3VGRuK1ZmTjh0Rm9JcTZ3WEFNNXYyWkxHRHJPMzZyTEN6eWhv?=
 =?utf-8?B?dURwZFNhVThTaHZzWS9sU2JWd3VrU1o5Z3JzMXRUanVJUWFMbkY2S0hmcUUz?=
 =?utf-8?B?VXl3WjRrOFBxVWEzTkw2SU9DTUhYSzNpRTBHemNDVVljUmYwOVhURndCZmdS?=
 =?utf-8?B?aTRSVTZPSmFBMk5FcDhJaUpYR29yOUs4ZFJuaHBHTWJZVjF2L3FHMzhhcjE0?=
 =?utf-8?B?U0h4Rlk5K1RXTm9iMm96cjBJamRHZGhyTmNHSW1hdldVdWQyeHNmcEtoM2Qv?=
 =?utf-8?B?UVFuZW9TMzQ3Skh0TEtXSlZFR0h1K3hvZFU4ckhMKzBhQUpLSGF1UnlnVEQ1?=
 =?utf-8?B?Z2lCZkI2QSs4TnhBQUREZjhrWEpqZVJzOVVNQjFLZDZ4eTVhQ3ZEcU4xQ3h0?=
 =?utf-8?B?SjRraDI3aTFGZ1pEUlgzV3ZEa0Y0eGdWSDFHWGE1c2VpZHBzeWQyS0hNeFEw?=
 =?utf-8?B?N3pBS28ySUVETzJWOEY0VTlha0FCRzdZeUJZUm1VL1NiejJGaDRXRmVpeGVZ?=
 =?utf-8?B?dEwrdjk0SEVRaWFoZlBkeHVVRGV3NVhzS3dwY2pLZCtDU2JJcjZDKzh4ZE9n?=
 =?utf-8?B?OTdYK1JhSXpILzNDVUZtWmtWb1ZrR01abGM1Vm9GSmhocU9sVnNtYmtQRW1T?=
 =?utf-8?B?ejYzTDlCa3F3ajNsTkkxTzczYll2aWdlZERrTjkvL240YlBVTHFOWGJ0OUdv?=
 =?utf-8?Q?v61eLJmnXR/z6JaH/q2Z3gLGYq7/X3hYY+63ewA2A8cY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4986e25d-2017-43a3-076a-08dbb9b07286
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 08:06:09.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1762
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ren, thanks for your review.

sg2042 and jh7100 use the same uart driver and we here just want to reuse the logic from jh7100.
We don't touch jh7100 stuff, we just rename "dw8250_starfive_jh7100_data"  to "dw8250_skip_set_rate_data" and make it a common data for both sg2042 and jh7100.

在 2023/9/20 15:53, Guo Ren 写道:
> On Wed, Sep 20, 2023 at 2:40 PM Chen Wang <unicornxw@gmail.com> wrote:
>> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>>
>> Add quirk to skip setting the input clock rate for the uarts on the
>> Sophgo SG2042 SoC similar to the StarFive JH7100.
>>
>> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
>> ---
>>   drivers/tty/serial/8250/8250_dw.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
>> index f4cafca1a7da..6c344877a07f 100644
>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
>> @@ -770,7 +770,7 @@ static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
>>          .quirks = DW_UART_QUIRK_IS_DMA_FC,
>>   };
>>
>> -static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
>> +static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
>>          .usr_reg = DW_UART_USR,
>>          .quirks = DW_UART_QUIRK_SKIP_SET_RATE,
>>   };
>> @@ -780,7 +780,8 @@ static const struct of_device_id dw8250_of_match[] = {
>>          { .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
>>          { .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
>>          { .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
>> -       { .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
>> +       { .compatible = "sophgo,sg2042-uart", .data = &dw8250_skip_set_rate_data },
>> +       { .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
> Why shall we touch the jh7100 stuff in this patch?
>
>>          { /* Sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, dw8250_of_match);
>> --
>> 2.25.1
>>
>
