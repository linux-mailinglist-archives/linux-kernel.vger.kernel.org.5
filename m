Return-Path: <linux-kernel+bounces-77578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561358607BA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA64D1F24E16
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5CB469D;
	Fri, 23 Feb 2024 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2jv0/GB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461A5372;
	Fri, 23 Feb 2024 00:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708648169; cv=none; b=iKNTg48kOyQxtkq/tIDYRrJ+g7jwIUKjFmY7pQEC2WWFSmVsq/ZMaLnvfQHK23aUm5jrReKm1oQGsEKynIGogCWGCljm5nHWOoRJTta+90lkOx00Qh11qu+zKgi05rerz4ZHmIp2y66BeyQfQKfEQhHLk356EFoynw2LSCRvK6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708648169; c=relaxed/simple;
	bh=ZeCNJBXQ9bwuS1WWwQEywvtoXAbTPDeQyBV5lMwyy7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSXzlqT7SH8ev0PMRWuPF5DuzEu/HKFA9m/5zKDKHB/rE0wPv9Bjdn3Q8u80VZrTRqXi8MjXXRCdatj2/JfR37zTyu5WH+XKbptLasPdACuB/mV9nl8uMNZJ4vpLmWFvY23MXIzC8tcESqLj5YlASqkbjEf5QYMxSvS1UXSHapI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2jv0/GB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D216AC433F1;
	Fri, 23 Feb 2024 00:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708648169;
	bh=ZeCNJBXQ9bwuS1WWwQEywvtoXAbTPDeQyBV5lMwyy7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2jv0/GBroQoysc8chdUrCOdvQ2fVBshGFizT8Vf+drkep1X4XtlCyNuMkBlQqtzY
	 7EoOaPhrs/GuyNfV6VED66KOsThDdU7+tIlXOXk1wFv1Ua1/tNyRaM7vGeCW3JCCZS
	 6b5X6iIg0PQFhHO+tVO9OXn0UZmLQ4bVwtZxKjKXJbOkyPs6pGt3Rt5IQrjIjDh24t
	 7qxsLBWZY5XqyPJYM1kEY7StkHOlrkE3QF/Ir3dvWDGucwos6x3KCp2w7NE6MnioOT
	 f0UhYX2LfiZWsvZ+ha35DUMg9DZYAJFaRC3ziT0Uu1zFAMPdYdrsvUILe2Gy0fQyj8
	 49C/3PuHnQKdA==
Date: Thu, 22 Feb 2024 17:29:25 -0700
From: Rob Herring <robh@kernel.org>
To: Michael Riesch <michael.riesch@wolfvision.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	linux-media@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: Re: [PATCH 03/14] media: dt-bindings: media: rockchip,px30-vip: add
 optional property iommus
Message-ID: <170864816486.3960279.12154290757664269303.robh@kernel.org>
References: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
 <20240220-v6-8-topic-rk3568-vicap-v1-3-2680a1fa640b@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-v6-8-topic-rk3568-vicap-v1-3-2680a1fa640b@wolfvision.net>


On Tue, 20 Feb 2024 10:39:13 +0100, Michael Riesch wrote:
> The PX30 VIP features an IOMMU and can be operated with or without using
> it. Document the property iommus in order to support the former case.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


