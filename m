Return-Path: <linux-kernel+bounces-145994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813188A5E00
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F851F226D5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FD4158DDF;
	Mon, 15 Apr 2024 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx6d951X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F72B156977;
	Mon, 15 Apr 2024 23:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713222334; cv=none; b=VrT5N84XiJtBY9BnuGtb48cQ2KnJkEceWeUQh9M4QYSdGncoM9OdomXt/dlpIz1dOkUrYYEUtLmsx60B+eas/0N2doTgHXMrN9j1DcfSeEIbYdMol3bmw4FqFr7Yf9hp00fgoDjOa8SrvmwLVmspDrVTeNlRlgbg61UVxyhEI3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713222334; c=relaxed/simple;
	bh=ujka/03jMUb0XAncsAq1DSp6vUMODs+NmGkGQhLYg68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APnU3uLh8EBtDFJLXntWat0Rma+Jiqn3jhrTnFZx+dVEGXObSgiNQIlknZeKjg4h4Hwjazs/28YOPw1o/RH38CRAAldTdff9W3MccXF1LtWtFXHshicZ7L0Djr1lk+zWbP+3tuaH2ZV/9sudiTRsxuPGAYqUTdOMBDFp8iMUDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx6d951X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EA4C113CC;
	Mon, 15 Apr 2024 23:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713222333;
	bh=ujka/03jMUb0XAncsAq1DSp6vUMODs+NmGkGQhLYg68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gx6d951XUcnisiPltyGh2R86ooQuEYTrxs3fuuz33iLrsJZKIr4Yh7kIEhpgZYT0u
	 +cscArqD1yK5tD3G0VQc+Ap7mBDtsJdrKBNrU1S3p32nkeZGHxgvSM3TImP1L3AnT+
	 F1Nn6ThGM/Nxfr+vuJQoaLTePGQ8EfFhYr8JHlpahucJC6/h2JaGVs/KfAy6oNyMOG
	 N+dAJk9Pas+V8JpKU1LFAZJsJJQ8Z4hWi+pQzAMfGyvrh+MkM1rVX2dbNMvB1H0UsB
	 9dOhkk3jUFJLdhWOMw6dCldHzd9gEp8IhUOIXELJODAGnL83vI0TUDlFCajFJHVR0y
	 /+aHDeMK9aFHg==
Date: Mon, 15 Apr 2024 18:05:30 -0500
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-bluetooth@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	linux-arm-kernel@lists.infradead.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
Message-ID: <171322232789.252337.16326980700188367647.robh@kernel.org>
References: <20240412073046.1192744-1-wenst@chromium.org>
 <20240412073046.1192744-2-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412073046.1192744-2-wenst@chromium.org>


On Fri, 12 Apr 2024 15:30:42 +0800, Chen-Yu Tsai wrote:
> The MediaTek MT7921S is a WiFi/Bluetooth combo chip that works over
> SDIO. WiFi and Bluetooth are separate SDIO functions within the chip.
> While the Bluetooth SDIO function is fully discoverable, the chip has
> a pin that can reset just the Bluetooth core, as opposed to the full
> chip. This should be described in the device tree.
> 
> Add a device tree binding for the Bluetooth SDIO function of the MT7921S
> specifically to document the reset line. This binding is based on the MMC
> controller binding, which specifies one device node per SDIO function.
> 
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v2:
> - Expand description and commit message to clearly state that WiFi and
>   Bluetooth are separate SDIO functions, and that each function should
>   be a separate device node, as specified by the MMC binding.
> - Change 'additionalProperties' to 'unevaluatedProperties'
> - Add missing separating new line
> - s/ot/to/
> 
> Angelo's reviewed-by was not picked up due to the above changes.
> 
> Changes since v1:
> - Reworded descriptions
> - Moved binding maintainer section before description
> - Added missing reference to bluetooth-controller.yaml
> - Added missing GPIO header to example
> ---
>  .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 55 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


