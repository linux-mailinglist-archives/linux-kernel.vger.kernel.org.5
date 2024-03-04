Return-Path: <linux-kernel+bounces-90765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678508704A8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED422281780
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E9546544;
	Mon,  4 Mar 2024 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXn/Ipfx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B143FB1C;
	Mon,  4 Mar 2024 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564342; cv=none; b=rY7JjnNKc8I8i7gASXB8wDJGrhChXW3ijv35vOPTmLdOhPXXu8BA93l0pi2SMVEJd/tFkVFzMORPLiiOWjhj+XpRMWM2CuempvPkPyLL65h5u5nF1OsNjA78Z67XQHo4EsYn0cjY4jkZkWJEnbC/QYbVKxS0Nnnp26CaTsYxhX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564342; c=relaxed/simple;
	bh=z2v8CXrrV+Qdm48Kfwgi9f4FfBKZReyYmFvVQIhpIIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBUueg9/aKBNW/awMiI/OJ5WD2OI9xuc955huUK6trV8/afaJ/8hnE8IO3sVQkH5pmh+9HJ6HNJqTb9ZQC8Z3fOnwahFVEuobBgEHrRAWDCOr+H7nwOiZeows8KW4ZLc2XqwrbC/JcJ/1W+ANUKaRIoJ4jE0DUgI0Bgxm8XvS8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXn/Ipfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4670DC433F1;
	Mon,  4 Mar 2024 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709564341;
	bh=z2v8CXrrV+Qdm48Kfwgi9f4FfBKZReyYmFvVQIhpIIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bXn/IpfxLlHInHt1mBCYOsDJ6/35WXKrKr68JSnnOGEXLENLgT62BsZrLgOfAgB/6
	 E1sBrthNYmxgtT9IT9X8hYXvLrC8ER0MVQMl500reWS8645A99eUsuX34qUPjFivip
	 KAN3dpODtigFzbo7lpVwTXu/WljtOiYOfx/g18jM7TIi9sENaDD1KERECcvo6inLcO
	 nyM/uYxS+IjjfBFexkLAZtCpzSBqH6os6856RvHtp6NSAaPU4CtC45ZDMT2kdeTqjx
	 iY7CyBaPQOT1C7uykxN9L2IjM6YiX5flJAJq7rl3l/EBjjmKLbk1byNkJ70FEq3uVy
	 eHDk/iCawOjlg==
Date: Mon, 4 Mar 2024 08:58:59 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <20240304145859.GA208747-robh@kernel.org>
References: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
 <20240228-asrc_8qxp-v3-3-d4d5935fd3aa@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228-asrc_8qxp-v3-3-d4d5935fd3aa@nxp.com>

On Wed, Feb 28, 2024 at 02:14:15PM -0500, Frank Li wrote:
> Some sai only connect one direction. So allow only "rx" or "tx" for
> dma-names.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> index 2456d958adeef..0302752d58a2b 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> @@ -86,10 +86,14 @@ properties:
>        - description: DMA controller phandle and request line for TX
>  
>    dma-names:
> -    minItems: 1
> -    items:
> -      - const: rx

Just this change is enough:

         - enum: [ rx, tx ]

(We enforce unique items elsewhere already)

> -      - const: tx
> +    oneOf:
> +      - items:
> +          - const: rx
> +          - const: tx
> +      - items:
> +          - enum:
> +              - rx
> +              - tx

