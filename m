Return-Path: <linux-kernel+bounces-48975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3A3846443
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E65A1C234B0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F59547A7E;
	Thu,  1 Feb 2024 23:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U092rYjg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF53D960;
	Thu,  1 Feb 2024 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706828634; cv=none; b=ipiep/PDGQxB1rJ3skMzJ44Wodydkrgf/umVdiey4a+LdG75UT1+tylrKr2AIq848gkYwJcWEi3rdworrd39MvaVutcTya6FyxR4u7UecKuncUAyizW9WdF+4PMcf2YzPE7j8thVBv1RTncPwEmlNP59zpUJlTXC90EuEBLCkX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706828634; c=relaxed/simple;
	bh=TmmtCVM8VC/h1dh1K7OAfFtepe6cXDGEX6jRnECeUSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNlPQ+SVYpVyQqh2/BYVFF8yswJO9d0Ska7v0P66jN2/MiZoMMvqXlvh6GsEbRueABA/HZeibShl++S4IWPfv0C452C/Fj9Av1b2TLjkbuAECPqwsKOwxqyy4ZqEqwY8NVoLiQFOfRXFA5NEOXAlfiYTz1QqWaHgKNCpFuNcnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U092rYjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41879C433C7;
	Thu,  1 Feb 2024 23:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706828634;
	bh=TmmtCVM8VC/h1dh1K7OAfFtepe6cXDGEX6jRnECeUSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U092rYjgLNwi7QIp1vfGTvwx3bbm/et2nujn/B1fWF3pZ4re6XSTPA1w3P9sgBwhG
	 UTbyh7Tp/10mgMtAFdPDdqb2fZA/O38Z3JsjQg9WUrVkdCAsretuzkDvBwcq6Pck2W
	 2ocfDFa2FoumfjGbemChrLwiE4eSgq3TlpOUbcBANP3dJaTN2HcK4JPIBhuqJ2ARqs
	 1GnKml2wyGNyJWGlXTCRWotg7wZbFBg/cO9hzCtfGSOPKKBL5wfctvIOnkfdqWx+jO
	 s0QJJo0xfaf2meoz3g1WQ3G0N/sfrJRDGYtUKd959N6QTxErGZa2j1ajhtOQY9DhaM
	 eNPsiU9S+EtAw==
Date: Thu, 1 Feb 2024 17:03:51 -0600
From: Rob Herring <robh@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 02/12] dt-bindings: arm: keystone: ti-sci: Add
 reboot-controller child node
Message-ID: <20240201230351.GA1900918-robh@kernel.org>
References: <20240131221957.213717-1-afd@ti.com>
 <20240131221957.213717-3-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131221957.213717-3-afd@ti.com>

On Wed, Jan 31, 2024 at 04:19:47PM -0600, Andrew Davis wrote:
> The TI-SCI firmware supports rebooting the system in addition to the
> functions already listed here, document child node for the same.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../devicetree/bindings/arm/keystone/ti,sci.yaml          | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> index c24ad0968f3ef..e392175b33c74 100644
> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> @@ -83,6 +83,10 @@ properties:
>      type: object
>      $ref: /schemas/reset/ti,sci-reset.yaml#
>  
> +  reboot-controller:
> +    type: object
> +    $ref: /schemas/power/reset/ti,sci-reboot.yaml#

Don't need a ref just for a single property.

But then why do we need a node here at all? Can't you assume reboot 
support for TI-SCI firmware (i.e. based on the parent node). Then you 
don't need a DT update to add the feature.

Rob

