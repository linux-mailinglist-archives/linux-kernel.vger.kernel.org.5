Return-Path: <linux-kernel+bounces-67127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6940A8566B5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA8D1C23B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29895132C21;
	Thu, 15 Feb 2024 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nycA5Fd2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659D013173F;
	Thu, 15 Feb 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009018; cv=none; b=gm/cbslhPBwnobC8mbwSckTXbxgYtYEIbIV8ph/ie6Hi3Dml9rkaf1KJAWOKfpIdIWXAoWMrrfgxHdhGIOIjCussZTOcW6ymwBJNPl/CN3uzxHd1Sm2xt56eL3fpmfWx3ByP89hXiqZvVC6SljdAO67Bv1IEmAYs+ZOqaBAX89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009018; c=relaxed/simple;
	bh=ucwlbu5kk1LT2OIRwH/QzVt60ZVE3lOvKXZUObl/Z48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewOm0tDiC3aDZPPDK7vA1egIiwN3+8igVaaGojVajx/U1U8g1kVfxx18JGyncnkD8cqZOEHQnotIUAgV0Ftgqo6AOpvtBBXl7JrE+cGhP+PZ67U4V1kRkitdF079S2bfVjo9DX2ihV8VKud9n6ZuC9QhBtdlB/SbZvm13url0c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nycA5Fd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C869C43390;
	Thu, 15 Feb 2024 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708009017;
	bh=ucwlbu5kk1LT2OIRwH/QzVt60ZVE3lOvKXZUObl/Z48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nycA5Fd2mYDABwlas8rwiHA66ofv4OFnirUc5ZDpPXFhiWd7j+mub0d9zpPt3vmUn
	 BsS+ki3KMvAlycL4XMNiS5O3rUPh7h+CjrlfSxTIv26uhFi+bJCT2rwfhqzuFIqH45
	 CgdJF+h98YutiJs9S+nQ3IzF2CTk/JWz9tN24JP+bDNiBO71F/G2cok2mIVLUKUZch
	 sbfvJdqYcA+H2UXe1QV/ybtrYYu1/tNcJqWu7/yYbJmDxy+k/j2V3QrX1ARBbP4i/J
	 elStWvHJx9DrPEXzP9Z007PXz11ESr4zo3AjngQDfbWX7qKOLBl3nBAnCFIT99pNxc
	 PivZi3piTCKog==
Date: Thu, 15 Feb 2024 08:56:54 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-leds@vger.kernel.org,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	devicetree@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] dt-bindings: leds: pwm-multicolour: re-allow active-low
Message-ID: <170800901376.28179.1088265042745462072.robh@kernel.org>
References: <20240213-verse-clinic-e6de06e1f18d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-verse-clinic-e6de06e1f18d@spud>


On Tue, 13 Feb 2024 20:13:41 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> active-low was lifted to the common schema for leds, but it went
> unnoticed that the leds-multicolour binding had "additionalProperties:
> false" where the other users had "unevaluatedProperties: false", thereby
> disallowing active-low for multicolour leds. Explicitly permit it again.
> 
> Fixes: c94d1783136e ("dt-bindings: net: phy: Make LED active-low property common")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> 
> I'm just assuming this is intentionally restrictive, if its not, we
> could easily just change this to uneval: false.
> 
> CC: Pavel Machek <pavel@ucw.cz>
> CC: Lee Jones <lee@kernel.org>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> CC: Christian Marangi <ansuelsmth@gmail.com>
> CC: linux-leds@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


