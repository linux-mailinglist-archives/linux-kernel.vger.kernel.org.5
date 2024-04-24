Return-Path: <linux-kernel+bounces-157336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD028B1000
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B711F233F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153CC16D323;
	Wed, 24 Apr 2024 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dMo1QBHt"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0493224E8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976500; cv=none; b=fFfVaoqAAK/KNoMA6fle/S6IVk0G16lC6LxmJGG4gQ4PeuA0vm+tfY57zQro2H7uIa8RSkFjzV+SBd1Eb/3TsskEPyw8Mrq6wlzlmIi79X5zs1WpC90beZFw8zABk/xSmnm5Xo5oYstXKcXV8SE4WPjR61ORJIThq9RghZHNie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976500; c=relaxed/simple;
	bh=iB+4XqNIdHt7yvtxsimmIldmqZ+s79xvMNaIc7fbl+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXu8YmOGcc6nr4VWaTRfsIrap8souxwx15skuYHR7LO+MyuadQwA2A5gunpTOdzhNRO21gObzJWBfBYbPLcDlxBAucIY+LewprnVCVO0GVgzu8bWbWYTJc4zmp1BziGFQCWsjtEdI5ePXJyifz9y56inYYo2+C3Q0ZPgUMALyCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dMo1QBHt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-518931f8d23so7755490e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713976497; x=1714581297; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zmM7lELFzDnGc6ZurObVedqGSv5yidRsKIMWiDcLanw=;
        b=dMo1QBHtMYfsf4ULtJhXA9C51awBvbVyYudqDfRrWx6k/Pbdq37k425ORLSJ9dposp
         /yUMzUQu3rLFzbDn6nzxwZ3yxUsv+wBJFBlQ1KGbBcZOhTuGaWg5066ND2GDmZS2y/py
         aNLdCf4i69yvym2pDNpmHtWJ93EbFixAXT0JBcTVZmbgq9n3ZzNQgepHAiqOLWYbXVT/
         34CwVrXoe7MG6/gCmDLz8CMy76kaRnLHDAZRve6Ha18rIVh7vuxQETT6JjZT7SY6t8K2
         LxwHQlaQWTFFbggDGv0kF3fGy8EjJ6vJbwznV0dMkEv9wTD9iDFJReYvQm26Wx1msaAJ
         UQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976497; x=1714581297;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmM7lELFzDnGc6ZurObVedqGSv5yidRsKIMWiDcLanw=;
        b=mVhO50EDkTR3NMxAU71iXhjIxaeoKWfTxcwSteNP7udqF9pT5LuROtnGNOlC3bbjFF
         2M3G1Gfxmn4FABqa2XIO9/+gTk7MkN6ZHQcXG733PR5hx6VwUHgIjjWD8VFEDYiHIFLp
         oUZ7x/xbh4EkELjW71EPJ/4VUl6+AnJR+JaTxQI9ymK8f3uuQALlu7uubEOUxD5dBXzl
         JRyIxd0q0HP0EZvbCaCgpPi8dCll5LBffvxZfkkSW4iDUhsfGUIX3ds0lgsjbtwE00n6
         uP+fkISXaCXODvdv7KDpvqFC35xWeE3xct+ohU3pxd7M0UkQGAssfbsyOD4qUdhAocZw
         VkjA==
X-Forwarded-Encrypted: i=1; AJvYcCXyCJQjXL38MwXsZU7K7Xh9SnanJSmOBIA1J+rXK8OHvfRIcWaK6pd22xlTJQNA5NnZY3ZdwmfKBJCW05RBZOKZ+7haL9XxOK0QYpdi
X-Gm-Message-State: AOJu0Yyn4zyrrEcBlRwl1efb60X26Ee2IWEyJhThgaQSej8u1KB6c0sd
	2wSPYl8Ncu5U+/lgWWRy+n4X3yNRa6FiWp/qOdT1YzWNjvmHMM6Ju+zIdZAwUM8=
