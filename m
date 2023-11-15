Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BC77EBB40
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 03:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjKOCew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 21:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKOCeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 21:34:50 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2075.outbound.protection.outlook.com [40.92.103.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57449C4;
        Tue, 14 Nov 2023 18:34:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyIG4DwOB5io7u7nTGW45kl4N4aTrwiW3Tfwz+4F3iE3jpHSv2gAPWBShmV1Hw0Cj184vYwL5ayWSS7Rvxr69rrYxSffQWXBxy7GYYqfnueV9Hvz/8kaVQuTP9PIXzsW758Rv8d+y89bgAHMZ2gTFjFW8a/LeFVYhvsB9MJI8OIPbn/wNCK+f7SEXRe6MXfBOe2Fn4AQ7aZ/iXub1kyrmtjlKtWVSF99/qx9iALdKvDDjRT+/DRK8F5dBlp2dp+a8gENGYV6hvAXP/nZByBNfBzTwN/DrItvRYEYiPOVuhBtv+xUawoDRXjgCFThhkrXw6emy4N+HIB89O5Nxxzpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8wRBArRDv5vFodQ7HPWe0bidS5cmtRLzhFaYJaNt10=;
 b=GrsxeI52SX9o50CWGMjgAix24oN30sARkmg68FZrgX3uAlQ+XYLsSebGFO+a9bFsBz0ZJYq2b8swYGUf9OBdb3tvENHjCrC0AozHQRMm0BfTotkhieAq23kDbk3TZq6sBgtsoNDY/8ho+azOcySV6VKjyePxrcnoVxLsB6aSelt6WuRgaBuzy3exXrst9oz3xdE1s39kj2eix8E6E3c4I6dmw9NZEb8aZX/W6uvWeGT6z33oy4zBESXW4TmU2vbpr7acni9j9yBW0cZ7smmr0/z2tnO8bd6bCAHfD1meM4MVxo0OJsbgOeLsQkhl4Dm2iMjKEocNCDJxQRT4B3ej3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8wRBArRDv5vFodQ7HPWe0bidS5cmtRLzhFaYJaNt10=;
 b=s1HeLtOXYZit0rb8Qp+O8TAYxW1pv/MB/r2mRU/ZyY/Vl9NeTcf4Cuxua4OG7tQsC8yLRFBj6Zeuc1KLJyOv2CkSr3FX5TjZansdfvVFWYaShCLSzI5aGkHnxNb5W6YFcwx7HPEJmJMsxcooCnGA5E9Lao+3onn73Sa6AZILZL2dww2t30f2vFjz8biMmCoUm3i8iPdvM3ipubwLhGo0Lr5zs7+IbnWp/wUjZ2cpr1WxO4CxuiNgXShGxcpg8/SsbXbBNFe1azAbyItdX8HD8T2s1mJG4zBH4N7FQyAuA9rEBZDi2X+qCev4YzB24Ut2+UU4ccgRYyqfrHUOpfqTgw==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN2P287MB0738.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:f5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.18; Wed, 15 Nov 2023 02:34:39 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 02:34:39 +0000
Message-ID: <MA0P287MB033267DFDA919663B01C6C57FEB1A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Wed, 15 Nov 2023 10:34:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] riscv: dts: add clock generator for Sophgo SG2042 SoC
To:     Samuel Holland <samuel.holland@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com
References: <cover.1699879741.git.unicorn_wang@outlook.com>
 <25fcbab4c04bcbbdc4577dc58822540829f91dc9.1699879741.git.unicorn_wang@outlook.com>
 <20231114-grumble-capably-d8f7a8eb6a8d@squawk>
 <PN3P287MB032447BC501261D47E8E3124FEB1A@PN3P287MB0324.INDP287.PROD.OUTLOOK.COM>
 <68220eb6-8a20-42d4-83e5-d0d45b2f1404@sifive.com>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <68220eb6-8a20-42d4-83e5-d0d45b2f1404@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [lsGd0pydk6mHAX0yLrMSNC6MGxr6tSbyKL1KG9fttLk=]
