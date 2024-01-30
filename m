Return-Path: <linux-kernel+bounces-45059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C75D842B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11411F2643E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24AB14E2D0;
	Tue, 30 Jan 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVOgJDlw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A614E2C6;
	Tue, 30 Jan 2024 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637075; cv=none; b=jJjyu3QdLzsEcTPnxQeJIu1bYxxmKS5ZXJ3vVPqnV0jQ8GworuGAwgu/fbtiVr+fs3SE+4JS5z/l0y7RPDxWTwJeCpEPAGCoCLKr5K/FHNj2mqrTvOYTrk99q+HWNmFlNGd03Azr76nB1QF2OQP30U1hABIKArYdtiUqNXiGd94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637075; c=relaxed/simple;
	bh=DLSPvWePq7u4CdVnhLxHSUsOcaWXfundUGhrwH3b74Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXLnf9H0Pj1RvEgIGWAOICulktcaF9syu9q8+rQr3BzEybGisi1qZEk0cqa0Q2YOYJ4PKCMucE6XNszDlr4z2xHHVhOBLxeMAENQaa3GxiJX5Tg+36KcMITxR6qkN7iT0TjTEsuabqFAraIlriqTqHjwSCrjSLecs/dKMBWIOGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVOgJDlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF42C433C7;
	Tue, 30 Jan 2024 17:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706637074;
	bh=DLSPvWePq7u4CdVnhLxHSUsOcaWXfundUGhrwH3b74Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVOgJDlwGSKU7+ba2A8EpRFzEE1f8EsGEGAgimwIWcT9R5UrOsy7CyPyy1iTz3ewT
	 mKigbDH0EaiSqf1o/tbc2QKXn0QMEQietBjB2qEWHpS5oxiqgjjFN+HqTcC7yl6uYK
	 agH0WhQpgj4N7IQy/g8lgUbSHzsBRR7RvpX8qeevKSwmjNoS00M6K4jJrbOpaJdUI0
	 u9Dsy/KEwcgO3nyc93FPTAaON5mpXJDwDv3eEkx0VOQpH0gEuFKyrwgiYIkXK0LVqB
	 jv9XoSvh5IJR5jzUnvMnwq2Ux3+r3NR0Rr3GkcAVE2UlGJOsN87TimQmXFGRpMcrtw
	 Vv3MgSTZdP8LA==
Date: Tue, 30 Jan 2024 11:51:12 -0600
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
Subject: Re: [PATCH v2 2/4] dt-bindings: remoteproc: Add compatibility for
 TEE support
Message-ID: <20240130175112.GA2040002-robh@kernel.org>
References: <20240118100433.3984196-1-arnaud.pouliquen@foss.st.com>
 <20240118100433.3984196-3-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118100433.3984196-3-arnaud.pouliquen@foss.st.com>

On Thu, Jan 18, 2024 at 11:04:31AM +0100, Arnaud Pouliquen wrote:
> The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
> where the Cortex-M4 firmware is loaded by the Trusted execution Environment
> (TEE).
> For instance, this compatible is used in both the Linux and OP-TEE
> device-tree:
> - In OP-TEE, a node is defined in the device tree with the
>   st,stm32mp1-m4-tee to support signed remoteproc firmware.
>   Based on DT properties, OP-TEE authenticates, loads, starts, and stops
>   the firmware.
> - On Linux, when the compatibility is set, the Cortex-M resets should not
>   be declared in the device tree.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> V1 to V2 updates
> - update "st,stm32mp1-m4" compatible description to generalize
> - remove the 'reset-names' requirement in one conditional branch, as the
>   property is already part of the condition test.
> ---
>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 52 +++++++++++++++----
>  1 file changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> index 370af61d8f28..6af821b15736 100644
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
> +      Use "st,stm32mp1-m4" for the Cortex-M4 coprocessor management by non-secure context
> +      Use "st,stm32mp1-m4-tee" for the Cortex-M4 coprocessor management by secure context
>  
>    reg:
>      description:
> @@ -142,21 +147,40 @@ properties:
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

Note that this is true when 'reset-names' is not present. If that is not 
desired, then you need 'required: [reset-names]'. Not really a new issue 
though.

> +      then:
> +        required:
> +          - st,syscfg-holdboot
> +          - resets
> +      else:
> +        properties:
> +          st,syscfg-holdboot: false
> +        required:
> +          - resets

'resets' is always required within the outer 'then' schema, so you can 
move this up a level.

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
> @@ -188,5 +212,15 @@ examples:
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

