Return-Path: <linux-kernel+bounces-159911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26068B3614
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882A81F214AD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9576F144D3F;
	Fri, 26 Apr 2024 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdakEkNm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DA1448C0;
	Fri, 26 Apr 2024 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128708; cv=none; b=WmRp1kVGP1Q2aVVPiXKbFGGau6K5K+/odDKeFEpUsvpgO/TyxS9v+oq+7U3SgN7BgzpKV40sPGq7s+FjDhhsTmtt3iNfz+h9YEZF6jmi8UuSAKenPgUX2n9f58DPrhLHFfCsDFQ+cautZTrWlI3zis/DVl3eMhQinIboGq28d58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128708; c=relaxed/simple;
	bh=F7/0p0viB4fCK8ImI6PRs/n4wSopc0v7ppeGo6pKuYQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lwdunoCK1SCj1IkfNJsbgH6zh9wDJ9y94uW8+/rchR4uV/p3awurTicTc82V8yVYoT8kMRXOaocSXTRGtk7JtJu7Of+jOWMnyPdkxYO4QufMLuTCf9joGNUtyh7Ei8UtQZtgo6N2QSkqtE//g/UEA1Qzs5wZPce8KF1gkAFhErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdakEkNm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714128706; x=1745664706;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=F7/0p0viB4fCK8ImI6PRs/n4wSopc0v7ppeGo6pKuYQ=;
  b=OdakEkNmYLeNxtr7aLU3xOREDumNTCjotWB9zqOA7mjgjKX2ZxWb04lS
   fJ91aQVwJBjxR5VgcrDcu852O9ensaRDzGojR7qKH5ToBdrXBl17MX81X
   bgYE5dCV02JbwGg5FMOlbwWkv4iICk/KktGLJgAnZBRoruy5lqIoeb2bM
   omxuM+0mBxAkUplAXmmXs1NTdJr1kplEVOK3eE9YAtfI/Re/kD69eXP9i
   6lDYR+a4G+VMarYFLwrN/fiez/NIVpNkJCsxbc2e3jI/kDf+POhlbC/1p
   0/WQ4LYNHbwj6IPW9K4dam1q4X4KNwQ26oEl7IhXTTaNc6kxalf7YQaGY
   Q==;
X-CSE-ConnectionGUID: sPCilrY1T8iPh9NxgXuG9A==
X-CSE-MsgGUID: LsHNVpMhSVKSGVwlmTXwNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20546301"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="20546301"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 03:51:45 -0700
X-CSE-ConnectionGUID: U20o4/gzTHa/C6ijBtIRvw==
X-CSE-MsgGUID: US2qCHoVT8+owcn7ICSj9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="30200794"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.43])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 03:51:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 26 Apr 2024 13:51:40 +0300 (EEST)
To: lumingyindetect@126.com
cc: LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
Subject: Re: [PATCH] Fix a memory leak in the function lpss8250_probe
In-Reply-To: <20240426104535.1238368-1-lumingyindetect@126.com>
Message-ID: <79a30533-7504-9a53-8f8a-ca16817c1ee5@linux.intel.com>
References: <20240426104535.1238368-1-lumingyindetect@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 26 Apr 2024, lumingyindetect@126.com wrote:

> From: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
> 
> In the lpss8250_probe function in the 8250_lpss.c file, the program may directly return at either line 347 or line 351, without jumping to the error handling label to release the dynamically allocated memory region pointed to by the variable pdev, as done at line 357 or line 361. This fix introduces a new label named free_irq_vectors to release the dynamically allocated memory region pointed to by pdev, thereby fixing the memory leak defect.

Hi,

You left most of my comments unaddressed. :-( Please don't send a new 
version unless you've addressed all the comments.

> Signed-off-by: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
> ---

You also need to name version of the patch on subject line and provide the 
version history here underneath --- line.

>  drivers/tty/serial/8250/8250_lpss.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index c3cd6cb9ac80..fa9fd4dc86c7 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -344,11 +344,11 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	uart.port.mapbase = pci_resource_start(pdev, 0);
>  	uart.port.membase = pcim_iomap(pdev, 0, 0);
>  	if (!uart.port.membase)
> -		return -ENOMEM;
> +		goto free_irq_vectors;
>  
>  	ret = lpss->board->setup(lpss, &uart.port);
>  	if (ret)
> -		return ret;
> +		goto free_irq_vectors;
>  
>  	dw8250_setup_port(&uart.port);
>  
> @@ -367,6 +367,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  err_exit:
>  	lpss->board->exit(lpss);
> +free_irq_vectors:
>  	pci_free_irq_vectors(pdev);
>  	return ret;
>  }
> 

-- 
 i.


