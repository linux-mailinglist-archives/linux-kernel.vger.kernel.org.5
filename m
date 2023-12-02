Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3675C80188C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjLBAF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442007AbjLBAFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:05:12 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6941FE3;
        Fri,  1 Dec 2023 16:04:54 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 7660E120027;
        Sat,  2 Dec 2023 03:04:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7660E120027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1701475490;
        bh=rswht4tp6bVZEwPQC/eJeMDlDm0anK7iby4EiMgmWvA=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=YmzY+eyTx9f4+oXHhAnywRc481Fu31AWnX+fspgxf9ZHVaRE03r+41QyeSZQVqar4
         zdUmtIO4WJABaLL9dfFAN7/eFXZRs6Nxw4yKeWPo5+u8S3Ho2/GM7i0M0KZKHD6tmn
         KP2IKfyKhaGVNSeuGCMIHH0CNc9VpRgxypPFmlVzg2vsarW8cStpQzaqaY1V2Vgm4Y
         CZutHsoQRKSPBov3vFnth4Z3GPzdi6C5tHV55+JrUk+RAHwwsCIXusIhU10agxMZiq
         Spc9rNbD6J0MolcHIDmTvAhK0CO8GoXh94ZCWjNzxbD/Mp/1+TQ1iNYsT5JGXRoGMD
         lHg8kmL6l6y6A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Sat,  2 Dec 2023 03:04:50 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 2 Dec 2023 03:04:49 +0300
Message-ID: <2cd319fe-f1f8-4855-badb-cf7dd1f6160a@salutedevices.com>
Date:   Sat, 2 Dec 2023 03:05:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iio: adc: meson: add separate config for axg SoC
 family
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@salutedevices.com>
References: <20231122074741.154228-1-gnstark@salutedevices.com>
 <20231125172508.2a2242bf@jic23-huawei>
 <ca18c346-94f3-4c4c-a540-57509b879b04@salutedevices.com>
 <20231201180811.00002783@Huawei.com>
From:   George Stark <gnstark@salutedevices.com>
In-Reply-To: <20231201180811.00002783@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181777 [Dec 01 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;100.64.160.123:7.1.2;lore.kernel.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/12/01 22:50:00
X-KSMG-LinksScanning: Clean, bases: 2023/12/01 23:54:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/12/01 22:03:00 #22603897
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

On 12/1/23 21:08, Jonathan Cameron wrote:
> On Mon, 27 Nov 2023 22:17:33 +0300
> George Stark <gnstark@salutedevices.com> wrote:
> 
>> Hello Jonathan
>>
>> Thanks for the review.
>>
>> On 11/25/23 20:25, Jonathan Cameron wrote:
>>> On Wed, 22 Nov 2023 10:47:41 +0300
>>> George Stark <gnstark@salutedevices.com> wrote:
>>>    
>>>> According to Amlogic custom kernels ADC of axg SoC family has
>>>> vref_select and requires this setting to work nominally and thus
>>>> needs a separate config.
>>>>
>>>> Signed-off-by: George Stark <gnstark@salutedevices.com>
>>>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>
>>> Is this a fix?  If so, please provide a fixes tag.
>> Actually yes, these changes could be done in the patch that introduced
>> new configuration parameters.
>>
>>> Or is it aligning with the vendor kernels and we don't know if
>>> it's strictly necessary or not?
>> I do know it's necessary if we want kernel driver to be independent from
>> ADC initialization in vendor u-boot code. I have Amlogic a113x device
>> (axg family) and can provide test results w and w/o this patch.
> 
> Definitely best to not rely on firmware.
> 
> So send a Fixes tag for this and I'll apply it as a fix
> (you get to figure out which patch it fixed :)

The patch is ready :)

https://lore.kernel.org/lkml/20231127235558.71995-1-gnstark@salutedevices.com/


> 
> Jonathan
> 
>>
>>>    
>>>> ---
>>>>    drivers/iio/adc/meson_saradc.c | 16 +++++++++++++++-
>>>>    1 file changed, 15 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
>>>> index db280da9edbf..34555a85f131 100644
>>>> --- a/drivers/iio/adc/meson_saradc.c
>>>> +++ b/drivers/iio/adc/meson_saradc.c
>>>> @@ -1242,6 +1242,20 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
>>>>    	.cmv_select = 1,
>>>>    };
>>>>    
>>>> +static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
>>>> +	.has_bl30_integration = true,
>>>> +	.clock_rate = 1200000,
>>>> +	.bandgap_reg = MESON_SAR_ADC_REG11,
>>>> +	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
>>>> +	.resolution = 12,
>>>> +	.disable_ring_counter = 1,
>>>> +	.has_reg11 = true,
>>>> +	.vref_volatge = 1,
>>>> +	.has_vref_select = true,
>>>> +	.vref_select = VREF_VDDA,
>>>> +	.cmv_select = 1,
>>>> +};
>>>> +
>>>>    static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
>>>>    	.has_bl30_integration = false,
>>>>    	.clock_rate = 1200000,
>>>> @@ -1286,7 +1300,7 @@ static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
>>>>    };
>>>>    
>>>>    static const struct meson_sar_adc_data meson_sar_adc_axg_data = {
>>>> -	.param = &meson_sar_adc_gxl_param,
>>>> +	.param = &meson_sar_adc_axg_param,
>>>>    	.name = "meson-axg-saradc",
>>>>    };
>>>>      
>>>    
>>
> 

-- 
Best regards
George
