Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A3D80C01B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjLKDoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 22:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLKDoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 22:44:18 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AB1F1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 19:44:23 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50be3611794so4644570e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 19:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702266262; x=1702871062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/vqeWpmuaC2GKHcpPmHJB7dDJL1y38uQQZMJmxyCF0=;
        b=z43b3XoggtMMluh+vm98LBwUQruY1XMaAJCw7TLfN11qV7fEhF5OMWWeCKugDQM3DJ
         6b3so7YsKa5e70GpwANnLC6dzwNm3ZlLL6ZOxMM7CyHnke6w4qJw/qnEKRv0IEqCWy+2
         t/luV7VptNzRulzdqiwt7jRPAJvkfYjvWEmeOuF7Cm0ifg43cpYhOqr0LgSW9gtW5fj5
         IOPk+otd7orMmVcQUftPXmPzAe4G9+bCc6GOxfSBcMC3X+Ox+Mq8dIn0FTFaVm0S6OUu
         JLozc3Ij6QsMND5ypBrvy6J79U3RyLfBfHVQR+W/mVeXWm6iiWC4WYs41dOjaQfmqnwI
         5oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702266262; x=1702871062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/vqeWpmuaC2GKHcpPmHJB7dDJL1y38uQQZMJmxyCF0=;
        b=o6p2DsfRWndEBM38gpo/gP3mhFCAv82HkydNXf4HQesHZq1uqcGFIAm36/5fUTV1fR
         ba0wguihH1BY0RnQgYjWDc072EhWDbxhkIP4bJyXFEPev/NP4GYGQ6RNp2kkwLZDdcHi
         eOKG3m+vkgxa3YCx5J4G6E493i0JipKk3eB5EPVXN8obkQ5Y016Hib9Gkj9BDYHit3y+
         hsbLvl8x8Ak7NyVMIueFvVtZ/MRrXKoh3Yg6SQrsLwsnGRjkHDIS7rEelL6KP9xtcKtY
         bz4rqEWCBJbdnQTKRsXBpXJ8zjEIBQrFmET/AvtDQ7Z311ffs2oNyhnyGoYfweSZvVvv
         u46w==
X-Gm-Message-State: AOJu0Yw0W8S43JEESLzSOto97FOKOsOJq8SSu9lC/SJOqtozr0tDAmX8
        rSA7Y0uniGW46D5vAH61Jghr0w==
X-Google-Smtp-Source: AGHT+IF5PtBpY6xhcdNz9G3vVrurxD3qF8aQpcfrWHvhTTpJjLx5LRR48o/Ym5kxD82928DzeICIlg==
X-Received: by 2002:ac2:562c:0:b0:50b:fd06:1c8a with SMTP id b12-20020ac2562c000000b0050bfd061c8amr1341405lff.26.1702266261661;
        Sun, 10 Dec 2023 19:44:21 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id w2-20020a50d782000000b0054cceab1940sm3269357edi.29.2023.12.10.19.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 19:44:20 -0800 (PST)
Message-ID: <2cadfffa-00bf-4e6a-bfce-9cc654b042a1@linaro.org>
Date:   Mon, 11 Dec 2023 03:44:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Content-Language: en-US
To:     "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
        "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
 <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
 <9f577482-30d9-4e1d-9469-812d323b18c6@linaro.org>
 <BN7PR12MB2802C8279CA95FA08F8DDCF2DC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <BN7PR12MB2802C8279CA95FA08F8DDCF2DC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/23 17:06, Mahapatra, Amit Kumar wrote:
> Hello Tudor,

Hi!

