Return-Path: <linux-kernel+bounces-110545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E83088605C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E50028848A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C6C1332BB;
	Thu, 21 Mar 2024 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afXh4vD1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DD9E57B;
	Thu, 21 Mar 2024 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044700; cv=none; b=ZhUBHTPCLfqtF99Moa3CtoTt4hrNVOP3tCrsPS1++pTxMgt4j/ANY1Hbb8UX805O5ESA76rkhhwo/x6A88udiETTWyUeljFhcgsAA1/N96KTrWBwzr3xYh2fLtk6qtT1akPDKEOlFtO4vLonzGmXXI9dBqnlp5oMRcOP+bBd0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044700; c=relaxed/simple;
	bh=6fQiXxD+tmHS1mS0ctqiVmMYgD6WS34yof38NdjhqSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6plpIFeP2/2LzFOAIc/Fvjt55I8UwpVg2zwrLsejNmTFgWGGDOZK+urUcxraoSZDP4XorMmNVVL2tR0hqRC+xRuHwVaiCngLIpSyMBwO/kRIY2UxEyiaAZ5Huye4W6nQmerixMDBWdAF6Q2uof0kkiqRlEkbR5L8dVotlSKLCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afXh4vD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C42CC433C7;
	Thu, 21 Mar 2024 18:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711044700;
	bh=6fQiXxD+tmHS1mS0ctqiVmMYgD6WS34yof38NdjhqSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afXh4vD1ukrufFzgDopbfZlCQn6FCYLyRYfMGAml76O8rxliYTT5TgJAmF5CMY9Mm
	 JUawpZaGSd1NBUXhGKO+rIm3hoT7roBO02N4ByUglpbt3jBQ2R+nQP57PqvvZzGquE
	 rd/xJKSCfpPVzQgyxD3C38PPBKq7RtHAQl+uAFgM78vMy/6aT0HQtVggXzbTHPjJ7O
	 hzJBUskqoutjmmAZOsyp4jNG2vKy3Pwf8kcH1AkwuFasVNVLQkyRc89F/1XN/9apSe
	 ExZL0XQquHPTtONPJHxDrobjrcVhCUBuELYI1VOOPTYSY/Hxs7StvLQvo+EqpQ1/Oq
	 BrzjGGFZ6ClLg==
Date: Thu, 21 Mar 2024 18:11:33 +0000
From: Lee Jones <lee@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: andy.shevchenko@gmail.com, pavel@ucw.cz, vadimp@nvidia.com,
	christophe.leroy@csgroup.eu, hdegoede@redhat.com,
	mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	nikitos.tr@gmail.com, marek.behun@nic.cz, kabel@kernel.org,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@salutedevices.com
Subject: Re: [PATCH v7 0/8] devm_led_classdev_register() usage problem
Message-ID: <20240321181133.GG13211@google.com>
References: <20240314201856.1991899-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240314201856.1991899-1-gnstark@salutedevices.com>

On Thu, 14 Mar 2024, George Stark wrote:

