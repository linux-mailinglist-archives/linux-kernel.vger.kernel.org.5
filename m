Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A077A16F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjIOHKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjIOHKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:10:15 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2084.outbound.protection.outlook.com [40.107.249.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC14AE9;
        Fri, 15 Sep 2023 00:09:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChEZMMKCQ1ymLMak0vIHBMu5fWtBaDcHNeiRkhhnsG5ISmS6A1xxdOCVT9DRADOW/N9j9FIj7N0m3Ohx9OsSXTS9g8rqaKkqaHYXWAmxNek1mmC69m4oUUGa7iaCyHq+OQwRMj/zVmnb4f5OxbE6W3v+SrxMOM6LFP4R8bgJD4x1ilkfoqOPrwLsv0PMjV74SjT2711A0IAqzIKJ4oUEzV8k2q8Kwm7pPsxaT1RQN5nwzo6eNDkw2Sqc+ro0GGkT9bSOJ64rwZkaMKTELuy3lbHYfrhX6cnAQgGeCMxvc+Ifyt3f5SixfZNjO42ptrCsa8plcsdv1xT6wS6TsG7k4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgQJPxibwYt+0rQG5zZ66UFyepjE/Uj7PohTxTcaFQk=;
 b=h451RUXqQDO9AdYIbVOrz9bPuIiY2VAt5bJQTP+Fxk/QigEV040L1t0m40pMd4Zz7p60Vw8n0zTvNQihYzUece/zTUEYoyfLwSRhLxg0aac5n+kML85rqMYiNKkv4NXQdfhKx8Zl3UJ/+W/THw4j7t9ktJ2ppAIy1pfucZhcU12E8KpW52LcIKW3mR/KCr1ZVUP8a9ihsEAtA2+zddny6QNec4or6vLFq8J5U6SmQgV6LcAXogG8f8zTB1HjRCFEscVrhIKQAqdVBxl2ZMUkzuDp2zUoU2Aa7DApmGMlPIODPC3NdL9m06PmDfmWfSuSXGWblccHFKXmFE5ezrQZxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgQJPxibwYt+0rQG5zZ66UFyepjE/Uj7PohTxTcaFQk=;
 b=aFX7NGE02mc3bq4ToEHl1G4Dypba5k+7cvuSZZLEi4wORKHotObtOhCzaYhRxOif1Fe4wMI09k1rwXLIoyLb7hTSZ6bfXVcmG8ecLL9PRqicgO8yUENTKVVRWZF8h/j0fOCMHF6/Mwz0zc+0hbSxRnMfSdMnQvHtrpHwjocx1VM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB9194.eurprd08.prod.outlook.com (2603:10a6:20b:57e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 07:09:56 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 07:09:56 +0000
Message-ID: <0e43362f-83c5-fcdf-f18c-5815f9d4d98f@wolfvision.net>
Date:   Fri, 15 Sep 2023 09:09:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] usb: typec: tps6598x: add reset gpio support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230912-topic-tps6598x_reset-v1-0-78dc0bf61790@wolfvision.net>
 <20230912-topic-tps6598x_reset-v1-1-78dc0bf61790@wolfvision.net>
 <6566084c-2a10-45bb-b016-b1810d137351@linaro.org>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <6566084c-2a10-45bb-b016-b1810d137351@linaro.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: VI1PR07CA0257.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::24) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: a9763dfb-3bdd-428a-f57c-08dbb5bac463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUnL0cnxs9ogIhZyYVagwUudbh8DZ4ljzBkwzC2znH+DYKXWAcX/tzz3Ml1wTC5UV7sG1By3JAYNMLyLISADrwhCYJf8GtFF8X3H9p09sFmyYkKLq/1VQ/BsUyHKKmRrA/XrchErPVGtcaJ2GBnvcBvrLBHuI1kdUoJbZxL5//T5elVaMNMOOaQ4L40lO3wmH0GrHCtZRmzopceF77XknfPjtxaSFy/qlPIYbVvQplQl4KlIPLBBYCj/OewDJGgSJctIcbl9/QEV6Ru8mPNGWKnAGx51DeaUKeo2nnHYr5AgM3S91Fool1v1oku26+4ZqIKVSL70YyxFjn5odJ2wsTPHeAl6Ji1rBCUqvjgKh9VgLhj9iljcbtP6YhUiCGxWTsimNa6mDYxwqWjDagozmyCmgHdx2HLO91xyWKg299zaBHCEMAb8kIvnYjopNb+l1TpTdtee444j76y923ESjQ2PebZ1B3jTzLJhvfQ8j4K2roFUWXQWwBs6ONy3K48BpOV9NyG4d6lPgE1fpOZjbEQ7h9HAahbis7sATtDm8YyEyJKh3CXYrROzTbROd4t+v0E0/lfnnk9On/1NiJ9XrFjpUL+XVbGSZ27v3J5wXwdnJ1dcPHJbjLqPqbV4WxrxWScbnIx1pE7R7M18Y5K8Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39850400004)(451199024)(1800799009)(186009)(45080400002)(478600001)(966005)(8676002)(4326008)(44832011)(8936002)(316002)(110136005)(66476007)(66556008)(66946007)(36756003)(5660300002)(41300700001)(31686004)(86362001)(26005)(31696002)(2616005)(7416002)(2906002)(38100700002)(53546011)(6512007)(6486002)(6506007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0NQTU9ZTUVOUVdVSytyU0lzNXUza1VFSms5UzB0VFRrbU9PeXhDdXA4d1pD?=
 =?utf-8?B?dDlGZHNad1NZQ3JKWHFUQ0dnUFM2TytSWHhqbWdGbVJpTVpBUFEwTHVUSi9Q?=
 =?utf-8?B?dVgwSjlwNWlrYnJwTVRZWVJCcFNLQ1lmRDl5ei9nSkYzaTJTNUl6N2VLdEFO?=
 =?utf-8?B?Wjl4UVpPdDJoR0pBSnJCZy9Zd3VlWldRa3lrZVNiYWNWUXEzNVF1Y2lXNjJG?=
 =?utf-8?B?QVdiOGRFS0pXWnBpalJDdXdFS2E3WURXRVlvUzRrWUhiTEZCWkt2QWg2ZG1p?=
 =?utf-8?B?Snlrc2M5RDJUN2djV0xzNWkvbHRjUDRTSEh5UElQVnJHbUc1T0RaYktiMkZZ?=
 =?utf-8?B?MENId09jczErblB6bGp5ZlZjU0xXNXB6SHFwQm1NOFpFdUVkd1hsa3FtNjRp?=
 =?utf-8?B?NjFOYzRhNFI0cFp2akxtc3FXRXBFM2UyZzdjMG9FUGhMdnR6R3BkbHJ2TmVn?=
 =?utf-8?B?UWRRbUpHWjFQN1c4NGdIWkxGd0YzOFp5VlhwNklkSmRaV2QvenNJU1NJVTNv?=
 =?utf-8?B?b3ZjNHIyZlNSbng2ZFZyeW5DYlFQcGhmZGFVQVBwQmcyT2JWUWNxVWtjTE9N?=
 =?utf-8?B?Q2Vmb0QzVVdKcUxrOVVmY0VndGZsalRybGVoR0J2dnRGT2lEYkwyckJma2FP?=
 =?utf-8?B?OTI5MXBWdjJYS0ovWXBIVkdUdnZENGdtWXpZZ1EyZFRqRjR5Z1lrZ2tnNjV3?=
 =?utf-8?B?ZVlYOTY0UC9QR3J4NzRoMldXNVZOR3BzSHplMUZYWTNLbnJJdTdvbmVDdHdj?=
 =?utf-8?B?YVNHWEdSMDFiT3FEdGRYVk5WTkoxSUMxYWxKcmlMUU44OU5iZ1prWklwQk1Y?=
 =?utf-8?B?RXptV0Z3VElFZE9oM3ZtV09Zc3grYUJjSVV0R3o5dDhEbVp1cWdXeVpSWm5M?=
 =?utf-8?B?eFgwV1NxenVqVFk3NjI5Y29sQWJLQXlwM2NNRDdZYVNrMjR2WERUS1JybE96?=
 =?utf-8?B?aDQ3ZnljWUhCTjFxbEw3b29MRjhINWhUMWkxR0ZVdyt6MVcvVUpYQnpTcCtY?=
 =?utf-8?B?TlV6ay9VbUtZRm5idXNFdVYyaVZsT1NKVlY3bGNpVzdPanBacS9wajVqWGM2?=
 =?utf-8?B?NUNyZlc4aklVR2trcllwb0FvWUl6K2pFVzM3LzNVNkJlVVRtdysvcW1NWEZP?=
 =?utf-8?B?YWg0VkxjTzY0OGpybHFkV1lNMEJLZFJTZHRnMlVJWUlWYVFKaG5JaHRzakha?=
 =?utf-8?B?Rmx3WG1Ud3l5cGRQNWV1VHJrQml6ZzdGMWVFVzJBOHpCSDdsa05JWUtWOFJJ?=
 =?utf-8?B?VFoyc2NDZld0bElqYktZZy9zNU9Pc1R0WjczOGtNVG1XZDVNbFVtNDFPOUNM?=
 =?utf-8?B?R09Sd3I4eG5DU2M0ZTRFMC9LdmV4UW1Sc25VTXdKdEl2TklWSDFKMGtVZ0Zn?=
 =?utf-8?B?ZmRzTGRyaTFwRVZwTVQxbG9yWWJZZ3ZJblZwYzJ6WU1JNndISUNtR0dDUEI3?=
 =?utf-8?B?bGtGYm9XRG1CbWRzMXpKWlNuWDZxTDU4UU1Nem8yU0cybGtaMCt6cG9RQ3R4?=
 =?utf-8?B?dkVjSEIwUUhIRWtxVkdYZmc2bGpob0hMeXNIdDFleHB3RDRwRlVLeXFiVWY0?=
 =?utf-8?B?VUF4bVV3NlEyUkI4em5xVEdCeWkyK2ZkU01rWTkzV2J1NCtlS1NyUFNNYkZQ?=
 =?utf-8?B?L2xvUTB2cmNDdk50REZ2VktHcTN2Y0JtMzU2eGdUR1NYeW1OUzJFbWtteThm?=
 =?utf-8?B?c1ZBb1JWblFoK2U5RTl3ZzViSnFRT09UdmUzRDlETUczSzVmK0xQcFhsOXBK?=
 =?utf-8?B?R3JMdDFmdEhIWWQzbjJSTWVaY2EwSWt1MEFYck5aWWhoUTBWMGtjQ2pJbW5n?=
 =?utf-8?B?b0I3c1JkQmFVemtNRTh3bExlcU0vb01nV1lHSUs4WjZKZFpXSSswV1pRZDJq?=
 =?utf-8?B?Nm9lQVBFbkV6VnJlYmt3ZFJFa1BYTlRFQllLbnM5ZGlwdWV1VHNLSGJJeUlN?=
 =?utf-8?B?dnV0LzZta0k0RWhUTUJUdjF6dUJGVE5pVlJ1Ymt5dmZmQ011Qm1VcHJmdFlT?=
 =?utf-8?B?K0JCd0g4c3Jja0F5SjNVekNMNS9Vb2M1L3dieUNjQ1RQZ25FY0ZlMEVRT2NN?=
 =?utf-8?B?eFBtbXhraGcrY3kvV1RsYmpPOWRyQXhEUTd1UUlxNkhaeEhDdWx0SGw5NUYw?=
 =?utf-8?B?QU1qSC8vWXJWeHZxRzIzRkdYMDNra0gvNWI2bkF3TVRzb3lOTm0xS09DRHNw?=
 =?utf-8?Q?iXwNj0TETuEUGLR9DPhETAk=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a9763dfb-3bdd-428a-f57c-08dbb5bac463
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 07:09:56.7459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpSJ3vYBTJYQir6RxIUxZk/4OorggvNfpXDcC/wIcWsyokPogu9G90mM+Oiwd+pWl/V4kLgjoUNL/vXAEpXA1kDxIgqVn+G9ilf1c+qxJTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9194
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 15.09.23 08:57, Krzysztof Kozlowski wrote:
> On 15/09/2023 08:50, Javier Carrasco wrote:
>> The TPS6598x PD controller provides an active-high hardware reset input
>> that reinitializes all device settings. If it is not grounded by
>> design, the driver must be able to de-assert it in order to initialize
>> the device.
>>
>> The PD controller is not ready for registration right after the reset
>> de-assertion and a delay must be introduced in that case. According to
>> TI, the delay can reach up to 1000 ms [1], which is in line with the
>> experimental results obtained with a TPS65987D.
>>
>> Add a GPIO descriptor for the reset signal and basic reset management
>> for initialization and suspend/resume.
>>
>> [1] https://e2e.ti.com/support/power-management-group/power-management/
>> f/power-management-forum/1269856/tps65987d-tps65987d-reset-de-assert-
>> to-normal-operation/4809389#4809389
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>> ---
>>  drivers/usb/typec/tipd/core.c | 21 ++++++++++++++++++++-
>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>> index 37b56ce75f39..550f5913e985 100644
>> --- a/drivers/usb/typec/tipd/core.c
>> +++ b/drivers/usb/typec/tipd/core.c
>> @@ -8,6 +8,7 @@
>>  
>>  #include <linux/i2c.h>
>>  #include <linux/acpi.h>
>> +#include <linux/gpio/consumer.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/power_supply.h>
>> @@ -43,6 +44,9 @@
>>  /* TPS_REG_SYSTEM_CONF bits */
>>  #define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
>>  
>> +/* reset de-assertion to ready for operation */
>> +#define SETUP_MS			1000
> 
> 1 second? That's a bit a lot. Does it come from datasheet?
> 
I also thought it is a long delay, but when I tested it myself with real
hardware I got values of hundreds of milliseconds until the
regmap_init_i2c was able to reach the device. I also noticed that there
is already a timeout of 1s in the tps_6598x_exec_cmd function, which
made me suspect that the timing might be a factor to consider.

