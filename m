Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07DF7F2166
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjKTX2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKTX2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:28:14 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2050.outbound.protection.outlook.com [40.107.13.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43029C8;
        Mon, 20 Nov 2023 15:28:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUkgb7hrDrCA9Mi5MkYd2eLIK+fF8CvwWiLc3OTHqqfIkgngbVkTII7Z+zA2ocPeMGqHJqjBTAgfp7kcemW2n8DbBJS7RdlgNx3fdIxgklf9vPq/oM87IJSwloG1p296zbEoAKqWfOPodvy+7FvVq39dD4vav/ztC9Ul6kivbIpJzj3U/6QvwTSuNPCaNQ48haqwANfv7IANk2lR+UIxm5cdPa7FcvtKuOy+9hiDw2K3pOu8y0dRqTDVRk+jvmUkS5zxBZPaTP9uVdKi2oqIsDHr53xS8Sh67EWj7426xEN1rR8KHuyIRQnAVpJHnLAJQByRBO28g/vDZ89J7ggZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWXzyFR3inrBgZQhwIySphsu9tQrO21P9EJ3VyxhQnI=;
 b=hyCuFu0Kx3fFmAfn8UgTPRN5h0MqDeBl44QVN0F/g/nYhsjKkNi697dbQLD7rdifE1Myp/IOtm6+kpTyMP/260FhZYYtpfhnttHesfQuyF/JF2TNVHZ8f7p1pyHfHAo8tHuWnP0KbxNmG8Mw0bhPSzZm+GwVtDFXPgpQnZmFv/ARgvo1GBJuZnNirp4UQrKYA4uHhOWVKNAqW10T7zY/g7DdIV9Whd2bU5Nt+PCRNZ2Th5yAgLYU79BozOZZDH3jBPksvV+Jf8UOecfV0P/5fk1z3nMo2yS89FfuTod7sU6xLew0Er734Bj53KlvXUqZ6pRE6oIPKmyEpn6XuUOXMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWXzyFR3inrBgZQhwIySphsu9tQrO21P9EJ3VyxhQnI=;
 b=hsJW9DMMmzAKvfRNPrAHbKEnsPDSjOUaaVToNLAF0Rnk1Q1p8t/uLDPtXGkre4TFLKV7vz6BUmkmb1Nd+tr1NBDQmGjcyHOldVTqLg+EP5ey19v0B9HzFlmo+S1YHFVQ6GN+CpVSHH/AMTolGQcBK3+n82rScj6htxrstRkcxGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB1174.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:339::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Mon, 20 Nov
 2023 23:28:06 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 23:28:05 +0000
Message-ID: <eb1a1667-be1e-454b-aa80-d20b504c28f5@kunbus.com>
Date:   Tue, 21 Nov 2023 00:28:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] serial: core: implement support for rs485-mux-gpios
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-3-linux@rasmusvillemoes.dk>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <20231120151056.148450-3-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0414.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::7) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB1174:EE_
X-MS-Office365-Filtering-Correlation-Id: 08242c9d-8d96-4bf9-3719-08dbea2058fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9u3uLtBCwYrTY2/uxYpmEazwh91gAJTvESSMr1cmxraTNYjM9rafURNQsjjkRZsk4CKYI6coxYRDnNg9Ou3qtcMdJ5N+8vrvVO+W7NbWq26Uh7cLn9htiY0eqtaz2+P5cgMEMxCHcpDGUT/ESDGtAxf2N00dq/CKBnRfjy3IZuOTUv+elZCMkkw4GsZLRg1JQ2KmYaVQUHeoV+eUJpZxgSjC33eZDD9zQJunjxw+ALxtJMzEvcBWQe1ftZ9ZS/1cZfkE7sy/STW916bWzNYBlwz0pOT51D4mFaT+JlDDYYHWsF4g6WW+adRDa/Q0ipisofumIOSKi411XuGhSxy1ZNkfRD4tRMjet4ZvaMjk86QrXxGPPY2tsNwP+MuF3k/2qFa0HzTyJq8JRDstBDWSMjsCDfmG9WoBMn+pMZt4iB0eO44mflfsiv3Beps6MkhvNAMbx9Aj6s4P9FxCF0nVxV+WgizfOehlaBPshOJ29ZVmYoUDM49bqadW7vLsqzg8KVMZB9bHOPAh+AJZWBmoEIfnrmlnysnUdMykkM8Zi4XLCnD6DM64oWEgrp47zX2xauP5Y3xlRPCkydVZ/QQW3tEoJesgxulMFIsKYZIFaCxsVXKozwdEO97+sI4/7m7b/PpnSIEnb+ZlFmuLJn7f9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(136003)(346002)(376002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(41300700001)(36756003)(86362001)(5660300002)(31696002)(2906002)(83380400001)(6512007)(6506007)(478600001)(52116002)(53546011)(6486002)(2616005)(38100700002)(8676002)(4326008)(8936002)(54906003)(66476007)(66556008)(316002)(110136005)(31686004)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3N5eTV3T0t1VXVHWVc0eTBvN2hyYTlUK1NqaTN4TVhZT2owbnBBT1hJYlhu?=
 =?utf-8?B?aVBXZGtUaGtvMkpNTm4rQzNPOW1LaXIzaHJPb0xsZjd2eW5WbDArVXR3V3kz?=
 =?utf-8?B?VFZmQUliQ2RQTnNmS0xFbFRuR2ZQMkwxdlRBU0tjNTd1MzY5VnN2Rjd0ZEdl?=
 =?utf-8?B?dHFHMFIyOEVXUEtlTElpOFZwNHkrNXRHZEpQeXNjNHdZajlIR2JqVEhUbzNJ?=
 =?utf-8?B?WjloYzNxWkxKYzNnd2Jna3cyTi9RNmZ6NC93aXB1VEZxbmlRMk4yMVV2Zkht?=
 =?utf-8?B?TzdyNXphRVB3ZUhwYTRmdUpCSXNCT1RBZ0FhZFkxdHNZNTlRcmZyN2lhMWxW?=
 =?utf-8?B?QXFzNGxsTE1tbVBxMFZZeE54akVtZG1oVXF1cFFpQVp1RGlza0tpdkYzeXB6?=
 =?utf-8?B?dkZZcXZlWVRtVVRSbDdqN0lYWWJqbVc3NWl1ejF3aHQ0ZmtSa3puckdha2pS?=
 =?utf-8?B?NnMxS3pNcTIwekpPeTJmdnBZY3k0VEhzSFFxWlp3Z21WbjhYVXBVclBIUmxR?=
 =?utf-8?B?WUFnTnhFeXR5ZmdZQ1YvbXRsNkNlNmxlNkp6L3Y3aXlDZE9ZT1RuMngzeitI?=
 =?utf-8?B?Vlo2b2lSRXZ3SFcxRjd6b0diVlpwUWlPbmF4UUZWMi9MaEpZTlVCbmRjZEJj?=
 =?utf-8?B?L2xSc3d5cmZwempzRUxVeWJUSEVnS3JKT1RROTNSUDlFZk9yRzJjUUpKbjNQ?=
 =?utf-8?B?Q045MEUyNFRXT05yL3NjdDJNbE1kQTcvZE5FbE1uZVBqTlJwVzc4RHF2YXJw?=
 =?utf-8?B?bVRuQytLWXA3Y2FoeExncmkxMjlOUTE1UW9nZDBHQjNYcHFwbmd3U0NIR2N6?=
 =?utf-8?B?RTlrMjdyTEFVaEkydDR0VENrTGplREpaWlB5YWVYb25pem94UzdZS0M5R1RC?=
 =?utf-8?B?UnRtZU9YdGVzWFNsUFNudCtVYSt3d1B5RWMvaTl5bVczbGNsTXFUbFZGN2Z5?=
 =?utf-8?B?QzNuc0RBMEN4dXVjQlZDdHQxRlFjU1ZiTXJOazdBT1djTXdNQ0NkK09XRmVy?=
 =?utf-8?B?Wm1nejVCanVRU3QydzIzSEdKZjN5bUF1cm1sWHo5S0w4WFFwTHRKRXpOYXd0?=
 =?utf-8?B?Ui80c0FiSzFuRStJaFJSb05USnVkb3FxWHBOSXBCYnBsbUMya3FvaWNXRUE3?=
 =?utf-8?B?bzdycWVXWUd6TXArZVcwNE1SbzBNK2ZubUl4bnovVXFyQmN0WlphRjFSOG5w?=
 =?utf-8?B?Y00wbkxScEE4aFd4WHVyaEIrSVFneGZEc05wYmMvNndyZE80WGRWM3h1aU1C?=
 =?utf-8?B?cFY4eDBzTDdpb25MbnJIeGJ0MS92OTVIRWZ6M2JkUFRHV0YzdG5mMmVGYzBE?=
 =?utf-8?B?MHJHOThvVHdDd3BnR3R4eWZWSTE1U0hybU9wYVRBK3RqLzJLR2w4SHNhNGpY?=
 =?utf-8?B?bUNJM2Z3NC91ZU1UWUMvMzk4QjhpeldDUnp4RUlwbE9vc1BxQzV0YktZUzVD?=
 =?utf-8?B?UFJIR1cwQ1B1a2RFTFptbHhzVEgyaTluaDdIaStlSEp3UXBMMGdNWm5jdHYw?=
 =?utf-8?B?WlZKRml5RFpFOWpPU0RvNmxVTzhFbWhYemVLTE05eWQwWHZqL3kvMVhGSytM?=
 =?utf-8?B?aS9IWEVrbWM4dGZ6Nm5RQ1BMSXI5eTZJYmNaZ1BtN2UxNnJ3VUNpYk9BNGlI?=
 =?utf-8?B?dWVBdWVwZ1prWjdxbkkzQ1M0RDAxQTFPWmVoMi8rQlFGZjZwZHg3aGNkQUZG?=
 =?utf-8?B?b3Npd2xJUWJ1eXk1TVk4QlVNRDYydiszaDVnTHVGZWNTa0o3a1NmdDVGZ0VW?=
 =?utf-8?B?REF6ZXVLOW80RjlPb24zb3kyTGl6ZDhaK3Z3TXJGTXllZW50djVvckg2TDg1?=
 =?utf-8?B?SGR0a2F2cWJaWi9zdXlZTlJ3eG1ac2czTStPbDIrbllwOUNMaGQ2THNwUVBn?=
 =?utf-8?B?T1dxajJGM0s2MUxVdkRDcHdIUDhpaWJvd3BrcitSSW1NTytOYWErdGRJc0lQ?=
 =?utf-8?B?NVNVL1pxcjJGR3dBUTZkSElTUUIvRW5pdnkxd2tWSDZyZXpGK1FEU0s3dkZa?=
 =?utf-8?B?NTFxYmIxSUpzQVFnN2JqajNqcHR5c2hKbHVlSjhNM0ZsZzBlbnhFeE9xaVRX?=
 =?utf-8?B?Yjl0T1pWR09MVDZTdmY3YmpiUkxGZ1pGTXdXSDhEOFdudGs3UGxIdU05TWNy?=
 =?utf-8?B?ODluYW8vMWU5M0RnU3hJM3FCRSsydm5nTWZueFJERFJLTUpOQ011cTFnV2ZX?=
 =?utf-8?Q?QpRKt4eJbj/IapGeW0p7w8gSKxKL6A0zT+mlRSXroWyB?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08242c9d-8d96-4bf9-3719-08dbea2058fc
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 23:28:05.8460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuGAG451MdUGH/1bAZe+tO1q6FLRSmJC2M8mbwPkvS00enfZ/WFw7aPa5VkSHOGpM9MzCYsimJ+Pzps8chrHWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20.11.23 16:10, Rasmus Villemoes wrote:
> Add code for handling a rs485-mux-gpio specified in device tree.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/tty/serial/serial_core.c | 35 ++++++++++++++++++++++++++++++--
>  include/linux/serial_core.h      |  1 +
>  2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index f1348a509552..410b17ea7444 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1402,14 +1402,20 @@ static void uart_set_rs485_termination(struct uart_port *port,
>  				 !!(rs485->flags & SER_RS485_TERMINATE_BUS));
>  }
>  
> +static void uart_set_rs485_mux(struct uart_port *port, const struct serial_rs485 *rs485)
> +{
> +	gpiod_set_value_cansleep(port->rs485_mux_gpio,
> +				 !!(rs485->flags & SER_RS485_ENABLED));
> +}
> +
>  static int uart_rs485_config(struct uart_port *port)
>  {
>  	struct serial_rs485 *rs485 = &port->rs485;
>  	unsigned long flags;
> -	int ret;
> +	int ret = 0;
>  
>  	if (!(rs485->flags & SER_RS485_ENABLED))
> -		return 0;
> +		goto out;
>  
>  	uart_sanitize_serial_rs485(port, rs485);
>  	uart_set_rs485_termination(port, rs485);
> @@ -1420,6 +1426,9 @@ static int uart_rs485_config(struct uart_port *port)
>  	if (ret)
>  		memset(rs485, 0, sizeof(*rs485));
>  
> +out:
> +	uart_set_rs485_mux(port, rs485);
> +
>  	return ret;
>  }
>  
> @@ -1457,6 +1466,14 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
>  		return ret;
>  	uart_sanitize_serial_rs485(port, &rs485);
>  	uart_set_rs485_termination(port, &rs485);
> +	/*
> +	 * To avoid glitches on the transmit enable pin, the mux must
> +	 * be set before calling the driver's ->rs485_config when
> +	 * disabling rs485 mode, but after when enabling rs485
> +	 * mode.
> +	 */
> +	if (!(rs485.flags & SER_RS485_ENABLED))
> +		uart_set_rs485_mux(port, &rs485);
>  
>  	uart_port_lock_irqsave(port, &flags);
>  	ret = port->rs485_config(port, &tty->termios, &rs485);
> @@ -1468,6 +1485,13 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
>  			port->ops->set_mctrl(port, port->mctrl);
>  	}
>  	uart_port_unlock_irqrestore(port, flags);
> +
> +	/*
> +	 * The ->rs485_config might have failed. Regardless, set the
> +	 * mux according to the port's effective rs485 config.
> +	 */
> +	uart_set_rs485_mux(port, &port->rs485);
> +
>  	if (ret)
>  		return ret;
>  
> @@ -3621,6 +3645,13 @@ int uart_get_rs485_mode(struct uart_port *port)
>  		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-rx-during-tx-gpios\n");
>  	port->rs485_rx_during_tx_gpio = desc;
>  
> +	dflags = (rs485conf->flags & SER_RS485_ENABLED) ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> +	desc = devm_gpiod_get_optional(dev, "rs485-mux", dflags);
> +	if (IS_ERR(desc))
> +		return dev_err_probe(dev, PTR_ERR(port->rs485_mux_gpio),
> +				     "Cannot get rs485-mux-gpios\n");
> +	port->rs485_mux_gpio = desc;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(uart_get_rs485_mode);
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 89f7b6c63598..943818209c49 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -584,6 +584,7 @@ struct uart_port {
>  	struct serial_rs485	rs485_supported;	/* Supported mask for serial_rs485 */
>  	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
>  	struct gpio_desc	*rs485_rx_during_tx_gpio; /* Output GPIO that sets the state of RS485 RX during TX */
> +	struct gpio_desc	*rs485_mux_gpio;	/* gpio for selecting RS485 mode */
>  	struct serial_iso7816   iso7816;
>  	void			*private_data;		/* generic platform data pointer */
>  };

FWIW

Reviewed-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>

Regards,
Lino
