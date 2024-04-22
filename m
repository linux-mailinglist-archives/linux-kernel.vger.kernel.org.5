Return-Path: <linux-kernel+bounces-153548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D5C8ACF7B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAE11F21D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEAD15219A;
	Mon, 22 Apr 2024 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXH6W0Hx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C53CF65;
	Mon, 22 Apr 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796351; cv=none; b=h7L1GoPAJmqrs49A2Y//fEzi+N+Blp6MYxh7FXxnvrxF0VrHWZZkqq40S/R2DYzgGcJKdKiGqajR49vKCYAm0/5vbcfqpnVoBfxvf95UkJzru1+28hWDQHhOIDfYA5KTP+KuDw/kHaECpZngviP61b3+edCCQnOkHvnkueEnMK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796351; c=relaxed/simple;
	bh=K6eCMcV02CRHJtAWFf5NEGxhvatJNeftrLgXnmZavbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZZHjKGdCbVdK+zbjGSNTXeKHvBQguHU4N0MdAXpN9F/WFS+xyCycQRJViiSFNTYnd4VykeEBQuJIS/cyIn6FH8ZaD+GaiJ4C8En+aXYjKnKReBsfXZcCRHFBlAaegzOHDkXSfxON27voDZILyTW/CGK7D/Kovj8yw484FkFt1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXH6W0Hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F13DC113CC;
	Mon, 22 Apr 2024 14:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713796351;
	bh=K6eCMcV02CRHJtAWFf5NEGxhvatJNeftrLgXnmZavbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXH6W0HxKC5vREV5ZTANcsbQyGp9p0okTXQyn3HLiCLir7fsz3W9XINKXakuZWt+t
	 PEJKuM49F80bDCG6tAMyck99r1GFEqdIZxQhZ+k8+vAPBIc7Wbr7QpPqDtx8Pcn0dy
	 i+XTIUjwfYD9WLBPFdJeAb2eOSzui7+6UwdCBeip2StN5PWMVj715ornBoeDiy0fll
	 yraWL+aNzaCub8uX65sdgJP+0hK3yIkiWtwh7CcS2tyWz179fXrLjzIIsqDALid3/A
	 EwKKpieYUSsXbVIskoXcuwAzsOJ9Figcki5+wRVinxlt1SBDmn5XSOS2gHCZHTU+il
	 0m19B2bbh3hPw==
Date: Mon, 22 Apr 2024 09:32:29 -0500
From: Rob Herring <robh@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: linux-arm-kernel@lists.infradead.org, FUKAUMI Naoki <naoki@radxa.com>,
	Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: rockchip: correct the model
 name for Radxa ROCK 3A
Message-ID: <171379630376.1216062.9468889487800020829.robh@kernel.org>
References: <20240419103019.992586-1-amadeus@jmu.edu.cn>
 <20240419103019.992586-2-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419103019.992586-2-amadeus@jmu.edu.cn>


On Fri, 19 Apr 2024 18:30:18 +0800, Chukun Pan wrote:
> According to https://radxa.com/products/rock3/3a,
> the name of this board should be "Radxa ROCK 3A".
> 
> Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


