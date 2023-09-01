Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B221178FE16
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349688AbjIANKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjIANKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:10:43 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2050.outbound.protection.outlook.com [40.92.107.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14BFE0;
        Fri,  1 Sep 2023 06:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUyjQZvEFUea3s9mTmbdcW8dgxE0wFLhJYMpuOjzZf0qa0MflSRKmIQI+dcIkkV1XXUOIpHqfmQF3odHBiS3yyFyMm/Zd93xPmrc6lMuD/ufPG1DvavEFri/wXvZcTkzV+a7vk0RDcmDXvXEx+BKpDiaCcD9xi8kL9qZdzuDH/9sSsA0KXBSd3q9CDXd/ako7gE9T8kShkefCMy3v8nD8klX7bDf6eNcOvJQBSHyTeX6n4vWwp4KWkpii1Q/OVxxIksG3YkC+O3acC5gGMQoQlMB6EHXG+SE2O7wguSAYD1GMx3l5eRGKo/MJh8lesGStmRn6gI7Z64a6hYAqQdQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMe0cIZJZgJgtFaQ0bb8Okh9q+9WJ/XLDjlMdBHKATU=;
 b=Rugj5+hA5Spv32elbXoidqMLkOHm/ALy0/aNbBgUvk+s1fSwk9HOsIpxD1HP9FZtY0lUWHEN0vRC+WAuUleXIdYyhx6+h/ULnaju1GBLWbwpchSXc+IJdYl+ur+/qD7X3kLnLrIZFFgkaMaQTqUkR1mEHrnpBM3jZgZZM0lEuPiq8j3IwJODqqYR+YX4coEbFSj8FhTMDUTSnuyi2n3ovaMbZPWAtV74BwTnrPPA/c/7gPr3AxbLJ1suWrETolba1rNZNJZoj+g1Vx2XZ5lSkjkk1ir0Axb/asijZtsMZmfaFK4apVrHidJOfeyiQr3rzZ9U1BoWLQTtJ8UGQqebRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMe0cIZJZgJgtFaQ0bb8Okh9q+9WJ/XLDjlMdBHKATU=;
 b=hwfiofloB/teTJ7kToAy/yqpPK1SU8ZBaajc9l0xH31gmQd/YZvxwXySgGzbEtUOxEqqC5ov0umu/4vgv9gqnpufbDcnqIjYXUZlPVaWq+KMeBcZMflajvKZY5kgY3uYMs+Anh9PXoHkrXqxBStlO7aHOTQrsPSPI9Fts5hWXQPYWGq27dhd+YT6U52kGffaQNhsik37HDpYCyTthKbUuc/nIwKKj3kF2OkB1euYQSqYcCQwU9zMtnOHpSD1kkWh5qeFr5rsjgzZtwymfJ+cTmFuegmBZ/JTGOfYSgz8st6A11bcHL4qIYol6QBiPr2DXI35nxx81YZwLs+L59/6Ng==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by KL1PR01MB5797.apcprd01.prod.exchangelabs.com
 (2603:1096:820:10d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Fri, 1 Sep
 2023 13:10:33 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a40d:d453:3c29:577c]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a40d:d453:3c29:577c%4]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 13:10:33 +0000
Message-ID: <TYZPR01MB55565E0E55FAE550EAA53D3AC9E4A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date:   Fri, 1 Sep 2023 21:09:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] arm64: dts: ipq5018: Correct uart1_pins pinconf
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>
References: <TYZPR01MB5556F902BF64AF857C3ABD44C9E5A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <49fbae87-ce09-23af-6bcd-459b5646e680@nexus-software.ie>
Cc:     agross@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_gokulsri@quicinc.com,
        quic_srichara@quicinc.com, quic_varada@quicinc.com,
        robh+dt@kernel.org
