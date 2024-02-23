Return-Path: <linux-kernel+bounces-78429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D9386135E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D2D3B25F93
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244FF80BED;
	Fri, 23 Feb 2024 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2oyc5ze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689427EEEF;
	Fri, 23 Feb 2024 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696345; cv=none; b=rx3h4BETLN4hdBFLMv5t+5dZTCyyrPT6aUM/M2YQ1tbPgeeOtUC3bP45Jz1DHqX1UUQdwPkF2IcAazuzReQGbR8dml5QwnXWDtIou4Fupbc5xXQ7mI/xmiHoYeL+gZd9Yoguk1yD50FEo1Yn7+LG6eMXBxLsHJDzSwcSop6a7fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696345; c=relaxed/simple;
	bh=V8TznJ0k0V6DJyvkcGoCJqMKzz//BdtNKBjJlJ3UDjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfmguaDnSO3akkQ4xcw/IrJLaXbj5mh+OR4BBnwm1lWTq5atgrKM13Btd9mkzCyGXj6mEkijXvQ8RYzzAE19OAf1y3lbaLr6WGiq8OhvW0DxuKpToiuTCf7+bVgUmROw2vGTigtwmgt9HL+J6kAxfk8qpv3HXu+zQa/RxIf/9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2oyc5ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324DAC433C7;
	Fri, 23 Feb 2024 13:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708696344;
	bh=V8TznJ0k0V6DJyvkcGoCJqMKzz//BdtNKBjJlJ3UDjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2oyc5zesXUWqfHsjlsEnMs1YHxloW1tzQHKvZdPAm1WzCmzZVDcoDIaj7PqVTlTg
	 MtTmg8P+g9Q6Ofx6FmBgC92jsq7OjMH1MZkDup1/cIgvpo89YYX5RlC7+IZQqHv4q7
	 wB/dd5SGfhlwszZ0GHlno5wK3FbXwWCNOO4brEjxTFA+QIkynhn5A4VtC9Lm1DL8XW
	 ImhWSGJm4Ngj5IJxndSs2D1mz5DnoJLmfCk0s7sNf3V1q3E660U5yGP9o5Dmr14ERn
	 sVRlzd3+vGwPgJ+f0ZX4pXeQvqY+bDorlAcadMnoELWUUDpxQvG4kX9ZoM9+IzCNkC
	 pU/NQUdrsn/2Q==
Date: Fri, 23 Feb 2024 13:52:19 +0000
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [resend, PATCH v3 0/3] backlight: mp3309c: Allow to use on
 non-OF platforms
Message-ID: <20240223135219.GB1613065@google.com>
References: <20240208184313.2224579-1-andriy.shevchenko@linux.intel.com>
 <20240223134908.GA1613065@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223134908.GA1613065@google.com>

On Fri, 23 Feb 2024, Lee Jones wrote:

> On Thu, 08 Feb 2024, Andy Shevchenko wrote:
> 
> > Allow to use driver on non-OF platforms and other cleanups.
> > 
> > Changelog v3:
> > - rebased on top of the last changes against this driver (Lee)
> > - added tags to patch 2 (Daniel, Flavio)
> > 
> > Changelog v2:
> > - rename pm3309c_parse_dt_node() --> mp3309c_parse_fwnode() (Daniel)                                             - add tags (Daniel, Flavio)
> > - new patch 2
> > 
> > Andy Shevchenko (3):
> >   backlight: mp3309c: Make use of device properties
> >   backlight: mp3309c: use dev_err_probe() instead of dev_err()
> >   backlight: mp3309c: Utilise temporary variable for struct device
> > 
> >  drivers/video/backlight/mp3309c.c | 88 ++++++++++++-------------------
> >  1 file changed, 35 insertions(+), 53 deletions(-)
> 
> Sorry for the delay, I was on vacation and I've been fighting fires this
> week.
> 
> This set still doesn't apply?

Disregard, my fault.  Applied now, thanks.

-- 
Lee Jones [李琼斯]

