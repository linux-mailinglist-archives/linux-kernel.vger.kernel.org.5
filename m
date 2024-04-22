Return-Path: <linux-kernel+bounces-153446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252788ACE37
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 872A1B20B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A072D14F9FB;
	Mon, 22 Apr 2024 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKy/HXQu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D814F9C9;
	Mon, 22 Apr 2024 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792627; cv=none; b=In3M/k+9JfGSpUlGytDVL2jrJKNXYcETflRx/qz79AWAlFceIWeT7YovrciIc+eHtG+wx3bF6JddUq39WyGiqgQTKN3AT7xcXvAk6775UAPXy7e7osW6T6B83wfV2ZEinZxvJKf3s2qGr0ERPWoq3rsBRTVQqA/tOZ3yEciDJUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792627; c=relaxed/simple;
	bh=A2znyBsHTWmdbkt6A3QZvg0H6BjA3WnoxBIAsNlWmr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGSOBZ8QlO+zEPi/Bklm0tJ6vhiLeJr1ou9kUU8XiW6aauhHuMvHeqiqZqBlHNCcVrHBxLt621X0+Pv0SVwo6iR6bGttEugHghmTR1px7oLWfDEW89qY0V03gYyZ2IVrG2I8wUwvHTB2YSLT+ILU7O8DTRL+ApIMPO35burwmlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKy/HXQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3312DC113CC;
	Mon, 22 Apr 2024 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713792626;
	bh=A2znyBsHTWmdbkt6A3QZvg0H6BjA3WnoxBIAsNlWmr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZKy/HXQuZdRus/ZPGAEDOtrOlqc+Hs7/f/xiTmlo0N3iCWVivfqNuQjxVrxTF24tg
	 i+hjF/JSWveIzHlYciFCzaqJsY2hUk3OO92e/Mp10Y2vS3XqKWfPKTXzbJP6/cvF7n
	 JYf4Hh7AdTL0RYV6+TlsYMILIam5fbV+TGJYMMaLWck5+N+ACGMmkDc7Ld8h9gb82w
	 yKcD1OlijU8U/YvYHo7DsF4CwVYn/VPL+43TKsy4jxWNqPIaZVrf58CBf4bidkUnnB
	 cqso4X5b5S8uiF8HXcQz6SBF75OHrkntagMdyA3aQWScS8uO5obNQj35jb0g+0g1zW
	 Ub32FZQJJi9/g==
Date: Mon, 22 Apr 2024 08:30:24 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, matthias.bgg@gmail.com, gustavoars@kernel.org,
	henryc.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, broonie@kernel.org,
	linux-mediatek@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com,
	keescook@chromium.org, wenst@chromium.org, djakov@kernel.org,
	amergnat@baylibre.com, lgirdwood@gmail.com,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/7] dt-bindings: interconnect: Add MediaTek EMI
 Interconnect bindings
Message-ID: <171379262174.1121504.1745329422512464486.robh@kernel.org>
References: <20240418094134.203330-1-angelogioacchino.delregno@collabora.com>
 <20240418094134.203330-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418094134.203330-3-angelogioacchino.delregno@collabora.com>


On Thu, 18 Apr 2024 11:41:29 +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the MediaTek External Memory Interface Interconnect,
> which providers support system bandwidth requirements through Dynamic
> Voltage Frequency Scaling Resource Collector (DVFSRC) hardware.
> 
> This adds bindings for MediaTek MT8183 and MT8195 SoCs.
> 
> Note that this is modeled as a subnode of DVFSRC for multiple reasons:
>  - Some SoCs have more than one interconnect on the DVFSRC (and two
>    different kinds of EMI interconnect, and also a SMI interconnect);
> 
>  - Some boards will want to not enable the interconnect driver because
>    some of those are not battery powered (so they just keep the knobs
>    at full thrust from the bootloader and never care scaling busses);
> 
>  - Some DVFSRC interconnect features may depend on firmware.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../interconnect/mediatek,mt8183-emi.yaml     | 51 +++++++++++++++++++
>  .../interconnect/mediatek,mt8183.h            | 23 +++++++++
>  .../interconnect/mediatek,mt8195.h            | 44 ++++++++++++++++
>  3 files changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
>  create mode 100644 include/dt-bindings/interconnect/mediatek,mt8183.h
>  create mode 100644 include/dt-bindings/interconnect/mediatek,mt8195.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>


