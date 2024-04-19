Return-Path: <linux-kernel+bounces-151470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BB18AAF4D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED213B22DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51414127B7B;
	Fri, 19 Apr 2024 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qekj9SK+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2415685943;
	Fri, 19 Apr 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533267; cv=none; b=CzAQ2elanqSEnj21G8JJ5ktXqD2r+lbOyyqMmQSSeNAq7zUkaVIZTk1uD90PR/zjMNMp4qgQeQdET83EoQ7dpSjvFQb/rvCINFN6lNMC2pAoD+CyHr0le6TawErGDuWnM0EVqSIomNyw1eEzATDuP/+rlr0bg7ydPQY7C/65b1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533267; c=relaxed/simple;
	bh=tAjbLsXIapgYTL9f7raZF2mp3g+wwb4J9qj9tlHlRZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iwq8khHrohCRHEg+QJeF2g8pFhj245us4ke+Qr6AlTo+RNIOQGS4jA6VcK7e0R5mcNbGckKnfSupiCyVTNa7OAu575+l5fJ76TCHzU3XVFhD1Fq2MGMAvpPCc/Zovog3ZL02ymPgZ7sWkTL1iVkbpcF40KLMZXwaJM3kP1BOOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qekj9SK+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713533266; x=1745069266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tAjbLsXIapgYTL9f7raZF2mp3g+wwb4J9qj9tlHlRZE=;
  b=Qekj9SK+/zK4PL8oJ97/ZmfmuTsNXRmYLpFDa1J1SCf1Q9yGarfIuqkr
   MT9DdL+eONuaEHSK9R16mA6JP5LQLA5vg6qVVooGcM/DvuAxIuuK0XgnC
   Va3yyb3Zgn+5UoRCuyHvxa5k7/67+TOms+tn9zauN+lvaCfCe1CMARm42
   diEDaVaG8IwFVhWjAqLjZtXRiqIV2LutaTv/fGJ8GuLPUhVL1BUjzFuqM
   uQeX5f0uC/aAu0g7gD+J5ttXtbrNCrPBbLPSFCK892G+019BGqaq2hZ3V
   w+/RfXu3gx1S2B8X6vSx0P0VMQuSMTGXxyi69Q9//WX2cjkIzIf7yp8YR
   Q==;
X-CSE-ConnectionGUID: fqTkFCcZQaKoK1wI+CP/vA==
X-CSE-MsgGUID: 6kXZDVLbRiKTjT/c2l7fUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="20524795"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="20524795"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:27:45 -0700
X-CSE-ConnectionGUID: 0giGa5KkRW6LbE4k6icGeA==
X-CSE-MsgGUID: m+WgrNILSK+WJGx5ZDemgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23835138"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:27:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxoHC-00000000jGq-0TsA;
	Fri, 19 Apr 2024 16:27:38 +0300
Date: Fri, 19 Apr 2024 16:27:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: brgl@bgdev.pl, bartosz.golaszewski@linaro.org, elder@linaro.org,
	geert+renesas@glider.be, linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, warthog618@gmail.com, wsa@the-dreams.de
Subject: Re: [PATCH v3 00/24] gpio: rework locking and object life-time
 control
Message-ID: <ZiJxSeao5Zcv9KdF@smile.fi.intel.com>
References: <02a101da9227$bda04cb0$38e0e610$@trustnetic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02a101da9227$bda04cb0$38e0e610$@trustnetic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 19, 2024 at 03:03:54PM +0800, Jiawen Wu wrote:
> Hi Bartosz Golaszewski,
> 
> I ran into a kernel crash problem when I pull the latest net-next.git, and
> finally it was found that is caused by this patch series merged.

Can you bisect further, i.e. which patch (now a commit message) is the culprit?

> The kernel crashed because I got gpio=0 when I called irq_find_mapping()
> and then struct irq_data *d=null, as my driver describes:
> 
> 	int gpio = irq_find_mapping(gc->irq.domain, hwirq);
> 	struct irq_data *d = irq_get_irq_data(gpio);
> 
> 	txgbe_gpio_irq_ack(d);
> 
> The deeper positioning is this line in __irq_resolve_mapping().
> 
> 	data = rcu_dereference(domain->revmap[hwirq]);
> 		
> So, is it the addition of SRCU infrastructure that causes this issue?

Do you have a full traceback / Oops message to share?

-- 
With Best Regards,
Andy Shevchenko



