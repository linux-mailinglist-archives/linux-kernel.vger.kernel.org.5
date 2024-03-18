Return-Path: <linux-kernel+bounces-106115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA0887E959
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A2228350C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970332FE0F;
	Mon, 18 Mar 2024 12:30:54 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7551B1EF18;
	Mon, 18 Mar 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765054; cv=none; b=TtSiOTqhlOz339sH27ATSyuKMydJ2/HL6IqKz+jv3QxbcWRHjgug5OhTZLGhHdvXVueilHt0YpCf2xL88kFl9WpYQiVvd784g3k/q9ptkoX0OD+FpcvFDW/9ailaQ5EqdeYsHq7HAueJI0a4STk9Y2VJ5uwrCT4ES3wkc7k+2Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765054; c=relaxed/simple;
	bh=0oFjsR8UMfssqHaMgHT3LLZ1XLAc6e6F+5fJPvG3290=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fp53wZBl7+PA5uuTGZOuYTBqiAMDretLMncHM5BcXOlY8ohCwMtpzrnPBK9J4nJlKDt2gL1m8L5Tl4N2fCrBnQa88HtG5y+PBIlQHK7MjXd54UzJN96tvIMmJ8d1jRlqrN0CWj5+HZGInucmrPKxYytATr4R61g93jecwc0eTVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TyvM83LKRz6JBZp;
	Mon, 18 Mar 2024 20:30:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C0D73140A78;
	Mon, 18 Mar 2024 20:30:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Mar
 2024 12:29:54 +0000
Date: Mon, 18 Mar 2024 12:29:53 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
CC: David Lechner <dlechner@baylibre.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Jonathan Cameron <jic23@kernel.org>, Syunya
 Ohshio <syunya.ohshio@atmark-techno.com>, Guido =?ISO-8859-1?Q?G?=
 =?ISO-8859-1?Q?=FCnther?= <agx@sigxcpu.org>, Lars-Peter Clausen
	<lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: industrialio-core: look for aliases to request
 device index
Message-ID: <20240318122953.000013f3@Huawei.com>
In-Reply-To: <ZfejyEvPIncygKJ9@atmark-techno.com>
References: <20240228051254.3988329-1-dominique.martinet@atmark-techno.com>
	<7f03bb12-0976-4cb7-9ca9-4e4e28170bdd@linaro.org>
	<Zd7hSOw3_zosyrn3@atmark-techno.com>
	<daed8ada-9e01-41ad-82af-5da5cbbc865c@linaro.org>
	<Zd7qz1Qte8HWieF_@atmark-techno.com>
	<20240228142441.00002a79@Huawei.com>
	<Zd_zB_ymxkx0HB3q@atmark-techno.com>
	<ZfPg-nMANUtBlr6S@atmark-techno.com>
	<CAMknhBG_kJx8JPvTBQo7zpy3mFAkUjZpRY3DLBfXt+39nRJWiA@mail.gmail.com>
	<ZfejyEvPIncygKJ9@atmark-techno.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 18 Mar 2024 11:15:36 +0900
Dominique Martinet <dominique.martinet@atmark-techno.com> wrote:

> David Lechner wrote on Fri, Mar 15, 2024 at 10:53:36AM -0500:
> > How about using udev rules to create symlinks for each device based on
> > the label attribute? No changes to the kernel are needed.  
> 
> Right, it's definitely possible to make symlinks for each "device" -- my
> patch comment links to such an udev script "solution":
> https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-core/udev/files/verdin-imx8mm/toradex-adc.sh?h=kirkstone-6.x.y
> (the script is launched by udev here:
> https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-core/udev/files/verdin-imx8mm/99-toradex.rules
> )
> 
> My conceptual problem with this is that this makes symlinks in /dev to
> files in /sys and it feels like we're crossing boundaries.
> As far as I can tell there is no way for userspace to create arbitrary
> symlinks in /sys, so I think we could have an interface more
> user-friendly by allowing paths to be static for users with multiple
> devices.
> (I guess that's a weak argument given e.g. disks etc will also have an
> unreliable name in /sys in the general case, but simple programs don't
> interact with them in /sys and can use stable links in /dev so my
> expectations here aren't quite the same)
> 
> 
> Ultimately, the problem might run deeper in that we're having userspace
> interact with the device through /sys and not the /dev char dev... As
> far as I could see /dev/iio:deviceX only allows reading buffered values
> and doesn't have any ioctl or other way of reading immediate values as
> is possible in /sys though, so that'd require quite a bit of work to
> duplicate the interface there...

Don't.  The sysfs interface as only control is entirely intentional and
we do not want IOCTL based duplication.

Just addressing this bit as I'm still a bit snowed under to think about this
more generally.




