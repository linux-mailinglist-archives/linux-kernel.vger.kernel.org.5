Return-Path: <linux-kernel+bounces-96318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4A9875A26
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918551C217D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA38313E7F4;
	Thu,  7 Mar 2024 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsbNL5fT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03193138480;
	Thu,  7 Mar 2024 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849951; cv=none; b=qp0BEenpGx1l31rjXIs1yGZg4mqewfsAg+c4y44MsAbAdDGlsSkMCdcbhykT3DlPmwwUiHZkZrd/06584cAYKi29QDb9pQDnNv2Rxr089XIiaJDQ4PJS2IFgsiO+PLKmqHmTofzn0FGQZygZS9qCLgx8GiKuESLupuClTR8/RGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849951; c=relaxed/simple;
	bh=NAFhcgfMUP7spt7IIedCEfy35hhbhzwIEFEoh/NeEfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxJv4HfmS0uTz2sELb9FvMt9HayDJH8gqexBTvIitNWgP0bMnZSFJVbTWSPpp9+qRXprna6Uxzn879mlcRR5DcB26S3aTk6mAyEXnU/RPBUAdojlwJonfFsFn+BFVJAZkrmK2yH4D3Fn96MtRPnAx7hGeOycvx0wAfY0iUelfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsbNL5fT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D7AC433F1;
	Thu,  7 Mar 2024 22:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709849950;
	bh=NAFhcgfMUP7spt7IIedCEfy35hhbhzwIEFEoh/NeEfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tsbNL5fTmJHEXUV4T3i+J45UyNghKGJh5J/Ee3Um2FXS43jCijoYt7WgveHk6nXF7
	 LSNNzbv8qAp3G0+niY2F+7B/KpJ/ivwZtqQ60EDypwdYWblwwu5MAgbL97VeTnnWiZ
	 183dRsQZFQmUSNODn/9CoN4z/1Lc3tk1wv8vxTDHXWeHuVu7JNpGDxFR+9Ko+GcH7k
	 Jnp1ZPb/4jQdTWLaaYI53nic5WKN+E9NQ5z9cmEcvaC3O9XsJIONZNu76RPpnisyOD
	 7kIlcWKao7IAByVD4vIimTF7wIvM+jV6qGDtfwMSpHX9yU9zP0wJ4eqvr0Cf1Mut87
	 wPCOCxbkCBCTw==
Date: Thu, 7 Mar 2024 16:19:07 -0600
From: Rob Herring <robh@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: magnus.damm@gmail.com, devicetree@vger.kernel.org, conor+dt@kernel.org,
	linux-clk@vger.kernel.org, geert+renesas@glider.be,
	krzysztof.kozlowski+dt@linaro.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, sboyd@kernel.org,
	linux-kernel@vger.kernel.org, mturquette@baylibre.com,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 05/10] dt-bindings: clock: renesas,rzg2l-cpg: Update
 #power-domain-cells = <1> for RZ/G3S
Message-ID: <170984994653.3258431.619276607715437902.robh@kernel.org>
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
 <20240307140728.190184-6-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307140728.190184-6-claudiu.beznea.uj@bp.renesas.com>


On Thu, 07 Mar 2024 16:07:23 +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The driver will be modified (in the next commits) to be able to specify
> individual power domain ID for each IP. The driver will still
> support #power-domain-cells = <0>, thus, previous users are not
> affected.
> 
> The #power-domain-cells = <1> has been instantiated only for RZ/G3S at
> the moment as individual platform clock drivers need to be adapted for
> this to be supported on the rest of the SoCs.
> 
> Also, the description for #power-domain-cells was updated with the links
> to per-SoC power domain IDs.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v2:
> - updated patch title and description
> - kept both 0 and 1 for #power-domain-cells as not all the drivers,
>   device trees are adpated with this series
> - added a reference to dt-bindings/clock/r9a0*-cpg.h for power domain
>   specifiers
> - dropped the changes from examples section
> 
>  .../bindings/clock/renesas,rzg2l-cpg.yaml      | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


