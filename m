Return-Path: <linux-kernel+bounces-95990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFDA8755B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332851C21655
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240F8131756;
	Thu,  7 Mar 2024 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrYLK4l1"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9908E130E39;
	Thu,  7 Mar 2024 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834382; cv=none; b=N6nVYgCXRo86jfgvE157RHC6CIaqFMs6zt7h0FFQglUkzVL5fPX8yghpvUNSGj9vAjAD6p7SrvJgjcHfiHDNIDyE04NO/okyJLw/dLZmp36XtXPjWhYrDBwgldVOwvfCK3wdYSKIIPxKJ99SnKvjiADytpaLe0WPs1n3j1EqcN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834382; c=relaxed/simple;
	bh=RNfmHO/bc1zpUk92vZiNtIECWGZWxy7H5p2qSY77MTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQT/0OYV8GDUX/llOjprtSTG9AMWFOgHzNakhLfswgFvlE3y5FNO3cI5jr5ZyRAfdLU8wUvK0zsVFenygL64T/NpDigOWsH6fQ0hOXnFBkGWVnhUoriKkIf6SqPO8mE0mUwV1VNMlKsonXFYfF9Wovs71ixIRvG7aeNygoOq3XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrYLK4l1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e64647af39so1177583b3a.1;
        Thu, 07 Mar 2024 09:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709834380; x=1710439180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=br7LhqE5jOi6Ju5fFjJ2bgQj1bOvRW7SFbUW6PgsJts=;
        b=SrYLK4l1c++AizdHyVvbr7znxHGdWzzvFl2kGThXeHj5xt9Iv++L78l8n1R24cSgEs
         axV1D+a3gY6Vh2o1b6DAzCO41KoOVdiHS81QHRiLls0BWOQLbN8F62LpgE9H/sikXm+6
         4i2YLvK+iOBjclA4zVstOS5w/hdPZkxXlx0Ov6fW2h60jQr1m6C4aU5OQ3/3FtqhR7N/
         askcVdLg1eYgiUnpFeZk5hmWnWovNn5rmD7tY5NOk1FbNebsBBP/7oAonfe/xmLnaRqV
         TecmAhQ3wi4X2c1gEaVe8Hv6weFCxjN9X/EXUZ8KOQOyyhm7dVrTjmxQRitGonM+zi9Y
         ovPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709834380; x=1710439180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=br7LhqE5jOi6Ju5fFjJ2bgQj1bOvRW7SFbUW6PgsJts=;
        b=WzeUmaRjqvywYwjd2nuU2uSIdbN8bNZTpXR/eCEjtX0kmgWpy5+8IzULCdSnev8P2M
         NQvJCLf4Ow+4HEUAV5Dls6M+UUWJok9XT9jWCsMMmLk86q8OgF3qkPMUa47nJ1EisCx3
         gQWThJ85NFahfl/Qg+V6lbHPAdo7IBcWCFZrUXAt4oC1vpXiBDGTvHVFlfhiXhPJEYpL
         7nyi02BeLk36UsR+vDCUjbhb8mcBwys6nUBtQtCmRR/DTwMMcQAAkx4nRjOkIHKuavN9
         gyacORgvqi70hyQ4qnX70g9gpnNVl4Lpy6uml0HsWetxmclsVNwXExHSVamFYkUSj1tg
         xcIg==
X-Forwarded-Encrypted: i=1; AJvYcCVpvL0pLbiVFtsEPZKzwY+/t+hjg1MMZNtUtkr/0rZuLdAOjfkY6FUw0nsM5PwoaC1ujXsMru30EilMhSu9A6hzMQBaH0jfE7ryNcPGNJ5uJiTaT6hFoK9fL7wveSheDlcXGPV9QGsysH4=
X-Gm-Message-State: AOJu0YxE+HdKLeQvI4YqOZT1VZP+Q7qrC+ntwLNADeGycYmsC8XvQYzJ
	WSnq4j5T4YNewkK7MUNl2N1oVvqm4+HhDLswgThiZ6F+tPjglz2a
X-Google-Smtp-Source: AGHT+IF8B9y/pv1As2dOop940NDH9LTF1aAqaRsWt4NLMpm5wjhT7Cqh96zstJHhSoforkVD7LvfMQ==
X-Received: by 2002:a05:6a20:b312:b0:1a1:4caa:7ecc with SMTP id ef18-20020a056a20b31200b001a14caa7eccmr7556342pzb.53.1709834379784;
        Thu, 07 Mar 2024 09:59:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x20-20020a056a000bd400b006e65d66bb3csm1446251pfu.21.2024.03.07.09.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 09:59:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 7 Mar 2024 09:59:38 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, mazziesaccount@gmail.com,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] hwmon: (pmbus/mp2975) Fix IRQ masking
Message-ID: <e680cc14-1068-4ae7-8400-5adcc9650c2f@roeck-us.net>
References: <20240305101608.2807612-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305101608.2807612-1-naresh.solanki@9elements.com>

