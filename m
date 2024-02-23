Return-Path: <linux-kernel+bounces-78805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CFD86190F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7F01F255F0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143B013BAC9;
	Fri, 23 Feb 2024 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYm1KEm2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364A13B2B5;
	Fri, 23 Feb 2024 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708358; cv=none; b=E1q8WWYrV2OPizEZq2veUYjrDxk5wgfn68g2QW0p36EZWIyMCh0XKSb7YL9SvLrHfYFTfDwE3ra4++i9EZbaVActvKMUjPebXQj6nKONIefJcZ2d3F2dnBDIFsa2n5Sq+SAxncILKopvOm/XnClrpUL57cDuuvu7S/a3H9lUXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708358; c=relaxed/simple;
	bh=SJjK/OlnPiSEOlTM7MrjuCeEvk6XyHl4V+e8NRfLHqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAjwiog+a5vHc3wcCR3Du0cPEHjrTp0oQ3m74odeYGWy3gsAiQhJEtPpX7qBlKI8RdDpSPLPqumdstSWx9JII47EEOU/IMqnKh/X/vDwwHXDGX4oeGMCHYjL1T6G7n6ekYF8e2gS5JCPhioJt+d6ZV5+VcZsKYwygPWDsP7Pyzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYm1KEm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A374C433B1;
	Fri, 23 Feb 2024 17:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708357;
	bh=SJjK/OlnPiSEOlTM7MrjuCeEvk6XyHl4V+e8NRfLHqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYm1KEm2XgtFgQGp5qKeCuIkODtj4+WK/ieP3Rqkbgz0M3YCb0tomjB7u6JQ7aURH
	 9IPoG5BxDf5IHeMPQmbXNZKuuT4LqD038LhJkroxo/MAk/NomQeaAS+eX6XrfIF9HO
	 ArC0Km+RQXKxmWqXOUENhhB/cN/Q8XFjbQyJdyZQAJqARFceZRVRJ1Lne60NYMOTx3
	 p0oDUKsznRxiZzDFu4A/Xpy97Eey5CtV6lFk/azTDZZ8NsNbECZIMau1/0gQC8boTm
	 TW4f4N5MnNQx+2qQEFuFW2pc7flHpIivly4BrC8fnptrg+CdS8QE8Bl2+SGCMXJWcb
	 ujd3ZSC+eBWgQ==
Date: Fri, 23 Feb 2024 17:12:31 +0000
From: Lee Jones <lee@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Andrew Davis <afd@ti.com>,
	b-liu@ti.com, srk@ti.com, r-gunasekaran@ti.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: mfd: syscon: Add
 ti,am62-usb-phy-ctrl compatible
Message-ID: <20240223171231.GN1666215@google.com>
References: <20240223-b4-for-v6-5-am62-usb-typec-dt-v5-0-4b5854d17d18@kernel.org>
 <20240223-b4-for-v6-5-am62-usb-typec-dt-v5-1-4b5854d17d18@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223-b4-for-v6-5-am62-usb-typec-dt-v5-1-4b5854d17d18@kernel.org>

On Fri, 23 Feb 2024, Roger Quadros wrote:

> Add the compatible for TI AM62 USB PHY Control register. This
> register is found in the TI AM62 WKUP_CTRL_MMR0 space [1]. It
> is used to indicate the USB PHY PLL reference clock rate and
> core voltage level to the USB controller.
> 
> [1] - https://www.ti.com/lit/pdf/spruiv7
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changelog:
> v5 - no change. Added Lee Jones in To list
> v4 - no change. Added Rob's Acked-by
>      https://lore.kernel.org/all/20240205135908.54656-2-rogerq@kernel.org/
> v3 - add compatibles in alphabetical order
>      https://lore.kernel.org/all/20240201120332.4811-2-rogerq@kernel.org/
> v2 - New patch
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 084b5c2a2a3c..9437705af92f 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -72,6 +72,7 @@ properties:
>                - rockchip,rk3588-qos
>                - rockchip,rv1126-qos
>                - starfive,jh7100-sysmain
> +              - ti,am62-usb-phy-ctrl
>                - ti,am654-dss-oldi-io-ctrl

Doesn't apply.  Please rebase on tomorrow's -next.

-- 
Lee Jones [李琼斯]

