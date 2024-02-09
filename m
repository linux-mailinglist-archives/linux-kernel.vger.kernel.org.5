Return-Path: <linux-kernel+bounces-59090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BD784F114
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5916D1C22059
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074C465BB6;
	Fri,  9 Feb 2024 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIYf2n/s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC765BAD;
	Fri,  9 Feb 2024 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465268; cv=none; b=RWKJwr4zY/PvrfPXApOsmD+FYmbAt2bAn5Wjlp3j8s9s82hh28fzz1KKUkgphKaQ7g5/hjUOO7VN6C9VWp2/whFmKTaXDct6schU2extkp8X/ELJXsg1urKrrXkCyadTNnVBkQMgq980JNc39CCOvMAuH6Do+lZn0SY339INE20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465268; c=relaxed/simple;
	bh=tDbADdHiugy5HAcwsH0PsQLO0MCWnTycBqCPrNSiuA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omBtH97DNKDotFODjbfa1bVlDTvxSliWO169ypK9DYKCO3+8KsTjuwft6DwaEScplOFJOGFzRIIX7palGx+sa9ArLwdI7nU3OzmogzfIbTxyn8NTB884WTsQjirvov2pSbs9IroMVjzwX4bWBECAfl96n83ahOOz5M5ZCgazrV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIYf2n/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EA6C433F1;
	Fri,  9 Feb 2024 07:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707465267;
	bh=tDbADdHiugy5HAcwsH0PsQLO0MCWnTycBqCPrNSiuA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YIYf2n/s0jIvllicuk2lMONPDbJZslGXjClO95rLhmCZmY+Q6uUvizjS4F7MN1/ke
	 FxiZWo1TX5oJAh6URqnF+ymcAPMexDlSV50Yeb/ekYBQ5J5zghCi1sPeA0LJEckCnx
	 5y7iSfB9JexhjMeYhtff544VUJWk0lFVxrZlvYA4dD7uRmNEsqXHmkDRCBsjy20U8J
	 g8CPMmqyyxlF1jKgQHy/NIF6erXPbR/zHHWJ2HGsrj8cI886M5ozvU/vfJngPUG8al
	 ErAe5sxh2eQUryAiSksKI40iq4i/6hJF4lk9hiBL/4q+OLjQSqXojzdU6RqpfhAwHX
	 X5Oh29dZlCHjw==
Date: Fri, 9 Feb 2024 07:54:23 +0000
From: Lee Jones <lee@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mfd: tmio: remove obsolete platform_data
Message-ID: <20240209075423.GC689448@google.com>
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
 <20240209015817.14627-9-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209015817.14627-9-wsa+renesas@sang-engineering.com>

On Fri, 09 Feb 2024, Wolfram Sang wrote:

> With commit 8971bb812e3c ("mfd: remove toshiba tmio drivers"), all users
> of platform data for NAND and framebuffers are gone. So, remove
> definitions from the header, too.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  include/linux/mfd/tmio.h | 27 ---------------------------
>  1 file changed, 27 deletions(-)

Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index eace8ea6cda0..bc53323293a3 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -103,31 +103,4 @@ struct tmio_mmc_data {
>  	void (*set_pwr)(struct platform_device *host, int state);
>  	void (*set_clk_div)(struct platform_device *host, int state);
>  };
> -
> -/*
> - * data for the NAND controller
> - */
> -struct tmio_nand_data {
> -	struct nand_bbt_descr	*badblock_pattern;
> -	struct mtd_partition	*partition;
> -	unsigned int		num_partitions;
> -	const char *const	*part_parsers;
> -};
> -
> -#define FBIO_TMIO_ACC_WRITE	0x7C639300
> -#define FBIO_TMIO_ACC_SYNC	0x7C639301
> -
> -struct tmio_fb_data {
> -	int			(*lcd_set_power)(struct platform_device *fb_dev,
> -						 bool on);
> -	int			(*lcd_mode)(struct platform_device *fb_dev,
> -					    const struct fb_videomode *mode);
> -	int			num_modes;
> -	struct fb_videomode	*modes;
> -
> -	/* in mm: size of screen */
> -	int			height;
> -	int			width;
> -};
> -
>  #endif
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

