Return-Path: <linux-kernel+bounces-41634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A3E83F5A5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426751F22135
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C501123769;
	Sun, 28 Jan 2024 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qh+gAG+S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD8423746;
	Sun, 28 Jan 2024 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706449330; cv=none; b=CCkD4M4kwDHb10ykxjtzzafRdRFBKkC+qdCS8L2LbwmFKUqKo4ZrLKdtchuOSkjSa4+t1UiqDbQDj3NGmcs6EXP1n/+goZZozYZXyaVHmFN8GKE9R0ZJwNjSci6oy6hkB2jVUXRKC9dbhkZC6yyMOUSDp7FrC+gnIqPMmIYtZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706449330; c=relaxed/simple;
	bh=zoqzVmA6GSns3s2tk0r/sjhN7fyHiGxTng4Rr+3BZwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhgf1bYEB1LveLqrI/GsGOlv40TtCbt2nWyfYF4DuZE8M5V/A82eLVsz0AaIo5dhLoAtTWJrD365lnooogHuGiFDmd/xCyxqHZ0ADDs4SZXIhdyDlbrx1x/HHGprqIT1RNAxf/zWqNK69dmXx6KJC6m7aOzRZXtV6cbQ174ajFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qh+gAG+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8D9C433C7;
	Sun, 28 Jan 2024 13:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706449328;
	bh=zoqzVmA6GSns3s2tk0r/sjhN7fyHiGxTng4Rr+3BZwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qh+gAG+S9RQfu5h216l/VB2X7CdrrAAb5FDF2PGVNLWQ/LTCqwC2v6h+pHKXFJh9v
	 WDCCUQ/Lh/+dJdaTd6S/S/HbsrorPr/QRRtP7LsEVdOVCN+HTB4a6u9tlbrqnhh1jK
	 fHO682aEiE6FzA8mZUkMVq32xXRd3VCwLzQRcnC2mtdHU1dQivCm0FJe6maiwJiwMw
	 gtwrKm9/ADuB04EgGl6uUeMvzRqlrhduyFKOvCl865xp0hHR4gLgeuR3G0k7fYaGLj
	 3B1gUqjN0bB/EaqrAkqHexX7F7E09jh9Oz2U4lK+VZ7Bqwce5OJ2OrbZoGhAPv1s2X
	 Q3fiI8Oi4fqBQ==
Date: Sun, 28 Jan 2024 13:41:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH RESEND] iio: move LIGHT_UVA and LIGHT_UVB to the end of
 iio_modifier
Message-ID: <20240128134057.075b23ae@jic23-huawei>
In-Reply-To: <20240127200208.185815-1-javier.carrasco.cruz@gmail.com>
References: <20240127200208.185815-1-javier.carrasco.cruz@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 21:02:08 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The new modifiers should have added to the end of the enum, so they do
> not affect the existing entries.
> 
> No modifiers were added since then, so they can be moved safely to the
> end of the list.
> 
> Move IIO_MOD_LIGHT_UVA and IIO_MOD_LIGHT_UVB to the end of iio_modifier.
> 
> Fixes: b89710bd215e ("iio: add modifiers for A and B ultraviolet light")
> Suggested-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Thanks for the resend.

Applied to the fixes-togreg branch of iio.git

Jonathan

> ---
>  include/uapi/linux/iio/types.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 5060963707b1..f2e0b2d50e6b 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -91,8 +91,6 @@ enum iio_modifier {
>  	IIO_MOD_CO2,
>  	IIO_MOD_VOC,
>  	IIO_MOD_LIGHT_UV,
> -	IIO_MOD_LIGHT_UVA,
> -	IIO_MOD_LIGHT_UVB,
>  	IIO_MOD_LIGHT_DUV,
>  	IIO_MOD_PM1,
>  	IIO_MOD_PM2P5,
> @@ -107,6 +105,8 @@ enum iio_modifier {
>  	IIO_MOD_PITCH,
>  	IIO_MOD_YAW,
>  	IIO_MOD_ROLL,
> +	IIO_MOD_LIGHT_UVA,
> +	IIO_MOD_LIGHT_UVB,
>  };
>  
>  enum iio_event_type {


