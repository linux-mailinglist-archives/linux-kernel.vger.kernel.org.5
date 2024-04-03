Return-Path: <linux-kernel+bounces-130231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4AD8975BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE3F28C1CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDD0152172;
	Wed,  3 Apr 2024 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojtKpnha"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B991514DB;
	Wed,  3 Apr 2024 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163487; cv=none; b=JIkxp9SiJzDD/c+8V4dlV0PFsXXjegqhdTcSBd/UbWif+s9P51XtU83IKMulqeTYepJYxsa4xT1onzkEiDgY4T1Os2+GZB3dR2WNQrdPSnAEqy5Zv5lsDCKKh3UDYr4vcN8Lw3Ap+qe1JGx1qyDYBHVqlQjbvKu57JaAqmHOEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163487; c=relaxed/simple;
	bh=9rLMe366FhUw6+imqIqQBG1vHsoorewZtvDCW2ZLNc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7pbgh6EVhoKoIW71OW+7VTcR9J1QkUjsWiwRDpQYT3rIaaQswEH5ST+MgWwYLueVxFr41FzEaHo/VdhnMzlJjh+vt7BvLKo4wmwtRSyBzpnQ26MCIlvNrcUbRgi64pyjNMyMK1LRq9gXiXctZ7qorYnUhf0WdrWkzdcmAU4ROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojtKpnha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4985DC43390;
	Wed,  3 Apr 2024 16:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712163486;
	bh=9rLMe366FhUw6+imqIqQBG1vHsoorewZtvDCW2ZLNc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojtKpnhaY1d27rxoQjGBAiQWNjZzZPL6hc2QUxgcI/wE3dDp9TLn0J74mI6ZpFs7j
	 L4zAvkuZxjNKKErcfxMJ+gAgGOWOTaJAVjIRPswKCQ+IE76rFuysjOLhG2nNU4YCdU
	 cgoG6fg7cdOmTXdVaW7HZqxAzeaDqKAxDVjDNSIJwOB0+OSAzqnB48n1OsceSX70lu
	 gtDLarjj37V5cCJ0Yj51P5lcsjdNFBp9YYIYLGicmJU4vxALZ9a1crs+rcyVydYzKz
	 FgsUcavs7X0Hnk3SAdrmdZN+Y0NyiMJQzmkq5c3cgMz7H7V8bt/ddjEDXUF3tceZGZ
	 ooXOVE1bt9nRQ==
Date: Wed, 3 Apr 2024 11:58:04 -0500
From: Rob Herring <robh@kernel.org>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH v1 3/4] dt-bindings: arm: fsl: Add Colibri iMX8DX
Message-ID: <171216347777.3984715.9828328734762234096.robh@kernel.org>
References: <20240402193512.240417-1-hiagofranco@gmail.com>
 <20240402193512.240417-4-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402193512.240417-4-hiagofranco@gmail.com>


On Tue, 02 Apr 2024 16:35:11 -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> Add support for Toradex Colibri iMX8DX SoM. As the i.MX8QXP variant is
> already supported, update the description with i.MX8DX and add
> 'fsl,imx8dx' item as well.
> 
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


