Return-Path: <linux-kernel+bounces-140299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D8E8A1269
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C869D2832B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B41474AA;
	Thu, 11 Apr 2024 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USUTOPXb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A6413BACD;
	Thu, 11 Apr 2024 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833230; cv=none; b=Xr7FISOf/ZFPS67pqMLNab8R2lAg8hhF5JdSKf2jpJ876xQ1orNbJiRrpgabBVZ1w0vrw6hzsJZHfgatpgDyfqmh0KzbVvT/ATk6gdq30ig45S9PO8Vv5w5Wk2bIYk7QLD64L4C/z+p11cM+Fff8taajdODURCsFU50TXyNt9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833230; c=relaxed/simple;
	bh=TWliYVPsBWbsHahvHYhpN+Shb5Uw4uVhz9aPR2rpWZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiLWvqancvkKInFPnQap83pDt78sToC/BL7FiKDqU/UC/tozXvqRRKSAuXt4X0GBlN7CVhKjpZZyiuGY166gbKYQIZqPhfbyKfjRBwEWxazsE5nmXr1Yr6W0hTGgXuxpehgMFIy51mm/E374j0de5stoWVAXyoXS64BZoE2PCy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USUTOPXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D50C433C7;
	Thu, 11 Apr 2024 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712833230;
	bh=TWliYVPsBWbsHahvHYhpN+Shb5Uw4uVhz9aPR2rpWZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USUTOPXbXgiGKAY0EfZxFJTh1S0mdkDr07ek/QvEnC9RWK8YOu2+d7kRsmmy1W/+w
	 ISWv/Y4flcWUA735MGQ1CG0v8697b6H91JvxUVFs8udvSeWqpm8zfmdwbl0sBJQIEw
	 JHalMtumvVaxINCHf5UFBc+TUHSqN9UXCfAC42IZtJpYLSyKscKlfoBgqgvcl3uU2/
	 AvBqHlksACQ0OZDdSO2Q3dSkNkBjrIuHcUsPxjRcP8lZ2IjnCglw70T7jHTVpOHiqw
	 rZ+dLqjsxIHJ8+6vCS3sAAU24hqVs3MM0I67fFozzB7W/khrqfjhGO1ynvHdvIe/cR
	 cYCI0B/C8VdfA==
Date: Thu, 11 Apr 2024 12:00:24 +0100
From: Lee Jones <lee@kernel.org>
To: andy.shevchenko@gmail.com, pavel@ucw.cz, vadimp@nvidia.com,
	christophe.leroy@csgroup.eu, hdegoede@redhat.com,
	mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	nikitos.tr@gmail.com, kabel@kernel.org,
	George Stark <gnstark@salutedevices.com>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@salutedevices.com
Subject: Re: [PATCH v7 0/8] devm_led_classdev_register() usage problem
Message-ID: <20240411110024.GF1980182@google.com>
References: <20240314201856.1991899-1-gnstark@salutedevices.com>
 <171283316999.2296003.5529877568304975347.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171283316999.2296003.5529877568304975347.b4-ty@kernel.org>

On Thu, 11 Apr 2024, Lee Jones wrote:

> On Thu, 14 Mar 2024 23:18:48 +0300, George Stark wrote:
> > This patch series fixes the problem of devm_led_classdev_register misusing.
> > 
> > The basic problem is described in [1]. Shortly when devm_led_classdev_register()
> > is used then led_classdev_unregister() called after driver's remove() callback.
> > led_classdev_unregister() calls driver's brightness_set callback and that callback
> > may use resources which were destroyed already in driver's remove().
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/8] locking/mutex: introduce devm_mutex_init()
>       commit: c1a17857f8e333aa597ce0099c8728888e0c5037
> [2/8] leds: aw2013: use devm API to cleanup module's resources
>       commit: aa2fb50d9f17185e799a5969d0d357842d07450b
> [3/8] leds: aw200xx: use devm API to cleanup module's resources
>       commit: 517d9d3c408369cfa552652ac06294410c570095
> [4/8] leds: lp3952: use devm API to cleanup module's resources
>       commit: f8cf710c971e021e5ca39832adde32dfa241e081
> [5/8] leds: lm3532: use devm API to cleanup module's resources
>       commit: d265d86a2725e38c4f13ef79fc4e685b7234e7a3
> [6/8] leds: nic78bx: use devm API to cleanup module's resources
>       commit: 917676a8961e18e4dd5b17411317e3261473762a
> [7/8] leds: mlxreg: use devm_mutex_init() for mutex initialization
>       commit: 0548081cb25fbd0eb3a605cb6647dd166368da32
> [8/8] leds: an30259a: use devm_mutex_init() for mutex initialization
>       commit: c898cf6eb464d4172c79e925ea4d8007e856e10c

Submitted for build testing.

I'll follow-up with a pull-request once everything is in order.

-- 
Lee Jones [李琼斯]

