Return-Path: <linux-kernel+bounces-166764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E43328B9F33
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E481F2226A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BCD16F916;
	Thu,  2 May 2024 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbW6EJTs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C9816FF27;
	Thu,  2 May 2024 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669486; cv=none; b=rRYzvnU2HFq4aMYVF2GoFN6n8TaZTsU4EYDR0NzEuzIMiJJ3+/FfUSaI0ir7c5lA1TY3CxnAaUWFDH+CgSQ9k7pDREqKlEWE0M16nSvWKL7ZOkGAPnPNRSCsZOO+HMcDP7dAsuWhLwpFJKJ8LKP4KmYGeWod7ele+2dV5wwGaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669486; c=relaxed/simple;
	bh=49eyjM/VLdE7NVxycz/BBQaGVKwViQu2psRAqw1p1YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCqNH/EipBST/S2WAKt7i33PWCTOf5x/PSDvLbJIk0wPOAP0Jg/7hBTM21ebi03rBX7PQ5bejizbx554uswApXWT9icsqeCw5xVxbuKtcIyHtVG3WpJ/+pS27V0TuS+cjuxINXxeD2YdH0b7xOreUbi/4ADMSz2ziIifgVs99xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbW6EJTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A07CC113CC;
	Thu,  2 May 2024 17:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714669485;
	bh=49eyjM/VLdE7NVxycz/BBQaGVKwViQu2psRAqw1p1YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jbW6EJTsLqbwr7myvvL4/KS3XciomH0hvu1aInVGZ2FnkRV3bKQKKDwkDWAwlSIr4
	 Yd7rS/dN5bhwWHiCweWn67TlpHoIPO/Wgq2It3J4sJHH6LzFwjFRS8LNajO8brJkZG
	 HeerqdsycyGFxMvbnIszQhMY3iBmQcIoqUVyGovct77CScgfmXJ/xfjGxODqu8v3UV
	 ghuxQ/3cxEa06ZWWpqXh+iGnhvoaqQRpv3HR69WF0ldoIK5m+lXi6eQ6uczynZje1Y
	 atzlGnKh8PEey4wihiw3FPMz31tZn42xPqNQMI6xThBOmWFVKRcVh6HfkQ1wSyzB5E
	 TmRDrqVTxJtCw==
Date: Thu, 2 May 2024 18:04:41 +0100
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Subject: Re: (subset) [PATCH] leds: pwm: Disable PWM when going to suspend
Message-ID: <20240502170441.GD1200070@google.com>
References: <20240417144943.GA2399047@google.com>
 <20240417153846.271751-2-u.kleine-koenig@pengutronix.de>
 <171466932928.1214296.17132644352212078458.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171466932928.1214296.17132644352212078458.b4-ty@kernel.org>

On Thu, 02 May 2024, Lee Jones wrote:

> On Wed, 17 Apr 2024 17:38:47 +0200, Uwe Kleine-König wrote:
> > On stm32mp1xx based machines (and others) a PWM consumer has to disable
> > the PWM because an enabled PWM refuses to suspend. So check the
> > LED_SUSPENDED flag and depending on that set the .enabled property.
> > 
> > 
> 
> Applied, thanks!
> 
> [1/1] leds: pwm: Disable PWM when going to suspend
>       commit: 974afccd37947a6951a052ef8118c961e57eaf7b

If this is important, you may wish to retroactively send it to Stable
once it's been merged into Mainline.

-- 
Lee Jones [李琼斯]

