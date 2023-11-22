Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366A67F4531
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343937AbjKVL4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbjKVL4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:56:00 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D2E91;
        Wed, 22 Nov 2023 03:55:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ea5DxXu7/gjxXBfTJsc1GiiNDAVu1dtSIATgT0diITRcHQKFoaOU8MVzpnOTIxW2EcePzVuhPk9bwRUYMsNu07+tuHvp04zEi7RNdeko4Yf/rh9KL86Fy+Yn/izkIz5+EIiYqLFaFpUurOJ4kEz4XZWUc2QQhFrqXPABnETZ1ry3kmWpwNITE0MPqkvhsJ3TvgFPloLOrafe90q4zz8S8NDtVFJXhXgv2zvhiAM2VsQyL+xTBADRPbdH9J5+e4BlOl/dlYyMkZZSj/jpj+Nw71Od9kUJoQDwE4vw2ATaf/Qnw/mOPQovRa19nUe7N/jWv7HNE+5dWAxwnUHq7KjWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAZq1lqs0/i5JHU3+iZ2xT/hO6JGh13xOAcVSTw8Va4=;
 b=KNF+TU5Iw/bBU9EVXX6bxA8a6a0M1MIMaWvc39AUJhqsgYrGjIoRZsde5FH0d+F/Zmfq/q8+YONeTqRYZP7M0thZ98mdmcBzlW+s6RnBDThrM1QKn5DcJFTaRduaZjUQUFKfX8Tz2jPruPozFg9653z5t7NVC4PzFBmguxj6vTUuwJ6L8Y0qZDnsQ2/AZeZ5q2jY/sBSrxLDzsndewxIveL/KqAayfWT94QDrc0LyKmlk4Onc/N4a99rva4MlBm6aw/Tplri9ZSEjphjhq9q6wNjGHBL/TaBTnlEJIxa3mLLjkDbc9LuQtfxM8jW9ZON0rUzPUa0vztHPPxHdASF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAZq1lqs0/i5JHU3+iZ2xT/hO6JGh13xOAcVSTw8Va4=;
 b=D8eTDCkUM8m297oQsylbjrxzMCXZZuqXEjwiIwi2vkybgDBjesWmoN1nFdqmG1LOUQhAwHk1lkqGzzUeNZvFRKAtFYxynpp7dIT2LFWpIzPQiX3P7jMUpGRNOqx42xV7IirsuEFOud+02+Azx4gXCtNNNrG8btMRxiVhCV5wbWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PAXP193MB1904.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 11:55:52 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 11:55:52 +0000
Message-ID: <a2b54b76-01ce-4aa2-a00b-e65e123ba7e9@kunbus.com>
Date:   Wed, 22 Nov 2023 12:55:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 1/7] serial: Do not hold the port lock when
 setting rx-during-tx GPIO
Content-Language: en-US
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com, stable@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hugo Villeneuve <hugo@hugovil.com>
References: <20231119112856.11587-1-l.sanfilippo@kunbus.com>
 <20231119112856.11587-2-l.sanfilippo@kunbus.com>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <20231119112856.11587-2-l.sanfilippo@kunbus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0319.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PAXP193MB1904:EE_
