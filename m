Return-Path: <linux-kernel+bounces-27747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301D482F53A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE336286135
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E78B1D556;
	Tue, 16 Jan 2024 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDAoxy/e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490231D551;
	Tue, 16 Jan 2024 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432908; cv=none; b=EuBitNO56Kq3K7Ts77l0fNqMDPr4x5Hq+AK24CnAw+wD+6nPlhIe7lqcIj4CTuUcUGrS9JFSrxDVnscRZ18fhYoMY6bCMy/ttx4mw6yEa6WjanAQt8LhDJ9J6F8rrecPSnw76MWw5GMT7DZ+PL+pvG5JnjPRGKqFzyq5sPAYpTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432908; c=relaxed/simple;
	bh=a/KKy2dE543H2Gl6BmUDI+HNtbqufnDY/kX/+aRrmDc=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=MTLSVY3HPxzC56D3REAHxEruNw/f4NUbGRztpVx9E+fpqDyzJUKP7HudsQrdW7xXizkzcl50CDmpbipMV6j+03a2T6iiigKwhzA6XFtqNm7UP8nkMeWUMNaq2BK1z6/5TkH26k39LXZYgyU6FXeAv5jaDlJXYg8mg1Ie87VClek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDAoxy/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B1DC433C7;
	Tue, 16 Jan 2024 19:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705432907;
	bh=a/KKy2dE543H2Gl6BmUDI+HNtbqufnDY/kX/+aRrmDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jDAoxy/eYK61+Kg+xMhbM8xlmHaaAueJnPU9exonyxZzgXOus0vBbOgLYb5wueTX2
	 GkXwlwdNe+NT+3vysFVA31Db9m5O5XRcGO2/Ku3qYpyuzRv+sCvpfHRDsJ0g6uDT1J
	 m/tLBAN77h5YizY521DffARYkQ8x0or7b6ehyREuW7hyKAQWbHknRPqyED3YTsB0HV
	 oZlgDi9YLyv1+wq/y4sWE0mjT5p95+P9GWU8U1/1Z6ixKvF1D/Ve1wGdiUHfEyYhqg
	 j6bwZ0Jp02j857IHouQc/HP4o8HUZfAV4px4m0T3LQJKxDaCnR/22TbP79gCiaxMGE
	 61HaulBQ9UnxQ==
Date: Tue, 16 Jan 2024 13:21:45 -0600
From: Rob Herring <robh@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: remoteproc: add compatibility for TEE
 support
Message-ID: <20240116192145.GA265232-robh@kernel.org>
References: <20240115135249.296822-1-arnaud.pouliquen@foss.st.com>
 <20240115135249.296822-3-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115135249.296822-3-arnaud.pouliquen@foss.st.com>

On Mon, Jan 15, 2024 at 02:52:47PM +0100, Arnaud Pouliquen wrote:
> The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
> where the Cortex-M4 firmware is loaded by the Trusted execution Environment
> (TEE).
> This compatible is used in both the Linux and OP-TEE device-tree.
> - In OP-TEE, a node is defined in the device tree with the
>   st,stm32mp1-m4-tee to support signed remoteproc firmware.
>   Based on DT properties, OP-TEE authenticates, loads, starts, and stops
>   the firmware.
> - On Linux, when the compatibility is set, the Cortex-M resets should not
>   be declared in the device tree.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 53 +++++++++++++++----
>  1 file changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> index 370af61d8f28..9fdfa30eff20 100644
> --- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> @@ -16,7 +16,12 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: st,stm32mp1-m4
> +    enum:
> +      - st,stm32mp1-m4
> +      - st,stm32mp1-m4-tee
> +    description:
> +      Use "st,stm32mp1-m4" for the Cortex-M4 coprocessor management by Linux

What if other OSs want to manage the M4?

> +      Use "st,stm32mp1-m4-tee" for the Cortex-M4 coprocessor management by secure context
>  
>    reg:
>      description:
> @@ -142,21 +147,41 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - resets
>  
>  allOf:
>    - if:
>        properties:
> -        reset-names:
> -          not:
> -            contains:
> -              const: hold_boot
> +        compatible:
> +          contains:
> +            const: st,stm32mp1-m4
> +    then:
> +      if:
> +        properties:
> +          reset-names:
> +            not:
> +              contains:
> +                const: hold_boot
> +      then:
> +        required:
> +          - st,syscfg-holdboot
> +          - resets
> +      else:
> +        properties:
> +          st,syscfg-holdboot: false
> +        required:
> +          - reset-names

Looks like a new required property.

> +          - resets
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: st,stm32mp1-m4-tee
>      then:
> -      required:
> -        - st,syscfg-holdboot
> -    else:
>        properties:
>          st,syscfg-holdboot: false
> +        reset-names: false
> +        resets: false
>  
>  additionalProperties: false
>  
> @@ -188,5 +213,15 @@ examples:
>        st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
>        st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
>      };
> +  - |
> +    #include <dt-bindings/reset/stm32mp1-resets.h>
> +    m4@10000000 {
> +      compatible = "st,stm32mp1-m4-tee";
> +      reg = <0x10000000 0x40000>,
> +            <0x30000000 0x40000>,
> +            <0x38000000 0x10000>;
> +      st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
> +      st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
> +    };
>  
>  ...
> -- 
> 2.25.1
> 

