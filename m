Return-Path: <linux-kernel+bounces-132473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E79E899572
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BDB1F226CB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1019C1D556;
	Fri,  5 Apr 2024 06:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2fzG6jg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC1A18659;
	Fri,  5 Apr 2024 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298924; cv=none; b=M5PBd5+r7/uo13EGArq5EkWYugqER3rPMDGkulZWF9HhHkqM4q3oA6HM4jNc2+JAIon5dCMFY9ssDWuVYrtIjrL9qngpyYTlkuUGRHEbBJ0gF4IEcPi0OmUqfrCQkuId3wfYs8JBOSy+heDQE7NgaYJ1bSdz3cxaC4JjC8Cj8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298924; c=relaxed/simple;
	bh=pPuorhFj3frbjHffgW3nUZmzMcIbkT7Hc32VnpOtYAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr3FRZfww+rw5ukgSkUASrJttm/cI+mCI9SHjx4A+iSEjsPYA0M843ufhQKUnc340+cS53+6EcQ4cPnZdMs35B/sC068XoIjpE9aPfvcb50jw7a05gx2ta5iYi4tV1OkHeahn8/huIkRVhWg+9uEOCgd8vFJFBJNNwQA85w0JD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2fzG6jg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F942C433F1;
	Fri,  5 Apr 2024 06:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712298924;
	bh=pPuorhFj3frbjHffgW3nUZmzMcIbkT7Hc32VnpOtYAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2fzG6jg9t4Tl3X4STbtCcI1ZjrJsefdAPWvz3dfNLJ7MSyy7MRySvyZk5hJsFO1y
	 kBzWfW4p3fzrGqWzkEtegu1zDt73H+Amh8QpB+Zw80VHh6yEI7obbX/TXvVFR2bewU
	 LM5jTtqWsq0qmYZPsU3RVA3DPLvslMhmvl03Hm6YRsvhQJjQ1bP1yYu849DYiDZ+3O
	 JnCx8j4oY1LRl/7RCwmonssPrV4PFv/a3g1PbdGgtpxuCMXXsGMARBDkKTr+ErQNs9
	 QW2b8fwXynV1BW24TOzalroJSVqG0W/d8M7Bgijga6kjDBhjjFF2CXtyC84Np2uVjd
	 W7Fdw2wnhFLmg==
Date: Fri, 5 Apr 2024 07:35:18 +0100
From: Lee Jones <lee@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, mazziesaccount@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: rohm-bd71828: Add software-compatible variant
 BD71879
Message-ID: <20240405063518.GA6194@google.com>
References: <20240402193515.513713-1-andreas@kemnade.info>
 <20240402193515.513713-3-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402193515.513713-3-andreas@kemnade.info>

On Tue, 02 Apr 2024, Andreas Kemnade wrote:

> Add the BD71879 PMIC which is software-compatible to the BD71828, so reuse
> the same device_type enum.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  drivers/mfd/rohm-bd71828.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
> index 4a1fa8a0d76a..f0b444690d4d 100644
> --- a/drivers/mfd/rohm-bd71828.c
> +++ b/drivers/mfd/rohm-bd71828.c
> @@ -585,6 +585,10 @@ static const struct of_device_id bd71828_of_match[] = {
>  	{
>  		.compatible = "rohm,bd71828",
>  		.data = (void *)ROHM_CHIP_TYPE_BD71828,
> +	}, {
> +		.compatible = "rohm,bd71879",
> +		/* equivalent from a software point of view */

Nit: Sentences start with capital letters.

> +		.data = (void *)ROHM_CHIP_TYPE_BD71828,
>  	}, {
>  		.compatible = "rohm,bd71815",
>  		.data = (void *)ROHM_CHIP_TYPE_BD71815,
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]

