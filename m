Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C583C7A1BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjIOKIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbjIOKIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:08:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF232270A;
        Fri, 15 Sep 2023 03:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqVa4bLxXyLv3icjCnNw9Omru9vg34IZpci2f4MSFzydUaGiHzB+Rm+rH3UVMxbTMP7npmasfvVAPOY+J5iCHxRu02QU6mLkkgg0Rz6natGf4f731KlyIR+vyDUXFZmWCAWJeye5kUCynsMJQeqOUXozGB+cl+0ZZ+NBXI9rKhBeRgGwVy77jgdvSo+Vsn+Rt0tV+eNaWl5UmrRtmiqp+7sweGt55bgMBn1Tk9LpJgO5QmjCF830vKumNW28v30wplZvdv1WgoWEGobEOu3pM0ssAZkGWh+sN89jvpVc1OjXUY72v5A0e69IwKvtkXwXJx6gkspwnLA2XdE0+D404w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE79vswRL1hg9ZdUEe31k3NBndjXKQo2itn/pZQYKJE=;
 b=bB2AamJjrRqtK0AjOX6ONywozmegvrEpxI9K6jiAuvIvdPsIDPiHDL+OWKlMcYTGiQaf8v1BkJ6teY1zrjIPb+HHg2GlIPEhooIXusYWf9Jmi9Dvgm7X3yyxbNRWBs8l/QzY16CkpMJoSHhHCcf+dX/6vJjzg3ZaC2NjA0cQkg/qg4UHycTLiBjaDgkp9SixWhCgRflacRVHP3xXVIRNvYAKuQNDOmHeDj4Q97+ksdwN8jRuyoXz3w4qzg6Xs5utA9lw5LGAJmiczrae8U9zqLUgeLKSVaVrE5G7GE6UrVAWm+DGZjeqcSAT5ianoNyMkG4zVsJjYpAF+JM39k+Jnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE79vswRL1hg9ZdUEe31k3NBndjXKQo2itn/pZQYKJE=;
 b=HkltraDiAQ5qFvOPq6p9aCm+jpE3Kccnh6hPnTAahqgt4tb9Ysho3A+NCL73HtTMW7GlFDdKgZPDqOVUq+TMWpUshmkaG6mz3Z21SkUM/5bhGQBtqFim0QF2byh+irRRxWxCigvqhBDyBcOAEDyvNK/fkcnY71Dw2BvRsLKhPoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM0PR08MB5412.eurprd08.prod.outlook.com (2603:10a6:208:186::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 10:07:10 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 10:07:10 +0000
Message-ID: <f3184a12-fd2d-1812-e196-c3e59e841632@wolfvision.net>
Date:   Fri, 15 Sep 2023 12:07:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] usb: typec: tps6598x: add reset gpio support
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230912-topic-tps6598x_reset-v1-0-78dc0bf61790@wolfvision.net>
 <20230912-topic-tps6598x_reset-v1-1-78dc0bf61790@wolfvision.net>
 <ca9075db-de92-4545-8c47-d6c292d57ad9@linaro.org>
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ca9075db-de92-4545-8c47-d6c292d57ad9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0054.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::43) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM0PR08MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f59c40-5ea9-4bdc-3513-08dbb5d38677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsulht1qRpaFJvNnd7IpDeQeZ6n21GW2K1osHGQTzz4/FTTc/PoTIJ/E7LA/Y9UL4NXw+5GiaOb/uw0AEOgzzxhSYzEb33jiOg2a7rBvMancZf2WiYMjxB5hcsaaaw4swiloWauWcA86aqDPFxaAzvAue5M9uAlFV8VKvjCAjYGQj5hmcZ4P85FhIHsPSXGugTJFGPT9v5msU26I2vhxm9qGdcYDCdlMmsJrIAkgcaLA86RM2JCJCbjgiwnmcq1TQ6Pbqlk3lzX5rcoH/O4VHwMDlOz1lh4zkRzZ/L8P4tbZBEPzqMWsv+fyQPjjB+XPjznwfOF5yrmC8nJRZdpf0Zx83orT/4khZVcHPned64EH6HW/TeP20y/0u9Esbb6GRUVAgHHbw7OFmcyDotLbjZLRuLybVXI/MgG/xXjZ7gLWOHz0Dd9/fLHBkRu76dne7iQHCitV0c52kvcAo/gQbJ9BWGx77FAG2xQi2l+809g9yvBXZb84fzMxRM6GysZMjon99wpm9DIhs0170GUFyniaz332IJ5a/S1IHe7P8OrHoyncJaUXOtppUsZp9D7kmMcA/Lwey2oy04on+BfQ9Xc+ExItAaoeFjL3FBeklySgbXvmp36YGeIqNOs6EXJoyzhuyn69dRKn7kgJnXWa2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(39850400004)(376002)(186009)(451199024)(1800799009)(5660300002)(316002)(41300700001)(8936002)(4326008)(8676002)(38100700002)(2616005)(26005)(2906002)(53546011)(6486002)(6506007)(6512007)(83380400001)(966005)(478600001)(45080400002)(110136005)(44832011)(66476007)(66556008)(66946007)(36756003)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUdXZjRQUWFxdTU1ckY2enhrVCtUZ0gzM1NzaVBidWV2S2R4UmhzWUdKb1I5?=
 =?utf-8?B?ZGNmU2x0TmwyM092a04xM1dwaE5SRGlJclVYZk80SkFZQUs0NlVkUDNDaG5R?=
 =?utf-8?B?Vm1WbzNpMk1yNjlkT3B2U2VieEtrMTZRU1F1Z0UrYW04L0xkZ2ZtRDY2TG5H?=
 =?utf-8?B?WlA4MFYxUGN0Yndvd2ZMVit5QitybVMwSGphcmtSa280ZXZmeWFleTF4Y3FH?=
 =?utf-8?B?cGpUWU9oZzNiczJpcXFUUVhZclVLa3V3ZldXUFJZWko3TnlueXJMcDAvYkJW?=
 =?utf-8?B?djRMSmpMRmRoMlZmbWxhajVXcFFTMldhYTBsQkFDUk0yWkptQjJoQzZOanZ1?=
 =?utf-8?B?bzcxanFwTXFwUlVMblk0NXEwQ1RIWm9zR2RLeVhUcjB3TkZTUVR3bFRMcnlq?=
 =?utf-8?B?OVZ1Vy94SU5GUFgycGpmcVpLWkJlMm11U1E0ZllNNmFRYTVsdHI5SXY5Z0lt?=
 =?utf-8?B?WTJGSVcyUWFvRHpvT0svRXZiLzRhWG54MVN4MUF2MUMxRktyOGJXTWNYbkEx?=
 =?utf-8?B?SmxYRHN6Mkk3dGN6THVILy93VjBndHhxOVNrM0t6Mkl4d2xXZGtVSXJFa1I3?=
 =?utf-8?B?VGVWR3daRGE4WXBrUEo1NHRTdUNCNU9LcGZvU1ZCQTJKZm12VWtPS0FubDJ2?=
 =?utf-8?B?N2Vnc2FHaGFEMldBL0ZwcC9XRzJmRjVnMzFla0MvYkd5VDFmTGovVzFjbmQ3?=
 =?utf-8?B?R1piRmV0ODlUYmVhamFhQmNINjVOeDhzVmdtL1VPUGJRdVVyMEo5WkM5Qmds?=
 =?utf-8?B?SFdxelZ1QldtN2U1MldiKzFkMWVvU2hBWVR6bkkwblFZRUsyc1dmejVCNzhh?=
 =?utf-8?B?QXEvdEsxNFdkZTFlN2FIdkhUVmtqVGxnQkYyVWlyMmVobnV3Qjl6Rk5QampP?=
 =?utf-8?B?TzdxbDdBelVORCtBTnhVdmZDZUVlQlEvcEV0OXJWT3lqSDRHVkRsR3lBNU5R?=
 =?utf-8?B?UVBzVkEvZEgydStYVDFBYldQTmJmbGc3bHJaNERUT0VkS2l4TmkxS0M5ei9R?=
 =?utf-8?B?eXFBTmFWV0FmRWEwWnNhckc1THV6YWkzU0xtV284czF0TU5qQ2dwQlJuSURI?=
 =?utf-8?B?WWpBUWw1S0V1VnNWSkExNSsxNlBPMFNXK0syRDBXdDlodkFjRTVUdk5lcXRh?=
 =?utf-8?B?Q1hmMFRXdzR5cmRVQ2cwdmJUc0g1bzBJY3JpU0V6TkdlZHIrY2F5ZW53d2Ur?=
 =?utf-8?B?UXlUVlFCREtZTXUwMmdHV0o1MUIrRzBFc24wQWdHM3lGbUh3dlM5aXZrMVlx?=
 =?utf-8?B?ejB3WDhoSHhWUEEyOUYwQUlSYVQ5Y2NQT1pYK2lBZGlVSXJWWjZxdVFkTUN3?=
 =?utf-8?B?NEo4T0lzWTlnZVJtT1RsZ2R0VWFpV2JpQzUvWlNESm9UelQzUXVuVlNaT1Ru?=
 =?utf-8?B?OFptZU5tNDQ3NWR0Q0s0d25oRzZDVXZHTitOdzc3ZUZxQ3p2WGZycmMvUGlO?=
 =?utf-8?B?c0lwcWhxSmNhTEV1bzhybG5XTjlreDNHTkNqY1RDaXZqUkZ5cEFaVDcydHRV?=
 =?utf-8?B?RUx4NUlWWmlzM1o5VkZZT1phcmoyVURZbFpIdDVqNmV6WW12MFl6WHZyNlhT?=
 =?utf-8?B?NE5Oek9xZld6K3lXUytHUTBGSGM4WmQ4ZFVEVjdpRENtN3NRcUEzZFVuOWx6?=
 =?utf-8?B?UTE3azF2WjZaSWptS2h6QUNBMlhqZDBwbE5OQ2xLeXdZNjJ4NXkxNFBmaE5V?=
 =?utf-8?B?NnU3Q2ZmZVBjTDVidmZSbjMzVkVOZEdLTVZ3dDdXWFFrS2tHRldLV3JOeUJm?=
 =?utf-8?B?a3hZSzBjd0hsK1kyL3htQmtCNnhNeWZndW9RTDl1NDdUSUFEeXB1VUVNQXR5?=
 =?utf-8?B?RWxYUjZteHVCV2lyUjVnUXN6aVJrZGtGdkZUTHAyZlJBZXlxNnMvbXVyNXBZ?=
 =?utf-8?B?dU1SQktnYk5yam5TekhJdi9Ndjd5S3hZY25RSG5LZkZzc1o1aUY0WG9hMWVw?=
 =?utf-8?B?U1g3bnZ0ZjA5WGpXVU8wRnBzV1liUmdoSVRMM3lMczYza1JUN1dubk0vNDRF?=
 =?utf-8?B?dlR0R2pwYi9uKzlBdUd4emhEd2dsVzVvY29SWElMc29Vdk51OXJ5cG9HTllr?=
 =?utf-8?B?NitSS0RqcWpIOENJK1FkdnhxUFRRTk5XLzhNTlV0d3F3RHprN2hhRTdMWnBU?=
 =?utf-8?B?ZlRmdEpUNG0weUFkVGsyZFRuSVJwMmRxVXZJcGM5alp0ZU91dUQ3MEg3bWov?=
 =?utf-8?Q?viMvTUlnJ3kqMMd2R96kcfk=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f59c40-5ea9-4bdc-3513-08dbb5d38677
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 10:07:10.3121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66EX5y45VHNoS+pHki1Ouo5vymmJaUL2rXFZmc/eNVUlglbbt73KmPmTqe7vEBDLJFK9s/RKlX0zHRo2OUT+5UaD5eHKZ6176jo/vEEwBRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5412
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bryan,

