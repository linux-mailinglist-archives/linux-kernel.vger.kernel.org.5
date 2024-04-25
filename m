Return-Path: <linux-kernel+bounces-158879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2948B2624
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3FAB233D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CB414D446;
	Thu, 25 Apr 2024 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p37YipOi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B5514D2B4;
	Thu, 25 Apr 2024 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061839; cv=none; b=RR3BEtqb5b6vJKVm74Z4tGpwIT6xlWdSKo05ia2h9KEI4JIaDBoPCZIIArDT/l1ohQXyosOKRkLVPyyrVQRbUfGgua8SoXzAk+5kfxdZWKzbkJEWV/f0KyHDOYgzCltS42u0pmZMG4HlT4VEXjsaR+ssoOC+E2tADhKgTn+Zbj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061839; c=relaxed/simple;
	bh=ScLqWv63xir2MvKOgR98NCP/SnbKk9idOV31izZb2+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gmimh48HE/HsGUSoT8RlKSnnMhzhpLnRaGG+McKl9S63+BnUh4tiTA1PgJ7js4soESK8gchbi/heRjLYi1a8NHgrFgdNSzYLd0MMueAprM9Hfq7Coe4c0VXgbzzN8ahHUsK1PENdRr5p5HHedJuz2QpDGV9AJcaewWVk9qSGAQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p37YipOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611DAC113CC;
	Thu, 25 Apr 2024 16:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714061838;
	bh=ScLqWv63xir2MvKOgR98NCP/SnbKk9idOV31izZb2+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p37YipOiH//QqkaxVlIMr2fSWxyx+QrccIcH0KZou9sWdoQoxA/HqR0Y1LlTHTRNm
	 FNCyYmsJGKOpGRFztZ8+W/HUzFmZoAamLIe4pcCTD3SmX+/1mKi/851Sr9oN6YVjn5
	 KJAxN1POlDwQNK5lr1kJ+n4Kqvhn0F3cpgdPYduHSGjO6OI/TjDsFOASj1Qeb9qlmf
	 rMgtI9PYCw0c/4gHh5rDTGERmDMAj8AdhCHrF85DdLCIvfPBGpGEu8Ri6E7OzYmNWD
	 gr2DuRxd/rqrvk1Jt6NnMZ6sNUlZ4i+36e2FuqZo3l0OGTKtBFs7kK9YMZQF/GattE
	 ngNfgnlvERwqA==
Date: Thu, 25 Apr 2024 11:17:15 -0500
From: Rob Herring <robh@kernel.org>
To: Luca Weiss <luca@z3ntu.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] dt-bindings: soc: qcom,smsm: Allow specifying
 mboxes instead of qcom,ipc
Message-ID: <20240425161715.GA2759240-robh@kernel.org>
References: <20240424-smsm-mbox-v1-0-555f3f442841@z3ntu.xyz>
 <20240424-smsm-mbox-v1-1-555f3f442841@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-smsm-mbox-v1-1-555f3f442841@z3ntu.xyz>

On Wed, Apr 24, 2024 at 07:21:51PM +0200, Luca Weiss wrote:
> The qcom,ipc-N properties are essentially providing a reference to a
> mailbox, so allow using the mboxes property to do the same in a more
> structured way.

Can we mark qcom,ipc-N as deprecated then?
 
> Since multiple SMSM hosts are supported, we need to be able to provide
> the correct mailbox for each host. The old qcom,ipc-N properties map to
> the mboxes property by index, starting at 0 since that's a valid SMSM
> host also.
> 
> The new example shows how an smsm node with just qcom,ipc-3 should be
> specified with the mboxes property.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,smsm.yaml    | 48 ++++++++++++++++++----
>  1 file changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
> index db67cf043256..b12589171169 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
> @@ -33,6 +33,13 @@ properties:
>        specifier of the column in the subscription matrix representing the local
>        processor.
>  
> +  mboxes:
> +    minItems: 1
> +    maxItems: 5

Need to define what each entry is.

> +    description:
> +      Reference to the mailbox representing the outgoing doorbell in APCS for
> +      this client.
> +
>    '#size-cells':
>      const: 0
>  
> @@ -98,15 +105,18 @@ required:
>    - '#address-cells'
>    - '#size-cells'
>  
> -anyOf:
> +oneOf:
>    - required:
> -      - qcom,ipc-1
> -  - required:
> -      - qcom,ipc-2
> -  - required:
> -      - qcom,ipc-3
> -  - required:
> -      - qcom,ipc-4
> +      - mboxes
> +  - anyOf:
> +      - required:
> +          - qcom,ipc-1
> +      - required:
> +          - qcom,ipc-2
> +      - required:
> +          - qcom,ipc-3
> +      - required:
> +          - qcom,ipc-4
>  
>  additionalProperties: false
>  
> @@ -136,3 +146,25 @@ examples:
>              #interrupt-cells = <2>;
>          };
>      };
> +  # Example using mboxes property
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    shared-memory {
> +        compatible = "qcom,smsm";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        mboxes = <0>, <0>, <0>, <&apcs 19>;
> +
> +        apps@0 {
> +            reg = <0>;
> +            #qcom,smem-state-cells = <1>;
> +        };
> +
> +        wcnss@7 {
> +            reg = <7>;
> +            interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +        };
> +    };
> 
> -- 
> 2.44.0
> 

