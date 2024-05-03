Return-Path: <linux-kernel+bounces-167468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E388BA9EE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5133F1F215F4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400F314F12A;
	Fri,  3 May 2024 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eixsxYDm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8814A0AC
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728752; cv=none; b=b8YDVP1nNgmwZfmXgXK8a8HwEcetjQC/s9XFNMyhxrmgNZeGYrqy0lL2a8y5j0Gz9J838AecYslmL4/19IUbIvvdkecu5iAfg5XjZWv4Vn5TQxTykGbs997EdWoLVQ98bWSbvLV90TpWEvuaRnMVEM3UOYBgc2OmLwXDLPSvCSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728752; c=relaxed/simple;
	bh=J9VY1YOreLWaho6RPq8dqFZ6OxZ/GwblA2TicCmxOgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPkTVFtO+aVzxshTJcui4YrOgYif/CKdwfbNLGJJP7yalgedtUFPa3+mszMbAV5lbSVTXY2i2Ry2d130c26SG89dzoBkuU9Og2Y0Jhboqq7J7/UAuczPSfOhqrI3XAfTJ3luGmmusMz0+VcMLyEm9dSd6MsOx5BK07ndiP3lrEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eixsxYDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32379C116B1;
	Fri,  3 May 2024 09:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714728751;
	bh=J9VY1YOreLWaho6RPq8dqFZ6OxZ/GwblA2TicCmxOgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eixsxYDm8U9Vs9CktRtwS0jhqIEdRpaWLno9WZHku8GC5S4t74ZgqYCTAt3lfuThZ
	 2LJpRoamPQsO+lySdTeinMqe8ooTYlMMsL4bd7UlNjiqCHIqj1oLk3JRbeHCM+qxJR
	 N2Woj2wzmx+m4FcOD5TmZPQQb3WTJ9HT8x615nZY4OQAzyxHJhoB79Rv4+IErmQA1R
	 pQXUZHN/QJ/FNmgNDHusVGk/h/dRobyCvmqJ0mkYPIxdQThFEDwPj/ZqJv8aMofnyA
	 x35w8sy0lbutCkmUITQMU4VOYhxooV7T+4Iq4VK5I0gJvFi6OKS1Q7SEhj755ycCK/
	 hR4th835Q5YFQ==
Date: Fri, 3 May 2024 10:32:27 +0100
From: Lee Jones <lee@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: linux-kernel@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH mfd v2 1/2] mfd: rsmu: support I2C SMBus access
Message-ID: <20240503093227.GN1227636@google.com>
References: <20240501163256.28463-1-lnimi@hotmail.com>
 <LV3P220MB12021342F302AADEB6C1601CA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV3P220MB12021342F302AADEB6C1601CA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>

On Wed, 01 May 2024, Min Li wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> 8a3400x device implements its own reg_read and reg_write,
> which only supports I2C bus access. This patch adds support
> for SMBus access.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> - Provide cover-letter suggested by Lee
> 
>  drivers/mfd/rsmu_i2c.c | 107 +++++++++++++++++++++++++++++++++++------
>  drivers/mfd/rsmu_spi.c |   8 +--
>  2 files changed, 97 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
> index 5711e512b..cba64f107 100644
> --- a/drivers/mfd/rsmu_i2c.c
> +++ b/drivers/mfd/rsmu_i2c.c
> @@ -32,6 +32,8 @@
>  #define	RSMU_SABRE_PAGE_ADDR		0x7F
>  #define	RSMU_SABRE_PAGE_WINDOW		128
>  
> +typedef int (*rsmu_rw_device)(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u8 bytes);

We're not going to start passing around function points all over the
place.  Use a variable 'bool smbus'(?) instead and call the correct
helper based on that instead.

-- 
Lee Jones [李琼斯]

