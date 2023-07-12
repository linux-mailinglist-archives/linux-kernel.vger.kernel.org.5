Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB468751023
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGLR6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjGLR6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:58:09 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718A8199E;
        Wed, 12 Jul 2023 10:58:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6726d5d92afso693096b3a.1;
        Wed, 12 Jul 2023 10:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689184687; x=1691776687;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pny1aYjNXYFl78WbEOF0DtXJPo5MK8VKFPATPLc74sA=;
        b=sLvNEi+z4hHGnMamq7u+RTz0umPhBTkcwyH3v6+/86E/tfk3l+/rC/am7ydF8lp+JY
         UzsIZEuiDP1cUSeL0rtLic7hz9KsYMGUu6bNkkpqOXWTti8jlH5QNL6FQBRcsWznTuGx
         9ykD2KWrf2KzpnGec2DjpYrggKWRKBGQjPFl2A1Bo56P53omGf64z2fz29apHNh5QOto
         7GpZecFfJLIOudkB4IFHtoafr2wIzkKNJpUV4T8SZs2a21Kt6WiTHmuqy6ETcIWcCSjJ
         IBZvqt8MVsxfeoR5tWhQ0sC8LA9Spg9w19DURZ8NrBJHAkFtW2Qw/hIC/RP/4IDuc7VA
         egDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689184687; x=1691776687;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pny1aYjNXYFl78WbEOF0DtXJPo5MK8VKFPATPLc74sA=;
        b=Lbzmy9FG4ol2hl3XL88cS8hHuqHqUbSUQTNYEmVm6lKiCvQpJ1FvnJVnTHW37olm3C
         hEa/Hhd7R5xBPgeHoiBDQbFoc0QqO4tpX66OFgxmVIpx0wAytamKHmUudBjZw4pLN2sX
         EoRR6He41H6TV9iSXs20O+04tCFGhP7lzbRq1CpjV0QmLtcTbBTIN2IqvOaYVxNvNxTV
         5xaK8GTIxvjtcR31AXwScDEjK3kACU8rTfJfx8rFjHcTgv3SQUZz2Zd6ymZDF1bSb+d2
         VD7mZhbwaH8xZfOKtWN6+kTD3OzYH3ZeA1T8TRDPJgSN4FcA7crGbsh2zIkBhHEAS5X9
         sYkA==
X-Gm-Message-State: ABy/qLaJuPLQg1Tw1dk1dheyioJoGREtoFjP4Rk6jg7s2gwEOwPWj+gO
        gDuBhRe4Axl8VksI4J047Nggh0vToL0=
X-Google-Smtp-Source: APBJJlFT01LHPaI9H6TatqoxUSnUeJ2G49ygoCTnDZNrhBgG9UKYUbnAtweP85MwzqdTvlP5xlFT0g==
X-Received: by 2002:a17:902:708a:b0:1b8:76d1:f1e8 with SMTP id z10-20020a170902708a00b001b876d1f1e8mr2799494plk.28.1689184686635;
        Wed, 12 Jul 2023 10:58:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090274c900b001b9df8f2907sm4204895plt.264.2023.07.12.10.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 10:58:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <76aa2aa3-1d38-36a2-d664-00b719f37932@roeck-us.net>
Date:   Wed, 12 Jul 2023 10:58:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
 <20230712114754.500477-6-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6/8] hwmon: (pmbus/mp2975) Add support for MP2971 and
 MP2973
In-Reply-To: <20230712114754.500477-6-Naresh.Solanki@9elements.com>
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

