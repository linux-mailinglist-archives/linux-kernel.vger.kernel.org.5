Return-Path: <linux-kernel+bounces-78190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A454860FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AFE61C2289E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69049657D6;
	Fri, 23 Feb 2024 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3fjZTfL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839C14B835;
	Fri, 23 Feb 2024 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708686064; cv=none; b=HwtqxxJZihB3HTD6wwDYI/aW72MIoetLdCs6nKGXy8i/IufOSnknl4WeWrixut/F7HeJYFNtL1Yh908LM2L3f4aPIbnl3VUlZxqhPUpWRI10cSjdbhEDhXxOQXdya1mkJoDNLHXoBmGXxysZjrbCKqmTKMKjDAWdyRHfdMx/Gj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708686064; c=relaxed/simple;
	bh=yrtQyWnsvLC95TkaPvjMnBeQTZ/b6mzcf4JclqRkn9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PI6RU+fovqPoQAj6TvLWsPhzhrv1q9qOEqCSZNPkKOQlfhcFJFwr+/kiqw2N5sVzMTk5v3/1sZnfCSCEKV07ZLr5Mhp5niqvzE3h/p4B91bvgTfCPBWc54bhSt4WPiNtgZeIN5CV0h4esm9lL1/WmvbKjAAqnIzM7xzX2tt9kDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3fjZTfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EE7C433C7;
	Fri, 23 Feb 2024 11:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708686064;
	bh=yrtQyWnsvLC95TkaPvjMnBeQTZ/b6mzcf4JclqRkn9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e3fjZTfLCKzt3Y8pPziqzb5Hcmsw76U9966vEHbNXjaaJshFZVlCE73WxLvQitWGh
	 V3bOT1rCDM/ajdMRc7UUdjVVNDs7aR3gNoutKpnUo7kEzqLhUVHjevYtPKMtVFYHCx
	 Gw4jRZ612dsYD7rx4x8r3O0Snwy28rdDGqO4tlSjDoFCN4wJPwP/POxE+WSEz2d+cd
	 lRn/8kuqinmQH0uteAi4PO9vYyELqg+K32oxQppR6+mrjoGlUjBmUo+b+nEmGePI0d
	 1RMUGGK+nrwFD6JH18hh/bYvdg3KazTziroi6QUE9oWAolodgsteuJXPT75IuzPbPs
	 5m5+4xCa07gNw==
Date: Fri, 23 Feb 2024 11:01:00 +0000
From: Lee Jones <lee@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@nvidia.com>,
	Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: mlxreg: fix a kernel-doc warning
Message-ID: <20240223110100.GU10170@google.com>
References: <20240221060153.3924-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221060153.3924-1-rdunlap@infradead.org>

On Tue, 20 Feb 2024, Randy Dunlap wrote:

Would you mind being more descriptive in your subject lines please?

It's common for people (me included) to find subject lines a reliable
way to search through Git history and these types of descriptions are
likely to cause duplication.

Thanks.

> Drop one struct description to fix a kernel-doc warning:
> 
> drivers/leds/leds-mlxreg.c:42: warning: Excess struct member 'led_data' description in 'mlxreg_led_data'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vadim Pasternak <vadimp@nvidia.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Lee Jones <lee@kernel.org>
> Cc: linux-leds@vger.kernel.org
> ---
>  drivers/leds/leds-mlxreg.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff -- a/drivers/leds/leds-mlxreg.c b/drivers/leds/leds-mlxreg.c
> --- a/drivers/leds/leds-mlxreg.c
> +++ b/drivers/leds/leds-mlxreg.c
> @@ -29,7 +29,6 @@
>   * @data: led configuration data;
>   * @led_cdev: led class data;
>   * @base_color: base led color (other colors have constant offset from base);
> - * @led_data: led data;
>   * @data_parent: pointer to private device control data of parent;
>   * @led_cdev_name: class device name
>   */

-- 
Lee Jones [李琼斯]

