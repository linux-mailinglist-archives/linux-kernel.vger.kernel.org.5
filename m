Return-Path: <linux-kernel+bounces-14611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFAE821F9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C67B1F22213
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C945714F8E;
	Tue,  2 Jan 2024 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgVQrryV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8050214F62;
	Tue,  2 Jan 2024 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9ac5bd128so2277267b3a.0;
        Tue, 02 Jan 2024 08:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704213575; x=1704818375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJILKmZ4kcbZoI3Jm11w7C8ZSpu1QPUnWEpHEd88Zxk=;
        b=DgVQrryVPm/jNZbM1Poz2op4Lpx1CIu+wO7APL/ns6Dsh7azJrZiSFiz0M0igYBeam
         80pHfrA23Y1DFiAZY5z/9V7h7rEttAxylN/AGzrzVr5bkEXJOfyTmJ0ufRyT/M8Xx//O
         c6FB8RPOBHUvNwK72UfeCBFRVd8C8LW/wwdXdibQdY6o1wwIpZYOln/r0a/OBi5CMJjl
         mnZF3rG1S7VAOl/TT5uqDOyApGl3R9XZg+FpB+g+AH6Zl6AmJt77/hqzaA14ofpQuhWj
         cp4WP7NgCOplgeO2HHo31L3bavFT3SjNqj80ulhUCYa+0+ruYkTqUkRQUlegGaELkpHI
         aoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704213575; x=1704818375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJILKmZ4kcbZoI3Jm11w7C8ZSpu1QPUnWEpHEd88Zxk=;
        b=mK+Ef8Y5Lp3TpX9u3YPEbWF9+aXKjtiUm8an2wbPUbSDpy7RWJmJi99XpTA1uHLCJc
         ZwK8FdqbbnsDdWjoR5tL5/XrqMHXc93smhrfbec/+SfIHhSGGIEZQa19v2oVD5Ua8bQP
         qsISIHYPxotfnphy0QgeuGXz1qaYlk84GVjasd4nYES5gI3/XbImNhhaKCGBgT1vzXFU
         qTpvFoK0jTIYLjhEkrQ06GZYR02hrcaBNVbyucoWdhuErVibcC7ieHulmDsWXmq/aVFO
         4vKnzz1oybZifiDItfAcnnEtc4CPq42hLS9WkiL+FHpycsYaB6mDRVt/o7teQHOrYxiv
         P/nw==
X-Gm-Message-State: AOJu0YzltKg6rDIpu93yiuukNBIYGHgbvLF4Ffm5d5M4R61iq7YRDn/r
	Pqr9TqZVsl8ol3GGsK6C/kucf3MA/+Y=
X-Google-Smtp-Source: AGHT+IE1GY4luJxvA7XW5jTP7w37gDDzmmU1tBmld5nM/P8GC/YsdKKUhedCipWJgtSk5AgboDjT4Q==
X-Received: by 2002:a62:a518:0:b0:6d9:cdf5:cc45 with SMTP id v24-20020a62a518000000b006d9cdf5cc45mr4984775pfm.63.1704213574715;
        Tue, 02 Jan 2024 08:39:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fb35-20020a056a002da300b006d9bff075cfsm14284191pfb.33.2024.01.02.08.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 08:39:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 2 Jan 2024 08:39:32 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Stefan Gloor <code@stefan-gloor.ch>
Cc: jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] hwmon: (sht3x) read out sensor serial number
Message-ID: <0946e7cc-e054-4e94-85e6-1db88ea925dd@roeck-us.net>
References: <20231227190036.20725-1-code@stefan-gloor.ch>
 <20231227190036.20725-2-code@stefan-gloor.ch>
 <4389cd48-5d61-49bc-8cb5-b337afe40c23@roeck-us.net>
 <20240101221448.wtwn23vgeptgs36v@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240101221448.wtwn23vgeptgs36v@thinkpad>

On Mon, Jan 01, 2024 at 11:18:21PM +0100, Stefan Gloor wrote:
> On Sun, Dec 31, 2023 at 10:32:56AM -0800, Guenter Roeck wrote:
> > This creates i2c<bus>-<address>/serial_number when the device is instantiated.
> > That debugfs entry is not removed when the device is removed, only when the
> > driver is unloaded. This means that de-instantiating the device will leave
> > stray debugfs directories and files behind until the driver is unloaded.
> > 
> > We had this before, and I understand that you claimed that this doesn't happen.
> > To get me to believe you, you'll have to provide a log of
> > 
> > - instantiating the driver 
> > - Showing the debufs tree
> > - de-instantiating the driver
> > - Showing the debugfs tree
> > 
> > ... but even then I'll want to be able to test it myself. Not sure if I
> > have an eval board, but either case that will take some time. Frankly,
> > I don't understand why you refuse to remove
> > i2c<bus>-<address>/serial_number on device removal.
> > 
> > Guenter
> > 
> 
> Hi Guenter,
> 
> Thank you for your patience. As this is my first patch set for Linux I still
> need to learn a lot.
> 
> You are right. I was confused about driver instantiation and driver
> loading/unloading. The i2cX-XX directory needs to be removed explicitly.
> 
> If I understood correctly, the following changes should achieve this:
> 
> +static void sht3x_remove(struct i2c_client *client)
> +{
> +	struct sht3x_data *data;
> +
> +	data = dev_get_drvdata(&client->dev);
> +	debugfs_remove_recursive(data->sensor_dir);
> +}
> +
>  static struct i2c_driver sht3x_i2c_driver = {
>  	.driver.name = "sht3x",
>  	.probe       = sht3x_probe,
> +	.remove      = sht3x_remove,
>  	.id_table    = sht3x_ids,
>  };
> 
> Of course data->sensor_dir needs to be set to the i2X-XX directory when it is
> created.
> 
> If there is nothing obviously wrong with it I'll submit v4 shortly.
> 

This is correct. I personally would prefer the use of devm_add_action_or_reset()
instead of a remove function, but the above works as well. Make sure though
that debugfs_remove_recursive() is also called if hwmon registration fails.

Thanks,
Guenter

