Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E517F3509
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjKURiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjKURiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:38:15 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B54E8;
        Tue, 21 Nov 2023 09:38:06 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ALCoHrE008041;
        Tue, 21 Nov 2023 11:37:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        content-type:message-id:date:mime-version:subject:to:cc
        :references:from:in-reply-to; s=PODMain02222019; bh=5gcL/av8gs4/
        +0c0DpBAB4W7XnRrmwWvBg9JKCUKtFI=; b=CICj1TOUi6f7tUXo94mAfDMu7me5
        JgKL9VI0PiRj246fmiIOMFPu2ADNrKYDv6vqJSuxJ7+RL33cnjrtENw3H6RFfbda
        8Z7cyTGoLtk8MGxYOLSyC5EEDrOvC6XlDXB8JR9GX97HdDnXszaaJbK0lsj+kA1b
        ML/9lRPIBNUMo4S33EHW7phXZcmzLz5AIDyYZGe1Gj+MEVv1+fzBbT/ZSH5avc0g
        qmDlxutTkVjmkQiSHctHlkXgjWUN5BSaQRKU6Rv8wrwXRbyW89ASKxLC4w0xkbog
        5k3QKKP6XXFKm7LeEbOB6wpHobq03IjMdR4xMBN/btR9WjWZpvno2t6Wdg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ueuj2bgbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 11:37:21 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 21 Nov
 2023 17:37:19 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Tue, 21 Nov 2023 17:37:19 +0000
Received: from [198.61.65.15] (LONN2DGDQ73.ad.cirrus.com [198.61.65.15])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8B4F4458;
        Tue, 21 Nov 2023 17:37:18 +0000 (UTC)
Content-Type: multipart/mixed;
        boundary="------------XtTI47P0lSXzOpt1a7UfDNYn"
Message-ID: <d5b50766-b8f8-45b4-8a53-7baad200c6c2@opensource.cirrus.com>
Date:   Tue, 21 Nov 2023 17:37:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/8] spi: Add multi-cs memories support in SPI core
To:     "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
References: <20231118135446.52783-1-amit.kumar-mahapatra@amd.com>
 <20231118135446.52783-2-amit.kumar-mahapatra@amd.com>
 <8182135b-6f4f-47ae-ba53-e94a058d466f@opensource.cirrus.com>
 <BN7PR12MB28026E2EBD64F0D49A1084ABDCBBA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <b10252e3-41bf-4d5c-bbd1-0af4c723884f@opensource.cirrus.com>
 <BN7PR12MB2802ADDA7C5789CADC1D89D2DCBBA@BN7PR12MB2802.namprd12.prod.outlook.com>
Content-Language: en-GB
From:   Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <BN7PR12MB2802ADDA7C5789CADC1D89D2DCBBA@BN7PR12MB2802.namprd12.prod.outlook.com>
X-Proofpoint-ORIG-GUID: gWnW-_3nvQgTHjy5X6TJ_6EME6yrc-Ro
X-Proofpoint-GUID: gWnW-_3nvQgTHjy5X6TJ_6EME6yrc-Ro
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------XtTI47P0lSXzOpt1a7UfDNYn
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 21/11/2023 16:35, Mahapatra, Amit Kumar wrote:
> Hello Stefan,
>
>> -----Original Message-----
>> From: Stefan Binding <sbinding@opensource.cirrus.com>
>> Sent: Tuesday, November 21, 2023 7:28 PM
>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
>> broonie@kernel.org; tudor.ambarus@linaro.org; pratyush@kernel.org;
>> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com
>> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
>> michael@walle.cc; linux-mtd@lists.infradead.org;
>> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
>> claudiu.beznea@tuxon.dev; Simek, Michal <michal.simek@amd.com>; linux-
>> arm-kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>;
>> amitrkcian2002@gmail.com; patches@opensource.cirrus.com
>> Subject: Re: [PATCH v10 1/8] spi: Add multi-cs memories support in SPI core
>>
>>
>> On 21/11/2023 07:39, Mahapatra, Amit Kumar wrote:
>>> Hello Stefan,
>>>
>>>> -----Original Message-----
>>>> From: Stefan Binding <sbinding@opensource.cirrus.com>
>>>> Sent: Monday, November 20, 2023 8:00 PM
>>>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
>>>> broonie@kernel.org; tudor.ambarus@linaro.org; pratyush@kernel.org;
>>>> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com
>>>> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> michael@walle.cc; linux-mtd@lists.infradead.org;
>>>> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
>>>> claudiu.beznea@tuxon.dev; Simek, Michal <michal.simek@amd.com>;
>>>> linux- arm-kernel@lists.infradead.org; git (AMD-Xilinx)
>>>> <git@amd.com>; amitrkcian2002@gmail.com;
>>>> patches@opensource.cirrus.com
>>>> Subject: Re: [PATCH v10 1/8] spi: Add multi-cs memories support in
>>>> SPI core
>>>>
>>>>
>>>> On 18/11/2023 13:54, Amit Kumar Mahapatra wrote:
>>>>> AMD-Xilinx GQSPI controller has two advanced mode that allows the
>>>>> controller to consider two flashes as one single device.
>>>>>
>>>>> One of these two mode is the parallel mode in which each byte of
>>>>> data is stored in both devices, the even bits in the lower flash &
>>>>> the odd bits in the upper flash. The byte split is automatically
>>>>> handled by the QSPI controller.
>>>>>
>>>>> The other mode is the stacked mode in which both the flashes share
>>>>> the same SPI bus but each of the device contain half of the data. In
>>>>> this mode, the controller does not follow CS requests but instead
>>>>> internally wires the two CS levels with the value of the most
>>>>> significant
>>>> address bit.
>>>>> For supporting both these modes SPI core need to be updated for
>>>>> providing multiple CS for a single SPI device.
>>>>>
>>>>> For adding multi CS support the SPI device need to be aware of all
>>>>> the CS values. So, the "chip_select" member in the spi_device
>>>>> structure is now an array that holds all the CS values.
>>>>>
>>>>> spi_device structure now has a "cs_index_mask" member. This acts as
>>>>> an index to the chip_select array. If nth bit of spi->cs_index_mask
>>>>> is set then the driver would assert spi->chip_select[n].
>>>>>
>>>>> In parallel mode all the chip selects are asserted/de-asserted
>>>>> simultaneously and each byte of data is stored in both devices, the
>>>>> even bits in one, the odd bits in the other. The split is
>>>>> automatically handled by the GQSPI controller. The GQSPI controller
>>>>> supports a maximum of two flashes connected in parallel mode. A
>>>>> SPI_CONTROLLER_MULTI_CS flag bit is added in the spi controller
>>>>> flags, through ctlr->flags the spi core will make sure that the
>>>>> controller is capable of handling multiple chip selects at once.
>>>>>
>>>>> For supporting multiple CS via GPIO the cs_gpiod member of the
>>>>> spi_device structure is now an array that holds the gpio descriptor
>>>>> for each chipselect.
>>>>>
>>>>> CS GPIO is not tested due to unavailability of necessary hardware setup.
>>>>>
>>>>> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-
>> mahapatra@amd.com>
>>>>> ---
>>>>> Hello @Stefen,
>>>>> We restructured the SPI core implementation, for handling arbitrary
>>>>> number of devices connected in parallel(multi-cs) or stacked mode.
>>>>> We have tested this updated patch on native-cs setup but couldn't
>>>>> test cs-gpio due to unavailability of a proper setup. If possible,
>>>>> could you please retest the cs-gpio use case with this updated patch
>>>>> and provide
>>>> your feedback.
>>>>
>>>> Hi,
>>>>
>>>> I tested this chain on 2 different systems using GPIOs as chip
>>>> selects, and see the same error on both:
>>>> [    2.842045] pxa2xx-spi pxa2xx-spi.6: chipselect 0 already in use
>>>>
>>>> Let me know if you need any further testing.
>>>>
>>>> Thanks,
>>>>
>>>> Stefan Binding
>>>>
>>>>> ---
>>>>>     drivers/spi/spi.c       | 192 +++++++++++++++++++++++++++++++---------
>>>>>     include/linux/spi/spi.h |  51 ++++++++---
>>>>>     2 files changed, 191 insertions(+), 52 deletions(-)
>>>>>
>>>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c index
>>>>> 8ead7acb99f3..ff66147ba95f 100644
>>>>> --- a/drivers/spi/spi.c
>>>>> +++ b/drivers/spi/spi.c
>>>>> @@ -612,10 +612,21 @@ static int spi_dev_check(struct device *dev,
>>>>> void
>>>> *data)
>>>>>     {
>>>>>     	struct spi_device *spi = to_spi_device(dev);
>>>>>     	struct spi_device *new_spi = data;
>>>>> -
>>>>> -	if (spi->controller == new_spi->controller &&
>>>>> -	    spi_get_chipselect(spi, 0) == spi_get_chipselect(new_spi, 0))
>>>>> -		return -EBUSY;
>>>>> +	int idx, nw_idx;
>>>>> +	u8 cs, cs_nw;
>>>>> +
>>>>> +	if (spi->controller == new_spi->controller) {
>>>>> +		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>> +			cs = spi_get_chipselect(spi, idx);
>>>>> +			for (nw_idx = 0; nw_idx < SPI_CS_CNT_MAX;
>>>> nw_idx++) {
>>>>> +				cs_nw = spi_get_chipselect(spi, nw_idx);
>>> Thank you for dedicating your time to test my patch.
>>> As per my analysis the error is reported from here as we are supplying
>>> the former SPI device structure to retrieve the CS value for the new
>>> SPI devices.
>>> To fix this, could you kindly substitute the above line with
>>>
>>> cs_nw = spi_get_chipselect(new_spi, nw_idx);
>>>
>>> and rerun your tests?
>>> If it works correctly, I will incorporate this fix into my upcoming
>>> series.
>>>
>>> Regards,
>>> Amit

Hi,

I've attached my log.
I notice that you add a print to of_spi_parse_dt, however since the 
laptop I am using is an x86 laptop, it uses ACPI rather than OF, and I 
don't think this function isnt even compiled in.

Thanks,

Stefan

>> Hi,
>>
>> I still see the same error:
>>
>> [    2.748546] pxa2xx-spi pxa2xx-spi.6: chipselect 0 already in use
> Thank you for the quick testing. For further analysis I have incorporated
> additional debug prints on top of 1/8 patch. The corresponding diff is
> shared below. Kindly implement the specified changes, rerun your test and
> share the kernel logs.
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index ff66147ba95f..7f59ea81593d 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -618,8 +618,10 @@ static int spi_dev_check(struct device *dev, void *data)
>          if (spi->controller == new_spi->controller) {
>                  for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>                          cs = spi_get_chipselect(spi, idx);
> +                       printk("%s() [%d] CS[%d] = [%d]\n", __func__, __LINE__, idx, cs);
>                          for (nw_idx = 0; nw_idx < SPI_CS_CNT_MAX; nw_idx++) {
> -                               cs_nw = spi_get_chipselect(spi, nw_idx);
> +                               cs_nw = spi_get_chipselect(new_spi, nw_idx);
> +                               printk("%s() [%d] CS_NEW[%d] = [%d]\n", __func__, __LINE__, nw_idx, cs_nw);
>                                  if (cs != 0xFF && cs_nw != 0xFF && cs == cs_nw) {
>                                          dev_err(dev, "chipselect %d already in use\n", cs_nw);
>                                          return -EBUSY;
> @@ -659,8 +661,10 @@ static int __spi_add_device(struct spi_device *spi)
>           */
>          for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>                  cs = spi_get_chipselect(spi, idx);
> +               printk("%s() [%d] CS[%d] = [%d]\n", __func__, __LINE__, idx, cs);
>                  for (nw_idx = idx + 1; nw_idx < SPI_CS_CNT_MAX; nw_idx++) {
>                          nw_cs = spi_get_chipselect(spi, nw_idx);
> +                       printk("%s() [%d] CS_NEW[%d] = [%d]\n", __func__, __LINE__, nw_idx, nw_cs);
>                          if (cs != 0xFF && nw_cs != 0xFF && cs == nw_cs) {
>                                  dev_err(dev, "chipselect %d already in use\n", nw_cs);
>                                  return -EBUSY;
> @@ -2401,6 +2405,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>          for (idx = 0; idx < rc; idx++)
>                  spi_set_chipselect(spi, idx, cs[idx]);
>   
> +       for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
> +               printk("%s() [%d] CS[%d] = [%d]\n", __func__, __LINE__, idx, spi_get_chipselect(spi, idx));
> +
>          /* spi->chip_select[i] gives the corresponding physical CS for logical CS i
>           * logical CS number is represented by setting the ith bit in spi->cs_index_mask
>           * So, for example, if spi->cs_index_mask = 0x01 then logical CS number is 0 and
>
> Regards,
> Amit
>   
>> Thanks,
>>
>> Stefan
>>
>>>>> +				if (cs != 0xFF && cs_nw != 0xFF && cs ==
>>>> cs_nw) {
>>>>> +					dev_err(dev, "chipselect %d already in
>>>> use\n", cs_nw);
>>>>> +					return -EBUSY;
>>>>> +				}
>>>>> +			}
>>>>> +		}
>>>>> +	}
>>>>>     	return 0;
>>>>>     }
>>>>>
>>>>> @@ -629,13 +640,32 @@ static int __spi_add_device(struct spi_device
>> *spi)
>>>>>     {
>>>>>     	struct spi_controller *ctlr = spi->controller;
>>>>>     	struct device *dev = ctlr->dev.parent;
>>>>> -	int status;
>>>>> +	int status, idx, nw_idx;
>>>>> +	u8 cs, nw_cs;
>>>>> +
>>>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>> +		/* Chipselects are numbered 0..max; validate. */
>>>>> +		cs = spi_get_chipselect(spi, idx);
>>>>> +		if (cs != 0xFF && cs >= ctlr->num_chipselect) {
>>>>> +			dev_err(dev, "cs%d >= max %d\n",
>>>> spi_get_chipselect(spi, idx),
>>>>> +				ctlr->num_chipselect);
>>>>> +			return -EINVAL;
>>>>> +		}
>>>>> +	}
>>>>>
>>>>> -	/* Chipselects are numbered 0..max; validate. */
>>>>> -	if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
>>>>> -		dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, 0),
>>>>> -			ctlr->num_chipselect);
>>>>> -		return -EINVAL;
>>>>> +	/*
>>>>> +	 * Make sure that multiple logical CS doesn't map to the same
>>>> physical CS.
>>>>> +	 * For example, spi->chip_select[0] != spi->chip_select[1] and so on.
>>>>> +	 */
>>>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>> +		cs = spi_get_chipselect(spi, idx);
>>>>> +		for (nw_idx = idx + 1; nw_idx < SPI_CS_CNT_MAX; nw_idx++) {
>>>>> +			nw_cs = spi_get_chipselect(spi, nw_idx);
>>>>> +			if (cs != 0xFF && nw_cs != 0xFF && cs == nw_cs) {
>>>>> +				dev_err(dev, "chipselect %d already in use\n",
>>>> nw_cs);
>>>>> +				return -EBUSY;
>>>>> +			}
>>>>> +		}
>>>>>     	}
>>>>>
>>>>>     	/* Set the bus ID string */
>>>>> @@ -647,11 +677,8 @@ static int __spi_add_device(struct spi_device
>> *spi)
>>>>>     	 * its configuration.
>>>>>     	 */
>>>>>     	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
>>>>> -	if (status) {
>>>>> -		dev_err(dev, "chipselect %d already in use\n",
>>>>> -				spi_get_chipselect(spi, 0));
>>>>> +	if (status)
>>>>>     		return status;
>>>>> -	}
>>>>>
>>>>>     	/* Controller may unregister concurrently */
>>>>>     	if (IS_ENABLED(CONFIG_SPI_DYNAMIC) && @@ -659,8 +686,15 @@
>>>> static
>>>>> int __spi_add_device(struct spi_device *spi)
>>>>>     		return -ENODEV;
>>>>>     	}
>>>>>
>>>>> -	if (ctlr->cs_gpiods)
>>>>> -		spi_set_csgpiod(spi, 0, ctlr->cs_gpiods[spi_get_chipselect(spi,
>>>> 0)]);
>>>>> +	if (ctlr->cs_gpiods) {
>>>>> +		u8 cs;
>>>>> +
>>>>> +		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>> +			cs = spi_get_chipselect(spi, idx);
>>>>> +			if (cs != 0xFF)
>>>>> +				spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
>>>>> +		}
>>>>> +	}
>>>>>
>>>>>     	/*
>>>>>     	 * Drivers may modify this initial i/o setup, but will @@ -701,6
>>>>> +735,9 @@ int spi_add_device(struct spi_device *spi)
>>>>>     	struct spi_controller *ctlr = spi->controller;
>>>>>     	int status;
>>>>>
>>>>> +	/* Set the bus ID string */
>>>>> +	spi_dev_set_name(spi);
>>>>> +
>>>>>     	mutex_lock(&ctlr->add_lock);
>>>>>     	status = __spi_add_device(spi);
>>>>>     	mutex_unlock(&ctlr->add_lock);
>>>>> @@ -942,32 +979,51 @@ static void spi_res_release(struct
>>>>> spi_controller
>>>> *ctlr, struct spi_message *mes
>>>>>     }
>>>>>
>>>>>
>>>>> /*------------------------------------------------------------------
>>>>> --
>>>>> -----*/
>>>>> +static inline bool spi_is_last_cs(struct spi_device *spi) {
>>>>> +	u8 idx;
>>>>> +	bool last = false;
>>>>> +
>>>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>> +		if ((spi->cs_index_mask >> idx) & 0x01) {
>>>>> +			if (spi->controller->last_cs[idx] ==
>>>> spi_get_chipselect(spi, idx))
>>>>> +				last = true;
>>>>> +		}
>>>>> +	}
>>>>> +	return last;
>>>>> +}
>>>>> +
>>>>>
>>>>>     static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
>>>>>     {
>>>>>     	bool activate = enable;
>>>>> +	u8 idx;
>>>>>
>>>>>     	/*
>>>>>     	 * Avoid calling into the driver (or doing delays) if the chip select
>>>>>     	 * isn't actually changing from the last time this was called.
>>>>>     	 */
>>>>> -	if (!force && ((enable && spi->controller->last_cs ==
>>>> spi_get_chipselect(spi, 0)) ||
>>>>> -		       (!enable && spi->controller->last_cs !=
>>>> spi_get_chipselect(spi, 0))) &&
>>>>> +	if (!force && ((enable && spi->controller->last_cs_index_mask ==
>>>>> +spi-
>>>>> cs_index_mask &&
>>>>> +			spi_is_last_cs(spi)) ||
>>>>> +		       (!enable && spi->controller->last_cs_index_mask == spi-
>>>>> cs_index_mask &&
>>>>> +			!spi_is_last_cs(spi))) &&
>>>>>     	    (spi->controller->last_cs_mode_high == (spi->mode &
>>>> SPI_CS_HIGH)))
>>>>>     		return;
>>>>>
>>>>>     	trace_spi_set_cs(spi, activate);
>>>>>
>>>>> -	spi->controller->last_cs = enable ? spi_get_chipselect(spi, 0) : -1;
>>>>> +	spi->controller->last_cs_index_mask = spi->cs_index_mask;
>>>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
>>>>> +		spi->controller->last_cs[idx] = enable ? spi_get_chipselect(spi,
>>>> 0)
>>>>> +: -1;
>>>>>     	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
>>>>>
>>>>> -	if ((spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) &&
>>>> !activate)
>>>>> -		spi_delay_exec(&spi->cs_hold, NULL);
>>>>> -
>>>>>     	if (spi->mode & SPI_CS_HIGH)
>>>>>     		enable = !enable;
>>>>>
>>>>> -	if (spi_get_csgpiod(spi, 0)) {
>>>>> +	if (spi_is_csgpiod(spi)) {
>>>>> +		if (!spi->controller->set_cs_timing && !activate)
>>>>> +			spi_delay_exec(&spi->cs_hold, NULL);
>>>>> +
>>>>>     		if (!(spi->mode & SPI_NO_CS)) {
>>>>>     			/*
>>>>>     			 * Historically ACPI has no means of the GPIO polarity
>>>> and @@
>>>>> -979,26 +1035,38 @@ static void spi_set_cs(struct spi_device *spi,
>>>>> bool
>>>> enable, bool force)
>>>>>     			 * ambiguity. That's why we use enable, that takes
>>>> SPI_CS_HIGH
>>>>>     			 * into account.
>>>>>     			 */
>>>>> -			if (has_acpi_companion(&spi->dev))
>>>>> -
>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), !enable);
>>>>> -			else
>>>>> -				/* Polarity handled by GPIO library */
>>>>> -
>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), activate);
>>>>> +			for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>> +				if (((spi->cs_index_mask >> idx) & 0x01) &&
>>>>> +				    spi_get_csgpiod(spi, idx)) {
>>>>> +					if (has_acpi_companion(&spi->dev))
>>>>> +
>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
>>>>> +
>>>> !enable);
>>>>> +					else
>>>>> +						/* Polarity handled by GPIO
>>>> library */
>>>>> +
>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
>>>>> +
>>>> activate);
>>>>> +
>>>>> +					if (activate)
>>>>> +						spi_delay_exec(&spi-
>>>>> cs_setup, NULL);
>>>>> +					else
>>>>> +						spi_delay_exec(&spi-
>>>>> cs_inactive, NULL);
>>>>> +				}
>>>>> +			}
>>>>>     		}
>>>>>     		/* Some SPI masters need both GPIO CS & slave_select */
>>>>>     		if ((spi->controller->flags & SPI_CONTROLLER_GPIO_SS) &&
>>>>>     		    spi->controller->set_cs)
>>>>>     			spi->controller->set_cs(spi, !enable);
>>>>> +
>>>>> +		if (!spi->controller->set_cs_timing) {
>>>>> +			if (activate)
>>>>> +				spi_delay_exec(&spi->cs_setup, NULL);
>>>>> +			else
>>>>> +				spi_delay_exec(&spi->cs_inactive, NULL);
>>>>> +		}
>>>>>     	} else if (spi->controller->set_cs) {
>>>>>     		spi->controller->set_cs(spi, !enable);
>>>>>     	}
>>>>> -
>>>>> -	if (spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) {
>>>>> -		if (activate)
>>>>> -			spi_delay_exec(&spi->cs_setup, NULL);
>>>>> -		else
>>>>> -			spi_delay_exec(&spi->cs_inactive, NULL);
>>>>> -	}
>>>>>     }
>>>>>
>>>>>     #ifdef CONFIG_HAS_DMA
>>>>> @@ -2222,8 +2290,8 @@ static void of_spi_parse_dt_cs_delay(struct
>>>> device_node *nc,
>>>>>     static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device
>> *spi,
>>>>>     			   struct device_node *nc)
>>>>>     {
>>>>> -	u32 value;
>>>>> -	int rc;
>>>>> +	u32 value, cs[SPI_CS_CNT_MAX];
>>>>> +	int rc, idx;
>>>>>
>>>>>     	/* Mode (clock phase/polarity/etc.) */
>>>>>     	if (of_property_read_bool(nc, "spi-cpha")) @@ -2295,14 +2363,52
>>>> @@
>>>>> static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>>>>>     		return 0;
>>>>>     	}
>>>>>
>>>>> +	if (ctlr->num_chipselect > SPI_CS_CNT_MAX) {
>>>>> +		dev_err(&ctlr->dev, "No. of CS is more than max. no. of
>>>> supported CS\n");
>>>>> +		return -EINVAL;
>>>>> +	}
>>>>> +
>>>>> +	/*
>>>>> +	 * Zero(0) is a valid physical CS value and can be located at any
>>>>> +	 * logical CS in the spi->chip_select[]. If all the physical CS
>>>>> +	 * are initialized to 0 then It would be difficult to differentiate
>>>>> +	 * between a valid physical CS 0 & an unused logical CS whose
>>>> physical
>>>>> +	 * CS can be 0. As a solution to this issue initialize all the CS to 0xFF.
>>>>> +	 * Now all the unused logical CS will have 0xFF physical CS value
>>>>> +& can
>>>> be
>>>>> +	 * ignore while performing physical CS validity checks.
>>>>> +	 */
>>>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
>>>>> +		spi_set_chipselect(spi, idx, 0xFF);
>>>>> +
>>>>>     	/* Device address */
>>>>> -	rc = of_property_read_u32(nc, "reg", &value);
>>>>> -	if (rc) {
>>>>> +	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
>>>>> +						 SPI_CS_CNT_MAX);
>>>>> +	if (rc < 0) {
>>>>>     		dev_err(&ctlr->dev, "%pOF has no valid 'reg' property
>>>> (%d)\n",
>>>>>     			nc, rc);
>>>>>     		return rc;
>>>>>     	}
>>>>> -	spi_set_chipselect(spi, 0, value);
>>>>> +	if (rc > ctlr->num_chipselect) {
>>>>> +		dev_err(&ctlr->dev, "%pOF has number of CS > ctlr-
>>>>> num_chipselect (%d)\n",
>>>>> +			nc, rc);
>>>>> +		return rc;
>>>>> +	}
>>>>> +	if ((of_property_read_bool(nc, "parallel-memories")) &&
>>>>> +	    (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
>>>>> +		dev_err(&ctlr->dev, "SPI controller doesn't support multi
>>>> CS\n");
>>>>> +		return -EINVAL;
>>>>> +	}
>>>>> +	for (idx = 0; idx < rc; idx++)
>>>>> +		spi_set_chipselect(spi, idx, cs[idx]);
>>>>> +
>>>>> +	/* spi->chip_select[i] gives the corresponding physical CS for
>>>>> +logical CS
>>>> i
>>>>> +	 * logical CS number is represented by setting the ith bit in spi-
>>>>> cs_index_mask
>>>>> +	 * So, for example, if spi->cs_index_mask = 0x01 then logical CS
>>>> number is 0 and
>>>>> +	 * spi->chip_select[0] will give the physical CS.
>>>>> +	 * By default spi->chip_select[0] will hold the physical CS number
>>>>> +so,
>>>> set
>>>>> +	 * spi->cs_index_mask as 0x01.
>>>>> +	 */
>>>>> +	spi->cs_index_mask = 0x01;
>>>>>
>>>>>     	/* Device speed */
>>>>>     	if (!of_property_read_u32(nc, "spi-max-frequency", &value)) @@
>>>>> -3100,6 +3206,7 @@ int spi_register_controller(struct spi_controller *ctlr)
>>>>>     	struct boardinfo	*bi;
>>>>>     	int			first_dynamic;
>>>>>     	int			status;
>>>>> +	int			idx;
>>>>>
>>>>>     	if (!dev)
>>>>>     		return -ENODEV;
>>>>> @@ -3164,7 +3271,8 @@ int spi_register_controller(struct
>>>>> spi_controller
>>>> *ctlr)
>>>>>     	}
>>>>>
>>>>>     	/* Setting last_cs to -1 means no chip selected */
>>>>> -	ctlr->last_cs = -1;
>>>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
>>>>> +		ctlr->last_cs[idx] = -1;
>>>>>
>>>>>     	status = device_add(&ctlr->dev);
>>>>>     	if (status < 0)
>>>>> @@ -3889,7 +3997,7 @@ static int __spi_validate(struct spi_device
>>>>> *spi,
>>>> struct spi_message *message)
>>>>>     	 * cs_change is set for each transfer.
>>>>>     	 */
>>>>>     	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits &
>>>> SPI_CS_WORD) ||
>>>>> -					  spi_get_csgpiod(spi, 0))) {
>>>>> +					  spi_is_csgpiod(spi))) {
>>>>>     		size_t maxsize = BITS_TO_BYTES(spi->bits_per_word);
>>>>>     		int ret;
>>>>>
>>>>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h index
>>>>> 7b4baff63c5c..871d3a6d879b 100644
>>>>> --- a/include/linux/spi/spi.h
>>>>> +++ b/include/linux/spi/spi.h
>>>>> @@ -20,6 +20,9 @@
>>>>>
>>>>>     #include <uapi/linux/spi/spi.h>
>>>>>
>>>>> +/* Max no. of CS supported per spi device */ #define SPI_CS_CNT_MAX
>>>>> +4
>>>>> +
>>>>>     struct dma_chan;
>>>>>     struct software_node;
>>>>>     struct ptp_system_timestamp;
>>>>> @@ -132,7 +135,8 @@ extern void
>>>> spi_transfer_cs_change_delay_exec(struct spi_message *msg,
>>>>>      * @max_speed_hz: Maximum clock rate to be used with this chip
>>>>>      *	(on this board); may be changed by the device's driver.
>>>>>      *	The spi_transfer.speed_hz can override this for each transfer.
>>>>> - * @chip_select: Chipselect, distinguishing chips handled by @controller.
>>>>> + * @chip_select: Array of physical chipselect, spi->chipselect[i] gives
>>>>> + *	the corresponding physical CS for logical CS i.
>>>>>      * @mode: The spi mode defines how data is clocked out and in.
>>>>>      *	This may be changed by the device's driver.
>>>>>      *	The "active low" default for chipselect mode can be overridden
>>>>> @@ -157,8 +161,8 @@ extern void
>>>> spi_transfer_cs_change_delay_exec(struct spi_message *msg,
>>>>>      *	the device will bind to the named driver and only the named driver.
>>>>>      *	Do not set directly, because core frees it; use driver_set_override() to
>>>>>      *	set or clear it.
>>>>> - * @cs_gpiod: GPIO descriptor of the chipselect line (optional, NULL
>> when
>>>>> - *	not using a GPIO line)
>>>>> + * @cs_gpiod: Array of GPIO descriptors of the corresponding
>>>>> + chipselect
>>>> lines
>>>>> + *	(optional, NULL when not using a GPIO line)
>>>>>      * @word_delay: delay to be inserted between consecutive
>>>>>      *	words of a transfer
>>>>>      * @cs_setup: delay to be introduced by the controller after CS
>>>>> is asserted @@ -167,6 +171,7 @@ extern void
>>>> spi_transfer_cs_change_delay_exec(struct spi_message *msg,
>>>>>      *	deasserted. If @cs_change_delay is used from @spi_transfer, then
>>>> the
>>>>>      *	two delays will be added up.
>>>>>      * @pcpu_statistics: statistics for the spi_device
>>>>> + * @cs_index_mask: Bit mask of the active chipselect(s) in the
>>>>> + chipselect array
>>>>>      *
>>>>>      * A @spi_device is used to interchange data between an SPI slave
>>>>>      * (usually a discrete chip) and CPU memory.
>>>>> @@ -182,7 +187,7 @@ struct spi_device {
>>>>>     	struct spi_controller	*controller;
>>>>>     	struct spi_controller	*master;	/* Compatibility layer */
>>>>>     	u32			max_speed_hz;
>>>>> -	u8			chip_select;
>>>>> +	u8			chip_select[SPI_CS_CNT_MAX];
>>>>>     	u8			bits_per_word;
>>>>>     	bool			rt;
>>>>>     #define SPI_NO_TX		BIT(31)		/* No transmit wire */
>>>>> @@ -213,7 +218,7 @@ struct spi_device {
>>>>>     	void			*controller_data;
>>>>>     	char			modalias[SPI_NAME_SIZE];
>>>>>     	const char		*driver_override;
>>>>> -	struct gpio_desc	*cs_gpiod;	/* Chip select GPIO descriptor
>>>> */
>>>>> +	struct gpio_desc	*cs_gpiod[SPI_CS_CNT_MAX];	/* Chip select
>>>> gpio desc */
>>>>>     	struct spi_delay	word_delay; /* Inter-word delay */
>>>>>     	/* CS delays */
>>>>>     	struct spi_delay	cs_setup;
>>>>> @@ -223,6 +228,13 @@ struct spi_device {
>>>>>     	/* The statistics */
>>>>>     	struct spi_statistics __percpu	*pcpu_statistics;
>>>>>
>>>>> +	/* Bit mask of the chipselect(s) that the driver need to use from
>>>>> +	 * the chipselect array.When the controller is capable to handle
>>>>> +	 * multiple chip selects & memories are connected in parallel
>>>>> +	 * then more than one bit need to be set in cs_index_mask.
>>>>> +	 */
>>>>> +	u32			cs_index_mask : SPI_CS_CNT_MAX;
>>>>> +
>>>>>     	/*
>>>>>     	 * Likely need more hooks for more protocol options affecting how
>>>>>     	 * the controller talks to each chip, like:
>>>>> @@ -279,22 +291,33 @@ static inline void *spi_get_drvdata(const
>>>>> struct spi_device *spi)
>>>>>
>>>>>     static inline u8 spi_get_chipselect(const struct spi_device *spi, u8 idx)
>>>>>     {
>>>>> -	return spi->chip_select;
>>>>> +	return spi->chip_select[idx];
>>>>>     }
>>>>>
>>>>>     static inline void spi_set_chipselect(struct spi_device *spi, u8
>>>>> idx, u8
>>>> chipselect)
>>>>>     {
>>>>> -	spi->chip_select = chipselect;
>>>>> +	spi->chip_select[idx] = chipselect;
>>>>>     }
>>>>>
>>>>>     static inline struct gpio_desc *spi_get_csgpiod(const struct
>>>>> spi_device *spi,
>>>> u8 idx)
>>>>>     {
>>>>> -	return spi->cs_gpiod;
>>>>> +	return spi->cs_gpiod[idx];
>>>>>     }
>>>>>
>>>>>     static inline void spi_set_csgpiod(struct spi_device *spi, u8
>>>>> idx, struct
>>>> gpio_desc *csgpiod)
>>>>>     {
>>>>> -	spi->cs_gpiod = csgpiod;
>>>>> +	spi->cs_gpiod[idx] = csgpiod;
>>>>> +}
>>>>> +
>>>>> +static inline bool spi_is_csgpiod(struct spi_device *spi) {
>>>>> +	u8 idx;
>>>>> +
>>>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>> +		if (spi_get_csgpiod(spi, idx))
>>>>> +			return true;
>>>>> +	}
>>>>> +	return false;
>>>>>     }
>>>>>
>>>>>     /**
>>>>> @@ -399,6 +422,8 @@ extern struct spi_device
>>>> *spi_new_ancillary_device(struct spi_device *spi, u8 ch
>>>>>      * @bus_lock_spinlock: spinlock for SPI bus locking
>>>>>      * @bus_lock_mutex: mutex for exclusion of multiple callers
>>>>>      * @bus_lock_flag: indicates that the SPI bus is locked for
>>>>> exclusive use
>>>>> + * @multi_cs_cap: indicates that the SPI Controller can assert/de-assert
>>>>> + *	more than one chip select at once.
>>>>>      * @setup: updates the device mode and clocking records used by a
>>>>>      *	device's SPI controller; protocol code may call this.  This
>>>>>      *	must fail if an unrecognized or unsupported mode is requested.
>>>>> @@ -567,6 +592,11 @@ struct spi_controller {
>>>>>     #define SPI_CONTROLLER_MUST_TX		BIT(4)	/* Requires tx
>> */
>>>>>     #define SPI_CONTROLLER_GPIO_SS		BIT(5)	/* GPIO CS
>> must
>>>> select slave */
>>>>>     #define SPI_CONTROLLER_SUSPENDED	BIT(6)	/* Currently
>>>> suspended */
>>>>> +	/*
>>>>> +	 * The spi-controller has multi chip select capability and can
>>>>> +	 * assert/de-assert more than one chip select at once.
>>>>> +	 */
>>>>> +#define SPI_CONTROLLER_MULTI_CS		BIT(7)
>>>>>
>>>>>     	/* Flag indicating if the allocation of this struct is devres-managed */
>>>>>     	bool			devm_allocated;
>>>>> @@ -677,7 +707,8 @@ struct spi_controller {
>>>>>     	bool				rt;
>>>>>     	bool				auto_runtime_pm;
>>>>>     	bool				cur_msg_mapped;
>>>>> -	char				last_cs;
>>>>> +	char				last_cs[SPI_CS_CNT_MAX];
>>>>> +	char				last_cs_index_mask;
>>>>>     	bool				last_cs_mode_high;
>>>>>     	bool                            fallback;
>>>>>     	struct completion               xfer_completion;
--------------XtTI47P0lSXzOpt1a7UfDNYn
Content-Type: text/plain; charset="UTF-8"; name="dmesg.log"
Content-Disposition: attachment; filename="dmesg.log"
Content-Transfer-Encoding: base64

WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA2LjcuMC1yYzEtbmV4dC0yMDIzMTExNSsg
KHNiaW5kaW5nQHNiaW5kaW5nLWNpcnJ1cy1kc2t0cDIpIChnY2MgKFVidW50dSAxMS40LjAt
MXVidW50dTF+MjIuMDQpIDExLjQuMCwgR05VIGxkIChHTlUgQmludXRpbHMgZm9yIFVidW50
dSkgMi4zOCkgIzczOCBTTVAgUFJFRU1QVF9EWU5BTUlDIFR1ZSBOb3YgMjEgMTc6MTE6NTUg
R01UIDIwMjMKWyAgICAwLjAwMDAwMF0gQ29tbWFuZCBsaW5lOiBCT09UX0lNQUdFPS9ib290
L3ZtbGludXotNi43LjAtcmMxLW5leHQtMjAyMzExMTUrIHJvb3Q9VVVJRD0wNjE1MDJhOS0y
MDVlLTRiNzMtODI1MS0xMjIwZTc3MGM1ZDggcm8gcXVpZXQgc3BsYXNoIHBjaWVfYXNwbT1v
ZmYgbG9nX2J1Zl9sZW49MTBNIHRyYWNlX2V2ZW50PWdwaW86KiB2dC5oYW5kb2ZmPTcKWyAg
ICAwLjAwMDAwMF0gS0VSTkVMIHN1cHBvcnRlZCBjcHVzOgpbICAgIDAuMDAwMDAwXSAgIElu
dGVsIEdlbnVpbmVJbnRlbApbICAgIDAuMDAwMDAwXSAgIEFNRCBBdXRoZW50aWNBTUQKWyAg
ICAwLjAwMDAwMF0gICBIeWdvbiBIeWdvbkdlbnVpbmUKWyAgICAwLjAwMDAwMF0gICBDZW50
YXVyIENlbnRhdXJIYXVscwpbICAgIDAuMDAwMDAwXSAgIHpoYW94aW4gICBTaGFuZ2hhaSAg
ClsgICAgMC4wMDAwMDBdIHg4Ni9zcGxpdCBsb2NrIGRldGVjdGlvbjogI0FDOiBjcmFzaGlu
ZyB0aGUga2VybmVsIG9uIGtlcm5lbCBzcGxpdF9sb2NrcyBhbmQgd2FybmluZyBvbiB1c2Vy
LXNwYWNlIHNwbGl0X2xvY2tzClsgICAgMC4wMDAwMDBdIEJJT1MtcHJvdmlkZWQgcGh5c2lj
YWwgUkFNIG1hcDoKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAw
MDAwMDAwMC0weDAwMDAwMDAwMDAwOWVmZmZdIHVzYWJsZQpbICAgIDAuMDAwMDAwXSBCSU9T
LWU4MjA6IFttZW0gMHgwMDAwMDAwMDAwMDlmMDAwLTB4MDAwMDAwMDAwMDBmZmZmZl0gcmVz
ZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAwMDEwMDAw
MC0weDAwMDAwMDAwM2I4ZGNmZmZdIHVzYWJsZQpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6
IFttZW0gMHgwMDAwMDAwMDNiOGRkMDAwLTB4MDAwMDAwMDA0MTkzM2ZmZl0gcmVzZXJ2ZWQK
WyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDA0MTkzNDAwMC0weDAw
MDAwMDAwNDFiMzNmZmZdIEFDUEkgTlZTClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21l
bSAweDAwMDAwMDAwNDFiMzQwMDAtMHgwMDAwMDAwMDQxYmZlZmZmXSBBQ1BJIGRhdGEKWyAg
ICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDA0MWJmZjAwMC0weDAwMDAw
MDAwNDFiZmZmZmZdIHVzYWJsZQpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgw
MDAwMDAwMDQxYzAwMDAwLTB4MDAwMDAwMDA0N2ZmZmZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAw
MDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDA0OTQwMDAwMC0weDAwMDAwMDAwNDk1
ZmZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAw
MDAwNGMwMDAwMDAtMHgwMDAwMDAwMDU0N2ZmZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAw
XSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGMwMDAwMDAwLTB4MDAwMDAwMDBjZmZmZmZm
Zl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBm
ZWQyMDAwMC0weDAwMDAwMDAwZmVkN2ZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJ
T1MtZTgyMDogW21lbSAweDAwMDAwMDAwZmYwMDAwMDAtMHgwMDAwMDAwMGZmZmZmZmZmXSBy
ZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMTAwMDAw
MDAwLTB4MDAwMDAwMDhhYjdmZmZmZl0gdXNhYmxlClsgICAgMC4wMDAwMDBdIE5YIChFeGVj
dXRlIERpc2FibGUpIHByb3RlY3Rpb246IGFjdGl2ZQpbICAgIDAuMDAwMDAwXSBBUElDOiBT
dGF0aWMgY2FsbHMgaW5pdGlhbGl6ZWQKWyAgICAwLjAwMDAwMF0gZWZpOiBFRkkgdjIuNyBi
eSBIUApbICAgIDAuMDAwMDAwXSBlZmk6IEFDUEk9MHg0MWJmZTAwMCBBQ1BJIDIuMD0weDQx
YmZlMDE0IFRQTUZpbmFsTG9nPTB4NDFhNTAwMDAgU01CSU9TPTB4M2MwNGMwMDAgRVNSVD0w
eDNjMGE4MDk4IE1FTUFUVFI9MHgyZWM1MjAxOCBNT0t2YXI9MHgzYzA0YjAwMCBSTkc9MHg0
MWI0ZDAxOCBUUE1FdmVudExvZz0weDJlOWM2MDE4IApbICAgIDAuMDAwMDAwXSByYW5kb206
IGNybmcgaW5pdCBkb25lClsgICAgMC4wMDAwMDBdIGVmaTogUmVtb3ZlIG1lbTQ1MjogTU1J
TyByYW5nZT1bMHhjMDAwMDAwMC0weGNmZmZmZmZmXSAoMjU2TUIpIGZyb20gZTgyMCBtYXAK
WyAgICAwLjAwMDAwMF0gZTgyMDogcmVtb3ZlIFttZW0gMHhjMDAwMDAwMC0weGNmZmZmZmZm
XSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBlZmk6IFJlbW92ZSBtZW00NTQ6IE1NSU8gcmFu
Z2U9WzB4ZmYwMDAwMDAtMHhmZmZmZmZmZl0gKDE2TUIpIGZyb20gZTgyMCBtYXAKWyAgICAw
LjAwMDAwMF0gZTgyMDogcmVtb3ZlIFttZW0gMHhmZjAwMDAwMC0weGZmZmZmZmZmXSByZXNl
cnZlZApbICAgIDAuMDAwMDAwXSBTTUJJT1MgMy40IHByZXNlbnQuClsgICAgMC4wMDAwMDBd
IERNSTogSFAgSFAgWkJvb2sgRnVyeSAxNiBHOSBNb2JpbGUgV29ya3N0YXRpb24gUEMvODlD
NiwgQklPUyBVOTYgVmVyLiA5Mi4yNS4wMiAwOS8yMC8yMDIzClsgICAgMC4wMDAwMDBdIHRz
YzogRGV0ZWN0ZWQgMjQwMC4wMDAgTUh6IHByb2Nlc3NvcgpbICAgIDAuMDAwMDAwXSB0c2M6
IERldGVjdGVkIDI0MTkuMjAwIE1IeiBUU0MKWyAgICAwLjAwMDAwM10gZTgyMDogdXBkYXRl
IFttZW0gMHgwMDAwMDAwMC0weDAwMDAwZmZmXSB1c2FibGUgPT0+IHJlc2VydmVkClsgICAg
MC4wMDAwMDVdIGU4MjA6IHJlbW92ZSBbbWVtIDB4MDAwYTAwMDAtMHgwMDBmZmZmZl0gdXNh
YmxlClsgICAgMC4wMDAwMDldIGxhc3RfcGZuID0gMHg4YWI4MDAgbWF4X2FyY2hfcGZuID0g
MHg0MDAwMDAwMDAKWyAgICAwLjAwMDAxM10gdG90YWwgUkFNIGNvdmVyZWQ6IDYyNzIwTQpb
ICAgIDAuMDAwMDg2XSBGb3VuZCBvcHRpbWFsIHNldHRpbmcgZm9yIG10cnIgY2xlYW4gdXAK
WyAgICAwLjAwMDA4N10gIGdyYW5fc2l6ZTogNjRLIAljaHVua19zaXplOiA2NEsgCW51bV9y
ZWc6IDYgIAlsb3NlIGNvdmVyIFJBTTogMEcKWyAgICAwLjAwMDA4OV0gTVRSUiBtYXA6IDUg
ZW50cmllcyAoMyBmaXhlZCArIDIgdmFyaWFibGU7IG1heCAyMyksIGJ1aWx0IGZyb20gMTAg
dmFyaWFibGUgTVRSUnMKWyAgICAwLjAwMDA5MF0geDg2L1BBVDogQ29uZmlndXJhdGlvbiBb
MC03XTogV0IgIFdDICBVQy0gVUMgIFdCICBXUCAgVUMtIFdUICAKWyAgICAwLjAwMDUzOF0g
ZTgyMDogdXBkYXRlIFttZW0gMHg1MDAwMDAwMC0weGZmZmZmZmZmXSB1c2FibGUgPT0+IHJl
c2VydmVkClsgICAgMC4wMDA1NDBdIGxhc3RfcGZuID0gMHg0MWMwMCBtYXhfYXJjaF9wZm4g
PSAweDQwMDAwMDAwMApbICAgIDAuMDA1ODA2XSBlc3J0OiBSZXNlcnZpbmcgRVNSVCBzcGFj
ZSBmcm9tIDB4MDAwMDAwMDAzYzBhODA5OCB0byAweDAwMDAwMDAwM2MwYTgxNzAuClsgICAg
MC4wMDU4MzBdIFVzaW5nIEdCIHBhZ2VzIGZvciBkaXJlY3QgbWFwcGluZwpbICAgIDAuMDE0
OTIzXSBwcmludGs6IGxvZ19idWZfbGVuOiAxNjc3NzIxNiBieXRlcwpbICAgIDAuMDE0OTI0
XSBwcmludGs6IGVhcmx5IGxvZyBidWYgZnJlZTogMjU4NzIwKDk4JSkKWyAgICAwLjAxNDky
NV0gU2VjdXJlIGJvb3QgZGlzYWJsZWQKWyAgICAwLjAxNDkyNV0gUkFNRElTSzogW21lbSAw
eDI2MTkxMDAwLTB4MmE1ODRmZmZdClsgICAgMC4wMTQ5MjldIEFDUEk6IEVhcmx5IHRhYmxl
IGNoZWNrc3VtIHZlcmlmaWNhdGlvbiBkaXNhYmxlZApbICAgIDAuMDE0OTMyXSBBQ1BJOiBS
U0RQIDB4MDAwMDAwMDA0MUJGRTAxNCAwMDAwMjQgKHYwMiBIUFFPRU0pClsgICAgMC4wMTQ5
MzVdIEFDUEk6IFhTRFQgMHgwMDAwMDAwMDQxQjUyMjI4IDAwMDE5NCAodjAxIEhQUU9FTSBT
TElDLUJQQyAwMDAwMDAwMCAgICAgIDAxMDAwMDEzKQpbICAgIDAuMDE0OTM5XSBBQ1BJOiBG
QUNQIDB4MDAwMDAwMDA0MUJEQjAwMCAwMDAxMTQgKHYwNiBIUFFPRU0gU0xJQy1CUEMgMDAw
MDAwMDAgSFAgICAwMDAwMDAwMSkKWyAgICAwLjAxNDk0M10gQUNQSTogRFNEVCAweDAwMDAw
MDAwNDFCODUwMDAgMDUyRTA5ICh2MDIgSFBRT0VNIDg5QzYgICAgIDAwMDAwMDAwIElOVEwg
MjAyMDA3MTcpClsgICAgMC4wMTQ5NDVdIEFDUEk6IEZBQ1MgMHgwMDAwMDAwMDQxQTJEMDAw
IDAwMDA0MApbICAgIDAuMDE0OTQ3XSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDA0MUJGQzAwMCAw
MDBGREYgKHYwMiBIUCAgICAgUFNFTldTQVIgMDAwMDEwMDAgSU5UTCAyMDIwMDcxNykKWyAg
ICAwLjAxNDk0OV0gQUNQSTogUlRNQSAweDAwMDAwMDAwNDFCRkIwMDAgMDAwMDlFICh2MDEg
SFAgICAgIF9IQk1BUlRfIDAwMDAxMDAwIEhQICAgMDAwMDAwMDEpClsgICAgMC4wMTQ5NTFd
IEFDUEk6IFNTRFQgMHgwMDAwMDAwMDQxQkY5MDAwIDAwMTdCMyAodjAyIEhQICAgICBVY3Np
QWNwaSAwMDAwMDAwMSBJTlRMIDIwMjAwNzE3KQpbICAgIDAuMDE0OTUyXSBBQ1BJOiBTU0RU
IDB4MDAwMDAwMDA0MUJGODAwMCAwMDAwRkIgKHYwMiBIUCAgICAgVWNzaUNudHIgMDAwMDAw
MDEgSU5UTCAyMDIwMDcxNykKWyAgICAwLjAxNDk1NF0gQUNQSTogU1NEVCAweDAwMDAwMDAw
NDFCRjcwMDAgMDAwMkQ3ICh2MDIgSFAgICAgIE5WVEVDICAgIDAwMDAwMDAxIElOVEwgMjAy
MDA3MTcpClsgICAgMC4wMTQ5NTZdIEFDUEk6IFNTRFQgMHgwMDAwMDAwMDQxQkY2MDAwIDAw
MDEzRSAodjAyIEhQICAgICBTaG1UYWJsZSAwMDAwMDAwMSBJTlRMIDIwMjAwNzE3KQpbICAg
IDAuMDE0OTU4XSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDA0MUJGNTAwMCAwMDAzOEMgKHYwMiBQ
bWF4RHYgUG1heF9EZXYgMDAwMDAwMDEgSU5UTCAyMDIwMDcxNykKWyAgICAwLjAxNDk1OV0g
QUNQSTogU1NEVCAweDAwMDAwMDAwNDFCRUYwMDAgMDA1RDM0ICh2MDIgQ3B1UmVmIENwdVNz
ZHQgIDAwMDAzMDAwIElOVEwgMjAyMDA3MTcpClsgICAgMC4wMTQ5NjFdIEFDUEk6IE9FTUwg
MHgwMDAwMDAwMDQxQkVFMDAwIDAwMDAyOCAodjAzIEhQUU9FTSBBREwgICAgICAwMDAwMDAw
MiAgICAgIDAxMDAwMDEzKQpbICAgIDAuMDE0OTYzXSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDA0
MUJFQzAwMCAwMDFEOEEgKHYwMiBIUCAgICAgTEFQVE9QUEMgMDAwMDEwMDAgSU5UTCAyMDIw
MDcxNykKWyAgICAwLjAxNDk2NV0gQUNQSTogU1NEVCAweDAwMDAwMDAwNDFCRTcwMDAgMDAz
MjU2ICh2MDIgSU5URUwgIERUYnRTc2R0IDAwMDAxMDAwIElOVEwgMjAyMDA3MTcpClsgICAg
MC4wMTQ5NjZdIEFDUEk6IFNTRFQgMHgwMDAwMDAwMDQxQkU2MDAwIDAwMDVGQiAodjAyIEhQ
UU9FTSBUcG0yVGFibCAwMDAwMTAwMCBJTlRMIDIwMjAwNzE3KQpbICAgIDAuMDE0OTY4XSBB
Q1BJOiBUUE0yIDB4MDAwMDAwMDA0MUJFNTAwMCAwMDAwNEMgKHYwNCBIUFFPRU0gQURMICAg
ICAgMDAwMDAwMDIgICAgICAwMTAwMDAxMykKWyAgICAwLjAxNDk3MF0gQUNQSTogU1NEVCAw
eDAwMDAwMDAwNDFCRTIwMDAgMDAyQjI2ICh2MDIgU2FTc2R0IFNhU3NkdCAgIDAwMDAzMDAw
IElOVEwgMjAyMDA3MTcpClsgICAgMC4wMTQ5NzJdIEFDUEk6IFNTRFQgMHgwMDAwMDAwMDQx
QkRFMDAwIDAwMzNDNCAodjAyIElOVEVMICBJZ2Z4U3NkdCAwMDAwMzAwMCBJTlRMIDIwMjAw
NzE3KQpbICAgIDAuMDE0OTczXSBBQ1BJOiBNU0RNIDB4MDAwMDAwMDA0MUJERDAwMCAwMDAw
NTUgKHYwMyBIUFFPRU0gU0xJQy1CUEMgMDAwMDAwMDAgSFAgICAwMDAwMDAwMSkKWyAgICAw
LjAxNDk3NV0gQUNQSTogV1NNVCAweDAwMDAwMDAwNDFCREMwMDAgMDAwMDI4ICh2MDEgSFBR
T0VNIDg5QzYgICAgIDAwMDAwMDAxIEhQICAgMDAwMDAwMDEpClsgICAgMC4wMTQ5NzddIEFD
UEk6IEhQRVQgMHgwMDAwMDAwMDQxQkRBMDAwIDAwMDAzOCAodjAxIEhQUU9FTSA4OUM2ICAg
ICAwMDAwMDAwMSBIUCAgIDAwMDAwMDAxKQpbICAgIDAuMDE0OTc5XSBBQ1BJOiBBUElDIDB4
MDAwMDAwMDA0MUJEOTAwMCAwMDAxREMgKHYwNSBIUFFPRU0gODlDNiAgICAgMDAwMDAwMDEg
SFAgICAwMDAwMDAwMSkKWyAgICAwLjAxNDk4MF0gQUNQSTogTUNGRyAweDAwMDAwMDAwNDFC
RkQwMDAgMDAwMDNDICh2MDEgSFBRT0VNIDg5QzYgICAgIDAwMDAwMDAxIEhQICAgMDAwMDAw
MDEpClsgICAgMC4wMTQ5ODJdIEFDUEk6IFNTRFQgMHgwMDAwMDAwMDQxQjg0MDAwIDAwMDlE
OSAodjAyIEhQUU9FTSBIUF9YSENfUCAwMDAwMDAwMCBJTlRMIDIwMjAwNzE3KQpbICAgIDAu
MDE0OTg0XSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDA0MUI3RDAwMCAwMDZCMDYgKHYwMiBEcHRm
VGIgRHB0ZlRhYmwgMDAwMDEwMDAgSU5UTCAyMDIwMDcxNykKWyAgICAwLjAxNDk4Nl0gQUNQ
STogTFBJVCAweDAwMDAwMDAwNDFCN0MwMDAgMDAwMENDICh2MDEgSFBRT0VNICAgICAgICAg
IDAwMDAwMDAwICAgICAgMDAwMDAwMDApClsgICAgMC4wMTQ5ODddIEFDUEk6IFdTTVQgMHgw
MDAwMDAwMDQxQjdCMDAwIDAwMDAyOCAodjAxIEhQUU9FTSAgICAgICAgICAwMDAwMDAwMCAg
ICAgIDAwMDAwMDAwKQpbICAgIDAuMDE0OTg5XSBBQ1BJOiBOSExUIDB4MDAwMDAwMDA0MUI3
OTAwMCAwMDFCMzUgKHYwMCBIUFFPRU0gQURMICAgICAgMDAwMDAwMDIgICAgICAwMTAwMDAx
MykKWyAgICAwLjAxNDk5MV0gQUNQSTogRE1BUiAweDAwMDAwMDAwNDFCNzgwMDAgMDAwMDg4
ICh2MDEgSU5URUwgIEFETCAgICAgIDAwMDAwMDAyIElOVEwgMDEwMDAwMTMpClsgICAgMC4w
MTQ5OTNdIEFDUEk6IEZQRFQgMHgwMDAwMDAwMDQxQjc3MDAwIDAwMDA0NCAodjAxIEhQUU9F
TSBBREwgICAgICAwMDAwMDAwMiAgICAgIDAxMDAwMDEzKQpbICAgIDAuMDE0OTk0XSBBQ1BJ
OiBTU0RUIDB4MDAwMDAwMDA0MUI3MzAwMCAwMDM5REEgKHYwMiBTb2NHcGUgU29jR3BlICAg
MDAwMDMwMDAgSU5UTCAyMDIwMDcxNykKWyAgICAwLjAxNDk5Nl0gQUNQSTogU1NEVCAweDAw
MDAwMDAwNDFCNkYwMDAgMDAzOURBICh2MDIgU29jQ21uIFNvY0NtbiAgIDAwMDAzMDAwIElO
VEwgMjAyMDA3MTcpClsgICAgMC4wMTQ5OThdIEFDUEk6IFNTRFQgMHgwMDAwMDAwMDQxQjZF
MDAwIDAwMDJDNyAodjAyIEhQICAgICBIUE5CQ09OViAwMDAwMTAwMCBJTlRMIDIwMjAwNzE3
KQpbICAgIDAuMDE1MDAwXSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDA0MUI2RDAwMCAwMDA0MzUg
KHYwMiBIUCAgICAgSU5UVFBMICAgMDAwMDEwMDAgSU5UTCAyMDIwMDcxNykKWyAgICAwLjAx
NTAwMV0gQUNQSTogU1NEVCAweDAwMDAwMDAwNDFCNjQwMDAgMDA4NjU4ICh2MDIgSFAgICAg
IEhQRFRCVCAgIDAwMDAxMDAwIElOVEwgMjAyMDA3MTcpClsgICAgMC4wMTUwMDNdIEFDUEk6
IFNTRFQgMHgwMDAwMDAwMDQxQjYxMDAwIDAwMjRDQSAodjAyIFJ0ZDMgICBBZGxTQlRidCAw
MDAwMTAwMCBJTlRMIDIwMjAwNzE3KQpbICAgIDAuMDE1MDA1XSBBQ1BJOiBTU0RUIDB4MDAw
MDAwMDA0MUI1QzAwMCAwMDQ4M0MgKHYwMSBIUCAgICAgTlZIRyAgICAgMDAwMDEwMDAgSU5U
TCAyMDIwMDcxNykKWyAgICAwLjAxNTAwN10gQUNQSTogU1NEVCAweDAwMDAwMDAwNDFCNUIw
MDAgMDAwNTIyICh2MDEgSFAgICAgIE5WUE9XRVJDIDAwMDAxMDAwIElOVEwgMjAyMDA3MTcp
ClsgICAgMC4wMTUwMDhdIEFDUEk6IFNTRFQgMHgwMDAwMDAwMDQxQjU3MDAwIDAwM0E0QSAo
djAyIEhQICAgICBIUElOTkJXTCAwMDAwMTAwMCBJTlRMIDIwMjAwNzE3KQpbICAgIDAuMDE1
MDEwXSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDA0MUI1NjAwMCAwMDAwMzIgKHYwMiBIUCAgICAg
SFBDT05ERVYgMDAwMDEwMDAgSU5UTCAyMDIwMDcxNykKWyAgICAwLjAxNTAxMl0gQUNQSTog
U1NEVCAweDAwMDAwMDAwNDFCNTUwMDAgMDAwMTE2ICh2MDIgSFAgICAgIEhQU0FOSU1EIDAw
MDAxMDAwIElOVEwgMjAyMDA3MTcpClsgICAgMC4wMTUwMTRdIEFDUEk6IFNTRFQgMHgwMDAw
MDAwMDQxQjUzMDAwIDAwMTAyNyAodjAyIEhQICAgICBIUElOVEVMRyAwMDAwMTAwMCBJTlRM
IDIwMjAwNzE3KQpbICAgIDAuMDE1MDE1XSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDA0MUJEODAw
MCAwMDAwNjkgKHYwMiBIUCAgICAgSFBDQUhXSUQgMDAwMDEwMDAgSU5UTCAyMDIwMDcxNykK
WyAgICAwLjAxNTAxN10gQUNQSTogU1NEVCAweDAwMDAwMDAwNDFCNTEwMDAgMDAwMDRCICh2
MDEgSFAgICAgIENBUEFIV0lEIDAwMDAxMDAwIElOVEwgMjAyMDA3MTcpClsgICAgMC4wMTUw
MTldIEFDUEk6IEJHUlQgMHgwMDAwMDAwMDQxQjRGMDAwIDAwMDAzOCAodjAxIEhQUU9FTSBB
REwgICAgICAwMDAwMDAwMiAgICAgIDAxMDAwMDEzKQpbICAgIDAuMDE1MDIxXSBBQ1BJOiBB
U0YhIDB4MDAwMDAwMDA0MUI1MDAwMCAwMDAwQTAgKHYzMiBIUFFPRU0gIFVZQU1JSEMgMDAw
MDAwMDIgICAgICAwMTAwMDAxMykKWyAgICAwLjAxNTAyMl0gQUNQSTogUEhBVCAweDAwMDAw
MDAwNDFCNEUwMDAgMDAwNEVBICh2MDEgSFBRT0VNIFNMSUMtQlBDIDAwMDAwMDA1IE1TRlQg
MDEwMDAwMEQpClsgICAgMC4wMTUwMjRdIEFDUEk6IFNTRFQgMHgwMDAwMDAwMDQxQkVCMDAw
IDAwMDJGOSAodjAyIEhQICAgICBQd3JDdGxFdiAwMDAwMDAwMSBJTlRMIDIwMjAwNzE3KQpb
ICAgIDAuMDE1MDI1XSBBQ1BJOiBSZXNlcnZpbmcgRkFDUCB0YWJsZSBtZW1vcnkgYXQgW21l
bSAweDQxYmRiMDAwLTB4NDFiZGIxMTNdClsgICAgMC4wMTUwMjZdIEFDUEk6IFJlc2Vydmlu
ZyBEU0RUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4NDFiODUwMDAtMHg0MWJkN2UwOF0KWyAg
ICAwLjAxNTAyN10gQUNQSTogUmVzZXJ2aW5nIEZBQ1MgdGFibGUgbWVtb3J5IGF0IFttZW0g
MHg0MWEyZDAwMC0weDQxYTJkMDNmXQpbICAgIDAuMDE1MDI3XSBBQ1BJOiBSZXNlcnZpbmcg
U1NEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDQxYmZjMDAwLTB4NDFiZmNmZGVdClsgICAg
MC4wMTUwMjhdIEFDUEk6IFJlc2VydmluZyBSVE1BIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4
NDFiZmIwMDAtMHg0MWJmYjA5ZF0KWyAgICAwLjAxNTAyOF0gQUNQSTogUmVzZXJ2aW5nIFNT
RFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg0MWJmOTAwMC0weDQxYmZhN2IyXQpbICAgIDAu
MDE1MDI5XSBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDQx
YmY4MDAwLTB4NDFiZjgwZmFdClsgICAgMC4wMTUwMjldIEFDUEk6IFJlc2VydmluZyBTU0RU
IHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4NDFiZjcwMDAtMHg0MWJmNzJkNl0KWyAgICAwLjAx
NTAzMF0gQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg0MWJm
NjAwMC0weDQxYmY2MTNkXQpbICAgIDAuMDE1MDMwXSBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0
YWJsZSBtZW1vcnkgYXQgW21lbSAweDQxYmY1MDAwLTB4NDFiZjUzOGJdClsgICAgMC4wMTUw
MzBdIEFDUEk6IFJlc2VydmluZyBTU0RUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4NDFiZWYw
MDAtMHg0MWJmNGQzM10KWyAgICAwLjAxNTAzMV0gQUNQSTogUmVzZXJ2aW5nIE9FTUwgdGFi
bGUgbWVtb3J5IGF0IFttZW0gMHg0MWJlZTAwMC0weDQxYmVlMDI3XQpbICAgIDAuMDE1MDMx
XSBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDQxYmVjMDAw
LTB4NDFiZWRkODldClsgICAgMC4wMTUwMzJdIEFDUEk6IFJlc2VydmluZyBTU0RUIHRhYmxl
IG1lbW9yeSBhdCBbbWVtIDB4NDFiZTcwMDAtMHg0MWJlYTI1NV0KWyAgICAwLjAxNTAzMl0g
QUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg0MWJlNjAwMC0w
eDQxYmU2NWZhXQpbICAgIDAuMDE1MDMzXSBBQ1BJOiBSZXNlcnZpbmcgVFBNMiB0YWJsZSBt
ZW1vcnkgYXQgW21lbSAweDQxYmU1MDAwLTB4NDFiZTUwNGJdClsgICAgMC4wMTUwMzNdIEFD
UEk6IFJlc2VydmluZyBTU0RUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4NDFiZTIwMDAtMHg0
MWJlNGIyNV0KWyAgICAwLjAxNTAzM10gQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVt
b3J5IGF0IFttZW0gMHg0MWJkZTAwMC0weDQxYmUxM2MzXQpbICAgIDAuMDE1MDM0XSBBQ1BJ
OiBSZXNlcnZpbmcgTVNETSB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDQxYmRkMDAwLTB4NDFi
ZGQwNTRdClsgICAgMC4wMTUwMzRdIEFDUEk6IFJlc2VydmluZyBXU01UIHRhYmxlIG1lbW9y
eSBhdCBbbWVtIDB4NDFiZGMwMDAtMHg0MWJkYzAyN10KWyAgICAwLjAxNTAzNV0gQUNQSTog
UmVzZXJ2aW5nIEhQRVQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg0MWJkYTAwMC0weDQxYmRh
MDM3XQpbICAgIDAuMDE1MDM1XSBBQ1BJOiBSZXNlcnZpbmcgQVBJQyB0YWJsZSBtZW1vcnkg
YXQgW21lbSAweDQxYmQ5MDAwLTB4NDFiZDkxZGJdClsgICAgMC4wMTUwMzVdIEFDUEk6IFJl
c2VydmluZyBNQ0ZHIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4NDFiZmQwMDAtMHg0MWJmZDAz
Yl0KWyAgICAwLjAxNTAzNl0gQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0
IFttZW0gMHg0MWI4NDAwMC0weDQxYjg0OWQ4XQpbICAgIDAuMDE1MDM2XSBBQ1BJOiBSZXNl
cnZpbmcgU1NEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDQxYjdkMDAwLTB4NDFiODNiMDVd
ClsgICAgMC4wMTUwMzddIEFDUEk6IFJlc2VydmluZyBMUElUIHRhYmxlIG1lbW9yeSBhdCBb
bWVtIDB4NDFiN2MwMDAtMHg0MWI3YzBjYl0KWyAgICAwLjAxNTAzN10gQUNQSTogUmVzZXJ2
aW5nIFdTTVQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg0MWI3YjAwMC0weDQxYjdiMDI3XQpb
ICAgIDAuMDE1MDM4XSBBQ1BJOiBSZXNlcnZpbmcgTkhMVCB0YWJsZSBtZW1vcnkgYXQgW21l
bSAweDQxYjc5MDAwLTB4NDFiN2FiMzRdClsgICAgMC4wMTUwMzhdIEFDUEk6IFJlc2Vydmlu
ZyBETUFSIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4NDFiNzgwMDAtMHg0MWI3ODA4N10KWyAg
ICAwLjAxNTAzOF0gQUNQSTogUmVzZXJ2aW5nIEZQRFQgdGFibGUgbWVtb3J5IGF0IFttZW0g
MHg0MWI3NzAwMC0weDQxYjc3MDQzXQpbICAgIDAuMDE1MDM5XSBBQ1BJOiBSZXNlcnZpbmcg
U1NEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDQxYjczMDAwLTB4NDFiNzY5ZDldClsgICAg
MC4wMTUwMzldIEFDUEk6IFJlc2VydmluZyBTU0RUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4
NDFiNmYwMDAtMHg0MWI3MjlkOV0KWyAgICAwLjAxNTA0MF0gQUNQSTogUmVzZXJ2aW5nIFNT
RFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg0MWI2ZTAwMC0weDQxYjZlMmM2XQpbICAgIDAu
MDE1MDQwXSBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDQx
YjZkMDAwLTB4NDFiNmQ0MzRdClsgICAgMC4wMTUwNDBdIEFDUEk6IFJlc2VydmluZyBTU0RU
IHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4NDFiNjQwMDAtMHg0MWI2YzY1N10KWyAgICAwLjAx
NTA0MV0gQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg0MWI2
MTAwMC0weDQxYjYzNGM5XQpbICAgIDAuMDE1MDQxXSBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0
YWJsZSBtZW1vcnkgYXQgW21lbSAweDQxYjVjMDAwLTB4NDFiNjA4M2JdClsgICAgMC4wMTUw
NDJdIEFDUEk6IFJlc2VydmluZyBTU0RUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4NDFiNWIw
MDAtMHg0MWI1YjUyMV0KWyAgICAwLjAxNTA0Ml0gQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFi
bGUgbWVtb3J5IGF0IFttZW0gMHg0MWI1NzAwMC0weDQxYjVhYTQ5XQpbICAgIDAuMDE1MDQz
XSBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDQxYjU2MDAw
LTB4NDFiNTYwMzFdClsgICAgMC4wMTUwNDNdIEFDUEk6IFJlc2VydmluZyBTU0RUIHRhYmxl
IG1lbW9yeSBhdCBbbWVtIDB4NDFiNTUwMDAtMHg0MWI1NTExNV0KWyAgICAwLjAxNTA0M10g
QUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg0MWI1MzAwMC0w
eDQxYjU0MDI2XQpbICAgIDAuMDE1MDQ0XSBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0YWJsZSBt
ZW1vcnkgYXQgW21lbSAweDQxYmQ4MDAwLTB4NDFiZDgwNjhdClsgICAgMC4wMTUwNDRdIEFD
UEk6IFJlc2VydmluZyBTU0RUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4NDFiNTEwMDAtMHg0
MWI1MTA0YV0KWyAgICAwLjAxNTA0NV0gQUNQSTogUmVzZXJ2aW5nIEJHUlQgdGFibGUgbWVt
b3J5IGF0IFttZW0gMHg0MWI0ZjAwMC0weDQxYjRmMDM3XQpbICAgIDAuMDE1MDQ1XSBBQ1BJ
OiBSZXNlcnZpbmcgQVNGISB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDQxYjUwMDAwLTB4NDFi
NTAwOWZdClsgICAgMC4wMTUwNDZdIEFDUEk6IFJlc2VydmluZyBQSEFUIHRhYmxlIG1lbW9y
eSBhdCBbbWVtIDB4NDFiNGUwMDAtMHg0MWI0ZTRlOV0KWyAgICAwLjAxNTA0Nl0gQUNQSTog
UmVzZXJ2aW5nIFNTRFQgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg0MWJlYjAwMC0weDQxYmVi
MmY4XQpbICAgIDAuMDE1MzcxXSBObyBOVU1BIGNvbmZpZ3VyYXRpb24gZm91bmQKWyAgICAw
LjAxNTM3Ml0gRmFraW5nIGEgbm9kZSBhdCBbbWVtIDB4MDAwMDAwMDAwMDAwMDAwMC0weDAw
MDAwMDA4YWI3ZmZmZmZdClsgICAgMC4wMTUzNzZdIE5PREVfREFUQSgwKSBhbGxvY2F0ZWQg
W21lbSAweDhhNmZkNTAwMC0weDhhNmZmZmZmZl0KWyAgICAwLjAxNTUwMF0gWm9uZSByYW5n
ZXM6ClsgICAgMC4wMTU1MDBdICAgRE1BICAgICAgW21lbSAweDAwMDAwMDAwMDAwMDEwMDAt
MHgwMDAwMDAwMDAwZmZmZmZmXQpbICAgIDAuMDE1NTAxXSAgIERNQTMyICAgIFttZW0gMHgw
MDAwMDAwMDAxMDAwMDAwLTB4MDAwMDAwMDBmZmZmZmZmZl0KWyAgICAwLjAxNTUwMl0gICBO
b3JtYWwgICBbbWVtIDB4MDAwMDAwMDEwMDAwMDAwMC0weDAwMDAwMDA4YWI3ZmZmZmZdClsg
ICAgMC4wMTU1MDNdICAgRGV2aWNlICAgZW1wdHkKWyAgICAwLjAxNTUwNF0gTW92YWJsZSB6
b25lIHN0YXJ0IGZvciBlYWNoIG5vZGUKWyAgICAwLjAxNTUwNV0gRWFybHkgbWVtb3J5IG5v
ZGUgcmFuZ2VzClsgICAgMC4wMTU1MDVdICAgbm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMDAw
MDAxMDAwLTB4MDAwMDAwMDAwMDA5ZWZmZl0KWyAgICAwLjAxNTUwNl0gICBub2RlICAgMDog
W21lbSAweDAwMDAwMDAwMDAxMDAwMDAtMHgwMDAwMDAwMDNiOGRjZmZmXQpbICAgIDAuMDE1
NTA3XSAgIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMDA0MWJmZjAwMC0weDAwMDAwMDAwNDFi
ZmZmZmZdClsgICAgMC4wMTU1MDddICAgbm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMTAwMDAw
MDAwLTB4MDAwMDAwMDhhYjdmZmZmZl0KWyAgICAwLjAxNTUwOV0gSW5pdG1lbSBzZXR1cCBu
b2RlIDAgW21lbSAweDAwMDAwMDAwMDAwMDEwMDAtMHgwMDAwMDAwOGFiN2ZmZmZmXQpbICAg
IDAuMDE1NTEzXSBPbiBub2RlIDAsIHpvbmUgRE1BOiAxIHBhZ2VzIGluIHVuYXZhaWxhYmxl
IHJhbmdlcwpbICAgIDAuMDE1NTMwXSBPbiBub2RlIDAsIHpvbmUgRE1BOiA5NyBwYWdlcyBp
biB1bmF2YWlsYWJsZSByYW5nZXMKWyAgICAwLjAxNjcyM10gT24gbm9kZSAwLCB6b25lIERN
QTMyOiAyNTM3OCBwYWdlcyBpbiB1bmF2YWlsYWJsZSByYW5nZXMKWyAgICAwLjA1MDczMl0g
T24gbm9kZSAwLCB6b25lIE5vcm1hbDogMjU2MDAgcGFnZXMgaW4gdW5hdmFpbGFibGUgcmFu
Z2VzClsgICAgMC4wNTA4NjVdIE9uIG5vZGUgMCwgem9uZSBOb3JtYWw6IDE4NDMyIHBhZ2Vz
IGluIHVuYXZhaWxhYmxlIHJhbmdlcwpbICAgIDAuMDUwOTA0XSBSZXNlcnZpbmcgSW50ZWwg
Z3JhcGhpY3MgbWVtb3J5IGF0IFttZW0gMHg1MDgwMDAwMC0weDU0N2ZmZmZmXQpbICAgIDAu
MDUyNTc0XSBBQ1BJOiBQTS1UaW1lciBJTyBQb3J0OiAweDE4MDgKWyAgICAwLjA1MjU4MV0g
QUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4MDFdIGhpZ2ggZWRnZSBsaW50WzB4MV0pClsg
ICAgMC4wNTI1ODJdIEFDUEk6IExBUElDX05NSSAoYWNwaV9pZFsweDAyXSBoaWdoIGVkZ2Ug
bGludFsweDFdKQpbICAgIDAuMDUyNTgyXSBBQ1BJOiBMQVBJQ19OTUkgKGFjcGlfaWRbMHgw
M10gaGlnaCBlZGdlIGxpbnRbMHgxXSkKWyAgICAwLjA1MjU4M10gQUNQSTogTEFQSUNfTk1J
IChhY3BpX2lkWzB4MDRdIGhpZ2ggZWRnZSBsaW50WzB4MV0pClsgICAgMC4wNTI1ODNdIEFD
UEk6IExBUElDX05NSSAoYWNwaV9pZFsweDA1XSBoaWdoIGVkZ2UgbGludFsweDFdKQpbICAg
IDAuMDUyNTg0XSBBQ1BJOiBMQVBJQ19OTUkgKGFjcGlfaWRbMHgwNl0gaGlnaCBlZGdlIGxp
bnRbMHgxXSkKWyAgICAwLjA1MjU4NF0gQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4MDdd
IGhpZ2ggZWRnZSBsaW50WzB4MV0pClsgICAgMC4wNTI1ODRdIEFDUEk6IExBUElDX05NSSAo
YWNwaV9pZFsweDA4XSBoaWdoIGVkZ2UgbGludFsweDFdKQpbICAgIDAuMDUyNTg1XSBBQ1BJ
OiBMQVBJQ19OTUkgKGFjcGlfaWRbMHgwOV0gaGlnaCBlZGdlIGxpbnRbMHgxXSkKWyAgICAw
LjA1MjU4NV0gQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4MGFdIGhpZ2ggZWRnZSBsaW50
WzB4MV0pClsgICAgMC4wNTI1ODZdIEFDUEk6IExBUElDX05NSSAoYWNwaV9pZFsweDBiXSBo
aWdoIGVkZ2UgbGludFsweDFdKQpbICAgIDAuMDUyNTg2XSBBQ1BJOiBMQVBJQ19OTUkgKGFj
cGlfaWRbMHgwY10gaGlnaCBlZGdlIGxpbnRbMHgxXSkKWyAgICAwLjA1MjU4Nl0gQUNQSTog
TEFQSUNfTk1JIChhY3BpX2lkWzB4MGRdIGhpZ2ggZWRnZSBsaW50WzB4MV0pClsgICAgMC4w
NTI1ODddIEFDUEk6IExBUElDX05NSSAoYWNwaV9pZFsweDBlXSBoaWdoIGVkZ2UgbGludFsw
eDFdKQpbICAgIDAuMDUyNTg3XSBBQ1BJOiBMQVBJQ19OTUkgKGFjcGlfaWRbMHgwZl0gaGln
aCBlZGdlIGxpbnRbMHgxXSkKWyAgICAwLjA1MjU4OF0gQUNQSTogTEFQSUNfTk1JIChhY3Bp
X2lkWzB4MTBdIGhpZ2ggZWRnZSBsaW50WzB4MV0pClsgICAgMC4wNTI1ODhdIEFDUEk6IExB
UElDX05NSSAoYWNwaV9pZFsweDExXSBoaWdoIGVkZ2UgbGludFsweDFdKQpbICAgIDAuMDUy
NTg4XSBBQ1BJOiBMQVBJQ19OTUkgKGFjcGlfaWRbMHgxMl0gaGlnaCBlZGdlIGxpbnRbMHgx
XSkKWyAgICAwLjA1MjU4OV0gQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4MTNdIGhpZ2gg
ZWRnZSBsaW50WzB4MV0pClsgICAgMC4wNTI1ODldIEFDUEk6IExBUElDX05NSSAoYWNwaV9p
ZFsweDE0XSBoaWdoIGVkZ2UgbGludFsweDFdKQpbICAgIDAuMDUyNTkwXSBBQ1BJOiBMQVBJ
Q19OTUkgKGFjcGlfaWRbMHgxNV0gaGlnaCBlZGdlIGxpbnRbMHgxXSkKWyAgICAwLjA1MjU5
MF0gQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4MTZdIGhpZ2ggZWRnZSBsaW50WzB4MV0p
ClsgICAgMC4wNTI1OTBdIEFDUEk6IExBUElDX05NSSAoYWNwaV9pZFsweDE3XSBoaWdoIGVk
Z2UgbGludFsweDFdKQpbICAgIDAuMDUyNTkxXSBBQ1BJOiBMQVBJQ19OTUkgKGFjcGlfaWRb
MHgwMF0gaGlnaCBlZGdlIGxpbnRbMHgxXSkKWyAgICAwLjA1MjYyN10gSU9BUElDWzBdOiBh
cGljX2lkIDIsIHZlcnNpb24gMzIsIGFkZHJlc3MgMHhmZWMwMDAwMCwgR1NJIDAtMTE5Clsg
ICAgMC4wNTI2MjldIEFDUEk6IElOVF9TUkNfT1ZSIChidXMgMCBidXNfaXJxIDAgZ2xvYmFs
X2lycSAyIGRmbCBkZmwpClsgICAgMC4wNTI2MzBdIEFDUEk6IElOVF9TUkNfT1ZSIChidXMg
MCBidXNfaXJxIDkgZ2xvYmFsX2lycSA5IGhpZ2ggbGV2ZWwpClsgICAgMC4wNTI2MzNdIEFD
UEk6IFVzaW5nIEFDUEkgKE1BRFQpIGZvciBTTVAgY29uZmlndXJhdGlvbiBpbmZvcm1hdGlv
bgpbICAgIDAuMDUyNjMzXSBBQ1BJOiBIUEVUIGlkOiAweDgwODZhMjAxIGJhc2U6IDB4ZmVk
MDAwMDAKWyAgICAwLjA1MjY0Ml0gZTgyMDogdXBkYXRlIFttZW0gMHgyZTg2NjAwMC0weDJl
OGRiZmZmXSB1c2FibGUgPT0+IHJlc2VydmVkClsgICAgMC4wNTI2NDhdIFRTQyBkZWFkbGlu
ZSB0aW1lciBhdmFpbGFibGUKWyAgICAwLjA1MjY0OF0gc21wYm9vdDogQWxsb3dpbmcgMjQg
Q1BVcywgMCBob3RwbHVnIENQVXMKWyAgICAwLjA1MjY1Nl0gUE06IGhpYmVybmF0aW9uOiBS
ZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHgwMDAwMDAwMC0weDAwMDAwZmZmXQpb
ICAgIDAuMDUyNjU3XSBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9y
eTogW21lbSAweDAwMDlmMDAwLTB4MDAwZmZmZmZdClsgICAgMC4wNTI2NThdIFBNOiBoaWJl
cm5hdGlvbjogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4MmU4NjYwMDAtMHgy
ZThkYmZmZl0KWyAgICAwLjA1MjY1OV0gUE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5v
c2F2ZSBtZW1vcnk6IFttZW0gMHgzYjhkZDAwMC0weDQxOTMzZmZmXQpbICAgIDAuMDUyNjYw
XSBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweDQx
OTM0MDAwLTB4NDFiMzNmZmZdClsgICAgMC4wNTI2NjBdIFBNOiBoaWJlcm5hdGlvbjogUmVn
aXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4NDFiMzQwMDAtMHg0MWJmZWZmZl0KWyAg
ICAwLjA1MjY2MV0gUE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6
IFttZW0gMHg0MWMwMDAwMC0weDQ3ZmZmZmZmXQpbICAgIDAuMDUyNjYxXSBQTTogaGliZXJu
YXRpb246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweDQ4MDAwMDAwLTB4NDkz
ZmZmZmZdClsgICAgMC4wNTI2NjJdIFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJlZCBub3Nh
dmUgbWVtb3J5OiBbbWVtIDB4NDk0MDAwMDAtMHg0OTVmZmZmZl0KWyAgICAwLjA1MjY2Ml0g
UE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHg0OTYw
MDAwMC0weDRiZmZmZmZmXQpbICAgIDAuMDUyNjYyXSBQTTogaGliZXJuYXRpb246IFJlZ2lz
dGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweDRjMDAwMDAwLTB4NTQ3ZmZmZmZdClsgICAg
MC4wNTI2NjNdIFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBb
bWVtIDB4NTQ4MDAwMDAtMHhmZWQxZmZmZl0KWyAgICAwLjA1MjY2M10gUE06IGhpYmVybmF0
aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFttZW0gMHhmZWQyMDAwMC0weGZlZDdm
ZmZmXQpbICAgIDAuMDUyNjYzXSBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQgbm9zYXZl
IG1lbW9yeTogW21lbSAweGZlZDgwMDAwLTB4ZmZmZmZmZmZdClsgICAgMC4wNTI2NjRdIFtt
ZW0gMHg1NDgwMDAwMC0weGZlZDFmZmZmXSBhdmFpbGFibGUgZm9yIFBDSSBkZXZpY2VzClsg
ICAgMC4wNTI2NjVdIEJvb3RpbmcgcGFyYXZpcnR1YWxpemVkIGtlcm5lbCBvbiBiYXJlIGhh
cmR3YXJlClsgICAgMC4wNTI2NjddIGNsb2Nrc291cmNlOiByZWZpbmVkLWppZmZpZXM6IG1h
c2s6IDB4ZmZmZmZmZmYgbWF4X2N5Y2xlczogMHhmZmZmZmZmZiwgbWF4X2lkbGVfbnM6IDc2
NDU1MTk2MDAyMTE1NjggbnMKWyAgICAwLjA1MjY3MV0gc2V0dXBfcGVyY3B1OiBOUl9DUFVT
OjgxOTIgbnJfY3B1bWFza19iaXRzOjI0IG5yX2NwdV9pZHM6MjQgbnJfbm9kZV9pZHM6MQpb
ICAgIDAuMDUzMzkxXSBwZXJjcHU6IEVtYmVkZGVkIDY0IHBhZ2VzL2NwdSBzMjI1MjgwIHI4
MTkyIGQyODY3MiB1MjYyMTQ0ClsgICAgMC4wNTMzOTRdIHBjcHUtYWxsb2M6IHMyMjUyODAg
cjgxOTIgZDI4NjcyIHUyNjIxNDQgYWxsb2M9MSoyMDk3MTUyClsgICAgMC4wNTMzOTZdIHBj
cHUtYWxsb2M6IFswXSAwMCAwMSAwMiAwMyAwNCAwNSAwNiAwNyBbMF0gMDggMDkgMTAgMTEg
MTIgMTMgMTQgMTUgClsgICAgMC4wNTM0MDFdIHBjcHUtYWxsb2M6IFswXSAxNiAxNyAxOCAx
OSAyMCAyMSAyMiAyMyAKWyAgICAwLjA1MzQxNF0gS2VybmVsIGNvbW1hbmQgbGluZTogQk9P
VF9JTUFHRT0vYm9vdC92bWxpbnV6LTYuNy4wLXJjMS1uZXh0LTIwMjMxMTE1KyByb290PVVV
SUQ9MDYxNTAyYTktMjA1ZS00YjczLTgyNTEtMTIyMGU3NzBjNWQ4IHJvIHF1aWV0IHNwbGFz
aCBwY2llX2FzcG09b2ZmIGxvZ19idWZfbGVuPTEwTSB0cmFjZV9ldmVudD1ncGlvOiogdnQu
aGFuZG9mZj03ClsgICAgMC4wNTM0NTRdIFBDSWUgQVNQTSBpcyBkaXNhYmxlZApbICAgIDAu
MDUzNDczXSBVbmtub3duIGtlcm5lbCBjb21tYW5kIGxpbmUgcGFyYW1ldGVycyAic3BsYXNo
IEJPT1RfSU1BR0U9L2Jvb3Qvdm1saW51ei02LjcuMC1yYzEtbmV4dC0yMDIzMTExNSsiLCB3
aWxsIGJlIHBhc3NlZCB0byB1c2VyIHNwYWNlLgpbICAgIDAuMDU1Njg4XSBEZW50cnkgY2Fj
aGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA0MTk0MzA0IChvcmRlcjogMTMsIDMzNTU0NDMyIGJ5
dGVzLCBsaW5lYXIpClsgICAgMC4wNTY4MDldIElub2RlLWNhY2hlIGhhc2ggdGFibGUgZW50
cmllczogMjA5NzE1MiAob3JkZXI6IDEyLCAxNjc3NzIxNiBieXRlcywgbGluZWFyKQpbICAg
IDAuMDU2OTU2XSBGYWxsYmFjayBvcmRlciBmb3IgTm9kZSAwOiAwIApbICAgIDAuMDU2OTU4
XSBCdWlsdCAxIHpvbmVsaXN0cywgbW9iaWxpdHkgZ3JvdXBpbmcgb24uICBUb3RhbCBwYWdl
czogODE1NjY5OApbICAgIDAuMDU2OTU5XSBQb2xpY3kgem9uZTogTm9ybWFsClsgICAgMC4w
NTY5NjRdIG1lbSBhdXRvLWluaXQ6IHN0YWNrOm9mZiwgaGVhcCBhbGxvYzpvbiwgaGVhcCBm
cmVlOm9mZgpbICAgIDAuMDU2OTcwXSBzb2Z0d2FyZSBJTyBUTEI6IGFyZWEgbnVtIDMyLgpb
ICAgIDAuMTA1ODc1XSBNZW1vcnk6IDMyMTAzMjUySy8zMzE0NTMyOEsgYXZhaWxhYmxlICgy
MDQ4MEsga2VybmVsIGNvZGUsIDQyNjdLIHJ3ZGF0YSwgNzM3Nksgcm9kYXRhLCA0NzEySyBp
bml0LCA1MTg0SyBic3MsIDEwNDE4MjBLIHJlc2VydmVkLCAwSyBjbWEtcmVzZXJ2ZWQpClsg
ICAgMC4xMDYwNTldIFNMVUI6IEhXYWxpZ249NjQsIE9yZGVyPTAtMywgTWluT2JqZWN0cz0w
LCBDUFVzPTI0LCBOb2Rlcz0xClsgICAgMC4xMDYwODFdIGZ0cmFjZTogYWxsb2NhdGluZyA1
Mjg5MCBlbnRyaWVzIGluIDIwNyBwYWdlcwpbICAgIDAuMTExNjE5XSBmdHJhY2U6IGFsbG9j
YXRlZCAyMDcgcGFnZXMgd2l0aCA2IGdyb3VwcwpbICAgIDAuMTEyMjg0XSBEeW5hbWljIFBy
ZWVtcHQ6IHZvbHVudGFyeQpbICAgIDAuMTEyMzQ2XSByY3U6IFByZWVtcHRpYmxlIGhpZXJh
cmNoaWNhbCBSQ1UgaW1wbGVtZW50YXRpb24uClsgICAgMC4xMTIzNDZdIHJjdTogCVJDVSBy
ZXN0cmljdGluZyBDUFVzIGZyb20gTlJfQ1BVUz04MTkyIHRvIG5yX2NwdV9pZHM9MjQuClsg
ICAgMC4xMTIzNDddIAlUcmFtcG9saW5lIHZhcmlhbnQgb2YgVGFza3MgUkNVIGVuYWJsZWQu
ClsgICAgMC4xMTIzNDhdIAlSdWRlIHZhcmlhbnQgb2YgVGFza3MgUkNVIGVuYWJsZWQuClsg
ICAgMC4xMTIzNDhdIAlUcmFjaW5nIHZhcmlhbnQgb2YgVGFza3MgUkNVIGVuYWJsZWQuClsg
ICAgMC4xMTIzNDhdIHJjdTogUkNVIGNhbGN1bGF0ZWQgdmFsdWUgb2Ygc2NoZWR1bGVyLWVu
bGlzdG1lbnQgZGVsYXkgaXMgMjUgamlmZmllcy4KWyAgICAwLjExMjM0OV0gcmN1OiBBZGp1
c3RpbmcgZ2VvbWV0cnkgZm9yIHJjdV9mYW5vdXRfbGVhZj0xNiwgbnJfY3B1X2lkcz0yNApb
ICAgIDAuMTEzOTEwXSBOUl9JUlFTOiA1MjQ1NDQsIG5yX2lycXM6IDIyNDgsIHByZWFsbG9j
YXRlZCBpcnFzOiAxNgpbICAgIDAuMTE0MjA0XSByY3U6IHNyY3VfaW5pdDogU2V0dGluZyBz
cmN1X3N0cnVjdCBzaXplcyBiYXNlZCBvbiBjb250ZW50aW9uLgpbICAgIDAuMTE0NDE4XSBD
b25zb2xlOiBjb2xvdXIgZHVtbXkgZGV2aWNlIDgweDI1ClsgICAgMC4xMTQ0MjBdIHByaW50
azogbGVnYWN5IGNvbnNvbGUgW3R0eTBdIGVuYWJsZWQKWyAgICAwLjExNDQ1Ml0gQUNQSTog
Q29yZSByZXZpc2lvbiAyMDIzMDYyOApbICAgIDAuMTE0NzExXSBocGV0OiBIUEVUIGR5c2Z1
bmN0aW9uYWwgaW4gUEMxMC4gRm9yY2UgZGlzYWJsZWQuClsgICAgMC4xMTQ3MTFdIEFQSUM6
IFN3aXRjaCB0byBzeW1tZXRyaWMgSS9PIG1vZGUgc2V0dXAKWyAgICAwLjExNDcxM10gRE1B
UjogSG9zdCBhZGRyZXNzIHdpZHRoIDM5ClsgICAgMC4xMTQ3MTRdIERNQVI6IERSSEQgYmFz
ZTogMHgwMDAwMDBmZWQ5MDAwMCBmbGFnczogMHgwClsgICAgMC4xMTQ3MTddIERNQVI6IGRt
YXIwOiByZWdfYmFzZV9hZGRyIGZlZDkwMDAwIHZlciA0OjAgY2FwIDFjMDAwMGM0MDY2MDQ2
MiBlY2FwIDI5YTAwZjA1MDVlClsgICAgMC4xMTQ3MTldIERNQVI6IERSSEQgYmFzZTogMHgw
MDAwMDBmZWQ5MTAwMCBmbGFnczogMHgxClsgICAgMC4xMTQ3MjRdIERNQVI6IGRtYXIxOiBy
ZWdfYmFzZV9hZGRyIGZlZDkxMDAwIHZlciA1OjAgY2FwIGQyMDA4YzQwNjYwNDYyIGVjYXAg
ZjA1MGRhClsgICAgMC4xMTQ3MjZdIERNQVI6IFJNUlIgYmFzZTogMHgwMDAwMDA1MDAwMDAw
MCBlbmQ6IDB4MDAwMDAwNTQ3ZmZmZmYKWyAgICAwLjExNDcyN10gRE1BUi1JUjogSU9BUElD
IGlkIDIgdW5kZXIgRFJIRCBiYXNlICAweGZlZDkxMDAwIElPTU1VIDEKWyAgICAwLjExNDcy
OF0gRE1BUi1JUjogSFBFVCBpZCAwIHVuZGVyIERSSEQgYmFzZSAweGZlZDkxMDAwClsgICAg
MC4xMTQ3MjldIERNQVItSVI6IFF1ZXVlZCBpbnZhbGlkYXRpb24gd2lsbCBiZSBlbmFibGVk
IHRvIHN1cHBvcnQgeDJhcGljIGFuZCBJbnRyLXJlbWFwcGluZy4KWyAgICAwLjExNjI4OF0g
RE1BUi1JUjogRW5hYmxlZCBJUlEgcmVtYXBwaW5nIGluIHgyYXBpYyBtb2RlClsgICAgMC4x
MTYyODldIHgyYXBpYyBlbmFibGVkClsgICAgMC4xMTYzMzhdIEFQSUM6IFN3aXRjaGVkIEFQ
SUMgcm91dGluZyB0bzogY2x1c3RlciB4MmFwaWMKWyAgICAwLjEyMDcyMl0gY2xvY2tzb3Vy
Y2U6IHRzYy1lYXJseTogbWFzazogMHhmZmZmZmZmZmZmZmZmZmZmIG1heF9jeWNsZXM6IDB4
MjJkZjExNDk5NDksIG1heF9pZGxlX25zOiA0NDA3OTUzMTI3ODkgbnMKWyAgICAwLjEyMDcy
N10gQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcCAoc2tpcHBlZCksIHZhbHVlIGNhbGN1bGF0ZWQg
dXNpbmcgdGltZXIgZnJlcXVlbmN5Li4gNDgzOC40MCBCb2dvTUlQUyAobHBqPTk2NzY4MDAp
ClsgICAgMC4xMjA3NzBdIHg4Ni90bWU6IG5vdCBlbmFibGVkIGJ5IEJJT1MKWyAgICAwLjEy
MDc3Nl0gQ1BVMDogVGhlcm1hbCBtb25pdG9yaW5nIGVuYWJsZWQgKFRNMSkKWyAgICAwLjEy
MDc3OF0geDg2L2NwdTogVXNlciBNb2RlIEluc3RydWN0aW9uIFByZXZlbnRpb24gKFVNSVAp
IGFjdGl2YXRlZApbICAgIDAuMTIwODgxXSBwcm9jZXNzOiB1c2luZyBtd2FpdCBpbiBpZGxl
IHRocmVhZHMKWyAgICAwLjEyMDg4M10gTGFzdCBsZXZlbCBpVExCIGVudHJpZXM6IDRLQiAw
LCAyTUIgMCwgNE1CIDAKWyAgICAwLjEyMDg4M10gTGFzdCBsZXZlbCBkVExCIGVudHJpZXM6
IDRLQiAwLCAyTUIgMCwgNE1CIDAsIDFHQiAwClsgICAgMC4xMjA4ODVdIFNwZWN0cmUgVjEg
OiBNaXRpZ2F0aW9uOiB1c2VyY29weS9zd2FwZ3MgYmFycmllcnMgYW5kIF9fdXNlciBwb2lu
dGVyIHNhbml0aXphdGlvbgpbICAgIDAuMTIwODg3XSBTcGVjdHJlIFYyIDogTWl0aWdhdGlv
bjogRW5oYW5jZWQgLyBBdXRvbWF0aWMgSUJSUwpbICAgIDAuMTIwODg3XSBTcGVjdHJlIFYy
IDogU3BlY3RyZSB2MiAvIFNwZWN0cmVSU0IgbWl0aWdhdGlvbjogRmlsbGluZyBSU0Igb24g
Y29udGV4dCBzd2l0Y2gKWyAgICAwLjEyMDg4OF0gU3BlY3RyZSBWMiA6IFNwZWN0cmUgdjIg
LyBQQlJTQi1lSUJSUzogUmV0aXJlIGEgc2luZ2xlIENBTEwgb24gVk1FWElUClsgICAgMC4x
MjA4ODldIFNwZWN0cmUgVjIgOiBtaXRpZ2F0aW9uOiBFbmFibGluZyBjb25kaXRpb25hbCBJ
bmRpcmVjdCBCcmFuY2ggUHJlZGljdGlvbiBCYXJyaWVyClsgICAgMC4xMjA4OTBdIFNwZWN1
bGF0aXZlIFN0b3JlIEJ5cGFzczogTWl0aWdhdGlvbjogU3BlY3VsYXRpdmUgU3RvcmUgQnlw
YXNzIGRpc2FibGVkIHZpYSBwcmN0bApbICAgIDAuMTIwODk4XSB4ODYvZnB1OiBTdXBwb3J0
aW5nIFhTQVZFIGZlYXR1cmUgMHgwMDE6ICd4ODcgZmxvYXRpbmcgcG9pbnQgcmVnaXN0ZXJz
JwpbICAgIDAuMTIwODk5XSB4ODYvZnB1OiBTdXBwb3J0aW5nIFhTQVZFIGZlYXR1cmUgMHgw
MDI6ICdTU0UgcmVnaXN0ZXJzJwpbICAgIDAuMTIwODk5XSB4ODYvZnB1OiBTdXBwb3J0aW5n
IFhTQVZFIGZlYXR1cmUgMHgwMDQ6ICdBVlggcmVnaXN0ZXJzJwpbICAgIDAuMTIwOTAwXSB4
ODYvZnB1OiBTdXBwb3J0aW5nIFhTQVZFIGZlYXR1cmUgMHgyMDA6ICdQcm90ZWN0aW9uIEtl
eXMgVXNlciByZWdpc3RlcnMnClsgICAgMC4xMjA5MDBdIHg4Ni9mcHU6IFN1cHBvcnRpbmcg
WFNBVkUgZmVhdHVyZSAweDgwMDogJ0NvbnRyb2wtZmxvdyBVc2VyIHJlZ2lzdGVycycKWyAg
ICAwLjEyMDkwMV0geDg2L2ZwdTogeHN0YXRlX29mZnNldFsyXTogIDU3NiwgeHN0YXRlX3Np
emVzWzJdOiAgMjU2ClsgICAgMC4xMjA5MDJdIHg4Ni9mcHU6IHhzdGF0ZV9vZmZzZXRbOV06
ICA4MzIsIHhzdGF0ZV9zaXplc1s5XTogICAgOApbICAgIDAuMTIwOTAyXSB4ODYvZnB1OiB4
c3RhdGVfb2Zmc2V0WzExXTogIDg0MCwgeHN0YXRlX3NpemVzWzExXTogICAxNgpbICAgIDAu
MTIwOTAzXSB4ODYvZnB1OiBFbmFibGVkIHhzdGF0ZSBmZWF0dXJlcyAweGEwNywgY29udGV4
dCBzaXplIGlzIDg1NiBieXRlcywgdXNpbmcgJ2NvbXBhY3RlZCcgZm9ybWF0LgpbICAgIDAu
MTI0NzI1XSBGcmVlaW5nIFNNUCBhbHRlcm5hdGl2ZXMgbWVtb3J5OiA0NEsKWyAgICAwLjEy
NDcyNV0gcGlkX21heDogZGVmYXVsdDogMzI3NjggbWluaW11bTogMzAxClsgICAgMC4xMjQ3
MjVdIExTTTogaW5pdGlhbGl6aW5nIGxzbT1sb2NrZG93bixjYXBhYmlsaXR5LGxhbmRsb2Nr
LHlhbWEsYXBwYXJtb3IsaW50ZWdyaXR5ClsgICAgMC4xMjQ3MjVdIGxhbmRsb2NrOiBVcCBh
bmQgcnVubmluZy4KWyAgICAwLjEyNDcyNV0gWWFtYTogYmVjb21pbmcgbWluZGZ1bC4KWyAg
ICAwLjEyNDcyNV0gQXBwQXJtb3I6IEFwcEFybW9yIGluaXRpYWxpemVkClsgICAgMC4xMjQ3
MjVdIE1vdW50LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNjU1MzYgKG9yZGVyOiA3LCA1
MjQyODggYnl0ZXMsIGxpbmVhcikKWyAgICAwLjEyNDcyNV0gTW91bnRwb2ludC1jYWNoZSBo
YXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2IChvcmRlcjogNywgNTI0Mjg4IGJ5dGVzLCBsaW5l
YXIpClsgICAgMC4xMjQ3MjVdIHNtcGJvb3Q6IENQVTA6IDEydGggR2VuIEludGVsKFIpIENv
cmUoVE0pIGk3LTEyODUwSFggKGZhbWlseTogMHg2LCBtb2RlbDogMHg5Nywgc3RlcHBpbmc6
IDB4MikKWyAgICAwLjEyNDcyNV0gUkNVIFRhc2tzOiBTZXR0aW5nIHNoaWZ0IHRvIDUgYW5k
IGxpbSB0byAxIHJjdV90YXNrX2NiX2FkanVzdD0xLgpbICAgIDAuMTI0NzI1XSBSQ1UgVGFz
a3MgUnVkZTogU2V0dGluZyBzaGlmdCB0byA1IGFuZCBsaW0gdG8gMSByY3VfdGFza19jYl9h
ZGp1c3Q9MS4KWyAgICAwLjEyNDcyNV0gUkNVIFRhc2tzIFRyYWNlOiBTZXR0aW5nIHNoaWZ0
IHRvIDUgYW5kIGxpbSB0byAxIHJjdV90YXNrX2NiX2FkanVzdD0xLgpbICAgIDAuMTI0NzI1
XSBQZXJmb3JtYW5jZSBFdmVudHM6IFhTQVZFIEFyY2hpdGVjdHVyYWwgTEJSLCBQRUJTIGZt
dDQrLWJhc2VsaW5lLCAgQW55VGhyZWFkIGRlcHJlY2F0ZWQsIEFsZGVybGFrZSBIeWJyaWQg
ZXZlbnRzLCAzMi1kZWVwIExCUiwgZnVsbC13aWR0aCBjb3VudGVycywgSW50ZWwgUE1VIGRy
aXZlci4KWyAgICAwLjEyNDcyNV0gY29yZTogY3B1X2NvcmUgUE1VIGRyaXZlcjogClsgICAg
MC4xMjQ3MjVdIC4uLiB2ZXJzaW9uOiAgICAgICAgICAgICAgICA1ClsgICAgMC4xMjQ3MjVd
IC4uLiBiaXQgd2lkdGg6ICAgICAgICAgICAgICA0OApbICAgIDAuMTI0NzI1XSAuLi4gZ2Vu
ZXJpYyByZWdpc3RlcnM6ICAgICAgOApbICAgIDAuMTI0NzI1XSAuLi4gdmFsdWUgbWFzazog
ICAgICAgICAgICAgMDAwMGZmZmZmZmZmZmZmZgpbICAgIDAuMTI0NzI1XSAuLi4gbWF4IHBl
cmlvZDogICAgICAgICAgICAgMDAwMDdmZmZmZmZmZmZmZgpbICAgIDAuMTI0NzI1XSAuLi4g
Zml4ZWQtcHVycG9zZSBldmVudHM6ICAgNApbICAgIDAuMTI0NzI1XSAuLi4gZXZlbnQgbWFz
azogICAgICAgICAgICAgMDAwMTAwMGYwMDAwMDBmZgpbICAgIDAuMTI0NzI1XSBzaWduYWw6
IG1heCBzaWdmcmFtZSBzaXplOiAzNjMyClsgICAgMC4xMjQ3MjVdIEVzdGltYXRlZCByYXRp
byBvZiBhdmVyYWdlIG1heCBmcmVxdWVuY3kgYnkgYmFzZSBmcmVxdWVuY3kgKHRpbWVzIDEw
MjQpOiAxOTYyClsgICAgMC4xMjQ3MjVdIHJjdTogSGllcmFyY2hpY2FsIFNSQ1UgaW1wbGVt
ZW50YXRpb24uClsgICAgMC4xMjQ3MjVdIHJjdTogCU1heCBwaGFzZSBuby1kZWxheSBpbnN0
YW5jZXMgaXMgMTAwMC4KWyAgICAwLjEyOTc5N10gTk1JIHdhdGNoZG9nOiBFbmFibGVkLiBQ
ZXJtYW5lbnRseSBjb25zdW1lcyBvbmUgaHctUE1VIGNvdW50ZXIuClsgICAgMC4xMjk5MTFd
IHNtcDogQnJpbmdpbmcgdXAgc2Vjb25kYXJ5IENQVXMgLi4uClsgICAgMC4xMzAxMDBdIHNt
cGJvb3Q6IHg4NjogQm9vdGluZyBTTVAgY29uZmlndXJhdGlvbjoKWyAgICAwLjEzMDEwMV0g
Li4uLiBub2RlICAjMCwgQ1BVczogICAgICAgICMyICAjNCAgIzYgICM4ICMxMCAjMTIgIzE0
ICMxNiAjMTcgIzE4ICMxOSAjMjAgIzIxICMyMiAjMjMKWyAgICAwLjAxMDM0M10gY29yZTog
Y3B1X2F0b20gUE1VIGRyaXZlcjogUEVCUy12aWEtUFQgClsgICAgMC4wMTAzNDNdIC4uLiB2
ZXJzaW9uOiAgICAgICAgICAgICAgICA1ClsgICAgMC4wMTAzNDNdIC4uLiBiaXQgd2lkdGg6
ICAgICAgICAgICAgICA0OApbICAgIDAuMDEwMzQzXSAuLi4gZ2VuZXJpYyByZWdpc3RlcnM6
ICAgICAgNgpbICAgIDAuMDEwMzQzXSAuLi4gdmFsdWUgbWFzazogICAgICAgICAgICAgMDAw
MGZmZmZmZmZmZmZmZgpbICAgIDAuMDEwMzQzXSAuLi4gbWF4IHBlcmlvZDogICAgICAgICAg
ICAgMDAwMDdmZmZmZmZmZmZmZgpbICAgIDAuMDEwMzQzXSAuLi4gZml4ZWQtcHVycG9zZSBl
dmVudHM6ICAgMwpbICAgIDAuMDEwMzQzXSAuLi4gZXZlbnQgbWFzazogICAgICAgICAgICAg
MDAwMDAwMDcwMDAwMDAzZgpbICAgIDAuMTQ0OTA1XSAgICMxICAjMyAgIzUgICM3ICAjOSAj
MTEgIzEzICMxNQpbICAgIDAuMTY0ODMyXSBzbXA6IEJyb3VnaHQgdXAgMSBub2RlLCAyNCBD
UFVzClsgICAgMC4xNjQ4MzJdIHNtcGJvb3Q6IE1heCBsb2dpY2FsIHBhY2thZ2VzOiAxClsg
ICAgMC4xNjQ4MzJdIHNtcGJvb3Q6IFRvdGFsIG9mIDI0IHByb2Nlc3NvcnMgYWN0aXZhdGVk
ICgxMTYxMjEuNjAgQm9nb01JUFMpClsgICAgMC4xNjk1ODRdIGRldnRtcGZzOiBpbml0aWFs
aXplZApbICAgIDAuMTY5NTg0XSB4ODYvbW06IE1lbW9yeSBibG9jayBzaXplOiAxMjhNQgpb
ICAgIDAuMTcwMjQxXSBBQ1BJOiBQTTogUmVnaXN0ZXJpbmcgQUNQSSBOVlMgcmVnaW9uIFtt
ZW0gMHg0MTkzNDAwMC0weDQxYjMzZmZmXSAoMjA5NzE1MiBieXRlcykKWyAgICAwLjE3MDI0
MV0gY2xvY2tzb3VyY2U6IGppZmZpZXM6IG1hc2s6IDB4ZmZmZmZmZmYgbWF4X2N5Y2xlczog
MHhmZmZmZmZmZiwgbWF4X2lkbGVfbnM6IDc2NDUwNDE3ODUxMDAwMDAgbnMKWyAgICAwLjE3
MDI0MV0gZnV0ZXggaGFzaCB0YWJsZSBlbnRyaWVzOiA4MTkyIChvcmRlcjogNywgNTI0Mjg4
IGJ5dGVzLCBsaW5lYXIpClsgICAgMC4xNzAyNDFdIHBpbmN0cmwgY29yZTogaW5pdGlhbGl6
ZWQgcGluY3RybCBzdWJzeXN0ZW0KWyAgICAwLjE3MDI0MV0gUE06IFJUQyB0aW1lOiAxNzoz
MTozMSwgZGF0ZTogMjAyMy0xMS0yMQpbICAgIDAuMTcwMjQxXSBORVQ6IFJlZ2lzdGVyZWQg
UEZfTkVUTElOSy9QRl9ST1VURSBwcm90b2NvbCBmYW1pbHkKWyAgICAwLjE3MDI0MV0gRE1B
OiBwcmVhbGxvY2F0ZWQgNDA5NiBLaUIgR0ZQX0tFUk5FTCBwb29sIGZvciBhdG9taWMgYWxs
b2NhdGlvbnMKWyAgICAwLjE3MDI0MV0gRE1BOiBwcmVhbGxvY2F0ZWQgNDA5NiBLaUIgR0ZQ
X0tFUk5FTHxHRlBfRE1BIHBvb2wgZm9yIGF0b21pYyBhbGxvY2F0aW9ucwpbICAgIDAuMTcy
OTM2XSBETUE6IHByZWFsbG9jYXRlZCA0MDk2IEtpQiBHRlBfS0VSTkVMfEdGUF9ETUEzMiBw
b29sIGZvciBhdG9taWMgYWxsb2NhdGlvbnMKWyAgICAwLjE3Mjk0Ml0gYXVkaXQ6IGluaXRp
YWxpemluZyBuZXRsaW5rIHN1YnN5cyAoZGlzYWJsZWQpClsgICAgMC4xNzI5NDZdIGF1ZGl0
OiB0eXBlPTIwMDAgYXVkaXQoMTcwMDU4Nzg5MS4wNTI6MSk6IHN0YXRlPWluaXRpYWxpemVk
IGF1ZGl0X2VuYWJsZWQ9MCByZXM9MQpbICAgIDAuMTcyOTQ2XSB0aGVybWFsX3N5czogUmVn
aXN0ZXJlZCB0aGVybWFsIGdvdmVybm9yICdmYWlyX3NoYXJlJwpbICAgIDAuMTcyOTQ2XSB0
aGVybWFsX3N5czogUmVnaXN0ZXJlZCB0aGVybWFsIGdvdmVybm9yICdiYW5nX2JhbmcnClsg
ICAgMC4xNzI5NDZdIHRoZXJtYWxfc3lzOiBSZWdpc3RlcmVkIHRoZXJtYWwgZ292ZXJub3Ig
J3N0ZXBfd2lzZScKWyAgICAwLjE3Mjk0Nl0gdGhlcm1hbF9zeXM6IFJlZ2lzdGVyZWQgdGhl
cm1hbCBnb3Zlcm5vciAndXNlcl9zcGFjZScKWyAgICAwLjE3Mjk0Nl0gdGhlcm1hbF9zeXM6
IFJlZ2lzdGVyZWQgdGhlcm1hbCBnb3Zlcm5vciAncG93ZXJfYWxsb2NhdG9yJwpbICAgIDAu
MTcyOTQ2XSBFSVNBIGJ1cyByZWdpc3RlcmVkClsgICAgMC4xNzI5NDZdIGNwdWlkbGU6IHVz
aW5nIGdvdmVybm9yIGxhZGRlcgpbICAgIDAuMTcyOTQ2XSBjcHVpZGxlOiB1c2luZyBnb3Zl
cm5vciBtZW51ClsgICAgMC4xNzI5NDZdIGFjcGlwaHA6IEFDUEkgSG90IFBsdWcgUENJIENv
bnRyb2xsZXIgRHJpdmVyIHZlcnNpb246IDAuNQpbICAgIDAuMTcyOTQ2XSBQQ0k6IE1NQ09O
RklHIGZvciBkb21haW4gMDAwMCBbYnVzIDAwLWZmXSBhdCBbbWVtIDB4YzAwMDAwMDAtMHhj
ZmZmZmZmZl0gKGJhc2UgMHhjMDAwMDAwMCkKWyAgICAwLjE3Mjk0Nl0gUENJOiBub3QgdXNp
bmcgTU1DT05GSUcKWyAgICAwLjE3Mjk0Nl0gUENJOiBVc2luZyBjb25maWd1cmF0aW9uIHR5
cGUgMSBmb3IgYmFzZSBhY2Nlc3MKWyAgICAwLjE3MzE5NF0gRU5FUkdZX1BFUkZfQklBUzog
U2V0IHRvICdub3JtYWwnLCB3YXMgJ3BlcmZvcm1hbmNlJwpbICAgIDAuMTczMTk1XSBrcHJv
YmVzOiBrcHJvYmUganVtcC1vcHRpbWl6YXRpb24gaXMgZW5hYmxlZC4gQWxsIGtwcm9iZXMg
YXJlIG9wdGltaXplZCBpZiBwb3NzaWJsZS4KWyAgICAwLjE3MzE5NV0gSHVnZVRMQjogcmVn
aXN0ZXJlZCAxLjAwIEdpQiBwYWdlIHNpemUsIHByZS1hbGxvY2F0ZWQgMCBwYWdlcwpbICAg
IDAuMTczMTk1XSBIdWdlVExCOiAxNjM4MCBLaUIgdm1lbW1hcCBjYW4gYmUgZnJlZWQgZm9y
IGEgMS4wMCBHaUIgcGFnZQpbICAgIDAuMTczMTk1XSBIdWdlVExCOiByZWdpc3RlcmVkIDIu
MDAgTWlCIHBhZ2Ugc2l6ZSwgcHJlLWFsbG9jYXRlZCAwIHBhZ2VzClsgICAgMC4xNzMxOTVd
IEh1Z2VUTEI6IDI4IEtpQiB2bWVtbWFwIGNhbiBiZSBmcmVlZCBmb3IgYSAyLjAwIE1pQiBw
YWdlClsgICAgMC4xNzMxOTVdIEFDUEk6IEFkZGVkIF9PU0koTW9kdWxlIERldmljZSkKWyAg
ICAwLjE3MzE5NV0gQUNQSTogQWRkZWQgX09TSShQcm9jZXNzb3IgRGV2aWNlKQpbICAgIDAu
MTczMTk1XSBBQ1BJOiBBZGRlZCBfT1NJKDMuMCBfU0NQIEV4dGVuc2lvbnMpClsgICAgMC4x
NzMxOTVdIEFDUEk6IEFkZGVkIF9PU0koUHJvY2Vzc29yIEFnZ3JlZ2F0b3IgRGV2aWNlKQpb
ICAgIDAuMjg0MjkzXSBBQ1BJOiAzMCBBQ1BJIEFNTCB0YWJsZXMgc3VjY2Vzc2Z1bGx5IGFj
cXVpcmVkIGFuZCBsb2FkZWQKWyAgICAwLjI4OTExOF0gQUNQSTogW0Zpcm13YXJlIEJ1Z106
IEJJT1MgX09TSShMaW51eCkgcXVlcnkgaWdub3JlZApbICAgIDAuMzY4NzM1XSBBQ1BJOiBE
eW5hbWljIE9FTSBUYWJsZSBMb2FkOgpbICAgIDAuMzY4NzM1XSBBQ1BJOiBTU0RUIDB4RkZG
Rjg4ODEwMzREODgwMCAwMDAzOTQgKHYwMiBQbVJlZiAgQ3B1MENzdCAgMDAwMDMwMDEgSU5U
TCAyMDIwMDcxNykKWyAgICAwLjM2OTA3M10gQUNQSTogRHluYW1pYyBPRU0gVGFibGUgTG9h
ZDoKWyAgICAwLjM2OTA4MV0gQUNQSTogU1NEVCAweEZGRkY4ODgxMDU0N0IwMDAgMDAwNTNG
ICh2MDIgUG1SZWYgIENwdTBJc3QgIDAwMDAzMDAwIElOVEwgMjAyMDA3MTcpClsgICAgMC4z
NzAzOTZdIEFDUEk6IER5bmFtaWMgT0VNIFRhYmxlIExvYWQ6ClsgICAgMC4zNzA0MDRdIEFD
UEk6IFNTRFQgMHhGRkZGODg4MTA1NDAwQTAwIDAwMDFBQiAodjAyIFBtUmVmICBDcHUwUHNk
ICAwMDAwMzAwMCBJTlRMIDIwMjAwNzE3KQpbICAgIDAuMzcxNjI2XSBBQ1BJOiBEeW5hbWlj
IE9FTSBUYWJsZSBMb2FkOgpbICAgIDAuMzcxNjMzXSBBQ1BJOiBTU0RUIDB4RkZGRjg4ODEw
NTQ3OTgwMCAwMDA0QkQgKHYwMiBQbVJlZiAgQ3B1MEh3cCAgMDAwMDMwMDAgSU5UTCAyMDIw
MDcxNykKWyAgICAwLjM3MzMxNF0gQUNQSTogRHluYW1pYyBPRU0gVGFibGUgTG9hZDoKWyAg
ICAwLjM3MzMyNl0gQUNQSTogU1NEVCAweEZGRkY4ODgxMDM0RDQwMDAgMDAxQkFGICh2MDIg
UG1SZWYgIEFwSXN0ICAgIDAwMDAzMDAwIElOVEwgMjAyMDA3MTcpClsgICAgMC4zNzUzOTld
IEFDUEk6IER5bmFtaWMgT0VNIFRhYmxlIExvYWQ6ClsgICAgMC4zNzU0MDhdIEFDUEk6IFNT
RFQgMHhGRkZGODg4MTA1NDg0MDAwIDAwMTAzOCAodjAyIFBtUmVmICBBcEh3cCAgICAwMDAw
MzAwMCBJTlRMIDIwMjAwNzE3KQpbICAgIDAuMzc3MjIxXSBBQ1BJOiBEeW5hbWljIE9FTSBU
YWJsZSBMb2FkOgpbICAgIDAuMzc3MjMyXSBBQ1BJOiBTU0RUIDB4RkZGRjg4ODEwNTQ4MjAw
MCAwMDEzNDkgKHYwMiBQbVJlZiAgQXBQc2QgICAgMDAwMDMwMDAgSU5UTCAyMDIwMDcxNykK
WyAgICAwLjM3OTEwOV0gQUNQSTogRHluYW1pYyBPRU0gVGFibGUgTG9hZDoKWyAgICAwLjM3
OTExOF0gQUNQSTogU1NEVCAweEZGRkY4ODgxMDM0RTMwMDAgMDAwRkJCICh2MDIgUG1SZWYg
IEFwQ3N0ICAgIDAwMDAzMDAwIElOVEwgMjAyMDA3MTcpClsgICAgMC4zOTExNjhdIEFDUEk6
IF9PU0MgZXZhbHVhdGVkIHN1Y2Nlc3NmdWxseSBmb3IgYWxsIENQVXMKWyAgICAwLjM5MTIx
OF0gQUNQSTogRUM6IEVDIHN0YXJ0ZWQKWyAgICAwLjM5MTIxOV0gQUNQSTogRUM6IGludGVy
cnVwdCBibG9ja2VkClsgICAgMC40MTQ3MDJdIEFDUEk6IEVDOiBFQ19DTUQvRUNfU0M9MHg2
NiwgRUNfREFUQT0weDYyClsgICAgMC40MTQ3MDVdIEFDUEk6IFxfU0JfLlBDMDAuTFBDQi5F
QzBfOiBCb290IERTRFQgRUMgdXNlZCB0byBoYW5kbGUgdHJhbnNhY3Rpb25zClsgICAgMC40
MTQ3MDZdIEFDUEk6IEludGVycHJldGVyIGVuYWJsZWQKWyAgICAwLjQxNDc3NF0gQUNQSTog
UE06IChzdXBwb3J0cyBTMCBTMyBTNCBTNSkKWyAgICAwLjQxNDc3NF0gQUNQSTogVXNpbmcg
SU9BUElDIGZvciBpbnRlcnJ1cHQgcm91dGluZwpbICAgIDAuNDE2NDg1XSBQQ0k6IE1NQ09O
RklHIGZvciBkb21haW4gMDAwMCBbYnVzIDAwLWZmXSBhdCBbbWVtIDB4YzAwMDAwMDAtMHhj
ZmZmZmZmZl0gKGJhc2UgMHhjMDAwMDAwMCkKWyAgICAwLjQxNzk1NF0gUENJOiBNTUNPTkZJ
RyBhdCBbbWVtIDB4YzAwMDAwMDAtMHhjZmZmZmZmZl0gcmVzZXJ2ZWQgYXMgQUNQSSBtb3Ro
ZXJib2FyZCByZXNvdXJjZQpbICAgIDAuNDE3OTYzXSBQQ0k6IFVzaW5nIGhvc3QgYnJpZGdl
IHdpbmRvd3MgZnJvbSBBQ1BJOyBpZiBuZWNlc3NhcnksIHVzZSAicGNpPW5vY3JzIiBhbmQg
cmVwb3J0IGEgYnVnClsgICAgMC40MTc5NjRdIFBDSTogSWdub3JpbmcgRTgyMCByZXNlcnZh
dGlvbnMgZm9yIGhvc3QgYnJpZGdlIHdpbmRvd3MKWyAgICAwLjQxODg4Nl0gQUNQSTogRW5h
YmxlZCA4IEdQRXMgaW4gYmxvY2sgMDAgdG8gN0YKWyAgICAwLjQyNTM2OF0gQUNQSTogXF9T
Ql8uUEMwMC5QRUcxLlBYUF86IE5ldyBwb3dlciByZXNvdXJjZQpbICAgIDAuNDMyMDE4XSBB
Q1BJOiBcX1NCXy5QQzAwLlhIQ0kuUkhVQi5IUzE0LkJUUFI6IE5ldyBwb3dlciByZXNvdXJj
ZQpbICAgIDAuNDM4NTI1XSBBQ1BJOiBcX1NCXy5QQzAwLkNOVlcuV1JTVDogTmV3IHBvd2Vy
IHJlc291cmNlClsgICAgMC40NDUwMTFdIEFDUEk6IFxfU0JfLlBDMDAuUlAwOS5QWFBfOiBO
ZXcgcG93ZXIgcmVzb3VyY2UKWyAgICAwLjQ2NDgxM10gQUNQSTogXFBJTl86IE5ldyBwb3dl
ciByZXNvdXJjZQpbICAgIDAuNDY1MjkyXSBBQ1BJOiBQQ0kgUm9vdCBCcmlkZ2UgW1BDMDBd
IChkb21haW4gMDAwMCBbYnVzIDAwLWZlXSkKWyAgICAwLjQ2NTI5OF0gYWNwaSBQTlAwQTA4
OjAwOiBfT1NDOiBPUyBzdXBwb3J0cyBbRXh0ZW5kZWRDb25maWcgU2VnbWVudHMgTVNJIEVE
UiBIUFgtVHlwZTNdClsgICAgMC40NjUzMDBdIGFjcGkgUE5QMEEwODowMDogX09TQzogbm90
IHJlcXVlc3RpbmcgT1MgY29udHJvbDsgT1MgcmVxdWlyZXMgW0V4dGVuZGVkQ29uZmlnIEFT
UE0gQ2xvY2tQTSBNU0ldClsgICAgMC40NzA4OTNdIFBDSSBob3N0IGJyaWRnZSB0byBidXMg
MDAwMDowMApbICAgIDAuNDcwODk1XSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291
cmNlIFtpbyAgMHgwMDAwLTB4MGNmNyB3aW5kb3ddClsgICAgMC40NzA4OTddIHBjaV9idXMg
MDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW2lvICAweDBkMDAtMHhmZmZmIHdpbmRvd10K
WyAgICAwLjQ3MDg5OF0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVt
IDB4MDAwYTAwMDAtMHgwMDBiZmZmZiB3aW5kb3ddClsgICAgMC40NzA4OTldIHBjaV9idXMg
MDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW21lbSAweDU0ODAwMDAwLTB4YmZmZmZmZmYg
d2luZG93XQpbICAgIDAuNDcwOTAwXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291
cmNlIFttZW0gMHg0MDAwMDAwMDAwLTB4N2ZmZmZmZmZmZiB3aW5kb3ddClsgICAgMC40NzA5
MDJdIHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW2J1cyAwMC1mZV0KWyAg
ICAwLjQ3MDkzNF0gcGNpIDAwMDA6MDA6MDAuMDogWzgwODY6NDYzN10gdHlwZSAwMCBjbGFz
cyAweDA2MDAwMApbICAgIDAuNDcxMDQwXSBwY2kgMDAwMDowMDowMS4wOiBbODA4Njo0NjBk
XSB0eXBlIDAxIGNsYXNzIDB4MDYwNDAwClsgICAgMC40NzEwODZdIHBjaSAwMDAwOjAwOjAx
LjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xkClsgICAgMC40NzExMDVd
IHBjaSAwMDAwOjAwOjAxLjA6IFBUTSBlbmFibGVkIChyb290KSwgNG5zIGdyYW51bGFyaXR5
ClsgICAgMC40NzE3OTBdIHBjaSAwMDAwOjAwOjAyLjA6IFs4MDg2OjQ2ODhdIHR5cGUgMDAg
Y2xhc3MgMHgwMzAwMDAKWyAgICAwLjQ3MTc5N10gcGNpIDAwMDA6MDA6MDIuMDogcmVnIDB4
MTA6IFttZW0gMHg2NDViMDAwMDAwLTB4NjQ1YmZmZmZmZiA2NGJpdF0KWyAgICAwLjQ3MTgw
Ml0gcGNpIDAwMDA6MDA6MDIuMDogcmVnIDB4MTg6IFttZW0gMHg0MDAwMDAwMDAwLTB4NDAw
ZmZmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuNDcxODA1XSBwY2kgMDAwMDowMDowMi4wOiBy
ZWcgMHgyMDogW2lvICAweDUwMDAtMHg1MDNmXQpbICAgIDAuNDcxODE4XSBwY2kgMDAwMDow
MDowMi4wOiBCQVIgMjogYXNzaWduZWQgdG8gZWZpZmIKWyAgICAwLjQ3MTgxOV0gcGNpIDAw
MDA6MDA6MDIuMDogRE1BUjogU2tpcCBJT01NVSBkaXNhYmxpbmcgZm9yIGdyYXBoaWNzClsg
ICAgMC40NzE4MjFdIHBjaSAwMDAwOjAwOjAyLjA6IFZpZGVvIGRldmljZSB3aXRoIHNoYWRv
d2VkIFJPTSBhdCBbbWVtIDB4MDAwYzAwMDAtMHgwMDBkZmZmZl0KWyAgICAwLjQ3MTg0MV0g
cGNpIDAwMDA6MDA6MDIuMDogcmVnIDB4MzQ0OiBbbWVtIDB4MDAwMDAwMDAtMHgwMGZmZmZm
ZiA2NGJpdF0KWyAgICAwLjQ3MTg0Ml0gcGNpIDAwMDA6MDA6MDIuMDogVkYobikgQkFSMCBz
cGFjZTogW21lbSAweDAwMDAwMDAwLTB4MDZmZmZmZmYgNjRiaXRdIChjb250YWlucyBCQVIw
IGZvciA3IFZGcykKWyAgICAwLjQ3MTg0Nl0gcGNpIDAwMDA6MDA6MDIuMDogcmVnIDB4MzRj
OiBbbWVtIDB4MDAwMDAwMDAtMHgxZmZmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuNDcxODQ3
XSBwY2kgMDAwMDowMDowMi4wOiBWRihuKSBCQVIyIHNwYWNlOiBbbWVtIDB4MDAwMDAwMDAt
MHhkZmZmZmZmZiA2NGJpdCBwcmVmXSAoY29udGFpbnMgQkFSMiBmb3IgNyBWRnMpClsgICAg
MC40NzIwMDBdIHBjaSAwMDAwOjAwOjA0LjA6IFs4MDg2OjQ2MWRdIHR5cGUgMDAgY2xhc3Mg
MHgxMTgwMDAKWyAgICAwLjQ3MjAxMl0gcGNpIDAwMDA6MDA6MDQuMDogcmVnIDB4MTA6IFtt
ZW0gMHg2NDVjYjAwMDAwLTB4NjQ1Y2IxZmZmZiA2NGJpdF0KWyAgICAwLjQ3MjMzOF0gcGNp
IDAwMDA6MDA6MDYuMDogWzgwODY6NDY0ZF0gdHlwZSAwMSBjbGFzcyAweDA2MDQwMApbICAg
IDAuNDcyNDA0XSBwY2kgMDAwMDowMDowNi4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQz
aG90IEQzY29sZApbICAgIDAuNDcyNDI3XSBwY2kgMDAwMDowMDowNi4wOiBQVE0gZW5hYmxl
ZCAocm9vdCksIDRucyBncmFudWxhcml0eQpbICAgIDAuNDczMTcyXSBwY2kgMDAwMDowMDow
OC4wOiBbODA4Njo0NjRmXSB0eXBlIDAwIGNsYXNzIDB4MDg4MDAwClsgICAgMC40NzMxNzld
IHBjaSAwMDAwOjAwOjA4LjA6IHJlZyAweDEwOiBbbWVtIDB4NjQ1Y2I2NjAwMC0weDY0NWNi
NjZmZmYgNjRiaXRdClsgICAgMC40NzMyNjddIHBjaSAwMDAwOjAwOjBhLjA6IFs4MDg2OjQ2
N2RdIHR5cGUgMDAgY2xhc3MgMHgxMTgwMDAKWyAgICAwLjQ3MzI3NF0gcGNpIDAwMDA6MDA6
MGEuMDogcmVnIDB4MTA6IFttZW0gMHg2NDVjYjQwMDAwLTB4NjQ1Y2I0N2ZmZiA2NGJpdF0K
WyAgICAwLjQ3MzI5MF0gcGNpIDAwMDA6MDA6MGEuMDogZW5hYmxpbmcgRXh0ZW5kZWQgVGFn
cwpbICAgIDAuNDczMzg4XSBwY2kgMDAwMDowMDoxMi4wOiBbODA4Njo3YWY4XSB0eXBlIDAw
IGNsYXNzIDB4MDcwMDAwClsgICAgMC40NzM0MDhdIHBjaSAwMDAwOjAwOjEyLjA6IHJlZyAw
eDEwOiBbbWVtIDB4NjQ1Y2IzMDAwMC0weDY0NWNiM2ZmZmYgNjRiaXRdClsgICAgMC40NzM0
NzhdIHBjaSAwMDAwOjAwOjEyLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QKWyAg
ICAwLjQ3NDEwNV0gcGNpIDAwMDA6MDA6MTQuMDogWzgwODY6N2FlMF0gdHlwZSAwMCBjbGFz
cyAweDBjMDMzMApbICAgIDAuNDc0MTIxXSBwY2kgMDAwMDowMDoxNC4wOiByZWcgMHgxMDog
W21lbSAweDY0NWNiMjAwMDAtMHg2NDVjYjJmZmZmIDY0Yml0XQpbICAgIDAuNDc0MTgzXSBw
Y2kgMDAwMDowMDoxNC4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQzaG90IEQzY29sZApbICAg
IDAuNDc0NzUyXSBwY2kgMDAwMDowMDoxNC4yOiBbODA4Njo3YWE3XSB0eXBlIDAwIGNsYXNz
IDB4MDUwMDAwClsgICAgMC40NzQ3NzFdIHBjaSAwMDAwOjAwOjE0LjI6IHJlZyAweDEwOiBb
bWVtIDB4NjQ1Y2I1ODAwMC0weDY0NWNiNWJmZmYgNjRiaXRdClsgICAgMC40NzQ3ODRdIHBj
aSAwMDAwOjAwOjE0LjI6IHJlZyAweDE4OiBbbWVtIDB4NjQ1Y2I2NTAwMC0weDY0NWNiNjVm
ZmYgNjRiaXRdClsgICAgMC40NzQ5MjhdIHBjaSAwMDAwOjAwOjE0LjM6IFs4MDg2OjdhZjBd
IHR5cGUgMDAgY2xhc3MgMHgwMjgwMDAKWyAgICAwLjQ3NDk3MF0gcGNpIDAwMDA6MDA6MTQu
MzogcmVnIDB4MTA6IFttZW0gMHg2NDVjYjU0MDAwLTB4NjQ1Y2I1N2ZmZiA2NGJpdF0KWyAg
ICAwLjQ3NTA5MF0gcGNpIDAwMDA6MDA6MTQuMzogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBE
M2hvdCBEM2NvbGQKWyAgICAwLjQ3NTQxNF0gcGNpIDAwMDA6MDA6MTUuMDogWzgwODY6N2Fj
Y10gdHlwZSAwMCBjbGFzcyAweDBjODAwMApbICAgIDAuNDc1NDgyXSBwY2kgMDAwMDowMDox
NS4wOiByZWcgMHgxMDogW21lbSAweDAwMDAwMDAwLTB4MDAwMDBmZmYgNjRiaXRdClsgICAg
MC40NzU5NzJdIHBjaSAwMDAwOjAwOjE1LjE6IFs4MDg2OjdhY2RdIHR5cGUgMDAgY2xhc3Mg
MHgwYzgwMDAKWyAgICAwLjQ3NjA0M10gcGNpIDAwMDA6MDA6MTUuMTogcmVnIDB4MTA6IFtt
ZW0gMHgwMDAwMDAwMC0weDAwMDAwZmZmIDY0Yml0XQpbICAgIDAuNDc2NTI4XSBwY2kgMDAw
MDowMDoxNS4yOiBbODA4Njo3YWNlXSB0eXBlIDAwIGNsYXNzIDB4MGM4MDAwClsgICAgMC40
NzY1OTVdIHBjaSAwMDAwOjAwOjE1LjI6IHJlZyAweDEwOiBbbWVtIDB4MDAwMDAwMDAtMHgw
MDAwMGZmZiA2NGJpdF0KWyAgICAwLjQ3NzA2MV0gcGNpIDAwMDA6MDA6MTYuMDogWzgwODY6
N2FlOF0gdHlwZSAwMCBjbGFzcyAweDA3ODAwMApbICAgIDAuNDc3MDgyXSBwY2kgMDAwMDow
MDoxNi4wOiByZWcgMHgxMDogW21lbSAweDY0NWNiNjEwMDAtMHg2NDVjYjYxZmZmIDY0Yml0
XQpbICAgIDAuNDc3MTYwXSBwY2kgMDAwMDowMDoxNi4wOiBQTUUjIHN1cHBvcnRlZCBmcm9t
IEQzaG90ClsgICAgMC40Nzc3NjBdIHBjaSAwMDAwOjAwOjE2LjM6IFs4MDg2OjdhZWJdIHR5
cGUgMDAgY2xhc3MgMHgwNzAwMDIKWyAgICAwLjQ3Nzc3Ml0gcGNpIDAwMDA6MDA6MTYuMzog
cmVnIDB4MTA6IFtpbyAgMHg1MDYwLTB4NTA2N10KWyAgICAwLjQ3Nzc3OV0gcGNpIDAwMDA6
MDA6MTYuMzogcmVnIDB4MTQ6IFttZW0gMHg4OGRhMTAwMC0weDg4ZGExZmZmXQpbICAgIDAu
NDc3OTk2XSBwY2kgMDAwMDowMDoxOS4wOiBbODA4Njo3YWZjXSB0eXBlIDAwIGNsYXNzIDB4
MGM4MDAwClsgICAgMC40NzgwMjJdIHBjaSAwMDAwOjAwOjE5LjA6IHJlZyAweDEwOiBbbWVt
IDB4MDAwMDAwMDAtMHgwMDAwMGZmZiA2NGJpdF0KWyAgICAwLjQ3ODMwOV0gcGNpIDAwMDA6
MDA6MTkuMjogWzgwODY6N2FmZV0gdHlwZSAwMCBjbGFzcyAweDA3ODAwMApbICAgIDAuNDc4
MzM4XSBwY2kgMDAwMDowMDoxOS4yOiByZWcgMHgxMDogW21lbSAweDAwMDAwMDAwLTB4MDAw
MDBmZmYgNjRiaXRdClsgICAgMC40Nzg4NzBdIHBjaSAwMDAwOjAwOjFiLjA6IFs4MDg2Ojdh
YzRdIHR5cGUgMDEgY2xhc3MgMHgwNjA0MDAKWyAgICAwLjQ3OTAxMV0gcGNpIDAwMDA6MDA6
MWIuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAgICAwLjQ3OTA1
OF0gcGNpIDAwMDA6MDA6MWIuMDogUFRNIGVuYWJsZWQgKHJvb3QpLCA0bnMgZ3JhbnVsYXJp
dHkKWyAgICAwLjQ3OTkxMV0gcGNpIDAwMDA6MDA6MWMuMDogWzgwODY6N2FiZF0gdHlwZSAw
MSBjbGFzcyAweDA2MDQwMApbICAgIDAuNDgwMDEzXSBwY2kgMDAwMDowMDoxYy4wOiBQTUUj
IHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAgIDAuNDgwMDUzXSBwY2kgMDAw
MDowMDoxYy4wOiBQVE0gZW5hYmxlZCAocm9vdCksIDRucyBncmFudWxhcml0eQpbICAgIDAu
NDgwODM3XSBwY2kgMDAwMDowMDoxZC4wOiBbODA4Njo3YWIwXSB0eXBlIDAxIGNsYXNzIDB4
MDYwNDAwClsgICAgMC40ODA5NDRdIHBjaSAwMDAwOjAwOjFkLjA6IFBNRSMgc3VwcG9ydGVk
IGZyb20gRDAgRDNob3QgRDNjb2xkClsgICAgMC40ODA5ODVdIHBjaSAwMDAwOjAwOjFkLjA6
IFBUTSBlbmFibGVkIChyb290KSwgNG5zIGdyYW51bGFyaXR5ClsgICAgMC40ODE4NDldIHBj
aSAwMDAwOjAwOjFlLjA6IFs4MDg2OjdhYThdIHR5cGUgMDAgY2xhc3MgMHgwNzgwMDAKWyAg
ICAwLjQ4MTkxOF0gcGNpIDAwMDA6MDA6MWUuMDogcmVnIDB4MTA6IFttZW0gMHgwMDAwMDAw
MC0weDAwMDAwZmZmIDY0Yml0XQpbICAgIDAuNDgyNDYwXSBwY2kgMDAwMDowMDoxZS4yOiBb
ODA4Njo3YWFhXSB0eXBlIDAwIGNsYXNzIDB4MGM4MDAwClsgICAgMC40ODI1MjldIHBjaSAw
MDAwOjAwOjFlLjI6IHJlZyAweDEwOiBbbWVtIDB4MDAwMDAwMDAtMHgwMDAwMGZmZiA2NGJp
dF0KWyAgICAwLjQ4Mjk0M10gcGNpIDAwMDA6MDA6MWYuMDogWzgwODY6N2E4ZF0gdHlwZSAw
MCBjbGFzcyAweDA2MDEwMApbICAgIDAuNDgzMzI4XSBwY2kgMDAwMDowMDoxZi4zOiBbODA4
Njo3YWQwXSB0eXBlIDAwIGNsYXNzIDB4MDQwMTAwClsgICAgMC40ODMzNjldIHBjaSAwMDAw
OjAwOjFmLjM6IHJlZyAweDEwOiBbbWVtIDB4NjQ1Y2I1MDAwMC0weDY0NWNiNTNmZmYgNjRi
aXRdClsgICAgMC40ODM0MjFdIHBjaSAwMDAwOjAwOjFmLjM6IHJlZyAweDIwOiBbbWVtIDB4
NjQ1Y2EwMDAwMC0weDY0NWNhZmZmZmYgNjRiaXRdClsgICAgMC40ODM1MjJdIHBjaSAwMDAw
OjAwOjFmLjM6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDNob3QgRDNjb2xkClsgICAgMC40ODM2
MThdIHBjaSAwMDAwOjAwOjFmLjQ6IFs4MDg2OjdhYTNdIHR5cGUgMDAgY2xhc3MgMHgwYzA1
MDAKWyAgICAwLjQ4MzYzOV0gcGNpIDAwMDA6MDA6MWYuNDogcmVnIDB4MTA6IFttZW0gMHg2
NDVjYjVjMDAwLTB4NjQ1Y2I1YzBmZiA2NGJpdF0KWyAgICAwLjQ4MzY2MF0gcGNpIDAwMDA6
MDA6MWYuNDogcmVnIDB4MjA6IFtpbyAgMHhlZmEwLTB4ZWZiZl0KWyAgICAwLjQ4Mzk0Nl0g
cGNpIDAwMDA6MDA6MWYuNTogWzgwODY6N2FhNF0gdHlwZSAwMCBjbGFzcyAweDBjODAwMApb
ICAgIDAuNDgzOTY0XSBwY2kgMDAwMDowMDoxZi41OiByZWcgMHgxMDogW21lbSAweGZlMDEw
MDAwLTB4ZmUwMTBmZmZdClsgICAgMC40ODQwOTNdIHBjaSAwMDAwOjAwOjFmLjY6IFs4MDg2
OjFhMWNdIHR5cGUgMDAgY2xhc3MgMHgwMjAwMDAKWyAgICAwLjQ4NDExOF0gcGNpIDAwMDA6
MDA6MWYuNjogcmVnIDB4MTA6IFttZW0gMHg4OGQ4MDAwMC0weDg4ZDlmZmZmXQpbICAgIDAu
NDg0MjM3XSBwY2kgMDAwMDowMDoxZi42OiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90
IEQzY29sZApbICAgIDAuNDg0NTU0XSBwY2kgMDAwMDowMTowMC4wOiBbMTBkZToyNGI5XSB0
eXBlIDAwIGNsYXNzIDB4MDMwMDAwClsgICAgMC40ODQ1NjJdIHBjaSAwMDAwOjAxOjAwLjA6
IHJlZyAweDEwOiBbbWVtIDB4ODcwMDAwMDAtMHg4N2ZmZmZmZl0KWyAgICAwLjQ4NDU2OV0g
cGNpIDAwMDA6MDE6MDAuMDogcmVnIDB4MTQ6IFttZW0gMHg2MDAwMDAwMDAwLTB4NjNmZmZm
ZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuNDg0NTc2XSBwY2kgMDAwMDowMTowMC4wOiByZWcg
MHgxYzogW21lbSAweDY0MDAwMDAwMDAtMHg2NDAxZmZmZmZmIDY0Yml0IHByZWZdClsgICAg
MC40ODQ1ODFdIHBjaSAwMDAwOjAxOjAwLjA6IHJlZyAweDI0OiBbaW8gIDB4NDAwMC0weDQw
N2ZdClsgICAgMC40ODQ1ODVdIHBjaSAwMDAwOjAxOjAwLjA6IHJlZyAweDMwOiBbbWVtIDB4
ZmZmODAwMDAtMHhmZmZmZmZmZiBwcmVmXQpbICAgIDAuNDg0NjI2XSBwY2kgMDAwMDowMTow
MC4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90ClsgICAgMC40ODQ4OTFdIHBjaSAw
MDAwOjAxOjAwLjE6IFsxMGRlOjIyOGJdIHR5cGUgMDAgY2xhc3MgMHgwNDAzMDAKWyAgICAw
LjQ4NDg5OF0gcGNpIDAwMDA6MDE6MDAuMTogcmVnIDB4MTA6IFttZW0gMHg4ODAwMDAwMC0w
eDg4MDAzZmZmXQpbICAgIDAuNDg0OTk3XSBwY2kgMDAwMDowMDowMS4wOiBQQ0kgYnJpZGdl
IHRvIFtidXMgMDFdClsgICAgMC40ODQ5OTldIHBjaSAwMDAwOjAwOjAxLjA6ICAgYnJpZGdl
IHdpbmRvdyBbaW8gIDB4NDAwMC0weDRmZmZdClsgICAgMC40ODUwMDFdIHBjaSAwMDAwOjAw
OjAxLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ODcwMDAwMDAtMHg4ODBmZmZmZl0KWyAg
ICAwLjQ4NTAwNF0gcGNpIDAwMDA6MDA6MDEuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHg2
MDAwMDAwMDAwLTB4NjQwMWZmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuNDg1NzcyXSBwY2kg
MDAwMDowMjowMC4wOiBbMTQ0ZDphODBhXSB0eXBlIDAwIGNsYXNzIDB4MDEwODAyClsgICAg
MC40ODU3ODZdIHBjaSAwMDAwOjAyOjAwLjA6IHJlZyAweDEwOiBbbWVtIDB4ODhjMDAwMDAt
MHg4OGMwM2ZmZiA2NGJpdF0KWyAgICAwLjQ4NTk4OF0gcGNpIDAwMDA6MDA6MDYuMDogUENJ
IGJyaWRnZSB0byBbYnVzIDAyXQpbICAgIDAuNDg1OTkwXSBwY2kgMDAwMDowMDowNi4wOiAg
IGJyaWRnZSB3aW5kb3cgW21lbSAweDg4YzAwMDAwLTB4ODhjZmZmZmZdClsgICAgMC40ODYz
MTldIHBjaSAwMDAwOjAzOjAwLjA6IFsxNWI3OjUwMTFdIHR5cGUgMDAgY2xhc3MgMHgwMTA4
MDIKWyAgICAwLjQ4NjM0MF0gcGNpIDAwMDA6MDM6MDAuMDogcmVnIDB4MTA6IFttZW0gMHg4
OGIwMDAwMC0weDg4YjAzZmZmIDY0Yml0XQpbICAgIDAuNDg2NjM2XSBwY2kgMDAwMDowMDox
Yi4wOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDNdClsgICAgMC40ODY2NDhdIHBjaSAwMDAwOjAw
OjFiLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ODhiMDAwMDAtMHg4OGJmZmZmZl0KWyAg
ICAwLjQ4NjcyMF0gcGNpIDAwMDA6MDQ6MDAuMDogWzEwZWM6NTI2MV0gdHlwZSAwMCBjbGFz
cyAweGZmMDAwMApbICAgIDAuNDg2NzQxXSBwY2kgMDAwMDowNDowMC4wOiByZWcgMHgxMDog
W21lbSAweDg4MTAwMDAwLTB4ODgxMDBmZmZdClsgICAgMC40ODY4OTVdIHBjaSAwMDAwOjA0
OjAwLjA6IHN1cHBvcnRzIEQxIEQyClsgICAgMC40ODY4OTZdIHBjaSAwMDAwOjA0OjAwLjA6
IFBNRSMgc3VwcG9ydGVkIGZyb20gRDEgRDIgRDNob3QgRDNjb2xkClsgICAgMC40ODcwNzVd
IHBjaSAwMDAwOjAwOjFjLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwNF0KWyAgICAwLjQ4NzA4
NV0gcGNpIDAwMDA6MDA6MWMuMDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHgzMDAwLTB4M2Zm
Zl0KWyAgICAwLjQ4NzA4OF0gcGNpIDAwMDA6MDA6MWMuMDogICBicmlkZ2Ugd2luZG93IFtt
ZW0gMHg4ODEwMDAwMC0weDg4YWZmZmZmXQpbICAgIDAuNDg3MDkyXSBwY2kgMDAwMDowMDox
Yy4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDY0NWMwMDAwMDAtMHg2NDVjOWZmZmZmIDY0
Yml0IHByZWZdClsgICAgMC40ODcyMTBdIHBjaSAwMDAwOjA1OjAwLjA6IFs4MDg2OjExMzZd
IHR5cGUgMDEgY2xhc3MgMHgwNjA0MDAKWyAgICAwLjQ4NzI3Ml0gcGNpIDAwMDA6MDU6MDAu
MDogZW5hYmxpbmcgRXh0ZW5kZWQgVGFncwpbICAgIDAuNDg3MzkxXSBwY2kgMDAwMDowNTow
MC4wOiBzdXBwb3J0cyBEMSBEMgpbICAgIDAuNDg3MzkyXSBwY2kgMDAwMDowNTowMC4wOiBQ
TUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQxIEQyIEQzaG90IEQzY29sZApbICAgIDAuNDg3NTA5
XSBwY2kgMDAwMDowNTowMC4wOiBQVE0gZW5hYmxlZCwgNG5zIGdyYW51bGFyaXR5ClsgICAg
MC40ODc2ODNdIHBjaSAwMDAwOjAwOjFkLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwNS02ZV0K
WyAgICAwLjQ4NzY5NF0gcGNpIDAwMDA6MDA6MWQuMDogICBicmlkZ2Ugd2luZG93IFttZW0g
MHg1ODAwMDAwMC0weDg2MGZmZmZmXQpbICAgIDAuNDg3Njk4XSBwY2kgMDAwMDowMDoxZC4w
OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDY0MTAwMDAwMDAtMHg2NDVhMGZmZmZmIDY0Yml0
IHByZWZdClsgICAgMC40ODc3ODRdIHBjaSAwMDAwOjA2OjAwLjA6IFs4MDg2OjExMzZdIHR5
cGUgMDEgY2xhc3MgMHgwNjA0MDAKWyAgICAwLjQ4Nzg0N10gcGNpIDAwMDA6MDY6MDAuMDog
ZW5hYmxpbmcgRXh0ZW5kZWQgVGFncwpbICAgIDAuNDg3OTY0XSBwY2kgMDAwMDowNjowMC4w
OiBzdXBwb3J0cyBEMSBEMgpbICAgIDAuNDg3OTY1XSBwY2kgMDAwMDowNjowMC4wOiBQTUUj
IHN1cHBvcnRlZCBmcm9tIEQwIEQxIEQyIEQzaG90IEQzY29sZApbICAgIDAuNDg4MTk4XSBw
Y2kgMDAwMDowNjowMS4wOiBbODA4NjoxMTM2XSB0eXBlIDAxIGNsYXNzIDB4MDYwNDAwClsg
ICAgMC40ODgyNjFdIHBjaSAwMDAwOjA2OjAxLjA6IGVuYWJsaW5nIEV4dGVuZGVkIFRhZ3MK
WyAgICAwLjQ4ODM4MF0gcGNpIDAwMDA6MDY6MDEuMDogc3VwcG9ydHMgRDEgRDIKWyAgICAw
LjQ4ODM4MV0gcGNpIDAwMDA6MDY6MDEuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEMSBE
MiBEM2hvdCBEM2NvbGQKWyAgICAwLjQ4ODYwNF0gcGNpIDAwMDA6MDY6MDIuMDogWzgwODY6
MTEzNl0gdHlwZSAwMSBjbGFzcyAweDA2MDQwMApbICAgIDAuNDg4NjY3XSBwY2kgMDAwMDow
NjowMi4wOiBlbmFibGluZyBFeHRlbmRlZCBUYWdzClsgICAgMC40ODg3NzhdIHBjaSAwMDAw
OjA2OjAyLjA6IHN1cHBvcnRzIEQxIEQyClsgICAgMC40ODg3NzldIHBjaSAwMDAwOjA2OjAy
LjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDEgRDIgRDNob3QgRDNjb2xkClsgICAgMC40
ODkwMTFdIHBjaSAwMDAwOjA2OjAzLjA6IFs4MDg2OjExMzZdIHR5cGUgMDEgY2xhc3MgMHgw
NjA0MDAKWyAgICAwLjQ4OTA3NV0gcGNpIDAwMDA6MDY6MDMuMDogZW5hYmxpbmcgRXh0ZW5k
ZWQgVGFncwpbICAgIDAuNDg5MTk0XSBwY2kgMDAwMDowNjowMy4wOiBzdXBwb3J0cyBEMSBE
MgpbICAgIDAuNDg5MTk1XSBwY2kgMDAwMDowNjowMy4wOiBQTUUjIHN1cHBvcnRlZCBmcm9t
IEQwIEQxIEQyIEQzaG90IEQzY29sZApbICAgIDAuNDg5NDI3XSBwY2kgMDAwMDowNTowMC4w
OiBQQ0kgYnJpZGdlIHRvIFtidXMgMDYtNmVdClsgICAgMC40ODk0MzZdIHBjaSAwMDAwOjA1
OjAwLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4NTgwMDAwMDAtMHg4NWVmZmZmZl0KWyAg
ICAwLjQ4OTQ0Ml0gcGNpIDAwMDA6MDU6MDAuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHg2
NDEwMDAwMDAwLTB4NjQ1YTBmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuNDg5NTIyXSBwY2kg
MDAwMDowNzowMC4wOiBbODA4NjoxMTM3XSB0eXBlIDAwIGNsYXNzIDB4MGMwMzQwClsgICAg
MC40ODk1NDhdIHBjaSAwMDAwOjA3OjAwLjA6IHJlZyAweDEwOiBbbWVtIDB4NjQ1YTAwMDAw
MC0weDY0NWEwM2ZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjQ4OTU2NF0gcGNpIDAwMDA6MDc6
MDAuMDogcmVnIDB4MTg6IFttZW0gMHg2NDVhMDQwMDAwLTB4NjQ1YTA0MGZmZiA2NGJpdCBw
cmVmXQpbICAgIDAuNDg5NjAwXSBwY2kgMDAwMDowNzowMC4wOiBlbmFibGluZyBFeHRlbmRl
ZCBUYWdzClsgICAgMC40ODk3MTldIHBjaSAwMDAwOjA3OjAwLjA6IHN1cHBvcnRzIEQxIEQy
ClsgICAgMC40ODk3MTldIHBjaSAwMDAwOjA3OjAwLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20g
RDAgRDEgRDIgRDNob3QgRDNjb2xkClsgICAgMC40ODk5MTRdIHBjaSAwMDAwOjA2OjAwLjA6
IFBDSSBicmlkZ2UgdG8gW2J1cyAwN10KWyAgICAwLjQ4OTkzN10gcGNpIDAwMDA6MDY6MDAu
MDogICBicmlkZ2Ugd2luZG93IFttZW0gMHg2NDVhMDAwMDAwLTB4NjQ1YTBmZmZmZiA2NGJp
dCBwcmVmXQpbICAgIDAuNDg5OTg0XSBwY2kgMDAwMDowNjowMS4wOiBQQ0kgYnJpZGdlIHRv
IFtidXMgMDgtM2FdClsgICAgMC40ODk5OTRdIHBjaSAwMDAwOjA2OjAxLjA6ICAgYnJpZGdl
IHdpbmRvdyBbbWVtIDB4NmYwMDAwMDAtMHg4NWVmZmZmZl0KWyAgICAwLjQ5MDAwMF0gcGNp
IDAwMDA6MDY6MDEuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHg2NDM1MDAwMDAwLTB4NjQ1
OWZmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuNDkwMDg3XSBwY2kgMDAwMDozYjowMC4wOiBb
ODA4NjoxMTM4XSB0eXBlIDAwIGNsYXNzIDB4MGMwMzMwClsgICAgMC40OTAxMTBdIHBjaSAw
MDAwOjNiOjAwLjA6IHJlZyAweDEwOiBbbWVtIDB4NmVmMDAwMDAtMHg2ZWYwZmZmZiA2NGJp
dF0KWyAgICAwLjQ5MDE1OV0gcGNpIDAwMDA6M2I6MDAuMDogZW5hYmxpbmcgRXh0ZW5kZWQg
VGFncwpbICAgIDAuNDkwMjQxXSBwY2kgMDAwMDozYjowMC4wOiBQTUUjIHN1cHBvcnRlZCBm
cm9tIEQzaG90IEQzY29sZApbICAgIDAuNDkwMzQ4XSBwY2kgMDAwMDowNjowMi4wOiBQQ0kg
YnJpZGdlIHRvIFtidXMgM2JdClsgICAgMC40OTAzNjJdIHBjaSAwMDAwOjA2OjAyLjA6ICAg
YnJpZGdlIHdpbmRvdyBbbWVtIDB4NmVmMDAwMDAtMHg2ZWZmZmZmZl0KWyAgICAwLjQ5MDQx
NF0gcGNpIDAwMDA6MDY6MDMuMDogUENJIGJyaWRnZSB0byBbYnVzIDNjLTZlXQpbICAgIDAu
NDkwNDIzXSBwY2kgMDAwMDowNjowMy4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDU4MDAw
MDAwLTB4NmVlZmZmZmZdClsgICAgMC40OTA0MzBdIHBjaSAwMDAwOjA2OjAzLjA6ICAgYnJp
ZGdlIHdpbmRvdyBbbWVtIDB4NjQxMDAwMDAwMC0weDY0MzRmZmZmZmYgNjRiaXQgcHJlZl0K
WyAgICAwLjQ5NTQ3OF0gQUNQSTogRUM6IGludGVycnVwdCB1bmJsb2NrZWQKWyAgICAwLjQ5
NTQ4MF0gQUNQSTogRUM6IGV2ZW50IHVuYmxvY2tlZApbICAgIDAuNDk1NDk1XSBBQ1BJOiBF
QzogRUNfQ01EL0VDX1NDPTB4NjYsIEVDX0RBVEE9MHg2MgpbICAgIDAuNDk1NDk2XSBBQ1BJ
OiBFQzogR1BFPTB4NmUKWyAgICAwLjQ5NTQ5N10gQUNQSTogXF9TQl8uUEMwMC5MUENCLkVD
MF86IEJvb3QgRFNEVCBFQyBpbml0aWFsaXphdGlvbiBjb21wbGV0ZQpbICAgIDAuNDk1NDk4
XSBBQ1BJOiBcX1NCXy5QQzAwLkxQQ0IuRUMwXzogRUM6IFVzZWQgdG8gaGFuZGxlIHRyYW5z
YWN0aW9ucyBhbmQgZXZlbnRzClsgICAgMC40OTU1NjNdIGlvbW11OiBEZWZhdWx0IGRvbWFp
biB0eXBlOiBUcmFuc2xhdGVkClsgICAgMC40OTU1NjNdIGlvbW11OiBETUEgZG9tYWluIFRM
QiBpbnZhbGlkYXRpb24gcG9saWN5OiBsYXp5IG1vZGUKWyAgICAwLjQ5NTU2M10gU0NTSSBz
dWJzeXN0ZW0gaW5pdGlhbGl6ZWQKWyAgICAwLjQ5NTU2M10gbGliYXRhIHZlcnNpb24gMy4w
MCBsb2FkZWQuClsgICAgMC40OTU1NjNdIEFDUEk6IGJ1cyB0eXBlIFVTQiByZWdpc3RlcmVk
ClsgICAgMC40OTU1NjNdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2
ZXIgdXNiZnMKWyAgICAwLjQ5NTU2M10gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJm
YWNlIGRyaXZlciBodWIKWyAgICAwLjQ5NTU2M10gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcg
ZGV2aWNlIGRyaXZlciB1c2IKWyAgICAwLjQ5NTU2M10gcHBzX2NvcmU6IExpbnV4UFBTIEFQ
SSB2ZXIuIDEgcmVnaXN0ZXJlZApbICAgIDAuNDk1NTYzXSBwcHNfY29yZTogU29mdHdhcmUg
dmVyLiA1LjMuNiAtIENvcHlyaWdodCAyMDA1LTIwMDcgUm9kb2xmbyBHaW9tZXR0aSA8Z2lv
bWV0dGlAbGludXguaXQ+ClsgICAgMC40OTU1NjNdIFBUUCBjbG9jayBzdXBwb3J0IHJlZ2lz
dGVyZWQKWyAgICAwLjQ5NTU2M10gRURBQyBNQzogVmVyOiAzLjAuMApbICAgIDAuNDk2OTcy
XSBlZml2YXJzOiBSZWdpc3RlcmVkIGVmaXZhcnMgb3BlcmF0aW9ucwpbICAgIDAuNDk2OTcy
XSBOZXRMYWJlbDogSW5pdGlhbGl6aW5nClsgICAgMC40OTY5NzJdIE5ldExhYmVsOiAgZG9t
YWluIGhhc2ggc2l6ZSA9IDEyOApbICAgIDAuNDk2OTcyXSBOZXRMYWJlbDogIHByb3RvY29s
cyA9IFVOTEFCRUxFRCBDSVBTT3Y0IENBTElQU08KWyAgICAwLjQ5Njk3Ml0gTmV0TGFiZWw6
ICB1bmxhYmVsZWQgdHJhZmZpYyBhbGxvd2VkIGJ5IGRlZmF1bHQKWyAgICAwLjQ5Njk3Ml0g
bWN0cDogbWFuYWdlbWVudCBjb21wb25lbnQgdHJhbnNwb3J0IHByb3RvY29sIGNvcmUKWyAg
ICAwLjQ5Njk3Ml0gTkVUOiBSZWdpc3RlcmVkIFBGX01DVFAgcHJvdG9jb2wgZmFtaWx5Clsg
ICAgMC40OTY5NzJdIFBDSTogVXNpbmcgQUNQSSBmb3IgSVJRIHJvdXRpbmcKWyAgICAwLjUx
NDYyN10gUENJOiBwY2lfY2FjaGVfbGluZV9zaXplIHNldCB0byA2NCBieXRlcwpbICAgIDAu
NTE1Nzc1XSBwY2kgMDAwMDowMDoxZi41OiBjYW4ndCBjbGFpbSBCQVIgMCBbbWVtIDB4ZmUw
MTAwMDAtMHhmZTAxMGZmZl06IG5vIGNvbXBhdGlibGUgYnJpZGdlIHdpbmRvdwpbICAgIDAu
NTE2NzA4XSBlODIwOiByZXNlcnZlIFJBTSBidWZmZXIgW21lbSAweDAwMDlmMDAwLTB4MDAw
OWZmZmZdClsgICAgMC41MTY3MDldIGU4MjA6IHJlc2VydmUgUkFNIGJ1ZmZlciBbbWVtIDB4
MmU4NjYwMDAtMHgyZmZmZmZmZl0KWyAgICAwLjUxNjcxMF0gZTgyMDogcmVzZXJ2ZSBSQU0g
YnVmZmVyIFttZW0gMHgzYjhkZDAwMC0weDNiZmZmZmZmXQpbICAgIDAuNTE2NzExXSBlODIw
OiByZXNlcnZlIFJBTSBidWZmZXIgW21lbSAweDQxYzAwMDAwLTB4NDNmZmZmZmZdClsgICAg
MC41MTY3MTJdIGU4MjA6IHJlc2VydmUgUkFNIGJ1ZmZlciBbbWVtIDB4OGFiODAwMDAwLTB4
OGFiZmZmZmZmXQpbICAgIDAuNTE2NzM3XSBwY2kgMDAwMDowMDowMi4wOiB2Z2FhcmI6IHNl
dHRpbmcgYXMgYm9vdCBWR0EgZGV2aWNlClsgICAgMC41MTY3MzddIHBjaSAwMDAwOjAwOjAy
LjA6IHZnYWFyYjogYnJpZGdlIGNvbnRyb2wgcG9zc2libGUKWyAgICAwLjUxNjczN10gcGNp
IDAwMDA6MDA6MDIuMDogdmdhYXJiOiBWR0EgZGV2aWNlIGFkZGVkOiBkZWNvZGVzPWlvK21l
bSxvd25zPWlvK21lbSxsb2Nrcz1ub25lClsgICAgMC41MTY3MzhdIHBjaSAwMDAwOjAxOjAw
LjA6IHZnYWFyYjogYnJpZGdlIGNvbnRyb2wgcG9zc2libGUKWyAgICAwLjUxNjczOV0gcGNp
IDAwMDA6MDE6MDAuMDogdmdhYXJiOiBWR0EgZGV2aWNlIGFkZGVkOiBkZWNvZGVzPWlvK21l
bSxvd25zPW5vbmUsbG9ja3M9bm9uZQpbICAgIDAuNTE2NzQxXSB2Z2FhcmI6IGxvYWRlZApb
ICAgIDAuNTE2ODM0XSBjbG9ja3NvdXJjZTogU3dpdGNoZWQgdG8gY2xvY2tzb3VyY2UgdHNj
LWVhcmx5ClsgICAgMC41MTcxMDhdIFZGUzogRGlzayBxdW90YXMgZHF1b3RfNi42LjAKWyAg
ICAwLjUxNzEyMF0gVkZTOiBEcXVvdC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDUxMiAo
b3JkZXIgMCwgNDA5NiBieXRlcykKWyAgICAwLjUxNzIwN10gQXBwQXJtb3I6IEFwcEFybW9y
IEZpbGVzeXN0ZW0gRW5hYmxlZApbICAgIDAuNTE3MjM1XSBwbnA6IFBuUCBBQ1BJIGluaXQK
WyAgICAwLjUxNzc1NV0gc3lzdGVtIDAwOjAwOiBbaW8gIDB4MDY4MC0weDA2OWZdIGhhcyBi
ZWVuIHJlc2VydmVkClsgICAgMC41MTc3NThdIHN5c3RlbSAwMDowMDogW2lvICAweDE2NGUt
MHgxNjRmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuNTE3OTA3XSBzeXN0ZW0gMDA6MDE6
IFtpbyAgMHgxODU0LTB4MTg1N10gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjUxODAwOF0g
c3lzdGVtIDAwOjAzOiBbaW8gIDB4MDIwMC0weDAyN2ZdIGhhcyBiZWVuIHJlc2VydmVkClsg
ICAgMC41MTgwMTBdIHN5c3RlbSAwMDowMzogW21lbSAweGZlZGYwMDAwLTB4ZmVkZmZmZmZd
IGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC41MTg0MDddIHBucCAwMDowNDogZGlzYWJsaW5n
IFttZW0gMHhjMDAwMDAwMC0weGNmZmZmZmZmXSBiZWNhdXNlIGl0IG92ZXJsYXBzIDAwMDA6
MDA6MDIuMCBCQVIgOSBbbWVtIDB4MDAwMDAwMDAtMHhkZmZmZmZmZiA2NGJpdCBwcmVmXQpb
ICAgIDAuNTE4NDM1XSBzeXN0ZW0gMDA6MDQ6IFttZW0gMHhmZWRjMDAwMC0weGZlZGM3ZmZm
XSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuNTE4NDM2XSBzeXN0ZW0gMDA6MDQ6IFttZW0g
MHhmZWRhMDAwMC0weGZlZGEwZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuNTE4NDM3
XSBzeXN0ZW0gMDA6MDQ6IFttZW0gMHhmZWRhMTAwMC0weGZlZGExZmZmXSBoYXMgYmVlbiBy
ZXNlcnZlZApbICAgIDAuNTE4NDM5XSBzeXN0ZW0gMDA6MDQ6IFttZW0gMHhmZWQyMDAwMC0w
eGZlZDdmZmZmXSBjb3VsZCBub3QgYmUgcmVzZXJ2ZWQKWyAgICAwLjUxODQ0MF0gc3lzdGVt
IDAwOjA0OiBbbWVtIDB4ZmVkOTAwMDAtMHhmZWQ5M2ZmZl0gY291bGQgbm90IGJlIHJlc2Vy
dmVkClsgICAgMC41MTg0NDFdIHN5c3RlbSAwMDowNDogW21lbSAweGZlZDQ1MDAwLTB4ZmVk
OGZmZmZdIGNvdWxkIG5vdCBiZSByZXNlcnZlZApbICAgIDAuNTE4NDQyXSBzeXN0ZW0gMDA6
MDQ6IFttZW0gMHhmZWUwMDAwMC0weGZlZWZmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAg
IDAuNTE4Nzg3XSBzeXN0ZW0gMDA6MDU6IFtpbyAgMHgyMDAwLTB4MjBmZV0gaGFzIGJlZW4g
cmVzZXJ2ZWQKWyAgICAwLjUxOTYxOF0gcG5wOiBQblAgQUNQSTogZm91bmQgNyBkZXZpY2Vz
ClsgICAgMC41MjUxNjddIGNsb2Nrc291cmNlOiBhY3BpX3BtOiBtYXNrOiAweGZmZmZmZiBt
YXhfY3ljbGVzOiAweGZmZmZmZiwgbWF4X2lkbGVfbnM6IDIwODU3MDEwMjQgbnMKWyAgICAw
LjUyNTIyMF0gTkVUOiBSZWdpc3RlcmVkIFBGX0lORVQgcHJvdG9jb2wgZmFtaWx5ClsgICAg
MC41MjU0MTRdIElQIGlkZW50cyBoYXNoIHRhYmxlIGVudHJpZXM6IDI2MjE0NCAob3JkZXI6
IDksIDIwOTcxNTIgYnl0ZXMsIGxpbmVhcikKWyAgICAwLjUyODEzMF0gdGNwX2xpc3Rlbl9w
b3J0YWRkcl9oYXNoIGhhc2ggdGFibGUgZW50cmllczogMTYzODQgKG9yZGVyOiA2LCAyNjIx
NDQgYnl0ZXMsIGxpbmVhcikKWyAgICAwLjUyODE3MV0gVGFibGUtcGVydHVyYiBoYXNoIHRh
YmxlIGVudHJpZXM6IDY1NTM2IChvcmRlcjogNiwgMjYyMTQ0IGJ5dGVzLCBsaW5lYXIpClsg
ICAgMC41MjgzNDldIFRDUCBlc3RhYmxpc2hlZCBoYXNoIHRhYmxlIGVudHJpZXM6IDI2MjE0
NCAob3JkZXI6IDksIDIwOTcxNTIgYnl0ZXMsIGxpbmVhcikKWyAgICAwLjUyODcwNl0gVENQ
IGJpbmQgaGFzaCB0YWJsZSBlbnRyaWVzOiA2NTUzNiAob3JkZXI6IDksIDIwOTcxNTIgYnl0
ZXMsIGxpbmVhcikKWyAgICAwLjUyODgwNV0gVENQOiBIYXNoIHRhYmxlcyBjb25maWd1cmVk
IChlc3RhYmxpc2hlZCAyNjIxNDQgYmluZCA2NTUzNikKWyAgICAwLjUyODk2M10gTVBUQ1Ag
dG9rZW4gaGFzaCB0YWJsZSBlbnRyaWVzOiAzMjc2OCAob3JkZXI6IDcsIDc4NjQzMiBieXRl
cywgbGluZWFyKQpbICAgIDAuNTI5MDQ0XSBVRFAgaGFzaCB0YWJsZSBlbnRyaWVzOiAxNjM4
NCAob3JkZXI6IDcsIDUyNDI4OCBieXRlcywgbGluZWFyKQpbICAgIDAuNTI5MTE5XSBVRFAt
TGl0ZSBoYXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChvcmRlcjogNywgNTI0Mjg4IGJ5dGVz
LCBsaW5lYXIpClsgICAgMC41MjkxOTddIE5FVDogUmVnaXN0ZXJlZCBQRl9VTklYL1BGX0xP
Q0FMIHByb3RvY29sIGZhbWlseQpbICAgIDAuNTI5MjAzXSBORVQ6IFJlZ2lzdGVyZWQgUEZf
WERQIHByb3RvY29sIGZhbWlseQpbICAgIDAuNTI5MjA2XSBwY2kgMDAwMDowMTowMC4wOiBj
YW4ndCBjbGFpbSBCQVIgNiBbbWVtIDB4ZmZmODAwMDAtMHhmZmZmZmZmZiBwcmVmXTogbm8g
Y29tcGF0aWJsZSBicmlkZ2Ugd2luZG93ClsgICAgMC41MjkyMTJdIHBjaV9idXMgMDAwMDow
MDogbWF4IGJ1cyBkZXB0aDogMyBwY2lfdHJ5X251bTogNApbICAgIDAuNTI5MjI2XSBwY2kg
MDAwMDowMDowMi4wOiBCQVIgOTogYXNzaWduZWQgW21lbSAweDQwMjAwMDAwMDAtMHg0MGZm
ZmZmZmZmIDY0Yml0IHByZWZdClsgICAgMC41MjkyMjldIHBjaSAwMDAwOjAwOjAyLjA6IEJB
UiA3OiBhc3NpZ25lZCBbbWVtIDB4NDAxMDAwMDAwMC0weDQwMTZmZmZmZmYgNjRiaXRdClsg
ICAgMC41MjkyMzFdIHBjaSAwMDAwOjAwOjE1LjA6IEJBUiAwOiBhc3NpZ25lZCBbbWVtIDB4
NDAxNzAwMDAwMC0weDQwMTcwMDBmZmYgNjRiaXRdClsgICAgMC41MjkyODddIHBjaSAwMDAw
OjAwOjE1LjE6IEJBUiAwOiBhc3NpZ25lZCBbbWVtIDB4NDAxNzAwMTAwMC0weDQwMTcwMDFm
ZmYgNjRiaXRdClsgICAgMC41MjkzMDFdIHBjaSAwMDAwOjAwOjE1LjI6IEJBUiAwOiBhc3Np
Z25lZCBbbWVtIDB4NDAxNzAwMjAwMC0weDQwMTcwMDJmZmYgNjRiaXRdClsgICAgMC41Mjkz
MTRdIHBjaSAwMDAwOjAwOjE5LjA6IEJBUiAwOiBhc3NpZ25lZCBbbWVtIDB4NDAxNzAwMzAw
MC0weDQwMTcwMDNmZmYgNjRiaXRdClsgICAgMC41MjkzMjhdIHBjaSAwMDAwOjAwOjE5LjI6
IEJBUiAwOiBhc3NpZ25lZCBbbWVtIDB4NDAxNzAwNDAwMC0weDQwMTcwMDRmZmYgNjRiaXRd
ClsgICAgMC41MjkzODNdIHBjaSAwMDAwOjAwOjFkLjA6IEJBUiAxMzogYXNzaWduZWQgW2lv
ICAweDYwMDAtMHg4ZmZmXQpbICAgIDAuNTI5Mzg1XSBwY2kgMDAwMDowMDoxZS4wOiBCQVIg
MDogYXNzaWduZWQgW21lbSAweDQwMTcwMDUwMDAtMHg0MDE3MDA1ZmZmIDY0Yml0XQpbICAg
IDAuNTI5NDM5XSBwY2kgMDAwMDowMDoxZS4yOiBCQVIgMDogYXNzaWduZWQgW21lbSAweDQw
MTcwMDYwMDAtMHg0MDE3MDA2ZmZmIDY0Yml0XQpbICAgIDAuNTI5NDUzXSBwY2kgMDAwMDow
MDoxZi41OiBCQVIgMDogYXNzaWduZWQgW21lbSAweDU0ODAwMDAwLTB4NTQ4MDBmZmZdClsg
ICAgMC41Mjk0NjRdIHBjaSAwMDAwOjAxOjAwLjA6IEJBUiA2OiBhc3NpZ25lZCBbbWVtIDB4
ODgwODAwMDAtMHg4ODBmZmZmZiBwcmVmXQpbICAgIDAuNTI5NDY2XSBwY2kgMDAwMDowMDow
MS4wOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDFdClsgICAgMC41Mjk0NjddIHBjaSAwMDAwOjAw
OjAxLjA6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIDB4NDAwMC0weDRmZmZdClsgICAgMC41Mjk0
NzBdIHBjaSAwMDAwOjAwOjAxLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ODcwMDAwMDAt
MHg4ODBmZmZmZl0KWyAgICAwLjUyOTQ3MV0gcGNpIDAwMDA6MDA6MDEuMDogICBicmlkZ2Ug
d2luZG93IFttZW0gMHg2MDAwMDAwMDAwLTB4NjQwMWZmZmZmZiA2NGJpdCBwcmVmXQpbICAg
IDAuNTI5NDc1XSBwY2kgMDAwMDowMDowNi4wOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDJdClsg
ICAgMC41Mjk0ODBdIHBjaSAwMDAwOjAwOjA2LjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4
ODhjMDAwMDAtMHg4OGNmZmZmZl0KWyAgICAwLjUyOTQ4NV0gcGNpIDAwMDA6MDA6MWIuMDog
UENJIGJyaWRnZSB0byBbYnVzIDAzXQpbICAgIDAuNTI5NTU0XSBwY2kgMDAwMDowMDoxYi4w
OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDg4YjAwMDAwLTB4ODhiZmZmZmZdClsgICAgMC41
Mjk1NjFdIHBjaSAwMDAwOjAwOjFjLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwNF0KWyAgICAw
LjUyOTU2M10gcGNpIDAwMDA6MDA6MWMuMDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHgzMDAw
LTB4M2ZmZl0KWyAgICAwLjUyOTU2Nl0gcGNpIDAwMDA6MDA6MWMuMDogICBicmlkZ2Ugd2lu
ZG93IFttZW0gMHg4ODEwMDAwMC0weDg4YWZmZmZmXQpbICAgIDAuNTI5NTY5XSBwY2kgMDAw
MDowMDoxYy4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDY0NWMwMDAwMDAtMHg2NDVjOWZm
ZmZmIDY0Yml0IHByZWZdClsgICAgMC41Mjk1NzRdIHBjaSAwMDAwOjA1OjAwLjA6IEJBUiAx
MzogYXNzaWduZWQgW2lvICAweDYwMDAtMHg3ZmZmXQpbICAgIDAuNTI5NTc2XSBwY2kgMDAw
MDowNjowMS4wOiBCQVIgMTM6IGFzc2lnbmVkIFtpbyAgMHg2MDAwLTB4NmZmZl0KWyAgICAw
LjUyOTU3N10gcGNpIDAwMDA6MDY6MDMuMDogQkFSIDEzOiBhc3NpZ25lZCBbaW8gIDB4NzAw
MC0weDdmZmZdClsgICAgMC41Mjk1NzhdIHBjaSAwMDAwOjA2OjAwLjA6IFBDSSBicmlkZ2Ug
dG8gW2J1cyAwN10KWyAgICAwLjUyOTU4Nl0gcGNpIDAwMDA6MDY6MDAuMDogICBicmlkZ2Ug
d2luZG93IFttZW0gMHg2NDVhMDAwMDAwLTB4NjQ1YTBmZmZmZiA2NGJpdCBwcmVmXQpbICAg
IDAuNTI5NTkzXSBwY2kgMDAwMDowNjowMS4wOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDgtM2Fd
ClsgICAgMC41Mjk1OTVdIHBjaSAwMDAwOjA2OjAxLjA6ICAgYnJpZGdlIHdpbmRvdyBbaW8g
IDB4NjAwMC0weDZmZmZdClsgICAgMC41Mjk2MDBdIHBjaSAwMDAwOjA2OjAxLjA6ICAgYnJp
ZGdlIHdpbmRvdyBbbWVtIDB4NmYwMDAwMDAtMHg4NWVmZmZmZl0KWyAgICAwLjUyOTYwNF0g
cGNpIDAwMDA6MDY6MDEuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHg2NDM1MDAwMDAwLTB4
NjQ1OWZmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuNTI5NjEwXSBwY2kgMDAwMDowNjowMi4w
OiBQQ0kgYnJpZGdlIHRvIFtidXMgM2JdClsgICAgMC41Mjk2MTVdIHBjaSAwMDAwOjA2OjAy
LjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4NmVmMDAwMDAtMHg2ZWZmZmZmZl0KWyAgICAw
LjUyOTYyNV0gcGNpIDAwMDA6MDY6MDMuMDogUENJIGJyaWRnZSB0byBbYnVzIDNjLTZlXQpb
ICAgIDAuNTI5NjI3XSBwY2kgMDAwMDowNjowMy4wOiAgIGJyaWRnZSB3aW5kb3cgW2lvICAw
eDcwMDAtMHg3ZmZmXQpbICAgIDAuNTI5NjMyXSBwY2kgMDAwMDowNjowMy4wOiAgIGJyaWRn
ZSB3aW5kb3cgW21lbSAweDU4MDAwMDAwLTB4NmVlZmZmZmZdClsgICAgMC41Mjk2MzZdIHBj
aSAwMDAwOjA2OjAzLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4NjQxMDAwMDAwMC0weDY0
MzRmZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjUyOTY0Ml0gcGNpIDAwMDA6MDU6MDAuMDog
UENJIGJyaWRnZSB0byBbYnVzIDA2LTZlXQpbICAgIDAuNTI5NjQ1XSBwY2kgMDAwMDowNTow
MC4wOiAgIGJyaWRnZSB3aW5kb3cgW2lvICAweDYwMDAtMHg3ZmZmXQpbICAgIDAuNTI5NjUw
XSBwY2kgMDAwMDowNTowMC4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDU4MDAwMDAwLTB4
ODVlZmZmZmZdClsgICAgMC41Mjk2NTNdIHBjaSAwMDAwOjA1OjAwLjA6ICAgYnJpZGdlIHdp
bmRvdyBbbWVtIDB4NjQxMDAwMDAwMC0weDY0NWEwZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAw
LjUyOTY2MF0gcGNpIDAwMDA6MDA6MWQuMDogUENJIGJyaWRnZSB0byBbYnVzIDA1LTZlXQpb
ICAgIDAuNTI5NjYxXSBwY2kgMDAwMDowMDoxZC4wOiAgIGJyaWRnZSB3aW5kb3cgW2lvICAw
eDYwMDAtMHg4ZmZmXQpbICAgIDAuNTI5NjY1XSBwY2kgMDAwMDowMDoxZC4wOiAgIGJyaWRn
ZSB3aW5kb3cgW21lbSAweDU4MDAwMDAwLTB4ODYwZmZmZmZdClsgICAgMC41Mjk2NjhdIHBj
aSAwMDAwOjAwOjFkLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4NjQxMDAwMDAwMC0weDY0
NWEwZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjUyOTY3M10gcGNpX2J1cyAwMDAwOjAwOiBy
ZXNvdXJjZSA0IFtpbyAgMHgwMDAwLTB4MGNmNyB3aW5kb3ddClsgICAgMC41Mjk2NzRdIHBj
aV9idXMgMDAwMDowMDogcmVzb3VyY2UgNSBbaW8gIDB4MGQwMC0weGZmZmYgd2luZG93XQpb
ICAgIDAuNTI5Njc1XSBwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDYgW21lbSAweDAwMGEw
MDAwLTB4MDAwYmZmZmYgd2luZG93XQpbICAgIDAuNTI5Njc3XSBwY2lfYnVzIDAwMDA6MDA6
IHJlc291cmNlIDcgW21lbSAweDU0ODAwMDAwLTB4YmZmZmZmZmYgd2luZG93XQpbICAgIDAu
NTI5Njc4XSBwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDggW21lbSAweDQwMDAwMDAwMDAt
MHg3ZmZmZmZmZmZmIHdpbmRvd10KWyAgICAwLjUyOTY3OV0gcGNpX2J1cyAwMDAwOjAxOiBy
ZXNvdXJjZSAwIFtpbyAgMHg0MDAwLTB4NGZmZl0KWyAgICAwLjUyOTY4MF0gcGNpX2J1cyAw
MDAwOjAxOiByZXNvdXJjZSAxIFttZW0gMHg4NzAwMDAwMC0weDg4MGZmZmZmXQpbICAgIDAu
NTI5NjgxXSBwY2lfYnVzIDAwMDA6MDE6IHJlc291cmNlIDIgW21lbSAweDYwMDAwMDAwMDAt
MHg2NDAxZmZmZmZmIDY0Yml0IHByZWZdClsgICAgMC41Mjk2ODJdIHBjaV9idXMgMDAwMDow
MjogcmVzb3VyY2UgMSBbbWVtIDB4ODhjMDAwMDAtMHg4OGNmZmZmZl0KWyAgICAwLjUyOTY4
M10gcGNpX2J1cyAwMDAwOjAzOiByZXNvdXJjZSAxIFttZW0gMHg4OGIwMDAwMC0weDg4YmZm
ZmZmXQpbICAgIDAuNTI5Njg0XSBwY2lfYnVzIDAwMDA6MDQ6IHJlc291cmNlIDAgW2lvICAw
eDMwMDAtMHgzZmZmXQpbICAgIDAuNTI5Njg1XSBwY2lfYnVzIDAwMDA6MDQ6IHJlc291cmNl
IDEgW21lbSAweDg4MTAwMDAwLTB4ODhhZmZmZmZdClsgICAgMC41Mjk2ODZdIHBjaV9idXMg
MDAwMDowNDogcmVzb3VyY2UgMiBbbWVtIDB4NjQ1YzAwMDAwMC0weDY0NWM5ZmZmZmYgNjRi
aXQgcHJlZl0KWyAgICAwLjUyOTY4N10gcGNpX2J1cyAwMDAwOjA1OiByZXNvdXJjZSAwIFtp
byAgMHg2MDAwLTB4OGZmZl0KWyAgICAwLjUyOTY4OF0gcGNpX2J1cyAwMDAwOjA1OiByZXNv
dXJjZSAxIFttZW0gMHg1ODAwMDAwMC0weDg2MGZmZmZmXQpbICAgIDAuNTI5Njg4XSBwY2lf
YnVzIDAwMDA6MDU6IHJlc291cmNlIDIgW21lbSAweDY0MTAwMDAwMDAtMHg2NDVhMGZmZmZm
IDY0Yml0IHByZWZdClsgICAgMC41Mjk2OTBdIHBjaV9idXMgMDAwMDowNjogcmVzb3VyY2Ug
MCBbaW8gIDB4NjAwMC0weDdmZmZdClsgICAgMC41Mjk2OTBdIHBjaV9idXMgMDAwMDowNjog
cmVzb3VyY2UgMSBbbWVtIDB4NTgwMDAwMDAtMHg4NWVmZmZmZl0KWyAgICAwLjUyOTY5MV0g
cGNpX2J1cyAwMDAwOjA2OiByZXNvdXJjZSAyIFttZW0gMHg2NDEwMDAwMDAwLTB4NjQ1YTBm
ZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuNTI5NjkyXSBwY2lfYnVzIDAwMDA6MDc6IHJlc291
cmNlIDIgW21lbSAweDY0NWEwMDAwMDAtMHg2NDVhMGZmZmZmIDY0Yml0IHByZWZdClsgICAg
MC41Mjk2OTNdIHBjaV9idXMgMDAwMDowODogcmVzb3VyY2UgMCBbaW8gIDB4NjAwMC0weDZm
ZmZdClsgICAgMC41Mjk2OTRdIHBjaV9idXMgMDAwMDowODogcmVzb3VyY2UgMSBbbWVtIDB4
NmYwMDAwMDAtMHg4NWVmZmZmZl0KWyAgICAwLjUyOTY5NV0gcGNpX2J1cyAwMDAwOjA4OiBy
ZXNvdXJjZSAyIFttZW0gMHg2NDM1MDAwMDAwLTB4NjQ1OWZmZmZmZiA2NGJpdCBwcmVmXQpb
ICAgIDAuNTI5Njk2XSBwY2lfYnVzIDAwMDA6M2I6IHJlc291cmNlIDEgW21lbSAweDZlZjAw
MDAwLTB4NmVmZmZmZmZdClsgICAgMC41Mjk2OTddIHBjaV9idXMgMDAwMDozYzogcmVzb3Vy
Y2UgMCBbaW8gIDB4NzAwMC0weDdmZmZdClsgICAgMC41Mjk2OThdIHBjaV9idXMgMDAwMDoz
YzogcmVzb3VyY2UgMSBbbWVtIDB4NTgwMDAwMDAtMHg2ZWVmZmZmZl0KWyAgICAwLjUyOTY5
OV0gcGNpX2J1cyAwMDAwOjNjOiByZXNvdXJjZSAyIFttZW0gMHg2NDEwMDAwMDAwLTB4NjQz
NGZmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuNTI5ODM1XSBwY2kgMDAwMDowMDoxNC4wOiBl
bmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikKWyAgICAwLjUzMDM3Nl0gcGNpIDAwMDA6
MDE6MDAuMTogZXh0ZW5kaW5nIGRlbGF5IGFmdGVyIHBvd2VyLW9uIGZyb20gRDNob3QgdG8g
MjAgbXNlYwpbICAgIDAuNTMwNDEwXSBwY2kgMDAwMDowMTowMC4xOiBEMCBwb3dlciBzdGF0
ZSBkZXBlbmRzIG9uIDAwMDA6MDE6MDAuMApbICAgIDAuNTMxNjY3XSBwY2kgMDAwMDozYjow
MC4wOiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikKWyAgICAwLjUzMTcwM10gUENJ
OiBDTFMgMCBieXRlcywgZGVmYXVsdCA2NApbICAgIDAuNTMxNzExXSBETUFSOiBJbnRlbC1J
T01NVSBmb3JjZSBlbmFibGVkIGR1ZSB0byBwbGF0Zm9ybSBvcHQgaW4KWyAgICAwLjUzMTcy
MV0gRE1BUjogTm8gQVRTUiBmb3VuZApbICAgIDAuNTMxNzIyXSBETUFSOiBObyBTQVRDIGZv
dW5kClsgICAgMC41MzE3MjNdIERNQVI6IElPTU1VIGZlYXR1cmUgZmwxZ3Bfc3VwcG9ydCBp
bmNvbnNpc3RlbnQKWyAgICAwLjUzMTcyNF0gRE1BUjogSU9NTVUgZmVhdHVyZSBwZ3NlbF9p
bnYgaW5jb25zaXN0ZW50ClsgICAgMC41MzE3MjRdIERNQVI6IElPTU1VIGZlYXR1cmUgbndm
cyBpbmNvbnNpc3RlbnQKWyAgICAwLjUzMTcyNV0gRE1BUjogSU9NTVUgZmVhdHVyZSBkaXQg
aW5jb25zaXN0ZW50ClsgICAgMC41MzE3MjVdIERNQVI6IElPTU1VIGZlYXR1cmUgc2Nfc3Vw
cG9ydCBpbmNvbnNpc3RlbnQKWyAgICAwLjUzMTcyNl0gRE1BUjogSU9NTVUgZmVhdHVyZSBk
ZXZfaW90bGJfc3VwcG9ydCBpbmNvbnNpc3RlbnQKWyAgICAwLjUzMTcyNl0gRE1BUjogZG1h
cjA6IFVzaW5nIFF1ZXVlZCBpbnZhbGlkYXRpb24KWyAgICAwLjUzMTcyOV0gRE1BUjogZG1h
cjE6IFVzaW5nIFF1ZXVlZCBpbnZhbGlkYXRpb24KWyAgICAwLjUzMTc4OV0gVHJ5aW5nIHRv
IHVucGFjayByb290ZnMgaW1hZ2UgYXMgaW5pdHJhbWZzLi4uClsgICAgMC41MzI1MjZdIHBj
aSAwMDAwOjAwOjAyLjA6IEFkZGluZyB0byBpb21tdSBncm91cCAwClsgICAgMC41MzI1NjVd
IHBjaSAwMDAwOjAwOjAwLjA6IEFkZGluZyB0byBpb21tdSBncm91cCAxClsgICAgMC41MzI1
NzZdIHBjaSAwMDAwOjAwOjAxLjA6IEFkZGluZyB0byBpb21tdSBncm91cCAyClsgICAgMC41
MzI1ODVdIHBjaSAwMDAwOjAwOjA0LjA6IEFkZGluZyB0byBpb21tdSBncm91cCAzClsgICAg
MC41MzI2MDBdIHBjaSAwMDAwOjAwOjA2LjA6IEFkZGluZyB0byBpb21tdSBncm91cCA0Clsg
ICAgMC41MzI2MDhdIHBjaSAwMDAwOjAwOjA4LjA6IEFkZGluZyB0byBpb21tdSBncm91cCA1
ClsgICAgMC41MzI2MTddIHBjaSAwMDAwOjAwOjBhLjA6IEFkZGluZyB0byBpb21tdSBncm91
cCA2ClsgICAgMC41MzI2MzBdIHBjaSAwMDAwOjAwOjEyLjA6IEFkZGluZyB0byBpb21tdSBn
cm91cCA3ClsgICAgMC41MzI2NTBdIHBjaSAwMDAwOjAwOjE0LjA6IEFkZGluZyB0byBpb21t
dSBncm91cCA4ClsgICAgMC41MzI2NTldIHBjaSAwMDAwOjAwOjE0LjI6IEFkZGluZyB0byBp
b21tdSBncm91cCA4ClsgICAgMC41MzI2NjhdIHBjaSAwMDAwOjAwOjE0LjM6IEFkZGluZyB0
byBpb21tdSBncm91cCA5ClsgICAgMC41MzI2OTBdIHBjaSAwMDAwOjAwOjE1LjA6IEFkZGlu
ZyB0byBpb21tdSBncm91cCAxMApbICAgIDAuNTMyNzAwXSBwY2kgMDAwMDowMDoxNS4xOiBB
ZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMTAKWyAgICAwLjUzMjcwOF0gcGNpIDAwMDA6MDA6MTUu
MjogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDEwClsgICAgMC41MzI3MjddIHBjaSAwMDAwOjAw
OjE2LjA6IEFkZGluZyB0byBpb21tdSBncm91cCAxMQpbICAgIDAuNTMyNzM2XSBwY2kgMDAw
MDowMDoxNi4zOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMTEKWyAgICAwLjUzMjc1NF0gcGNp
IDAwMDA6MDA6MTkuMDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDEyClsgICAgMC41MzI3NjNd
IHBjaSAwMDAwOjAwOjE5LjI6IEFkZGluZyB0byBpb21tdSBncm91cCAxMgpbICAgIDAuNTMy
NzgwXSBwY2kgMDAwMDowMDoxYi4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMTMKWyAgICAw
LjUzMjgwMl0gcGNpIDAwMDA6MDA6MWMuMDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDE0Clsg
ICAgMC41MzI4MTJdIHBjaSAwMDAwOjAwOjFkLjA6IEFkZGluZyB0byBpb21tdSBncm91cCAx
NQpbICAgIDAuNTMyODMwXSBwY2kgMDAwMDowMDoxZS4wOiBBZGRpbmcgdG8gaW9tbXUgZ3Jv
dXAgMTYKWyAgICAwLjUzMjg0MF0gcGNpIDAwMDA6MDA6MWUuMjogQWRkaW5nIHRvIGlvbW11
IGdyb3VwIDE2ClsgICAgMC41MzI4NzJdIHBjaSAwMDAwOjAwOjFmLjA6IEFkZGluZyB0byBp
b21tdSBncm91cCAxNwpbICAgIDAuNTMyODgyXSBwY2kgMDAwMDowMDoxZi4zOiBBZGRpbmcg
dG8gaW9tbXUgZ3JvdXAgMTcKWyAgICAwLjUzMjg5Ml0gcGNpIDAwMDA6MDA6MWYuNDogQWRk
aW5nIHRvIGlvbW11IGdyb3VwIDE3ClsgICAgMC41MzI5MDJdIHBjaSAwMDAwOjAwOjFmLjU6
IEFkZGluZyB0byBpb21tdSBncm91cCAxNwpbICAgIDAuNTMyOTEyXSBwY2kgMDAwMDowMDox
Zi42OiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMTcKWyAgICAwLjUzMjkzMF0gcGNpIDAwMDA6
MDE6MDAuMDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDE4ClsgICAgMC41MzI5NDFdIHBjaSAw
MDAwOjAxOjAwLjE6IEFkZGluZyB0byBpb21tdSBncm91cCAxOApbICAgIDAuNTMyOTU1XSBw
Y2kgMDAwMDowMjowMC4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMTkKWyAgICAwLjUzMjk3
Ml0gcGNpIDAwMDA6MDM6MDAuMDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDIwClsgICAgMC41
MzI5ODJdIHBjaSAwMDAwOjA0OjAwLjA6IEFkZGluZyB0byBpb21tdSBncm91cCAyMQpbICAg
IDAuNTMyOTkyXSBwY2kgMDAwMDowNTowMC4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMjIK
WyAgICAwLjUzMzAxMV0gcGNpIDAwMDA6MDY6MDAuMDogQWRkaW5nIHRvIGlvbW11IGdyb3Vw
IDIzClsgICAgMC41MzMwMjJdIHBjaSAwMDAwOjA2OjAxLjA6IEFkZGluZyB0byBpb21tdSBn
cm91cCAyNApbICAgIDAuNTMzMDQwXSBwY2kgMDAwMDowNjowMi4wOiBBZGRpbmcgdG8gaW9t
bXUgZ3JvdXAgMjUKWyAgICAwLjUzMzA1MF0gcGNpIDAwMDA6MDY6MDMuMDogQWRkaW5nIHRv
IGlvbW11IGdyb3VwIDI2ClsgICAgMC41MzMwNzJdIHBjaSAwMDAwOjA3OjAwLjA6IEFkZGlu
ZyB0byBpb21tdSBncm91cCAyNwpbICAgIDAuNTMzMDg2XSBwY2kgMDAwMDozYjowMC4wOiBB
ZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMjgKWyAgICAwLjUzNDM2Ml0gRE1BUjogSW50ZWwoUikg
VmlydHVhbGl6YXRpb24gVGVjaG5vbG9neSBmb3IgRGlyZWN0ZWQgSS9PClsgICAgMC41MzQz
NjRdIFBDSS1ETUE6IFVzaW5nIHNvZnR3YXJlIGJvdW5jZSBidWZmZXJpbmcgZm9yIElPIChT
V0lPVExCKQpbICAgIDAuNTM0MzY1XSBzb2Z0d2FyZSBJTyBUTEI6IG1hcHBlZCBbbWVtIDB4
MDAwMDAwMDAxZjhkZTAwMC0weDAwMDAwMDAwMjM4ZGUwMDBdICg2NE1CKQpbICAgIDAuNTM4
NzY5XSBjbG9ja3NvdXJjZTogdHNjOiBtYXNrOiAweGZmZmZmZmZmZmZmZmZmZmYgbWF4X2N5
Y2xlczogMHgyMmRmMTE0OTk0OSwgbWF4X2lkbGVfbnM6IDQ0MDc5NTMxMjc4OSBucwpbICAg
IDAuNTM4ODczXSBjbG9ja3NvdXJjZTogU3dpdGNoZWQgdG8gY2xvY2tzb3VyY2UgdHNjClsg
ICAgMC41Mzg4OTNdIHBsYXRmb3JtIHJ0Y19jbW9zOiByZWdpc3RlcmVkIHBsYXRmb3JtIFJU
QyBkZXZpY2UgKG5vIFBOUCBkZXZpY2UgZm91bmQpClsgICAgMC41NDMxNTZdIEluaXRpYWxp
c2Ugc3lzdGVtIHRydXN0ZWQga2V5cmluZ3MKWyAgICAwLjU0MzE2M10gS2V5IHR5cGUgYmxh
Y2tsaXN0IHJlZ2lzdGVyZWQKWyAgICAwLjU0MzI0NV0gd29ya2luZ3NldDogdGltZXN0YW1w
X2JpdHM9MzYgbWF4X29yZGVyPTIzIGJ1Y2tldF9vcmRlcj0wClsgICAgMC41NDMyNTBdIHpi
dWQ6IGxvYWRlZApbICAgIDAuNTQzNDI2XSBzcXVhc2hmczogdmVyc2lvbiA0LjAgKDIwMDkv
MDEvMzEpIFBoaWxsaXAgTG91Z2hlcgpbICAgIDAuNTQzNDgzXSBmdXNlOiBpbml0IChBUEkg
dmVyc2lvbiA3LjM5KQpbICAgIDAuNTQzNTk2XSBpbnRlZ3JpdHk6IFBsYXRmb3JtIEtleXJp
bmcgaW5pdGlhbGl6ZWQKWyAgICAwLjU0MzU5OV0gaW50ZWdyaXR5OiBNYWNoaW5lIGtleXJp
bmcgaW5pdGlhbGl6ZWQKWyAgICAwLjU1MjM3M10gS2V5IHR5cGUgYXN5bW1ldHJpYyByZWdp
c3RlcmVkClsgICAgMC41NTIzNzVdIEFzeW1tZXRyaWMga2V5IHBhcnNlciAneDUwOScgcmVn
aXN0ZXJlZApbICAgIDAuNTUyMzg3XSBCbG9jayBsYXllciBTQ1NJIGdlbmVyaWMgKGJzZykg
ZHJpdmVyIHZlcnNpb24gMC40IGxvYWRlZCAobWFqb3IgMjQzKQpbICAgIDAuNTUyNDQ2XSBp
byBzY2hlZHVsZXIgbXEtZGVhZGxpbmUgcmVnaXN0ZXJlZApbICAgIDAuNTU0Njc1XSBzaHBj
aHA6IFN0YW5kYXJkIEhvdCBQbHVnIFBDSSBDb250cm9sbGVyIERyaXZlciB2ZXJzaW9uOiAw
LjQKWyAgICAwLjU1NDcyNF0gZWZpZmI6IHByb2JpbmcgZm9yIGVmaWZiClsgICAgMC41NTQ3
MzldIGVmaWZiOiBzaG93aW5nIGJvb3QgZ3JhcGhpY3MKWyAgICAwLjU1NjE5N10gZWZpZmI6
IGZyYW1lYnVmZmVyIGF0IDB4NDAwMDAwMDAwMCwgdXNpbmcgOTAwMGssIHRvdGFsIDkwMDBr
ClsgICAgMC41NTYxOTldIGVmaWZiOiBtb2RlIGlzIDE5MjB4MTIwMHgzMiwgbGluZWxlbmd0
aD03NjgwLCBwYWdlcz0xClsgICAgMC41NTYyMDBdIGVmaWZiOiBzY3JvbGxpbmc6IHJlZHJh
dwpbICAgIDAuNTU2MjAwXSBlZmlmYjogVHJ1ZWNvbG9yOiBzaXplPTg6ODo4OjgsIHNoaWZ0
PTI0OjE2Ojg6MApbICAgIDAuNTU2MjMyXSBmYmNvbjogRGVmZXJyaW5nIGNvbnNvbGUgdGFr
ZS1vdmVyClsgICAgMC41NTYyMzNdIGZiMDogRUZJIFZHQSBmcmFtZSBidWZmZXIgZGV2aWNl
ClsgICAgMC41NTc0NDNdIEFDUEk6IEFDOiBBQyBBZGFwdGVyIFtBQ10gKG9uLWxpbmUpClsg
ICAgMC41NTc0ODddIGlucHV0OiBTbGVlcCBCdXR0b24gYXMgL2RldmljZXMvTE5YU1lTVE06
MDAvTE5YU1lCVVM6MDAvUE5QMEMwRTowMC9pbnB1dC9pbnB1dDAKWyAgICAwLjU1NzUwMV0g
QUNQSTogYnV0dG9uOiBTbGVlcCBCdXR0b24gW1NMUEJdClsgICAgMC41NTc1MjFdIGlucHV0
OiBMaWQgU3dpdGNoIGFzIC9kZXZpY2VzL0xOWFNZU1RNOjAwL0xOWFNZQlVTOjAwL1BOUDBD
MEQ6MDAvaW5wdXQvaW5wdXQxClsgICAgMC41NTc1MzNdIEFDUEk6IGJ1dHRvbjogTGlkIFN3
aXRjaCBbTElEXQpbICAgIDAuNTU3NTU1XSBpbnB1dDogUG93ZXIgQnV0dG9uIGFzIC9kZXZp
Y2VzL0xOWFNZU1RNOjAwL0xOWFBXUkJOOjAwL2lucHV0L2lucHV0MgpbICAgIDAuNTU3NTky
XSBBQ1BJOiBidXR0b246IFBvd2VyIEJ1dHRvbiBbUFdSRl0KWyAgICAwLjU2OTUxNV0gdGhl
cm1hbCBMTlhUSEVSTTowMDogcmVnaXN0ZXJlZCBhcyB0aGVybWFsX3pvbmUwClsgICAgMC41
Njk1MTldIEFDUEk6IHRoZXJtYWw6IFRoZXJtYWwgWm9uZSBbQ1BVWl0gKDQ2IEMpClsgICAg
MC41NzY0NjFdIHRoZXJtYWwgTE5YVEhFUk06MDE6IHJlZ2lzdGVyZWQgYXMgdGhlcm1hbF96
b25lMQpbICAgIDAuNTc2NDY0XSBBQ1BJOiB0aGVybWFsOiBUaGVybWFsIFpvbmUgW0dGWFpd
ICgyNSBDKQpbICAgIDAuNTgwNjAwXSB0aGVybWFsIExOWFRIRVJNOjAyOiByZWdpc3RlcmVk
IGFzIHRoZXJtYWxfem9uZTIKWyAgICAwLjU4MDYwNF0gQUNQSTogdGhlcm1hbDogVGhlcm1h
bCBab25lIFtFWFRaXSAoNDIgQykKWyAgICAwLjU4NDgxNV0gdGhlcm1hbCBMTlhUSEVSTTow
MzogcmVnaXN0ZXJlZCBhcyB0aGVybWFsX3pvbmUzClsgICAgMC41ODQ4MTddIEFDUEk6IHRo
ZXJtYWw6IFRoZXJtYWwgWm9uZSBbTE9DWl0gKDM3IEMpClsgICAgMC41OTE5MjldIHRoZXJt
YWwgTE5YVEhFUk06MDQ6IHJlZ2lzdGVyZWQgYXMgdGhlcm1hbF96b25lNApbICAgIDAuNTkx
OTMyXSBBQ1BJOiB0aGVybWFsOiBUaGVybWFsIFpvbmUgW0JBVFpdICgyNCBDKQpbICAgIDAu
NTk2MzE2XSB0aGVybWFsIExOWFRIRVJNOjA1OiByZWdpc3RlcmVkIGFzIHRoZXJtYWxfem9u
ZTUKWyAgICAwLjU5NjMxOV0gQUNQSTogdGhlcm1hbDogVGhlcm1hbCBab25lIFtDSEdaXSAo
MzAgQykKWyAgICAwLjYwMDY4MV0gdGhlcm1hbCBMTlhUSEVSTTowNjogcmVnaXN0ZXJlZCBh
cyB0aGVybWFsX3pvbmU2ClsgICAgMC42MDA2ODRdIEFDUEk6IHRoZXJtYWw6IFRoZXJtYWwg
Wm9uZSBbU0sxWl0gKDMwIEMpClsgICAgMC42MDQ4NDFdIHRoZXJtYWwgTE5YVEhFUk06MDc6
IHJlZ2lzdGVyZWQgYXMgdGhlcm1hbF96b25lNwpbICAgIDAuNjA0ODQzXSBBQ1BJOiB0aGVy
bWFsOiBUaGVybWFsIFpvbmUgW1NLMlpdICgyOCBDKQpbICAgIDAuNjA5MDk5XSB0aGVybWFs
IExOWFRIRVJNOjA4OiByZWdpc3RlcmVkIGFzIHRoZXJtYWxfem9uZTgKWyAgICAwLjYwOTEw
MV0gQUNQSTogdGhlcm1hbDogVGhlcm1hbCBab25lIFtQQ0haXSAoMCBDKQpbICAgIDAuNjA5
MzU0XSBTZXJpYWw6IDgyNTAvMTY1NTAgZHJpdmVyLCAzMiBwb3J0cywgSVJRIHNoYXJpbmcg
ZW5hYmxlZApbICAgIDAuNjExMjYzXSBzZXJpYWwgMDAwMDowMDoxMi4wOiBlbmFibGluZyBk
ZXZpY2UgKDAwMDAgLT4gMDAwMikKWyAgICAwLjYxMTUzN10gc2VyaWFsIDAwMDA6MDA6MTYu
MzogZW5hYmxpbmcgZGV2aWNlICgwMDAwIC0+IDAwMDMpClsgICAgMC42MzIzNjJdIDAwMDA6
MDA6MTYuMzogdHR5UzQgYXQgSS9PIDB4NTA2MCAoaXJxID0gMTksIGJhc2VfYmF1ZCA9IDEx
NTIwMCkgaXMgYSAxNjU1MEEKWyAgICAwLjYzMjcwNl0gaHBldF9hY3BpX2FkZDogbm8gYWRk
cmVzcyBvciBpcnFzIGluIF9DUlMKWyAgICAwLjYzMjcyN10gTGludXggYWdwZ2FydCBpbnRl
cmZhY2UgdjAuMTAzClsgICAgMC42MzQ0NjldIHRwbV90aXMgSUZYMTUyMTowMDogMi4wIFRQ
TSAoZGV2aWNlLWlkIDB4MUQsIHJldi1pZCA1NCkKWyAgICAwLjY0MTA3N10gQUNQSTogYmF0
dGVyeTogU2xvdCBbQkFUMF0gKGJhdHRlcnkgcHJlc2VudCkKWyAgICAwLjc4NDY2N10gbG9v
cDogbW9kdWxlIGxvYWRlZApbICAgIDAuNzg0OTQ1XSB0dW46IFVuaXZlcnNhbCBUVU4vVEFQ
IGRldmljZSBkcml2ZXIsIDEuNgpbICAgIDAuNzg1MDAxXSBQUFAgZ2VuZXJpYyBkcml2ZXIg
dmVyc2lvbiAyLjQuMgpbICAgIDAuNzg1MTAyXSBpODA0MjogUE5QOiBQUy8yIENvbnRyb2xs
ZXIgW1BOUDAzMDM6UFMyS10gYXQgMHg2MCwweDY0IGlycSAxClsgICAgMC43ODUxMDRdIGk4
MDQyOiBQTlA6IFBTLzIgYXBwZWFycyB0byBoYXZlIEFVWCBwb3J0IGRpc2FibGVkLCBpZiB0
aGlzIGlzIGluY29ycmVjdCBwbGVhc2UgYm9vdCB3aXRoIGk4MDQyLm5vcG5wClsgICAgMC43
ODU2NjFdIHNlcmlvOiBpODA0MiBLQkQgcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEKWyAgICAw
Ljc4NTc0MF0gbW91c2VkZXY6IFBTLzIgbW91c2UgZGV2aWNlIGNvbW1vbiBmb3IgYWxsIG1p
Y2UKWyAgICAwLjc4NTgzMF0gcnRjX2Ntb3MgcnRjX2Ntb3M6IFJUQyBjYW4gd2FrZSBmcm9t
IFM0ClsgICAgMC43ODY3MjVdIHJ0Y19jbW9zIHJ0Y19jbW9zOiByZWdpc3RlcmVkIGFzIHJ0
YzAKWyAgICAwLjc4NjkxMF0gcnRjX2Ntb3MgcnRjX2Ntb3M6IHNldHRpbmcgc3lzdGVtIGNs
b2NrIHRvIDIwMjMtMTEtMjFUMTc6MzE6MzIgVVRDICgxNzAwNTg3ODkyKQpbICAgIDAuNzg2
OTM5XSBydGNfY21vcyBydGNfY21vczogYWxhcm1zIHVwIHRvIG9uZSBtb250aCwgeTNrLCAx
MTQgYnl0ZXMgbnZyYW0KWyAgICAwLjc4Njk0OF0gaTJjX2RldjogaTJjIC9kZXYgZW50cmll
cyBkcml2ZXIKWyAgICAwLjc4ODg0N10gZGV2aWNlLW1hcHBlcjogY29yZTogQ09ORklHX0lN
QV9ESVNBQkxFX0hUQUJMRSBpcyBkaXNhYmxlZC4gRHVwbGljYXRlIElNQSBtZWFzdXJlbWVu
dHMgd2lsbCBub3QgYmUgcmVjb3JkZWQgaW4gdGhlIElNQSBsb2cuClsgICAgMC43ODg4NThd
IGRldmljZS1tYXBwZXI6IHVldmVudDogdmVyc2lvbiAxLjAuMwpbICAgIDAuNzg4ODk0XSBk
ZXZpY2UtbWFwcGVyOiBpb2N0bDogNC40OC4wLWlvY3RsICgyMDIzLTAzLTAxKSBpbml0aWFs
aXNlZDogZG0tZGV2ZWxAcmVkaGF0LmNvbQpbICAgIDAuNzg4OTEyXSBwbGF0Zm9ybSBlaXNh
LjA6IFByb2JpbmcgRUlTQSBidXMgMApbICAgIDAuNzg4OTE0XSBwbGF0Zm9ybSBlaXNhLjA6
IEVJU0E6IENhbm5vdCBhbGxvY2F0ZSByZXNvdXJjZSBmb3IgbWFpbmJvYXJkClsgICAgMC43
ODg5MTVdIHBsYXRmb3JtIGVpc2EuMDogQ2Fubm90IGFsbG9jYXRlIHJlc291cmNlIGZvciBF
SVNBIHNsb3QgMQpbICAgIDAuNzg4OTE2XSBwbGF0Zm9ybSBlaXNhLjA6IENhbm5vdCBhbGxv
Y2F0ZSByZXNvdXJjZSBmb3IgRUlTQSBzbG90IDIKWyAgICAwLjc4ODkxN10gcGxhdGZvcm0g
ZWlzYS4wOiBDYW5ub3QgYWxsb2NhdGUgcmVzb3VyY2UgZm9yIEVJU0Egc2xvdCAzClsgICAg
MC43ODg5MTddIHBsYXRmb3JtIGVpc2EuMDogQ2Fubm90IGFsbG9jYXRlIHJlc291cmNlIGZv
ciBFSVNBIHNsb3QgNApbICAgIDAuNzg4OTE4XSBwbGF0Zm9ybSBlaXNhLjA6IENhbm5vdCBh
bGxvY2F0ZSByZXNvdXJjZSBmb3IgRUlTQSBzbG90IDUKWyAgICAwLjc4ODkxOV0gcGxhdGZv
cm0gZWlzYS4wOiBDYW5ub3QgYWxsb2NhdGUgcmVzb3VyY2UgZm9yIEVJU0Egc2xvdCA2Clsg
ICAgMC43ODg5MjBdIHBsYXRmb3JtIGVpc2EuMDogQ2Fubm90IGFsbG9jYXRlIHJlc291cmNl
IGZvciBFSVNBIHNsb3QgNwpbICAgIDAuNzg4OTIwXSBwbGF0Zm9ybSBlaXNhLjA6IENhbm5v
dCBhbGxvY2F0ZSByZXNvdXJjZSBmb3IgRUlTQSBzbG90IDgKWyAgICAwLjc4ODkyMV0gcGxh
dGZvcm0gZWlzYS4wOiBFSVNBOiBEZXRlY3RlZCAwIGNhcmRzClsgICAgMC43ODg5MjRdIGlu
dGVsX3BzdGF0ZTogSW50ZWwgUC1zdGF0ZSBkcml2ZXIgaW5pdGlhbGl6aW5nClsgICAgMC43
OTEyNzZdIGludGVsX3BzdGF0ZTogSFdQIGVuYWJsZWQKWyAgICAwLjc5NjYwNl0gRnJlZWlu
ZyBpbml0cmQgbWVtb3J5OiA2OTU4NEsKWyAgICAwLjc5Njk0NV0gbGVkdHJpZy1jcHU6IHJl
Z2lzdGVyZWQgdG8gaW5kaWNhdGUgYWN0aXZpdHkgb24gQ1BVcwpbICAgIDAuNzk3MTU5XSBk
cm9wX21vbml0b3I6IEluaXRpYWxpemluZyBuZXR3b3JrIGRyb3AgbW9uaXRvciBzZXJ2aWNl
ClsgICAgMC43OTcyNTFdIE5FVDogUmVnaXN0ZXJlZCBQRl9JTkVUNiBwcm90b2NvbCBmYW1p
bHkKWyAgICAwLjgwMjAwMV0gU2VnbWVudCBSb3V0aW5nIHdpdGggSVB2NgpbICAgIDAuODAy
MDA3XSBJbi1zaXR1IE9BTSAoSU9BTSkgd2l0aCBJUHY2ClsgICAgMC44MDIwMjddIE5FVDog
UmVnaXN0ZXJlZCBQRl9QQUNLRVQgcHJvdG9jb2wgZmFtaWx5ClsgICAgMC44MDIwOTddIEtl
eSB0eXBlIGRuc19yZXNvbHZlciByZWdpc3RlcmVkClsgICAgMC44MDU1ODddIG1pY3JvY29k
ZTogTWljcm9jb2RlIFVwZGF0ZSBEcml2ZXI6IHYyLjIuClsgICAgMC44MDU2MDVdIElQSSBz
aG9ydGhhbmQgYnJvYWRjYXN0OiBlbmFibGVkClsgICAgMC44MDY0MzRdIHNjaGVkX2Nsb2Nr
OiBNYXJraW5nIHN0YWJsZSAoODAwMDAwNzk1LCA2MzQzMTg3KS0+KDkwMjc1MjYzMCwgLTk2
NDA4NjQ4KQpbICAgIDAuODA2OTc2XSByZWdpc3RlcmVkIHRhc2tzdGF0cyB2ZXJzaW9uIDEK
WyAgICAwLjgxMDE1NV0gTG9hZGluZyBjb21waWxlZC1pbiBYLjUwOSBjZXJ0aWZpY2F0ZXMK
WyAgICAwLjgxMDU5Nl0gTG9hZGVkIFguNTA5IGNlcnQgJ0J1aWxkIHRpbWUgYXV0b2dlbmVy
YXRlZCBrZXJuZWwga2V5OiA2ZDdiZTNlZTgyYWQ5MmU4MjhhNDI1ZGE3ZGU0YTAzYjdlZTU4
NTMyJwpbICAgIDAuODExNTc2XSBLZXkgdHlwZSAuZnNjcnlwdCByZWdpc3RlcmVkClsgICAg
MC44MTE1NzddIEtleSB0eXBlIGZzY3J5cHQtcHJvdmlzaW9uaW5nIHJlZ2lzdGVyZWQKWyAg
ICAwLjgxMTYwM10gS2V5IHR5cGUgdHJ1c3RlZCByZWdpc3RlcmVkClsgICAgMC44MTI1NjFd
IGlucHV0OiBBVCBUcmFuc2xhdGVkIFNldCAyIGtleWJvYXJkIGFzIC9kZXZpY2VzL3BsYXRm
b3JtL2k4MDQyL3NlcmlvMC9pbnB1dC9pbnB1dDMKWyAgICAwLjgyNTkxMV0gS2V5IHR5cGUg
ZW5jcnlwdGVkIHJlZ2lzdGVyZWQKWyAgICAwLjgyNTkxN10gQXBwQXJtb3I6IEFwcEFybW9y
IHNoYTEgcG9saWN5IGhhc2hpbmcgZW5hYmxlZApbICAgIDAuODI1OTYyXSBpbnRlZ3JpdHk6
IExvYWRpbmcgWC41MDkgY2VydGlmaWNhdGU6IFVFRkk6ZGIKWyAgICAwLjgyNTk5OV0gaW50
ZWdyaXR5OiBMb2FkZWQgWC41MDkgY2VydCAnSFAgSW5jLjogSFAgVUVGSSBTZWN1cmUgQm9v
dCBEQiAyMDE3OiBkOWMwMWI1MGNmY2FlODlkM2IwNTM0NWMxNjNhYTc2ZTVkZDU4OWU3Jwpb
ICAgIDAuODI2MDAwXSBpbnRlZ3JpdHk6IExvYWRpbmcgWC41MDkgY2VydGlmaWNhdGU6IFVF
Rkk6ZGIKWyAgICAwLjgyNjAyOF0gaW50ZWdyaXR5OiBMb2FkZWQgWC41MDkgY2VydCAnTWlj
cm9zb2Z0IFdpbmRvd3MgUHJvZHVjdGlvbiBQQ0EgMjAxMTogYTkyOTAyMzk4ZTE2YzQ5Nzc4
Y2Q5MGY5OWU0ZjlhZTE3YzU1YWY1MycKWyAgICAwLjgyNjAyOV0gaW50ZWdyaXR5OiBMb2Fk
aW5nIFguNTA5IGNlcnRpZmljYXRlOiBVRUZJOmRiClsgICAgMC44MjYwNTNdIGludGVncml0
eTogTG9hZGVkIFguNTA5IGNlcnQgJ01pY3Jvc29mdCBDb3Jwb3JhdGlvbiBVRUZJIENBIDIw
MTE6IDEzYWRiZjQzMDliZDgyNzA5YzhjZDU0ZjMxNmVkNTIyOTg4YTFiZDQnClsgICAgMC44
MjczMjldIExvYWRpbmcgY29tcGlsZWQtaW4gbW9kdWxlIFguNTA5IGNlcnRpZmljYXRlcwpb
ICAgIDAuODI3OTcyXSBMb2FkZWQgWC41MDkgY2VydCAnQnVpbGQgdGltZSBhdXRvZ2VuZXJh
dGVkIGtlcm5lbCBrZXk6IDZkN2JlM2VlODJhZDkyZTgyOGE0MjVkYTdkZTRhMDNiN2VlNTg1
MzInClsgICAgMC44Mjc5NzRdIGltYTogQWxsb2NhdGVkIGhhc2ggYWxnb3JpdGhtOiBzaGEx
ClsgICAgMC44NTA4MjRdIGltYTogTm8gYXJjaGl0ZWN0dXJlIHBvbGljaWVzIGZvdW5kClsg
ICAgMC44NTA4NjBdIGV2bTogSW5pdGlhbGlzaW5nIEVWTSBleHRlbmRlZCBhdHRyaWJ1dGVz
OgpbICAgIDAuODUwODYxXSBldm06IHNlY3VyaXR5LnNlbGludXgKWyAgICAwLjg1MDg2NF0g
ZXZtOiBzZWN1cml0eS5TTUFDSzY0ClsgICAgMC44NTA4NjZdIGV2bTogc2VjdXJpdHkuU01B
Q0s2NEVYRUMKWyAgICAwLjg1MDg2N10gZXZtOiBzZWN1cml0eS5TTUFDSzY0VFJBTlNNVVRF
ClsgICAgMC44NTA4NjhdIGV2bTogc2VjdXJpdHkuU01BQ0s2NE1NQVAKWyAgICAwLjg1MDg2
OV0gZXZtOiBzZWN1cml0eS5hcHBhcm1vcgpbICAgIDAuODUwODcxXSBldm06IHNlY3VyaXR5
LmltYQpbICAgIDAuODUwODcyXSBldm06IHNlY3VyaXR5LmNhcGFiaWxpdHkKWyAgICAwLjg1
MDg3M10gZXZtOiBITUFDIGF0dHJzOiAweDEKWyAgICAwLjg1MTY4NF0gUE06ICAgTWFnaWMg
bnVtYmVyOiAxNTo4ODk6NTQyClsgICAgMC44NTE3NjRdIHBsYXRmb3JtIElOVEMxMDQ2OjAx
OiBoYXNoIG1hdGNoZXMKWyAgICAwLjg1MTgyMF0gYWNwaSBJTlRDMTA0NjowMTogaGFzaCBt
YXRjaGVzClsgICAgMC44NTIzMjldIFJBUzogQ29ycmVjdGFibGUgRXJyb3JzIGNvbGxlY3Rv
ciBpbml0aWFsaXplZC4KWyAgICAwLjg1MjQyMF0gY2xrOiBEaXNhYmxpbmcgdW51c2VkIGNs
b2NrcwpbICAgIDAuODYxMDUwXSBGcmVlaW5nIHVudXNlZCBkZWNyeXB0ZWQgbWVtb3J5OiAy
MDI4SwpbICAgIDAuODYxOTAwXSBGcmVlaW5nIHVudXNlZCBrZXJuZWwgaW1hZ2UgKGluaXRt
ZW0pIG1lbW9yeTogNDcxMksKWyAgICAwLjg5MTAwNF0gV3JpdGUgcHJvdGVjdGluZyB0aGUg
a2VybmVsIHJlYWQtb25seSBkYXRhOiAyODY3MmsKWyAgICAwLjg5MjE2N10gRnJlZWluZyB1
bnVzZWQga2VybmVsIGltYWdlIChyb2RhdGEvZGF0YSBnYXApIG1lbW9yeTogODE2SwpbICAg
IDAuOTA5NTg4XSB4ODYvbW06IENoZWNrZWQgVytYIG1hcHBpbmdzOiBwYXNzZWQsIG5vIFcr
WCBwYWdlcyBmb3VuZC4KWyAgICAwLjkwOTU5M10gUnVuIC9pbml0IGFzIGluaXQgcHJvY2Vz
cwpbICAgIDAuOTA5NTk0XSAgIHdpdGggYXJndW1lbnRzOgpbICAgIDAuOTA5NTk1XSAgICAg
L2luaXQKWyAgICAwLjkwOTU5Nl0gICAgIHNwbGFzaApbICAgIDAuOTA5NTk3XSAgIHdpdGgg
ZW52aXJvbm1lbnQ6ClsgICAgMC45MDk1OTddICAgICBIT01FPS8KWyAgICAwLjkwOTU5OF0g
ICAgIFRFUk09bGludXgKWyAgICAwLjkwOTU5OV0gICAgIEJPT1RfSU1BR0U9L2Jvb3Qvdm1s
aW51ei02LjcuMC1yYzEtbmV4dC0yMDIzMTExNSsKWyAgICAwLjk5NTU0Ml0gd21pX2J1cyB3
bWlfYnVzLVBOUDBDMTQ6MDI6IFdRWlogZGF0YSBibG9jayBxdWVyeSBjb250cm9sIG1ldGhv
ZCBub3QgZm91bmQKWyAgICAwLjk5Nzc0NF0gaGlkOiByYXcgSElEIGV2ZW50cyBkcml2ZXIg
KEMpIEppcmkgS29zaW5hClsgICAgMS4wMDI2NzFdIHhoY2lfaGNkIDAwMDA6MDA6MTQuMDog
eEhDSSBIb3N0IENvbnRyb2xsZXIKWyAgICAxLjAwMjY4M10geGhjaV9oY2QgMDAwMDowMDox
NC4wOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDEKWyAg
ICAxLjAwMzc4M10geGhjaV9oY2QgMDAwMDowMDoxNC4wOiBoY2MgcGFyYW1zIDB4MjAwMDdm
YzEgaGNpIHZlcnNpb24gMHgxMjAgcXVpcmtzIDB4MDAwMDAwMDIwMDAwOTgxMApbICAgIDEu
MDA0MTQ1XSB4aGNpX2hjZCAwMDAwOjAwOjE0LjA6IHhIQ0kgSG9zdCBDb250cm9sbGVyClsg
ICAgMS4wMDQxNDldIHhoY2lfaGNkIDAwMDA6MDA6MTQuMDogbmV3IFVTQiBidXMgcmVnaXN0
ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAyClsgICAgMS4wMDQxNTJdIHhoY2lfaGNkIDAw
MDA6MDA6MTQuMDogSG9zdCBzdXBwb3J0cyBVU0IgMy4yIEVuaGFuY2VkIFN1cGVyU3BlZWQK
WyAgICAxLjAwNDI3MV0gdXNiIHVzYjE6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRv
cj0xZDZiLCBpZFByb2R1Y3Q9MDAwMiwgYmNkRGV2aWNlPSA2LjA3ClsgICAgMS4wMDQyNzRd
IHVzYiB1c2IxOiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MywgUHJvZHVjdD0yLCBT
ZXJpYWxOdW1iZXI9MQpbICAgIDEuMDA0Mjc1XSB1c2IgdXNiMTogUHJvZHVjdDogeEhDSSBI
b3N0IENvbnRyb2xsZXIKWyAgICAxLjAwNDI3Nl0gdXNiIHVzYjE6IE1hbnVmYWN0dXJlcjog
TGludXggNi43LjAtcmMxLW5leHQtMjAyMzExMTUrIHhoY2ktaGNkClsgICAgMS4wMDQyNzdd
IHVzYiB1c2IxOiBTZXJpYWxOdW1iZXI6IDAwMDA6MDA6MTQuMApbICAgIDEuMDA0NTE2XSBo
dWIgMS0wOjEuMDogVVNCIGh1YiBmb3VuZApbICAgIDEuMDA0NTUwXSBodWIgMS0wOjEuMDog
MTYgcG9ydHMgZGV0ZWN0ZWQKWyAgICAxLjAwNDk0OF0gcnRzeF9wY2kgMDAwMDowNDowMC4w
OiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikKWyAgICAxLjAwNzAxNl0gdXNiIHVz
YjI6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0xZDZiLCBpZFByb2R1Y3Q9MDAw
MywgYmNkRGV2aWNlPSA2LjA3ClsgICAgMS4wMDcwMThdIHVzYiB1c2IyOiBOZXcgVVNCIGRl
dmljZSBzdHJpbmdzOiBNZnI9MywgUHJvZHVjdD0yLCBTZXJpYWxOdW1iZXI9MQpbICAgIDEu
MDA3MDE5XSB1c2IgdXNiMjogUHJvZHVjdDogeEhDSSBIb3N0IENvbnRyb2xsZXIKWyAgICAx
LjAwNzAyMF0gdXNiIHVzYjI6IE1hbnVmYWN0dXJlcjogTGludXggNi43LjAtcmMxLW5leHQt
MjAyMzExMTUrIHhoY2ktaGNkClsgICAgMS4wMDcwMjFdIHVzYiB1c2IyOiBTZXJpYWxOdW1i
ZXI6IDAwMDA6MDA6MTQuMApbICAgIDEuMDA3MTE3XSBodWIgMi0wOjEuMDogVVNCIGh1YiBm
b3VuZApbICAgIDEuMDA3MTM3XSBodWIgMi0wOjEuMDogMTAgcG9ydHMgZGV0ZWN0ZWQKWyAg
ICAxLjAwNzU4MF0gdXNiOiBwb3J0IHBvd2VyIG1hbmFnZW1lbnQgbWF5IGJlIHVucmVsaWFi
bGUKWyAgICAxLjAwODU5Nl0geGhjaV9oY2QgMDAwMDozYjowMC4wOiB4SENJIEhvc3QgQ29u
dHJvbGxlcgpbICAgIDEuMDA4NTk5XSB4aGNpX2hjZCAwMDAwOjNiOjAwLjA6IG5ldyBVU0Ig
YnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgMwpbICAgIDEuMDA5NzY4XSB4
aGNpX2hjZCAwMDAwOjNiOjAwLjA6IGhjYyBwYXJhbXMgMHgyMDAwN2ZjMSBoY2kgdmVyc2lv
biAweDExMCBxdWlya3MgMHgwMDAwMDAwMjAwMDA5ODEwClsgICAgMS4wMTAwNTBdIHhoY2lf
aGNkIDAwMDA6M2I6MDAuMDogeEhDSSBIb3N0IENvbnRyb2xsZXIKWyAgICAxLjAxMDA1Ml0g
eGhjaV9oY2QgMDAwMDozYjowMC4wOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25l
ZCBidXMgbnVtYmVyIDQKWyAgICAxLjAxMDA1M10geGhjaV9oY2QgMDAwMDozYjowMC4wOiBI
b3N0IHN1cHBvcnRzIFVTQiAzLjEgRW5oYW5jZWQgU3VwZXJTcGVlZApbICAgIDEuMDEwMDc0
XSB1c2IgdXNiMzogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTFkNmIsIGlkUHJv
ZHVjdD0wMDAyLCBiY2REZXZpY2U9IDYuMDcKWyAgICAxLjAxMDA3Nl0gdXNiIHVzYjM6IE5l
dyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0zLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0x
ClsgICAgMS4wMTAwNzddIHVzYiB1c2IzOiBQcm9kdWN0OiB4SENJIEhvc3QgQ29udHJvbGxl
cgpbICAgIDEuMDEwMDc4XSB1c2IgdXNiMzogTWFudWZhY3R1cmVyOiBMaW51eCA2LjcuMC1y
YzEtbmV4dC0yMDIzMTExNSsgeGhjaS1oY2QKWyAgICAxLjAxMDA3OF0gdXNiIHVzYjM6IFNl
cmlhbE51bWJlcjogMDAwMDozYjowMC4wClsgICAgMS4wMTAxODFdIGh1YiAzLTA6MS4wOiBV
U0IgaHViIGZvdW5kClsgICAgMS4wMTAyMDJdIGh1YiAzLTA6MS4wOiAyIHBvcnRzIGRldGVj
dGVkClsgICAgMS4wMTA2NjFdIHVzYiB1c2I0OiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRW
ZW5kb3I9MWQ2YiwgaWRQcm9kdWN0PTAwMDMsIGJjZERldmljZT0gNi4wNwpbICAgIDEuMDEw
NjY0XSB1c2IgdXNiNDogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTMsIFByb2R1Y3Q9
MiwgU2VyaWFsTnVtYmVyPTEKWyAgICAxLjAxMDY2NV0gdXNiIHVzYjQ6IFByb2R1Y3Q6IHhI
Q0kgSG9zdCBDb250cm9sbGVyClsgICAgMS4wMTA2NjZdIHVzYiB1c2I0OiBNYW51ZmFjdHVy
ZXI6IExpbnV4IDYuNy4wLXJjMS1uZXh0LTIwMjMxMTE1KyB4aGNpLWhjZApbICAgIDEuMDEw
NjY2XSB1c2IgdXNiNDogU2VyaWFsTnVtYmVyOiAwMDAwOjNiOjAwLjAKWyAgICAxLjAxMDc4
OF0gaHViIDQtMDoxLjA6IFVTQiBodWIgZm91bmQKWyAgICAxLjAxMDgxMV0gaHViIDQtMDox
LjA6IDIgcG9ydHMgZGV0ZWN0ZWQKWyAgICAxLjAxMjk0N10gQUNQSTogYnVzIHR5cGUgZHJt
X2Nvbm5lY3RvciByZWdpc3RlcmVkClsgICAgMS4wMTY4ODZdIEFDUEk6IGJ1cyB0eXBlIHRo
dW5kZXJib2x0IHJlZ2lzdGVyZWQKWyAgICAxLjAxNjk2N10gdGh1bmRlcmJvbHQgMDAwMDow
NzowMC4wOiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikKWyAgICAxLjAxOTA4N10g
ZTEwMDBlOiBJbnRlbChSKSBQUk8vMTAwMCBOZXR3b3JrIERyaXZlcgpbICAgIDEuMDE5MDg5
XSBlMTAwMGU6IENvcHlyaWdodChjKSAxOTk5IC0gMjAxNSBJbnRlbCBDb3Jwb3JhdGlvbi4K
WyAgICAxLjAxOTEyNF0gZTEwMDBlIDAwMDA6MDA6MWYuNjogZW5hYmxpbmcgZGV2aWNlICgw
MDAwIC0+IDAwMDIpClsgICAgMS4wMTkyOTVdIGk4MDFfc21idXMgMDAwMDowMDoxZi40OiBl
bmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMykKWyAgICAxLjAxOTMyN10gX19zcGlfYWRk
X2RldmljZSgpIFs2NjRdIENTWzBdID0gWzBdClsgICAgMS4wMTkzMjldIF9fc3BpX2FkZF9k
ZXZpY2UoKSBbNjY3XSBDU19ORVdbMV0gPSBbMF0KWyAgICAxLjAxOTMzMF0gaW50ZWwtc3Bp
IDAwMDA6MDA6MWYuNTogY2hpcHNlbGVjdCAwIGFscmVhZHkgaW4gdXNlClsgICAgMS4wMTkz
MzRdIGZiY29uOiBUYWtpbmcgb3ZlciBjb25zb2xlClsgICAgMS4wMTkzMzldIG52bWUgMDAw
MDowMjowMC4wOiBwbGF0Zm9ybSBxdWlyazogc2V0dGluZyBzaW1wbGUgc3VzcGVuZApbICAg
IDEuMDE5MzM5XSBlMTAwMGUgMDAwMDowMDoxZi42OiBJbnRlcnJ1cHQgVGhyb3R0bGluZyBS
YXRlIChpbnRzL3NlYykgc2V0IHRvIGR5bmFtaWMgY29uc2VydmF0aXZlIG1vZGUKWyAgICAx
LjAxOTM4M10gbnZtZSAwMDAwOjAzOjAwLjA6IHBsYXRmb3JtIHF1aXJrOiBzZXR0aW5nIHNp
bXBsZSBzdXNwZW5kClsgICAgMS4wMTk0NDFdIGk4MDFfc21idXMgMDAwMDowMDoxZi40OiBT
UEQgV3JpdGUgRGlzYWJsZSBpcyBzZXQKWyAgICAxLjAxOTQ3NF0gQ29uc29sZTogc3dpdGNo
aW5nIHRvIGNvbG91ciBmcmFtZSBidWZmZXIgZGV2aWNlIDI0MHg3NQpbICAgIDEuMDE5NDg0
XSBpODAxX3NtYnVzIDAwMDA6MDA6MWYuNDogU01CdXMgdXNpbmcgUENJIGludGVycnVwdApb
ICAgIDEuMDE5NTY4XSBudm1lIG52bWUwOiBwY2kgZnVuY3Rpb24gMDAwMDowMjowMC4wClsg
ICAgMS4wMTk2MjFdIG52bWUgbnZtZTE6IHBjaSBmdW5jdGlvbiAwMDAwOjAzOjAwLjAKWyAg
ICAxLjAyMDY4Ml0gaTJjIGkyYy0wOiAyLzQgbWVtb3J5IHNsb3RzIHBvcHVsYXRlZCAoZnJv
bSBETUkpClsgICAgMS4wMjA2ODVdIGkyYyBpMmMtMDogTWVtb3J5IHR5cGUgMHgyMiBub3Qg
c3VwcG9ydGVkIHlldCwgbm90IGluc3RhbnRpYXRpbmcgU1BEClsgICAgMS4wMjkxNzFdIGlu
dGVsLWxwc3MgMDAwMDowMDoxNS4wOiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikK
WyAgICAxLjAyOTQ2Ml0gaWRtYTY0IGlkbWE2NC4wOiBGb3VuZCBJbnRlbCBpbnRlZ3JhdGVk
IERNQSA2NC1iaXQKWyAgICAxLjAzMjY0OV0gbnZtZSBudm1lMDogU2h1dGRvd24gdGltZW91
dCBzZXQgdG8gMTAgc2Vjb25kcwpbICAgIDEuMDM3MjE0XSBudm1lIG52bWUwOiAyNC8wLzAg
ZGVmYXVsdC9yZWFkL3BvbGwgcXVldWVzClsgICAgMS4wNDAwMTFdICBudm1lMG4xOiBwMSBw
MiBwMwpbICAgIDEuMDQ1MzEwXSBpbnRlbC1scHNzIDAwMDA6MDA6MTUuMTogZW5hYmxpbmcg
ZGV2aWNlICgwMDAwIC0+IDAwMDIpClsgICAgMS4wNDU1NTJdIGlkbWE2NCBpZG1hNjQuMTog
Rm91bmQgSW50ZWwgaW50ZWdyYXRlZCBETUEgNjQtYml0ClsgICAgMS4wNTQwMjNdIG52bWUg
bnZtZTE6IDI0LzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1ZXMKWyAgICAxLjA1ODY4N10g
IG52bWUxbjE6IHAxIHAyIHAzClsgICAgMS4wNjE5NzNdIGludGVsLWxwc3MgMDAwMDowMDox
NS4yOiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikKWyAgICAxLjA2MjUxN10gaWRt
YTY0IGlkbWE2NC4yOiBGb3VuZCBJbnRlbCBpbnRlZ3JhdGVkIERNQSA2NC1iaXQKWyAgICAx
LjA4MjQyOV0gaW50ZWwtbHBzcyAwMDAwOjAwOjE5LjA6IGVuYWJsaW5nIGRldmljZSAoMDAw
MCAtPiAwMDAyKQpbICAgIDEuMDgzNDI0XSBpZG1hNjQgaWRtYTY0LjM6IEZvdW5kIEludGVs
IGludGVncmF0ZWQgRE1BIDY0LWJpdApbICAgIDEuMDk2OTM3XSBlMTAwMGUgMDAwMDowMDox
Zi42IDAwMDA6MDA6MWYuNiAodW5pbml0aWFsaXplZCk6IHJlZ2lzdGVyZWQgUEhDIGNsb2Nr
ClsgICAgMS4xMDUyMzZdIGludGVsLWxwc3MgMDAwMDowMDoxOS4yOiBlbmFibGluZyBkZXZp
Y2UgKDAwMDAgLT4gMDAwMikKWyAgICAxLjEwNTgwOV0gaWRtYTY0IGlkbWE2NC40OiBGb3Vu
ZCBJbnRlbCBpbnRlZ3JhdGVkIERNQSA2NC1iaXQKWyAgICAxLjExODQ0Nl0gaW50ZWwtbHBz
cyAwMDAwOjAwOjFlLjA6IGVuYWJsaW5nIGRldmljZSAoMDAwMCAtPiAwMDAyKQpbICAgIDEu
MTE5MjU3XSBpZG1hNjQgaWRtYTY0LjU6IEZvdW5kIEludGVsIGludGVncmF0ZWQgRE1BIDY0
LWJpdApbICAgIDEuMTMxMzc0XSBpbnRlbC1scHNzIDAwMDA6MDA6MWUuMjogZW5hYmxpbmcg
ZGV2aWNlICgwMDAwIC0+IDAwMDIpClsgICAgMS4xMzI0ODFdIGlkbWE2NCBpZG1hNjQuNjog
Rm91bmQgSW50ZWwgaW50ZWdyYXRlZCBETUEgNjQtYml0ClsgICAgMS4xNjk2NzNdIGUxMDAw
ZSAwMDAwOjAwOjFmLjYgZXRoMDogKFBDSSBFeHByZXNzOjIuNUdUL3M6V2lkdGggeDEpIDM4
OmNhOjg0OmQ1OmIyOjRmClsgICAgMS4xNjk2NzhdIGUxMDAwZSAwMDAwOjAwOjFmLjYgZXRo
MDogSW50ZWwoUikgUFJPLzEwMDAgTmV0d29yayBDb25uZWN0aW9uClsgICAgMS4xNjk3OTBd
IGUxMDAwZSAwMDAwOjAwOjFmLjYgZXRoMDogTUFDOiAxNSwgUEhZOiAxMiwgUEJBIE5vOiBG
RkZGRkYtMEZGClsgICAgMS4yNjY0NzFdIHVzYiAxLTg6IG5ldyBoaWdoLXNwZWVkIFVTQiBk
ZXZpY2UgbnVtYmVyIDIgdXNpbmcgeGhjaV9oY2QKWyAgICAxLjMyNDM4MF0gaTJjX2hpZF9h
Y3BpIGkyYy1FTEFOMjUxMzowMDogaTJjX2hpZF9nZXRfaW5wdXQ6IElSUSB0cmlnZ2VyZWQg
YnV0IHRoZXJlJ3Mgbm8gZGF0YQpbICAgIDEuMzI1Mzc0XSBpbnB1dDogU1lOQTMwRjc6MDAg
MDZDQjpDRUMzIE1vdXNlIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxNS4wL2ky
Y19kZXNpZ253YXJlLjAvaTJjLTEvaTJjLVNZTkEzMEY3OjAwLzAwMTg6MDZDQjpDRUMzLjAw
MDEvaW5wdXQvaW5wdXQ0ClsgICAgMS4zMjU1MDJdIGlucHV0OiBTWU5BMzBGNzowMCAwNkNC
OkNFQzMgVG91Y2hwYWQgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjE1LjAvaTJj
X2Rlc2lnbndhcmUuMC9pMmMtMS9pMmMtU1lOQTMwRjc6MDAvMDAxODowNkNCOkNFQzMuMDAw
MS9pbnB1dC9pbnB1dDUKWyAgICAxLjMyNTU2MF0gaGlkLWdlbmVyaWMgMDAxODowNkNCOkNF
QzMuMDAwMTogaW5wdXQsaGlkcmF3MDogSTJDIEhJRCB2MS4wMCBNb3VzZSBbU1lOQTMwRjc6
MDAgMDZDQjpDRUMzXSBvbiBpMmMtU1lOQTMwRjc6MDAKWyAgICAxLjMyNTczM10gaW5wdXQ6
IEVMQU4yNTEzOjAwIDA0RjM6MkZFMCBUb3VjaHNjcmVlbiBhcyAvZGV2aWNlcy9wY2kwMDAw
OjAwLzAwMDA6MDA6MTUuMS9pMmNfZGVzaWdud2FyZS4xL2kyYy0yL2kyYy1FTEFOMjUxMzow
MC8wMDE4OjA0RjM6MkZFMC4wMDAyL2lucHV0L2lucHV0NwpbICAgIDEuMzI1NzYyXSBpbnB1
dDogRUxBTjI1MTM6MDAgMDRGMzoyRkUwIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDow
MDoxNS4xL2kyY19kZXNpZ253YXJlLjEvaTJjLTIvaTJjLUVMQU4yNTEzOjAwLzAwMTg6MDRG
MzoyRkUwLjAwMDIvaW5wdXQvaW5wdXQ4ClsgICAgMS4zMjU3ODZdIGlucHV0OiBFTEFOMjUx
MzowMCAwNEYzOjJGRTAgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjE1LjEvaTJj
X2Rlc2lnbndhcmUuMS9pMmMtMi9pMmMtRUxBTjI1MTM6MDAvMDAxODowNEYzOjJGRTAuMDAw
Mi9pbnB1dC9pbnB1dDkKWyAgICAxLjMyNTgzMl0gaGlkLWdlbmVyaWMgMDAxODowNEYzOjJG
RTAuMDAwMjogaW5wdXQsaGlkcmF3MTogSTJDIEhJRCB2MS4wMCBEZXZpY2UgW0VMQU4yNTEz
OjAwIDA0RjM6MkZFMF0gb24gaTJjLUVMQU4yNTEzOjAwClsgICAgMS4zNDI1MTZdIGUxMDAw
ZSAwMDAwOjAwOjFmLjYgZW5wMHMzMWY2OiByZW5hbWVkIGZyb20gZXRoMApbICAgIDEuNDkz
Njg3XSB1c2IgMS04OiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MDQwOCwgaWRQ
cm9kdWN0PTU0NWIsIGJjZERldmljZT0gMC4wNgpbICAgIDEuNDkzNzAzXSB1c2IgMS04OiBO
ZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MSwgUHJvZHVjdD0yLCBTZXJpYWxOdW1iZXI9
MwpbICAgIDEuNDkzNzA5XSB1c2IgMS04OiBQcm9kdWN0OiBIUCA1TVAgQ2FtZXJhClsgICAg
MS40OTM3MTNdIHVzYiAxLTg6IE1hbnVmYWN0dXJlcjogUXVhbnRhClsgICAgMS40OTM3MTdd
IHVzYiAxLTg6IFNlcmlhbE51bWJlcjogMDEuMDAuMDAKWyAgICAxLjYzODUzNV0gdXNiIDEt
MTQ6IG5ldyBmdWxsLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDMgdXNpbmcgeGhjaV9oY2QK
WyAgICAxLjY5NTM2MF0gaXNoLWhpZCB7MzNBRUNENTgtQjY3OS00RTU0LTlCRDktQTA0RDM0
RjBDMjI2fTogW2hpZC1pc2hdOiBlbnVtX2RldmljZXNfZG9uZSBPSywgbnVtX2hpZF9kZXZp
Y2VzPTIKWyAgICAxLjcwODM4MV0gaGlkLWdlbmVyaWMgMDAxRjo4MDg3OjBBQzIuMDAwMzog
aGlkcmF3MjogU0VOU09SIEhVQiBISUQgdjIuMDAgRGV2aWNlIFtoaWQtaXNodHAgODA4Nzow
QUMyXSBvbiAKWyAgICAxLjcxNjEyMl0gaGlkLWdlbmVyaWMgMDAxRjo4MDg3OjBBQzMuMDAw
NDogaGlkcmF3MzogU0VOU09SIEhVQiBISUQgdjIuMDAgRGV2aWNlIFtoaWQtaXNodHAgODA4
NzowQUMzXSBvbiAKWyAgICAxLjcyMDUwNl0gaGlkLXNlbnNvci1odWIgMDAxRjo4MDg3OjBB
QzIuMDAwMzogaGlkcmF3MjogU0VOU09SIEhVQiBISUQgdjIuMDAgRGV2aWNlIFtoaWQtaXNo
dHAgODA4NzowQUMyXSBvbiAKWyAgICAxLjcyMjE3NV0gaGlkLXNlbnNvci1odWIgMDAxRjo4
MDg3OjBBQzMuMDAwNDogaGlkcmF3MzogU0VOU09SIEhVQiBISUQgdjIuMDAgRGV2aWNlIFto
aWQtaXNodHAgODA4NzowQUMzXSBvbiAKWyAgICAxLjc4OTA5NF0gdXNiIDEtMTQ6IE5ldyBV
U0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj04MDg3LCBpZFByb2R1Y3Q9MDAzMywgYmNkRGV2
aWNlPSAwLjAwClsgICAgMS43ODkxMTBdIHVzYiAxLTE0OiBOZXcgVVNCIGRldmljZSBzdHJp
bmdzOiBNZnI9MCwgUHJvZHVjdD0wLCBTZXJpYWxOdW1iZXI9MApbICAgIDEuODkwMzQ0XSBy
YWlkNjogYXZ4Mng0ICAgZ2VuKCkgMzUyMTQgTUIvcwpbICAgIDEuOTU4MzQ0XSByYWlkNjog
YXZ4MngyICAgZ2VuKCkgMzgzNzMgTUIvcwpbICAgIDIuMDI2MzQ0XSByYWlkNjogYXZ4Mngx
ICAgZ2VuKCkgMzU2NTQgTUIvcwpbICAgIDIuMDI2MzQ0XSByYWlkNjogdXNpbmcgYWxnb3Jp
dGhtIGF2eDJ4MiBnZW4oKSAzODM3MyBNQi9zClsgICAgMi4wOTQzNDRdIHJhaWQ2OiAuLi4u
IHhvcigpIDI0OTE0IE1CL3MsIHJtdyBlbmFibGVkClsgICAgMi4wOTQzNDVdIHJhaWQ2OiB1
c2luZyBhdngyeDIgcmVjb3ZlcnkgYWxnb3JpdGhtClsgICAgMi4wOTU4NjZdIHhvcjogYXV0
b21hdGljYWxseSB1c2luZyBiZXN0IGNoZWNrc3VtbWluZyBmdW5jdGlvbiAgIGF2eCAgICAg
ICAKWyAgICAyLjA5Njc3N10gYXN5bmNfdHg6IGFwaSBpbml0aWFsaXplZCAoYXN5bmMpClsg
ICAgMi4xNjE3MzZdIEJ0cmZzIGxvYWRlZCwgem9uZWQ9eWVzLCBmc3Zlcml0eT15ZXMKWyAg
ICAyLjI0ODY2NF0gRVhUNC1mcyAobnZtZTBuMXAzKTogbW91bnRlZCBmaWxlc3lzdGVtIDA2
MTUwMmE5LTIwNWUtNGI3My04MjUxLTEyMjBlNzcwYzVkOCBybyB3aXRoIG9yZGVyZWQgZGF0
YSBtb2RlLiBRdW90YSBtb2RlOiBub25lLgpbICAgIDIuMzI2OTMyXSBzeXN0ZW1kWzFdOiBJ
bnNlcnRlZCBtb2R1bGUgJ2F1dG9mczQnClsgICAgMi4zNDA3MDFdIHN5c3RlbWRbMV06IHN5
c3RlbWQgMjQ5LjExLTB1YnVudHUzLjkgcnVubmluZyBpbiBzeXN0ZW0gbW9kZSAoK1BBTSAr
QVVESVQgK1NFTElOVVggK0FQUEFSTU9SICtJTUEgK1NNQUNLICtTRUNDT01QICtHQ1JZUFQg
K0dOVVRMUyArT1BFTlNTTCArQUNMICtCTEtJRCArQ1VSTCArRUxGVVRJTFMgK0ZJRE8yICtJ
RE4yIC1JRE4gK0lQVEMgK0tNT0QgK0xJQkNSWVBUU0VUVVAgK0xJQkZESVNLICtQQ1JFMiAt
UFdRVUFMSVRZIC1QMTFLSVQgLVFSRU5DT0RFICtCWklQMiArTFo0ICtYWiArWkxJQiArWlNU
RCAtWEtCQ09NTU9OICtVVE1QICtTWVNWSU5JVCBkZWZhdWx0LWhpZXJhcmNoeT11bmlmaWVk
KQpbICAgIDIuMzQwNzc5XSBzeXN0ZW1kWzFdOiBEZXRlY3RlZCBhcmNoaXRlY3R1cmUgeDg2
LTY0LgpbICAgIDIuMzQwOTgxXSBzeXN0ZW1kWzFdOiBIb3N0bmFtZSBzZXQgdG8gPHUtSFAt
WkJvb2stRnVyeS0xNi1HOS1Nb2JpbGUtV29ya3N0YXRpb24tUEM+LgpbICAgIDIuMzk4NzQz
XSBibG9jayBudm1lMG4xOiB0aGUgY2FwYWJpbGl0eSBhdHRyaWJ1dGUgaGFzIGJlZW4gZGVw
cmVjYXRlZC4KWyAgICAyLjQ3NzQ1Nl0gc3lzdGVtZFsxXTogUXVldWVkIHN0YXJ0IGpvYiBm
b3IgZGVmYXVsdCB0YXJnZXQgR3JhcGhpY2FsIEludGVyZmFjZS4KWyAgICAyLjUwODA5Nl0g
c3lzdGVtZFsxXTogQ3JlYXRlZCBzbGljZSBTbGljZSAvc3lzdGVtL21vZHByb2JlLgpbICAg
IDIuNTA4ODUyXSBzeXN0ZW1kWzFdOiBDcmVhdGVkIHNsaWNlIFNsaWNlIC9zeXN0ZW0vc3lz
dGVtZC1mc2NrLgpbICAgIDIuNTA5MTc3XSBzeXN0ZW1kWzFdOiBDcmVhdGVkIHNsaWNlIFVz
ZXIgYW5kIFNlc3Npb24gU2xpY2UuClsgICAgMi41MDkzMDNdIHN5c3RlbWRbMV06IFN0YXJ0
ZWQgRm9yd2FyZCBQYXNzd29yZCBSZXF1ZXN0cyB0byBXYWxsIERpcmVjdG9yeSBXYXRjaC4K
WyAgICAyLjUwOTYzOF0gc3lzdGVtZFsxXTogU2V0IHVwIGF1dG9tb3VudCBBcmJpdHJhcnkg
RXhlY3V0YWJsZSBGaWxlIEZvcm1hdHMgRmlsZSBTeXN0ZW0gQXV0b21vdW50IFBvaW50Lgpb
ICAgIDIuNTA5NzUyXSBzeXN0ZW1kWzFdOiBSZWFjaGVkIHRhcmdldCBVc2VyIGFuZCBHcm91
cCBOYW1lIExvb2t1cHMuClsgICAgMi41MDk3ODFdIHN5c3RlbWRbMV06IFJlYWNoZWQgdGFy
Z2V0IFJlbW90ZSBGaWxlIFN5c3RlbXMuClsgICAgMi41MDk4MDBdIHN5c3RlbWRbMV06IFJl
YWNoZWQgdGFyZ2V0IFNsaWNlIFVuaXRzLgpbICAgIDIuNTA5ODMxXSBzeXN0ZW1kWzFdOiBS
ZWFjaGVkIHRhcmdldCBNb3VudGluZyBzbmFwcy4KWyAgICAyLjUwOTg4MV0gc3lzdGVtZFsx
XTogUmVhY2hlZCB0YXJnZXQgTG9jYWwgVmVyaXR5IFByb3RlY3RlZCBWb2x1bWVzLgpbICAg
IDIuNTEwMDE4XSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gRGV2aWNlLW1hcHBlciBldmVu
dCBkYWVtb24gRklGT3MuClsgICAgMi41MTAyMDFdIHN5c3RlbWRbMV06IExpc3RlbmluZyBv
biBMVk0yIHBvbGwgZGFlbW9uIHNvY2tldC4KWyAgICAyLjUxMDMyMV0gc3lzdGVtZFsxXTog
TGlzdGVuaW5nIG9uIFN5c2xvZyBTb2NrZXQuClsgICAgMi41MTA0NDVdIHN5c3RlbWRbMV06
IExpc3RlbmluZyBvbiBmc2NrIHRvIGZzY2tkIGNvbW11bmljYXRpb24gU29ja2V0LgpbICAg
IDIuNTEwNTA0XSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gaW5pdGN0bCBDb21wYXRpYmls
aXR5IE5hbWVkIFBpcGUuClsgICAgMi41MTA3NTRdIHN5c3RlbWRbMV06IExpc3RlbmluZyBv
biBKb3VybmFsIEF1ZGl0IFNvY2tldC4KWyAgICAyLjUxMDg1MV0gc3lzdGVtZFsxXTogTGlz
dGVuaW5nIG9uIEpvdXJuYWwgU29ja2V0ICgvZGV2L2xvZykuClsgICAgMi41MTA5ODNdIHN5
c3RlbWRbMV06IExpc3RlbmluZyBvbiBKb3VybmFsIFNvY2tldC4KWyAgICAyLjUxMTI1M10g
c3lzdGVtZFsxXTogTGlzdGVuaW5nIG9uIHVkZXYgQ29udHJvbCBTb2NrZXQuClsgICAgMi41
MTEzNDddIHN5c3RlbWRbMV06IExpc3RlbmluZyBvbiB1ZGV2IEtlcm5lbCBTb2NrZXQuClsg
ICAgMi41MTI0MjldIHN5c3RlbWRbMV06IE1vdW50aW5nIEh1Z2UgUGFnZXMgRmlsZSBTeXN0
ZW0uLi4KWyAgICAyLjUxMzQ5Ml0gc3lzdGVtZFsxXTogTW91bnRpbmcgUE9TSVggTWVzc2Fn
ZSBRdWV1ZSBGaWxlIFN5c3RlbS4uLgpbICAgIDIuNTE0NjczXSBzeXN0ZW1kWzFdOiBNb3Vu
dGluZyBLZXJuZWwgRGVidWcgRmlsZSBTeXN0ZW0uLi4KWyAgICAyLjUxNTU5Nl0gc3lzdGVt
ZFsxXTogTW91bnRpbmcgS2VybmVsIFRyYWNlIEZpbGUgU3lzdGVtLi4uClsgICAgMi41MTc3
MzBdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIEpvdXJuYWwgU2VydmljZS4uLgpbICAgIDIuNTE3
OTA1XSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBBdmFpbGFiaWxpdHkgb2YgYmxvY2sgZGV2aWNl
cy4KWyAgICAyLjUxODg4N10gc3lzdGVtZFsxXTogU3RhcnRpbmcgU2V0IHRoZSBjb25zb2xl
IGtleWJvYXJkIGxheW91dC4uLgpbICAgIDIuNTE5NzQ5XSBzeXN0ZW1kWzFdOiBTdGFydGlu
ZyBDcmVhdGUgTGlzdCBvZiBTdGF0aWMgRGV2aWNlIE5vZGVzLi4uClsgICAgMi41MjA0MTRd
IHN5c3RlbWRbMV06IFN0YXJ0aW5nIE1vbml0b3Jpbmcgb2YgTFZNMiBtaXJyb3JzLCBzbmFw
c2hvdHMgZXRjLiB1c2luZyBkbWV2ZW50ZCBvciBwcm9ncmVzcyBwb2xsaW5nLi4uClsgICAg
Mi41MjEwNTRdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIExvYWQgS2VybmVsIE1vZHVsZSBjaHJv
bWVvc19wc3RvcmUuLi4KWyAgICAyLjUyMTY2MV0gc3lzdGVtZFsxXTogU3RhcnRpbmcgTG9h
ZCBLZXJuZWwgTW9kdWxlIGNvbmZpZ2ZzLi4uClsgICAgMi41MjIyMzVdIHN5c3RlbWRbMV06
IFN0YXJ0aW5nIExvYWQgS2VybmVsIE1vZHVsZSBkcm0uLi4KWyAgICAyLjUyMjgzNV0gc3lz
dGVtZFsxXTogU3RhcnRpbmcgTG9hZCBLZXJuZWwgTW9kdWxlIGVmaV9wc3RvcmUuLi4KWyAg
ICAyLjUyMzM2Nl0gc3lzdGVtZFsxXTogU3RhcnRpbmcgTG9hZCBLZXJuZWwgTW9kdWxlIGZ1
c2UuLi4KWyAgICAyLjUyNDEzM10gc3lzdGVtZFsxXTogU3RhcnRpbmcgTG9hZCBLZXJuZWwg
TW9kdWxlIHBzdG9yZV9ibGsuLi4KWyAgICAyLjUyNTIyOF0gc3lzdGVtZFsxXTogU3RhcnRp
bmcgTG9hZCBLZXJuZWwgTW9kdWxlIHBzdG9yZV96b25lLi4uClsgICAgMi41MjU2MDNdIHN5
c3RlbWRbMV06IFN0YXJ0aW5nIExvYWQgS2VybmVsIE1vZHVsZSByYW1vb3BzLi4uClsgICAg
Mi41MjY0ODFdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIExvYWQgS2VybmVsIE1vZHVsZXMuLi4K
WyAgICAyLjUyNjcxN10gcHN0b3JlOiBVc2luZyBjcmFzaCBkdW1wIGNvbXByZXNzaW9uOiBk
ZWZsYXRlClsgICAgMi41MjY5NzVdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIFJlbW91bnQgUm9v
dCBhbmQgS2VybmVsIEZpbGUgU3lzdGVtcy4uLgpbICAgIDIuNTI3Mzc2XSBzeXN0ZW1kWzFd
OiBTdGFydGluZyBDb2xkcGx1ZyBBbGwgdWRldiBEZXZpY2VzLi4uClsgICAgMi41MjgwNzRd
IHN5c3RlbWRbMV06IE1vdW50ZWQgSHVnZSBQYWdlcyBGaWxlIFN5c3RlbS4KWyAgICAyLjUy
ODExMl0gc3lzdGVtZFsxXTogTW91bnRlZCBQT1NJWCBNZXNzYWdlIFF1ZXVlIEZpbGUgU3lz
dGVtLgpbICAgIDIuNTI4MTM2XSBzeXN0ZW1kWzFdOiBNb3VudGVkIEtlcm5lbCBEZWJ1ZyBG
aWxlIFN5c3RlbS4KWyAgICAyLjUyODE1N10gc3lzdGVtZFsxXTogTW91bnRlZCBLZXJuZWwg
VHJhY2UgRmlsZSBTeXN0ZW0uClsgICAgMi41MjgyODNdIHN5c3RlbWRbMV06IEZpbmlzaGVk
IENyZWF0ZSBMaXN0IG9mIFN0YXRpYyBEZXZpY2UgTm9kZXMuClsgICAgMi41MjgzNzNdIHN5
c3RlbWRbMV06IG1vZHByb2JlQGNvbmZpZ2ZzLnNlcnZpY2U6IERlYWN0aXZhdGVkIHN1Y2Nl
c3NmdWxseS4KWyAgICAyLjUyODQ2OV0gc3lzdGVtZFsxXTogRmluaXNoZWQgTG9hZCBLZXJu
ZWwgTW9kdWxlIGNvbmZpZ2ZzLgpbICAgIDIuNTI4NTc0XSBzeXN0ZW1kWzFdOiBtb2Rwcm9i
ZUBkcm0uc2VydmljZTogRGVhY3RpdmF0ZWQgc3VjY2Vzc2Z1bGx5LgpbICAgIDIuNTI4Njky
XSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBMb2FkIEtlcm5lbCBNb2R1bGUgZHJtLgpbICAgIDIu
NTI4Nzg2XSBzeXN0ZW1kWzFdOiBtb2Rwcm9iZUBmdXNlLnNlcnZpY2U6IERlYWN0aXZhdGVk
IHN1Y2Nlc3NmdWxseS4KWyAgICAyLjUyODg3OV0gc3lzdGVtZFsxXTogRmluaXNoZWQgTG9h
ZCBLZXJuZWwgTW9kdWxlIGZ1c2UuClsgICAgMi41Mjg5NTVdIHN5c3RlbWRbMV06IG1vZHBy
b2JlQHBzdG9yZV9ibGsuc2VydmljZTogRGVhY3RpdmF0ZWQgc3VjY2Vzc2Z1bGx5LgpbICAg
IDIuNTI5MDE1XSBwc3RvcmU6IFJlZ2lzdGVyZWQgZWZpX3BzdG9yZSBhcyBwZXJzaXN0ZW50
IHN0b3JlIGJhY2tlbmQKWyAgICAyLjUyOTA1MF0gc3lzdGVtZFsxXTogRmluaXNoZWQgTG9h
ZCBLZXJuZWwgTW9kdWxlIHBzdG9yZV9ibGsuClsgICAgMi41MjkxMjRdIHN5c3RlbWRbMV06
IG1vZHByb2JlQHBzdG9yZV96b25lLnNlcnZpY2U6IERlYWN0aXZhdGVkIHN1Y2Nlc3NmdWxs
eS4KWyAgICAyLjUyOTIxMl0gc3lzdGVtZFsxXTogRmluaXNoZWQgTG9hZCBLZXJuZWwgTW9k
dWxlIHBzdG9yZV96b25lLgpbICAgIDIuNTI5Mjg1XSBzeXN0ZW1kWzFdOiBtb2Rwcm9iZUBl
ZmlfcHN0b3JlLnNlcnZpY2U6IERlYWN0aXZhdGVkIHN1Y2Nlc3NmdWxseS4KWyAgICAyLjUy
OTQ1Ml0gc3lzdGVtZFsxXTogRmluaXNoZWQgTG9hZCBLZXJuZWwgTW9kdWxlIGVmaV9wc3Rv
cmUuClsgICAgMi41Mjk2NTJdIHN5c3RlbWRbMV06IG1vZHByb2JlQHJhbW9vcHMuc2Vydmlj
ZTogRGVhY3RpdmF0ZWQgc3VjY2Vzc2Z1bGx5LgpbICAgIDIuNTI5ODgyXSBzeXN0ZW1kWzFd
OiBGaW5pc2hlZCBMb2FkIEtlcm5lbCBNb2R1bGUgcmFtb29wcy4KWyAgICAyLjUzMDY1MV0g
c3lzdGVtZFsxXTogTW91bnRpbmcgRlVTRSBDb250cm9sIEZpbGUgU3lzdGVtLi4uClsgICAg
Mi41MzEwMjBdIHN5c3RlbWRbMV06IE1vdW50aW5nIEtlcm5lbCBDb25maWd1cmF0aW9uIEZp
bGUgU3lzdGVtLi4uClsgICAgMi41MzE5NjddIHN5c3RlbWRbMV06IE1vdW50ZWQgRlVTRSBD
b250cm9sIEZpbGUgU3lzdGVtLgpbICAgIDIuNTMyMjQ1XSBzeXN0ZW1kWzFdOiBNb3VudGVk
IEtlcm5lbCBDb25maWd1cmF0aW9uIEZpbGUgU3lzdGVtLgpbICAgIDIuNTM0MjM5XSBscDog
ZHJpdmVyIGxvYWRlZCBidXQgbm8gZGV2aWNlcyBmb3VuZApbICAgIDIuNTM2MTkxXSBwcGRl
djogdXNlci1zcGFjZSBwYXJhbGxlbCBwb3J0IGRyaXZlcgpbICAgIDIuNTM3NzQ3XSBwYXJw
b3J0MDogUEMtc3R5bGUgYXQgMHgyNzggW1BDU1BQLEVQUF0KWyAgICAyLjU0ODk0NF0gc3lz
dGVtZFsxXTogU3RhcnRlZCBKb3VybmFsIFNlcnZpY2UuClsgICAgMi41NTg2OTddIEVYVDQt
ZnMgKG52bWUwbjFwMyk6IHJlLW1vdW50ZWQgMDYxNTAyYTktMjA1ZS00YjczLTgyNTEtMTIy
MGU3NzBjNWQ4IHIvdy4gUXVvdGEgbW9kZTogbm9uZS4KWyAgICAyLjU2MjYxMF0gc3lzdGVt
ZC1qb3VybmFsZFs0NjBdOiBSZWNlaXZlZCBjbGllbnQgcmVxdWVzdCB0byBmbHVzaCBydW50
aW1lIGpvdXJuYWwuClsgICAgMi41NzAzMDldIEFkZGluZyA1MTc4MzY3Nmsgc3dhcCBvbiAv
c3dhcGZpbGUuICBQcmlvcml0eTotMiBleHRlbnRzOjExNiBhY3Jvc3M6NDg2NjI1MDE2ayBT
UwpbICAgIDIuNjA1MzE2XSBsb29wMDogZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20g
MCB0byA4ClsgICAgMi42MDU1NzRdIGxvb3AxOiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2Ug
ZnJvbSAwIHRvIDE1MTM1MgpbICAgIDIuNjA2MTg4XSBsb29wMjogZGV0ZWN0ZWQgY2FwYWNp
dHkgY2hhbmdlIGZyb20gMCB0byA0ODkwMDgKWyAgICAyLjYwNjcwOV0gbG9vcDM6IGRldGVj
dGVkIGNhcGFjaXR5IGNoYW5nZSBmcm9tIDAgdG8gNDkyMTY4ClsgICAgMi42MDcyMDZdIGxv
b3A0OiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDk5NDMzNgpbICAgIDIu
NjA3Nzg3XSBsb29wNTogZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20gMCB0byAxMDE3
ODE2ClsgICAgMi42MDgyNjNdIGxvb3A2OiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJv
bSAwIHRvIDE4Nzc3NgpbICAgIDIuNjA5MDA4XSBsb29wNzogZGV0ZWN0ZWQgY2FwYWNpdHkg
Y2hhbmdlIGZyb20gMCB0byAyNTI0MApbICAgIDIuNjEwMDkyXSBsb29wODogZGV0ZWN0ZWQg
Y2FwYWNpdHkgY2hhbmdlIGZyb20gMCB0byA4MzY0OApbICAgIDIuNjEwNTU5XSBsb29wOTog
ZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20gMCB0byA4MzY3MgpbICAgIDIuNjExMTMz
XSBsb29wMTA6IGRldGVjdGVkIGNhcGFjaXR5IGNoYW5nZSBmcm9tIDAgdG8gOTA0ClsgICAg
Mi42NDQyMTRdIGxwMDogdXNpbmcgcGFycG9ydDAgKHBvbGxpbmcpLgpbICAgIDIuNjQ1Nzc5
XSBpbnB1dDogSW50ZWwgSElEIGV2ZW50cyBhcyAvZGV2aWNlcy9wbGF0Zm9ybS9JTlRDMTA3
MDowMC9pbnB1dC9pbnB1dDExClsgICAgMi42NDYwNzZdIGludGVsLWhpZCBJTlRDMTA3MDow
MDogcGxhdGZvcm0gc3VwcG9ydHMgNSBidXR0b24gYXJyYXkKWyAgICAyLjY0NjEwM10gaW5w
dXQ6IEludGVsIEhJRCA1IGJ1dHRvbiBhcnJheSBhcyAvZGV2aWNlcy9wbGF0Zm9ybS9JTlRD
MTA3MDowMC9pbnB1dC9pbnB1dDEyClsgICAgMi42NTE4MzBdIENvbnNpZGVyIHVzaW5nIHRo
ZXJtYWwgbmV0bGluayBldmVudHMgaW50ZXJmYWNlClsgICAgMi42ODExMTFdIF9fc3BpX2Fk
ZF9kZXZpY2UoKSBbNjY0XSBDU1swXSA9IFswXQpbICAgIDIuNjgxMTE4XSBfX3NwaV9hZGRf
ZGV2aWNlKCkgWzY2N10gQ1NfTkVXWzFdID0gWzBdClsgICAgMi42ODExMjJdIHB4YTJ4eC1z
cGkgcHhhMnh4LXNwaS42OiBjaGlwc2VsZWN0IDAgYWxyZWFkeSBpbiB1c2UKWyAgICAyLjY4
MTE2M10gc3BpX21hc3RlciBzcGkwOiBlcnJvciAtRUJVU1k6IGZhaWxlZCB0byBhZGQgU1BJ
IGRldmljZSBDU0MzNTUxOjAwIGZyb20gQUNQSQpbICAgIDIuNjgxODgyXSBTZXJpYWwgYnVz
IG11bHRpIGluc3RhbnRpYXRlIHBzZXVkbyBkZXZpY2UgZHJpdmVyOiBwcm9iZSBvZiBDU0Mz
NTUxOjAwIGZhaWxlZCB3aXRoIGVycm9yIC0xNgpbICAgIDIuNzMxMzYwXSBtYzogTGludXgg
bWVkaWEgaW50ZXJmYWNlOiB2MC4xMApbICAgIDIuNzQyMzMzXSBocF93bWk6IHF1ZXJ5IDB4
NCByZXR1cm5lZCBlcnJvciAweDUKWyAgICAyLjc0MzAwNF0gZHctYXBiLXVhcnQuNDogdHR5
UzUgYXQgTU1JTyAweDQwMTcwMDQwMDAgKGlycSA9IDQyLCBiYXNlX2JhdWQgPSA2MjUwMDAw
KSBpcyBhIDE2NTUwQQpbICAgIDIuNzU2MzgwXSBjZmc4MDIxMTogTG9hZGluZyBjb21waWxl
ZC1pbiBYLjUwOSBjZXJ0aWZpY2F0ZXMgZm9yIHJlZ3VsYXRvcnkgZGF0YWJhc2UKWyAgICAy
Ljc1NjU5MV0gTG9hZGVkIFguNTA5IGNlcnQgJ3Nmb3JzaGVlOiAwMGIyOGRkZjQ3YWVmOWNl
YTcnClsgICAgMi43NTcwMzFdIG1laV9tZSAwMDAwOjAwOjE2LjA6IGVuYWJsaW5nIGRldmlj
ZSAoMDAwMCAtPiAwMDAyKQpbICAgIDIuNzU3MTg3XSBpbnRlbF9yYXBsX21zcjogUEw0IHN1
cHBvcnQgZGV0ZWN0ZWQuClsgICAgMi43NTkwMjNdIGludGVsX3JhcGxfY29tbW9uOiBGb3Vu
ZCBSQVBMIGRvbWFpbiBwYWNrYWdlClsgICAgMi43NTkwMjldIGludGVsX3JhcGxfY29tbW9u
OiBGb3VuZCBSQVBMIGRvbWFpbiBjb3JlClsgICAgMi43NTkwMzFdIFJBUEwgUE1VOiBBUEkg
dW5pdCBpcyAyXi0zMiBKb3VsZXMsIDQgZml4ZWQgY291bnRlcnMsIDY1NTM2MCBtcyBvdmZs
IHRpbWVyClsgICAgMi43NTkwMzJdIGludGVsX3JhcGxfY29tbW9uOiBGb3VuZCBSQVBMIGRv
bWFpbiB1bmNvcmUKWyAgICAyLjc1OTAzM10gUkFQTCBQTVU6IGh3IHVuaXQgb2YgZG9tYWlu
IHBwMC1jb3JlIDJeLTE0IEpvdWxlcwpbICAgIDIuNzU5MDM0XSBSQVBMIFBNVTogaHcgdW5p
dCBvZiBkb21haW4gcGFja2FnZSAyXi0xNCBKb3VsZXMKWyAgICAyLjc1OTAzNF0gUkFQTCBQ
TVU6IGh3IHVuaXQgb2YgZG9tYWluIHBwMS1ncHUgMl4tMTQgSm91bGVzClsgICAgMi43NTkw
MzVdIFJBUEwgUE1VOiBodyB1bml0IG9mIGRvbWFpbiBwc3lzIDJeLTE0IEpvdWxlcwpbICAg
IDIuNzU5MDM1XSBpbnRlbF9yYXBsX2NvbW1vbjogRm91bmQgUkFQTCBkb21haW4gcHN5cwpb
ICAgIDIuNzU5NDU1XSBpbnB1dDogSFAgV01JIGhvdGtleXMgYXMgL2RldmljZXMvdmlydHVh
bC9pbnB1dC9pbnB1dDEzClsgICAgMi43NjE1NDVdIGR3LWFwYi11YXJ0LjU6IHR0eVM2IGF0
IE1NSU8gMHg0MDE3MDA1MDAwIChpcnEgPSAxNiwgYmFzZV9iYXVkID0gNjI1MDAwMCkgaXMg
YSAxNjU1MEEKWyAgICAyLjc2NzM3OF0gY3J5cHRkOiBtYXhfY3B1X3FsZW4gc2V0IHRvIDEw
MDAKWyAgICAyLjc3MTcyNF0gaGlkX3NlbnNvcl9hbHMgSElELVNFTlNPUi0yMDAwNDEuNC5h
dXRvOiBmYWlsZWQgdG8gc2V0dXAgYXR0cmlidXRlcwpbICAgIDIuNzcxNzI3XSBoaWRfc2Vu
c29yX2FsczogcHJvYmUgb2YgSElELVNFTlNPUi0yMDAwNDEuNC5hdXRvIGZhaWxlZCB3aXRo
IGVycm9yIC0xClsgICAgMi43NzYyMTZdIHZpZGVvZGV2OiBMaW51eCB2aWRlbyBjYXB0dXJl
IGludGVyZmFjZTogdjIuMDAKWyAgICAyLjc3ODYzOV0gcHJvY190aGVybWFsX3BjaSAwMDAw
OjAwOjA0LjA6IGVuYWJsaW5nIGRldmljZSAoMDAwMCAtPiAwMDAyKQpbICAgIDIuNzc4OTg0
XSBBVlgyIHZlcnNpb24gb2YgZ2NtX2VuYy9kZWMgZW5nYWdlZC4KWyAgICAyLjc3OTAxNV0g
aW50ZWxfcmFwbF9jb21tb246IEZvdW5kIFJBUEwgZG9tYWluIHBhY2thZ2UKWyAgICAyLjc3
OTA4N10gQUVTIENUUiBtb2RlIGJ5OCBvcHRpbWl6YXRpb24gZW5hYmxlZApbICAgIDIuNzgw
ODg5XSBJbnRlbChSKSBXaXJlbGVzcyBXaUZpIGRyaXZlciBmb3IgTGludXgKWyAgICAyLjc4
MDk2OV0gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IGVuYWJsaW5nIGRldmljZSAoMDAwMCAtPiAw
MDAyKQpbICAgIDIuNzgzMTk0XSBpd2x3aWZpIDAwMDA6MDA6MTQuMzogRGV0ZWN0ZWQgY3Jm
LWlkIDB4NDAwNDEwLCBjbnYtaWQgMHg4MDQwMSB3ZnBtIGlkIDB4ODAwMDAwMjAKWyAgICAy
Ljc4MzIyMF0gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IFBDSSBkZXYgN2FmMC8wMDkwLCByZXY9
MHg0MzAsIHJmaWQ9MHgyMDEwZDAwMApbICAgIDIuNzg2Mzc4XSBpd2x3aWZpIDAwMDA6MDA6
MTQuMzogRGlyZWN0IGZpcm13YXJlIGxvYWQgZm9yIGl3bHdpZmktc28tYTAtZ2YtYTAtODYu
dWNvZGUgZmFpbGVkIHdpdGggZXJyb3IgLTIKWyAgICAyLjc4NjU1MV0gaXdsd2lmaSAwMDAw
OjAwOjE0LjM6IERpcmVjdCBmaXJtd2FyZSBsb2FkIGZvciBpd2x3aWZpLXNvLWEwLWdmLWEw
LTg1LnVjb2RlIGZhaWxlZCB3aXRoIGVycm9yIC0yClsgICAgMi43ODY2NjJdIGl3bHdpZmkg
MDAwMDowMDoxNC4zOiBEaXJlY3QgZmlybXdhcmUgbG9hZCBmb3IgaXdsd2lmaS1zby1hMC1n
Zi1hMC04NC51Y29kZSBmYWlsZWQgd2l0aCBlcnJvciAtMgpbICAgIDIuNzg2NjgwXSBpd2x3
aWZpIDAwMDA6MDA6MTQuMzogRGlyZWN0IGZpcm13YXJlIGxvYWQgZm9yIGl3bHdpZmktc28t
YTAtZ2YtYTAtODMudWNvZGUgZmFpbGVkIHdpdGggZXJyb3IgLTIKWyAgICAyLjc4NjY5Nl0g
aXdsd2lmaSAwMDAwOjAwOjE0LjM6IERpcmVjdCBmaXJtd2FyZSBsb2FkIGZvciBpd2x3aWZp
LXNvLWEwLWdmLWEwLTgyLnVjb2RlIGZhaWxlZCB3aXRoIGVycm9yIC0yClsgICAgMi43ODY3
MTJdIGl3bHdpZmkgMDAwMDowMDoxNC4zOiBEaXJlY3QgZmlybXdhcmUgbG9hZCBmb3IgaXds
d2lmaS1zby1hMC1nZi1hMC04MS51Y29kZSBmYWlsZWQgd2l0aCBlcnJvciAtMgpbICAgIDIu
Nzg2NzI5XSBpd2x3aWZpIDAwMDA6MDA6MTQuMzogRGlyZWN0IGZpcm13YXJlIGxvYWQgZm9y
IGl3bHdpZmktc28tYTAtZ2YtYTAtODAudWNvZGUgZmFpbGVkIHdpdGggZXJyb3IgLTIKWyAg
ICAyLjc5MjgyMV0gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IGFwaSBmbGFncyBpbmRleCAyIGxh
cmdlciB0aGFuIHN1cHBvcnRlZCBieSBkcml2ZXIKWyAgICAyLjc5MjgzMl0gaXdsd2lmaSAw
MDAwOjAwOjE0LjM6IFRMVl9GV19GU0VRX1ZFUlNJT046IEZTRVEgVmVyc2lvbjogMC4wLjIu
NDEKWyAgICAyLjc5MzA5NF0gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IGxvYWRlZCBmaXJtd2Fy
ZSB2ZXJzaW9uIDc5LjI3ZjFjMzdiLjAgc28tYTAtZ2YtYTAtNzkudWNvZGUgb3BfbW9kZSBp
d2xtdm0KWyAgICAyLjc5NDA0N10gQmx1ZXRvb3RoOiBDb3JlIHZlciAyLjIyClsgICAgMi43
OTQwNjNdIE5FVDogUmVnaXN0ZXJlZCBQRl9CTFVFVE9PVEggcHJvdG9jb2wgZmFtaWx5Clsg
ICAgMi43OTQwNjRdIEJsdWV0b290aDogSENJIGRldmljZSBhbmQgY29ubmVjdGlvbiBtYW5h
Z2VyIGluaXRpYWxpemVkClsgICAgMi43OTQwNjddIEJsdWV0b290aDogSENJIHNvY2tldCBs
YXllciBpbml0aWFsaXplZApbICAgIDIuNzk0MDY4XSBCbHVldG9vdGg6IEwyQ0FQIHNvY2tl
dCBsYXllciBpbml0aWFsaXplZApbICAgIDIuNzk0MDcxXSBCbHVldG9vdGg6IFNDTyBzb2Nr
ZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgICAyLjgwMTUxM10gdXNiY29yZTogcmVnaXN0ZXJl
ZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBidHVzYgpbICAgIDIuODAzMTAzXSBCbHVldG9vdGg6
IGhjaTA6IERldmljZSByZXZpc2lvbiBpcyAwClsgICAgMi44MDMxMDddIEJsdWV0b290aDog
aGNpMDogU2VjdXJlIGJvb3QgaXMgZW5hYmxlZApbICAgIDIuODAzMTA4XSBCbHVldG9vdGg6
IGhjaTA6IE9UUCBsb2NrIGlzIGVuYWJsZWQKWyAgICAyLjgwMzEwOV0gQmx1ZXRvb3RoOiBo
Y2kwOiBBUEkgbG9jayBpcyBlbmFibGVkClsgICAgMi44MDMxMTBdIEJsdWV0b290aDogaGNp
MDogRGVidWcgbG9jayBpcyBkaXNhYmxlZApbICAgIDIuODAzMTExXSBCbHVldG9vdGg6IGhj
aTA6IE1pbmltdW0gZmlybXdhcmUgYnVpbGQgMSB3ZWVrIDEwIDIwMTQKWyAgICAyLjgwMzEx
Ml0gQmx1ZXRvb3RoOiBoY2kwOiBCb290bG9hZGVyIHRpbWVzdGFtcCAyMDE5LjQwIGJ1aWxk
dHlwZSAxIGJ1aWxkIDM4ClsgICAgMi44MDMxNjRdIEFDUEkgV2FybmluZzogXF9TQi5QQzAw
LlhIQ0kuUkhVQi5IUzE0Ll9EU006IEFyZ3VtZW50ICM0IHR5cGUgbWlzbWF0Y2ggLSBGb3Vu
ZCBbSW50ZWdlcl0sIEFDUEkgcmVxdWlyZXMgW1BhY2thZ2VdICgyMDIzMDYyOC9uc2FyZ3Vt
ZW50cy02MSkKWyAgICAyLjgwMzI4OF0gQmx1ZXRvb3RoOiBoY2kwOiBEU00gcmVzZXQgbWV0
aG9kIHR5cGU6IDB4MDAKWyAgICAyLjgwNDQwOV0gdXNiIDEtODogRm91bmQgVVZDIDEuNTAg
ZGV2aWNlIEhQIDVNUCBDYW1lcmEgKDA0MDg6NTQ1YikKWyAgICAyLjgwNDU0NV0gQmx1ZXRv
b3RoOiBoY2kwOiBGb3VuZCBkZXZpY2UgZmlybXdhcmU6IGludGVsL2lidC0xMDQwLTAwNDEu
c2ZpClsgICAgMi44MDQ1NTRdIEJsdWV0b290aDogaGNpMDogQm9vdCBBZGRyZXNzOiAweDEw
MDgwMApbICAgIDIuODA0NTU1XSBCbHVldG9vdGg6IGhjaTA6IEZpcm13YXJlIFZlcnNpb246
IDEwNy01MS4yMgpbICAgIDIuODEzMDA1XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3MDA1
ODc4OTQuNTIwOjIpOiBhcHBhcm1vcj0iU1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfbG9h
ZCIgcHJvZmlsZT0idW5jb25maW5lZCIgbmFtZT0ibGlicmVvZmZpY2Utc2VuZGRvYyIgcGlk
PTc4NSBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAgMi44MTMwNzFdIGF1ZGl0OiB0eXBl
PTE0MDAgYXVkaXQoMTcwMDU4Nzg5NC41MjA6Myk6IGFwcGFybW9yPSJTVEFUVVMiIG9wZXJh
dGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZpbmVkIiBuYW1lPSJsaWJyZW9m
ZmljZS1vb3NwbGFzaCIgcGlkPTc4NCBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAgMi44
MTMxOTNdIGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTcwMDU4Nzg5NC41MjA6NCk6IGFwcGFy
bW9yPSJTVEFUVVMiIG9wZXJhdGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZp
bmVkIiBuYW1lPSJsaWJyZW9mZmljZS14cGRmaW1wb3J0IiBwaWQ9Nzg3IGNvbW09ImFwcGFy
bW9yX3BhcnNlciIKWyAgICAyLjgxMzI3N10gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzAw
NTg3ODk0LjUyMDo1KTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9uPSJwcm9maWxlX2xv
YWQiIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9Im52aWRpYV9tb2Rwcm9iZSIgcGlkPTc3
OCBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAgMi44MTMyODBdIGF1ZGl0OiB0eXBlPTE0
MDAgYXVkaXQoMTcwMDU4Nzg5NC41MjA6Nik6IGFwcGFybW9yPSJTVEFUVVMiIG9wZXJhdGlv
bj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZpbmVkIiBuYW1lPSJudmlkaWFfbW9k
cHJvYmUvL2ttb2QiIHBpZD03NzggY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpbICAgIDIuODEz
MzEyXSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3MDA1ODc4OTQuNTIwOjcpOiBhcHBhcm1v
cj0iU1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfbG9hZCIgcHJvZmlsZT0idW5jb25maW5l
ZCIgbmFtZT0ibHNiX3JlbGVhc2UiIHBpZD03NzcgY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpb
ICAgIDIuODEzNDU2XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3MDA1ODc4OTQuNTIwOjgp
OiBhcHBhcm1vcj0iU1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfbG9hZCIgcHJvZmlsZT0i
dW5jb25maW5lZCIgbmFtZT0iL3Vzci9iaW4vbWFuIiBwaWQ9NzgxIGNvbW09ImFwcGFybW9y
X3BhcnNlciIKWyAgICAyLjgxMzQ2NV0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzAwNTg3
ODk0LjUyMDo5KTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9uPSJwcm9maWxlX2xvYWQi
IHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9Im1hbl9maWx0ZXIiIHBpZD03ODEgY29tbT0i
YXBwYXJtb3JfcGFyc2VyIgpbICAgIDIuODEzNDY4XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0
KDE3MDA1ODc4OTQuNTIwOjEwKTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9uPSJwcm9m
aWxlX2xvYWQiIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9Im1hbl9ncm9mZiIgcGlkPTc4
MSBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAgMi44ODI1MDJdIHVzYiAxLTg6IEZvdW5k
IFVWQyAxLjUwIGRldmljZSBIUCA1TVAgQ2FtZXJhICgwNDA4OjU0NWIpClsgICAgMi45MDAy
MDFdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgdXZjdmlkZW8K
WyAgICAzLjA1MzcxOF0gaTkxNSAwMDAwOjAwOjAyLjA6IFtkcm1dIFZULWQgYWN0aXZlIGZv
ciBnZnggYWNjZXNzClsgICAgMy4wNTM4NzFdIENvbnNvbGU6IHN3aXRjaGluZyB0byBjb2xv
dXIgZHVtbXkgZGV2aWNlIDgweDI1ClsgICAgMy4wNTM4ODldIGk5MTUgMDAwMDowMDowMi4w
OiB2Z2FhcmI6IGRlYWN0aXZhdGUgdmdhIGNvbnNvbGUKWyAgICAzLjA1MzkzM10gaTkxNSAw
MDAwOjAwOjAyLjA6IFtkcm1dIFVzaW5nIFRyYW5zcGFyZW50IEh1Z2VwYWdlcwpbICAgIDMu
MDU0NjExXSBpOTE1IDAwMDA6MDA6MDIuMDogdmdhYXJiOiBWR0EgZGVjb2RlcyBjaGFuZ2Vk
OiBvbGRkZWNvZGVzPWlvK21lbSxkZWNvZGVzPW5vbmU6b3ducz1pbyttZW0KWyAgICAzLjA1
NTU0Nl0gaTkxNSAwMDAwOjAwOjAyLjA6IFtkcm1dIEZpbmlzaGVkIGxvYWRpbmcgRE1DIGZp
cm13YXJlIGk5MTUvYWRsc19kbWNfdmVyMl8wMS5iaW4gKHYyLjEpClsgICAgMy4wNjA2ODVd
IGl3bHdpZmkgMDAwMDowMDoxNC4zOiBEZXRlY3RlZCBJbnRlbChSKSBXaS1GaSA2RSBBWDIx
MSAxNjBNSHosIFJFVj0weDQzMApbICAgIDMuMDYwNzcwXSB0aGVybWFsIHRoZXJtYWxfem9u
ZTE3OiBmYWlsZWQgdG8gcmVhZCBvdXQgdGhlcm1hbCB6b25lICgtNjEpClsgICAgMy4wNjEy
MzFdIG1laV9oZGNwIDAwMDA6MDA6MTYuMC1iNjM4YWI3ZS05NGUyLTRlYTItYTU1Mi1kMWM1
NGI2MjdmMDQ6IGJvdW5kIDAwMDA6MDA6MDIuMCAob3BzIGk5MTVfaGRjcF9vcHMgW2k5MTVd
KQpbICAgIDMuMDY0MzU4XSBzbmRfaGRhX2ludGVsIDAwMDA6MDA6MWYuMzogRFNQIGRldGVj
dGVkIHdpdGggUENJIGNsYXNzL3N1YmNsYXNzL3Byb2ctaWYgaW5mbyAweDA0MDEwMApbICAg
IDMuMDY0Mzc3XSBzbmRfaGRhX2ludGVsIDAwMDA6MDA6MWYuMzogRGlnaXRhbCBtaWNzIGZv
dW5kIG9uIFNreWxha2UrIHBsYXRmb3JtLCB1c2luZyBTT0YgZHJpdmVyClsgICAgMy4wNjQ0
MzRdIHNuZF9oZGFfaW50ZWwgMDAwMDowMTowMC4xOiBlbmFibGluZyBkZXZpY2UgKDAwMDAg
LT4gMDAwMikKWyAgICAzLjA2NDUzNF0gc25kX2hkYV9pbnRlbCAwMDAwOjAxOjAwLjE6IERp
c2FibGluZyBNU0kKWyAgICAzLjA2NDUzOV0gc25kX2hkYV9pbnRlbCAwMDAwOjAxOjAwLjE6
IEhhbmRsZSB2Z2Ffc3dpdGNoZXJvbyBhdWRpbyBjbGllbnQKWyAgICAzLjA2ODg0OF0gaXds
d2lmaSAwMDAwOjAwOjE0LjM6IFdSVDogSW52YWxpZCBidWZmZXIgZGVzdGluYXRpb24KWyAg
ICAzLjA4ODgwOV0gaW50ZWxfdGNjX2Nvb2xpbmc6IFRDQyBPZmZzZXQgbG9ja2VkClsgICAg
My4wOTQ1MDNdIGlucHV0OiBIREEgTlZpZGlhIEhETUkvRFAscGNtPTMgYXMgL2RldmljZXMv
cGNpMDAwMDowMC8wMDAwOjAwOjAxLjAvMDAwMDowMTowMC4xL3NvdW5kL2NhcmQwL2lucHV0
MTQKWyAgICAzLjA5NDU2MV0gaW5wdXQ6IEhEQSBOVmlkaWEgSERNSS9EUCxwY209NyBhcyAv
ZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MDEuMC8wMDAwOjAxOjAwLjEvc291bmQvY2Fy
ZDAvaW5wdXQxNQpbICAgIDMuMDk0NjExXSBpbnB1dDogSERBIE5WaWRpYSBIRE1JL0RQLHBj
bT04IGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDowMS4wLzAwMDA6MDE6MDAuMS9z
b3VuZC9jYXJkMC9pbnB1dDE2ClsgICAgMy4wOTQ2NjNdIGlucHV0OiBIREEgTlZpZGlhIEhE
TUkvRFAscGNtPTkgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjAxLjAvMDAwMDow
MTowMC4xL3NvdW5kL2NhcmQwL2lucHV0MTcKWyAgICAzLjA5OTU4MF0gc29mLWF1ZGlvLXBj
aS1pbnRlbC10Z2wgMDAwMDowMDoxZi4zOiBEU1AgZGV0ZWN0ZWQgd2l0aCBQQ0kgY2xhc3Mv
c3ViY2xhc3MvcHJvZy1pZiBpbmZvIDB4MDQwMTAwClsgICAgMy4xMDI4NTBdIHNvZi1hdWRp
by1wY2ktaW50ZWwtdGdsIDAwMDA6MDA6MWYuMzogRGlnaXRhbCBtaWNzIGZvdW5kIG9uIFNr
eWxha2UrIHBsYXRmb3JtLCB1c2luZyBTT0YgZHJpdmVyClsgICAgMy4xMDI4NjBdIHNvZi1h
dWRpby1wY2ktaW50ZWwtdGdsIDAwMDA6MDA6MWYuMzogZW5hYmxpbmcgZGV2aWNlICgwMDAw
IC0+IDAwMDIpClsgICAgMy4xMDM1MTZdIHNvZi1hdWRpby1wY2ktaW50ZWwtdGdsIDAwMDA6
MDA6MWYuMzogRFNQIGRldGVjdGVkIHdpdGggUENJIGNsYXNzL3N1YmNsYXNzL3Byb2ctaWYg
MHgwNDAxMDAKWyAgICAzLjEwNTUwMV0gaW5wdXQ6IFNZTkEzMEY3OjAwIDA2Q0I6Q0VDMyBN
b3VzZSBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MTUuMC9pMmNfZGVzaWdud2Fy
ZS4wL2kyYy0xL2kyYy1TWU5BMzBGNzowMC8wMDE4OjA2Q0I6Q0VDMy4wMDAxL2lucHV0L2lu
cHV0MTgKWyAgICAzLjEwNTYwMV0gaW5wdXQ6IFNZTkEzMEY3OjAwIDA2Q0I6Q0VDMyBUb3Vj
aHBhZCBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MTUuMC9pMmNfZGVzaWdud2Fy
ZS4wL2kyYy0xL2kyYy1TWU5BMzBGNzowMC8wMDE4OjA2Q0I6Q0VDMy4wMDAxL2lucHV0L2lu
cHV0MTkKWyAgICAzLjEwNTY3OF0gaGlkLW11bHRpdG91Y2ggMDAxODowNkNCOkNFQzMuMDAw
MTogaW5wdXQsaGlkcmF3MDogSTJDIEhJRCB2MS4wMCBNb3VzZSBbU1lOQTMwRjc6MDAgMDZD
QjpDRUMzXSBvbiBpMmMtU1lOQTMwRjc6MDAKWyAgICAzLjEwNjk5NF0gc25kX2hkYV9pbnRl
bCAwMDAwOjAwOjFmLjM6IERTUCBkZXRlY3RlZCB3aXRoIFBDSSBjbGFzcy9zdWJjbGFzcy9w
cm9nLWlmIGluZm8gMHgwNDAxMDAKWyAgICAzLjEwODkzOV0gc25kX2hkYV9pbnRlbCAwMDAw
OjAwOjFmLjM6IERpZ2l0YWwgbWljcyBmb3VuZCBvbiBTa3lsYWtlKyBwbGF0Zm9ybSwgdXNp
bmcgU09GIGRyaXZlcgpbICAgIDMuMTA4OTQ1XSBzb2YtYXVkaW8tcGNpLWludGVsLXRnbCAw
MDAwOjAwOjFmLjM6IERTUCBkZXRlY3RlZCB3aXRoIFBDSSBjbGFzcy9zdWJjbGFzcy9wcm9n
LWlmIGluZm8gMHgwNDAxMDAKWyAgICAzLjEwODk1MV0gc29mLWF1ZGlvLXBjaS1pbnRlbC10
Z2wgMDAwMDowMDoxZi4zOiBEaWdpdGFsIG1pY3MgZm91bmQgb24gU2t5bGFrZSsgcGxhdGZv
cm0sIHVzaW5nIFNPRiBkcml2ZXIKWyAgICAzLjEwOTA4MF0gc29mLWF1ZGlvLXBjaS1pbnRl
bC10Z2wgMDAwMDowMDoxZi4zOiBEU1AgZGV0ZWN0ZWQgd2l0aCBQQ0kgY2xhc3Mvc3ViY2xh
c3MvcHJvZy1pZiAweDA0MDEwMApbICAgIDMuMjE0OTkyXSBCbHVldG9vdGg6IEJORVAgKEV0
aGVybmV0IEVtdWxhdGlvbikgdmVyIDEuMwpbICAgIDMuMjE0OTk2XSBCbHVldG9vdGg6IEJO
RVAgZmlsdGVyczogcHJvdG9jb2wgbXVsdGljYXN0ClsgICAgMy4yMTUwMDFdIEJsdWV0b290
aDogQk5FUCBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgICAzLjIzMDAzMV0gaXdsd2lm
aSAwMDAwOjAwOjE0LjM6IFdGUE1fVU1BQ19QRF9OT1RJRklDQVRJT046IDB4MjAKWyAgICAz
LjIzMDA2Ml0gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IFdGUE1fTE1BQzJfUERfTk9USUZJQ0FU
SU9OOiAweDFmClsgICAgMy4yMzAwNzBdIGl3bHdpZmkgMDAwMDowMDoxNC4zOiBXRlBNX0FV
VEhfS0VZXzA6IDB4OTAKWyAgICAzLjIzMDA4MF0gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IENO
VklfU0NVX1NFUV9EQVRBX0RXOTogMHgwClsgICAgMy4yMzAzMTldIGl3bHdpZmkgMDAwMDow
MDoxNC4zOiBsb2FkZWQgUE5WTSB2ZXJzaW9uIDY0YWNkYzUxClsgICAgMy4yNDcwNDVdIGl3
bHdpZmkgMDAwMDowMDoxNC4zOiBEZXRlY3RlZCBSRiBHRiwgcmZpZD0weDIwMTBkMDAwClsg
ICAgMy4zMTUzMjldIGl3bHdpZmkgMDAwMDowMDoxNC4zOiBiYXNlIEhXIGFkZHJlc3M6IGUw
OmQwOjQ1OjIzOmQ2OmM0ClsgICAgMy4zMjA5MTBdIGlucHV0OiBFTEFOMjUxMzowMCAwNEYz
OjJGRTAgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjE1LjEvaTJjX2Rlc2lnbndh
cmUuMS9pMmMtMi9pMmMtRUxBTjI1MTM6MDAvMDAxODowNEYzOjJGRTAuMDAwMi9pbnB1dC9p
bnB1dDIxClsgICAgMy4zMjA5NjNdIGlucHV0OiBFTEFOMjUxMzowMCAwNEYzOjJGRTAgVU5L
Tk9XTiBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MTUuMS9pMmNfZGVzaWdud2Fy
ZS4xL2kyYy0yL2kyYy1FTEFOMjUxMzowMC8wMDE4OjA0RjM6MkZFMC4wMDAyL2lucHV0L2lu
cHV0MjIKWyAgICAzLjMyMDk4Nl0gaW5wdXQ6IEVMQU4yNTEzOjAwIDA0RjM6MkZFMCBVTktO
T1dOIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxNS4xL2kyY19kZXNpZ253YXJl
LjEvaTJjLTIvaTJjLUVMQU4yNTEzOjAwLzAwMTg6MDRGMzoyRkUwLjAwMDIvaW5wdXQvaW5w
dXQyMwpbICAgIDMuMzIxMDI4XSBoaWQtbXVsdGl0b3VjaCAwMDE4OjA0RjM6MkZFMC4wMDAy
OiBpbnB1dCxoaWRyYXcxOiBJMkMgSElEIHYxLjAwIERldmljZSBbRUxBTjI1MTM6MDAgMDRG
MzoyRkUwXSBvbiBpMmMtRUxBTjI1MTM6MDAKWyAgICAzLjMyMTA2NV0gc25kX2hkYV9pbnRl
bCAwMDAwOjAwOjFmLjM6IERTUCBkZXRlY3RlZCB3aXRoIFBDSSBjbGFzcy9zdWJjbGFzcy9w
cm9nLWlmIGluZm8gMHgwNDAxMDAKWyAgICAzLjMyMTA4N10gc25kX2hkYV9pbnRlbCAwMDAw
OjAwOjFmLjM6IERpZ2l0YWwgbWljcyBmb3VuZCBvbiBTa3lsYWtlKyBwbGF0Zm9ybSwgdXNp
bmcgU09GIGRyaXZlcgpbICAgIDMuMzIxMDkzXSBzb2YtYXVkaW8tcGNpLWludGVsLXRnbCAw
MDAwOjAwOjFmLjM6IERTUCBkZXRlY3RlZCB3aXRoIFBDSSBjbGFzcy9zdWJjbGFzcy9wcm9n
LWlmIGluZm8gMHgwNDAxMDAKWyAgICAzLjMyMTA5OV0gc29mLWF1ZGlvLXBjaS1pbnRlbC10
Z2wgMDAwMDowMDoxZi4zOiBEaWdpdGFsIG1pY3MgZm91bmQgb24gU2t5bGFrZSsgcGxhdGZv
cm0sIHVzaW5nIFNPRiBkcml2ZXIKWyAgICAzLjMyMTMwMV0gc29mLWF1ZGlvLXBjaS1pbnRl
bC10Z2wgMDAwMDowMDoxZi4zOiBEU1AgZGV0ZWN0ZWQgd2l0aCBQQ0kgY2xhc3Mvc3ViY2xh
c3MvcHJvZy1pZiAweDA0MDEwMApbICAgIDMuMzYyMzk4XSBpd2x3aWZpIDAwMDA6MDA6MTQu
MyB3bHAwczIwZjM6IHJlbmFtZWQgZnJvbSB3bGFuMApbICAgIDMuNjAzNzU4XSBpd2x3aWZp
IDAwMDA6MDA6MTQuMzogV1JUOiBJbnZhbGlkIGJ1ZmZlciBkZXN0aW5hdGlvbgpbICAgIDMu
NzU5NjkzXSBpd2x3aWZpIDAwMDA6MDA6MTQuMzogV0ZQTV9VTUFDX1BEX05PVElGSUNBVElP
TjogMHgyMApbICAgIDMuNzU5NzI2XSBpd2x3aWZpIDAwMDA6MDA6MTQuMzogV0ZQTV9MTUFD
Ml9QRF9OT1RJRklDQVRJT046IDB4MWYKWyAgICAzLjc1OTczNF0gaXdsd2lmaSAwMDAwOjAw
OjE0LjM6IFdGUE1fQVVUSF9LRVlfMDogMHg5MApbICAgIDMuNzU5NzQyXSBpd2x3aWZpIDAw
MDA6MDA6MTQuMzogQ05WSV9TQ1VfU0VRX0RBVEFfRFc5OiAweDAKWyAgICAzLjg0NzkxNV0g
aXdsd2lmaSAwMDAwOjAwOjE0LjM6IFJlZ2lzdGVyZWQgUEhDIGNsb2NrOiBpd2x3aWZpLVBU
UCwgd2l0aCBpbmRleDogMQpbICAgIDMuOTY2MjUyXSBsb29wMTE6IGRldGVjdGVkIGNhcGFj
aXR5IGNoYW5nZSBmcm9tIDAgdG8gOApbICAgIDQuMTgxNTQ3XSBCbHVldG9vdGg6IGhjaTA6
IFdhaXRpbmcgZm9yIGZpcm13YXJlIGRvd25sb2FkIHRvIGNvbXBsZXRlClsgICAgNC4xODIw
NjhdIEJsdWV0b290aDogaGNpMDogRmlybXdhcmUgbG9hZGVkIGluIDEzNDUyMzUgdXNlY3MK
WyAgICA0LjE4MjEwM10gQmx1ZXRvb3RoOiBoY2kwOiBXYWl0aW5nIGZvciBkZXZpY2UgdG8g
Ym9vdApbICAgIDQuMTk4MDcwXSBCbHVldG9vdGg6IGhjaTA6IERldmljZSBib290ZWQgaW4g
MTU2MDggdXNlY3MKWyAgICA0LjE5ODA3MV0gQmx1ZXRvb3RoOiBoY2kwOiBNYWxmb3JtZWQg
TVNGVCB2ZW5kb3IgZXZlbnQ6IDB4MDIKWyAgICA0LjE5ODIwOF0gQmx1ZXRvb3RoOiBoY2kw
OiBGb3VuZCBJbnRlbCBEREMgcGFyYW1ldGVyczogaW50ZWwvaWJ0LTEwNDAtMDA0MS5kZGMK
WyAgICA0LjIwMDA3Ml0gQmx1ZXRvb3RoOiBoY2kwOiBBcHBseWluZyBJbnRlbCBEREMgcGFy
YW1ldGVycyBjb21wbGV0ZWQKWyAgICA0LjIwMzA5NV0gQmx1ZXRvb3RoOiBoY2kwOiBGaXJt
d2FyZSB0aW1lc3RhbXAgMjAyMi41MSBidWlsZHR5cGUgMSBidWlsZCA1NjY4MwpbICAgIDQu
MjczMTQ2XSBCbHVldG9vdGg6IE1HTVQgdmVyIDEuMjIKWyAgICA0LjI3NjEyNV0gTkVUOiBS
ZWdpc3RlcmVkIFBGX0FMRyBwcm90b2NvbCBmYW1pbHkKWyAgICA4LjE4NjU0OF0gaTkxNSAw
MDAwOjAwOjAyLjA6IFtkcm1dIEdUMDogR3VDIGZpcm13YXJlIGk5MTUvdGdsX2d1Y183MC5i
aW4gKDcwLjEyLjEpIGlzIHJlY29tbWVuZGVkLCBidXQgb25seSBpOTE1L3RnbF9ndWNfNzAu
YmluICg3MC41LjEpIHdhcyBmb3VuZApbICAgIDguMTg2NTU0XSBpOTE1IDAwMDA6MDA6MDIu
MDogW2RybV0gR1QwOiBDb25zaWRlciB1cGRhdGluZyB5b3VyIGxpbnV4LWZpcm13YXJlIHBr
ZyBvciBkb3dubG9hZGluZyBmcm9tIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L2Zpcm13YXJlL2xpbnV4LWZpcm13YXJlLmdpdC90cmVlL2k5MTUK
WyAgICA4LjE5MTI4Nl0gaTkxNSAwMDAwOjAwOjAyLjA6IFtkcm1dIEdUMDogR3VDIGZpcm13
YXJlIGk5MTUvdGdsX2d1Y183MC5iaW4gdmVyc2lvbiA3MC41LjEKWyAgICA4LjE5MTI4OV0g
aTkxNSAwMDAwOjAwOjAyLjA6IFtkcm1dIEdUMDogSHVDIGZpcm13YXJlIGk5MTUvdGdsX2h1
Yy5iaW4gdmVyc2lvbiA3LjkuMwpbICAgIDguMjA2MzY2XSBpOTE1IDAwMDA6MDA6MDIuMDog
W2RybV0gR1QwOiBIdUM6IGF1dGhlbnRpY2F0ZWQgZm9yIGFsbCB3b3JrbG9hZHMKWyAgICA4
LjIwNjM3N10gaTkxNSAwMDAwOjAwOjAyLjA6IFtkcm1dIEdUMDogR1VDOiBzdWJtaXNzaW9u
IGRpc2FibGVkClsgICAgOC4yMDYzODFdIGk5MTUgMDAwMDowMDowMi4wOiBbZHJtXSBHVDA6
IEdVQzogU0xQQyBkaXNhYmxlZApbICAgIDguMjA3NDE2XSBtZWlfcHhwIDAwMDA6MDA6MTYu
MC1mYmY2ZmNmMS05NmNmLTRlMmUtYTZhNi0xYmFiOGNiZTM2YjE6IGJvdW5kIDAwMDA6MDA6
MDIuMCAob3BzIGk5MTVfcHhwX3RlZV9jb21wb25lbnRfb3BzIFtpOTE1XSkKWyAgICA4LjIw
NzU5Ml0gaTkxNSAwMDAwOjAwOjAyLjA6IFtkcm1dIFByb3RlY3RlZCBYZSBQYXRoIChQWFAp
IHByb3RlY3RlZCBjb250ZW50IHN1cHBvcnQgaW5pdGlhbGl6ZWQKWyAgICA4LjIyNzAyMl0g
W2RybV0gSW5pdGlhbGl6ZWQgaTkxNSAxLjYuMCAyMDIzMDkyOSBmb3IgMDAwMDowMDowMi4w
IG9uIG1pbm9yIDAKWyAgICA4LjIyODA2M10gQUNQSTogdmlkZW86IFZpZGVvIERldmljZSBb
UEVHUF0gKG11bHRpLWhlYWQ6IHllcyAgcm9tOiBubyAgcG9zdDogbm8pClsgICAgOC4yMjgy
MThdIGlucHV0OiBWaWRlbyBCdXMgYXMgL2RldmljZXMvTE5YU1lTVE06MDAvTE5YU1lCVVM6
MDAvUE5QMEEwODowMC9kZXZpY2U6MDMvTE5YVklERU86MDAvaW5wdXQvaW5wdXQyNQpbICAg
IDguMjI4MzAxXSBzbmRfaGRhX2ludGVsIDAwMDA6MDA6MWYuMzogRFNQIGRldGVjdGVkIHdp
dGggUENJIGNsYXNzL3N1YmNsYXNzL3Byb2ctaWYgaW5mbyAweDA0MDEwMApbICAgIDguMjI4
NTUxXSBzbmRfaGRhX2ludGVsIDAwMDA6MDA6MWYuMzogRGlnaXRhbCBtaWNzIGZvdW5kIG9u
IFNreWxha2UrIHBsYXRmb3JtLCB1c2luZyBTT0YgZHJpdmVyClsgICAgOC4yMjg1NTldIHNv
Zi1hdWRpby1wY2ktaW50ZWwtdGdsIDAwMDA6MDA6MWYuMzogRFNQIGRldGVjdGVkIHdpdGgg
UENJIGNsYXNzL3N1YmNsYXNzL3Byb2ctaWYgaW5mbyAweDA0MDEwMApbICAgIDguMjI5MjMz
XSBzb2YtYXVkaW8tcGNpLWludGVsLXRnbCAwMDAwOjAwOjFmLjM6IERpZ2l0YWwgbWljcyBm
b3VuZCBvbiBTa3lsYWtlKyBwbGF0Zm9ybSwgdXNpbmcgU09GIGRyaXZlcgpbICAgIDguMjI5
NDgyXSBzb2YtYXVkaW8tcGNpLWludGVsLXRnbCAwMDAwOjAwOjFmLjM6IERTUCBkZXRlY3Rl
ZCB3aXRoIFBDSSBjbGFzcy9zdWJjbGFzcy9wcm9nLWlmIDB4MDQwMTAwClsgICAgOC4yMzAy
NjZdIEFDUEk6IHZpZGVvOiBWaWRlbyBEZXZpY2UgW0dGWDBdIChtdWx0aS1oZWFkOiB5ZXMg
IHJvbTogbm8gIHBvc3Q6IG5vKQpbICAgIDguMjMwNTc4XSBpbnB1dDogVmlkZW8gQnVzIGFz
IC9kZXZpY2VzL0xOWFNZU1RNOjAwL0xOWFNZQlVTOjAwL1BOUDBBMDg6MDAvTE5YVklERU86
MDEvaW5wdXQvaW5wdXQyNgpbICAgIDguMjMwNjI4XSBzbmRfaGRhX2ludGVsIDAwMDA6MDA6
MWYuMzogRFNQIGRldGVjdGVkIHdpdGggUENJIGNsYXNzL3N1YmNsYXNzL3Byb2ctaWYgaW5m
byAweDA0MDEwMApbICAgIDguMjMwNjM4XSBzbmRfaGRhX2ludGVsIDAwMDA6MDA6MWYuMzog
RGlnaXRhbCBtaWNzIGZvdW5kIG9uIFNreWxha2UrIHBsYXRmb3JtLCB1c2luZyBTT0YgZHJp
dmVyClsgICAgOC4yMzA2NDNdIHNvZi1hdWRpby1wY2ktaW50ZWwtdGdsIDAwMDA6MDA6MWYu
MzogRFNQIGRldGVjdGVkIHdpdGggUENJIGNsYXNzL3N1YmNsYXNzL3Byb2ctaWYgaW5mbyAw
eDA0MDEwMApbICAgIDguMjMwNjUxXSBzb2YtYXVkaW8tcGNpLWludGVsLXRnbCAwMDAwOjAw
OjFmLjM6IERpZ2l0YWwgbWljcyBmb3VuZCBvbiBTa3lsYWtlKyBwbGF0Zm9ybSwgdXNpbmcg
U09GIGRyaXZlcgpbICAgIDguMjMwNzE3XSBpOTE1IGRpc3BsYXkgaW5mbzogZGlzcGxheSB2
ZXJzaW9uOiAxMgpbICAgIDguMjMwNzE5XSBpOTE1IGRpc3BsYXkgaW5mbzogY3Vyc29yX25l
ZWRzX3BoeXNpY2FsOiBubwpbICAgIDguMjMwNzIwXSBpOTE1IGRpc3BsYXkgaW5mbzogaGFz
X2NkY2xrX2NyYXdsOiBubwpbICAgIDguMjMwNzIxXSBpOTE1IGRpc3BsYXkgaW5mbzogaGFz
X2NkY2xrX3NxdWFzaDogbm8KWyAgICA4LjIzMDcyMl0gaTkxNSBkaXNwbGF5IGluZm86IGhh
c19kZGk6IHllcwpbICAgIDguMjMwNzIzXSBpOTE1IGRpc3BsYXkgaW5mbzogaGFzX2RwX21z
dDogeWVzClsgICAgOC4yMzA3MjRdIGk5MTUgZGlzcGxheSBpbmZvOiBoYXNfZHNiOiB5ZXMK
WyAgICA4LjIzMDcyNV0gaTkxNSBkaXNwbGF5IGluZm86IGhhc19mcGdhX2RiZzogeWVzClsg
ICAgOC4yMzA3MjZdIGk5MTUgZGlzcGxheSBpbmZvOiBoYXNfZ21jaDogbm8KWyAgICA4LjIz
MDcyN10gaTkxNSBkaXNwbGF5IGluZm86IGhhc19ob3RwbHVnOiB5ZXMKWyAgICA4LjIzMDcy
OF0gaTkxNSBkaXNwbGF5IGluZm86IGhhc19odGk6IHllcwpbICAgIDguMjMwNzI5XSBpOTE1
IGRpc3BsYXkgaW5mbzogaGFzX2lwYzogeWVzClsgICAgOC4yMzA3MjldIGk5MTUgZGlzcGxh
eSBpbmZvOiBoYXNfb3ZlcmxheTogbm8KWyAgICA4LjIzMDczMF0gaTkxNSBkaXNwbGF5IGlu
Zm86IGhhc19wc3I6IHllcwpbICAgIDguMjMwNzMxXSBpOTE1IGRpc3BsYXkgaW5mbzogaGFz
X3Bzcl9od190cmFja2luZzogbm8KWyAgICA4LjIzMDczMl0gaTkxNSBkaXNwbGF5IGluZm86
IG92ZXJsYXlfbmVlZHNfcGh5c2ljYWw6IG5vClsgICAgOC4yMzA3MzNdIGk5MTUgZGlzcGxh
eSBpbmZvOiBzdXBwb3J0c190djogbm8KWyAgICA4LjIzMDczNF0gaTkxNSBkaXNwbGF5IGlu
Zm86IGhhc19oZGNwOiB5ZXMKWyAgICA4LjIzMDczNV0gaTkxNSBkaXNwbGF5IGluZm86IGhh
c19kbWM6IHllcwpbICAgIDguMjMwNzM2XSBpOTE1IGRpc3BsYXkgaW5mbzogaGFzX2RzYzog
eWVzClsgICAgOC4yMzA4MjJdIHNvZi1hdWRpby1wY2ktaW50ZWwtdGdsIDAwMDA6MDA6MWYu
MzogRFNQIGRldGVjdGVkIHdpdGggUENJIGNsYXNzL3N1YmNsYXNzL3Byb2ctaWYgMHgwNDAx
MDAKWyAgICA4LjIzMzIwMF0gZmJjb246IGk5MTVkcm1mYiAoZmIwKSBpcyBwcmltYXJ5IGRl
dmljZQpbICAgIDguMjMzMTYxXSBzb2YtYXVkaW8tcGNpLWludGVsLXRnbCAwMDAwOjAwOjFm
LjM6IGJvdW5kIDAwMDA6MDA6MDIuMCAob3BzIGk5MTVfYXVkaW9fY29tcG9uZW50X2JpbmRf
b3BzIFtpOTE1XSkKWyAgICA4LjIzOTcyMF0gc29mLWF1ZGlvLXBjaS1pbnRlbC10Z2wgMDAw
MDowMDoxZi4zOiB1c2UgbXNpIGludGVycnVwdCBtb2RlClsgICAgOC4yNDEwNDNdIENvbnNv
bGU6IHN3aXRjaGluZyB0byBjb2xvdXIgZnJhbWUgYnVmZmVyIGRldmljZSAyNDB4NzUKWyAg
ICA4LjI1ODc2N10gaTkxNSAwMDAwOjAwOjAyLjA6IFtkcm1dIGZiMDogaTkxNWRybWZiIGZy
YW1lIGJ1ZmZlciBkZXZpY2UKWyAgICA4LjMwNDM0OF0gc29mLWF1ZGlvLXBjaS1pbnRlbC10
Z2wgMDAwMDowMDoxZi4zOiBoZGEgY29kZWNzIGZvdW5kLCBtYXNrIDUKWyAgICA4LjMwNDM1
Ml0gc29mLWF1ZGlvLXBjaS1pbnRlbC10Z2wgMDAwMDowMDoxZi4zOiB1c2luZyBIREEgbWFj
aGluZSBkcml2ZXIgc2tsX2hkYV9kc3BfZ2VuZXJpYyBub3cKWyAgICA4LjMwNDM1NF0gc29m
LWF1ZGlvLXBjaS1pbnRlbC10Z2wgMDAwMDowMDoxZi4zOiBETUlDcyBkZXRlY3RlZCBpbiBO
SExUIHRhYmxlczogNApbICAgIDguMzA1MjMzXSBzb2YtYXVkaW8tcGNpLWludGVsLXRnbCAw
MDAwOjAwOjFmLjM6IEZpcm13YXJlIGluZm86IHZlcnNpb24gMjowOjAtYjY3OGEKWyAgICA4
LjMwNTIzNV0gc29mLWF1ZGlvLXBjaS1pbnRlbC10Z2wgMDAwMDowMDoxZi4zOiBGaXJtd2Fy
ZTogQUJJIDM6MjA6MCBLZXJuZWwgQUJJIDM6MjM6MApbICAgIDguMzA1MjM4XSBzb2YtYXVk
aW8tcGNpLWludGVsLXRnbCAwMDAwOjAwOjFmLjM6IHVua25vd24gc29mX2V4dF9tYW4gaGVh
ZGVyIHR5cGUgMyBzaXplIDB4MzAKWyAgICA4LjQwODg2OV0gc29mLWF1ZGlvLXBjaS1pbnRl
bC10Z2wgMDAwMDowMDoxZi4zOiBGaXJtd2FyZSBpbmZvOiB2ZXJzaW9uIDI6MDowLWI2Nzhh
ClsgICAgOC40MDg4NzNdIHNvZi1hdWRpby1wY2ktaW50ZWwtdGdsIDAwMDA6MDA6MWYuMzog
RmlybXdhcmU6IEFCSSAzOjIwOjAgS2VybmVsIEFCSSAzOjIzOjAKWyAgICA4LjQxMzI3OF0g
c29mLWF1ZGlvLXBjaS1pbnRlbC10Z2wgMDAwMDowMDoxZi4zOiBUb3BvbG9neTogQUJJIDM6
MjA6MCBLZXJuZWwgQUJJIDM6MjM6MApbICAgIDguNDEzNDUxXSBza2xfaGRhX2RzcF9nZW5l
cmljIHNrbF9oZGFfZHNwX2dlbmVyaWM6IEFTb0M6IFBhcmVudCBjYXJkIG5vdCB5ZXQgYXZh
aWxhYmxlLCB3aWRnZXQgY2FyZCBiaW5kaW5nIGRlZmVycmVkClsgICAgOC40MzI1NzBdIHNu
ZF9oZGFfY29kZWNfcmVhbHRlayBlaGRhdWRpbzBEMDogYXV0b2NvbmZpZyBmb3IgQUxDMjQ1
OiBsaW5lX291dHM9MSAoMHgxNy8weDAvMHgwLzB4MC8weDApIHR5cGU6c3BlYWtlcgpbICAg
IDguNDMyNTc1XSBzbmRfaGRhX2NvZGVjX3JlYWx0ZWsgZWhkYXVkaW8wRDA6ICAgIHNwZWFr
ZXJfb3V0cz0wICgweDAvMHgwLzB4MC8weDAvMHgwKQpbICAgIDguNDMyNTc3XSBzbmRfaGRh
X2NvZGVjX3JlYWx0ZWsgZWhkYXVkaW8wRDA6ICAgIGhwX291dHM9MSAoMHgyMS8weDAvMHgw
LzB4MC8weDApClsgICAgOC40MzI1NzldIHNuZF9oZGFfY29kZWNfcmVhbHRlayBlaGRhdWRp
bzBEMDogICAgbW9ubzogbW9ub19vdXQ9MHgwClsgICAgOC40MzI1ODBdIHNuZF9oZGFfY29k
ZWNfcmVhbHRlayBlaGRhdWRpbzBEMDogICAgaW5wdXRzOgpbICAgIDguNDMyNTgxXSBzbmRf
aGRhX2NvZGVjX3JlYWx0ZWsgZWhkYXVkaW8wRDA6ICAgICAgTWljPTB4MTkKWyAgICA4LjQ4
MDI3Nl0gc25kX2hkYV9jb2RlY19yZWFsdGVrIGVoZGF1ZGlvMEQwOiBBU29DOiBzaW5rIHdp
ZGdldCBBSUYxVFggb3ZlcndyaXR0ZW4KWyAgICA4LjQ4MDI4NF0gc25kX2hkYV9jb2RlY19y
ZWFsdGVrIGVoZGF1ZGlvMEQwOiBBU29DOiBzb3VyY2Ugd2lkZ2V0IEFJRjFSWCBvdmVyd3Jp
dHRlbgpbICAgIDguNDgwNDEzXSBza2xfaGRhX2RzcF9nZW5lcmljIHNrbF9oZGFfZHNwX2dl
bmVyaWM6IEFTb0M6IHNpbmsgd2lkZ2V0IGhpZmkzIG92ZXJ3cml0dGVuClsgICAgOC40ODA0
MThdIHNrbF9oZGFfZHNwX2dlbmVyaWMgc2tsX2hkYV9kc3BfZ2VuZXJpYzogQVNvQzogc2lu
ayB3aWRnZXQgaGlmaTIgb3ZlcndyaXR0ZW4KWyAgICA4LjQ4MDQyMl0gc2tsX2hkYV9kc3Bf
Z2VuZXJpYyBza2xfaGRhX2RzcF9nZW5lcmljOiBBU29DOiBzaW5rIHdpZGdldCBoaWZpMSBv
dmVyd3JpdHRlbgpbICAgIDguNDgwNDI2XSBza2xfaGRhX2RzcF9nZW5lcmljIHNrbF9oZGFf
ZHNwX2dlbmVyaWM6IEFTb0M6IHNvdXJjZSB3aWRnZXQgQ29kZWMgT3V0cHV0IFBpbjEgb3Zl
cndyaXR0ZW4KWyAgICA4LjQ4MDQyOV0gc2tsX2hkYV9kc3BfZ2VuZXJpYyBza2xfaGRhX2Rz
cF9nZW5lcmljOiBBU29DOiBzaW5rIHdpZGdldCBDb2RlYyBJbnB1dCBQaW4xIG92ZXJ3cml0
dGVuClsgICAgOC40ODA0MzRdIHNrbF9oZGFfZHNwX2dlbmVyaWMgc2tsX2hkYV9kc3BfZ2Vu
ZXJpYzogQVNvQzogc2luayB3aWRnZXQgQW5hbG9nIENvZGVjIFBsYXliYWNrIG92ZXJ3cml0
dGVuClsgICAgOC40ODA0MzldIHNrbF9oZGFfZHNwX2dlbmVyaWMgc2tsX2hkYV9kc3BfZ2Vu
ZXJpYzogQVNvQzogc2luayB3aWRnZXQgRGlnaXRhbCBDb2RlYyBQbGF5YmFjayBvdmVyd3Jp
dHRlbgpbICAgIDguNDgwNDQzXSBza2xfaGRhX2RzcF9nZW5lcmljIHNrbF9oZGFfZHNwX2dl
bmVyaWM6IEFTb0M6IHNpbmsgd2lkZ2V0IEFsdCBBbmFsb2cgQ29kZWMgUGxheWJhY2sgb3Zl
cndyaXR0ZW4KWyAgICA4LjQ4MDQ0OV0gc2tsX2hkYV9kc3BfZ2VuZXJpYyBza2xfaGRhX2Rz
cF9nZW5lcmljOiBBU29DOiBzb3VyY2Ugd2lkZ2V0IEFuYWxvZyBDb2RlYyBDYXB0dXJlIG92
ZXJ3cml0dGVuClsgICAgOC40ODA0NTNdIHNrbF9oZGFfZHNwX2dlbmVyaWMgc2tsX2hkYV9k
c3BfZ2VuZXJpYzogQVNvQzogc291cmNlIHdpZGdldCBEaWdpdGFsIENvZGVjIENhcHR1cmUg
b3ZlcndyaXR0ZW4KWyAgICA4LjQ4MDQ1OF0gc2tsX2hkYV9kc3BfZ2VuZXJpYyBza2xfaGRh
X2RzcF9nZW5lcmljOiBBU29DOiBzb3VyY2Ugd2lkZ2V0IEFsdCBBbmFsb2cgQ29kZWMgQ2Fw
dHVyZSBvdmVyd3JpdHRlbgpbICAgIDguNDgwNDY3XSBza2xfaGRhX2RzcF9nZW5lcmljIHNr
bF9oZGFfZHNwX2dlbmVyaWM6IGhkYV9kc3BfaGRtaV9idWlsZF9jb250cm9sczogbm8gUENN
IGluIHRvcG9sb2d5IGZvciBIRE1JIGNvbnZlcnRlciAzClsgICAgOC40OTc2ODNdIGlucHV0
OiBzb2YtaGRhLWRzcCBNaWMgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFmLjMv
c2tsX2hkYV9kc3BfZ2VuZXJpYy9zb3VuZC9jYXJkMS9pbnB1dDI3ClsgICAgOC40OTc3MThd
IGlucHV0OiBzb2YtaGRhLWRzcCBIZWFkcGhvbmUgYXMgL2RldmljZXMvcGNpMDAwMDowMC8w
MDAwOjAwOjFmLjMvc2tsX2hkYV9kc3BfZ2VuZXJpYy9zb3VuZC9jYXJkMS9pbnB1dDI4Clsg
ICAgOC40OTc3NDFdIGlucHV0OiBzb2YtaGRhLWRzcCBIRE1JL0RQLHBjbT0zIGFzIC9kZXZp
Y2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZi4zL3NrbF9oZGFfZHNwX2dlbmVyaWMvc291bmQv
Y2FyZDEvaW5wdXQyOQpbICAgIDguNDk3NzY5XSBpbnB1dDogc29mLWhkYS1kc3AgSERNSS9E
UCxwY209NCBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWYuMy9za2xfaGRhX2Rz
cF9nZW5lcmljL3NvdW5kL2NhcmQxL2lucHV0MzAKWyAgICA4LjQ5Nzc5MF0gaW5wdXQ6IHNv
Zi1oZGEtZHNwIEhETUkvRFAscGNtPTUgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAw
OjFmLjMvc2tsX2hkYV9kc3BfZ2VuZXJpYy9zb3VuZC9jYXJkMS9pbnB1dDMxClsgICAgOS43
NzkzODddIGUxMDAwZSAwMDAwOjAwOjFmLjYgZW5wMHMzMWY2OiBOSUMgTGluayBpcyBVcCAx
MDAgTWJwcyBGdWxsIER1cGxleCwgRmxvdyBDb250cm9sOiBSeC9UeApbICAgMTMuNjA3NDIz
XSBrYXVkaXRkX3ByaW50a19za2I6IDM4IGNhbGxiYWNrcyBzdXBwcmVzc2VkClsgICAxMy42
MDc0MjVdIGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTcwMDU4NzkwNS4zMTY6NDkpOiBhcHBh
cm1vcj0iREVOSUVEIiBvcGVyYXRpb249ImNhcGFibGUiIGNsYXNzPSJjYXAiIHByb2ZpbGU9
Ii9zbmFwL3NuYXBkLzIwMjkwL3Vzci9saWIvc25hcGQvc25hcC1jb25maW5lIiBwaWQ9MTM5
MyBjb21tPSJzbmFwLWNvbmZpbmUiIGNhcGFiaWxpdHk9MTIgIGNhcG5hbWU9Im5ldF9hZG1p
biIKWyAgIDEzLjYwNzQyOF0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzAwNTg3OTA1LjMx
Njo1MCk6IGFwcGFybW9yPSJERU5JRUQiIG9wZXJhdGlvbj0iY2FwYWJsZSIgY2xhc3M9ImNh
cCIgcHJvZmlsZT0iL3NuYXAvc25hcGQvMjAyOTAvdXNyL2xpYi9zbmFwZC9zbmFwLWNvbmZp
bmUiIHBpZD0xMzkzIGNvbW09InNuYXAtY29uZmluZSIgY2FwYWJpbGl0eT0zOCAgY2FwbmFt
ZT0icGVyZm1vbiIKWyAgIDEzLjYzMDExNl0gQmx1ZXRvb3RoOiBSRkNPTU0gVFRZIGxheWVy
IGluaXRpYWxpemVkClsgICAxMy42MzAxMjJdIEJsdWV0b290aDogUkZDT01NIHNvY2tldCBs
YXllciBpbml0aWFsaXplZApbICAgMTMuNjMwMTI1XSBCbHVldG9vdGg6IFJGQ09NTSB2ZXIg
MS4xMQpbICAgMTYuNDQ2OTA0XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3MDA1ODc5MDgu
MTU2OjUxKTogYXBwYXJtb3I9IkRFTklFRCIgb3BlcmF0aW9uPSJjYXBhYmxlIiBjbGFzcz0i
Y2FwIiBwcm9maWxlPSIvc25hcC9zbmFwZC8yMDI5MC91c3IvbGliL3NuYXBkL3NuYXAtY29u
ZmluZSIgcGlkPTE2NzQgY29tbT0ic25hcC1jb25maW5lIiBjYXBhYmlsaXR5PTEyICBjYXBu
YW1lPSJuZXRfYWRtaW4iClsgICAxNi40NDY5MTddIGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQo
MTcwMDU4NzkwOC4xNTY6NTIpOiBhcHBhcm1vcj0iREVOSUVEIiBvcGVyYXRpb249ImNhcGFi
bGUiIGNsYXNzPSJjYXAiIHByb2ZpbGU9Ii9zbmFwL3NuYXBkLzIwMjkwL3Vzci9saWIvc25h
cGQvc25hcC1jb25maW5lIiBwaWQ9MTY3NCBjb21tPSJzbmFwLWNvbmZpbmUiIGNhcGFiaWxp
dHk9MzggIGNhcG5hbWU9InBlcmZtb24iClsgICAxOC43MDg5ODldIGF1ZGl0OiB0eXBlPTE0
MDAgYXVkaXQoMTcwMDU4NzkxMC40MTY6NTMpOiBhcHBhcm1vcj0iREVOSUVEIiBvcGVyYXRp
b249ImNhcGFibGUiIGNsYXNzPSJjYXAiIHByb2ZpbGU9Ii9zbmFwL3NuYXBkLzIwMjkwL3Vz
ci9saWIvc25hcGQvc25hcC1jb25maW5lIiBwaWQ9MTc1MSBjb21tPSJzbmFwLWNvbmZpbmUi
IGNhcGFiaWxpdHk9MTIgIGNhcG5hbWU9Im5ldF9hZG1pbiIKWyAgIDE4LjcwOTAwNF0gYXVk
aXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzAwNTg3OTEwLjQxNjo1NCk6IGFwcGFybW9yPSJERU5J
RUQiIG9wZXJhdGlvbj0iY2FwYWJsZSIgY2xhc3M9ImNhcCIgcHJvZmlsZT0iL3NuYXAvc25h
cGQvMjAyOTAvdXNyL2xpYi9zbmFwZC9zbmFwLWNvbmZpbmUiIHBpZD0xNzUxIGNvbW09InNu
YXAtY29uZmluZSIgY2FwYWJpbGl0eT0zOCAgY2FwbmFtZT0icGVyZm1vbiIKWyAgIDIwLjk2
MDQ3OV0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzAwNTg3OTEyLjY2ODo1NSk6IGFwcGFy
bW9yPSJERU5JRUQiIG9wZXJhdGlvbj0iY2FwYWJsZSIgY2xhc3M9ImNhcCIgcHJvZmlsZT0i
L3NuYXAvc25hcGQvMjAyOTAvdXNyL2xpYi9zbmFwZC9zbmFwLWNvbmZpbmUiIHBpZD0xODI3
IGNvbW09InNuYXAtY29uZmluZSIgY2FwYWJpbGl0eT0xMiAgY2FwbmFtZT0ibmV0X2FkbWlu
IgpbICAgMjAuOTYwNDg5XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3MDA1ODc5MTIuNjY4
OjU2KTogYXBwYXJtb3I9IkRFTklFRCIgb3BlcmF0aW9uPSJjYXBhYmxlIiBjbGFzcz0iY2Fw
IiBwcm9maWxlPSIvc25hcC9zbmFwZC8yMDI5MC91c3IvbGliL3NuYXBkL3NuYXAtY29uZmlu
ZSIgcGlkPTE4MjcgY29tbT0ic25hcC1jb25maW5lIiBjYXBhYmlsaXR5PTM4ICBjYXBuYW1l
PSJwZXJmbW9uIgpbICAgMjMuMjAzODIzXSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3MDA1
ODc5MTQuOTEyOjU3KTogYXBwYXJtb3I9IkRFTklFRCIgb3BlcmF0aW9uPSJjYXBhYmxlIiBj
bGFzcz0iY2FwIiBwcm9maWxlPSIvc25hcC9zbmFwZC8yMDI5MC91c3IvbGliL3NuYXBkL3Nu
YXAtY29uZmluZSIgcGlkPTE5MDUgY29tbT0ic25hcC1jb25maW5lIiBjYXBhYmlsaXR5PTEy
ICBjYXBuYW1lPSJuZXRfYWRtaW4iClsgICAyMy4yMDM4MzNdIGF1ZGl0OiB0eXBlPTE0MDAg
YXVkaXQoMTcwMDU4NzkxNC45MTI6NTgpOiBhcHBhcm1vcj0iREVOSUVEIiBvcGVyYXRpb249
ImNhcGFibGUiIGNsYXNzPSJjYXAiIHByb2ZpbGU9Ii9zbmFwL3NuYXBkLzIwMjkwL3Vzci9s
aWIvc25hcGQvc25hcC1jb25maW5lIiBwaWQ9MTkwNSBjb21tPSJzbmFwLWNvbmZpbmUiIGNh
cGFiaWxpdHk9MzggIGNhcG5hbWU9InBlcmZtb24iClsgICAyNC4wNjg2ODZdIGk5MTUgMDAw
MDowMDowMi4wOiBbZHJtXSAqRVJST1IqIEZhaWxlZCB0byBzZW5kIFBYUCBURUUgbWVzc2Fn
ZQpbICAgMjQuOTIxMjkyXSByZmtpbGw6IGlucHV0IGhhbmRsZXIgZGlzYWJsZWQKWyAgIDI1
LjMwNDg3MF0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzAwNTg3OTE3LjAxMjo1OSk6IGFw
cGFybW9yPSJERU5JRUQiIG9wZXJhdGlvbj0iY2FwYWJsZSIgY2xhc3M9ImNhcCIgcHJvZmls
ZT0iL3NuYXAvc25hcGQvMjAyOTAvdXNyL2xpYi9zbmFwZC9zbmFwLWNvbmZpbmUiIHBpZD0y
NDA0IGNvbW09InNuYXAtY29uZmluZSIgY2FwYWJpbGl0eT0xMiAgY2FwbmFtZT0ibmV0X2Fk
bWluIgpbICAgMjUuMzA0ODg1XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3MDA1ODc5MTcu
MDEyOjYwKTogYXBwYXJtb3I9IkRFTklFRCIgb3BlcmF0aW9uPSJjYXBhYmxlIiBjbGFzcz0i
Y2FwIiBwcm9maWxlPSIvc25hcC9zbmFwZC8yMDI5MC91c3IvbGliL3NuYXBkL3NuYXAtY29u
ZmluZSIgcGlkPTI0MDQgY29tbT0ic25hcC1jb25maW5lIiBjYXBhYmlsaXR5PTM4ICBjYXBu
YW1lPSJwZXJmbW9uIgpbICAgMjkuMjcwOTcyXSBtZWlfcHhwIDAwMDA6MDA6MTYuMC1mYmY2
ZmNmMS05NmNmLTRlMmUtYTZhNi0xYmFiOGNiZTM2YjE6IFRyeWluZyB0byByZXNldCB0aGUg
Y2hhbm5lbC4uLgpbICAgMjkuMjcyMDcxXSBpOTE1IDAwMDA6MDA6MDIuMDogW2RybV0gKkVS
Uk9SKiBGYWlsZWQgdG8gc2VuZCBQWFAgVEVFIG1lc3NhZ2UKWyAgIDI5LjI3NDY4Nl0gaTkx
NSAwMDAwOjAwOjAyLjA6IFtkcm1dICpFUlJPUiogRmFpbGVkIHRvIHNlbmQgUFhQIFRFRSBt
ZXNzYWdlClsgICAyOS4yNzQ2OTZdIGk5MTUgMDAwMDowMDowMi4wOiBbZHJtXSAqRVJST1Iq
IEZhaWxlZCB0byBzZW5kIHRlZSBtc2cgZm9yIGludi1zdHJlYW0ta2V5LTE1LCByZXQ9WzI4
XQpbICAgMzQuMzkwNjgzXSBtZWlfcHhwIDAwMDA6MDA6MTYuMC1mYmY2ZmNmMS05NmNmLTRl
MmUtYTZhNi0xYmFiOGNiZTM2YjE6IFRyeWluZyB0byByZXNldCB0aGUgY2hhbm5lbC4uLgpb
ICAgMzQuMzkxNzUwXSBpOTE1IDAwMDA6MDA6MDIuMDogW2RybV0gKkVSUk9SKiBGYWlsZWQg
dG8gc2VuZCBQWFAgVEVFIG1lc3NhZ2UKWyAgIDM0LjM5MTc3Ml0gaTkxNSAwMDAwOjAwOjAy
LjA6IFtkcm1dICpFUlJPUiogRmFpbGVkIHRvIHNlbmQgdGVlIG1zZyBpbml0IGFyYiBzZXNz
aW9uLCByZXQ9Wy02Ml0KWyAgIDM0LjM5MTc3OF0gaTkxNSAwMDAwOjAwOjAyLjA6IFtkcm1d
ICpFUlJPUiogdGVlIGNtZCBmb3IgYXJiIHNlc3Npb24gY3JlYXRpb24gZmFpbGVkCg==

--------------XtTI47P0lSXzOpt1a7UfDNYn--
