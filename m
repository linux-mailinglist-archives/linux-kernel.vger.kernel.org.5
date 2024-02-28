Return-Path: <linux-kernel+bounces-85417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AB186B59B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B873428248D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B73A3FBAB;
	Wed, 28 Feb 2024 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mocrwp8N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B0208DF;
	Wed, 28 Feb 2024 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140259; cv=none; b=YoDUHzeMGn8R23Qb6M0CqEYraB0rX0tGdfIhk/ZZvxyECXfQDNcuM7KwrYq0ie7gcIOPs6A0xbOdl6/f9NI1+E7g/OfUGcPdVmfU/vTpw7v46ZiD7h11qCHt1/sR+aAsDa7JVz6fqyROhyyVyg+ZN9tyCOJyIex8odC+qCdurBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140259; c=relaxed/simple;
	bh=A2PeUUQm1wFXAtWCzhEN/ZB+2DhrYt9Yb05kV4WmWEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF+si4wj+2/5fYahYtQzoKPVHNdWsreAFtEQjF9b7ICYHglcSoG9a+DZA6n8PnjBtTvJpOU3x9gXAa6w9kP1pTKwVqkFY7N7dLK8NDOYEzwxipjfIE22t7X+sKAXKRJw8jeGwEZg9iqBejMVTfCKPWtXm65QGz+ylTWwTlSZkDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mocrwp8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5BBC433F1;
	Wed, 28 Feb 2024 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709140259;
	bh=A2PeUUQm1wFXAtWCzhEN/ZB+2DhrYt9Yb05kV4WmWEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mocrwp8N/vy7u1IWw0Ra0jjttGS1dGQCxbJXo0o494h53nKFeY00DP0uCxm0x3NEQ
	 t1T7mNWlgoilo+gKjoB3cmvuERUSSkoc3EiAO7xIO12Fa69+GdLmWQUin0Gpc9/hUc
	 W4dMFticyJW7lSoG4r15HtLSFvZXueljfxoqEbsgfIzdjsmClOMwhGFYUT4ouX4JF6
	 E/WFC5c+w8TTcWjpYEfZIIMpSec5vP3aYgCsLxW+6G9Yih+a7Y98qybpWo5xmJqAPf
	 X3LoFgGN7Ge9ZypF6jltMUqURKCAyxcEgDrj/55u6ZfJkHs3HhQu4aTbL/x3W2nQnC
	 p3eaVKVPoyEdg==
Date: Wed, 28 Feb 2024 10:10:57 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Sebastian Reichel <sre@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] power: supply: move power_supply_attr_group into #ifdef
 block
Message-ID: <20240228171057.GC2158263@dev-arch.thelio-3990X>
References: <20240228-device_cleanup-power-v1-1-52c0321c48e1@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228-device_cleanup-power-v1-1-52c0321c48e1@marliere.net>

On Wed, Feb 28, 2024 at 10:46:28AM -0300, Ricardo B. Marliere wrote:
> When building with CONFIG_SYSFS=n, the build error below is triggered:
> 
> ld: drivers/power/supply/power_supply_core.o:(.data+0x0): undefined
> reference to `power_supply_attr_group'
> 
> The problem is that power_supply_attr_group is needed in
> power_supply_core.c but defined in power_supply_sysfs.c, which is only
> targeted with CONFIG_SYSFS=y. Therefore, move the extern declaration into
> the #ifdef block that checks for CONFIG_SYSFS, and define an empty static
> const struct otherwise. This is safe because the macro __ATRIBUTE_GROUPS in
> power_supply_core.c will expand into an empty attribute_group array.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/all/20240227214916.GA3699076@dev-arch.thelio-3990X/
> Fixes: 7b46b60944d7 ("power: supply: core: constify the struct device_type usage")
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Tested-by: Nathan Chancellor <nathan@kernel.org> # build

Thanks for the quick fix!

> ---
> This patch depends on [1].
> [1]: 20240227-fix-power_supply_init_attrs-stub-v1-1-43365e68d4b3@kernel.org
> ---
>  drivers/power/supply/power_supply.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
> index 7d05756398b9..06749a534db4 100644
> --- a/drivers/power/supply/power_supply.h
> +++ b/drivers/power/supply/power_supply.h
> @@ -13,16 +13,16 @@ struct device;
>  struct device_type;
>  struct power_supply;
>  
> -extern const struct attribute_group power_supply_attr_group;
> -
>  #ifdef CONFIG_SYSFS
>  
>  extern void power_supply_init_attrs(void);
>  extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env);
> +extern const struct attribute_group power_supply_attr_group;
>  
>  #else
>  
>  static inline void power_supply_init_attrs(void) {}
> +static const struct attribute_group power_supply_attr_group;
>  #define power_supply_uevent NULL
>  
>  #endif /* CONFIG_SYSFS */
> 
> ---
> base-commit: 837af6b0cdb2b8df56d2df35db0444cfa1ea47c2
> change-id: 20240228-device_cleanup-power-2dcfaa7b7f2b
> 
> Best regards,
> -- 
> Ricardo B. Marliere <ricardo@marliere.net>
> 

