Return-Path: <linux-kernel+bounces-98604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F46F877C85
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4501B20B43
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97A4182AF;
	Mon, 11 Mar 2024 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhafz4nz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CCA17557;
	Mon, 11 Mar 2024 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148875; cv=none; b=JOv5ehkOzqoudnfFXtfB+E4t49FmSzg1P/W06mRdRTsMP4G4qwojeprg/vxewa4Uhm+k+ZT6Hki3ieLwYXgU9/r9z2SlxxA0ol5bjmbpwvMKa/2fqmQjQYTftNJM944r2+inqlgB88oB80a9DdTm8zw2rGldBCEcESK0E/d/rfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148875; c=relaxed/simple;
	bh=SJy63xxIMOOz80AbALShpGTRJiLYpQy9p+Uz2fnVaTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFoHvRIE1ZZaHyCCqOXtM+oUnyXwn45sDevKAsqV5HlHmHKxMlYgl5fxX0d03/WvG4MQmG5kunpZLTbYoAY/XRf8zXouZZx0KXA/6yJu3tbJ0vi4AfB8ieNHvmb1Nx0jbms61jeKacn6nz1uM7iHddNXoUYHLMeJitDWbQ6P31k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhafz4nz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AC7C433F1;
	Mon, 11 Mar 2024 09:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710148874;
	bh=SJy63xxIMOOz80AbALShpGTRJiLYpQy9p+Uz2fnVaTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhafz4nzgKKoOLViiq45Bzuf8CmTVFfmsYGlfFJPD+wTXM5t8txahmcKPKe4OaT/9
	 GvFxGHqEb3YO7Mi0isgKF5r9G6Hg9/tnshn5cpRxxLlEYshr0bkbDff8bxhmcM3lAd
	 imya5YPT7VOLi2ZVkT41+7+mqBWF6JlU6stNDngOhm5ZSMQTHDZvFcDLUsh14L4PiQ
	 ZzdAeQAsvKDYZ/j/kPbY0dNELFlAzvvoPgucMn26Ca173ocAsMZMAGJ4R7T+BbN9O/
	 7ZLYSlil+7ClZ7KFyxhSdVk9g8JCO7HC8BBFqhb6yXikPpNGPzwD0FJouA/NYXTIM5
	 pDzDcPvGuMs+g==
Date: Mon, 11 Mar 2024 09:21:05 +0000
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 1/1] net: dsa: microchip: add regmap_range
 for KSZ9563 chip
Message-ID: <20240311092105.GD24043@kernel.org>
References: <20240308105021.2552975-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308105021.2552975-1-o.rempel@pengutronix.de>

On Fri, Mar 08, 2024 at 11:50:21AM +0100, Oleksij Rempel wrote:
> Add register validation for KSZ9563.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>

..

