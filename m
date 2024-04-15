Return-Path: <linux-kernel+bounces-145081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EEF8A4F50
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9253B1F21C53
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182336F525;
	Mon, 15 Apr 2024 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmWrVLm2"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F3766B5E;
	Mon, 15 Apr 2024 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184934; cv=none; b=h7xheJlZ0dKPujUbK0fBH/AYF6v/Gf/GB5bzDlJDySZTkap0CTqjFM1M5aPwpb3qt5+NF9Nap7eSBGBDT1k+AZFnY8zB7R5DY9H39rIw0bn8DFR3CLsY61X6XxV/V4tZrTLqnLJScRtXzy7RzWEomW3Sxwm/5/beSDXKUmvHwSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184934; c=relaxed/simple;
	bh=yQhjbkjo0NZSRx3zaq2JlNEh5TJYvMzKERWxygHdDOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQllJKyQXEUG6w6bcQNB4HO0uSoO1xyMt8AIm2oYGFK5BebuqWacPIjbq+C2KMLBpqgyFNiC0h7B33z39LczXPHiiRfpn+BK2tmLVA4mFR0oVG7Vf9lYKp3OsnSbAdjNqI32j+lNhJ+z2u3LTTx7Ssn03/xqmniPzRzhHySkrqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmWrVLm2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso2578282b3a.3;
        Mon, 15 Apr 2024 05:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713184932; x=1713789732; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iuXJvJZy0hgr1HZAIhpBPUNdepR9wuSmPEwveDWvDBQ=;
        b=nmWrVLm2EzywxctzF6ASZIqBHni3+28tRYiGVRGBQRmYKeg+Ibwf6NtOYGd0C+nML6
         znmfNkpNeO7gmUUwUB7cW/jOMIe8DAeGyPiVf+JCc8Tav6we6YgexE3M9DYMr/KBHwcZ
         nc4QuexXkmc3Z0KjtZoh3YcD80Osr9sJYgQsOrXTG/2V+NIghlILjBjM5/tgBlg446M2
         V9qzaz/oBxBZvF1S357UI0reBTBnTr2yVFrbyw/Rj61lN6wTnSYeX6nGohuSFZEkTW4R
         2v8NFLqZjbudvFzr3O1T6bzaqwLH2XsZyJFKtQYfiUsqJYLZCyCzNRDdd6DYRgbCUXl+
         ZBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713184932; x=1713789732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuXJvJZy0hgr1HZAIhpBPUNdepR9wuSmPEwveDWvDBQ=;
        b=DElqWniOKhHDpGqan3crqA+Mppg5gl53yrFXi+v55S+PiE0D2jaeLhT6wGoSkmWx52
         8sqQEjke4ny6X/E0K7iNdtEHXvOX0vDHPVxEzRBVJLOPbu7c99tdbZn7zbWoNB+HCGTU
         QEt8RTBGdGptLWx6oowj7wngpItOPfU/R/rC5XxXeeg80vV9W47rUqgXlg86yzoEFfhv
         MrgfsekKCXV6dgVVmm9IzNXE8A4MHEIdG7fvdoWhrpbtldp+Zz0b/KRPTA330vcZDmg1
         kwravS4zwmiUs4CkC1uv1JBzCGx/4Ldjvbjx7ZmQ+315P2HqzWiDPv5EVlCFHcL89nil
         ls1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+qN8PEe3WIlxhKfGY+fhJcjJ/ui18dqmL3yH7yrPVCDUMusv2SI0fPil96WrSrDgxl1mvv4owpwN0+ZFHyyaevqap7eN5COQr8m+Ppxnquo98jmmbGqhk16lbZ65dfLN9WcsZzOzwyVqV1XC2PWxhsVfSzvL5MW7gqZESMY9V9+FRg==
X-Gm-Message-State: AOJu0YwySBXxwGdH9/VFxtP77q/bnmcQe4y3CJNQoW0BXd+72WyAYe70
	5AA8/2SavMi/ezt4etug9wRMXopLuWu/diNp0YewgNBpssGGJSxT
