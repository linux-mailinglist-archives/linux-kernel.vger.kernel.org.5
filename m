Return-Path: <linux-kernel+bounces-112683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B357E887CEE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D282815D9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BDB17C79;
	Sun, 24 Mar 2024 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4EZkOe2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C712107;
	Sun, 24 Mar 2024 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711287989; cv=none; b=CNyrOuJftEe4JCO3EmUT80vYz7/uCn1ILOlpPJKRP7o+iXNUPiuN5xNzmPcTlsRS4oWKvpZtCwBI1385EqZ9tnAj2agg9ogF7CkNN79GgOBvjG++4Rsr7wDFXiUjt2fkpgKkTBpBP1reUniGFhZNqACiIaoxOWud80T7uiUdrpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711287989; c=relaxed/simple;
	bh=0HlMU7/a84GQ2AgaVMZjHCoXU5bh3NtAqzmZKQB52pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrPWs2DEyRuhRHi/QB2cYBiHK4Ah2QVDpJiLKg9ZkYs5dihHwh2b96hw68x7mSy77Wwy6F4+nxB3TKtVraw35Lw0iF6qAkMKOTswK2vdUHba66KyxHGX0CbFRqon34jVulJmsO4r/+MLfg28pip2OgS9HFGZONgiQa0YAFnuLs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4EZkOe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B579C433C7;
	Sun, 24 Mar 2024 13:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711287988;
	bh=0HlMU7/a84GQ2AgaVMZjHCoXU5bh3NtAqzmZKQB52pQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F4EZkOe24/pnJVnwRg4lRoAiGCTxwRXGEex+ncGUAfSuI7is6JbVgUwLjld/3C/gM
	 IEg33+IrV2BPkTZtrqrAilrAh1WcpD5gIWvk/sPB3wV7LbSDzzRM/h1YBqZuaZakys
	 66r75Ix2cIGJuWd3SFfnNP9NLBLWJZ8kMqWgQsPn0i/EUcf2lbXQzu622Ly4jiOxcT
	 veetDOQt2gUl3TCCP/DI1EJXt7NaeUW3kuNRGHUFFOGhwWfGl8wXs5PbvpRd4QaPZT
	 gTozr3mx1PnGo1Uywx+ObX1OmzBQGETO4/AnVWImOo7ZX1ZmWnOtS9U4Rz+siJl8WR
	 1nkvaOOUvDrhA==
Date: Sun, 24 Mar 2024 13:46:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Matt Ranostay <matt@ranostay.sg>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: health: maxim,max30102: add
 max30101
Message-ID: <20240324134615.0380ef81@jic23-huawei>
In-Reply-To: <20240321-max30101-v1-1-00b83e966824@gmail.com>
References: <20240321-max30101-v1-0-00b83e966824@gmail.com>
	<20240321-max30101-v1-1-00b83e966824@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 19:33:48 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The Maxim max30101 irs the replacement for the max30105, which is no
> longer recommended for future designs.
> 
> The max30101 does not require new properties, and it can be described
> with the existing ones for the max30105.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Given there were no driver changes, is it fully compatible?
i.e. Should we have a fallback compatible here?

properties:
  compatible:
    oneOf:
       - items:
           - const: maxim,max30101
           - const: maxim,max30105
       - enum:
           - maxim,max30102
           - maxim,max30105

So that a DTS file could use
compatible = "maxim,max30101", "maxim,max30105"
and work with older kernels as well as new ones that understand the new ID?

> ---
>  Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
> index c13c10c8d65d..0e455809340f 100644
> --- a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
> +++ b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/health/maxim,max30102.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Maxim MAX30102 heart rate and pulse oximeter and MAX30105 particle-sensor
> +title: Maxim MAX30101/2 heart rate and pulse oximeter and MAX30105 particle-sensor
>  
>  maintainers:
>    - Matt Ranostay <matt.ranostay@konsulko.com>
> @@ -12,6 +12,7 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> +      - maxim,max30101
>        - maxim,max30102
>        - maxim,max30105
>  
> 