X-MS-Office365-Filtering-Correlation-Id: 3198fe32-ef41-45c1-0acf-08dbeb51f9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTcgNzWOFz6neVuyNSKqs+kvjHE3oe5fPKFls8yWPXMpMrvDBRkOcYKfCTG2DTJYO5emVLfHWJ5eGO9Q8Jlk7r+DQbcBsPYKbXnM1vsVW/vPSafbRqhQU2cbNU8AwN3hn5fC2hrlMf+QFDRVc06lr1+N+/D9473hpqAER+wFlU5YfqsP8hIYNiIPorm90q9pdwD8l6Ao+WyZBQeawIwS0EPpA5JqC8w9iUpADWPW9KiR/RSv6GFrzoGeEWfn2oKx+E2QDyJdHr+MdyYZxJC74ml2hFeU0R3mSKJKUTKPWlNH7G+qyLhRoYS7PEUV6/yVwptlZgpzO65InQ9mwcvVDkOBTWumN+f/JnBllAyMuXA5v7Bt2zmphJBQGiY/yFfWhs1BT0nrqEoeCd9OGPeAuj+xsBmdL2vUE+myrsV/x+yvhyGVwqsgr/TJXglkSS/T/+UeyM5ORsluMcE62HHovGraRWGQvWyqoYbdfganv/cHdH0AQbwzPjprKjM+mGO9Jyk7AcAxDHUSz3Wgw8xj2FRsSTaain658SeA7L0tuXniYvZnDIoD6uphWQHN31VPyKAJkLm2/OxuJQQjFIunnKPP8CPux008si6DM8fa5z6SxjoCSCnhqqOfv4JQ4noyRcJtVXAqi8YNmz94gI7c0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39840400004)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2616005)(6512007)(6666004)(53546011)(52116002)(6506007)(83380400001)(478600001)(7416002)(2906002)(5660300002)(41300700001)(966005)(6486002)(4326008)(8676002)(8936002)(54906003)(66476007)(66556008)(66946007)(316002)(38100700002)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmVUUi84ajRnSWNIWktQSEo3MUNBOWd4M1l1eEtlRkVQRDA1L3JIN1dLQy9B?=
 =?utf-8?B?WTY3WGI1K3Y4T2ZhTWJpZWRERi92QXAxZEtTWmN4SkNQSy81VEpMMERWazRm?=
 =?utf-8?B?K0RlbkhNZEMyTzR5ZUtIakM2d0hlWUYvUFZ2eHNWOTluN0JZelNmSXdQSnJZ?=
 =?utf-8?B?WHg3c2JIbXVQdUdOc2dEeEN6WE1zcnRvME9BY2NEQWhaUmp0SWNGb0prWS9i?=
 =?utf-8?B?b0JCK0RQU1I2T2Yvb1VXdjJJbHFQa05yNm80b2J6NldoVk0reXJXK1Mwbjhv?=
 =?utf-8?B?akxncFZmRDlqbEJ1bVlzMWYzbFhMZ1FTYmhXRS90dmg2ZzN5K21BYUZFbFBK?=
 =?utf-8?B?dXp4eTNxQkhQM040NzVXK0ZCN1dVY2graTU0LzA2clpwQjFvTWkyR1VQNDd4?=
 =?utf-8?B?RGFiYU5ld0NSK0VVdjYwd2JTUlloNlIvSHNhdFR3RFUzajBEb2I4Wmx3dVpJ?=
 =?utf-8?B?RjI3WmFuWjhjREdjTG1ERW5yaThQWkM3Ky91NE5WYURhNUJBWTdmOGJyYXBF?=
 =?utf-8?B?ZDA3WGliOU1RS1hhQTFOUEVzSEJTZEFOSnZnd2VsQmNtYktxV2NmbHdvK3hC?=
 =?utf-8?B?aXM4U3JQRythcjZvZVNEazI1ZlNQOENVMHJyRUU0TFI0ZFB0bElYaVRVdzl6?=
 =?utf-8?B?WlAwOXYwWXk3N1lsOHM4MS9FeWJsMGR6STNtc1hoTXY0RUd4MVVmTlRaS09i?=
 =?utf-8?B?Q01PRmtCY2xWZnp4dzhpV2R4emlOMUx0RSt5eUhOY0g1eWgvNk9Jck1vd1Jn?=
 =?utf-8?B?T2JDUG5jWkR1SEtuNjlBcnRoRmtsaHNPWW9RSjlSZWpDNHJLYWVVV0FSM1da?=
 =?utf-8?B?TURtZVpiTDlVNFg4TFJkdGFtNk11Y3FCMDBNYkw5TVUyRlhuY2d6Ti9iM1pv?=
 =?utf-8?B?V002elczSzVvOUZXSWYrMnBFam0wYlE3MHVWUjdzUGw1NTd6MFExWDMrM1gz?=
 =?utf-8?B?aXhNWW1YM29ndjlnckRUTVYxWFA4RUpFWFVpcm56K1QwcjNtUXUwdkhnNWF6?=
 =?utf-8?B?VHZMVXZhbVRUVUpYaWp4OWNNWmx0Nk56OGI2T0JUek5vbkQwMmJCNG9JZ3pT?=
 =?utf-8?B?OVJ4cFFoRXdXYWxLdWNmNjk4R0ZxYjBrUWtYUHYyYjhRc1RIZyt5NDkwMEcv?=
 =?utf-8?B?dXUrd0hQMzZnRmJ5ZHI5ekFySkNFNFhOYTFmcDZOVWxqcDB0NG43cEM2L1Jw?=
 =?utf-8?B?NkNYKzdlK1doeDJiM3pTWGhBeXdWeC9qeENlY2ViOWJwVmFiN1lXMTZ2ZWFI?=
 =?utf-8?B?NzhEaEtTNkpKaksvWmZYZXNKOFZGczJNdjgyRk90U3N2RzFkM0dNWTgzQ1V4?=
 =?utf-8?B?SElZbjRUR3Y4c25NL3VFbjZ6NE1jSS9BdHRMbjREdSsycUN0cjdZVlEwNHMr?=
 =?utf-8?B?ejlldlVPZVl0anBqKzdnb3psYUxveUMwckJBZjJTZGp3S0xYN3huMSt0N2xq?=
 =?utf-8?B?YlQ0OFhGSlFNRy9BYUZTanA4bjRONGlMcmZRUUtmWXNYazN1ditlbWVLWTc4?=
 =?utf-8?B?a2dUWmEzeGZlOVhSQkw2cmg5M1dHRUpneDVHOWt6NXMra3ExNkNVd1NmcE5F?=
 =?utf-8?B?Q1BGU1BGTDhYWHdXN2NLL0NBb1hqczQ0TUo2QTg0cVhaa0xhL3Y2SFh5aE1G?=
 =?utf-8?B?WXNmTkN5TkdPUjBSRGRMV05lY3FkTkg3N1VRTUEzK1VZZU9MNzFnZHZpTHMw?=
 =?utf-8?B?dUMrNmNUVmd6YzN6MTJnQi9mSWxqbkR1engzd2FKRUhrdDlxVGRyUDlpK01L?=
 =?utf-8?B?dlpqVGRYMkdERHFMSnBQTy9UaGR3dzFYa0VackM2UWdXYWRmR2g5OER6Vytn?=
 =?utf-8?B?ZXVFeEF4QjA1YlNacFRYaFBOZjd3OU1kVWpiMFZuS3Z2ckJ3TlNPcHlnek1M?=
 =?utf-8?B?NmtJa1BXU21TTjAyUUdLTlRiRFY5ckU0TldkUUp6TXhLc24xYk9NeXZQMHdK?=
 =?utf-8?B?M1RQbmY5Q0lWN2VHVSsvNGNSRWpqLzB6VWw2VWlwRUM1ZTY0SUZmMVRuT2xS?=
 =?utf-8?B?ZWpnTnM5aEJVRjloamFKRWRvN0hyZHcyZnVnSG8wamNGTXU2RDAwdHRwOVZk?=
 =?utf-8?B?LzJYTlpGcW1WbGprTjdqNHQ2YTBGaGtpaDZFZDhzbWcwNkFUbmV6dVRNbUhU?=
 =?utf-8?B?THMyL3hYSVNnbFVXdHBOckJYQmZRaWVwMUxrczlsYkwyTmRULzdkdVVORW4v?=
 =?utf-8?Q?nElebTolCb05y027JlSNR+2PlLt+s475tRaZNxx5FVyc?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3198fe32-ef41-45c1-0acf-08dbeb51f9d6
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:55:52.1313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFKH903Erm6MHz98StTZEyK1yCGHIaGpsfKunYuhlZ0EI/boCpX9/UCJ/2feEHJscf8lz1a9Sbt5rX6taa8vMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1904
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.11.23 12:28, Lino Sanfilippo wrote:
> Both the imx and stm32 driver set the rx-during-tx GPIO in rs485_config().
> Since this function is called with the port lock held, this can be an
> problem in case that setting the GPIO line can sleep (e.g. if a GPIO
> expander is used which is connected via SPI or I2C).
> 
> Avoid this issue by moving the GPIO setting outside of the port lock into
> the serial core and thus making it a generic feature.
> 
> Since both setting the term and the rx-during-tx GPIO is done at the same
> code place, move it into a common function.

