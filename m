Return-Path: <linux-kernel+bounces-126694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E101893BA8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9A91C213E5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E72E3FE46;
	Mon,  1 Apr 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxp575dQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B023FB1E;
	Mon,  1 Apr 2024 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711979799; cv=none; b=KGaW/50g74zK4BT4HegxG+nnUDCNlIRp5G7lL5+gUtzMNFTYPtuCmyx7NOgHj1jLlhp15X9GU0y66LRe5LBfIfMEAacUYtPN8flwRXXIc73Xttd3W+7NfeSNrX/zKN/jgA+qhH9cIHtMYJ1H40ODrSQuB97wQ+UjDP9jxN8eu/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711979799; c=relaxed/simple;
	bh=SB286+nY7DQGLoaBo1jo/XJvyvYzcBgrwXpwBgupmWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okeW6jGjK8uV6A+J2tDcZjTVPHh9nR8T/1OXpPtAx4RPw1gc9mZbkSKt0UHZaULTy05WPU3x0v6+Uef3KO2PmDzOuOUWGwPQld4BYbSTogxZ8ZVO2CPd7eY3ENB76uPVf6mlIpdUKP50vo0okfHJdFrcDa/h6ayMVFAfUYxXlS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxp575dQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E18C43390;
	Mon,  1 Apr 2024 13:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711979799;
	bh=SB286+nY7DQGLoaBo1jo/XJvyvYzcBgrwXpwBgupmWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dxp575dQiKZXAdercVf8cUDwWfKwEI6IqLjDU0pN3iKC0OrWxwjzbb0sw0uNSB2su
	 DPVp94ewBebNT2v7SyvuYfXsqUtZpuUvIwWT6EtFTNIZpVf/zF7D0puWN82DDXTa6Q
	 Kpubtuqo9ATNQorO7++V53Rx8U58e13DUolQFy9a7g0XztCd9yAtBGZ70qTnVn534V
	 mzlsyll3/cmjN5WycpuflvPpxhB+kKCL1N70VmsHaxLPjc6UjtiLJo3Cr1rEybUnEb
	 i3tJWsVtJV6N59bCi3vYfRUQQWBcdPctEdOXf4zm4Aqec43LuDYbhXz0mgM8gHMD3z
	 3jWM2YyadVUzQ==
Date: Mon, 1 Apr 2024 08:56:37 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Yin <peteryin.openbmc@gmail.com>
Cc: patrick@stwcx.xyz, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] dt-bindings: watchdog: aspeed-wdt: Add aspeed,scu
Message-ID: <20240401135637.GA342928-robh@kernel.org>
References: <20240328022231.3649741-1-peteryin.openbmc@gmail.com>
 <20240328022231.3649741-4-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328022231.3649741-4-peteryin.openbmc@gmail.com>

On Thu, Mar 28, 2024 at 10:22:30AM +0800, Peter Yin wrote:
> To use the SCU register to obtain reset flags for supporting
> bootstatus.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> index 3208adb3e52e..80a1f58b5a2e 100644
> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> @@ -8,6 +8,8 @@ Required properties:
>  
>   - reg: physical base address of the controller and length of memory mapped
>     region
> + - aspeed,scu: a reference to the System Control Unit node of the Aspeed
> +   SOC.

You cannot add new required properties as that is an ABI break.

If there's only 1 SCU instance, you can just fetch its node by 
compatible with no DT change.

What's the plan for converting this binding to schema? This is the 2nd 
new property in 6 months.

Rob

