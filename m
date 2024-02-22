Return-Path: <linux-kernel+bounces-75924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAA485F0C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5331C2153E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB2A7483;
	Thu, 22 Feb 2024 05:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="g0cHn1fn"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C06FB2;
	Thu, 22 Feb 2024 05:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578870; cv=none; b=XoVZtqrXbrCyLCVpvXGD6XyrvwgzgHvXDVKrTibKZBhJ73NJzuPjREuiBnFQ5LMJpaYv0kG9p19HA7zW9kfsNavZJXRKBKTunH2+3Hc1AKP9dUVqCufgGhAtBLKEn3pbzk9CVbVBsm/acJ1GAsWQ0KBCHa1KqBLhZp1vlQbrk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578870; c=relaxed/simple;
	bh=N4KpCM+UVrNx33f8oBGXZMbn6GuSNZZSPQgZqz/X9Sw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ViUJyfw6GlMxrgQlr9EYGy+cmDJnNQldBC6QU7PUsbIK7zPgbY3u58aeztYZCmR0/e8Ck1iDdwfpP9aVFwnSIhnJxwOR/Vm68ctYmEWnVTkmgfOLMfOC6ACq0n2u/jsslbXq/VnUqsXy7QupznCJFWRz4K/i2BlwAj8c9awxAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=g0cHn1fn; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.16.88] (ppp118-210-168-240.adl-adc-lon-bras34.tpg.internode.on.net [118.210.168.240])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 93A7120127;
	Thu, 22 Feb 2024 13:14:22 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708578865;
	bh=89ProCV78HKbw9sgfRbewDIGLrfuKhODmhkmtlXU7lw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g0cHn1fnMT6UpTNcpHCJ9LOZRxITvHjhkLUvdoHuoEqCSvt4DyHBI3/QDbJgMHhne
	 hv/PFKdK0XzOAmAQjQkKCCtjKxBG9OPX2PnkDHnRSucKG23cPf9Ik9x4MgwBLTPHVq
	 s0yzTbSZSHwQ8kXSnU6uhLoHkKbv+gnzUOuLckJsGjK7KgN8JWoNMZbnbyuckR79bv
	 T5IR5gFvH/TA/F/TxCU7dWUiDdSdc3RRBm7MwXc0F0LdZC7KkOwyZ5BJq/G2QAzyP9
	 DzR09xY3euO6q/CzzrpuG+1R0rxgszMfARDPWtsIVpqlVJrWH9J7g+qiYU3W/cxMao
	 4qHi/YThobLaA==
Message-ID: <2ab9b3924dbe07039e934d4580ab7dd397a31728.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: arm: aspeed: add ASUS X4TF board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kelly Hung <ppighouse@gmail.com>, robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, kelly_hung@asus.com, Allenyy_Hsu@asus.com
Date: Thu, 22 Feb 2024 15:44:20 +1030
In-Reply-To: <20240222032504.1147489-2-Kelly_Hung@asus.com>
References: <20240222032504.1147489-1-Kelly_Hung@asus.com>
	 <20240222032504.1147489-2-Kelly_Hung@asus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Kelly,

On Thu, 2024-02-22 at 11:25 +0800, Kelly Hung wrote:
> Document the new compatibles used on ASUS X4TF.
>=20
> Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/D=
ocumentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 749ee54a3ff8..60a494b7aaaf 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -74,6 +74,7 @@ properties:
>                - ampere,mtmitchell-bmc
>                - aspeed,ast2600-evb
>                - aspeed,ast2600-evb-a1
> +              - asus, x4tf

You need to remove the space after the comma. This should be
`asus,x4tf`.

Andrew

