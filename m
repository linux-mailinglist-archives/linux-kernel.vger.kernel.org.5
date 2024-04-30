Return-Path: <linux-kernel+bounces-164712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284CA8B8188
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8CA1F23921
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8BC1A0AF5;
	Tue, 30 Apr 2024 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrQPMK4h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26619DF63;
	Tue, 30 Apr 2024 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509360; cv=none; b=Ig8b5uT2gRkv2AR8Z8+6pQhThLTTBLauiL1ZaBcfWrT0WMtQOM4ThoBzDhjJM8mXVJBdzXahtlSP9tW4fWeNN2CSDjFGnI069d8zvTUksRj7Q30slPaMBM/fQBrm4O6EhJ9NMzyt4Bk4Jfq01Xq8ndis/K3rAx9htEy9AQQu09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509360; c=relaxed/simple;
	bh=ZrTYOUt0FA8RjqCveMWIjHR3nc9J5/OM3ty8hfTg9GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3eF3PEETaRCESB0MuCUgJ6B4T60FEsDnnAildNL2dBS6ceSa49s2Km2KGiCtnzleJLn/mXLIr5BFDsA6GO44fiocJyPfKcWDkBlW5orK/PE+DeAHHMWWRS152pRlpFkIITJ1K7TCr/yxCnY6EvfJSeAtDUkj3+1QbUTJSI7/vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrQPMK4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBC6C2BBFC;
	Tue, 30 Apr 2024 20:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714509359;
	bh=ZrTYOUt0FA8RjqCveMWIjHR3nc9J5/OM3ty8hfTg9GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrQPMK4hLHPa87bL2k3flGO/gsvssdliaH1YPOAemAm7HEAwwCqNtpaBbpe3M7TGn
	 lcJKx4gcihQA1LfwzLjMNH68CgI3ke/4jfH2s2qJXatuyhl5okeJajk1q1D99pH4DC
	 QBTav2x+XoHBZWNInVxieteVzcIuCuYSxWRwkiayIN8TY3VomEmTKRjv4RGT+VAzNo
	 XaVpiHwP/cq7/cIBPfo7cPzfy1swy+iLreQ668eNS0qy80wzhNHh39ysxNJ6pXeb2H
	 JWQ++KlFbdLuX5dZSycckNntGspE8lku0q3lcUPO24UpZ2p+l1hdWOAq0iqNYm5476
	 P1FD+rTDavcyg==
Date: Tue, 30 Apr 2024 15:35:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller:
 mediatek,mt6577-sysirq: Drop unnecessary quotes
Message-ID: <171450933497.1152845.17182769192054572844.robh@kernel.org>
References: <20240426195404.2771046-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426195404.2771046-1-robh@kernel.org>


On Fri, 26 Apr 2024 14:54:04 -0500, Rob Herring (Arm) wrote:
> Drop unnecessary quotes which aren't needed in yaml. This is checked by
> yamllint, but this case was excluded due to the comma and yamllint's
> mishandling of some cases with commas. That's now fixed in yamllint
> 1.34.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


