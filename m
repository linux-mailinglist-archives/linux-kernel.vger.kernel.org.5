Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2279F801235
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378448AbjLASIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLASIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:08:10 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805CBF9;
        Fri,  1 Dec 2023 10:08:15 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ShgyW1Yp3z6J9rV;
        Sat,  2 Dec 2023 02:07:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id 168131401E0;
        Sat,  2 Dec 2023 02:08:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Dec
 2023 18:08:12 +0000
Date:   Fri, 1 Dec 2023 18:08:11 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     George Stark <gnstark@salutedevices.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@salutedevices.com>
Subject: Re: [PATCH v2 1/1] iio: adc: meson: add separate config for axg SoC
 family
Message-ID: <20231201180811.00002783@Huawei.com>
In-Reply-To: <ca18c346-94f3-4c4c-a540-57509b879b04@salutedevices.com>
References: <20231122074741.154228-1-gnstark@salutedevices.com>
        <20231125172508.2a2242bf@jic23-huawei>
        <ca18c346-94f3-4c4c-a540-57509b879b04@salutedevices.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 22:17:33 +0300
George Stark <gnstark@salutedevices.com> wrote:

> Hello Jonathan
> 
> Thanks for the review.
> 
> On 11/25/23 20:25, Jonathan Cameron wrote:
> > On Wed, 22 Nov 2023 10:47:41 +0300
> > George Stark <gnstark@salutedevices.com> wrote:
> >   
> >> According to Amlogic custom kernels ADC of axg SoC family has
> >> vref_select and requires this setting to work nominally and thus
> >> needs a separate config.
> >>
> >> Signed-off-by: George Stark <gnstark@salutedevices.com>
> >> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>  
> > 
> > Is this a fix?  If so, please provide a fixes tag.  
> Actually yes, these changes could be done in the patch that introduced
> new configuration parameters.
> 
> > Or is it aligning with the vendor kernels and we don't know if
> > it's strictly necessary or not?  
> I do know it's necessary if we want kernel driver to be independent from 
> ADC initialization in vendor u-boot code. I have Amlogic a113x device 
> (axg family) and can provide test results w and w/o this patch.

Definitely best to not rely on firmware. 

So send a Fixes tag for this and I'll apply it as a fix
(you get to figure out which patch it fixed :)

Jonathan

> 
> >   
> >> ---
> >>   drivers/iio/adc/meson_saradc.c | 16 +++++++++++++++-
> >>   1 file changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> >> index db280da9edbf..34555a85f131 100644
> >> --- a/drivers/iio/adc/meson_saradc.c
> >> +++ b/drivers/iio/adc/meson_saradc.c
> >> @@ -1242,6 +1242,20 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
> >>   	.cmv_select = 1,
> >>   };
> >>   
> >> +static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
> >> +	.has_bl30_integration = true,
> >> +	.clock_rate = 1200000,
> >> +	.bandgap_reg = MESON_SAR_ADC_REG11,
> >> +	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
> >> +	.resolution = 12,
> >> +	.disable_ring_counter = 1,
> >> +	.has_reg11 = true,
> >> +	.vref_volatge = 1,
> >> +	.has_vref_select = true,
> >> +	.vref_select = VREF_VDDA,
> >> +	.cmv_select = 1,
> >> +};
> >> +
> >>   static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
> >>   	.has_bl30_integration = false,
> >>   	.clock_rate = 1200000,
> >> @@ -1286,7 +1300,7 @@ static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
> >>   };
> >>   
> >>   static const struct meson_sar_adc_data meson_sar_adc_axg_data = {
> >> -	.param = &meson_sar_adc_gxl_param,
> >> +	.param = &meson_sar_adc_axg_param,
> >>   	.name = "meson-axg-saradc",
> >>   };
> >>     
> >   
> 

