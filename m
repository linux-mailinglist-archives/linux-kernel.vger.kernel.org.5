Return-Path: <linux-kernel+bounces-99255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE008785A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EB81F21C99
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C721D481C0;
	Mon, 11 Mar 2024 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxFWqFsd"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D4B2AF06;
	Mon, 11 Mar 2024 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175461; cv=none; b=CRSNLIYssk3DOKYhy9ePO+P6BnkSLNp5Kxkfn3AIKpeIpXXBdPJD+xl5xJOTXGe56+oG8ajZTvOm6LwoAlGev+nVjbr5xb4NZqtYIr2M5uyzNaXpzv1bvJ7LcGmNIH+f/yCe23L679a0XTDQElbvAF4T4fvzhpAmXTGrfj7nYMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175461; c=relaxed/simple;
	bh=6NBRISRcZ1DgaQx5Bxk1KXFSBBBVkAQv54OitKcZZ7I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npBT3zJDGrbzey8BgrM6EcbLoXivnffWLl9wfmIWx6CLOJ228da9m2ev+rmCwHWq21dNOnIF7ZXYE4UejrtKs8V4f18116BWvOuBT/FO1+8m3QibpJ6sNrO3jngJVhYlNLebHBge88RrYN3s9Z2SXG62Q9fD616qg11OFx3M4V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxFWqFsd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a45ba1f8e89so510138766b.1;
        Mon, 11 Mar 2024 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710175458; x=1710780258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UbWkGAayYWenTYqN2oUQ8aST+NcC7qqKrwIVWhosCoU=;
        b=LxFWqFsdvcuSDJT43BF5h6/j542j0sJmcpXEoCrnY7jhWTNuR6/x6OvUGxEzXUS/Mm
         gIONODTD6ujLEsuFXI8TDbXxOJ/jPWTCR2I0qWSsTer8hmE9CGrZ09yze1nPf+ynCxPO
         ThgVO7T6O/IwQpaZQjLcsblAua3AinEC30Z9kk2n4wuZwYW8fuY6rnX4hATTwJMNAdg7
         /AHYi0/gJUoQrHg4RIFukVptiDR6PtE9CCqwpBekhGI0Fy8kpJb0MTTJEhiznVUn4zhO
         v9HOKSdw1wV/aTTiTWJv5TwmwC/M3T23Uv7dyso1rJujxIzGAdj7tpsnZNM9ADi6Lmyi
         VU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175458; x=1710780258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbWkGAayYWenTYqN2oUQ8aST+NcC7qqKrwIVWhosCoU=;
        b=HjxOrvsiAiIa+DnFP4RcHKA2/vuAXfFuvRAmz2Nd0qyDt/AGN8rMB0ilVx5qVS8227
         YQgvI0eiE5MTb2CKorFbh7LOu+TOdtWOoG0ciJ33nqW+iN8uu4+yYlvYMJQOBBgAb3oT
         WLlTJ3wNw26UJbGqOZY7fXhHfmwpkOJb1EA0H6XSPrZBsTMr6W1c7D9qldj8idXobuy9
         fWYkrE1Ci8xsCrzMbZ1XbwuG8dY4+vO/taWtqYsEZNN9L9wMpU5C26f8y2FihRdYB+Os
         mTbbBt1w68s+rUtDZMYC6TOmEvhAvrJi3VSXHfy4H/UvJ4GxS/PIjpDx9vcyEPX3YM3J
         80EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhkSdKYNe+bk7Z17TxZurjoPrrq4s0wzGPXTAFdYyB+F5VsivwwA0esNk96Fr75DaWOel6JInnu1PN5SPxzdtsIJxqQTxlhsobiBlMgW6SoZzc+p6HIABQ2pDhKVoPyDxeT1bp8Ysv
X-Gm-Message-State: AOJu0Ywzi7fh+BOI4RNPyQ4qew+ssdXYEbMcNlYKuq2I7k1rVBz3ITfr
	vacsxMLqbw4pW0LvKAyx69WWCTRo5i4tMxE/R6AweWH/9B+Arjeq
X-Google-Smtp-Source: AGHT+IHU4DuZOS6itD4uXre3W9irrkXk0UQd7C4PblN7xxtYSrBOZP3YGg5fWv2IbjG+bnJY0sD1Og==
X-Received: by 2002:a17:907:1681:b0:a46:2fd1:32de with SMTP id cx1-20020a170907168100b00a462fd132demr1890985ejd.12.1710175457405;
        Mon, 11 Mar 2024 09:44:17 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:b24d:a5cc:76ea:4a7a])
        by smtp.gmail.com with ESMTPSA id i26-20020a170906251a00b00a44cb0bf11bsm3012697ejb.79.2024.03.11.09.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:44:16 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 11 Mar 2024 17:44:14 +0100
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, ang.iglesiasg@gmail.com, phil@raspberrypi.com,
	579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: Fixes SPI support for BMP3xx devices
