Return-Path: <linux-kernel+bounces-50480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3206A8479AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE4C6B20D05
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9332765E04;
	Fri,  2 Feb 2024 19:29:31 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639515E5C5;
	Fri,  2 Feb 2024 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902171; cv=none; b=TaB/J9gm5EZXfTIgo1FnHeUqeOzX2T8ekBcvPxkYQYvhUgosIiCcPDHJ09v5CJj7aR7QVvJV/+3ma3KHoEfePqLRpGYcc8O80RMWJXc7GLyMdk3TMPL8u84XiN2XLiLjg8iStGMGfkgm33aXr9/AwtDIN8vUfOJ6HZu7RAzqiMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902171; c=relaxed/simple;
	bh=OSLx8ZGHgNRq/oilqETzpjFY24Zt3C6hbKYIPHxjhUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQTVRzu3LLr+qh1xqaV2se69GNbevlmMYHkO7CTIqW9OSDoZYLHm9+X7ys1ZWjuyT9BPf9/F5bEuXo17tPfK/2TQpQV/xoshNvFgTziKlwFcpMuhIUCasFFeBI6iReOX1k4dBCa4EchlcnD3lMZhRb6Jsnld75JLfMLyyyY6g3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5D9DD3000C980;
	Fri,  2 Feb 2024 20:20:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4DDF8406333; Fri,  2 Feb 2024 20:20:48 +0100 (CET)
Date: Fri, 2 Feb 2024 20:20:48 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Patrick Williams <patrick@stwcx.xyz>,
	Tao Ren <rentao.bupt@gmail.com>,
	Bruno Thomsen <bruno.thomsen@gmail.com>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	joel@jms.id.au, shawnguo@kernel.org, bcousson@baylibre.com,
	tony@atomide.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 20/23] ARM: dts: Fix TPM schema violations
Message-ID: <20240202192048.GA22666@wunner.de>
References: <20240202183926.540467-1-sashal@kernel.org>
 <20240202183926.540467-20-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202183926.540467-20-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Sasha,

On Fri, Feb 02, 2024 at 01:39:16PM -0500, Sasha Levin wrote:
> [ Upstream commit 8412c47d68436b9f9a260039a4a773daa6824925 ]
> 
> Since commit 26c9d152ebf3 ("dt-bindings: tpm: Consolidate TCG TIS
> bindings"), several issues are reported by "make dtbs_check" for ARM
> devicetrees:

You've auto-selected this commit for backporting to v6.6 and v6.7
stable kernels, but it's only really needed for v6.8 to avoid
issues reported by "make dtbs_check".

So IMO this commit can be dropped from the v6.6 and v6.7 patch queues.

Thanks,

Lukas

> The nodename needs to be "tpm@0" rather than "tpmdev@0" and the
> compatible property needs to contain the chip's name in addition to the
> generic "tcg,tpm_tis-spi" or "tcg,tpm-tis-i2c":
> 
>   tpmdev@0: $nodename:0: 'tpmdev@0' does not match '^tpm(@[0-9a-f]+)?$'
>         from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#
> 
>   tpm@2e: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['tcg,tpm-tis-i2c'] is too short
>         from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#
> 
> Fix these schema violations.