X-Google-Smtp-Source: AGHT+IEntR9/uVd4/eIk4MWEyWZzG/S+a5yzcbYj8tQjojJKxIJo8eQ7AdW3d7el429M+y5zptlpqw==
X-Received: by 2002:a05:6a21:6711:b0:1a9:ac49:ea94 with SMTP id wh17-20020a056a21671100b001a9ac49ea94mr6616443pzb.61.1713184931965;
        Mon, 15 Apr 2024 05:42:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b12-20020a056a000a8c00b006ed64f4767asm7116905pfl.112.2024.04.15.05.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:42:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 15 Apr 2024 05:42:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Neri, Ricardo" <ricardo.neri@intel.com>
Subject: Re: [PATCH 3/3] hwmon: (coretemp) Use a model-specific bitmask to
 read registers
Message-ID: <d807bb47-7501-4423-9a8f-d51b5349c96b@roeck-us.net>
References: <20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com>
 <20240406010416.4821-4-ricardo.neri-calderon@linux.intel.com>
 <6411e721a1cd559f59aecd8ac57a941cdaa13ff1.camel@intel.com>
 <20240415011946.GA12551@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415011946.GA12551@ranerica-svr.sc.intel.com>

On Sun, Apr 14, 2024 at 06:19:46PM -0700, Ricardo Neri wrote:
> On Sun, Apr 07, 2024 at 08:24:40AM +0000, Zhang, Rui wrote:
> > On Fri, 2024-04-05 at 18:04 -0700, Ricardo Neri wrote:
> > > The Intel Software Development manual defines states the temperature
> > 
> > I failed to parse this, is the above "states" redundant?
> 
> Sorry Rui! I missed this repy.
> 
> Ah, the commit message is wrong. I will do s/defines//
> 
> > 
> > [...]
> > 
> > > digital readout as the bits [22:16] of the
> > > IA32_[PACKAGE]_THERM_STATUS
> > > registers. In recent processor, however, the range is [23:16]. Use a
> > > model-specific bitmask to extract the temperature readout correctly.
> > > 
> > > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > > index 616bd1a5b864..5632e1b1dfb1 100644
> > > --- a/drivers/hwmon/coretemp.c
> > > +++ b/drivers/hwmon/coretemp.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/sysfs.h>
> > >  #include <linux/hwmon-sysfs.h>
> > >  #include <linux/err.h>
> > > +#include <linux/intel_tcc.h>
> > >  #include <linux/mutex.h>
> > >  #include <linux/list.h>
> > >  #include <linux/platform_device.h>
> > > @@ -404,6 +405,8 @@ static ssize_t show_temp(struct device *dev,
> > >         tjmax = get_tjmax(tdata, dev);
> > >         /* Check whether the time interval has elapsed */
> > >         if (time_after(jiffies, tdata->last_updated + HZ)) {
> > > +               u32 mask =
> > > intel_tcc_get_temp_mask(is_pkg_temp_data(tdata));
> > > +
> > >                 rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax,
> > > &edx);
> > >                 /*
> > >                  * Ignore the valid bit. In all observed cases the
> > > register
> > > @@ -411,7 +414,7 @@ static ssize_t show_temp(struct device *dev,
> > >                  * Return it instead of reporting an error which
> > > doesn't
> > >                  * really help at all.
> > >                  */
> > > -               tdata->temp = tjmax - ((eax >> 16) & 0x7f) * 1000;
> > > +               tdata->temp = tjmax - ((eax >> 16) & mask) * 1000;
> > >                 tdata->last_updated = jiffies;
> > >         }
> > > 
> > Besides this one, we can also convert to use intel_tcc_get_tjmax() in
> > get_tjmax().
> 
> I thought about this, but realized that the bitmask of TjMax is always
> [23:16]; no need for a model check. If anything, intel_tcc_get_tjmax()
> would remove some duplicated code. But coretemp.c would need to depend
> on INTEL_TCC, which seems to be a non-starter.
> 

Calling intel_tcc_get_temp_mask() in practice already introduces that
dependency because it returns a fixed mask if INTEL_TCC is not enabled.
If that doesn't matter, the dynamic mask is unnecessary to start with.

Guenter

