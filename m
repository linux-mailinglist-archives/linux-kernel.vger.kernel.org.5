Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188067A1FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbjIONRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjIONRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:17:38 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189CD10D;
        Fri, 15 Sep 2023 06:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZw+NkBSTbMZfKyVUmQZFzhdD+KVBSwJGWJysQvNXPiJ0g8b9x0l0FGfwwgriMQGR5xb/uvEHar2WYk+P/yMp0/xSowL8yvCnMwWK3wiQX8/oRbvuqZb+w4F6HicVarF1iGscOFGYO3hp5mAtJULg9ofEDzvm8XKhkwm41x4QrMMSyaMyd1dXWiyaQtr4M4XwHau7gGEI173CALORNbEFREVXMZrmTLsrhc3vslhUTGoR/HCNUP38MfUdrWpUMwryazmfBA+EUgLZZrBZ/+X9XG8fvVw0IioOPU4sQpfyDzDp8AKshvNGJUMOU9ujAI+dJultZ+02k9fH26tlspxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRujAxNgKGtASDIdUlxWlt0JJj4j2BXHs5/v6E2CRoI=;
 b=NV5Qd1PfTw18QAPMH+Iu1HMer8WVcg6LEGbj14+F6FDhU7pqcn1PWLtTPwfmDwb5jVpOKxUQtrE31E/ops+b4Og2HALOjDLPrzzzO2H4TF6OrZxQE+lR7Bde9Vkp8XGAwe2bS24HFeLsoJag3jaoINZNg/IhJjOAV1OlIdZ8X+ujmbk5htgEgtpMXmsauZRaSk7/JdCt86/YgAHgj40EdN0TseAvlyNkjpGpHYUO72EW4QwiZNg7czKVqMK/aKNjeb8efQX1Sa7fvxFq+KvSvImmYAjQTj7iXPmbAx8QSXcIMnsFRoT6e2GyhsXdzMzSVbLDqURgJAIlpYGPzFO+SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRujAxNgKGtASDIdUlxWlt0JJj4j2BXHs5/v6E2CRoI=;
 b=UA6Zwitp6Dg60SSnwZfveP3OhLgiog4/lhEj0NJoOSzuarKqJgJsK1CckxJAN77+1ozHeGEGe4tlQbmDIHNhQAA9nAZ1hShvpQ+Oc93wgXD5NctZ1HZaIRklNhoP9JQNi8XxYDRFxVSU4ha+0Yo98vR+LtoLZrOIq6aSayFp5R8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS2PR08MB9450.eurprd08.prod.outlook.com (2603:10a6:20b:5ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 13:17:30 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 13:17:30 +0000
Message-ID: <8937c928-1938-4864-08e1-25f88caadb9a@wolfvision.net>
Date:   Fri, 15 Sep 2023 15:17:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] usb: typec: tps6598x: add reset gpio support
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230912-topic-tps6598x_reset-v2-0-02a12e2ec50a@wolfvision.net>
 <20230912-topic-tps6598x_reset-v2-1-02a12e2ec50a@wolfvision.net>
 <ZQRUsD1QLke70VG2@kuha.fi.intel.com>
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZQRUsD1QLke70VG2@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: VI1P194CA0048.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::37) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS2PR08MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d336bbc-e889-49f2-8be4-08dbb5ee1d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpi1aaXVHvQQsrwvoXsqD81wvctKCQUn3y48jETRk7rdleFe68tC7ODvo2rggDPmbPxnSQE5tDq+nhL4ZcX5EhHStaxDdsjHLFSVnp/Z3vsyLJX0vjo4wpY7qtpgwmzqXNtaZbsvj4aMmW485bKxcADB0gXYBrLKiSTXzVwcR1nISifwkCG3cy0Hg431yUn8j+B3YwMPFkfoQo2ckoVuzGanoasQNBvWaw5wwwJcbCABdS9kMHizqXvVbbuD2f2tSSMxJDe6WKnokpMUiV/fbVLVcQrb+9XAXL4r2YWyY6gV+7aI9eA+o8jSBZif4Il8jyL/imIRcUEUhY16PIh1ODtErBvIi1/aBjS7eN43i/+XMs6qujVHSdFnY2PigDxUF2MHi649T+mfYINi7GrcnYeyZbz/Li2soRgWJB0SUDuu7+eEsAEqM3/3XBliWd2ftshfPetqWMAhSyItpDBHg8cnUsnbckAzn8W4M5uR8h8Z+M6fqCDk5AWAYh3FFojEXwaKkdN63TYpP/UpCznPqEO5qkzliArmECajpCYJubB+9CcbEvKHfGGQVUjEQ3zMI/EpfsoC3XZA1SszfNtAy+ItTLmPkyKMO5YO4DUe0eYD0fA69dpCty+U1WvyxG8vSZc8vs4hqAsJ7kUb5eB3BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39850400004)(186009)(1800799009)(451199024)(26005)(53546011)(2616005)(38100700002)(6512007)(36756003)(31696002)(83380400001)(86362001)(44832011)(966005)(5660300002)(2906002)(45080400002)(66556008)(478600001)(31686004)(41300700001)(8676002)(4326008)(316002)(6486002)(6506007)(8936002)(66946007)(6916009)(54906003)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cldJV3YySStJejNrOUM0a0FPZlF3QlIvSmp3Sy9aQzJoYmc3TTZDbDlQVGZj?=
 =?utf-8?B?NkJtUnFwZ3hDc3J6NTJ6bHIyK2RFd3BkQzhEcmJxV1F3NGk5cE9xWVFyTE5y?=
 =?utf-8?B?MzM2c0xRcEx2WXdtUWVFL2RmNHcyb0VwRkhRbVJoNHZhbXBPQTJ4eWV6YzlZ?=
 =?utf-8?B?cGhtN3Q4dUR4dGNJNHJCL0p6MVhldmRtZlZGMGo1WmhiUVFlQVBlUEhTcnlQ?=
 =?utf-8?B?WUhkaHVtQU0yL1ZPT2p5OWlFRXNoZm96V29sV3NtbGdlRVN2YWY5ODFBNUMx?=
 =?utf-8?B?eE42RDUrS1ZCOUVBR0ozalczRnd5ZjN6bTU1c1Y3VU9WekcvRHA4ZG1rTEtF?=
 =?utf-8?B?Ri90WTFkL1F1S3NnZ054cXNzbWpjeU8rbGRPL2NmUVpEbFNYV0xBRnhSMGl5?=
 =?utf-8?B?K0NZc0tWUHhUK0MrZlN2RTdybXNnY09mWDFWMDFQSlRwSS95SU1mS1EwNEFI?=
 =?utf-8?B?YklXb21CZ0drVWNoVTZlQzQzUi9Jd0c3UENPdkR2d3FJOEtZMm9pbW8yanFT?=
 =?utf-8?B?K3E1SHV0WFF6K25xYnN6SDAwRDFRYzV2RFcvOVR2eklIak5JcTl1QXZvNzg2?=
 =?utf-8?B?RHBKU3ByTk41SFhUcE9kZDhpcEZKbmo5eXUzWklzSDhPWlUyeXBVMnE3WlBE?=
 =?utf-8?B?T2ljYnBCUlFGWWxHc3VsQ3RaOEkxUUhKTmdDbG9hVGxjaHdhSm13WXRJMEJU?=
 =?utf-8?B?Q2dUVENoQVppSjRhTmUvbjZxMXZ1b0RpbzFRMktvK2ptMHB5Y0lUYkFma0Jk?=
 =?utf-8?B?Z2dXSXZMOVVWUnVxTjQ3K2kveVRZM0s3bWZVTTUxT0RlT2syNUZ5K1Q1MzJs?=
 =?utf-8?B?b3lYamFjOEF0ZjVyZndHRHBGejlzSFJUb3l1aUZjdmFDbzVuUE94VFhmMHg1?=
 =?utf-8?B?eFg4TUJrTVZDU21ITjQ5TDFzNDlsZmptS2FkTmVINEI1Z3d0dllDN0lPemN3?=
 =?utf-8?B?b3VGdy96TWJ4ckxISnBXQlpuYkdvcXVhb21jK2pwdmk5aDJicVo3bjBzOXV1?=
 =?utf-8?B?bDEwakdVVjdUYllHc0t3dzN5V24rcGtCNUJ6MHdaNGVCTzB0WmVrMGNEVVhy?=
 =?utf-8?B?VUhGekgveDdhWjIzSjVlMmJuNlNBMWxENmFkam1mWkprYS93ejRISGhldWFj?=
 =?utf-8?B?d24yOCt2RUZRdDg1c3MzRjcyS1A2ME5qMExEWVg1TU15Vk9IbjBUTm1sNGxh?=
 =?utf-8?B?RURpOHVKbEhQWlZZSG5QSyswWDI5UDRtV0NENEFvSzBmZGwvNDJLVHQ2bWlp?=
 =?utf-8?B?RzdRSjVOdGx3SXZ3UkV2end3V25UOTdnNmVoRGFqWlhKRHpZODlUdVMzZDh1?=
 =?utf-8?B?SWVwcW8wUWd6Sy9MMWwrMkJVZGlSZ0xHQVpnZlJqTmUzTmFwT1hVM2RLSXRJ?=
 =?utf-8?B?T3VrWWtFb1huNk94MnFLOWdkWWV1WEVhWnNoRzJxUE5kRmwzcmNMb3I1MVRn?=
 =?utf-8?B?UFBqWGt1ZElBeEk4VDErUllDdjQwc3N6ZFJnbit1ZTJGUkxvcEZoUHdLR0R0?=
 =?utf-8?B?cG5IQ0RBemRmM1BoanF6b2FkaitUd2lVd0JDSWpsVWtYNis3eEhQTmd1WXFs?=
 =?utf-8?B?UUd0UUhpL1ptNUkvckxMdWtuWGE3Rmd2bGJrd1VZYm5mcGtrNWhUTXpTRGtq?=
 =?utf-8?B?bDZoTE5HRDBpVU9vWFppVi9rYmdoTzZqbWhXZHdCYkJTc1dDZy9BZFJ1RWxo?=
 =?utf-8?B?UFZ6OFhFcUtxVi8xOFlqZWZBUTBwdHd1TFFvQ3dObExLeXh4R1RjRjdzVlBj?=
 =?utf-8?B?MndrWEF4dVorSUEzZ0FoYUJINFhtWmREL09vaW1yR01yTXlESUpyVFlYQ0Zx?=
 =?utf-8?B?by91ajNYTWFOSTBtcjAwbmllNTBqUk5aNW5UTGM1aXpaM1d6SGlHWCt2OHdj?=
 =?utf-8?B?ZlBtaVRQcG11bFc4c3JhaFRhaWpWK3Z4dUFsN3lSaWRyUHJTaE1JSEZ5enY5?=
 =?utf-8?B?OWdDN2ZPVmRmbXhRR2ZMczdoejNXMXZoWVozd1JGeHNuNTlMQWx5WHpaczVj?=
 =?utf-8?B?ZjRzMCtKbFdDOHEyM0wxY0xLSk1kTW1HZDVDL3Y3ajZMaU9ZbGE1TXE2bEh3?=
 =?utf-8?B?QXYzdWxFRktYNVRWbUUwTTBNczBDOVFXZCsyQnBFM3RyZTBFQmdlK0FNcm9R?=
 =?utf-8?B?MmJBeGYySXg4RkFSZ292MHU5aE1hYlNnL0pPckFDVEV0RVBXWWpDNHE3MGZi?=
 =?utf-8?Q?KVvPVob+hTJ/JkT8IBkSdGU=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d336bbc-e889-49f2-8be4-08dbb5ee1d51
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 13:17:30.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GcU+1FKFWcXJP0bLRXJ3CYfgcgq26IWGbViNUjAp9e4kdDKQtCBeufROgslXPDx0CIjUDTQZfffFRSnIV2ipw9yjSdFcZWmcFP9xRo2Q3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9450
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.09.23 14:57, Heikki Krogerus wrote:
> On Fri, Sep 15, 2023 at 02:23:48PM +0200, Javier Carrasco wrote:
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
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>  drivers/usb/typec/tipd/core.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
>> index 37b56ce75f39..3068ef300073 100644
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
> 
> Do you need that "if (tps->reset)" in this case? That function is NULL safe,
> right?
> 
The function makes use of the VALIDATE_DESC_VOID macro to make it NULL
safe, but this macro also calls pr_warn if the descriptor is NULL and I
do not want to add warnings for an optional property that did not exist
before because it could be confusing. But if that is the desired
behavior, I will remove the checks.

>>  }
>>  
>>  static int __maybe_unused tps6598x_suspend(struct device *dev)
>> @@ -902,6 +917,8 @@ static int __maybe_unused tps6598x_suspend(struct device *dev)
>>  	if (tps->wakeup) {
>>  		disable_irq(client->irq);
>>  		enable_irq_wake(client->irq);
>> +	} else if (tps->reset) {
>> +		gpiod_set_value_cansleep(tps->reset, 1);
>>  	}
>>  
>>  	if (!client->irq)
>> @@ -918,6 +935,9 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
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
>> -- 
>> 2.39.2
> 
> thanks,
> 
Thanks and best regards,
Javier Carrasco
