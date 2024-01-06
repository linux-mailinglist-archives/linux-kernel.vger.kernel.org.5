Return-Path: <linux-kernel+bounces-18536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E42825EE7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 09:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4DA1C235CE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB245393;
	Sat,  6 Jan 2024 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DwjUHezK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C85232;
	Sat,  6 Jan 2024 08:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DCBC433C8;
	Sat,  6 Jan 2024 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704530373;
	bh=zmYJTY0Hdz7TrCAQ67wvYKevEv9po9LKSFVjh63kg/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DwjUHezK9Canr9Y++G3aQA8U/lgdoJQxPYc995jsHYfi5MIpj2q2pOJA3flpuN2A+
	 TSUaIVK7C1BfnpJUuE7spPtudpg0ISit+/Q70Gh7ME2r/aEQUB2CzBafP9AC9nVl5R
	 rgZxnHN+eK84HMZohWlUASihufVR27n2UHdF+ht0=
Date: Sat, 6 Jan 2024 09:39:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Cc: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, liujian56@huawei.com
Subject: Re: [PATCH 4.14 00/21] 4.14.335-rc1 review
Message-ID: <2024010622-poster-credit-d7ce@gregkh>
References: <20240105143811.536282337@linuxfoundation.org>
 <2948beff-a9f6-42b2-8bfb-534ec9188de6@linaro.org>
 <26e9b0a8-158c-45b3-b724-616287d36e58@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26e9b0a8-158c-45b3-b724-616287d36e58@bootlin.com>

On Fri, Jan 05, 2024 at 09:39:58PM +0100, Alexis Lothoré wrote:
> Hello,
> 
> On 1/5/24 18:13, Daniel Díaz wrote:
> > Hello!
> > 
> > On 05/01/24 8:38 a. m., Greg Kroah-Hartman wrote:
> 
> [...]
> 
> > Failure looks like this:
> > 
> > -----8<-----
> >   /builds/linux/drivers/pinctrl/pinctrl-at91-pio4.c: In function
> > 'atmel_pinctrl_probe':
> >   /builds/linux/drivers/pinctrl/pinctrl-at91-pio4.c:1054:3: error: too many
> > arguments to function 'irq_set_lockdep_class'
> >      irq_set_lockdep_class(irq, &atmel_lock_key, &atmel_request_key);
> >      ^~~~~~~~~~~~~~~~~~~~~
> >   In file included from /builds/linux/include/linux/irq.h:517,
> >                    from /builds/linux/include/linux/gpio/driver.h:7,
> >                    from /builds/linux/drivers/pinctrl/pinctrl-at91-pio4.c:18:
> >   /builds/linux/include/linux/irqdesc.h:250:1: note: declared here
> >    irq_set_lockdep_class(unsigned int irq, struct lock_class_key *class)
> >    ^~~~~~~~~~~~~~~~~~~~~
> >   make[3]: *** [/builds/linux/scripts/Makefile.build:330:
> > drivers/pinctrl/pinctrl-at91-pio4.o] Error 1
> > ----->8-----
> > 
> > Bisection points to:
> > 
> >   commit 6c47537ba008b3affe99360f65592ff5b797818f
> >   Author: Alexis Lothoré <alexis.lothore@bootlin.com>
> >   Date:   Fri Dec 15 22:34:24 2023 +0100
> > 
> >       pinctrl: at91-pio4: use dedicated lock class for IRQ
> >             [ Upstream commit 14694179e561b5f2f7e56a0f590e2cb49a9cc7ab ]
> 
> This fails because linux-4.14.y is older than 39c3fd58952d: kernel/irq: Extend
> lockdep class for request mutex, which updates irq_set_lockdep_class API.
> 
> Looking at irq_set_lockdep_class update patch, what appears to be a simple fix is
> to simply remove the last parameter from irq_set_lockdep_class call in
> pinctrl-at91-pio4.c, but I am not even sure if the fix remains legitimate in this
> case (ie if the corresponding lockdep splat reappears), and I do not have access
> to corresponding hardware before the deadline, so if that's not already the plan,
> I suggest to drop this from 4.14 branch.

Now dropped, thanks.

greg k-h

