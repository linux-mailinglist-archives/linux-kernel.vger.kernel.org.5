Return-Path: <linux-kernel+bounces-110877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD50388651F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A03DB220FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C983D3FEF;
	Fri, 22 Mar 2024 02:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHXg9XZk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194151396;
	Fri, 22 Mar 2024 02:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073772; cv=none; b=uUYoA5qgfng+Jok3cabaqfRd0Zcy6ik36hT7E7Bf5YdvD5GzD9tvUXxyy12R+k4vVgsLHPGFcNWHuUhgLmrOuKWRBOFUt5jnbi9g2yx9JMybNet6JNO8UaJM2u0xigD9UZhBmBTHM9G6/b6fEHCGwXHyBrVJlNhMMK/K4B+BZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073772; c=relaxed/simple;
	bh=K/8Y6IptA1fL79TfA4npH3+SXlRYXFqAUiqkofQiLCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUrippoosS0ZkdpVkKfWEHB9t03cLtsf6Q9SdMeYp8exWBkuye4QE1Eh+LhagPeBZkhfBhAVEzjPjhGKJALwJzx4Dy1n1GjTky9FtKGEH8Yi1xqvjVoj1GaMJWntQ9uUXETapqMrpYdGJwlgfNi6DOsy4qZYJHaJhQOyTyQEwnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHXg9XZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51826C433C7;
	Fri, 22 Mar 2024 02:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711073771;
	bh=K/8Y6IptA1fL79TfA4npH3+SXlRYXFqAUiqkofQiLCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHXg9XZkBS++OJhttPNAmI5qUUjVQx3Ogs+b0y4Vrg8UwYbcrYL1rOIJO1NpGVjrU
	 LLou69/J5u/VyzhmcItFGSWD1nfq1CUnRys46Vb+aWw19hb39E+XtEkHSFTWyS41s1
	 fhVvngsepVZ5oZG3jUfXj/IaU0Wsp2vR0GmedgVW4zkAYT+kAWchHo45PRYBgSOWC0
	 eyf34Lk6iSAmxIHmv2j92kextw2DhFsuxll42dCyXBamHXw5bHxIe4kFbgD4vs27py
	 72laSIUaStcySOqoOK++zDj5HhP5t+gfg/owWd3m3AyL3U4jZYLzFLQwudOQyHQGW1
	 p5CUcaHL65ilw==
Date: Thu, 21 Mar 2024 21:16:09 -0500
From: Rob Herring <robh@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
Message-ID: <171107376685.3418327.3613926203249839043.robh@kernel.org>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-1-711127a409ae@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321-cn9130-som-v1-1-711127a409ae@solid-run.com>


On Thu, 21 Mar 2024 22:47:11 +0100, Josua Mayer wrote:
> Add bindings for SolidRun Clearfog boards, using a new SoM based on
> CN9130 SoC.
> The carrier boards are identical to the older Armada 388 based Clearfog
> boards. For consistency the carrier part of compatible strings are
> copied, including the established "-a1" suffix.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  .../devicetree/bindings/arm/marvell/armada-7k-8k.yaml        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


