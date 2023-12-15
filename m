Return-Path: <linux-kernel+bounces-1585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 706C381507F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE5D1C23C23
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A44654D;
	Fri, 15 Dec 2023 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzlqxPMP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753746452;
	Fri, 15 Dec 2023 19:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD33BC433CC;
	Fri, 15 Dec 2023 19:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702670335;
	bh=pITXZbNjDye/BbUhFXr78ZpH2SoCRgTp9w9h/IC74Zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzlqxPMPak3Jjtfrf20ZBzBxqZadmscbesW1ljF4IHMEDtSNJV+7Qg+zILsVM7meC
	 IVkG6PHvjiD8JORhOE6sqAy4982bPq0glyTqETgqYB3xmxKtDk4hN09b7tJybCJZFn
	 k5+7XusMWDdt2AmCOQIFpzALXyO7eP1gCkKsrKUHWY0rYcFJSO/oC2q0idHRxEgwWK
	 euV+A4bJGjLM2QTOf5trGm0u6zl4fgVueyO1Qbnc/xOWy+YH1nijlHFq/3EwtZgE13
	 iD+DLpD38yljmXuEn2pPzu5PH+eiuNxFByutNyuakBaK9UMbMnmwTmq/eXk8Tbs/BP
	 icTNQMoXlaFDA==
Received: (nullmailer pid 294909 invoked by uid 1000);
	Fri, 15 Dec 2023 19:58:53 -0000
Date: Fri, 15 Dec 2023 13:58:53 -0600
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: matthias.bgg@gmail.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v2 2/7] dt-bindings: media: mtk-vcodec-encoder: add
 dma-ranges
Message-ID: <170267033128.294824.6094667140033672249.robh@kernel.org>
References: <20231215104551.233679-1-eugen.hristev@collabora.com>
 <20231215104551.233679-2-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215104551.233679-2-eugen.hristev@collabora.com>


On Fri, 15 Dec 2023 12:45:46 +0200, Eugen Hristev wrote:
> As IOMMUs are supported, dma-ranges is not mentioned but
> additionalProperties=false, thus we have an error when adding dma-ranges.
> Add dma-ranges as a possible property because this may be present.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
> Changes in v2:
> - none.
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml      | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