The datasheet does not provide any timing for the reset, so I asked the
manufacturer (TI).
The reply form the TI technical staff was that depending on the
configuration it might take from 800 to 1000 ms. I added a link to that
answer in the commit message.

>> +
>>  enum {
>>  	TPS_PORTINFO_SINK,
>>  	TPS_PORTINFO_SINK_ACCESSORY,
>> @@ -86,6 +90,7 @@ struct tps6598x {
>>  	struct mutex lock; /* device lock */
>>  	u8 i2c_protocol:1;
>>  
>> +	struct gpio_desc *reset;
>>  	struct typec_port *port;
>>  	struct typec_partner *partner;
>>  	struct usb_pd_identity partner_identity;
>> @@ -717,6 +722,13 @@ static int tps6598x_probe(struct i2c_client *client)
>>  	mutex_init(&tps->lock);
>>  	tps->dev = &client->dev;
>>  
>> +	tps->reset = devm_gpiod_get_optional(tps->dev, "reset", GPIOD_OUT_LOW);
>> +	if (IS_ERR(tps->reset))
>> +		return dev_err_probe(tps->dev, PTR_ERR(tps->reset),
>> +				     "failed to get reset GPIO\n");
>> +	if (tps->reset)
>> +		msleep(SETUP_MS);
>> +
>>  	tps->regmap = devm_regmap_init_i2c(client, &tps6598x_regmap_config);
>>  	if (IS_ERR(tps->regmap))
>>  		return PTR_ERR(tps->regmap);
>> @@ -892,6 +904,9 @@ static void tps6598x_remove(struct i2c_client *client)
>>  	tps6598x_disconnect(tps, 0);
>>  	typec_unregister_port(tps->port);
>>  	usb_role_switch_put(tps->role_sw);
>> +
>> +	if (tps->reset)
>> +		gpiod_set_value_cansleep(tps->reset, 1);
>>  }
>>  
>>  static int __maybe_unused tps6598x_suspend(struct device *dev)
>> @@ -902,7 +917,8 @@ static int __maybe_unused tps6598x_suspend(struct device *dev)
>>  	if (tps->wakeup) {
>>  		disable_irq(client->irq);
>>  		enable_irq_wake(client->irq);
>> -	}
>> +	} else if (tps->reset)
>> +		gpiod_set_value_cansleep(tps->reset, 1);
> 
> Missing {} (see Linux coding style).
> 
Thanks, I will correct this for v2.
>>  
>>  	if (!client->irq)
>>  		cancel_delayed_work_sync(&tps->wq_poll);
>> @@ -918,6 +934,9 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
>>  	if (tps->wakeup) {
>>  		disable_irq_wake(client->irq);
>>  		enable_irq(client->irq);
>> +	} else if (tps->reset) {
>> +		gpiod_set_value_cansleep(tps->reset, 0);
>> +		msleep(SETUP_MS);
>>  	}
>>  
>>  	if (!client->irq)
>>
> 
> Best regards,
> Krzysztof
> 
Best regards,
Javier Carrasco
