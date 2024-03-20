Return-Path: <linux-kernel+bounces-109306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD1888176E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A339C1F22748
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C0B8529B;
	Wed, 20 Mar 2024 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4mRI5wQ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE2652F78;
	Wed, 20 Mar 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960323; cv=none; b=bUGrmOM4CkT3GsT0oiA2IVlivlJfo8tOFEQrKXBoynIk6TqzZM3xI0etoYpXDugjp991bjTfn3UVdSXqzNzjqI5Aar89MFSf3tfOg4UnAPtGBzP1/HByarF9tqGKNM+NUdauao2Jtp3ZmWV+/tdzyRruaFRv2JtlLzthEgzLBcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960323; c=relaxed/simple;
	bh=IIoFYLWjjgoGol2FMUHfgDpjuS9/7LVzzfTTe9iYYnY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJnf5VJkfFYQP/IdF8xxdIIefN+M+F6QOwuUnRsA43e7uDGAVo+giI75iPc1lh0OxxG3wZrS7ypw7TH50GpLpXLUXj54clM+GsjMybuE+hcQEuEoT1sxBkJPRJ4AxO43+Fj7Gbq44sBoO69B0MPh0X41+h9DpXuJIvtEom6teKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4mRI5wQ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513a08f2263so204889e87.3;
        Wed, 20 Mar 2024 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710960320; x=1711565120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Afz0eCjmB5LW6m89O9fLaUrWwF2XDDN/YPKtH4GdqXE=;
        b=B4mRI5wQ9GIGwSk6R5yg+055XA2+UfbWMS8TIedYWQVmoZdQP6A97nDRHbWhh3yDDJ
         6I7hMXTAG1w1PpEykga8yDJwg1fb08ih1yZszGe7x0qDUzzty7FYtcQFzMVsFKKAiEuj
         geTsj0W/C4AulYTHnRP+fhAgJ8YneLqT0sBLqm6PNmyHBS3+zm4nnsZXZEglHas22XrK
         m1BCsJclnUHya+EghQasHYzh6extHWbBUihjfquUNpMQhGf/6i5sMuNccw15aTvvqhhY
         cUidUcKewBgMNZbrIHPEJydlEXErOOwKs9o3am6q9zt381mJE/MDMqFRh0ZJTEWyK4bN
         EGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710960320; x=1711565120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Afz0eCjmB5LW6m89O9fLaUrWwF2XDDN/YPKtH4GdqXE=;
        b=ofgu+ROMaUhYKHojj+E56fwWL8UO0XdwC5XqubtaCf7t/ud44MkPa0gR9TDMGTgaMG
         T4MAxcaGK/2krsB0IdVhPcxwnwoF90VEUpiipXOYzE5DzByQsu0eXXV2QU6FNuz6R66S
         MKaVf41hWlGRjOkd1S48RvQsJolN0MMFIBMwQFn2hpdG45XMakts8Lz5ZdqqyBkOVR8K
         8Ql2lrs64IWe//vf48YhhmBEJMqs2PFpOINH6U/4rQl2S4GUHTc970el0gsDQxd4oFHx
         vekUYvlVdpcO6qNvvR4j7P/6btLIA33/ppUUd/VMi1dIB3KbMJcVmyQ+cFxHfPVj0iAF
         gGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyZZayeFprHrWh8QpMVCnrvxgpSQZlVGgsBBeXeILp1MNlyWQfXcxC6IPDm5T5fRXVHdXZREqwFwrBcQW+wEZPqgDicBWUC8Jb+GDPIddzaev2pXKkxH4T9C2wYijdbnTMfDOyQ/gW
X-Gm-Message-State: AOJu0YyXcBlkFisIawrqB+LhABYKuqjXDP5oBedxofKHXIb3uelju40h
	STTugXeZx7dfkp9Jbk4J+qJIaXYJrH4EpKCwtMSZ0aYSU28lwH3/
X-Google-Smtp-Source: AGHT+IGAzxTDRvMWWm8SlK54TTSL+cl6Rn4zD6aAd2YVvVB4w+OYGkDfhXBbRBVox1R2SW/YCddGxw==
X-Received: by 2002:a05:6512:310c:b0:512:ee61:c32b with SMTP id n12-20020a056512310c00b00512ee61c32bmr4967422lfb.43.1710960319670;
        Wed, 20 Mar 2024 11:45:19 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:9be1:7bef:ff5c:57fc])
        by smtp.gmail.com with ESMTPSA id jx25-20020a170907761900b00a4661f0f1e7sm7554317ejc.205.2024.03.20.11.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:45:19 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 20 Mar 2024 19:45:16 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, ang.iglesiasg@gmail.com, mazziesaccount@gmail.com,
	ak@it-klinger.de, petre.rodan@subdimension.ro, phil@raspberrypi.com,
	579lpy@gmail.com, linus.walleij@linaro.org,
	semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: pressure: Add timestamp and scan_masks for
 BMP280 driver
Message-ID: <20240320184516.GB36450@vamoiridPC>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
 <20240319002925.2121016-6-vassilisamir@gmail.com>
 <ZfrDW1ESxnFg__od@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfrDW1ESxnFg__od@smile.fi.intel.com>

On Wed, Mar 20, 2024 at 01:07:07PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 19, 2024 at 01:29:24AM +0100, Vasileios Amoiridis wrote:
> > The scan mask for the BME280 supports humidity measurement and
> > needs to be distinguished from the rest in order for the timestamp
> > to be able to work.
> 
> ...
> 
> > +enum bmp280_scan {
> > +	BMP280_TEMP,
> > +	BMP280_PRESS,
> > +	BME280_HUMID
> 
> The last is not a terminator, please leave trailing comma.
> 
> > +};
> 

What do you mean it is not a terminator? In general with the enum
variables I would write:

	enum var { a, b, c };

Why in this case there is a comma needed after the BME280_HUMID element?

Cheers,
Vasilis
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

