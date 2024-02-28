Return-Path: <linux-kernel+bounces-85179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE1D86B1B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E98B1C259D5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4648415A48E;
	Wed, 28 Feb 2024 14:24:49 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62038159589;
	Wed, 28 Feb 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130288; cv=none; b=KClLve5lkKO5aogoXkXgg646Eur4/e3ocj2/arbNpXxhuYhmFVzPPjAFMEsCmfK4Zine4KyYDLALSCao1jyv96ptEQIUELQIY7frU/5kgSIQM6zilXw3fFjaqcgdNZ61CubPVcscIjrdvSkX06wI3Lu7Q6wVF5zAn8Z+JCI7I04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130288; c=relaxed/simple;
	bh=pRzq8HG/Yov3i+0nNUEbFITL218UFSc1UWUM1H32W08=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3+yu9edJvzGNjmu+1lHF0brGMU9X9osyIJ4h6Vb6Ck0onXZUPfUbRvFANaGRjpirzVIA+iiMN4Z9dSvbA0k3fnmBrcyNLvYQlzc4NRRrQSQKPrlTpE38SfqSYwSb1QmU5FTpxaWsFiR5bdRgmziYQxnxJQ4jAuFa8MUYI257YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TlGhg5GT7z6J9yk;
	Wed, 28 Feb 2024 22:20:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 50B9F1412F1;
	Wed, 28 Feb 2024 22:24:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 28 Feb
 2024 14:24:42 +0000
Date: Wed, 28 Feb 2024 14:24:41 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Jonathan Cameron
	<jic23@kernel.org>, Syunya Ohshio <syunya.ohshio@atmark-techno.com>, Guido
 =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>, Lars-Peter Clausen
	<lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: industrialio-core: look for aliases to request
 device index
Message-ID: <20240228142441.00002a79@Huawei.com>
In-Reply-To: <Zd7qz1Qte8HWieF_@atmark-techno.com>
References: <20240228051254.3988329-1-dominique.martinet@atmark-techno.com>
	<7f03bb12-0976-4cb7-9ca9-4e4e28170bdd@linaro.org>
	<Zd7hSOw3_zosyrn3@atmark-techno.com>
	<daed8ada-9e01-41ad-82af-5da5cbbc865c@linaro.org>
	<Zd7qz1Qte8HWieF_@atmark-techno.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 28 Feb 2024 17:11:59 +0900
Dominique Martinet <dominique.martinet@atmark-techno.com> wrote:

> Krzysztof Kozlowski wrote on Wed, Feb 28, 2024 at 08:42:46AM +0100:
> > >> Sorry, that's why you have labels and compatibles.  
> >  
> > > Setting up a fixed alias seems to be precisely what aliases are about
> > > (e.g. setting rtc0 will make a specific node become /dev/rtc0, same with
> > > ethernet0, gpio, i2c, mmc, serial...), I'm not sure I agree a new label
> > > would be more appropriate here, but perhaps I'm missing some context?  
> > 
> > Maybe I don't get your point, but your email said "sysfs", so why do you
> > refer to /dev?  
> 
> I wrote /dev/rtc0, but it also sets the name in /sys, right?
> For example /sys/class/rtc/rtc0
> 
> As far as I'm aware iio also creates character devices in /dev with the
> same name (/dev/iio/iio:deviceX), but our application doesn't use these
> at all and has to? look in /sys directly, so normal udev SYMLINK+=
> unfortunately isn't applicable or I wouldn't be bothering with all
> this..

A given IIO device driver may create multiple sysfs directories (registers
device + one or more triggers), so I'm not sure how this would work.

> 
> > > I'm not sure I understand this comment -- would you rather this doesn't
> > > use aliases but instead add a new label (e.g. `iio,index = <10>` or
> > > whatever) to the iio node itself?  
> > 
> > No, the devices already have label property.  
> 
> Thank you for pointing me at the 'label' property, looking at other
> subsystems e.g. leds I see paths in sysfs that use labels as I'd like it
> to work for iio (/sys/class/leds/<label> and
> /sys/devices/platform/<parent>/leds/<label>)
> 
> Unfortunately for iio it looks like labels isn't ignored, but instead
> create a file in the sysfs directory of the device, e.g. I now have
> /sys/bus/iio/devices/iio:device1/label which contains the label string,
> so I'm not sure that can be changed easily as that'd be a change of API
> for existing users for labels in iio devices?

Yes, don't touch that ABI.  IIO software assumes naming of
iio\:deviceX etc.

> 
> (I checked briefly and didn't find any, but there seems to be an awful
> lot of code in the iio drivers tree about labels so I'm not really
> comfortable changing that without some more background on iio first...
> Jonathan perhaps has an opinion on this?)

There are labels for channels as well as devices, but the short description
you have above is it.

I don't see why that isn't sufficient for your use case though?
What does a directory name matter when you can write a few lines of
code to retrieve the IIO device that you want.

If this was day 0 maybe we could support renaming devices like this
but we have a long history of those names not being stable and label
+ parentage of the IIO devices being used to establish stable identification.

Anything beyond a trivial single use script is going to need to deal with
not having stable names (old kernel, dt without alias etc) so this doesn't
help in general.

Jonathan

> 
> 
> Thanks,


