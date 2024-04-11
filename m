Return-Path: <linux-kernel+bounces-140170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 338558A0C56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE9B2B2656C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B524A145335;
	Thu, 11 Apr 2024 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy4mytRI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF301145324
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827610; cv=none; b=KCCSF34OHZabld5Ly0AG7UZ5N/3vZFpNmYCbi2AV/Y4vCMpipt5w+Cu365ETKSaSiZNNRTUX3X6NP6ikGf79uUvFu8wrr8GWeWoMGLZDXnAKRPFlKVIEDtzm+VhxZ0FuL6+aOIJv5ST0zmikLKhUoJk1RIQBhbY1WVpG7+Ey1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827610; c=relaxed/simple;
	bh=jM4M691uuZf2QbIQ3KiJJHLhJop6/9uLu6R6v8Vznio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPpNTBB5nBNGD/TXc113h3+YTU09SctNyNjpseKV015Z/Awjw2Ywf7X00QLuO/1xEgtE/bc6n5dwHABT0Zje2UNUwUSKLKcKNlAK0mPmpRTHe1R8bP3RRATav1XMDBWxLl050HSbjA8+zNOTz6gYSywR8mlgjNZi80GFN27Ie58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy4mytRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DF6C433C7;
	Thu, 11 Apr 2024 09:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712827609;
	bh=jM4M691uuZf2QbIQ3KiJJHLhJop6/9uLu6R6v8Vznio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jy4mytRIHb4URVuWPksbyl0eKDYlk0ubPdu1Uqv6i1IwtYJpQ6VuvLaWbG6LudlIB
	 uTap1Vtv36/mzTkAAh8yeJzNl5I0WLjCtGpACWUHO+m8UUvikZUwhRtI0gYuKpA5z1
	 DJh+DDU7fmVJGe5a2rQ98vmQIsmwTh9iQa6v/3CC9xX7IP8/mx6zfOP6PRUtQcZV2R
	 3F0pBedD//u+qCGaLSo6TPOESdSM+uPGQNMARbiclGY2GHDjY4oKv1Bx4vN2L9FBB8
	 JBMcoYxXERZdMcYE04e6f2Zx0VpsbQY+IGscBlF4Ni5Oe5izZq3l8sAZfnSQfm8CQU
	 +n5eiVwNB9mqA==
Date: Thu, 11 Apr 2024 10:26:46 +0100
From: Lee Jones <lee@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: linux-kernel@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH mfd 1/2] mfd: rsmu: support I2C SMBus access
Message-ID: <20240411092645.GA1980182@google.com>
References: <LV3P220MB1202F6BA918D7CCC90264E8DA03D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV3P220MB1202F6BA918D7CCC90264E8DA03D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>

On Wed, 03 Apr 2024, Min Li wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> 8a3400x device implements its own reg_read and reg_write,
> which only supports I2C bus access. This patch adds support
> for SMBus access.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/mfd/rsmu_i2c.c | 109 +++++++++++++++++++++++++++++++++++------
>  drivers/mfd/rsmu_spi.c |   8 +--
>  2 files changed, 98 insertions(+), 19 deletions(-)

Please send this set again as --thread.

`man git format-patch`
`man git send-mail`

-- 
Lee Jones [李琼斯]

