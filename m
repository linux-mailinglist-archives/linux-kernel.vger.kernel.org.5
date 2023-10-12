Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7069E7C6C21
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378204AbjJLLRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343649AbjJLLRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:17:33 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED71290;
        Thu, 12 Oct 2023 04:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gg+/d7GIWZum+THqzNzqJz1AYR/U6EZfB5YWWpMxa05/tcwSZnwFPjrLtQUI/7O4Griz8WDiu5203vmHbmJQ/GNWLCdrG21aiUBFAQ2jmqZ9j9uNvzzP4OOIaacP0GHpAiTdbcCIy1+qE+PUPVNC2MmDIzHodF3uyVKUu3hqQFDOxoC0SIh3g6c4uCv4ymy4XHdlq+9hWRyVJ6pWXKkhIk3UdcZqz9maRv/XAi3AtnZvNGSC1H+N8NepnJzObV3NycQkLwMEQ52EIEYZZoc5FJ5H0dWiMYryZgSqnJBw27aTZ/Z4YGKRMQLYzTjbizqRjmGVtzDaSE0frFM6r39/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSYP/kBuVCWvXlYg+f7YZnvip4GVPZpHUJQwzxH0iAI=;
 b=TWrSCm8zoAQSFiK/kfUPCRLVJg/mjr0zeI4i44j4hyzAifBNzph3Q8hx//lev8H60hV5w0aXBmEDCJWzqn/7oa4e00N6Md1FPZo8wJFpACzPsKnit6vS/2O7nJDptI9hm05h/MLkehXY2rBc3qaDg/hOFxeEcI+UBokTKzhrFe4ktNZUhQ8ibRqXEhGMtIJCq8vLemSe94IhxQZxlyPSpHqwYz7IvdSsc5UpjuddGwVCbjHoHPqQo6ldh5BI704xQ1cR/rhyN5U3Wvx6Kh0P1TiFfT2k+hc/Xqhwef5IGnwuhVJ1eH9SR64FV9r3ztrCns239XTVEY73lozINWDFJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSYP/kBuVCWvXlYg+f7YZnvip4GVPZpHUJQwzxH0iAI=;
 b=CXo4d9FS0v+xxqqpa3WFYVnZw3HJS4IbqVjhNc5/VmZis9QkacntRoJ3L2LUltg9A50sNhT1FwKpob7fLwnwKhHLdRc3KMGGyYTOen5llmvGzzbU84dboh2dcJReNc1uJzydw1vssIwCwLonb9Tme3vcZKj1SF2vIiHPgFi6qZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB2349.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 11:17:28 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 11:17:28 +0000
Message-ID: <9166bf7e-0c43-4fdb-9c8c-67e3d86c1d3a@kunbus.com>
Date:   Thu, 12 Oct 2023 13:17:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] serial: Do not hold the port lock when setting
 rx-during-tx GPIO
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
        stable@vger.kernel.org
References: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
 <20231011181544.7893-2-l.sanfilippo@kunbus.com>
 <20231011183656.5111ba32ec0c9d43171662a1@hugovil.com>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <20231011183656.5111ba32ec0c9d43171662a1@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::10) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB2349:EE_
