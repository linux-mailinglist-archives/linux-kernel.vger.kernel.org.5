Return-Path: <linux-kernel+bounces-18346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 566C4825BD9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7211C236B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D306F360BF;
	Fri,  5 Jan 2024 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="StVccSeM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D112030C;
	Fri,  5 Jan 2024 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D83731BF206;
	Fri,  5 Jan 2024 20:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704487200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ErApUWVCi+t5EtS/F6eodB58nXznfuCF4fRAcU35LiQ=;
	b=StVccSeMOUQyEl95dqXt75Cd1mmJtZNf6TXqNpwA3nmd5WN6F9QAGxgQiIYPGqo2p3Zunz
	57Mwo5aoB+xRNkOimOAW5pbSqPbb0prQfbBmwL4HfbOYODYr3olDjbGhVGfh6AQFYrwIAv
	xlnDg8ZSW2+LJpj+xHqxHVIjhMIuB2JXISrDaIK9JY6KLbrs+qJrEqRtrw4Oojvrgfgd2y
	LAhgXSwfxIvzOtxymLJ0kMbiKSq/LMBAK5YbXf0Z8tzKipEoaQ0Xqkw60dSdM8Xn4DbH5q
	iyqPfamvQD+joknJo5xhbUaU1aBCD3DBvIUGe5KPQqUWv0Acav8nPLsd7zZ40A==
Message-ID: <26e9b0a8-158c-45b3-b724-616287d36e58@bootlin.com>
Date: Fri, 5 Jan 2024 21:39:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.14 00/21] 4.14.335-rc1 review
Content-Language: en-US
To: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, liujian56@huawei.com
References: <20240105143811.536282337@linuxfoundation.org>
 <2948beff-a9f6-42b2-8bfb-534ec9188de6@linaro.org>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <2948beff-a9f6-42b2-8bfb-534ec9188de6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,

On 1/5/24 18:13, Daniel Díaz wrote:
> Hello!
> 
> On 05/01/24 8:38 a. m., Greg Kroah-Hartman wrote:

[...]

> Failure looks like this:
> 
> -----8<-----
>   /builds/linux/drivers/pinctrl/pinctrl-at91-pio4.c: In function
> 'atmel_pinctrl_probe':
>   /builds/linux/drivers/pinctrl/pinctrl-at91-pio4.c:1054:3: error: too many
> arguments to function 'irq_set_lockdep_class'
>      irq_set_lockdep_class(irq, &atmel_lock_key, &atmel_request_key);
>      ^~~~~~~~~~~~~~~~~~~~~
>   In file included from /builds/linux/include/linux/irq.h:517,
>                    from /builds/linux/include/linux/gpio/driver.h:7,
>                    from /builds/linux/drivers/pinctrl/pinctrl-at91-pio4.c:18:
>   /builds/linux/include/linux/irqdesc.h:250:1: note: declared here
>    irq_set_lockdep_class(unsigned int irq, struct lock_class_key *class)
>    ^~~~~~~~~~~~~~~~~~~~~
>   make[3]: *** [/builds/linux/scripts/Makefile.build:330:
> drivers/pinctrl/pinctrl-at91-pio4.o] Error 1
> ----->8-----
> 
> Bisection points to:
> 
>   commit 6c47537ba008b3affe99360f65592ff5b797818f
>   Author: Alexis Lothoré <alexis.lothore@bootlin.com>
>   Date:   Fri Dec 15 22:34:24 2023 +0100
> 
>       pinctrl: at91-pio4: use dedicated lock class for IRQ
>             [ Upstream commit 14694179e561b5f2f7e56a0f590e2cb49a9cc7ab ]

This fails because linux-4.14.y is older than 39c3fd58952d: kernel/irq: Extend
lockdep class for request mutex, which updates irq_set_lockdep_class API.

Looking at irq_set_lockdep_class update patch, what appears to be a simple fix is
to simply remove the last parameter from irq_set_lockdep_class call in
pinctrl-at91-pio4.c, but I am not even sure if the fix remains legitimate in this
case (ie if the corresponding lockdep splat reappears), and I do not have access
to corresponding hardware before the deadline, so if that's not already the plan,
I suggest to drop this from 4.14 branch.

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


