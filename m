Return-Path: <linux-kernel+bounces-95719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C28751B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100DE1F26109
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD9C12E1C2;
	Thu,  7 Mar 2024 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgevToSY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1C12D750;
	Thu,  7 Mar 2024 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821322; cv=none; b=EpnpyvwrPfx+CuYmyYD2vRzWamq5f9cNtGYd6BtvQ1CzYZAcUTk3UniPsTBk5REhd3CCz6GP85493a/RQwEkuigqwrPyrDzgvf8mX6ARCcYv6t1h4uGGKwO5KIWNP4eYc8e2/+UBGv46qljcKZSToxqpsi+n5qBmS93cD2b4Qt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821322; c=relaxed/simple;
	bh=pQyoaEYrKSppwNKzOpGfaNBb34IlG28Na+zxotMV8v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpxrmEBBOrWkU8uRIGRTzZmX+7GqYgC7U8IJNaJZDjgJhL+whX8iw+eegTFL94bT0dLZuoA2vSeI4bpmZSpGApPxumT/lMMMUGCA2udwcyYH1zEXiW7Tu9lrqjjPtOqo7v7j0PGkfMqfQb872Z3OHYAkhTFWkUglmY1b6wpR29I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgevToSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A406DC433C7;
	Thu,  7 Mar 2024 14:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709821321;
	bh=pQyoaEYrKSppwNKzOpGfaNBb34IlG28Na+zxotMV8v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lgevToSYmmpFcs8YrXwoiAu/k99Og7eqcm05vCGKtuEHocBw5foVy+e7PvYUhEKLK
	 MsAaiddb7s4bJbLl5uSHQ9E9q9n8F/5ps64cUAgKnvtIhIsSJykTE+4sV+qvSL0uhK
	 ifQzdyYnjgdw7ZAfoUROcADECtSDw1/Yvq7byNJKX3iA8KHwJVahNDCWzgZ8OoV6EG
	 lLyABkQr0u2K3C0Z5l3gQLfca9OvUmUAQ6iPSEygFHUjymZFALGd4mySvA9sbys5hB
	 RigP3KAH4wZK7z08JyYCpbM7aross19IZtLsxgA9OX7XgY743Cf/uEQiG474iR20OW
	 ignM9Wxc/lcoA==
Date: Thu, 7 Mar 2024 08:21:59 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Kevin Hilman <khilman@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/9] dt-bindings: usb: ti,j721e-usb: add ti,j7200-usb
 compatible
Message-ID: <20240307142159.GA2542409-robh@kernel.org>
References: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
 <20240307-j7200-usb-suspend-v4-2-5ec7615431f3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240307-j7200-usb-suspend-v4-2-5ec7615431f3@bootlin.com>

On Thu, Mar 07, 2024 at 10:55:03AM +0100, Théo Lebrun wrote:
> On J7200, the controller & its wrapper are reset on resume. It has the
> same behavior as ti,j721e-usb with a different SoC integration.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> index 653a89586f4e..e8f7e7511483 100644
> --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> @@ -16,6 +16,9 @@ properties:
>        - items:
>            - const: ti,am64-usb
>            - const: ti,j721e-usb
> +      - items:
> +          - const: ti,j7200-usb
> +          - const: ti,j721e-usb

Combine this with the previous entry:

items:
  - enum:
      - ti,am64-usb
      - ti,j7200-usb
  - const: ti,j721e-usb


