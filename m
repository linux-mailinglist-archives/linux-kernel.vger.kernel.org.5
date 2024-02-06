Return-Path: <linux-kernel+bounces-55011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E6E84B63A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5307A288B55
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C690130AC9;
	Tue,  6 Feb 2024 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="kyRXYNsP"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BBD12FF97;
	Tue,  6 Feb 2024 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225747; cv=none; b=Ss4VPSqsCLgY/S9tps+d92j9888qy+1uHXBDGEn6V3v2fg2meezAQ/8Raclny61Dlg0FdoX4Im8ONrmy0nBQ9i/nXbg6Rtx+ptmerMaVqGgdkiGHhTjkUWYD9mDcS52s50KvyI+CJQ0J8gYJjPwMVePdyq2ZjxxA4smg4ecmrzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225747; c=relaxed/simple;
	bh=iWQ751Umn75UfafL9LXPbsEQPtgj8ZyLiC5Gw52znGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2SOha+hjx3UZYuGY5jO2gHfQzLr2QFnzbjxOOtIwG665+UjZvqRJq3Bg3k8AswoOXB/Fq81lc1GNccoSEQi0bIeHoo+DxuPV9HaDRRN9as5hZgnLFO2YX58e4M7cjiXt+GHK/ZVHEL9Q6+nblGmEcw/A8bKF7pWc5saGI12E08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=kyRXYNsP; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 073DD6050D;
	Tue,  6 Feb 2024 13:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707225744;
	bh=iWQ751Umn75UfafL9LXPbsEQPtgj8ZyLiC5Gw52znGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kyRXYNsPAQNClbcvX9psK+p4JTHYkaBWtnFBDwjQvcS/aQLak0g6khRvcqbypFOyF
	 +fqEFG+nHaNy4+EwIaLtgyTKDoZXw07mCgxKnhC80OkyksrJC3CzVKUWToqa02eT5u
	 hSqF+jdpLZRxMhNv+40y+j/zif/Mp/4Puhrbjl+sDrNiy+V5UNVMtjCVgYrvXTQXKR
	 ZdUnjtAbC0hLL2qZ++IuFS/Qyfh3998L+cuAVIBUhPxqcQJQH1VlfPM9LxilZjIVhd
	 UGH787yC0HKXmdxqVnA2kYN0CF3Le+QbqKcccaH3qHRIdq+H7Bwi66NMZ+wrRToXDj
	 WKQUy8XOPE3/g==
Date: Tue, 6 Feb 2024 15:21:55 +0200
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yicong Yang <yangyicong@huawei.com>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, john.ogness@linutronix.de,
	tglx@linutronix.de, yangyicong@hisilicon.com, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
	fanghao11@huawei.com
Subject: Re: [PATCH v2] serial: port: Don't suspend if the port is still busy
Message-ID: <20240206132155.GH5185@atomide.com>
References: <20240206073322.5560-1-yangyicong@huawei.com>
 <ZcIvjC1qzD4atwlT@smile.fi.intel.com>
 <ZcIwGm-W4A2rupOi@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcIwGm-W4A2rupOi@smile.fi.intel.com>

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240206 13:12]:
> > static int serial_port_runtime_suspend(struct device *dev)
> > {
> > 	int ret;
> > 	...
> > 	uart_port_lock_irqsave(port, &flags);
> > 	ret = __serial_port_busy(port);
> > 	if (ret)
> > 		port->ops->start_tx(port);
> > 	uart_port_unlock_irqrestore(port, flags);
> 
> > 	if (ret)
> > 		pm_runtime_mark_last_busy(dev);
> 
> And obvious question here: why in case of 0 we can't mark this as busy as well?
> I.o.w. why do we need to mark it only when error is set?

No need to call in the 0 case. The last time driver was busy
was when pm_runtime_mark_last_busy() was called, and in the 0 case
we just runtime suspend based on the autosuspend timeout value.

Regards,

Tony

