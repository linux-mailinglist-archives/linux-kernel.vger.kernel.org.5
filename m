Return-Path: <linux-kernel+bounces-82260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A0E86814E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213CE1C23E62
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFEF12FF86;
	Mon, 26 Feb 2024 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0IXPI4d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287EA12FB3A;
	Mon, 26 Feb 2024 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976610; cv=none; b=gHfkwj5zq8jdxBooVVMXjXhW+ALhhXX42cax+SMoOmw7H/Op4Yb8NAKQo3RvvaNDSq50ypEvQAw3j9x9zHBsyQCbZJPUfXOyisTUUBBqaqwBHmCWHF9PFM0gBaVvHbfpE/CzBaBRMMn7QkFWsaOvBegMN7p/a3hj7UtwJaEplM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976610; c=relaxed/simple;
	bh=CRbzg3rWJUoapiZSUsxDHPOv7O61fCg/LINaIjM6U1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOPsniBrENuNVG6W2VaSySLHJnn6NaQ4e/x9Eb4kr976YW7z80eqWTSUFdHqdpvi2KpT6ayPjMmDYnVV0U+7FoG+ejHIgx3bVgP632GA7DjZO6HSSrFFplbr6cbKmIgvNO/17F0J9fxYPq7VYiRG+inxioGGiHvyd3rWla1XQ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0IXPI4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EB6C433C7;
	Mon, 26 Feb 2024 19:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708976609;
	bh=CRbzg3rWJUoapiZSUsxDHPOv7O61fCg/LINaIjM6U1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0IXPI4dWKlld0TX6QnB4qrnJMvDvykfmwsHHFmiKjr8jONcHUl2/oSCnJTLWw6v/
	 e3gHkRGNvoJM5HTl6zsStgUuYhPMK/12KXr3QkDgkIWP/3LvDF7V1IEYzjsgLRPy+B
	 8p3ikD/3LW3vrq+5dJhJeN9iBvIzNRH/RApLsjAmzIjcoXgB+dTZrt8RdV3qbhWbJN
	 iGM9xus/74MA8FzdhwjwEaCGu6zvwFk7gYno80pebjzbUkkQTvS3jWQmaLNnt6ju2L
	 yeWBsi9gfb69koOxTnUDr2zUYAMIBw+ouCUFHknNBtqG62mjDiBZ1vOkgR3jF2xPYb
	 2pSd62O6eqlig==
Date: Mon, 26 Feb 2024 13:43:27 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: arm: amlogic: add Neil, Martin and
 Jerome as maintainers
Message-ID: <170897660703.1317880.16581710522159452609.robh@kernel.org>
References: <20240224084030.5867-1-krzysztof.kozlowski@linaro.org>
 <20240224084030.5867-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224084030.5867-2-krzysztof.kozlowski@linaro.org>


On Sat, 24 Feb 2024 09:40:30 +0100, Krzysztof Kozlowski wrote:
> Add rest of Linux Amlogic Meson SoC maintainers and reviewers to the
> Amlogic board/SoC binding maintainers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Entries ordered by lastname.
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


