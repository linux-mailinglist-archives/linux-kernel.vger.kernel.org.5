Return-Path: <linux-kernel+bounces-1610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B538150D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5826B1F2813B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9554B45C16;
	Fri, 15 Dec 2023 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZWFH3Ld"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E5E45C1B;
	Fri, 15 Dec 2023 20:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C139CC433C8;
	Fri, 15 Dec 2023 20:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702670584;
	bh=D3En7LevwtePTuCguIJqTHsJafw8n5zSzdRFnT9CLAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZWFH3LdzjpEwxz/BmgfBuoD4xQVv9+zSf04O7H952be0zt6Gn82JcEbbl7u4R94o
	 Z0i0jcQ7/7hUIfrckfBjYGcDSmVB0c0fIr6qOqRqqdD3oKNz7pSdZYC1fsRDsE9ZbH
	 6jUkCwk11YIvJfLy4PWk6KwjQgccmrL6Pqk9BNc6XM640oMgVyOu8jIEN9mqKBziwH
	 SqaTf/ERlhkEiEuQneDAw3/230kfcky/Vv82xSziwhRbJSom+2qPo53ncrJVhKQJDR
	 jzhc4AaR38XgbNApAnnkIaV1UPhgvBmZ1BRDgvq9BwA6fMG/v9ArjeRj6l8hquM329
	 WI7Xddpo8THkA==
Received: (nullmailer pid 303466 invoked by uid 1000);
	Fri, 15 Dec 2023 20:03:01 -0000
Date: Fri, 15 Dec 2023 14:03:01 -0600
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: andrew-ct.chen@mediatek.com, tiffany.lin@mediatek.com, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] dt-bindings: media: mtk-vcodec-encoder: fix
 non-vp8 clock name
Message-ID: <170267057932.303365.14773226712594255838.robh@kernel.org>
References: <20231215104551.233679-1-eugen.hristev@collabora.com>
 <20231215104551.233679-3-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215104551.233679-3-eugen.hristev@collabora.com>


On Fri, 15 Dec 2023 12:45:47 +0200, Eugen Hristev wrote:
> Looking at the binding it makes sense that the `-vp8` compatible has
> the `venc_lt_sel` while the other bindings have the `venc_sel` as name for
> the clock.
> This was also mentioned in the txt version of the binding before the
> conversion:
>  `
>  clock-names: avc encoder must contain "venc_sel", vp8 encoder must
>  contain "venc_lt_sel", decoder must contain "vcodecpll", "univpll_d2",
>  `
> 
> So it is easier to check for compatible that includes vp8, since that's
> just one, to have the requirement for the clock name property as
> `venc_lt_sel`, rather than for all the others, some of which are missing,
> thus for them, the requirement is wrongly `venc_lt_sel`.
> 
> Reordered the if/then/else to match `-vp8` and have all the rest of
> the compatibles using the other clock name (`venc_sel`).
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
> Changes in v2:
> - new patch.
>  .../bindings/media/mediatek,vcodec-encoder.yaml       | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


