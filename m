Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2022D7FAA13
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjK0TRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjK0TRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:17:06 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2FDD5D;
        Mon, 27 Nov 2023 11:17:11 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 14222120015;
        Mon, 27 Nov 2023 22:17:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 14222120015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1701112629;
        bh=SS1sGn/2cNOLsJ2sFe7Xteqkm0aQT+klhk6IpwzCwEI=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=un7CsDRUCi8AaK8jc3jZ2ciDPYaqLnUc+FzF2ARR4YfQ/epABCzay1VEgGoNOe3Hu
         d7mfrog5fDbRRQzrxOu8+1K5NVF7+99sthStCLnG+KdwP0ZvQWQedjGd8ADcN1Gt2U
         NvvYSMsyFL5OriSEXT61QjmBzj1bCPwJCNXBunw/fINUoaU+41vDwyCKceXwqIMwIk
         Bu6F1bdq5ZYZVA2sraaDv9JoZZpuuiakbsh5PItRSa/aAS4Kv38xSDlJNbFZ3pnoMY
         VV6TdkmjzX55hjwKFCNjwyYIVjCg+Il85pBATXMQYDEftGqivMJ1n0ICfVjhmdj1xW
         rHFjVyJ97v6Ig==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon, 27 Nov 2023 22:17:08 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 27 Nov 2023 22:17:07 +0300
Message-ID: <ca18c346-94f3-4c4c-a540-57509b879b04@salutedevices.com>
Date:   Mon, 27 Nov 2023 22:17:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iio: adc: meson: add separate config for axg SoC
 family
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@salutedevices.com>
References: <20231122074741.154228-1-gnstark@salutedevices.com>
 <20231125172508.2a2242bf@jic23-huawei>
From:   George Stark <gnstark@salutedevices.com>
In-Reply-To: <20231125172508.2a2242bf@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181629 [Nov 27 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/27 17:21:00 #22554181
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan

Thanks for the review.

On 11/25/23 20:25, Jonathan Cameron wrote:
> On Wed, 22 Nov 2023 10:47:41 +0300
> George Stark <gnstark@salutedevices.com> wrote:
> 
>> According to Amlogic custom kernels ADC of axg SoC family has
>> vref_select and requires this setting to work nominally and thus
>> needs a separate config.
>>
>> Signed-off-by: George Stark <gnstark@salutedevices.com>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Is this a fix?  If so, please provide a fixes tag.
Actually yes, these changes could be done in the patch that introduced
new configuration parameters.

> Or is it aligning with the vendor kernels and we don't know if
> it's strictly necessary or not?
I do know it's necessary if we want kernel driver to be independent from 
ADC initialization in vendor u-boot code. I have Amlogic a113x device 
(axg family) and can provide test results w and w/o this patch.

> 
>> ---
>>   drivers/iio/adc/meson_saradc.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
>> index db280da9edbf..34555a85f131 100644
>> --- a/drivers/iio/adc/meson_saradc.c
>> +++ b/drivers/iio/adc/meson_saradc.c
>> @@ -1242,6 +1242,20 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
>>   	.cmv_select = 1,
>>   };
>>   
>> +static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
>> +	.has_bl30_integration = true,
>> +	.clock_rate = 1200000,
>> +	.bandgap_reg = MESON_SAR_ADC_REG11,
>> +	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
>> +	.resolution = 12,
>> +	.disable_ring_counter = 1,
>> +	.has_reg11 = true,
>> +	.vref_volatge = 1,
>> +	.has_vref_select = true,
>> +	.vref_select = VREF_VDDA,
>> +	.cmv_select = 1,
>> +};
>> +
>>   static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
>>   	.has_bl30_integration = false,
>>   	.clock_rate = 1200000,
>> @@ -1286,7 +1300,7 @@ static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
>>   };
>>   
>>   static const struct meson_sar_adc_data meson_sar_adc_axg_data = {
>> -	.param = &meson_sar_adc_gxl_param,
>> +	.param = &meson_sar_adc_axg_param,
>>   	.name = "meson-axg-saradc",
>>   };
>>   
> 

-- 
Best regards
George