On Tue, Mar 05, 2024 at 03:46:07PM +0530, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> The MP2971/MP2973 use a custom 16bit register format for
> SMBALERT_MASK which doesn't follow the PMBUS specification.
> 
> Map the PMBUS defined bits used by the common code onto the custom
> format used by MPS and since the SMBALERT_MASK is currently never read
> by common code only implement the mapping for write transactions.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
> 
> Changes in V2:
> 1. Add/Update comment
> 2. Update SWAP define to include both variable.
> 3. Add defines for each bits of SMBALERT mask.
> ---
>  drivers/hwmon/pmbus/mp2975.c | 77 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> 
> base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
> 
> diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
> index e5fa10b3b8bc..766026204d88 100644
> --- a/drivers/hwmon/pmbus/mp2975.c
> +++ b/drivers/hwmon/pmbus/mp2975.c
> @@ -392,6 +392,82 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
>  	return ret;
>  }
>  
> +static int mp2973_write_word_data(struct i2c_client *client, int page,
> +				  int reg, u16 word)
> +{
> +	u8 target, mask;
> +	int ret;
> +
> +	if (reg != PMBUS_SMBALERT_MASK)
> +		return -ENODATA;
> +
> +	/*
> +	 * Vendor-specific SMBALERT_MASK register with 16 maskable bits.
> +	 */
> +	ret = pmbus_read_word_data(client, 0, 0, PMBUS_SMBALERT_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	target = word & 0xff;
> +	mask = word >> 8;
> +
> +/*
> + * Set/Clear 'bit' in 'ret' based on condition followed by define for each bit in SMBALERT_MASK.
> + * Also bit 2 & 15 are reserved.
> + */
> +#define SWAP(cond, bit) (ret = (mask & cond) ? (ret & ~BIT(bit)) : (ret | BIT(bit)))
> +

Checkpatch:

CHECK: Macro argument 'cond' may be better as '(cond)' to avoid precedence issues

In addition to that, I really dislike side effect programming
as it is risky and difficult to understand. Please make that
something like

#define SWAP(val, mask, cond, bit) (((mask) & (cond)) ? ((val) & ~BIT(bit)) : ((val) | BIT(bit)))

and
	ret = SWAP(ret, mask, PB_CML_FAULT_INVALID_DATA, MP2973_INVALID_DATA);

Yes, I know, checkpatch will still complain about the re-use of bit,
but such is life.

Thanks,
Guenter

> +#define MP2973_TEMP_OT		0
> +#define MP2973_VIN_UVLO		1
> +#define MP2973_VIN_OVP		3
> +#define MP2973_MTP_FAULT	4
> +#define MP2973_OTHER_COMM	5
> +#define MP2973_MTP_BLK_TRIG	6
> +#define MP2973_PACKET_ERROR	7
> +#define MP2973_INVALID_DATA	8
> +#define MP2973_INVALID_COMMAND	9
> +#define MP2973_IOUT_OC_LV	10
> +#define MP2973_IOUT_OC		11
> +#define MP2973_VOUT_MAX_MIN_WARNING 12
> +#define MP2973_VOLTAGE_UV	13
> +#define MP2973_VOLTAGE_OV	14
> +
> +	switch (target) {
> +	case PMBUS_STATUS_CML:
> +		SWAP(PB_CML_FAULT_INVALID_DATA, MP2973_INVALID_DATA);
> +		SWAP(PB_CML_FAULT_INVALID_COMMAND,  MP2973_INVALID_COMMAND);
> +		SWAP(PB_CML_FAULT_OTHER_COMM, MP2973_OTHER_COMM);
> +		SWAP(PB_CML_FAULT_PACKET_ERROR, MP2973_PACKET_ERROR);
> +		break;
> +	case PMBUS_STATUS_VOUT:
> +		SWAP(PB_VOLTAGE_UV_FAULT, MP2973_VOLTAGE_UV);
> +		SWAP(PB_VOLTAGE_OV_FAULT, MP2973_VOLTAGE_OV);
> +		break;
> +	case PMBUS_STATUS_IOUT:
> +		SWAP(PB_IOUT_OC_FAULT, MP2973_IOUT_OC);
> +		SWAP(PB_IOUT_OC_LV_FAULT, MP2973_IOUT_OC_LV);
> +		break;
> +	case PMBUS_STATUS_TEMPERATURE:
> +		SWAP(PB_TEMP_OT_FAULT, MP2973_TEMP_OT);
> +		break;
> +	/*
> +	 * Map remaining bits to MFR specific to let the PMBUS core mask
> +	 * those bits by default.
> +	 */
> +	case PMBUS_STATUS_MFR_SPECIFIC:
> +		SWAP(BIT(1), MP2973_VIN_UVLO);
> +		SWAP(BIT(3), MP2973_VIN_OVP);
> +		SWAP(BIT(4), MP2973_MTP_FAULT);
> +		SWAP(BIT(6), MP2973_MTP_BLK_TRIG);
> +		break;
> +	default:
> +		return 0;
> +	}
> +#undef SWAP
> +
> +	return pmbus_write_word_data(client, 0, PMBUS_SMBALERT_MASK, ret);
> +}
> +
>  static int mp2975_read_word_data(struct i2c_client *client, int page,
>  				 int phase, int reg)
>  {
> @@ -907,6 +983,7 @@ static struct pmbus_driver_info mp2973_info = {
>  		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
>  		PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT,
>  	.read_word_data = mp2973_read_word_data,
> +	.write_word_data = mp2973_write_word_data,
>  #if IS_ENABLED(CONFIG_SENSORS_MP2975_REGULATOR)
>  	.num_regulators = 1,
>  	.reg_desc = mp2975_reg_desc,

