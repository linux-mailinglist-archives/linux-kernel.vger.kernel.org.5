Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90087D4060
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjJWTkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJWTkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:40:04 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8A2B4;
        Mon, 23 Oct 2023 12:40:00 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id AC12F100009;
        Mon, 23 Oct 2023 22:39:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru AC12F100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1698089996;
        bh=Hhd9o3DW9H02Ejo8WGubQDNC+sSIsjqhUPhxroLp0IQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=Qzlt0w7tTATPGsbMuBs4DaPGSRQmI03REzogB+ki/buGpx2PFXzNGpKqthBzXJXF/
         shjiwowWttLUICQjG2Sx2B2mOiIn9LtVx3rs9HdmxuZgW4TP9o19dw0RSU7cuXcZSY
         NqJDExsc0U5rC8EHjFTAlCF1B19hD5E6vTGOG5610j7F3cLiIg6/0W9WVwjld0E83C
         mgqUmhrQpsd4p4ZZXCCSzg3eSGsYyWYNnffrx8/9BPijeegCItjGGUBL46za6l6se7
         cAJmooNCJFccC31E7K0+GgAqNhgSxniWvmGBAM61tNIFZnit5UU4/cP3mQZ9ScmZ9t
         D60edgYn72r+w==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon, 23 Oct 2023 22:39:54 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 23 Oct 2023 22:39:54 +0300
Message-ID: <07f978ec-2f18-4079-afb1-4d37827806a3@salutedevices.com>
Date:   Mon, 23 Oct 2023 22:40:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 RESEND] pwm: meson: add pwm support for S4
Content-Language: en-US
To:     Yixun Lan <dlan@gentoo.org>, JunYi Zhao <junyi.zhao@amlogic.com>
CC:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20231016052457.1191838-1-junyi.zhao@amlogic.com>
 <20231016223749.GA7647@ofsar>
From:   George Stark <gnstark@salutedevices.com>
In-Reply-To: <20231016223749.GA7647@ofsar>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180817 [Oct 23 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 542 542 3d23828e213bab96daa5e52f9cef518f74e40214, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;lists.infradead.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/10/23 18:44:00
X-KSMG-LinksScanning: Clean, bases: 2023/10/23 18:45:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/23 18:09:00 #22267281
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yixun Lan

On 10/17/23 01:37, Yixun Lan wrote:
> Hi JunYi
> 
> On 13:24 Mon 16 Oct     , JunYi Zhao wrote:
>> From: "junyi.zhao" <junyi.zhao@amlogic.com>
>>
>> Support PWM for S4 soc.
>> Now the PWM clock input is done in independent CLKCTRL registers.
>> And no more in the PWM registers.
>> PWM needs to obtain an external clock source.
>>
>> Signed-off-by: junyi.zhao <junyi.zhao@amlogic.com>
>> ---
>> V2 -> V3:
>> Rebase and Review the latest upstream code again.
>> After reconstruction, stick to the previous code as much as possible.
>>   drivers/pwm/pwm-meson.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 25519cddc2a9..fe9fd75747c4 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -99,6 +99,7 @@ struct meson_pwm_channel {
>>   struct meson_pwm_data {
>>   	const char * const *parent_names;
>>   	unsigned int num_parents;
>> +	unsigned int extern_clk;
>>   };
>>   
>>   struct meson_pwm {
>> @@ -396,6 +397,10 @@ static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
>>   	.num_parents = ARRAY_SIZE(pwm_g12a_ao_cd_parent_names),
>>   };
>>   
>> +static const struct meson_pwm_data pwm_s4_data = {
>> +	.extern_clk = true,
>> +};
>> +
>>   static const struct of_device_id meson_pwm_matches[] = {
>>   	{
>>   		.compatible = "amlogic,meson8b-pwm",
>> @@ -429,6 +434,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>>   		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
>>   		.data = &pwm_g12a_ao_cd_data
>>   	},
>> +	{
>> +		.compatible = "amlogic,s4-pwm",
>> +		.data = &pwm_s4_data,
>> +	},
>>   	{},
>>   };
>>   MODULE_DEVICE_TABLE(of, meson_pwm_matches);
>> @@ -451,6 +460,16 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>>   		struct clk_parent_data div_parent = {}, gate_parent = {};
>>   		struct clk_init_data init = {};
>>   
>> +		if (meson->data->extern_clk) {
>> +			snprintf(name, sizeof(name), "clkin%u", i);
>> +			channel->clk = devm_clk_get(dev, name);
> use devm_clk_get_optional() which would save you from introducing
> the 'extern_clk' variable

On S4 and other recent chips PWM clock resides in separate IP and it 
must be provided to driver in order to control PWM frequency. So this 
clock is not optional.

> 
>> +			if (IS_ERR(channel->clk)) {
>> +				dev_err(meson->chip.dev, "can't get device clock\n");
>> +				return PTR_ERR(channel->clk);
>> +			}
>> +			continue;
>> +		}
>> +
>>   		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
>>   
>>   		init.name = name;
>>
>> base-commit: 4d2c646ac07cf4a35ef1c4a935a1a4fd6c6b1a36
>> -- 
>> 2.41.0
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 

-- 
Best regards
George
