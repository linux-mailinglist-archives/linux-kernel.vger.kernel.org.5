Return-Path: <linux-kernel+bounces-18537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821DB825EEB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 09:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11E5FB23A36
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C144C5668;
	Sat,  6 Jan 2024 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XmZYJmzd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB395232;
	Sat,  6 Jan 2024 08:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6F5C433C8;
	Sat,  6 Jan 2024 08:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704530385;
	bh=D5mTId9xO5LvfbJ1Ot2qK6+t7m/AMhshXdY3og+Kmgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmZYJmzdXjAR1gYbAIMr96MQphfu7/knn1bRGk60K7T8EA7Qh7Blv4fWA1JEL65xj
	 YOLDDWksnioZ789zZGTtV6l5oSy6waba2jsbUOmSPsI7/fAjuO+FlfMMSKY3/AYldV
	 qK9mn5sHXsUjznJWsyRcXMTg1YhuuVy61iABU4P8=
Date: Sat, 6 Jan 2024 09:39:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.14 00/21] 4.14.335-rc1 review
Message-ID: <2024010633-unviable-agreeably-3456@gregkh>
References: <20240105143811.536282337@linuxfoundation.org>
 <5bf8a4d9-2a83-4503-b041-09c45207fe0c@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bf8a4d9-2a83-4503-b041-09c45207fe0c@nvidia.com>

On Fri, Jan 05, 2024 at 04:23:00PM +0000, Jon Hunter wrote:
> Hi Greg,
> 
> On 05/01/2024 14:38, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.335 release.
> > There are 21 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 07 Jan 2024 14:38:02 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.335-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > -------------
> > Pseudo-Shortlog of commits:
> 
> ...
> 
> 
> > Alexis Lothoré <alexis.lothore@bootlin.com>
> >      pinctrl: at91-pio4: use dedicated lock class for IRQ
> 
> 
> I am seeing the following build error for ARM ...
> 
> drivers/pinctrl/pinctrl-at91-pio4.c: In function ‘atmel_pinctrl_probe’:
> drivers/pinctrl/pinctrl-at91-pio4.c:1054:3: error: too many arguments to function ‘irq_set_lockdep_class’
>    irq_set_lockdep_class(irq, &atmel_lock_key, &atmel_request_key);
>    ^~~~~~~~~~~~~~~~~~~~~
> In file included from include/linux/irq.h:517:0,
>                  from include/linux/gpio/driver.h:7,
>                  from drivers/pinctrl/pinctrl-at91-pio4.c:18:
> include/linux/irqdesc.h:250:1: note: declared here
>  irq_set_lockdep_class(unsigned int irq, struct lock_class_key *class)
>  ^~~~~~~~~~~~~~~~~~~~~
> 
> I am guessing it is the above commit.

Thanks, now dropped.

greg k-h