X-ClientProxiedBy: TYWP286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::15) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <02ac84a4-ccca-41cd-ab95-a97cc0dfa87d@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN2P287MB0738:EE_
X-MS-Office365-Filtering-Correlation-Id: 5231c69d-45ee-4cde-5743-08dbe58368f6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ghf91YSybHWqbYNWLBUKE++Ncp4avt/YxtSHEX0aoEJHzCLeOVzi7UTBGUtIOY7iH6mNLVjvf2rSqcfDBHtECAzmCLlKWvN35prxFnRIYOoQ6B1lNao77QuUqIrzC5Xq+art+eukZL78ui6IaE/XLhPUDuYpto/TCGlxwIIK/6vB4jc7ABEseDlFEFzFYjd5RtpFrYqq9SRMIevIJbveJk5UUY2OXbqJKBTw+kq3H47DahB4e1ti6jP3/tkEdfS5tjTFkhR3/zq4cC7/ia327NEoS2lfHZlW+pbdNHgNIe+uNWCgHbVmrvTwCMzHZQFfQ8YK7Lw86xgE470AnVUToYyzJ+tlf0tqGWTNgg8OSJ3/YP9JnbnNQNNJql6tZI7U78/rFDvvkV3nP04nuZWheOsOZ8/m/MRgpgnNViqpy7zjVZ00sXsWytzxWihcNqInDOsnUidiG0dqIUwsuLZ9xXA85rK3rhbJ3ugSd4HSFN3iXjT68AnudfWPt12yOYm4fGlkoeaBAHksqTPKDsUyxaygpfJYQqawoNTbQzbOJv9VBClrxMY7GmiSSiTm/wTsz92bW5GfHc4JpdMI1LYzKTp52dK8dLXq5wram+62Hx4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bExMNGRkZExCRWM0SVNlYUFlcUVhTjhGWC9hNEhZbDlOckRkbjNvcGZuRitO?=
 =?utf-8?B?UjNSbkZsWmltQy9vU0pDYUNYYUpQb0FNVFdzMzVPSkpDejlERGZtZnplN05q?=
 =?utf-8?B?OVRLUGJMM3I1czdVODRZTGRDMWZPbmpTN3huZituWVlhK1JEd2xsUk9uVFJZ?=
 =?utf-8?B?TFlsM25zVi8rL3NGaDl0MFlrTkJUZGx4bEtPZUYxUzgzYTQyTWRjQmFOdnBq?=
 =?utf-8?B?NUZoUU1PRXA0SzRicnFwcFMwZjAycVBhMUFpZ2ZEZVY3aC9yck9UM2UrUkMz?=
 =?utf-8?B?eHJhMEpxY1MzVVpLMk9CMXFGZ2tRZU10MDVxV211NlZqeWxDVzA2YWNGMkZB?=
 =?utf-8?B?OVBtM2VTQU9jM3ZpRFhjVCtkQlp4Z290KzZQU0hkUVZWTjYwMnlSclBXZ25O?=
 =?utf-8?B?ak1tUnZEb1NxVXdPczd2cEp5YVVLd0hSc2kyWXU1Vy92UHVTNy9makxsNDdI?=
 =?utf-8?B?dC9HOElKMXZCT2YyMnRRbHZmTjJxNWU3QzhYZXNQVDljemI5UmQ2L0VjOTZy?=
 =?utf-8?B?eUF4UGFQdmx2eHFaOUJURzZqV0RjUEpHRUxmeitTcFJGTDNkY1RSOVVLbGNR?=
 =?utf-8?B?d1RjR0hPZ3pxbnZDOG4xemwvZHRvRnIwOW5aR1VHc09uYXBGZTZBS1I2KzBL?=
 =?utf-8?B?aWNsTWllbDhrandFTEhPbGZXcDBFRGJjYWtyNzFQdTljSnhpMCtqd1lVdm02?=
 =?utf-8?B?NDZrd0UvT3VrT0Nud1ZMaFZYOHRRbEloRVBKSzNYSTFDQnYzdTlTWFFrSFps?=
 =?utf-8?B?ci9BRkxYRkxveG05Rm1qQ3NwR3pKTWg3SlVXS3RoSTdHUlJGNmdKRHVuazBG?=
 =?utf-8?B?eFpLYW5zMTJKWTN1MHVmODE2TTJ6UzFLbmpxbGFmSzgvbmFHeE5HZFZPM0ph?=
 =?utf-8?B?cHFTTUEyanNKOWYrZUdqTnRXangvbjNtU0pUMFNkNHVZVERkTGpwWlhoT1U5?=
 =?utf-8?B?Vm1pNXA2ME1SZXhmaWJwN1dMMU9CWHhXUWpmUFlJOVNwQU80NEM3aEo0REtL?=
 =?utf-8?B?bEJoWHFiMHUrUlVjQ3I1K3R1UkUzamNUNHNEUmdWOXpiajFwNXlKSnVQbk5Q?=
 =?utf-8?B?L0tWWnBhdFZ1RXdLdzdTNHhHaEdJT1lGeTU1ZE1BTU5QWVZrU2UvWCtOaGNF?=
 =?utf-8?B?Q013T0dwOGFSVWJDaHpiRlNYVHFXRGwwcG5UN0x4VTdoalYrT3Nmclp5R0Jn?=
 =?utf-8?B?V1VaUkNqWGw5VlNxaVN6VWJ6VC9QTkNna3NFWktBaFVZbGlvSU81UGE2cEk4?=
 =?utf-8?B?dmZlbTNMSWdWMnRoTEg0TWNvVklzS2dSMWtOUTA2dHIzemt1WkFLVEFRYWF3?=
 =?utf-8?B?V2F1OEZBc0wwRFlVVlZUQ2RtVS9Rcmxmc2sxSmZMeWYrSDY1dnV0NFc5VEw4?=
 =?utf-8?B?eEV4RnlGaVB4dzcvdldycHlPT3RYMlBYaEdKSHFucS9VY1BsVGxKOGNEcU92?=
 =?utf-8?B?ai9wMTN1UWIrRTdSa28rK2IvSlFnWEc1NHlVMWJEaXRCWUJmWUZnMVhFeWdX?=
 =?utf-8?B?WHQzRCs4UXBqVlUzREg1cHRDclkzSlY1SkZOcjN5NldYNHhJOUs0M1VGRW5Y?=
 =?utf-8?B?MnlGNThDaHpZTmQzeWo2RkY3c3N6YzJmREp2N0hSSmk5WnlCNFM4ZDRnVGhM?=
 =?utf-8?Q?clTrW92W2VGDtYkokzQ1M8t7yw0LvGxJVwxys1dR3QjM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5231c69d-45ee-4cde-5743-08dbe58368f6
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 02:34:39.0149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0738
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/15 10:15, Samuel Holland wrote:
> On 2023-11-14 7:34 PM, Chen Wang wrote:
>> On 2023/11/15 1:31, Conor Dooley wrote:
>>> On Mon, Nov 13, 2023 at 09:20:11PM +0800, Chen Wang wrote:
>>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>>
>>>> Add clock generator node to device tree for SG2042, and enable clock for
>>>> uart0.
>>>>
>>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>>> ---
>>>>    arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi | 76 ++++++++++++++++++++
>>> There's no need to create an entirely new file for this.
>> Agree, I will merge this into sg2042.dtsi in next revision.
>>>>    arch/riscv/boot/dts/sophgo/sg2042.dtsi       | 10 +++
>>>>    2 files changed, 86 insertions(+)
>>>>    create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi
>>>>
>>>> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi
>>>> b/arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi
>>>> new file mode 100644
>>>> index 000000000000..66d2723fab35
>>>> --- /dev/null
>>>> +++ b/arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi
>>>> @@ -0,0 +1,76 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>>> +/*
>>>> + * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +/ {
>>>> +    cgi: oscillator {
>>>> +        compatible = "fixed-clock";
>>>> +        clock-frequency = <25000000>;
>>>> +        clock-output-names = "cgi";
>>>> +        #clock-cells = <0>;
>>>> +    };
>>> What actually is this oscillator?
>>> Is it provided by another clock controller on the SoC, or is it provided
>>> by an oscillator on the board?
>> This oscillator is an individual ic chip outside the SoC on the board, that's
>> why I list it outside soc node.
>>
>> Actually the "cgi" is abbrevation for "Clock Generation IC chip".
> Since the oscillator is outside the SoC, this node (or at least its
> clock-frequency property) belongs in the board devicetree, not the SoC .dtsi.
> See [1].
>
> Regards,
> Samuel
>
> [1]:
> https://lore.kernel.org/linux-riscv/b5401052-e803-9788-64d6-82b2737533ce@linaro.org/

Thank you Samuel, I have learned this and will correct this in next 
revision.