From:   Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <49fbae87-ce09-23af-6bcd-459b5646e680@nexus-software.ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [GDcMt4xi7hbzW641LfXLYRTtWlRcqWat]
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To TYZPR01MB5556.apcprd01.prod.exchangelabs.com (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <bd38884c-9200-dec2-755e-7131af8b4cfa@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|KL1PR01MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4fc4b7-6445-4e86-967b-08dbaaecd2d2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14jbAkRCX6a0vy94Bs7OfCAUDo03042kkUCor2VJr/C67fA/0eBVzh34wkeCBBY7by1OnLudlXzRp1CHdIfkevvrlQpVH3YMaJN1gErKx/uo57iFtcftxihyIDISCOvzYuB8EtXEfZ2IJz5/4mP2h6jlxW1sL5X1jQsDtGHIt217Yp7lSh+NhMe9xVZPkDCuM6gRQtBaFqApoJqBjBcuGmE+daNG3hcX+TsQe5BkUI4iZvnKsOdYjI4Cr579WpCm8Es8Fz6JgHKdesHmrSDvRvT/7EdsPv/1oeFZzGwRzdwtI4PRxM4kMGOM8xboOt+IMJlW8TMIwnBMjkwBrMw8vwiuPh9vucX4Bn+kwjxi2FVovId0Mc2IBK0VT6ZXWXYMuaOY0KSbJT+3iU2xcRZ74D+9trjjaqsW6+XYXw/pefOvYFk9mP9h5xSOWIALDmUSeC+pvxnJQwgzA6r5Huv2tkGP3JcIq6qo9sg0a13B18obgJ/+WKKOqR3gmpIh9lX1IXAk8Pl1jlDIaVuJtO44cfUdmaWiq9AA0dM8VeoKXHU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWRlOTRFOWZ5bzNnSGV5L0ZhZlRQWnhDeG15MkRvTUo1UEdtTmYrakVjTENt?=
 =?utf-8?B?N0h1YTRLeW9ZZVlWVytsdnZ6b1JUcFNoNVNJNW1Ya2xKWHA5MitTUW02N3U1?=
 =?utf-8?B?YTlZRTExbUFUd0dPbUFCNldVYUpJcUxlckdhN1ZlemlHSHpBVkl5dWdVN21O?=
 =?utf-8?B?a0lKM0M5VytWdmRTWEtLN2l1RXcycHM2dEVaNzFsV2FSckJKaDRBUGtGcDk5?=
 =?utf-8?B?d01UOVZZUWN0bm9iMDZTNFlzVERnd0dFNThIM2JiM3JKVzB5OWltRUtNSmhz?=
 =?utf-8?B?K3BjYURwaUNKVW05cXhRQi9jNVVka2oyL2g3S3dJQStXUGljSjliSEhwYmQr?=
 =?utf-8?B?ZnkyK2hMeTN4VW9YeWdKT2NvdHZjdkQvWVFTTUJUdVdmQ0Z0YjhRRTJxcS9T?=
 =?utf-8?B?MEh6UkdsSmYxczRJZXowWVpYYzdMbGd2c3QrV0tsbWlQS05LdkM1S0Jaaklw?=
 =?utf-8?B?bXhGVm5rS21tRTQzemUrZFVoZWRNSjJIZndzZWRDbzlMT3Q3WFA3QzA3N052?=
 =?utf-8?B?YWloTncwWDZJTCtORXRjbXozeWQwcmUzYmxyM0tPMWVKbFJxbHhpUi9Nbndw?=
 =?utf-8?B?Ni9keUhXdlV0RzJNeUMvVGtoenNuK2xBUmI2OHVDL01GNmtMc3NlYjBPenZY?=
 =?utf-8?B?eGtLdmZzRkpVY08xa3ZHeW9DeUlrTnBsSFNpSGZnZ1Y4RWRsaXlYRW1DVS94?=
 =?utf-8?B?UTEya3J0bm44OS83SjhBQmxJSlZlNTZWQmkwdEROUmJuL3hsQm1Md2JMYUlo?=
 =?utf-8?B?NExJdHMvbmljeWFld29YNm15WlNUWm00a1NoeFNoSXdIS3V1cDJHS2xpczJa?=
 =?utf-8?B?U1VwenVKU0VNNy84bVh4TFNMbkRFQXZlNUt2Y0Z6a0pUQUpLZlllbzRIWnBU?=
 =?utf-8?B?ak1WaFhmZGJDSG5tQVk4NkJBSE9KMzFuTFl3SndIOWlPNFROMC9YU0ladjNH?=
 =?utf-8?B?QWV6K2xjWi9GRFdBblRzaDYzT0c4ZEEzTmFxL0loWGp3RTl0NVZlSFFpR05i?=
 =?utf-8?B?N0pWNW91dHRyZDFZbng5M2NtZmR1aERXUnQxMmwzNzdtUGN1WkNwUk5PMDFz?=
 =?utf-8?B?Ulcxc2RXWThrR3pIeHdYaTAyb3ZHa0xHQ01taVAxeWlWRThkUi83Um8xb1JW?=
 =?utf-8?B?cGhoS3NHRGQ5Ym1oNVlacGJmV0Y5Nk5QeW9vWVVqa2d1amtBajRGeWlVblA1?=
 =?utf-8?B?N0ZIaUtKSktiRW9qUGRCTmI2dUQzL0gwRllKNEpmQlZvb3NZYzlVZ1BOL3N3?=
 =?utf-8?B?RDBwanUzdkxDcHpjcDJNS3NuVGd2eDZ3b3ZPamNobUxLT2owNEI5V3ozVmQv?=
 =?utf-8?B?OTBvMVE0QmRKd2dwN3dKMDN6RStxNXEzTWM4WE9XNHJmcjVRM085NTFoUmU4?=
 =?utf-8?B?UzY3SW9YcjZ3dE9nMFN3QWFZckxmRTZ4M1NZeFVLdmRYbFUxWUF2T1loSlFk?=
 =?utf-8?B?OVBOV3NORHFvcFRLWDZWUWI0RHo2ejNPYUQxME1WTzM3WnBBOUVQZkg1L1Ir?=
 =?utf-8?B?TW1MaDNjWmpxdGozNkZKSW56UFZoWmpyanBKZ1RSYUV6ekQ5OTlKdlZVWkhs?=
 =?utf-8?B?eGJ5V2d6TmYzcVI5NXV2SDB0c3VBU2RIMlZqQ3Q5eUg2UWJFMm1TWnJORXM5?=
 =?utf-8?B?ZDlNQUI1a0xFWnRvMWR0SE9mVDRMaEE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4fc4b7-6445-4e86-967b-08dbaaecd2d2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 13:10:33.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5797
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/9/1 4:19, Bryan O'Donoghue 写道:
> On 31/08/2023 17:34, Ziyang Huang wrote:
>> In pinctrl, the pinconfigs for uart are named "blspX_uartY".
>>    X is the UART ID. Starts from 1.
>>      1-6 are in BLSP Block 1.
>>      7-12 are in BLSP Block 2.
>>    Y is the index of mux config. Starts from 0.
>>
>> In dts, the serials are also named "blspX_uartY", but with different 
>> logic.
>>    X is the BLSP Block ID. Starts from 1.
>>    Y is the uart id inside block.
>>      In "ipq6018.dtsi" and "ipq8074.dtsi", it starts from 1.
>>      But in "ipq5332.dtsi" and "ipq9574.dtsi", it starts from 0.
>>
>> +-----------------+-----------------+-------------+-----------------+
>> |     Block ID    | ID inside Block |  dts name   | pinconfig name  |
>> | (Starts from 1) | (Starts from 1) |             |                 |
>> +-----------------+-----------------+-------------+-----------------+
>> |        1        |        1        | blsp1_uart1 |   blsp0_uartY   |
>> |        1        |        2        | blsp1_uart2 |   blsp1_uartY   |
>> |        1        |        6        | blsp1_uart6 |   blsp5_uartY   |
>> |        2        |        1        | blsp2_uart1 |   blsp6_uartY   |
>> |        2        |        6        | blsp2_uart6 |   blsp12_uartY  |
>> +-----------------+-----------------+-------------+-----------------+
>>
>> In "ipq5018.dts", "blsp1_uart1" (dts name) is the first serial (confimed
>> by the address), So its pinconfig should be "blsp0_uart0" (pinconfig 
>> name,
>> use GPIO 20 and 21) or "blsp0_uart1" (pinconfig name, use GPIO 28 and 
>> 29).
>>
>> Fixes: 570006756a16 ("arm64: dts: Add ipq5018 SoC and rdp432-c2 board 
>> support")
>> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
>> ---
>> Changes since v1
>> - Use corrent name in From
>>
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi 
>> b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> index 9f13d2dcdfd5..91b98020e1c6 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -104,10 +104,10 @@ tlmm: pinctrl@1000000 {
>>               #interrupt-cells = <2>;
>>               uart1_pins: uart1-state {
>> -                pins = "gpio31", "gpio32", "gpio33", "gpio34";
>> -                function = "blsp1_uart1";
>> +                pins = "gpio28", "gpio29";
>> +                function = "blsp0_uart1";
>>                   drive-strength = <8>;
>> -                bias-pull-down;
>> +                bias-disabled;
>>               };
>>           };
> 
> So this change will have the effect of changing the console on 
> ipq5018-rdp432 from gpio31-gpio34 to gpio28, gpio29.
> 

No. GPIO31-34 can be configured to "blsp1_uart1" (pinconf name). But it 
belongs to UART2 (Index starts from 1). For UART1, there are only two 
groups - "blsp0_uart0" (GPIO20 and 21) and "blsp0_uart1" (GPIO 28 and 29).

Your device can work with current code because of U-Boot. U-Boot 
configured correct GPIOs for the UART and pinctrl doesn't clear the 
pinmux settings of unmentioned GPIOs.


> Have you verified that change on hardware or the schematic ?
> 
> https://forum.openwrt.org/t/add-support-for-xiaomi-redmi-ax5400-white-version/140879/22?page=2
> 
> This has the wrong UART pinout ?
> 

You can try to export the GPIO 20,21 and 28,29 by sysfs to clear the 
pinmux settings and then your serial doesn't work.

> Is this change something that should be expressed for a particular board ?
> 

Yes, this is device-special. Some boards use GPIO20 and 21 while others 
use GPIO28 and 29. But we have defined a wrong value here. At lease, it 
should be a correct demo. Or should I leave 2 configs here to let device 
choose?

> ---
> bod