X-MS-Office365-Filtering-Correlation-Id: 00074726-485c-4cc6-879b-08dbcb14d169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5kGg1dp0umogajUNyV7HzmLgCDcNg76+KVouYGm/968LLoiE8Ocl1QgvsnNZytyJ00cGM4IV8Q2OsHmuyBrMAWAjprtemEmARRi4jZQLUTJ+KMYwwYjXfzk/22MYWLDEGI2QfPfNB/k+Ybu5/OmQVjb4vVUzJTW4ZdvE5MjTf1L6ZWksRFFcR2mC/f8b8KyiVt/k6bmhu6tp+xegaBgW7sCfRJRlIKBbWxYZP6CYeehX3ovYiqbM3d4Z4lpliHV+cqTXptFyjGii1qAXRBSis/5Pdj6cLn/5mEIRA87lVBtUSLQ8TjzIiw4srRE4pRaO1QNfGsdv3KczvFAXXngVKJ4iQI/o/sbf9AAhUakY2TZqaWCCA3ABra3prREUv5aYNaMcokLukKyjAAca/rc2KXguYo+efv3bA3McibmhXJyKUMF+R7YMc0A0rHbgjmTcVDjc4Xt9d2lRwn3XIw7s+eanrPNPMVy/AHsI812qebMjaAMwvq74182NBmv8xig04i2Z03+uB798NUkJQjtoCZyy230XWoUkN7P7eU022D7pnQHLhRLKgLc6Jciiq3Fvfhv5iNS/UF7IVk42SFlV+Y8QIeueU4OMqmsPYRO+/KNEPxs9PIrvb1QzDGcEQ/i+VSUlHxJq2RXmI02PF6PsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(136003)(396003)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(6512007)(2616005)(478600001)(6486002)(5660300002)(86362001)(8936002)(8676002)(4326008)(7416002)(31696002)(2906002)(6916009)(316002)(66476007)(36756003)(41300700001)(66556008)(66946007)(6666004)(52116002)(53546011)(6506007)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WC94b2Y5UzJOZk9HZWVKVEgyd3pIb0dTU21FSmpIa2o1OFpEazNlcUluYmZN?=
 =?utf-8?B?dk1wSzFIWmNBemErQnNkTktHQjZtRGo3dHlHcVRxMytIalJIQnFOdVVVc0xq?=
 =?utf-8?B?Y090NXdzaFN0OWtkUkt4bFF6U3phaGdrT2dudTYxNFVqbms5cEFHZE5HcXFN?=
 =?utf-8?B?MjdiQjhXZlB2RUE1aW1nY0xCamx2bjg2OFdSTmtlUS9pUlEweDN4a0xWelpN?=
 =?utf-8?B?WU8zWG90Sm9ORS9sLzkxNVQxQjNsTHRGSjZjV1g5QU9OdGZoYkxFdEVUR2lO?=
 =?utf-8?B?NWVJbkVlVEtRa2hReUtFMEorQWJ6WllNc3pNbFBORUo1WjZnRnlVNmFTNGU3?=
 =?utf-8?B?MGpsRFRsM1ZPcjZHS0NpQ2s2MThNUmowcVk0OU1DOWVVMWNvWTYrVzU3SmZx?=
 =?utf-8?B?eXpPMEM4Uk50MXNxaVFLdE9RRDJyMEUweWxqY0pvNG1yZXRZYkhSNFp3WGlC?=
 =?utf-8?B?R2t0MElyVEhEMnpWeFR1TEpPaCtmc3lQWTYvcjJUb2ZvQVhFbU44REZ3Z2xZ?=
 =?utf-8?B?SXJuVUFFckxWOVc1U3RGSnhaY3cvME14TEpmeVY3MW1PNGZMcnlBTlVaSUZm?=
 =?utf-8?B?UU1jcWRjTnk4eUVuTG5NZWhlQ1VINUlwS3BMTFBIRFVSb2ZXQW0reTR1cWxZ?=
 =?utf-8?B?UEVmcTV2ZTQ5NEtzb1BtU0x3Y3pVS3ZBdmlyMlBCQmp4WEFPZ2NBZHhzQTJ1?=
 =?utf-8?B?TkRyNm9DVUNjT2ZNYURuRitZTXNXQitKM0xhb3pwSHFSWDBlUGdsRTJGS09P?=
 =?utf-8?B?QWdaRmd2Si9Ja1Zlblgwc29tQVJEVVV1cFRpekZHN1RobFNCTG5laW1Obk1s?=
 =?utf-8?B?YWZKVE45c21jeU85N1RKODZjRzFhakgwQlpXajA2aWhyQW5jWDN1ajA3UURU?=
 =?utf-8?B?Q0VreU5aYmUrVVVmZkZHeWJ5TlBkZUJ1TWVLVzE1bXM4a3BoQkVJQVdBRkJu?=
 =?utf-8?B?WW1LcEE5aUNlbmVieEVabGhMNVF5WmtVdi9lNW1hZ1VXT3lzN1d5SHlVdUlN?=
 =?utf-8?B?NE9QOEdvYmp0NlR3d1d0QlhKc1UweU9kTjdxNUtQVlB3WmcxQlFCOUFrM1Rr?=
 =?utf-8?B?MzUrNEdwUjR0N2g2VWRUTmR1SUpSbG9BbW5MdHdjREtGbFNxcXFIZVAyWHNv?=
 =?utf-8?B?WncyOGNTY3Z3WmxUbXYrT3FCdmVhTVcrcTZsbmF0cjVSUDBRb2VvUlBuT2lN?=
 =?utf-8?B?Mllwa253b3pjemVjYmlZbEZOV0xNTWxvTlZQT1dOa0NHZDhDTExqTTgwNld5?=
 =?utf-8?B?WVlsM1VRcENnK2FTQmtQeSsvSk9jQ09pQTNFMFNBenloc0UvUlVZNUF2Mm9Q?=
 =?utf-8?B?dWZydm9lRDBHdUN5L2N0UDVjSHdvZkhoOFFEWTVLYjd4VlVOTFNIc1VRMi9U?=
 =?utf-8?B?YlJqS2l4ZGFWdWYxUEljL1h1RU44YjR0MmF2cDhSWEM5d2VPNXAwVWdReWs2?=
 =?utf-8?B?VDNyRHg5NXQwaE1pQ0pqRncyTVlSVE5nTHNraUxRdDJObGRaU1NvbU1xRVA4?=
 =?utf-8?B?VzhFbHFhb0RNdTNqTHVZM2JiL3FFN3NhMnhrd1k2eTB3Yk41bW1qLzdVSzBG?=
 =?utf-8?B?YThza3ZueVdYQlhaK2lnZE5LdlhkaWJ2NWxmRFRsNUJkSW4zWDBlRjhXZEo2?=
 =?utf-8?B?L3lIMitXTm05MFdoU3VMRzRjclMyanphYmVGSnFmT0h1TzgrQnVrTEZYV1FB?=
 =?utf-8?B?R1lZaGN1d01oRkxwajZUNTk0N0hjTVZ2UzF4S1o2Qk1YbktSV04rU2xxMDE2?=
 =?utf-8?B?emVHVHgrOFh1dWRTb2U2NGlOU2ZnTmRzYnlHQ2FPbllhdThaemxhK1pCdTlo?=
 =?utf-8?B?MW9XQVo2aWtwZWJVZ1pUZ1RScjdQcXY1bjBJY2t4R1p2bUQ0dEFtQmRtVEpj?=
 =?utf-8?B?R3ZsNisxclJvNDFkZHhlWFZPZGJLeTYya29ucm9OREVsTHlwR0hPbnVXT1Uy?=
 =?utf-8?B?WUgxMmVSWFpaRlBPUHg3RkVFQ2MwK1VjZXJsRWYyczdSbnA3S2Izbm1ZRGVv?=
 =?utf-8?B?ZGxwM3pXYU0ydnJvNVM1bW9SRUJGQTlLNnF6YUxyeDZPME42OHYxdG5IZFN5?=
 =?utf-8?B?VS9rWEdXVFlKNHl4K1F4aXQwd21Vb0ZUcHE5MlUwZFk3d1NEWmt5cHRxTWJB?=
 =?utf-8?B?bmtQT25GM2hVMzFxRE1UMnFYMzlDZjVjV1YzL3pnblk5T0xvVnRSYTZkL0Nk?=
 =?utf-8?B?S0pkcGFUN3I4N1dBSFJBWCtGeklSM3JjUkVWckxCRU4reUpCaXVTci83YWVo?=
 =?utf-8?B?SG9pbjFKNnFPSVM4UWIwS0pTMFNBPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00074726-485c-4cc6-879b-08dbcb14d169
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 11:17:27.8623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUvFdAcAXt+dYnmmxGZ/Gtxgfrr/yk82noYcob42tMwoom8LaamJ82RGnyCsSbxZFXdXVmgXFFNbWkmFy6arsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2349
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 12.10.23 00:36, Hugo Villeneuve wrote:
.
> 
> 
> On Wed, 11 Oct 2023 20:15:39 +0200
> Lino Sanfilippo <l.sanfilippo@kunbus.com> wrote:
> 
>> Both the imx and stm32 driver set the rx-during-tx GPIO in the
>> rs485_config() function by means of gpiod_set_value(). Since rs485_config()
>> is called with the port lock held, this can be an problem in case that
>> setting the GPIO line can sleep (e.g. if a GPIO expander is used which is
>> connected via SPI or I2C).
>>
>> Avoid this issue by setting the GPIO outside of the port lock in the serial
>> core and by using gpiod_set_value_cansleep() instead of gpiod_set_value().
> 
> Hi Lino,
> it seems to me that both drivers were already using
> gpiod_set_value_cansleep()? Maybe update your commit
> message if this is the case.
> 