On 15.09.23 11:52, Bryan O'Donoghue wrote:
> On 15/09/2023 07:50, Javier Carrasco wrote:
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
>> [1]
>> https://e2e.ti.com/support/power-management-group/power-management/
>> f/power-management-forum/1269856/tps65987d-tps65987d-reset-de-assert-
>> to-normal-operation/4809389#4809389
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>> ---
>>   drivers/usb/typec/tipd/core.c | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/typec/tipd/core.c
>> b/drivers/usb/typec/tipd/core.c
>> index 37b56ce75f39..550f5913e985 100644
>> --- a/drivers/usb/typec/tipd/core.c
>> +++ b/drivers/usb/typec/tipd/core.c
>> @@ -8,6 +8,7 @@
>>     #include <linux/i2c.h>
>>   #include <linux/acpi.h>
>> +#include <linux/gpio/consumer.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>>   #include <linux/power_supply.h>
>> @@ -43,6 +44,9 @@
>>   /* TPS_REG_SYSTEM_CONF bits */
>>   #define TPS_SYSCONF_PORTINFO(c)        ((c) & 7)
>>   +/* reset de-assertion to ready for operation */
>> +#define SETUP_MS            1000
>> +
>>   enum {
>>       TPS_PORTINFO_SINK,
>>       TPS_PORTINFO_SINK_ACCESSORY,
>> @@ -86,6 +90,7 @@ struct tps6598x {
>>       struct mutex lock; /* device lock */
>>       u8 i2c_protocol:1;
>>   +    struct gpio_desc *reset;
>>       struct typec_port *port;
>>       struct typec_partner *partner;
>>       struct usb_pd_identity partner_identity;
>> @@ -717,6 +722,13 @@ static int tps6598x_probe(struct i2c_client *client)
>>       mutex_init(&tps->lock);
>>       tps->dev = &client->dev;
>>   +    tps->reset = devm_gpiod_get_optional(tps->dev, "reset",
>> GPIOD_OUT_LOW);
>> +    if (IS_ERR(tps->reset))
>> +        return dev_err_probe(tps->dev, PTR_ERR(tps->reset),
>> +                     "failed to get reset GPIO\n");
>> +    if (tps->reset)
>> +        msleep(SETUP_MS);
>> +
> 
> This looks a bit odd to me, shouldn't you drive reset to zero ?
> 
> if (tps->reset) {
>     gpiod_set_value_cansleep(tps->reset, 0);
>     msleep(SETUP_MS);
> }
> 
The reset line is driven to zero by means fo the GPIOD_OUT_LOW flag, so
there is no need to set it explicitly again.

> also wouldn't it make sense to functionally decompose that and reuse in
> probe() and tps6598x_resume() ?
> 
> tps6598x_reset() {
>     if (tps->reset) {
>         gpiod_set_value_cansleep(tps->reset, 0);
>         msleep(SETUP_MS);
>     }
> }
> 
I can move the reset action to a separate function as you proposed, but
then I suppose it would make sense to use the same function for both
reset levels. Maybe something like:

tps6598x_reset(bool level) {
    if (tps->reset) {
        gpiod_set_value_cansleep(tps->reset, level);
	if (!level)
            msleep(SETUP_MS);
    }
}

> ---
> bod
Thanks for your feedback.

Best regards,
Javier Carrasco
