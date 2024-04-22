Return-Path: <linux-kernel+bounces-153448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642EA8ACE3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956AC1C20D83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29EE14F9E4;
	Mon, 22 Apr 2024 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7E4rY9d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2999F5028B;
	Mon, 22 Apr 2024 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792667; cv=none; b=lcB2+8+Fqhe4ER1iiggan7T4BPk4GnXTr4wK2sxEcSny4AKg2QF+zCg1esQwN+HIznWRGy9XtH8B7X/IDNMqzkIYrx71dDhB2xzh8atPYz58OZaox9J3BqcBgaChu8iSyjfd/LnImpdTb2f3w46mtyOTMw0/cxXawUrk3USEEjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792667; c=relaxed/simple;
	bh=RmWPWoJmuT/0TeUYKPz5ezD+M2RoaksC3ftBdfD+wfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvmWKktdXkbWW07FQ+QZev60sdpQ9sMH75wcVGjAMY6Xgqs4IT842u7vLMbJcxXIXD05F76PFqEMzwqQSBBDMs4HTO5n2Zux7aPRkN0IDwi0HJ+WgLEtoMn+6BzOoZ6mRraKl3qVaD12FdSz4LrpcaCgtHmy+cQXnXym5XvXsm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7E4rY9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93824C113CC;
	Mon, 22 Apr 2024 13:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713792666;
	bh=RmWPWoJmuT/0TeUYKPz5ezD+M2RoaksC3ftBdfD+wfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7E4rY9do8FFKN+uduXw6rv2lCPWOHbnN1YJi3knJ+DQTYw4r4KXDAWKNgzOBD7iX
	 8pZGOBSQqPYmYyn6x2u/uUdigsbXUcNmQ6Br276FHoNjr7mXcltAje56eszwWeGUUN
	 3QgU806dbPZ6qj1Zcy1ye6z6E1RYdCT7rF2QsUYYfcEOkmfdmnXPLgonxCaCb8GEff
	 jj9ZyOaGHRCgxsXYEGtuaQPP7IDP4RqNo4jyrhIWk+qiUdSMxMQnH31GD686Gz4u4W
	 V3mats/Z4lDhC6ePu2nxABTI7pR7qR7Nw1CPx49bcflqyMB1+t9kx29kGWHhyuNnZO
	 +33+ZbY7NE5lw==
Date: Mon, 22 Apr 2024 08:31:04 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, lgirdwood@gmail.com, gustavoars@kernel.org,
	linux-pm@vger.kernel.org, matthias.bgg@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, djakov@kernel.org,
	keescook@chromium.org, kernel@collabora.com,
	linux-kernel@vger.kernel.org, wenst@chromium.org,
	amergnat@baylibre.com, broonie@kernel.org, henryc.chen@mediatek.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/7] dt-bindings: soc: mediatek: Add DVFSRC bindings
 for MT8183 and MT8195
Message-ID: <171379264441.1122105.10432183532468198558.robh@kernel.org>
References: <20240418094134.203330-1-angelogioacchino.delregno@collabora.com>
 <20240418094134.203330-4-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418094134.203330-4-angelogioacchino.delregno@collabora.com>


On Thu, 18 Apr 2024 11:41:30 +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the MediaTek Dynamic Voltage and Frequency Scaling
> Resource Collector (DVFSRC), a hardware module used to collect all the
> requests from both software and the various remote processors embedded
> into the SoC and decide about a minimum operating voltage and a minimum
> DRAM frequency to fulfill those requests in an effort to provide the
> best achievable performance per watt.
> 
> This hardware IP is capable of transparently performing direct register
> R/W on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../soc/mediatek/mediatek,mt8183-dvfsrc.yaml  | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


