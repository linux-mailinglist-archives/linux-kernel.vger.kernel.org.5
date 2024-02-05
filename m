Return-Path: <linux-kernel+bounces-53086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 019B084A07E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38FB282CF6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849CA446BC;
	Mon,  5 Feb 2024 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fprk/LUi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A34597E;
	Mon,  5 Feb 2024 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153650; cv=none; b=loOTYQ7mbdHZHp1qIcpQIO+eoNmUScA12EnMGhDQYV3xIFqJcM7/pfBCTtPDe+CcHwZjbbykS2f9nKTy3KCfi3OFilKPjaFvRITedM4PvFI/AYuSAtYARAKi+TJ8+kp0znAKjYlAXDNKckwyvMB2/XCd7rxLdzoSpM/We2cJUHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153650; c=relaxed/simple;
	bh=TCImxvkVz5L7wITyguIjWK4mrkFlz9lqMRgQjXWfmrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRDllu7nV1kKUsii2S8Gz7TTA0JGgmvRg7fsEqge8/wuQHraw7nvaGT9sHFWciSYIDxa0PhdSKR9AHzXrv+SiR4DOwo8F6MY9kYqzRabIltZ1W3qYBcifJTKBjcgw62HFNIYx0MwrfKH5zNoQetS+XJU7nplsF/kFtxRQyRkxiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fprk/LUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01565C433F1;
	Mon,  5 Feb 2024 17:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707153649;
	bh=TCImxvkVz5L7wITyguIjWK4mrkFlz9lqMRgQjXWfmrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fprk/LUicnY0aQSxSVaH8TVzk1YshfKS9D7u6WHzElig1x2+tHrRcFJYopgqmy1Pv
	 9p4TrOR9veOxr8WfNwlQ5m3341Pcbr8OQ04o/rP2dkR2W/TXfkK7e+N/jUEOaXc0/Q
	 BPfXvmD9hZRoxBb/17gsK6odz3OBdoXT6iB2DsgyT1obZPYGhLEAZbWzaJr0NLfT+U
	 KyniczLOmh7tEn7EyRyTA1Ci4n8SLmD1aEbOe+5kVsiLdBbljRRWAQ3h7DmNcyHRhL
	 xtQq8jraZgHKKbNodqLpYfTB+ozz46uS85PAf9Lb6pFuivUQ/f3C+9FfaaVzbX49xj
	 KpxcYUTgVWYOA==
Date: Mon, 5 Feb 2024 17:20:46 +0000
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-hwmon@vger.kernel.org, Charles Hsu <ythsu0511@gmail.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] dt-bindings: trivial-devices: sort entries
 alphanumerically
Message-ID: <170715359536.3640223.5160945915604305923.robh@kernel.org>
References: <20240201075805.7492-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201075805.7492-1-krzysztof.kozlowski@linaro.org>


On Thu, 01 Feb 2024 08:58:05 +0100, Krzysztof Kozlowski wrote:
> Sort entries alphanumerically.  This was a semi manual job with help of:
> 
>   cat Documentation/devicetree/bindings/trivial-devices.yaml | grep '    - ' > old
>   cat old | sort -n > new
>   diff -ubB old new
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Charles Hsu <ythsu0511@gmail.com>
> Cc: linux-hwmon@vger.kernel.org
> Cc: Guenter Roeck <linux@roeck-us.net>
> ---
>  .../devicetree/bindings/trivial-devices.yaml  | 73 ++++++++++---------
>  1 file changed, 37 insertions(+), 36 deletions(-)
> 

Applied, thanks!

I'll try and pick up all the trivial-devices.yaml changes this cycle to 
minimize any conflicts.

Rob