Right, I will fix this, thanks!

>>
>> Since now both the term and the rx-during-tx GPIO are set within the serial
>> core use a common function uart_set_rs485_gpios() to set both.
>>
>> With moving it into the serial core setting the rx-during-tx GPIO is now
>> automatically done for all drivers that support such a GPIO.
>>
>> Fixes: c54d48543689 ("serial: stm32: Add support for rs485 RX_DURING_TX output GPIO")
>> Fixes: ca530cfa968c ("serial: imx: Add support for RS485 RX_DURING_TX output GPIO")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/tty/serial/imx.c         |  4 ----
>>  drivers/tty/serial/serial_core.c | 10 ++++++----
>>  drivers/tty/serial/stm32-usart.c |  5 +----
>>  3 files changed, 7 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 13cb78340709..edb2ec6a5567 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -1947,10 +1947,6 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
>>           rs485conf->flags & SER_RS485_RX_DURING_TX)
>>               imx_uart_start_rx(port);
>>
>> -     if (port->rs485_rx_during_tx_gpio)
>> -             gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
>> -                                      !!(rs485conf->flags & SER_RS485_RX_DURING_TX));
>> -
>>       return 0;
>>  }
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index 7bdc21d5e13b..ef0500be3553 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -1391,14 +1391,16 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
>>       memset(rs485->padding1, 0, sizeof(rs485->padding1));
>>  }
>>
>> -static void uart_set_rs485_termination(struct uart_port *port,
>> -                                    const struct serial_rs485 *rs485)
>> +static void uart_set_rs485_gpios(struct uart_port *port,
>> +                              const struct serial_rs485 *rs485)
>>  {
>>       if (!(rs485->flags & SER_RS485_ENABLED))
>>               return;
>>
>>       gpiod_set_value_cansleep(port->rs485_term_gpio,
>>                                !!(rs485->flags & SER_RS485_TERMINATE_BUS));
>> +     gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
>> +                              !!(rs485->flags & SER_RS485_RX_DURING_TX));
>>  }
>>
>>  static int uart_rs485_config(struct uart_port *port)
>> @@ -1407,7 +1409,7 @@ static int uart_rs485_config(struct uart_port *port)
>>       int ret;
>>
>>       uart_sanitize_serial_rs485(port, rs485);
>> -     uart_set_rs485_termination(port, rs485);
>> +     uart_set_rs485_gpios(port, rs485);
> 
> Suggestion: define a new function to handle rx_during_tx, to keep
> uart_set_rs485_termination(), which is more self-documenting than
> uart_set_rs485_gpios().
> 
> ex:
>         uart_set_rs485_termination(port, rs485);
>  +      uart_set_rs485_rx_during_tx(port, rs485);
> 