Message-ID: <20240311164414.GA1790017@vamoiridPC>
References: <20240311005432.1752853-1-vassilisamir@gmail.com>
 <Ze7XU5JS8FF5FZdg@smile.fi.intel.com>
 <20240311155829.00004478@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311155829.00004478@Huawei.com>

On Mon, Mar 11, 2024 at 03:58:29PM +0000, Jonathan Cameron wrote:
> On Mon, 11 Mar 2024 12:05:07 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Mon, Mar 11, 2024 at 01:54:32AM +0100, Vasileios Amoiridis wrote:
> > > Bosch does not use unique BMPxxx_CHIP_ID for the different versions of
> > > the device which leads to misidentification of devices if their ID is
> > > used. Use a new value in the chip_info structure instead of the
> > > BMPxxx_CHIP_ID, in order to choose the regmap_bus to be used.  
> > 
> > ...
> > 
> > >  	const struct regmap_config *regmap_config;
> > > +	int spi_read_extra_byte;  
> > 
> > Why is it int and not boolean?
> > Also, please run `pahole` to see the best place for a new member.
> 
> Whilst that's good in general, there aren't many of these structs (4ish)
> so if the 'cheapest' positioning isn't natural or hurts readability
> ignore what you get from pahole.
> 
> Jonathan
> 

Hello Andy, hello Jonathan,

Thank you for your feedback! Andy, I already used pahole as you suggested
already in one of my previous patch series for this driver, and the
result looks like it uses only 4 byte values so adding a bool would only
create a 3 byte hole. Apart from that, I noticed that for example, the 
num_chip_ids value could have easily been a u8 but instead it's an int,
I guess to satisfy the alignment requirements. Also the id_reg could
easily be a u8 but instead it is an unsigned int. Maybe in the future, if
more values are added it will be good to have a re-organization of those
values. I can look at it, after the fix is done and it is on the mainline.
Finally, I chose this specific position because it's next to the 
regmap_config, and the new value affects the regmap_bus so in my opinion
it helps readability.

pahole --class_name=bmp280_chip_info bmp280-core.dwo
struct bmp280_chip_info {
        unsigned int               id_reg;               /*     0     4 */
        const u8  *                chip_id;              /*     4     4 */
        int                        num_chip_id;          /*     8     4 */
        const struct regmap_config  * regmap_config;     /*    12     4 */
        int                        spi_read_extra_byte;  /*    16     4 */
        const struct iio_chan_spec  * channels;          /*    20     4 */
        int                        num_channels;         /*    24     4 */
        unsigned int               start_up_time;        /*    28     4 */
        const int  *               oversampling_temp_avail; /*    32     4 */
        int                        num_oversampling_temp_avail; /*    36     4 */
        int                        oversampling_temp_default; /*    40     4 */
        const int  *               oversampling_press_avail; /*    44     4 */
        int                        num_oversampling_press_avail; /*    48     4 */
        int                        oversampling_press_default; /*    52     4 */
        const int  *               oversampling_humid_avail; /*    56     4 */
        int                        num_oversampling_humid_avail; /*    60     4 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        int                        oversampling_humid_default; /*    64     4 */
        const int  *               iir_filter_coeffs_avail; /*    68     4 */
        int                        num_iir_filter_coeffs_avail; /*    72     4 */
        int                        iir_filter_coeff_default; /*    76     4 */
        const int  *               sampling_freq_avail;  /*    80     4 */
        int                        num_sampling_freq_avail; /*    84     4 */
        int                        sampling_freq_default; /*    88     4 */
        int                        (*chip_config)(struct bmp280_data *); /*    92     4 */
        int                        (*read_temp)(struct bmp280_data *, int *, int *); /*    96     4 */
        int                        (*read_press)(struct bmp280_data *, int *, int *); /*   100     4 */
        int                        (*read_humid)(struct bmp280_data *, int *, int *); /*   104     4 */
        int                        (*read_calib)(struct bmp280_data *); /*   108     4 */
        int                        (*preinit)(struct bmp280_data *); /*   112     4 */

        /* size: 116, cachelines: 2, members: 29 */
        /* last cacheline: 52 bytes */
};

Thanks,
Vasilis
> > 
> 

