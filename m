Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB62790BFC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 15:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbjICNCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 09:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjICNCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 09:02:50 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2108.outbound.protection.outlook.com [40.92.52.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777DD11A;
        Sun,  3 Sep 2023 06:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8R1DKlxyuDgpEX3sMdm5xT3PEwtRuUb6NdTR8iV8ss9uTMcxiwvfsDcBYkoKtAks3ecaI/cIHG3KiKkN/pxEM7laZejIL4s4bY15rG0T21Fi1rilP6JOqaOtw+htQJ/wZzDkG5iOXhW2Ge5DncfluyzRzIGhFncZLTFnUmuqcs2ADQYAGh36BxhMAXksnrXbCTG9UcVheldjSiITkmgoR1rJFLIhgHGyjRlLv4NrIceio83rsuxY5F82iqNOJXL4EhUhdrCvL4d1zM4wi6N/GlkP1KhbotzhGPCd7gJycWZhZ5iL/V/6gSs22PW/dlPHiMywbTwYfU3rrRQHjoWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXCAujRKuEMg7A0gHtXxZtldt6Q3tGJ2G/QvgdT9XWk=;
 b=lM7bcthQYSILPTGU085D+m7yKX0V/3FxQ8N9sFfkVx1H69m6Mr0PHlPCRLM+2JqQLwPLx6K1PYkXan0CV+fJn1Xvkng2cHxkuUSrKkyE3c6v0QeQziBT2b0Ka25h4S/tXv8N2mGqKXEZ3x32+l3vemQYe6nksM9pHnoqicHSqu7ata2Jtwa9aFCmKvJ2+ToC4JJaDGqD6drHpo54zouT9hUWXCw10UMWBZ18wESgnHmi2UuuVn5HXd1rnkrnGwYAWvlc2Q5Dz/M+1mTaFPALOoUiyTz5bbxQacq1Aocx+zG0hq1PCgvH3F9JoXUngl30MrWmScwRt8ANmJ/Al4yjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXCAujRKuEMg7A0gHtXxZtldt6Q3tGJ2G/QvgdT9XWk=;
 b=nFeH6HKJgA/ik451WSdlT04BTDSWR7pKXuAH3nHZIBV6sPMxfrWWBIodNH6icQAgwooyNp1meSalap5gNSg5rcGh1GbRgo0PWBD43XoVwuwKR4iE/iLlQdJj/N8mcsF7YMQBJwPQxP7SR4R2NbtdL0XjhQgH3JPLp5OwiWL2D95hNsLa27l6Ak4kOjgN/nHx8luBBTC6OM8pWQeHIsrIwld558UR7LOhqiTNHwjyhAwVwfMC7l0CUV7sT+yuJV4O0eiiBX7m+onVIZGYhxYh3atx1a+tL2G6Jex2Zi13tjxBrRMMk2nfrVOF6sJMty02Oo5ScNB4ew6tTIEQBfPwPQ==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by TYZPR01MB4941.apcprd01.prod.exchangelabs.com
 (2603:1096:400:282::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Sun, 3 Sep
 2023 13:02:41 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a40d:d453:3c29:577c]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a40d:d453:3c29:577c%4]) with mapi id 15.20.6745.030; Sun, 3 Sep 2023
 13:02:41 +0000
Message-ID: <TYZPR01MB555673C1E12A27DA8109DBEAC9EAA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date:   Sun, 3 Sep 2023 21:02:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] arm64: dts: ipq5018: Correct uart1_pins pinconf
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_gokulsri@quicinc.com,
        quic_srichara@quicinc.com, quic_varada@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <TYZPR01MB5556D24A77DAFA013F93B551C9E4A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <b6fa8337-a5c0-172a-a41b-ab18de3f4f72@linaro.org>
