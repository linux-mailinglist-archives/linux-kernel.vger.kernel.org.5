Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8087659D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjG0RRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjG0RR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:17:29 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D23AF7;
        Thu, 27 Jul 2023 10:17:28 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-348c47ca963so4546185ab.0;
        Thu, 27 Jul 2023 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690478248; x=1691083048;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+y+p/lZ0A7TPbjqRqcdjde8B6RMpTawfHps5YA67cyw=;
        b=qKXQnzBTqsSsjIOM4Gqwp8pIRNsE4QGSA8981WiZp6RfpfIgs5lcCkCwi7NfIlCUcx
         Xd2ghiF/nMCDQGb1MuJBs9tUaj46Xl2HPf3Jt67dHyYmcDq73JLVAK4Zl9y/QbUIebs1
         zG0BtRdYvvruxS0Zekd0P2IzDD04sIfmYJ1FS8pTX3qAw5bHgX1ENsXXMg3UpWi7oxul
         CVYEwuvJ1rziLb8gzMp+BcA6lE/QG8STaZMsQwQ1F7YaXcZz4WuYdGa0s+pDToGEl24X
         LQo1PukK8E/cTU+E1TY2TjO8/7N2oChVLJvDJ/gJIArwJlrClYHOukpdWPqVqLsdCrEz
         JMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690478248; x=1691083048;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+y+p/lZ0A7TPbjqRqcdjde8B6RMpTawfHps5YA67cyw=;
        b=OyVq6Un7ZzHUrf1h5NJNXFbdY6zBbksSaue456dxkicfsDl95wU8Aah+/KU9bXcy6p
         UvgvIXQbdJqJcQA6K/t2DvFq2vTeITxDnG/3aWquWGa1FlfxaOad8la1lIrlXei2ib+z
         SUByIJiiVRQP370iTwstKQ3+b7/aUEhBH+I90E6uvV+MfsMgO8D7+YELK43/+AyytFhN
         K7scZyM+QE+2QrfSYZcbrOjXp5zqgFEiGR1vfQkfNy6ugWID8UdP4/Uvg74DbmU/hquO
         8t1tjX19QiSDPWn2xHyiupJin1F4lHFXiCq19MKbFmgyImvPwjL4rJ/z0nFZCgeGa2jH
         SUIw==
X-Gm-Message-State: ABy/qLZBrBLBWwOCOZMbkIgiCntGsb3hhhxYXHacHb1EME2PWo8EyhSs
        3pkV3wlkjkHq2aw9/HYmNnU=
X-Google-Smtp-Source: APBJJlFKvDRxj4T5hYYHqck5VsvJU1STUkWcYDxH+py9wod67e56mJZSry89eXBCUzgkmKDOAe1VoA==
X-Received: by 2002:a05:6e02:eef:b0:348:936f:820f with SMTP id j15-20020a056e020eef00b00348936f820fmr41539ilk.16.1690478247729;
        Thu, 27 Jul 2023 10:17:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m16-20020a92c530000000b003488ded11edsm610674ili.11.2023.07.27.10.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 10:17:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d21d005d-569d-6105-e89c-7e6a7e84c701@roeck-us.net>
Date:   Thu, 27 Jul 2023 10:17:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Baskaran Kannan <Baski.Kannan@amd.com>, babu.moger@amd.com,
        Mario.Limonciello@amd.com, clemens@ladisch.de, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727162159.1056136-1-Baski.Kannan@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4] hwmon: (k10temp) Enable AMD3255 Proc to show negative
 temperature
In-Reply-To: <20230727162159.1056136-1-Baski.Kannan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 09:21, Baskaran Kannan wrote:
> Industrial processor i3255 supports temperatures -40 deg celcius
> to 105 deg Celcius. The current implementation of k10temp_read_temp
> rounds off any negative temperatures to '0'. To fix this,
> the following changes have been made.
> 
> A flag 'disp_negative' is added to struct k10temp_data to support
> AMD i3255 processors. Flag 'disp_negative' is set if 3255 processor
> is found during k10temp_probe.  Flag 'disp_negative' is used to
> determine whether to round off negative temperatures to '0' in
> k10temp_read_temp.
> 
> Signed-off-by: Baskaran Kannan <Baski.Kannan@amd.com>
> ---
> V4: Changed probe from model number to model id.
> V3: https://lore.kernel.org/all/20230619165413.806450-1-Baski.Kannan@amd.com/
> 
>   drivers/hwmon/k10temp.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 7b177b9fbb09..18c4deae82ba 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -77,6 +77,12 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>   #define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
>   #define ZEN_CUR_TEMP_TJ_SEL_MASK		GENMASK(17, 16)
>   
> +/* AMD's Industrial processor 3255 supports temperature from -40 deg to 105 deg Celsius.
> + * Use the model name to identify 3255 CPUs and set a flag to display negative temperature.
> + * Do not round off to zero for negative Tctl or Tdie values if the flag is set
> + */

This is not the networking subsystem. Please use standard multi-line comments.
Never mind, applied after fixing the comment style.

Guenter

> +#define AMD_I3255_STR				"3255"
> +
>   struct k10temp_data {
>   	struct pci_dev *pdev;
>   	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
> @@ -86,6 +92,7 @@ struct k10temp_data {
>   	u32 show_temp;
>   	bool is_zen;
>   	u32 ccd_offset;
> +	bool disp_negative;
>   };
>   
>   #define TCTL_BIT	0
> @@ -204,12 +211,12 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>   		switch (channel) {
>   		case 0:		/* Tctl */
>   			*val = get_raw_temp(data);
> -			if (*val < 0)
> +			if (*val < 0 && !data->disp_negative)
>   				*val = 0;
>   			break;
>   		case 1:		/* Tdie */
>   			*val = get_raw_temp(data) - data->temp_offset;
> -			if (*val < 0)
> +			if (*val < 0 && !data->disp_negative)
>   				*val = 0;
>   			break;
>   		case 2 ... 13:		/* Tccd{1-12} */
> @@ -405,6 +412,11 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	data->pdev = pdev;
>   	data->show_temp |= BIT(TCTL_BIT);	/* Always show Tctl */
>   
> +	if (boot_cpu_data.x86 == 0x17 &&
> +	    strstr(boot_cpu_data.x86_model_id, AMD_I3255_STR)) {
> +		data->disp_negative = true;
> +	}
> +
>   	if (boot_cpu_data.x86 == 0x15 &&
>   	    ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
>   	     (boot_cpu_data.x86_model & 0xf0) == 0x70)) {

