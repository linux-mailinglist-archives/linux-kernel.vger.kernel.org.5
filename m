Return-Path: <linux-kernel+bounces-82267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B83F868169
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E311F24E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C406C130AE8;
	Mon, 26 Feb 2024 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv5A4TqM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00601130ACC;
	Mon, 26 Feb 2024 19:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976850; cv=none; b=SnMCY/wsQn0QjIYiSB3Ei33N5vCBvRR7FM/YgBHvWQurxobVg0c8+cIueaYy881ntjykwqBwp4gUlP7XhOfKDMBBDN78QgS5B/eQMSZWaVk5IBAyGvtwzpbU2ZSuHbk54Ay9FXDUro+CC6UIgNsKC5Gv4OWieH8mmw94XoAnboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976850; c=relaxed/simple;
	bh=bN2ZLXQ1BVg6TFH1/7WADY4uD05YSBJXrczGwIHT+ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ra0GpjZJDB5L2X+sKRpMF7e4/6LkuHKvZTFyjH5j50o5+XDKmfZNGYsuJxGswHWuUCYCO5PfC0hxbDvLsDVRFi++sqnzDWz23wZ2gXGXTJ+xgw0/pkoJ7tHPRn+d0FQik7yY+x5HOejT3sflWNsBirOKcrr8Loyk5BpAAa2svMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv5A4TqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E98C43390;
	Mon, 26 Feb 2024 19:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708976849;
	bh=bN2ZLXQ1BVg6TFH1/7WADY4uD05YSBJXrczGwIHT+ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sv5A4TqM2dKTf46810qK1BFMH3qGSEWGaUdMxPKbvk8UccqJUjdtNVbuwwyCya3pt
	 DS41bXK1yrW/w3beNOO2FYfgAixrfxF+vjRG5q6E7YDs6fKBC8BfhoS2FylWjri9k+
	 xX60aHCdCY7YpHYj3b1YOEuUlInAZ8ZemnQDcxIFsr9Rpx9kanUwqG1+3aeqGb0xEj
	 RmtcIAEIQfW7SRX5gsIjpmyIpvIZHhPUFKejBo8zxsxr5bfnGXcajOqa7ezvvQaGbk
	 QW7t4ClCS+nzM0gI+7cxRSwaWBJ0h+K1MaWQBGoB2XK1Zo0z52XPeIU5GCDtMJbpSi
	 i3f/qwKFiux0A==
Date: Mon, 26 Feb 2024 13:47:27 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [RESEND PATCH v2 1/5] dt-bindings: sound: Add jack-type property
 to sun8i-a33-codec
Message-ID: <20240226194727.GA1320480-robh@kernel.org>
References: <20240224135501.3822390-1-megi@xff.cz>
 <20240224135501.3822390-2-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240224135501.3822390-2-megi@xff.cz>

On Sat, Feb 24, 2024 at 02:54:54PM +0100, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> The codec driver needs to know what jack connector it is connected to
> on the board. Add proprty to describe the type of connector.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> ---
>  .../bindings/sound/allwinner,sun8i-a33-codec.yaml        | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
> index 63eadc4200ac..399fc00ad3f4 100644
> --- a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
> +++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
> @@ -44,6 +44,15 @@ properties:
>        - const: bus
>        - const: mod
>  
> +  jack-type:

I'm all for a generic property name, but it needs to be documented 
somewhere common. Perhaps dai-common.yaml.

I'm sure there is some prior art here to consider as well.

Rob

