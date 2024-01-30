Return-Path: <linux-kernel+bounces-45359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB684842F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4D61C220A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21167D3FC;
	Tue, 30 Jan 2024 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqPeVdmr"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B427D3EE;
	Tue, 30 Jan 2024 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652003; cv=none; b=FfnETyFYEg7DA7JjXVIa3gcEopEOLGO4OEJVVbQDTZFCLEm9XInlBnBLG5CWtrgYszJ5CBscSSEC/19u6ohvzOnIjcHB+fhMqtlU7KUMKnzY3CzEc4+hclDIm4OEe+IKhR/cqkgLTPFfJ1pRg7hhKTvZJ4rWa4ybCMQ3cvewvso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652003; c=relaxed/simple;
	bh=1CW3qMyVGvYAz2Ags8+A5XJXNqBlJu/Dw4yb/APpQuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdbRJ+MvkVXoT7ZpQdGcHLqBEmyS4XxpVnc53l6x9t5yOADuNgdgPOTtOME83lUQeU5hdEvNutludJ2BcoKAbA+jnCjmg8Ns2i+Op5xlK0tizPZaerAISACep9hMfJGaFePIFuWa4s/vFvxnlS+m3Py7Dp1qg2QbS8ZyySbb+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqPeVdmr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d91397bd22so7215065ad.0;
        Tue, 30 Jan 2024 14:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706652000; x=1707256800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gsRDr5VvL9comRbizRuuGN62ar8G3zXGkqfZiAmKLE=;
        b=DqPeVdmrV2bpMdiV5gJ5gHijtDSJZQoFKqtM4ZI0IIklYxxTO45tbDOztCD+NUptUa
         4yEdHVwzZiK8a6u83lN7jhapG6wtBrNGf10+hYhRWwFozED6Yd7Kxhpr7u/QsVMUfPaO
         pJAXTQQj4qtCJIzPYganX03oFPF6XLWfm8iTKBfo4FAg60jPDOlyO52Dg9wcVD1OXh9h
         O3VwDo17GBm65Cr4OH7xxx5TDQ1SO+TcYRn4cTx5w7R+vg1XYk0sdFYbuWoRu54EedEQ
         nnyA3/V3ea1Gn25Tg47bpzpd5Wi6avt28utYQWv3HE6jF/bZ6jhxVfflhOtvfgPnns6j
         OZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706652000; x=1707256800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gsRDr5VvL9comRbizRuuGN62ar8G3zXGkqfZiAmKLE=;
        b=LIB3Ig8EsbYm4klYpElvKwqGslX5VCZOU++T+nTMJV7hFE7Pnu0Eqp+s//pVJbql7D
         uUU2r2R3laAaFsj2aRrHkGJsFGZT2tGVn9oEl6fuy82zXbHmU+F88pwpnOiTplAa61Iq
         GAuCzB6qKFQQ5m63eAxp3XDObw5y4WklX5zfrqVJ2kSr3S4oIbWirvPiNMKSnLVW4lj1
         EA0TI5a+bj4OXWTvD+4muxSrwM4PEIpapp76u6CtCwnxGOjCVs9pvbulSSBdd5OL9RBG
         dXdUxLJtEy30msanYZbyxpYmbz5TWW630Em1b0nH/ZrfDL1XymyzUNznB/kS6lndnIFd
         5wdQ==
X-Gm-Message-State: AOJu0YyS7tmq3ne1fxIQiBgeo8U8Evl5odsE8Ocmpp7JeiCytZCneFIB
	NAQ8Exjk0c6xnW1yMQHLZGTkfacC40CNrpz0MMqXFEgYrpG4rcjK
X-Google-Smtp-Source: AGHT+IH3yWI6AdKAlLcFmsCpgy1m/pZebQoKxre+4/5fgpML7mVHH7PSVwwJu6mXQw7vmimJ/CcW4g==
X-Received: by 2002:a17:902:d48e:b0:1d8:c1ed:74d6 with SMTP id c14-20020a170902d48e00b001d8c1ed74d6mr907547plg.14.1706652000342;
        Tue, 30 Jan 2024 14:00:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id lb3-20020a170902fa4300b001d913992d91sm1494529plb.240.2024.01.30.13.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:59:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 30 Jan 2024 13:59:57 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, mazziesaccount@gmail.com,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus/mp2975) Fix IRQ masking
Message-ID: <cd84b051-1608-48c0-8335-b038cd236f61@roeck-us.net>
References: <20240130175140.3834889-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130175140.3834889-1-naresh.solanki@9elements.com>

On Tue, Jan 30, 2024 at 11:21:39PM +0530, Naresh Solanki wrote:
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
>  drivers/hwmon/pmbus/mp2975.c | 57 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> 
> base-commit: 909d8d33f8b4664c9b6c7fd585114921af77fc2b
> 
> diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
> index b9bb469e2d8f..788ec2c5a45f 100644
> --- a/drivers/hwmon/pmbus/mp2975.c
> +++ b/drivers/hwmon/pmbus/mp2975.c
> @@ -377,6 +377,62 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
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
> +#define SWAP(cond, bit) (ret = (cond) ? (ret & ~BIT(bit)) : (ret | BIT(bit)))

This isn't really a "SWAP", but setting or clearing of bits in "ret"
depending on a bit set in "cond". I don't have a good idea for a
better name, but either case I think a comment describing what it
does would be useful.

"ret" use is implied, but "mask" is always provided as parameter.
Please either provide both as arguments, or make both implied.

Also, the first parameter is a bit mask, while the second parameter
is a bit position. Please used defines for the second parameter
and make it a mask as well.

> +	switch (target) {
> +	case PMBUS_STATUS_CML:
> +		SWAP(mask & PB_CML_FAULT_INVALID_DATA, 8);
> +		SWAP(mask & PB_CML_FAULT_INVALID_COMMAND,  9);
> +		SWAP(mask & PB_CML_FAULT_OTHER_COMM, 5);
> +		SWAP(mask & PB_CML_FAULT_PACKET_ERROR, 7);
> +		break;
> +	case PMBUS_STATUS_VOUT:
> +		SWAP(mask & PB_VOLTAGE_UV_FAULT, 13);
> +		SWAP(mask & PB_VOLTAGE_OV_FAULT, 14);
> +		break;
> +	case PMBUS_STATUS_IOUT:
> +		SWAP(mask & PB_IOUT_OC_FAULT, 11);
> +		SWAP(mask & PB_IOUT_OC_LV_FAULT, 10);
> +		break;
> +	case PMBUS_STATUS_TEMPERATURE:
> +		SWAP(mask & PB_TEMP_OT_FAULT, 0);
> +		break;
> +	/*
> +	 * Map remaining bits to MFR specific to let the PMBUS core mask
> +	 * those bits by default.
> +	 */
> +	case PMBUS_STATUS_MFR_SPECIFIC:
> +		SWAP(mask & BIT(1), 1);
> +		SWAP(mask & BIT(3), 3);
> +		SWAP(mask & BIT(4), 4);
> +		SWAP(mask & BIT(6), 6);
> +		break;

Coming back to using defines for the second parameter: The
above bit positions appear to be purely random. Having defines for
those bits will at least explain what is being masked (and hopefully
explain why bit 2, 12, and 15 are not covered at all).
For example, at least one other chip from the same vendor defines
bit 6 as CRC_ERROR, and the matching status register bit is bit
4 (memory fault detected) in STATUS_CML. Also, it is unclear why
the chip would not issue any alerts when warning limits are exceeded.
Without knowing what the bits in SMBALERT_MASK mean it is impossible
to validate if the above is correct and/or complete.

Thanks,
Guenter

