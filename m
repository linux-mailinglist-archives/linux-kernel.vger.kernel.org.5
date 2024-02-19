Return-Path: <linux-kernel+bounces-72029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E6A85AE08
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2505280A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BBA54FA7;
	Mon, 19 Feb 2024 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="VIojW0+x"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C054750;
	Mon, 19 Feb 2024 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708379371; cv=none; b=ecSAaMiD76uf6WkXZ/7N1VUiYHAf5rwtJAWPgGSOr76pkjV5pDTfwQS1b0uuEu2QLJ/EiOWcgctxorDumIFFMMErUR7qiyrhf3TFZvrEYu2L0KgJh0q5/2BCpIYUbut3DPuIlX5m6qnj9C8EdrsaM4FDGjt+IC0vIu8LO0/7mXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708379371; c=relaxed/simple;
	bh=MwlZPQydiUTgLjiT566xCPNMY9FV3gDoEnY24s9X8sk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SN1FrrFGwL/FMI5YCbWlspnHAcGDOT3BFYDJoPQEcRxlQ4gJ0QpGzuVeyit3yShQzCm4nNwrSFJkOvPaIWMaR6j92qaehGYxabyaQahipKQ3NbSFCLO8bjzOiIRgCGhAVfYZNjF3TmgcC96o21nzhMQh8D86ggesJRpzIlcMsjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=VIojW0+x; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B141B5A26F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1708379369; bh=MlX+7ARQZsUZU7KaqQLobZ9XeWXdvwsDzVJEuhd3H50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VIojW0+xF5UWVlm8UzLSJBjLCR4WOQ1LlFdO81AFVFXt4yldSXloOYEUYZohuRS6I
	 WlVkCrFmrfz2eEAQaEEJvpk2NUUdfvzmENBz7JGfqEe1SF7Bdq7O5n0VON5u3O61C6
	 q30enbLJchbXr2l/nlkHaO+k7tE3TzxFgOy/0rUc11vtjnDNbfpvU1n7TO/qD8Gydc
	 D53JbtjG6P9Va6tBh9YGncCs1RwzLhxJp4sewviLqV1RU//9rXR6PzpPD9a8ToM/of
	 8+3TYCA8bdDx7Nwf2FGavrtyiX2SQBjRu+QWoq2yMhr7BOAqCZ2t3HlhFMkrmGy3qd
	 +lqc5MKjaeBXQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B141B5A26F;
	Mon, 19 Feb 2024 21:49:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs: MAINTAINERS: add "Profile" keyword entry name
In-Reply-To: <20240219082448.14157-1-krzysztof.kozlowski@linaro.org>
References: <20240219082448.14157-1-krzysztof.kozlowski@linaro.org>
Date: Mon, 19 Feb 2024 14:49:29 -0700
Message-ID: <87o7ccm8eu.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> The HTML output of MAINTAINERS file prints "P:" for subsystem profile,
> e.g.:
> 	Status:   Maintained
> 	P:        process/maintainer-soc-clean-dts
>
> Use "Profile" as this entry name.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Changes in v2:
> 1. Drop duplicated "Profile" word.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b9c3100ef587..36fac6b3499a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24,7 +24,7 @@ Descriptions of section entries and preferred order
>  	   filing info, a direct bug tracker link, or a mailto: URI.
>  	C: URI for *chat* protocol, server and channel where developers
>  	   usually hang out, for example irc://server/channel.
> -	P: Subsystem Profile document for more details submitting
> +	P: Subsystem *Profile* document for more details submitting
>  	   patches to the given subsystem. This is either an in-tree file,

I would have taken this but ... SeongJae beat you to it by a few days:

  https://lore.kernel.org/r/20240216201902.10095-1-sj@kernel.org

Thanks,

jon

