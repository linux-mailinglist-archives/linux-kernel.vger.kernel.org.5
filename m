Return-Path: <linux-kernel+bounces-91132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DF98709E7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD7E283576
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFE878B5C;
	Mon,  4 Mar 2024 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYZ4uoSn"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079D578B44;
	Mon,  4 Mar 2024 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578223; cv=none; b=um8kTWZGvQhitCp5MzEPDl2EoNEyGK8XgrWPfsJ7LMd0rlezIRj85lA31YN0plbLP9KXSosPh706254LkSCNO6Dxei5sE19ZE5B/5srAWAcph3/EWPHmP8XoBaVhwLp0IjhQN/6+CPuxu+SjmSm6o9PMfPcYcRD52FhAufEWkmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578223; c=relaxed/simple;
	bh=7eDOCTzxgjXTz40cs4/kG1usCYFXG1biUAupDWGxh4g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnYjcfx6bX6awtnA7RuiNUzArSAge7o4GhQjtjPiXh8q5vU561/u1G5lIZkrK4P3RA1ZvkRa0yWajmzg5A1hxtqTQA6CsdUVgVYGU5eMMFt10GiqxMSwX0ZyOaE5yFdljpR/cJYAFPkVUZFx5vSa+6MNd+wI6+VO+tejzTzagmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYZ4uoSn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a36126ee41eso734387866b.2;
        Mon, 04 Mar 2024 10:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709578220; x=1710183020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWFpKyxy2sK/uWQlofpzOWO2CjJJHb7rOXZzYRW1nfs=;
        b=OYZ4uoSnTZAv3stWqenFrq7Vs5gh9PNqk58IAmbc+51Y+BaExrnrV4IuaPijoZOsfu
         /CAIKsONkeb9/KlLmMQpHTQD0780Ef23ehZE+KALKCEKRfG+tgAk2dxN9/42XojvDyPD
         caKKtwHTwQ65kxo+ERkSRe5kWMGxp3jEB0gBK0NfdhGsMhhZCC67oLZq4DZ/MogViBoZ
         xvPM13M8aZnIyEhFK3hxzCYjfeCxBmYwoCXNocxyDir2/2Tx3X4OjEAnL+HxwMPAcaAd
         3v1unZf1cDti+uof1gFWQB7SBD1VAtP0axWS0AfDKiXd1pq949iwhH8SfqIYcZPbN61Y
         Wntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578220; x=1710183020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWFpKyxy2sK/uWQlofpzOWO2CjJJHb7rOXZzYRW1nfs=;
        b=AGfX25Np8A1uW34UKgOaup+qJwdY2hcbx4tmfP8j8iV8u6EZOMSfxxAVg2II6DABgv
         PHq0EyugKmrmfFDZj5HZTyPxBHumqBoBxROwXgPr683sIyQ3EglrzPLXR4E5AkzNYcka
         LRsfuiGgpV6VNO+cnffjo/tfcVQyw55L+4FAn+7Cih2xPOd4j4gmiNaPL0CV8edmZzrL
         WSPmBB4kxltqdXKOXFHPCIwzLgcRO5VoTwCFxBCoXiJ/kA4pd2+JjoTKXccjyO+Grry9
         NtIyBhaTx3dKfXkzv7L8AT78dSgYsvFXIqjhYsFBEiCHCqEZ3fGtbqHJxxTe1s5iCKOC
         qSAA==
X-Forwarded-Encrypted: i=1; AJvYcCVaeOLe8iJHoAcVdvJDeb8M31l48pUj/MvT6ipRyk4LVJC/97tgxKMOJkWtuE6vhhFnneDydmtVJlyUAAKCt5o3Ziu+OhIN3SYnACSlECuWTz0vLIKwDD3BKqAXwBwt+A221gg7u9YE
X-Gm-Message-State: AOJu0YzoqILskILxMZEKdAbFIb2CkAnUfQrkJxRSsh0VmImytMIjHvHu
	E0ws5Je1InNEitCT+wlYRsLEbfSAeDFFfNVBWzjqkjKQxsg38loC
X-Google-Smtp-Source: AGHT+IHm8GJoX6TNzaQwnr9sHfpUcgpcdudEaQyQa9XAN5AOYVBbefyqIcFs86MI0jUuUqg3DhSGqQ==
X-Received: by 2002:a17:906:c352:b0:a45:5c4a:2db5 with SMTP id ci18-20020a170906c35200b00a455c4a2db5mr1862119ejb.48.1709578220106;
        Mon, 04 Mar 2024 10:50:20 -0800 (PST)
Received: from vamoiridPC ([2a04:ee41:82:7577:d458:fb5d:c4e5:fb19])
        by smtp.gmail.com with ESMTPSA id ag3-20020a1709069a8300b00a44790d06d3sm4243212ejc.71.2024.03.04.10.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:50:19 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 4 Mar 2024 19:50:17 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, ang.iglesiasg@gmail.com, mazziesaccount@gmail.com,
	ak@it-klinger.de, petre.rodan@subdimension.ro, phil@raspberrypi.com,
	579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: pressure: Add timestamp and scan_masks for
 BMP280 driver
Message-ID: <20240304185017.GA3955@vamoiridPC>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
 <20240303165300.468011-4-vassilisamir@gmail.com>
 <ZeW048EyOAze7oZR@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeW048EyOAze7oZR@smile.fi.intel.com>

On Mon, Mar 04, 2024 at 01:47:47PM +0200, Andy Shevchenko wrote:
> On Sun, Mar 03, 2024 at 05:52:59PM +0100, Vasileios Amoiridis wrote:
> > The scan mask for the BME280 device which contains humidity
> > measurement needs to become different in order for the timestamp
> > to be able to work. Scan masks are added for different combinations
> > of measurements. The temperature measurement is needed for either
> > pressure or humidity measurements.
> 
> ...
> 
> > +enum bmp280_scan {
> > +	BMP280_TEMP,
> > +	BMP280_PRESS,
> > +	BME280_HUMID,
> > +};
> 
> Hmm... Why do we need to actually copy the IIO ones? Can't we use IIO ones
> directly (or in some way)?
> 

What do you mean exactly by copying the IIO ones? These values are used as
indexes to enable channels in the avail_scan_masks below. 
> ...
> 
> > +static const unsigned long bmp280_avail_scan_masks[] = {
> > +	BIT(BMP280_TEMP),
> > +	BIT(BMP280_PRESS) | BIT(BMP280_TEMP),
> > +	0,
> 
> No comma for the terminator line.
> 
> > +};
> 
> > +static const unsigned long bme280_avail_scan_masks[] = {
> > +	BIT(BMP280_TEMP),
> > +	BIT(BMP280_PRESS) | BIT(BMP280_TEMP),
> > +	BIT(BME280_HUMID) | BIT(BMP280_TEMP),
> > +	BIT(BME280_HUMID) | BIT(BMP280_PRESS) | BIT(BMP280_TEMP),
> > +	0,
> 
> Ditto.
> 
> > +};
> 
> ...
> 
> >  	const struct iio_chan_spec *channels;
> >  	int num_channels;
> > +	const unsigned long *avail_scan_masks;
> >  	unsigned int start_up_time;
> 
> Please, run `pahole` every time you are changing data structure layout.
> Here you efficiently wasted 8 bytes of memory AFAICS.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