> -				       const struct serial_rs485 *rs485)
> +/*
> + * Set optional RS485 GPIOs for bus termination and data reception during
> + * transmission. These GPIOs are controlled by the serial core independently
> + * from the UART driver.
> + */
> +static void uart_set_rs485_gpios(struct uart_port *port,
> +				 const struct serial_rs485 *rs485)
>  {
>  	if (!(rs485->flags & SER_RS485_ENABLED))
>  		return;
>  
>  	gpiod_set_value_cansleep(port->rs485_term_gpio,
>  				 !!(rs485->flags & SER_RS485_TERMINATE_BUS));
> +	gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
> +				 !!(rs485->flags & SER_RS485_RX_DURING_TX));
>  }
>  

Rasmus is about to add support for another RS485 related GPIO (see 
https://lore.kernel.org/all/20231120151056.148450-3-linux@rasmusvillemoes.dk/ )
which has to be configured both before and after port->rs485_config(). This
does not fit very well with the idea of handling all these GPIOs in
one function. 

So I would like to revise this patch and send an updated version in a v5
of this series in which the suggestion from Hugo
(see https://lore.kernel.org/all/20231011183656.5111ba32ec0c9d43171662a1@hugovil.com/)
is implemented to use separate functions for the GPIO configurations.

Regards,
Lino
