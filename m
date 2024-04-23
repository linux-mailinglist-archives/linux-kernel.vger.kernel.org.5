Return-Path: <linux-kernel+bounces-155430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7DB8AEA3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32CCFB21D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675E413BAEF;
	Tue, 23 Apr 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Irrai3Du"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A256619BBA;
	Tue, 23 Apr 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885037; cv=none; b=g5anAlZJutDLGetjUXL0v3tw9J8MahqXyizyeQJoTCbSh/fRqpjb6T1zpdkIlLKZBXouzi+J4Ryks+O4M2yilUrK3VkfKA0mvwyRAPQHB7ITxJvzwj/HY1qqlsAvRebu+X2VsZ1G+LTUh2ct6SYQu2zYkj8UP4iYAYsHQVw81Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885037; c=relaxed/simple;
	bh=52fd+5vaBxmD90Fln/RqUEgECtSvmHx+CvJPbUfYKwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y49bX9knX+ngIy5XL8F4gxM/UPCZmIbo+b5JXAMoNrXLRU9e6uWPW9w+jfJ6WtvoAwjYeunNLXZ76AQdHqlSYQrXawFI+SW0VrA9WmVyI5fM+5SAnIqkY6aO5BQ7LPPQ1VnJIc7pIyWXKzCitcG5yWJuD1slgoN3Cc7SE41vXkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Irrai3Du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E68CC116B1;
	Tue, 23 Apr 2024 15:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713885037;
	bh=52fd+5vaBxmD90Fln/RqUEgECtSvmHx+CvJPbUfYKwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Irrai3Duzjh4zW0su3g+DGPTtfMLXYtzwDXb20v2oWi6s/kgADNfauNcZA9WFG2cR
	 IYh9z/ieZjq34ipFV/ZQ8QDLzAwDzXaTligexO68/3vv3cymng4dCo6svwkXOOMq1C
	 6Fcleib9tExGYjfDrVW0jPF11/4F1cju/jfVwW/IiujMBHFhDqd2lyJJwb89hRCrsK
	 la19uqoUQCRKMnmUpAwZmo0SHr/vjGCacvG6jJvjCAE7MMq0U9X0gjg4hD6uYFxQxS
	 gyHqltoxpm2tlT8yHtgMRRv6cAFID/l/SvXRzC9enmjGvPg3xENsBjYouBUHFxL8Bk
	 dR/IPDW/+17SA==
Date: Tue, 23 Apr 2024 10:10:35 -0500
From: Rob Herring <robh@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-arm-kernel@lists.infradead.org, samuel@sholland.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
	robh+dt@kernel.org, jernej.skrabec@gmail.com, wens@csie.org,
	Marek Kraus <gamiee@pine64.org>, didi.debian@cknow.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Correct the descriptions
 for Pine64 boards
Message-ID: <171388501868.266715.5097987585598723774.robh@kernel.org>
References: <d2943d9f4c99a239f86188eaf45a73972685c255.1713833436.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2943d9f4c99a239f86188eaf45a73972685c255.1713833436.git.dsimic@manjaro.org>


On Tue, 23 Apr 2024 03:00:19 +0200, Dragan Simic wrote:
> Correct the descriptions of a few Pine64 boards and devices, according
> to their official names used on the Pine64 wiki.  This ensures consistency
> between the officially used names and the names in the source code.
> 
> Cc: Marek Kraus <gamiee@pine64.org>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
> 
> Notes:
>     This completes the correction of the descriptions of the Pine64 boards
>     and devices, which was started with the Pine64 boards and devices based
>     on Rockchip SoCs. [1]
> 
>     [1] https://lore.kernel.org/linux-rockchip/ec124dab2b1a8776aa39177ecce34babca3a50e2.1713832790.git.dsimic@manjaro.org/
> 
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


