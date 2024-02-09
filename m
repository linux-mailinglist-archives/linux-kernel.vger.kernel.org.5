Return-Path: <linux-kernel+bounces-58957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE9E84EF2B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8141C264D7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEACB4C8E;
	Fri,  9 Feb 2024 03:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0RvK6BJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89394C61;
	Fri,  9 Feb 2024 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707447614; cv=none; b=jXzZWb7yc9vIsXkd91ECqeKNVWfFyK/lBP31G0Ng0upr3u+pTdLuphhcraNoJ88tNtoccZeiCE46Knlu4FS8Tl7+ytrpTmsylGHKqaMH9OQIxPinMIzrBW1Au1er7+0G134unFnR53WMpZnD2ASkcW4V3dYhwaO27XYqzDCR77A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707447614; c=relaxed/simple;
	bh=YWSXk4gg3iRUPrFxk01vbso3R2LXES4Zpy2uWOn8ZRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLdceKlT6jiL23kazd/0wvSVDovBl0eVzMz+mkUCLT64oQot730oY2tkx8I2eOjoxl/BBpmFiiasRSUQRaOskTtDxP4pC/qv//Isp0chonTgAhVFaUvlY9kvt8lZrZiwa9/tDoQEYZynP2/PzXCNZL/jVYJuM6I+THN8kZ7V1Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0RvK6BJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C046C433F1;
	Fri,  9 Feb 2024 03:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707447613;
	bh=YWSXk4gg3iRUPrFxk01vbso3R2LXES4Zpy2uWOn8ZRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0RvK6BJYc+i0eo4kPitnWN56L8nyAEUoRXfFPqmwIF6WdpQInOmsPnEgAdXvMwpN
	 VEGRXWU5prRW1XkylT/VR5TPM1XJZVn6x39iCYFjC+2wbA1sgbX53NL0eINgjcpX3K
	 ysgjTDfOh6a+hy+Rdf0/dHeWIOBk3JQMHjVu1myLdjFQOD/oHPlgDna+j5715fZAaL
	 UbjSBnQO+hmNaV3PdrNEsqAsI4ydIltEx+D4T8ieWx9mqORcAKZkCKIimBvOMPWOpP
	 MBFMNe1j+bf/Q7QtMCdMyudvincnyvyHBuGgZVlNa8npF0PQQgih6XnsQVkaGHA8L0
	 AbJIr28u8ZS7A==
Date: Thu, 8 Feb 2024 21:00:10 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com
Subject: Re: [PATCH v14 1/9] dt-bindings: usb: Add bindings for multiport
 properties on DWC3 controller
Message-ID: <wrki53fjc45ercxecxadq72p66diui4l4oklsk3nomsmshg3i4@5lrhk3fmjkal>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-2-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206051825.1038685-2-quic_kriskura@quicinc.com>

On Tue, Feb 06, 2024 at 10:48:17AM +0530, Krishna Kurapati wrote:
> Add bindings to indicate properties required to support multiport
> on Synopsys DWC3 controller.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index 8f5d250070c7..9227e200bcab 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -85,15 +85,16 @@ properties:
>  
>    phys:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 8
>  
>    phy-names:
>      minItems: 1
> -    maxItems: 2
> -    items:
> -      enum:
> -        - usb2-phy
> -        - usb3-phy
> +    maxItems: 8
> +    oneOf:
> +      - items:
> +          enum: [ usb2-phy, usb3-phy ]
> +      - items:
> +          pattern: "^usb[23]-[0-3]$"
>  
>    power-domains:
>      description:
> -- 
> 2.34.1
> 

