Return-Path: <linux-kernel+bounces-29298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BB1830C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D171F2672C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C1C22EF8;
	Wed, 17 Jan 2024 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHBQgeR8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BF522EE3;
	Wed, 17 Jan 2024 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514423; cv=none; b=IlQgwC+2YthZEW0fV+BCqljSgvkjjQFZScmPdrqS4lKaqNsLfrStVJCtYVyBarmflV9jFXktxHEjs3dFsMhQEV6rW5A17LPmI2/9+NV6rqnJnkIxQZG0IxTO3+hwXfv3mImV+bU/OX2zNyQ29eendif97SdS+769hHtV/5GhPlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514423; c=relaxed/simple;
	bh=F3wR44aqlTQjRSn46zQ8+b3/LFSV04pX0jPfJiM8VIk=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=T76oc1ZbsOpfdjLVZnWVTFGeyHIIZie/WtnnKubpuoLZSsn62M5a457320Z7Rq2EyFYLY2FJUF4Ne/xlKmYo7aGjkZHwZVJyBMU89rT4IKwsPNi8B+mFsx3XH0euTNXbqFtA+Xw6P8/pQRNQtfTPPGs0Tn9M2jLaR32TI/IpvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHBQgeR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA26C433C7;
	Wed, 17 Jan 2024 18:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705514423;
	bh=F3wR44aqlTQjRSn46zQ8+b3/LFSV04pX0jPfJiM8VIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHBQgeR8KeUcClZfRqRJRzSUh1GoGZRQGjKV8bvDqQOOHH9lbNEbvnKY3XIPnAxyW
	 uoO9OgHVDJJm0lUy36LUYbCrFyXNiM8PhV0M97DvLVSgZe9e6OVBMGkRS7l9lf3fK2
	 YlXxgPiBTej4dK0MrB7V694iOqOAXYTgLQRd4pZT33/Z7tg3BFfR/eHIjKm0/idbjN
	 PJQNIlw50v7NicWNS6oVCv0M2R7K9OZ4uzIrd1xHqmAsklVOOpWvEP6AOnFgHXQjVg
	 jJ7wY2NyKoLrMa81FW9BZ2eDLfw2ZTPiRx+tSdQ3F32zHzGG0I9d7N1viSDd0IMs/2
	 axP+Hl7b4WYjg==
Date: Wed, 17 Jan 2024 11:00:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [GIT PULL] power-supply changes for 6.8
Message-ID: <20240117180021.GA539437@dev-arch.thelio-3990X>
References: <nqrl5ggszhlzaew6yte6t6uv5cbf4fhl5vd4pfhkitlsbqozvf@w4pttrz6supl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nqrl5ggszhlzaew6yte6t6uv5cbf4fhl5vd4pfhkitlsbqozvf@w4pttrz6supl>

Hi Sebastian,

On Mon, Jan 15, 2024 at 09:43:11PM +0100, Sebastian Reichel wrote:
> Hi Linus,
> 
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> 
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.8
> 
> for you to fetch changes up to 05599b5f56b750b5a92ff7f2c081945210816f83:
> 
>   Merge power-supply fixes for 6.7 cycle (2024-01-14 21:38:31 +0100)
> 
> ----------------------------------------------------------------
> power supply and reset changes for the 6.8 series
> 
> * new drivers / features
>   - bq24190: Add support for BQ24296 charger
> * cleanups
>   - all reset drivers: Stop using module_platform_driver_probe()
>   - gpio-restart: use devm_register_sys_off_handler
>   - pwr-mlxbf: support graceful reboot
>   - cw2015: correct time_to_empty units
>   - qcom-battmgr: Fix driver initialization sequence
>   - bq27xxx: Start/Stop delayed work in suspend/resume
>   - minor cleanups and fixes

<snip>

> Hermes Zhang (2):
>       dt-bindings: power: supply: bq24190: Add BQ24296 compatible
>       power: supply: bq24190_charger: Add support for BQ24296

This is missing a fix for building with older compilers:

https://lore.kernel.org/20240103-fix-bq24190_charger-vbus_desc-non-const-v1-1-115ddf798c70@kernel.org/

Cheers,
Nathan