I admit that I do not like the function name uart_set_rs485_gpios() very much. As you said it is
less descriptive than e.g. uart_set_rs485_termination(). On the other hand the two functions you
suggested would always be called together, which reduces the benefit of having two separate functions.
Plus they are nothing more than wrappers around gpiod_set_value_cansleep() with the same additional 
check for SER_RS485_ENABLED.
Let me think about a better name first.

Anyway, thanks a lot for the review!

Regards,
Lino

> Hugo.
> 
> 
>>
>>       ret = port->rs485_config(port, NULL, rs485);
>>       if (ret)
>> @@ -1449,7 +1451,7 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
>>       if (ret)
>>               return ret;
>>       uart_sanitize_serial_rs485(port, &rs485);
>> -     uart_set_rs485_termination(port, &rs485);
>> +     uart_set_rs485_gpios(port, &rs485);
>>
>>       spin_lock_irqsave(&port->lock, flags);
>>       ret = port->rs485_config(port, &tty->termios, &rs485);
>> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
>> index 5e9cf0c48813..8eb13bf055f2 100644
>> --- a/drivers/tty/serial/stm32-usart.c
>> +++ b/drivers/tty/serial/stm32-usart.c
>> @@ -226,10 +226,7 @@ static int stm32_usart_config_rs485(struct uart_port *port, struct ktermios *ter
>>
>>       stm32_usart_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
>>
>> -     if (port->rs485_rx_during_tx_gpio)
>> -             gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
>> -                                      !!(rs485conf->flags & SER_RS485_RX_DURING_TX));
>> -     else
>> +     if (!port->rs485_rx_during_tx_gpio)
>>               rs485conf->flags |= SER_RS485_RX_DURING_TX;
>>
>>       if (rs485conf->flags & SER_RS485_ENABLED) {
>> --
>> 2.40.1
>>
