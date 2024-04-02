Return-Path: <linux-kernel+bounces-127554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79495894D91
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187361F221E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4051A56B9E;
	Tue,  2 Apr 2024 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+EwSNn5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3BD26292;
	Tue,  2 Apr 2024 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046745; cv=none; b=XZoIqWV/fADLiNcBghkSqbkZJFk81A+7N+U3zOyjDJZGdh3JqE139az+1Bk/ZXRC5fJqzonQfuvbxILfyYqUWGu8YiCOccRB2uJ/RRxZHrdCPBXdv3LN+UIge5sjk87PjQRLacMruJY20jfBhl1utDELjPTWtj7kwXkr/8+TXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046745; c=relaxed/simple;
	bh=OwSfI/lp7ZaOCrZ00Y4Ap44N0xgja+JeYa4l5qKaGg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEwP9nDfpZpW4i10Chrr56rHTNoPEA4IbppPxxQBFPB9Mjo19bAY+dZcvcrt8y7DYqXecMvO8+6qHJoxWS3Z8hAgos5hV9hIv8I6KLO/Oef9DP2vwCeERHGB0uwwCxQpVgQjUi/IPqljpvYVhXF1ymyfcmoXEIkvgT36DzOkNoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+EwSNn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F51C433C7;
	Tue,  2 Apr 2024 08:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712046744;
	bh=OwSfI/lp7ZaOCrZ00Y4Ap44N0xgja+JeYa4l5qKaGg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+EwSNn5TLvnG+t1weCH4tYHuYd6p9/t7G8uKeX5r1NYv6h1aVbRLOH5oUsozXe6S
	 dJ1Ted5gU3Oc2Z29UOho4Kr6waOZ0PmJ+JAjH6DhY+uwtlTjhR5apkuYZiblcInGuz
	 D3/6PIL1Luow2Ciiq4S5wwGHp5fy+g0gPR0DKA+v1NhImI5+wtNtnpiqX7Bq8v4TYx
	 962fZjkl/aZt3vLQ6RZqevfufbgo+iWmHvSfr3cG+Ply59rOZa+sstunHoh5cjZYXV
	 ee1IVUGV3uVG8JOhtLqKVEeiTlmjg6VA/VDqJthRa8lkHu9FCt/csmdQayfUm+Ii3k
	 jpbh+rq7teTjQ==
Date: Tue, 2 Apr 2024 09:32:19 +0100
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 2/2] net: dsa: sja1105: drop driver owner
 assignment
Message-ID: <20240402083219.GK26556@kernel.org>
References: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
 <20240330211023.100924-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330211023.100924-2-krzysztof.kozlowski@linaro.org>

On Sat, Mar 30, 2024 at 10:10:23PM +0100, Krzysztof Kozlowski wrote:
> Core in spi_register_driver() already sets the .owner, so driver
> does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