> This patch series fixes the problem of devm_led_classdev_register misusing.
> 
> The basic problem is described in [1]. Shortly when devm_led_classdev_register()
> is used then led_classdev_unregister() called after driver's remove() callback.
> led_classdev_unregister() calls driver's brightness_set callback and that callback
> may use resources which were destroyed already in driver's remove().
> 
> After discussion with maintainers [2] [3] we decided:
> 1) don't touch led subsystem core code and don't remove led_set_brightness() from it
> but fix drivers
> 2) don't use devm_led_classdev_unregister
> 
> So the solution is to use devm wrappers for all resources
> driver's brightness_set() depends on. And introduce dedicated devm wrapper
> for mutex as it's often used resource.
> 
> [1] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/
> [2] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/#mc132b9b350fa51931b4fcfe14705d9f06e91421f
> [3] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/#mdbf572a85c33f869a553caf986b6228bb65c8383
> 
> Changelog:
> v1->v2:
> 	revise patch series completely
> 
> v2->v3:
> locking: add define if mutex_destroy() is not an empty function
> 	new patch, discussed here [8]
> 
> devm-helpers: introduce devm_mutex_init
> 	previous version [4]
> 	- revise code based on mutex_destroy define
> 	- update commit message
> 	- update devm_mutex_init()'s description
> 
> leds: aw2013: unlock mutex before destroying it
> 	previous version [5]
> 	- make this patch first in the series
> 	- add tags Fixes and RvB by Andy
> 
> leds: aw2013: use devm API to cleanup module's resources
> 	previous version [6]
> 	- make aw2013_chip_disable_action()'s body one line
> 	- don't shadow devm_mutex_init() return code
> 
> leds: aw200xx: use devm API to cleanup module's resources
> 	previous version [7]
> 	- make aw200xx_*_action()'s bodies one line
> 	- don't shadow devm_mutex_init() return code
> 
> leds: lm3532: use devm API to cleanup module's resources
> leds: nic78bx: use devm API to cleanup module's resources
> leds: mlxreg: use devm_mutex_init for mutex initialization
> leds: an30259a: use devm_mutext_init for mutext initialization
> leds: powernv: add LED_RETAIN_AT_SHUTDOWN flag for leds
> 	- those patches were planned but not sent in the series #2 due to mail server
> 	problem on my side. I revised them according to the comments.
> 
> v3->v4:
> locking: introduce devm_mutex_init
> 	new patch
> 	- move devm_mutex_init implementation completely from devm-helpers.h to mutex.h
> 
> locking: add define if mutex_destroy() is not an empty function
> 	drop the patch [9]
> 
> devm-helpers: introduce devm_mutex_init
> 	drop the patch [10]
> 
> leds: aw2013: use devm API to cleanup module's resources
> 	- add tag Tested-by: Nikita Travkin <nikita@trvn.ru>
> 
> v4->v5:
> leds: aw2013: unlock mutex before destroying it
> 	merged separately and removed from the series
> 
> locking/mutex: move mutex_destroy() definition lower
> 	introduce optional refactoring patch
> 
> locking/mutex: introduce devm_mutex_init
> 	leave only one devm_mutex_init definition
> 	add tag Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> leds* patches
> 	remove #include <linux/devm-helpers.h> due to devm_mutex_init() in mutex.h now
> 
> v5->v6:
> locking/mutex: move mutex_destroy() definition lower [11]
> 	drop the patch due to devm_mutex_init block is big enough to be declared standalone.
> 
> locking/mutex: introduce devm_mutex_init
> 	redesign devm_mutex_init function to macro to keep lockdep feature working
> 	use typeof to redeclare mutex var in macro body (thanks to checkpatch)
> 	previous version [12]
> 
> v6->v7:
> locking/mutex: introduce devm_mutex_init
> 	fix comment at __devm_mutex_init
> 	move #include <linux/device.h> upper
> 	commit message: change devm_mutex_init -> devm_mutex_init(), add point in the end
> 	fix and move up tag Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 	add tags (in the order received):
> 	Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 	Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 	Reviewed-by: Marek Behún <kabel@kernel.org>
> 	Acked-by: Waiman Long <longman@redhat.com>
> 
> leds: powernv: use LED_RETAIN_AT_SHUTDOWN flag for leds
> 	remove the patch from this series to send it separately
> 
> leds: mlxreg: use devm_mutex_init() for mutex initialization
> leds: an30259a: use devm_mutex_init() for mutex initialization
> 	commit message: change devm_mutex_init -> devm_mutex_init()
> 	add tag Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> leds: aw2013: use devm API to cleanup module's resources
> leds: aw200xx: use devm API to cleanup module's resources
> leds: lp3952: use devm API to cleanup module's resources
> leds: lm3532: use devm API to cleanup module's resources
> leds: nic78bx: use devm API to cleanup module's resources
> 	add tag Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> [4] https://lore.kernel.org/lkml/20231204180603.470421-1-gnstark@salutedevices.com/T/#mf500af0eda2a9ffc95594607dbe4cb64f2e3c9a8
> [5] https://lore.kernel.org/lkml/20231204180603.470421-1-gnstark@salutedevices.com/T/#mc92df4fb4f7d4187fb01cc1144acfa5fb5230dd2
> [6] https://lore.kernel.org/lkml/20231204180603.470421-1-gnstark@salutedevices.com/T/#m300df89710c43cc2ab598baa16c68dd0a0d7d681
> [7] https://lore.kernel.org/lkml/20231204180603.470421-1-gnstark@salutedevices.com/T/#m8e5c65e0c6b137c91fa00bb9320ad581164d1d0b
> [8] https://lore.kernel.org/lkml/377e4437-7051-4d88-ae68-1460bcd692e1@redhat.com/T/#m5f84a4a2f387d49678783e652b9e658e02c27450
> [9] https://lore.kernel.org/lkml/20231213223020.2713164-1-gnstark@salutedevices.com/T/#m19ad1fc04c560012c1e27418e3156d0c9306dd84
> [10] https://lore.kernel.org/lkml/20231213223020.2713164-1-gnstark@salutedevices.com/T/#m63126025f5d1bdcef69bcad50f2e58274d42e2d
> [11] https://lore.kernel.org/lkml/20240307024034.1548605-2-gnstark@salutedevices.com/
> [12] https://lore.kernel.org/lkml/20240307024034.1548605-3-gnstark@salutedevices.com/
> 
> George Stark (8):
>   locking/mutex: introduce devm_mutex_init()
>   leds: aw2013: use devm API to cleanup module's resources
>   leds: aw200xx: use devm API to cleanup module's resources
>   leds: lp3952: use devm API to cleanup module's resources
>   leds: lm3532: use devm API to cleanup module's resources
>   leds: nic78bx: use devm API to cleanup module's resources
>   leds: mlxreg: use devm_mutex_init() for mutex initialization
>   leds: an30259a: use devm_mutex_init() for mutex initialization
> 
>  drivers/leds/leds-an30259a.c | 14 ++++----------
>  drivers/leds/leds-aw200xx.c  | 32 +++++++++++++++++++++-----------
>  drivers/leds/leds-aw2013.c   | 25 +++++++++++++------------
>  drivers/leds/leds-lm3532.c   | 29 +++++++++++++++++------------
>  drivers/leds/leds-lp3952.c   | 21 +++++++++++----------
>  drivers/leds/leds-mlxreg.c   | 14 +++++---------
>  drivers/leds/leds-nic78bx.c  | 23 +++++++++++++----------
>  include/linux/mutex.h        | 27 +++++++++++++++++++++++++++
>  kernel/locking/mutex-debug.c | 11 +++++++++++
>  9 files changed, 122 insertions(+), 74 deletions(-)

Doesn't apply to v6.8.

What base was used for this?

-- 
Lee Jones [李琼斯]

