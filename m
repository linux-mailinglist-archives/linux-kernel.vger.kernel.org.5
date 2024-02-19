Return-Path: <linux-kernel+bounces-70774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED92859C37
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD311C21016
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C662030A;
	Mon, 19 Feb 2024 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NoI5lzZv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A18200A8;
	Mon, 19 Feb 2024 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708324286; cv=none; b=ERsu09PKpD43jjpq5tuskZDq3LNjtZfMpbFr3vLvmfsTYf7oCPSOfUB1y5prKWF3ckQMqMgF47g19/2k/3VuvNbeQxuovWdcPvoO6PMwSS0zNoCQ/zor/XfyKGp3QqmyMp/b4+qE+KfmawphZfR2dl5nMjnfSq61SUcdELvh5Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708324286; c=relaxed/simple;
	bh=lhjQHvaY3quezMxU01KeyaxwGNJy9M7M5mrHhFiCAR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwFbBrnKDzzVDWY0rL7Q0yu4LiZmf6DbrH6v+ajbccV+ZW5U8nvx+JJ31DSTZF7GBBdkxjRdYwgZ4ST+/AOm8pzZ+foqKqzxs84Kkn/tdmQ18ecna6gTUTE1h6hZzcgt0G/hn6NS4IiHhYQVWRWVvClBT3lelaHAvkvEWBsQoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NoI5lzZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9772DC433F1;
	Mon, 19 Feb 2024 06:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708324286;
	bh=lhjQHvaY3quezMxU01KeyaxwGNJy9M7M5mrHhFiCAR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NoI5lzZvIAtLTGo/oNZo4q+XnqTEMk89LQwsJrSg7hzYa7DECVQ11KCytXuFC7laO
	 KdfAxHEXvXQv7kpbbTu6QEaoPdpPCseDDGBI7ZbvePa/5GdEek54bIGtpKdtA0Mrgy
	 V7qBug4oOBLLovo6g4eIu4CZIhu0nZAJJDarBj7E=
Date: Mon, 19 Feb 2024 07:31:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Puma Hsu <pumahsu@google.com>
Cc: mathias.nyman@intel.com, Thinh.Nguyen@synopsys.com, badhri@google.com,
	royluo@google.com, howardyen@google.com, albertccwang@google.com,
	raychi@google.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/3] MAINTAINERS: Add maintainer for Google USB XHCI
 driver
Message-ID: <2024021951-coping-ferment-2023@gregkh>
References: <20240219061008.1761102-1-pumahsu@google.com>
 <20240219061008.1761102-4-pumahsu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219061008.1761102-4-pumahsu@google.com>

On Mon, Feb 19, 2024 at 02:10:08PM +0800, Puma Hsu wrote:
> Add Google USB XHCI driver and maintainer.
> 
> Signed-off-by: Puma Hsu <pumahsu@google.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 960512bec428..dc0e32a3c250 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9081,6 +9081,12 @@ F:	arch/arm64/boot/dts/exynos/google/
>  F:	drivers/clk/samsung/clk-gs101.c
>  F:	include/dt-bindings/clock/google,gs101.h
>  
> +GOOGLE USB XHCI DRIVER
> +M:	Puma Hsu <pumahsu@google.com>
> +L:	linux-usb@vger.kernel.org
> +S:	Maintained
> +F:	drivers/usb/host/xhci-goog.c

You are not paid to look after this?  That sounds odd, can you work with
your managers to do this, otherwise this is going to be tough to do over
time, right?

thanks,

greg k-h

