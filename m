Return-Path: <linux-kernel+bounces-120634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D155488DAA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7338A1F2A05D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B5838DF8;
	Wed, 27 Mar 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=holoscopio.com header.i=@holoscopio.com header.b="I7W44Pc+"
Received: from grilo.cascardo.info (trem.minaslivre.org [195.201.110.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0468747F5C;
	Wed, 27 Mar 2024 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.110.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533378; cv=none; b=N5iYq7WeUsE9AShcPwRUPRsVwLtq5nskHZCX39bqXPYgbkVGs/8R0wLjtRuqh0COlc+QGOzi+afTsm2FY3OHPJaV+fjQopICIrARBuY4bCXcJMVkLwIGeEdfFRDspcviRIpN9ppbVf7FjPrrjPmv3zGDzIx/xx83bFrkhUSQGjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533378; c=relaxed/simple;
	bh=oZRj03f71Z6Mzs3OczjzQ0sW5FiStEjx1m5pPidYIQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMEnQ/sTFkQDm8HBuvrg6mZQ0Of7Td36aZ6DrEoMnPSeygkMOqbumSJMyV85Ebo4GKSEzIkjCAw7C90wkawQDWt5QE8aIGJhq/soYxIWYd0LbfUwnbCzkNlib9WlMPU/XD+bffgqbdD8fBycl+mK1d87K4GJf31MitvezIrF2hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holoscopio.com; spf=pass smtp.mailfrom=holoscopio.com; dkim=pass (2048-bit key) header.d=holoscopio.com header.i=@holoscopio.com header.b=I7W44Pc+; arc=none smtp.client-ip=195.201.110.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holoscopio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holoscopio.com
Received: from siri.cascardo.eti.br (unknown [IPv6:2804:431:e7c4:d08f:6a17:29ff:fe00:4f38])
	by grilo.cascardo.info (Postfix) with ESMTPSA id 22F3E206F1A;
	Wed, 27 Mar 2024 06:48:09 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=holoscopio.com;
	s=mail; t=1711532892;
	bh=oZRj03f71Z6Mzs3OczjzQ0sW5FiStEjx1m5pPidYIQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7W44Pc+qYTAd1YSNmEfPHrZvFEzsjJgtVRtDUKvyrJBZjhs71t595lKUm+6bHrxB
	 U2RCPrm9JEp2wGl/Dw6y9rEt7DgsbkE1zxPfiBPxG7G2dsx4D/nnBDP2rWHFnr+lxg
	 sNrtv/aeSdqNN3t+d6dpc8SpXxBPm7nkpehz6URLeyGXq7FxXofAxd3BmtEDL8SeM8
	 H4ExMJviG/MIge/gu/xAUcUgWqO/VuzLitivTi0CJkfZlCjGoulAcveX8zKC252TMQ
	 NyNFY1bOf7ZKWow2k9jLLa1+VI5jgu/3HysbGbjihXLLVvXGujBM74z2msdhoXeBkF
	 jRoY6f7ma2BAw==
Date: Wed, 27 Mar 2024 06:48:03 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: MAINTAINERS: drop Daniel Oliveira
 Nascimento
Message-ID: <ZgPrU0EZbaMwy5y9@siri.cascardo.eti.br>
References: <20240327081434.306106-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327081434.306106-1-krzysztof.kozlowski@linaro.org>

On Wed, Mar 27, 2024 at 09:14:34AM +0100, Krzysztof Kozlowski wrote:
> Emails to Daniel Oliveira Nascimento bounce:
> 
>   "550 5.1.1 The email account that you tried to reach does not exist."
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 51d5a64a5a36..de17c0950d83 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5207,7 +5207,6 @@ F:	lib/closure.c
>  
>  CMPC ACPI DRIVER
>  M:	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> -M:	Daniel Oliveira Nascimento <don@syst.com.br>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Supported
>  F:	drivers/platform/x86/classmate-laptop.c
> -- 
> 2.34.1
> 

