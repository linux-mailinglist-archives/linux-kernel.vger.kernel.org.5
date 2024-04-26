Return-Path: <linux-kernel+bounces-160079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7828B38CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DF71F2271E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D5A1482E7;
	Fri, 26 Apr 2024 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEUL+j9E"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01053147C63;
	Fri, 26 Apr 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139115; cv=none; b=B6wpRB1HBxd76b5g9kiYgKdz+qh5URq3GEPAWPW3c+RR2RI1frl6sVDH/INX2BV5c8lQ2V4+GV/b9A3N1zu6NjY5gPQqyBWscCBRQb8WaZLxiL5Z6W7LgjOBGfZG9v1geRVxsAYHItvg/Qo9SJNfXZUx9CJHN1qIZnEF5g03tTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139115; c=relaxed/simple;
	bh=OzT1/9oISTl67fDxCXw/M+/aEXiDIcb72ojGQ3tkaX4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kRGRbGY5x1apUbt5LNxzZnvpytnJIUZ/QMq+7kOYrhO+XOsfZV4sRJhGz2QxMHgj/AtraA4KL/WigwW/VssgQcCBt1qvifHpMFbQyOLGw+iQNLWvxMEqM/0DDKzznHkEESTW9VTGjG2l99i8NP0B9egkrJnrOkg7Za3sBkO42pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEUL+j9E; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714139114; x=1745675114;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OzT1/9oISTl67fDxCXw/M+/aEXiDIcb72ojGQ3tkaX4=;
  b=DEUL+j9EW2ZyAca5/h45bVqBGXkU1uTtiKuHHKH0t+nkOvTnyvTSgvrk
   K1yfCYeYfeedWRm0vy1URxX8RRO9GGBpU+N4trQ96I1rl+fVMsqBV5hUg
   hk163uOzBUIwPMS3rtOa3EP91LP6pHJVZIcj1xnSndOlnbETYQD8shGxw
   hg3YZYz7EG6r508ANu8A4D7auWX2aUwmR/LIa63+jvKSLXIQjaV2DH08f
   aHyIT8oegbGaCCNphkff8aFKz8dlTP6VaBvij0zf9Q65ATHdRy5NHHgbs
   qbJborVwMAYBCePaAAZg4Qisioac3CQLQEkWnsx4RiU83BzaOVSCjDJYw
   Q==;
X-CSE-ConnectionGUID: 12HfRcLeSByO7NUpW0UYfQ==
X-CSE-MsgGUID: q6WpUZ6nQlmtnkXjV3W/og==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9987225"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="9987225"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:45:13 -0700
X-CSE-ConnectionGUID: tWv2y6TqT123dc69raLdfQ==
X-CSE-MsgGUID: Y9QkQZEYRN6sdY3fVDTSuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="56350305"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.43])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:45:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 26 Apr 2024 16:45:06 +0300 (EEST)
To: lumingyindetect@126.com
cc: LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
Subject: Re: [PATCH] serial: 8250_lpss: Fix memory leak in lpss8250_probe()
In-Reply-To: <20240426114716.1275085-1-lumingyindetect@126.com>
Message-ID: <c6df7432-a76a-54e3-32f8-a94e9a18a3a3@linux.intel.com>
References: <20240426114716.1275085-1-lumingyindetect@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 26 Apr 2024, lumingyindetect@126.com wrote:

Hi,

Your patch should have had now (the version is missing):

Subject: [PATCH v3] serial: 8250_lpss: Fix memory leak in lpss8250_probe()

> From: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
> 
> In the execution logic of the lpss8250_probe() function, the function may directly return via a return statement at either line 347 or line 351.

Don't refer to line numbers and state too obvious things, effectively cut 
the "via a return statement at either ..." part out.

Like I already mentioned, there should be newline characters so that you 
don't exceed 75 characters.

> Unlike lines 357 or 361, where the return statement is used directly without releasing the dynamically allocated memory region pointed to by the variable pdev, causing a memory leak of the variable pdev.

Perhaps add part of this into the previous sentence (and again leave the 
talk about line numbers and return statement out of it, we all know that 
returning is done via return statement so it's uninteresting detail):

"... may directly return without releasing ..."

> In the lpss8250_probe() function, I added a label named "free_irq_vectors" to release the dynamically allocated memory region pointed to by the variable pdev, and replaced the two return statements mentioned above with goto statements to this label.

This is quite verbose way to state what can be read from the patch itself. 
Perhaps something like this can be used as replacement:

"Fix the issue by rolling back irq vector allocation."

> Fixes: e88c4cfcb7b888ac374916806f86c17d8ecaeb67

This gives you some examples:

git log | grep 'Fixes:'

Further information also available under Documentation/process/.

> 

Don't leave empty line here between Fixes and S-o-b tags.

> Signed-off-by: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
> ---

And here you should have listed changes you've made for each version (see 
ML archives for examples):

v3:
- ...

v2:
- ...

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


