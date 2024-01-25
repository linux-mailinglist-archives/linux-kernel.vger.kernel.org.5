Return-Path: <linux-kernel+bounces-38188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1DF83BC32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD188B22F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8FA1B955;
	Thu, 25 Jan 2024 08:43:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE161B945
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172212; cv=none; b=UEoI8ZQ1660S21fcQdyiC/TUv7PeykZPgKvmVLv5R8qBNS/1qEUj+XL7UohFkaPD1JspAAvonK/pWo6YoUp0ijvDrI9v9JwwU7R9gMdIB2RnFvE0fwHDB9EXGu3gMDcTMH3X0h6HeyXveu4kKS/4/e58pbOF/C386H/alaugzYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172212; c=relaxed/simple;
	bh=oBPYSRRIvuHXxmQlmAGsOhtiu70XaFxR53lewV+BuRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9pmhyx9cv2kcGniS9nf6a/t9b597g2XkeMreLlLzqTuE7EtzTPhP+vahB1X79AzLL81ImtiA521R6TZHqKIrxkh+uaK99btnSUQ+b8Cmtw2mXy/L1HoPKfuFmICuGxFQZ/jSgP1G5w3bhyHxWzgecWXHLaDFDzRRCFJ/kf2XD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mtr@pengutronix.de>)
	id 1rSvKG-00066k-03; Thu, 25 Jan 2024 09:43:08 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mtr@pengutronix.de>)
	id 1rSvKA-002FBI-4u; Thu, 25 Jan 2024 09:43:02 +0100
Received: from mtr by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <mtr@pengutronix.de>)
	id 1rSvKA-001iUn-2K; Thu, 25 Jan 2024 09:43:02 +0100
Date: Thu, 25 Jan 2024 09:43:02 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
To: Bo Liu <liubo03@inspur.com>
Cc: kernel@pengutronix.de, mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: isl7998x: convert to use maple tree register
 cache
Message-ID: <20240125084302.GA383229@pengutronix.de>
Mail-Followup-To: Michael Tretter <m.tretter@pengutronix.de>,
	Bo Liu <liubo03@inspur.com>, kernel@pengutronix.de,
	mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240117030910.2790-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117030910.2790-1-liubo03@inspur.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2024 22:09:10 -0500, Bo Liu wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>

> ---
>  drivers/media/i2c/isl7998x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/isl7998x.c b/drivers/media/i2c/isl7998x.c
> index 89e13ebbce0c..c7089035bbc1 100644
> --- a/drivers/media/i2c/isl7998x.c
> +++ b/drivers/media/i2c/isl7998x.c
> @@ -1337,7 +1337,7 @@ static const struct regmap_config isl7998x_regmap = {
>  	.rd_table	= &isl7998x_readable_table,
>  	.wr_table	= &isl7998x_writeable_table,
>  	.volatile_table	= &isl7998x_volatile_table,
> -	.cache_type	= REGCACHE_RBTREE,
> +	.cache_type	= REGCACHE_MAPLE,
>  };
>  
>  static int isl7998x_mc_init(struct isl7998x *isl7998x)
> -- 
> 2.31.1
> 
> 

