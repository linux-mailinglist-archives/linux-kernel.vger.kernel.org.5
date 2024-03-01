Return-Path: <linux-kernel+bounces-89148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F051986EB24
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1EE288765
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8C95821A;
	Fri,  1 Mar 2024 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjbHcU8y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3054258139;
	Fri,  1 Mar 2024 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328566; cv=none; b=KCra2fmCzJ2GCk0ItXo8DgnbjbfYIeKmmY1ys8EY5Un/2hhA4eKaBhhoZG2jlTnh+hXEf9iRLJgRJe33bfBJEeZQW/RahQyEjm5SLAELybhOtVz6gZEn1BjruEohpEdVvUfHKVU7yv5acMv9MH5K4/8y9LxMjJxyM0lvsNh5lTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328566; c=relaxed/simple;
	bh=8ucrO2riBci0C1NgaGOytxKIJ18XcZOm/cwTfi8S14U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHQDb8xsDnZaayNXtJ51bmRUdSz94G6VXcyIpr+edvARL/jokxmAhdZZgjbwOgmYNHL9vuICOqZfi40U0rkkkX+UmeBmJBjuxgNltk35JAwXVVjFNmTm0A1FbuPai6kjZvJiVdyg/FSgxv0sgceFaSZYZr0UCEx34IT+2q7HUfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjbHcU8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74439C433F1;
	Fri,  1 Mar 2024 21:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709328565;
	bh=8ucrO2riBci0C1NgaGOytxKIJ18XcZOm/cwTfi8S14U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjbHcU8ynX58zZXICxDgtkFZt52iQXDQSCzJKRPhntfO5hwSPvufuPRHpjrgUi/1q
	 4rOriKcMspIkQQV/mo2TtjWREFhqqrYctjkRTRgVo9Iy1shdaD45674C7qATgK1frj
	 Uz7BHzy2Di/BuLFnkJcmXwLDq/lMieYwCgkkKQF/j9QoXpx6Q0bM0jhQocCWHjI+y5
	 eFPRT+DEGYTIFk6ZSdgjmFIKZUhgzff46VlMVyb97RKPBN56s09B4Cvi5tpKZ8VQN3
	 eYcCOgxQaSY6GTtV1ZgZf0vKm+kpN8CShnT3nbvZdbt9jTkNxUKOuCIAfuM/H/LxIh
	 R/QLQIxUHqcsA==
Date: Fri, 1 Mar 2024 15:29:23 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: syna: remove unstable remark
Message-ID: <170932856194.3071068.14460961574294219365.robh@kernel.org>
References: <20240224084414.6264-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224084414.6264-1-krzysztof.kozlowski@linaro.org>


On Sat, 24 Feb 2024 09:44:14 +0100, Krzysztof Kozlowski wrote:
> Marvell Berlin SoCs (later Syna) bindings were marked as
> work-in-progress / unstable in 2015 in commit f07b4e49d27e ("Documentation:
> bindings: berlin: consider our dt bindings as unstable").  Almost nine
> years is enough, so drop the "unstable" remark and expect usual ABI
> rules.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/syna.txt | 12 ------------
>  1 file changed, 12 deletions(-)
> 

Applied, thanks!


