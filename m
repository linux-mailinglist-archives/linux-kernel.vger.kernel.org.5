Return-Path: <linux-kernel+bounces-159755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D04F8B3397
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCC71C21A09
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1CF13E043;
	Fri, 26 Apr 2024 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tf02vT6Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389613D500;
	Fri, 26 Apr 2024 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122415; cv=none; b=MT9s4zS+AxQAYQzUQ/6WCksxIbZ5z6wD2dftsze9n/M9yn66Y2tHNJN3SiZuuXJnsv9znKa8AI3rKvfk34WTvRozkyp3lzkMwqeRznC/awI1k3uXxis1/kBtI5EmYhPrTZkmwAMmQIxs6z0Mlnp5lnHEBWnOnnGOK3AOzW6AvLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122415; c=relaxed/simple;
	bh=+A+wN+Waa3u+GSAaOXj5u/i6Q2N/50vS3XJI5nCkpCQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fmjlsGu126f0D38ZjLR7WmQmEpQK4sGIxasJDZ1ZOQwMaN6FvfEWOAqa+01mvPq88HfNPr7wiyJrK3rwIx4CH3VdbQ1UvCgCwiAwwYXH24aypJVMOMnOeh4Mk/IFJ6aRfPgQK8NLJGCbnbk6WAYA5TiaaFVXn95eFpegDsI47uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tf02vT6Q; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714122413; x=1745658413;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+A+wN+Waa3u+GSAaOXj5u/i6Q2N/50vS3XJI5nCkpCQ=;
  b=Tf02vT6QWJlDCRf6Gzfb3fOT1TSG4++b4TQYIF+Kxgq8SinP4JOPpuZr
   iK8AvWJsbJVCvOzdVkoxPMVEUzpWdMndIB738vDWmJj4hk0We6WGotKrY
   W9TEaRDZyY0iQTxu0hBxTOrfa4XVO/JRURL+YSW7NcYMLavNuF2/4UOWx
   px6Xk0NxedN5Q5WxY2T9iIzbXlvU59nrDmhs8IAMyYEJBKjcl99MU5IoK
   4xlV8hi928F3uV+gyECiBPyzMTgWEbvSuTji6po46XVDDeomnkclZn7zk
   4x2X9/+kb8GmZVmf3GcYsNDnc8JHHhWc3VZXQZkXJzMoEPrGykZ+YmbqO
   w==;
X-CSE-ConnectionGUID: md4oKigeRzKk8FI8j84qxw==
X-CSE-MsgGUID: C5+M3sRbQCKuhc6TOHKKgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="10384430"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="10384430"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 02:06:52 -0700
X-CSE-ConnectionGUID: 8CNiV51sRYOLvzTmgMUIcA==
X-CSE-MsgGUID: KYE62ThXSw6c0mT7w0LGuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="29809989"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.43])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 02:06:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 26 Apr 2024 12:06:45 +0300 (EEST)
To: lumingyindetect@126.com
cc: LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
Subject: Re: [PATCH] "drivers:Fixed memory leak in /linux/drivers/tty/serial/8250/8250_lpss.c
 file.
In-Reply-To: <20240426021939.1083521-1-lumingyindetect@126.com>
Message-ID: <1ed76406-443d-63e2-3b3b-f6528a13f95a@linux.intel.com>
References: <20240426021939.1083521-1-lumingyindetect@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 26 Apr 2024, lumingyindetect@126.com wrote:

> From: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>

Use:

git log --oneline -- drivers/tty/serial/8250/8250_lpss.c

to learn what prefix you should use for shortlog (on the subject line). 
Beyond the correct prefix, don't use filename in the shortlog at all.

"Fixed" -> "Fix"

"in xx file" is awfully generic, please be more specific where the leak 
is.

> In the lpss8250_probe function in the file /linux/drivers/tty/serial/8250/8250_lpss.c, there were certain return paths where pci_free_irq_vectors was not called to release memory related to pdev, leading to a memory leak. This commit fixes that issue." 

- Wrap this properly.
- Don't write full paths like that.
- Put () into description when talking about functions.
- Use imperative language, don't use "This patch ...".

- Add Fixes tag

> Signed-off-by: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>

> ---
>  drivers/tty/serial/8250/8250_lpss.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 776ec1ef29d6..2bb86f9cad5b 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -344,11 +344,11 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	uart.port.mapbase = pci_resource_start(pdev, 0);
>  	uart.port.membase = pcim_iomap(pdev, 0, 0);
>  	if (!uart.port.membase)
> -		return -ENOMEM;
> +		goto early_err_exit;
>  
>  	ret = lpss->board->setup(lpss, &uart.port);
>  	if (ret)
> -		return ret;
> +		goto early_err_exit;
>  
>  	dw8250_setup_port(&uart.port);
>  
> @@ -367,6 +367,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  err_exit:
>  	lpss->board->exit(lpss);
> +early_err_exit:

This label could be more specific that it's about freeing the vectors.

>  	pci_free_irq_vectors(pdev);
>  	return ret;
>  }
> 

-- 
 i.