> 
>> -----Original Message-----
>> From: Tudor Ambarus <tudor.ambarus@linaro.org>
>> Sent: Wednesday, December 6, 2023 8:14 PM
>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
>> broonie@kernel.org; pratyush@kernel.org; miquel.raynal@bootlin.com;
>> richard@nod.at; vigneshr@ti.com; sbinding@opensource.cirrus.com;
>> lee@kernel.org; james.schulman@cirrus.com; david.rhodes@cirrus.com;
>> rf@opensource.cirrus.com; perex@perex.cz; tiwai@suse.com
>> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
>> michael@walle.cc; linux-mtd@lists.infradead.org;
>> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
>> claudiu.beznea@tuxon.dev; Simek, Michal <michal.simek@amd.com>; linux-
>> arm-kernel@lists.infradead.org; alsa-devel@alsa-project.org;
>> patches@opensource.cirrus.com; linux-sound@vger.kernel.org; git (AMD-
>> Xilinx) <git@amd.com>; amitrkcian2002@gmail.com
>> Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support
>> in spi-nor
>>
>>
>>
>> On 12/6/23 14:30, Tudor Ambarus wrote:
>>> Hi, Amit,
>>>
>>> On 11/25/23 09:21, Amit Kumar Mahapatra wrote:
>>>> Each flash that is connected in stacked mode should have a separate
>>>> parameter structure. So, the flash parameter member(*params) of the
>>>> spi_nor structure is changed to an array (*params[2]). The array is
>>>> used to store the parameters of each flash connected in stacked
>> configuration.
>>>>
>>>> The current implementation assumes that a maximum of two flashes are
>>>> connected in stacked mode and both the flashes are of same make but
>>>> can differ in sizes. So, except the sizes all other flash parameters
>>>> of both the flashes are identical.
>>>
>>> Do you plan to add support for different flashes in stacked mode? If
>>> not, wouldn't it be simpler to have just an array of flash sizes
>>> instead of duplicating the entire params struct?
>>>
>>>>
>>>> SPI-NOR is not aware of the chip_select values, for any incoming
>>>> request SPI-NOR will decide the flash index with the help of
>>>> individual flash size and the configuration type (single/stacked).
>>>> SPI-NOR will pass on the flash index information to the SPI core &
>>>> SPI driver by setting the appropriate bit in
>>>> nor->spimem->spi->cs_index_mask. For example, if nth bit of
>>>> nor->spimem->spi->cs_index_mask is set then the driver would
>>>> assert/de-assert spi->chip_slect[n].
>>>>
>>>> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-
>> mahapatra@amd.com>
>>>> ---
>>>>  drivers/mtd/spi-nor/core.c  | 272 +++++++++++++++++++++++++++++-------
>>>>  drivers/mtd/spi-nor/core.h  |   4 +
>>>>  include/linux/mtd/spi-nor.h |  15 +-
>>>>  3 files changed, 240 insertions(+), 51 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>>> index 93ae69b7ff83..e990be7c7eb6 100644
>>>> --- a/drivers/mtd/spi-nor/core.c
>>>> +++ b/drivers/mtd/spi-nor/core.c
>>>
>>> cut
>>>
>>>> @@ -2905,7 +3007,10 @@ static void spi_nor_init_fixup_flags(struct
>>>> spi_nor *nor)  static int spi_nor_late_init_params(struct spi_nor
>>>> *nor)  {
>>>>  	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor,
>> 0);
>>>> -	int ret;
>>>> +	struct device_node *np = spi_nor_get_flash_node(nor);
>>>> +	u64 flash_size[SNOR_FLASH_CNT_MAX];
>>>> +	u32 idx = 0;
>>>> +	int rc, ret;
>>>>
>>>>  	if (nor->manufacturer && nor->manufacturer->fixups &&
>>>>  	    nor->manufacturer->fixups->late_init) { @@ -2937,6 +3042,44 @@
>>>> static int spi_nor_late_init_params(struct spi_nor *nor)
>>>>  	if (params->n_banks > 1)
>>>>  		params->bank_size = div64_u64(params->size, params-
>>> n_banks);
>>>>
>>>> +	nor->num_flash = 0;
>>>> +
>>>> +	/*
>>>> +	 * The flashes that are connected in stacked mode should be of same
>> make.
>>>> +	 * Except the flash size all other properties are identical for all the
>>>> +	 * flashes connected in stacked mode.
>>>> +	 * The flashes that are connected in parallel mode should be identical.
>>>> +	 */
>>>> +	while (idx < SNOR_FLASH_CNT_MAX) {
>>>> +		rc = of_property_read_u64_index(np, "stacked-memories",
>> idx,
>>>> +&flash_size[idx]);
>>
>> also, it's not clear to me why you read this property multiple times.
>> Have you sent a device tree patch somewhere? It will help me understand
>> what you're trying to achieve.
> 
> Miquel submitted the device tree patch; here is the series.
> https://lore.kernel.org/all/20220126112608.955728-1-miquel.raynal@bootlin.com/
> 

oh, yes, I remember seeing this on the ml, but I couldn't allocate time
to review it. Looking at:
https://lore.kernel.org/all/20220126112608.955728-4-miquel.raynal@bootlin.com/

Flash size is not necessary for SPI NORs, as it can be discovered via
SFDP. And spi-max-frequency should have been specified for all flashes,
as I expect it can differ. At least so that the controller chooses the
minimum frequency from all the max (if it can't operate the stacks at
different frequencies).

Cheers,
ta