On 7/12/23 04:47, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add support for MP2971 and MP2973, the successor of MP2975.
> 
> The major differences are:
>   - On MP2973 and MP2971 the Vref cannot be read and thus most of
>     the OVP/current calculations won't work.
>   - MP2973 and MP2971 also support LINEAR format for VOUT
>   - MP2973 and MP2971 do not support OVP2
>   - On MP2973 and MP2971 most registers are in LINEAR format
>   - The IMVP9_EN bit has a different position
>   - Per phase current sense haven't been implemented.
> 
> As on MP2975 most of the FAULT_LIMIT and WARN_LIMIT registers
> have been redefined and doesn't provide the functionality as
> defined in PMBUS spec.
> 
> Tested on MP2973 and MP2971.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>   drivers/hwmon/pmbus/mp2975.c | 262 +++++++++++++++++++++++++++++------
>   1 file changed, 221 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
> index 13d8b95eb992..83242595ccbe 100644
> --- a/drivers/hwmon/pmbus/mp2975.c
> +++ b/drivers/hwmon/pmbus/mp2975.c
> @@ -35,6 +35,8 @@
>   #define MP2975_MFR_OVP_TH_SET		0xe5
>   #define MP2975_MFR_UVP_SET		0xe6
>   
> +#define MP2973_MFR_RESO_SET		0xc7
> +
>   #define MP2975_VOUT_FORMAT		BIT(15)
>   #define MP2975_VID_STEP_SEL_R1		BIT(4)
>   #define MP2975_IMVP9_EN_R1		BIT(13)
> @@ -49,8 +51,32 @@
>   #define MP2975_SENSE_AMPL_HALF		2
>   #define MP2975_VIN_UV_LIMIT_UNIT	8
>   
> +#define MP2973_VOUT_FORMAT_R1		GENMASK(7, 6)
> +#define MP2973_VOUT_FORMAT_R2		GENMASK(4, 3)
> +#define MP2973_VOUT_FORMAT_DIRECT_R1	BIT(7)
> +#define MP2973_VOUT_FORMAT_LINEAR_R1	BIT(6)
> +#define MP2973_VOUT_FORMAT_DIRECT_R2	BIT(4)
> +#define MP2973_VOUT_FORMAT_LINEAR_R2	BIT(3)
> +
> +#define MP2973_MFR_VR_MULTI_CONFIG_R1	0x0d
> +#define MP2973_MFR_VR_MULTI_CONFIG_R2	0x1d
> +#define MP2973_VID_STEP_SEL_R1		BIT(4)
> +#define MP2973_IMVP9_EN_R1		BIT(14)
> +#define MP2973_VID_STEP_SEL_R2		BIT(3)
> +#define MP2973_IMVP9_EN_R2		BIT(13)
> +
> +#define MP2973_MFR_READ_IOUT_PK		0x90
> +#define MP2973_MFR_READ_POUT_PK		0x91
> +
>   #define MP2975_MAX_PHASE_RAIL1	8
>   #define MP2975_MAX_PHASE_RAIL2	4
> +
> +#define MP2973_MAX_PHASE_RAIL1	14
> +#define MP2973_MAX_PHASE_RAIL2	6
> +
> +#define MP2971_MAX_PHASE_RAIL1	8
> +#define MP2971_MAX_PHASE_RAIL2	3
> +
>   #define MP2975_PAGE_NUM		2
>   
>   #define MP2975_RAIL2_FUNC	(PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT | \
> @@ -58,11 +84,13 @@
>   				 PMBUS_HAVE_POUT | PMBUS_PHASE_VIRTUAL)
>   
>   enum chips {
> -	mp2975
> +	mp2971, mp2973, mp2975
>   };
>   
>   static const int mp2975_max_phases[][MP2975_PAGE_NUM] = {
>   	[mp2975] = { MP2975_MAX_PHASE_RAIL1, MP2975_MAX_PHASE_RAIL2 },
> +	[mp2973] = { MP2973_MAX_PHASE_RAIL1, MP2973_MAX_PHASE_RAIL2 },
> +	[mp2971] = { MP2971_MAX_PHASE_RAIL1, MP2971_MAX_PHASE_RAIL2 },
>   };
>   
>   struct mp2975_data {
> @@ -79,6 +107,8 @@ struct mp2975_data {
>   };
>   
>   static const struct i2c_device_id mp2975_id[] = {
> +	{"mp2971", mp2971},
> +	{"mp2973", mp2973},
>   	{"mp2975", mp2975},
>   	{}
>   };
> @@ -215,6 +245,76 @@ mp2975_read_phases(struct i2c_client *client, struct mp2975_data *data,
>   	return ret;
>   }
>   
> +static int mp2973_read_word_data(struct i2c_client *client, int page,
> +				 int phase, int reg)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct mp2975_data *data = to_mp2975_data(info);
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_OT_FAULT_LIMIT:
> +		ret = mp2975_read_word_helper(client, page, phase, reg,
> +					      GENMASK(7, 0));
> +		break;
> +	case PMBUS_VIN_OV_FAULT_LIMIT:
> +		ret = mp2975_read_word_helper(client, page, phase, reg,
> +					      GENMASK(7, 0));
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = DIV_ROUND_CLOSEST(ret, MP2975_VIN_UV_LIMIT_UNIT);
> +		break;
> +	case PMBUS_VOUT_OV_FAULT_LIMIT:
> +		/*
> +		 * MP2971 and mp2973 only supports tracking (ovp1) mode.
> +		 */
> +		ret = mp2975_read_word_helper(client, page, phase,
> +					      MP2975_MFR_OVP_TH_SET,
> +					      GENMASK(2, 0));
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = data->vout_max[page] + 50 * (ret + 1);
> +		break;
> +	case PMBUS_VOUT_UV_FAULT_LIMIT:
> +		ret = mp2975_read_word_helper(client, page, phase, reg,
> +					      GENMASK(8, 0));
> +		if (ret < 0)
> +			return ret;
> +		ret = mp2975_vid2direct(info->vrm_version[page], ret);
> +		break;
> +	case PMBUS_VIRT_READ_POUT_MAX:
> +		ret = pmbus_read_word_data(client, page, phase,
> +					   MP2973_MFR_READ_POUT_PK);
> +		break;
> +	case PMBUS_VIRT_READ_IOUT_MAX:
> +		ret = pmbus_read_word_data(client, page, phase,
> +					   MP2973_MFR_READ_IOUT_PK);
> +		break;
> +	case PMBUS_UT_WARN_LIMIT:
> +	case PMBUS_UT_FAULT_LIMIT:
> +	case PMBUS_VIN_UV_WARN_LIMIT:
> +	case PMBUS_VIN_UV_FAULT_LIMIT:
> +	case PMBUS_VOUT_UV_WARN_LIMIT:
> +	case PMBUS_VOUT_OV_WARN_LIMIT:
> +	case PMBUS_VIN_OV_WARN_LIMIT:
> +	case PMBUS_IIN_OC_FAULT_LIMIT:
> +	case PMBUS_IOUT_OC_LV_FAULT_LIMIT:
> +	case PMBUS_IOUT_OC_WARN_LIMIT:
> +	case PMBUS_IOUT_OC_FAULT_LIMIT:
> +	case PMBUS_IOUT_UC_FAULT_LIMIT:
> +	case PMBUS_POUT_OP_FAULT_LIMIT:
> +	case PMBUS_POUT_OP_WARN_LIMIT:
> +	case PMBUS_PIN_OP_WARN_LIMIT:
> +		return -ENXIO;
> +	default:
> +		return -ENODATA;
> +	}
> +
> +	return ret;
> +}
> +
>   static int mp2975_read_word_data(struct i2c_client *client, int page,
>   				 int phase, int reg)
>   {
> @@ -386,7 +486,7 @@ mp2975_identify_multiphase(struct i2c_client *client, struct mp2975_data *data,
>   }
>   
>   static int
> -mp2975_identify_vid(struct i2c_client *client, struct mp2975_data *data,
> +mp297x_identify_vid(struct i2c_client *client, struct mp2975_data *data,

Please refrain from such cosmetic changes. It is perfectly fine to keep
calling the function mp2975_identify_vid() even if it is called for
other chips.

Those changes only make it more difficult to review your patch and,
on top of that, are not really related to introducing support for
the new chips.

>   		    struct pmbus_driver_info *info, u32 reg, int page,
>   		    u32 imvp_bit, u32 vr_bit)
>   {
> @@ -422,7 +522,7 @@ mp2975_identify_rails_vid(struct i2c_client *client, struct mp2975_data *data,
>   		return ret;
>   
>   	/* Identify VID mode for rail 1. */
> -	ret = mp2975_identify_vid(client, data, info,
> +	ret = mp297x_identify_vid(client, data, info,
>   				  MP2975_MFR_VR_MULTI_CONFIG_R1, 0,
>   				  MP2975_IMVP9_EN_R1, MP2975_VID_STEP_SEL_R1);
>   	if (ret < 0)
> @@ -430,10 +530,39 @@ mp2975_identify_rails_vid(struct i2c_client *client, struct mp2975_data *data,
>   
>   	/* Identify VID mode for rail 2, if connected. */
>   	if (info->phases[1])
> -		ret = mp2975_identify_vid(client, data, info,
> +		ret = mp297x_identify_vid(client, data, info,
>   					  MP2975_MFR_VR_MULTI_CONFIG_R2, 1,
>   					  MP2975_IMVP9_EN_R2,
>   					  MP2975_VID_STEP_SEL_R2);
> +
> +	return ret;
> +}
> +
> +static int
> +mp2973_identify_rails_vid(struct i2c_client *client, struct mp2975_data *data,
> +			  struct pmbus_driver_info *info)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Identify VID mode for rail 1. */
> +	ret = mp297x_identify_vid(client, data, info,
> +				  MP2973_MFR_VR_MULTI_CONFIG_R1, 0,
> +				  MP2973_IMVP9_EN_R1, MP2973_VID_STEP_SEL_R1);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Identify VID mode for rail 2, if connected. */
> +	if (info->phases[1])
> +		ret = mp297x_identify_vid(client, data, info,
> +					  MP2973_MFR_VR_MULTI_CONFIG_R2, 1,
> +					  MP2973_IMVP9_EN_R2,
> +					  MP2973_VID_STEP_SEL_R2);
> +
>   	return ret;
>   }
>   
> @@ -532,7 +661,7 @@ mp2975_vref_offset_get(struct i2c_client *client, struct mp2975_data *data,
>   }
>   
>   static int
> -mp2975_vout_max_get(struct i2c_client *client, struct mp2975_data *data,
> +mp297x_vout_max_get(struct i2c_client *client, struct mp2975_data *data,
>   		    struct pmbus_driver_info *info, int page)
>   {
>   	int ret;
> @@ -548,17 +677,33 @@ mp2975_vout_max_get(struct i2c_client *client, struct mp2975_data *data,
>   }
>   
>   static int
> -mp2975_set_vout_format(struct i2c_client *client,
> +mp297x_set_vout_format(struct i2c_client *client,
>   		       struct mp2975_data *data, int page)
>   {
>   	int ret;
>   
> -	ret = i2c_smbus_read_word_data(client, MP2975_MFR_DC_LOOP_CTRL);
> -	if (ret < 0)
> -		return ret;
>   	/* Enable DIRECT VOUT format 1mV/LSB */
> -	ret &= ~MP2975_VOUT_FORMAT;
> -	ret = i2c_smbus_write_word_data(client, MP2975_MFR_DC_LOOP_CTRL, ret);
> +	if (data->chip_id == mp2975) {
> +		ret = i2c_smbus_read_word_data(client, MP2975_MFR_DC_LOOP_CTRL);
> +		if (ret < 0)
> +			return ret;
> +		ret &= ~MP2975_VOUT_FORMAT;
> +		ret = i2c_smbus_write_word_data(client, MP2975_MFR_DC_LOOP_CTRL, ret);
> +	} else {
> +		ret = i2c_smbus_read_word_data(client, MP2973_MFR_RESO_SET);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (page == 0) {
> +			ret &= ~MP2973_VOUT_FORMAT_R1;
> +			ret |= MP2973_VOUT_FORMAT_DIRECT_R1;
> +		} else {
> +			ret &= ~MP2973_VOUT_FORMAT_R2;
> +			ret |= MP2973_VOUT_FORMAT_DIRECT_R2;
> +		}
> +
> +		ret = i2c_smbus_write_word_data(client, MP2973_MFR_RESO_SET, ret);

Same as with the previous patch: The value only needs to be written back if it differs
from the value already configured in the chip.

> +	}
>   	return ret;
>   }
>   
> @@ -605,24 +750,28 @@ mp2975_vout_per_rail_config_get(struct i2c_client *client,
>   	for (i = 0; i < data->info.pages; i++) {
>   		ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, i);
>   		if (ret < 0)
> -			return ret;
> +			continue;
>   
> -		/* Obtain voltage reference offsets. */
> -		ret = mp2975_vref_offset_get(client, data, i);
> +		/*
> +		 * Set VOUT format for READ_VOUT command : direct.
> +		 * Pages on same device can be configured with different
> +		 * formats.
> +		 */
> +		ret = mp297x_set_vout_format(client, data, i);
>   		if (ret < 0)
>   			return ret;
>   
>   		/* Obtain maximum voltage values. */
> -		ret = mp2975_vout_max_get(client, data, info, i);
> +		ret = mp297x_vout_max_get(client, data, info, i);
>   		if (ret < 0)
>   			return ret;
>   
> -		/*
> -		 * Set VOUT format for READ_VOUT command : direct.
> -		 * Pages on same device can be configured with different
> -		 * formats.
> -		 */
> -		ret = mp2975_set_vout_format(client, data, i);
> +		/* Skip if reading Vref is unsupported */
> +		if (data->chip_id != mp2975)
> +			continue;
> +
> +		/* Obtain voltage reference offsets. */
> +		ret = mp2975_vref_offset_get(client, data, i);
>   		if (ret < 0)
>   			return ret;
>   
> @@ -660,6 +809,23 @@ static struct pmbus_driver_info mp2975_info = {
>   	.read_word_data = mp2975_read_word_data,
>   };
>   
> +static struct pmbus_driver_info mp2973_info = {
> +	.pages = 1,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = direct,
> +	.format[PSC_TEMPERATURE] = linear,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.format[PSC_POWER] = linear,
> +	.m[PSC_VOLTAGE_OUT] = 1,
> +	.R[PSC_VOLTAGE_OUT] = 3,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> +		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
> +		PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT,
> +	.read_word_data = mp2973_read_word_data,
> +};
> +
>   static int mp2975_probe(struct i2c_client *client)
>   {
>   	struct pmbus_driver_info *info;
> @@ -679,6 +845,11 @@ static int mp2975_probe(struct i2c_client *client)
>   	memcpy(data->max_phases, mp2975_max_phases[data->chip_id],
>   	       sizeof(data->max_phases));
>   
> +	if (data->chip_id == mp2975)
> +		memcpy(&data->info, &mp2975_info, sizeof(*info));
> +	else
> +		memcpy(&data->info, &mp2973_info, sizeof(*info));
> +
>   	info = &data->info;
>   
>   	/* Identify multiphase configuration for rail 2. */
> @@ -693,30 +864,37 @@ static int mp2975_probe(struct i2c_client *client)
>   		data->info.func[1] = MP2975_RAIL2_FUNC;
>   	}
>   
> -	/* Identify multiphase configuration. */
> -	ret = mp2975_identify_multiphase(client, data, info);
> -	if (ret)
> -		return ret;
> +	if (data->chip_id == mp2975) {
> +		/* Identify multiphase configuration. */
> +		ret = mp2975_identify_multiphase(client, data, info);
> +		if (ret)
> +			return ret;
>   
> -	/* Identify VID setting per rail. */
> -	ret = mp2975_identify_rails_vid(client, data, info);
> -	if (ret < 0)
> -		return ret;
> +		/* Identify VID setting per rail. */
> +		ret = mp2975_identify_rails_vid(client, data, info);
> +		if (ret < 0)
> +			return ret;
>   
> -	/* Obtain current sense gain of power stage. */
> -	ret = mp2975_current_sense_gain_get(client, data);
> -	if (ret)
> -		return ret;
> +		/* Obtain current sense gain of power stage. */
> +		ret = mp2975_current_sense_gain_get(client, data);
> +		if (ret)
> +			return ret;
>   
> -	/* Obtain voltage reference values. */
> -	ret = mp2975_vref_get(client, data, info);
> -	if (ret)
> -		return ret;
> +		/* Obtain voltage reference values. */
> +		ret = mp2975_vref_get(client, data, info);
> +		if (ret)
> +			return ret;
>   
> -	/* Obtain vout over-voltage scales. */
> -	ret = mp2975_vout_ov_scale_get(client, data, info);
> -	if (ret < 0)
> -		return ret;
> +		/* Obtain vout over-voltage scales. */
> +		ret = mp2975_vout_ov_scale_get(client, data, info);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		/* Identify VID setting per rail. */
> +		ret = mp2973_identify_rails_vid(client, data, info);
> +		if (ret < 0)
> +			return ret;
> +	}
>   
>   	/* Obtain offsets, maximum and format for vout. */
>   	ret = mp2975_vout_per_rail_config_get(client, data, info);
> @@ -727,6 +905,8 @@ static int mp2975_probe(struct i2c_client *client)
>   }
>   
>   static const struct of_device_id __maybe_unused mp2975_of_match[] = {
> +	{.compatible = "mps,mp2971", .data = (void *)mp2971},
> +	{.compatible = "mps,mp2973", .data = (void *)mp2973},
>   	{.compatible = "mps,mp2975", .data = (void *)mp2975},
>   	{}
>   };

