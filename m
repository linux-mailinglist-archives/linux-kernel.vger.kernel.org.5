Return-Path: <linux-kernel+bounces-32724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C173835F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A786B23ED0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75253A1D6;
	Mon, 22 Jan 2024 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCN+kmIt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E923A1B4;
	Mon, 22 Jan 2024 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918816; cv=none; b=fckRmGiyeqzr6YaRp+6NdTZUjSPnmJMW17T9DpxECnCr6lxIEArSAzdz/Dr+fG2jsue+GAgPc9f/j+C6goL5eUVzeVOZph5zArrYrpT1FVSUkqTRfKO97VhIsNGOGqVnd70D2Cq2WXw73VBhLTN+g0aNQK7o8dPtIWT1NTv6EOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918816; c=relaxed/simple;
	bh=FkzVe6iZBWVXTveesPrlVI7IQutkxNDUXYFU5aqWMVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfAoKkDDdrLH//K5Jqs9BDC/HJKHjmT23ZJ0/aLu9upVgj5EEfsWA8DBjpHSekbPUeDPK/lp8CdCvVR4yWKwlB74pMjp7Ajk5PdvpoiLyN69iqa5y7J62ev6HroUQtoIQ1o0OATacuMI3XVFBo+OPbO+qAw5R4U1SZYrkqli8wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCN+kmIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B185EC433F1;
	Mon, 22 Jan 2024 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705918815;
	bh=FkzVe6iZBWVXTveesPrlVI7IQutkxNDUXYFU5aqWMVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WCN+kmItAJWSkCtB/80pBy8D9uLLLmmD+JgGzxn3Ig5NUh2IM9sAdEOioezdjdVwY
	 ficQmt3nkGye3JD/MCFO24MZQ5dyWjNbqE4FHzM98XLjsl2irpI6Iq6Kf6q6A8S7Wl
	 g8i0ra7aEzTr6LBstET/PFfg0EewtfAS8nYIiIklUr+CQz4pyLYsf2QPrxANar8abg
	 YLXeBEyHq0zAgWz8Bf/OGxJx2Z2YDTwq21jp7Duk0tSfATRE6lrsbgcNFvxrZ7Pxx0
	 kl55o7e11dKLco9mlv3koYQhjHNxrY5PgUzLFUiNyLKwtdoUCoB8/JQJ5RAaj8c01z
	 GKkdjuuQpr/kg==
Date: Mon, 22 Jan 2024 11:20:02 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: dlemoal@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linus.walleij@linaro.org, brgl@bgdev.pl, michal.simek@amd.com,
	p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
	piyush.mehta@amd.com, mubin.sayyed@amd.com,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH] dt-bindings: xilinx: replace Piyush Mehta maintainership
Message-ID: <Za5BUkkd8SymC6lT@x1-carbon>
References: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>

On Fri, Jan 19, 2024 at 05:06:21PM +0530, Radhey Shyam Pandey wrote:
> As Piyush is leaving AMD, he handed over ahci-ceva, ZynqMP Mode Pin GPIO
> controller, Zynq UltraScale+ MPSoC and Versal reset, Xilinx SuperSpeed
> DWC3 USB SoC controller, Microchip USB5744 4-port Hub Controller and
> Xilinx udc controller maintainership duties to Mubin and Radhey.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>  Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml      | 3 ++-
>  .../devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml     | 3 ++-
>  Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml | 3 ++-
>  Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml         | 3 ++-
>  Documentation/devicetree/bindings/usb/microchip,usb5744.yaml   | 3 ++-
>  Documentation/devicetree/bindings/usb/xlnx,usb2.yaml           | 3 ++-
>  6 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> index b29ce598f9aa..9952e0ef7767 100644
> --- a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> +++ b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Ceva AHCI SATA Controller
>  
>  maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>  
>  description: |
>    The Ceva SATA controller mostly conforms to the AHCI interface with some

For ata:
Acked-by: Niklas Cassel <cassel@kernel.org>