X-Google-Smtp-Source: AGHT+IHEuFcRmsP4kFacjkpHRKtzhOGVaaVSjSmCp/pdIJ+sH4pCvIEVYuesx7A1/mQPkGI1d1iWBQ==
X-Received: by 2002:ac2:47e7:0:b0:519:1503:9566 with SMTP id b7-20020ac247e7000000b0051915039566mr1987909lfp.56.1713976496664;
        Wed, 24 Apr 2024 09:34:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id n9-20020a056512388900b00518fadeed0fsm2430866lft.115.2024.04.24.09.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:34:56 -0700 (PDT)
Date: Wed, 24 Apr 2024 19:34:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sui Jingfeng <sui.jingfeng@linux.dev>, dri-devel@lists.freedesktop.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] software node: Implement device_get_match_data fwnode
 callback
Message-ID: <kucey3jsydjye3ndflns3cqolcpizhnxgzz3fkmcatlnpbnwrk@22ulsqfh2vf6>
References: <20240422164658.217037-1-sui.jingfeng@linux.dev>
 <Zie3ebHOEpWHj1qV@smile.fi.intel.com>
 <d5bc1e73-a553-451e-ab74-f5f0ca259c6b@linux.dev>
 <hcltp2bbxxg2t7ibmzgiib7mgbwgmvzwnnq6mochdh7c4h76r3@bxj6yk5zq64e>
 <ZikE4qOVO7rgIs9a@smile.fi.intel.com>
 <CAA8EJpr1FSjizAh6Dp5Bmux3NrGYh=BfHFL4D1fa87Og4ymY0w@mail.gmail.com>
 <Zikck2FJb4-PgXX0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zikck2FJb4-PgXX0@smile.fi.intel.com>

On Wed, Apr 24, 2024 at 05:52:03PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 24, 2024 at 04:34:39PM +0300, Dmitry Baryshkov wrote:
> > On Wed, 24 Apr 2024 at 16:11, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Wed, Apr 24, 2024 at 12:37:16AM +0300, Dmitry Baryshkov wrote:
> > > > On Wed, Apr 24, 2024 at 12:49:18AM +0800, Sui Jingfeng wrote:
> > > > > On 2024/4/23 21:28, Andy Shevchenko wrote:
> > > > > > On Tue, Apr 23, 2024 at 12:46:58AM +0800, Sui Jingfeng wrote:
> 
> ...
> 
> > > > But let me throw an argument why this patch (or something similar) looks
> > > > to be necessary.
> > > >
> > > > Both on DT and non-DT systems the kernel allows using the non-OF based
> > > > matching. For the platform devices there is platform_device_id-based
> > > > matching.
> > > >
> > > > Currently handling the data coming from such device_ids requires using
> > > > special bits of code, e.g. platform_get_device_id(pdev)->driver_data to
> > > > get the data from the platform_device_id. Having such codepaths goes
> > > > against the goal of unifying DT and non-DT paths via generic property /
> > > > fwnode code.
> > > >
> > > > As such, I support Sui's idea of being able to use device_get_match_data
> > > > for non-DT, non-ACPI platform devices.
> > >
> > > I'm not sure I buy this. We have a special helpers based on the bus type to
> > > combine device_get_match_data() with the respective ID table crawling, see
> > > the SPI and I²C cases as the examples.
> > 
> > I was thinking that we might be able to deprecate these helpers and
> > always use device_get_match_data().
> 
> True, but that is orthogonal to swnode match_data support, right?
> There even was (still is?) a patch series to do something like a new
> member to struct device_driver (? don't remember) to achieve that.

Maybe the scenario was not properly described in the commit message, or
maybe I missed something. The usecase that I understood from the commit
message was to use instatiated i2c / spi devices, which means
i2c_device_id / spi_device_id. The commit message should describe why
the usecase requires using 'compatible' property and swnode. Ideally it
should describe how these devices are instantiated at the first place.

-- 
With best wishes
Dmitry

