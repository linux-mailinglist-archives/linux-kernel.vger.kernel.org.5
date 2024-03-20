Return-Path: <linux-kernel+bounces-109063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B9288142F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76DD51C21532
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235A4F1E5;
	Wed, 20 Mar 2024 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuAWPno6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA49A4AEFE;
	Wed, 20 Mar 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947316; cv=none; b=nnqT65i482rFx1KZGpDPadoWrmuSFfRHWcgEMUcpuprChqrZ7dE6jQyeFxoLsuwwrFHQSwN7sod/aOTro0a6qS8xkjzKgCcVVeGEKd1UGikzHpCZjIcD5L5dD227lAXLoZbC7AlXZ8A/dQywZW1nZA08GrkHkE0pq1UQ02YyFdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947316; c=relaxed/simple;
	bh=cuT65SArsHk0q0YorBWmBbZLglwm8KniwFvajiph340=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FO/+HP+zS2HR9ITlfqS4HXcFpk6v0d6rVQ0c8YmivbilxRBGGFd3teD7N7aaoQYazPP7zOl+f4KYugRFosLs51qE7ldCE0H4MjX7g6St8ZBnTJ/VzH6Vys3Q0UxRoa8XYiAO4ynFKCSKDpeBnFCrJiq2YhszI0ung/Ys2B0/zF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuAWPno6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E2FC433F1;
	Wed, 20 Mar 2024 15:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710947315;
	bh=cuT65SArsHk0q0YorBWmBbZLglwm8KniwFvajiph340=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BuAWPno6kl1SLrWIxqh3LwKUkzMP738uIRi0OwUTOaxHUaKVpR0agxZPow7dN/Xbm
	 7gSCuSdapZkTJNJt0pwcpjDVsrCASgZ1AiVgX9mLWeRAHaU0V4/y6BTH+79VyHP9Hm
	 uOpEfNKuMm5tqCaCinZ5Yy8x7iGQZDwo3retd/Z6wP7AkiihKe1BXIgPbQhnZa9cYV
	 VxgpNhN5mL0PFCjvw2Al9C86ubexZTYcTV+ztk81TX2C0OHuy3HVF+uqlYevHPy6TK
	 en3aUDwqvRZW58P3Gsb2HUjM7f5b/+mHrZLfBlMi3P4CC8IbZNYi4CJMMUdP1eb3+Z
	 FaBDQagCNucrA==
Date: Wed, 20 Mar 2024 10:08:33 -0500
From: Rob Herring <robh@kernel.org>
To: Ivan Bornyakov <brnkv.i1@gmail.com>
Cc: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: media: cnm,wave521c: drop resets
 restriction
Message-ID: <20240320150833.GA1729819-robh@kernel.org>
References: <20240318144225.30835-1-brnkv.i1@gmail.com>
 <20240318144225.30835-4-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318144225.30835-4-brnkv.i1@gmail.com>

On Mon, Mar 18, 2024 at 05:42:18PM +0300, Ivan Bornyakov wrote:
> Different designs may have different amount of routed reset signals.
> Drop maxItems restriction, add a small description instead.
> 
> Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
> ---
>  Documentation/devicetree/bindings/media/cnm,wave521c.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
> index 6a11c1d11fb5..2cb4f68d27ac 100644
> --- a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
> +++ b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
> @@ -34,7 +34,8 @@ properties:
>      maxItems: 1
>  
>    resets:
> -    maxItems: 1
> +    items:
> +      - description: Optional reset lines

Your change is a NOP. In fact, the tools will translate an 'items' list 
with no constraints back into maxItems/minItems.

So it seems whatever change you think you needed, you did not validate 
the change.

Rob