From:   Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <b6fa8337-a5c0-172a-a41b-ab18de3f4f72@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [BMVubM4hnjMhegShwFiPqGeAfylNvh6d]
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <ce970610-417d-7073-2d71-1bedd0195009@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|TYZPR01MB4941:EE_
X-MS-Office365-Filtering-Correlation-Id: 484e7e70-8bf0-4088-a72c-08dbac7e0eb3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6XZh4xGTJ9lM84jKcIg4lWljBKoCNiMk93w75Vv7/JZjB3nmuTcIYxrFkquoDYl6wi6lzPBA/zbMSTDfPFpOq6c36UA3KIrfa5NBBP2mTRmWlMHi8ve50dXIC308zv23iwMprQDdTZSKIrT942ziRt8jn1pTVip6FR+qBSR2/rmPLoLftwQLFWKPkYlRrsRM5OzcIdHW2YD9A4+kI1TvJLYxtKzBYVRTpkbIX1Ahu1YPGEo2FAsbDp34fHlAHT03hqbPyWq/nM0UQRcrhv0yVY8lea3THkqMMcPrMW2D2AkdOWSzbPJypKxTF0QZhecyvDfF8JGMCpzfaRJoY5Whs/xTDUv5iS4NZ/2kUIzzlJRjseL/X6FkSsEjn4+tYt61/1AinF0U0712iyXg/nv6YsmNbSstbpqhhSlKNm0Kd4DXR9V0jLaqkSWSDzxLwoEU4Ev7xi17/33K6fcYIW9r06IB3suhvidbZSWgVairiDxWmfL1rAnwUKXvPkdZACGpPKwQHjmHG7tvbgjuQRcoL+haB88RDHnpnt7TSKxuFJM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEg3cnk4bDFDM0x3UGdNaVdseURxczdhQ0p1ZENMRXBNOFRnRDBiVDZaWExO?=
 =?utf-8?B?SFFHckV4V0NQSFZ4LzhjMUllbWR3Z2hoYXpSSUFLbUZFMysrOW5ZYjN6TWt0?=
 =?utf-8?B?WTFEcUZOS01RNmJtRTA2NGtYTmk4TDVOQlFmcmYvL0pXWnExY0NGQXdqaFBI?=
 =?utf-8?B?VjAzTSs1NkVzVXBiRGtOZnRQTHo2UmhEN2hmajZwbVByRk1wZ29qMzZZSzgy?=
 =?utf-8?B?TDZpaURLcDBrdmdSS0hBTm9adUFvQ014L1d0dTNrNGpUd3V4bGE5VisxWTF2?=
 =?utf-8?B?MkhsVDZFNmgxNkl0djR0b2ZBOElqTjVndDhqcUZTTi9NY3hyQ0d2MWM5OWpU?=
 =?utf-8?B?Y0NtRU9RYlBDMFdLRE9GZnJzS1dOZ3M0ZFEzOXBnRHovdG80d0JRSTFySjVF?=
 =?utf-8?B?Rk9qZVBTc2N6c0pIdTRnNXd5TVFCSXF0eGJDZ0dVRjFRZ3gvU0VtdnJQVkY2?=
 =?utf-8?B?aTJ0YUhNbDZlVTZ2dUM3ajhOdTVTRVFUTFNOSFVkS08xSDA2cldyWnpENFpH?=
 =?utf-8?B?dFltMVJEU2szbzBONi80eVZxUndjUjlCOVpGNytwblVtYnFhUERhMCtBay85?=
 =?utf-8?B?R1E0TGk0OEZpS2puMUdzTlJwVnJWV2ZaM3dTTUNaSHNWck5kY1ArQmp6MUJ3?=
 =?utf-8?B?amhQeTVKNHlLYlM4Mi9UNVo4MncyTSttWHFKbEhaNkJqWE95NkNRSWFMSTZS?=
 =?utf-8?B?ODdZNkJzRjZFZWRtSnphdUZvb2dJUnhCb09wemJYQ1JGcmwyL05oQUNlUmJK?=
 =?utf-8?B?VXMzZ2ZzMFZKM2I1VjFtcjY2ajN2SjRrNjRVQW9KMUJNMEVMZGh0NFQ3L1ZJ?=
 =?utf-8?B?VnhtSklTRkRZRWhuQ0wxZms1cGk0a1dlKzRqcHY5VUZhQ09lN0hnM3N2SkhG?=
 =?utf-8?B?N3RBOFlQbkpMRC9FSkF1NHhCZXJKbFhiK3doYWV4dnI4R2hEeE1RRlhiUDJI?=
 =?utf-8?B?RWpMUjR6U2pVVE91TnNLSDJXSHNkbE5YUXNDa2NWcVlmWm94V3RFclY5MmpZ?=
 =?utf-8?B?YUREL3Fac2V6cStreTZnV21jc2FYMkx2dWttTGdTbWxCL29sdGFwa2hraW15?=
 =?utf-8?B?RSsrV2ltZFlCOExXU2hEN2hFY0hPTldPcGJ3OCtVYXo0TUlDZlp4VFJrRUtB?=
 =?utf-8?B?QVgxSmVVdERlMzZPSU1zSkFHcjlvZyszL2pEZ0pIWTJHb3F5emlGNWh0UGg3?=
 =?utf-8?B?UmdqL2hrWFlwUWpGamRUcGtveDBlMitpZXJKa2NtS01ieFRJeThqdVZFNlBC?=
 =?utf-8?B?eUM0ZDRwaTB0UTJxU3drYXZYck5XU1NUUW14Q0htVGtmQkE4NlFpd1psc3U3?=
 =?utf-8?B?WWY5OUxkSEZjWUxTNm5jRFdWWG9rVWpFWFVQR3l2T3RDSjkvdi9pMUJDcUJO?=
 =?utf-8?B?OVJ3UW11SThYWkdKNnZDNkFyMzV2QWdvakJvTlhycWQ3QnI1VEllZTR0cmFW?=
 =?utf-8?B?M3I1dkVwWUY4TXNlWU1MUEdNWWdFdUJ4b2ZTOU14dU94MkRyYm4rb3ZXNUJz?=
 =?utf-8?B?eXVjMTBtemdoNzlQMUhnVEVDNDRPOXlUMU5QWmVKL2xsd1MyLzBaYTYyZTk1?=
 =?utf-8?B?MngvQ0MzYXB5NUVNUE9wajR4MzJLRzhEeXBXdDJCLzZjdkdpWXkxbVR1d1Bv?=
 =?utf-8?B?M3JmczBKYnB2V2kyV3BLUStqdG9zSXc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484e7e70-8bf0-4088-a72c-08dbac7e0eb3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2023 13:02:41.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4941
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/9/1 23:04, Bryan O'Donoghue 写道:
> <...>
> 
> The assignment of pins 20 and 21 to blsp1_uart1 is not correct.
> 
> The blspX_uartY in pinctrl should match what is in the dtsi so assigning 
> pins_a above to blsp1_uart1 is not right. The dts name and pinctrl name 
> should be the same.
> 
> Your console is on blsp0_uart0.
> 
> https://git.codelinaro.org/clo/qsdk/oss/boot/u-boot-2016/-/blob/5343739b4070bcec2fecd72f758c16adc31a3083/arch/arm/dts/ipq5018-mp03.3.dts#L33
> 
> So roughly speaking
> 
> arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> 
> aliases {
>      serial0 = &blsp0_uart0;
> };
> 
> chosen {
>      stdout-path = "serial0:115200n8";
> };
> 
> &blsp0_uart0 {
>          pinctrl-0 = <&uart0_pins>;
>          pinctrl-names = "default";
>          status = "okay";
> };
> 
> 
> arch/arm64/boot/dts/qcom/ipq5018.dtsi
> 
> blsp0_uart0: serial@78af000
> 
> either that or  blsp0_uart1 for pins28 and pins29 - you seem to indicate 
> pins_1 => blsp0_uart0.
> 
> The two roots of the problem are
> 
> 1. Mislabeling of the uart block in the dtsi
> 2. Invalid miscongiruation of pins for that misnamed block
> 
> The fix should be
> 
> 1. Fix the labeling of uart in the dtsi
> 2. Decide on which pins gpio20, gpio21 ? are the right ones to configure
> 
> I thought you said in a previous email if you changed pins gpio28 and 
> gpio29 that the UART would fail if so that implies blsp0_uart1.
> 
> Either way the pinctrl and dts should agree.
> 
> ---
> bod
> 

No, please read my commit message carefully.

The Y of pinctrl is the index of pinmux config. So it can't be used in 
the serial node definition.

Please note that the physical port of first serial is configurable. It 
can use gpio20, gpio21 or/and gpio28,29. All of these pins are for the 
first serial.

Let's take the second serial as an example. It has 3 configurable 
physical port groups - "blsp1_uart0" (pinconfig name, use GPIO 
10,11,12,13), "blsp1_uart1" (gpio 31,32,33,34), "blsp1_uart2" (gpio 
23,24,25,26).

But the dts name of the second serial definition is "blsp1_uart2". 
Because it the second serial of the first BLSP block.

Same logic. The dts name of the first serial definition is 
"blsp1_uart1". Because it the first serial of the first BLSP block.

I think I need to introduce the architecture of these SoC. It has two 
BLSP block. Each BLSP block has several uart port.

So the dts name of serial contains the BLSP index and the serial index 
inside BLSP. But pinconf name doesn't care about it. So it use global 
index. And due to the physical ports are configurable, it need pinmux index.

The equation will be like this:

dts name of serial definition: "blspX_uartY"
pinconf name: "blspU_uartV"
U = (uart_number_inside_each_blsp * (X - 1)) + (Y - 1)
