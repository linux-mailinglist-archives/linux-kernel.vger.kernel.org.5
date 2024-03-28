Return-Path: <linux-kernel+bounces-122392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE13988F61B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15ADF297F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84787381C2;
	Thu, 28 Mar 2024 03:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fCFBP2sg"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9392D052
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 03:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711598359; cv=none; b=d5doe0AtiOgY3Bj55QtJ51OLGPHfvDli6GV9Oksbdx9lwRTQ6V3x8gqB91iHlCM6JSeB/f4jkFR6eDXAxeF8asNyuaSm1DbIFur2ZO54LEWPS6pU7NIfQbp4mg5vOMUkMP6scoAufizAqQ/m4s0hbW4sLVawAgxxebaPzSxONZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711598359; c=relaxed/simple;
	bh=okEn6utwbpITb9k2PX8tO4MtO7QZXQhboupRJ92hruA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0b3VAX4eiRqNqAF/ONyQUrios/bnDbq4XAJebSL5p9gH39N6asL2dpvUTsY+vKw/UZBdZJ/SKW1Qk0HWsFPUgjrKkdZUL61lqZeEHqE5mCZICQ2KC/MkgMeJPSiLDejGsPLg0SrZnAM0EnHFuYHLkZSR7Ztgl2iqEFFwHVI5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fCFBP2sg; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso475316b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711598357; x=1712203157; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w17nDhuJOeSnSYP0vy+UdWxKC15io0olSqGdTX2vBVs=;
        b=fCFBP2sgNWLDoxvKDzQOeIKkI0RuXre5WOVQUC7hg0JeEyhSwGPs/ZOmJVcHHRi0BN
         JdFsfeTKiD/hpxpCWvFJtmFgmPsyUQWoApl2yxt3hT82OvAM+nAT+wiodWbfd4iGVPG8
         jpABTCYmTyffN8LZWNQZpvNVUAwei5tXV294R5JxhA47xLVNOSXmWFbZCzIu9tSVIm3T
         Am9nsWQhcWv8KmoFRBmjOjmXlMYluondvX5qNrnQqYF+8N0pGCWhypqU/cXB8tfXP8z+
         4QmkUkCbD8/ypyhRLhebcANtziX9aAJRdPElWZTInCA+yZsHkmzqZzZxTBNN1gvJXvOU
         YeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711598357; x=1712203157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w17nDhuJOeSnSYP0vy+UdWxKC15io0olSqGdTX2vBVs=;
        b=LEaOSt1p63VhYwt88Vmtm4A+VkUn6GjZVrb2h7ixqGhMt1VuvqDPI7aEqqNrRCM7L6
         2ROlzhRwpvormOqd0TuHOb6RmrMW1Gnj6tODD7ubHyOVNM4+qekaysbuf7UNvohQzp02
         gWzTbS6Nia17/qrYCCASqnHpQYvsfmuQA8n4TKtZ19EC2Lq0FM2Z4Jwp3j7XfVp77SnL
         x1T7FKadhLw+1tDm6AwkPIOm937x7Ff2nf+OqPpe7qWUeBhA+bDSYLeHFiVJaDl+UPEc
         1+NDkpQcjSsSuEqHLaBiItz68CPGeSuoraKzK5RSONf5EWTZCyubkjKZbFtYq7ua3ms9
         W2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU3ApL4T/Z1ERc280DIMflwtsdjBewiEkvaRDYa2chk4L9nfhm6b/E2xyErUZayAX2nH8RVquBu/PGRmgELLmpFMgr6cL9RsEmVZELq
X-Gm-Message-State: AOJu0YxpybzOXoAgvAc/WMkBxpC91E7krWTOPH0SWk3VdFLG2LfKdMUh
	K1ViVaMZ+5mHAsUbSiAZfrUvYwDS/8PoL3yDYzI8iuRKQS4sTpBnErjGcBlIuw==
X-Google-Smtp-Source: AGHT+IEUbeEwMLKQUFqnunvwzqrLUk2M2HSuYDMYCQ9/F1sqZywek+e6UuBrqRFaBAI4gnDY+N/LLg==
X-Received: by 2002:a05:6a20:548a:b0:1a3:aa06:38c1 with SMTP id i10-20020a056a20548a00b001a3aa0638c1mr2329538pzk.13.1711598357453;
        Wed, 27 Mar 2024 20:59:17 -0700 (PDT)
Received: from thinkpad ([2409:40f2:201b:315f:8cec:6523:95f2:3f93])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090a718b00b0029b59bf77b4sm2489300pjk.42.2024.03.27.20.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 20:59:17 -0700 (PDT)
Date: Thu, 28 Mar 2024 09:29:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: ufs: qcom: document SC7180 UFS
Message-ID: <20240328035909.GB3212@thinkpad>
References: <20240326174632.209745-1-krzysztof.kozlowski@linaro.org>
 <20240326174632.209745-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240326174632.209745-2-krzysztof.kozlowski@linaro.org>

On Tue, Mar 26, 2024 at 06:46:31PM +0100, Krzysztof Kozlowski wrote:
> Document already upstreamed and used Qualcomm SC7180 UFS host controller
> to fix dtbs_check warnings like:
> 
>   sc7180-idp.dtb: ufshc@1d84000: compatible:0: 'qcom,sc7180-ufshc' is not one of ...
>   sc7180-idp.dtb: ufshc@1d84000: clocks: [[39, 99], [39, 7], [39, 98], [39, 107], [36, 0], [39, 106], [39, 105]] is too short
>   sc7180-idp.dtb: ufshc@1d84000: clock-names: ['core_clk', 'bus_aggr_clk', 'iface_clk', 'core_clk_unipro', ...] is too short
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/ufs/qcom,ufs.yaml     | 34 ++++++++++++++++---
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index 1ab3d16917ac..7e6d442545ad 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -27,6 +27,7 @@ properties:
>            - qcom,msm8996-ufshc
>            - qcom,msm8998-ufshc
>            - qcom,sa8775p-ufshc
> +          - qcom,sc7180-ufshc
>            - qcom,sc7280-ufshc
>            - qcom,sc8180x-ufshc
>            - qcom,sc8280xp-ufshc
> @@ -43,11 +44,11 @@ properties:
>        - const: jedec,ufs-2.0
>  
>    clocks:
> -    minItems: 8
> +    minItems: 7
>      maxItems: 11
>  
>    clock-names:
> -    minItems: 8
> +    minItems: 7
>      maxItems: 11
>  
>    dma-coherent: true
> @@ -113,6 +114,31 @@ required:
>  allOf:
>    - $ref: ufs-common.yaml
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc7180-ufshc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 7
> +          maxItems: 7
> +        clock-names:
> +          items:
> +            - const: core_clk
> +            - const: bus_aggr_clk
> +            - const: iface_clk
> +            - const: core_clk_unipro
> +            - const: ref_clk
> +            - const: tx_lane0_sync_clk
> +            - const: rx_lane0_sync_clk
> +        reg:
> +          maxItems: 1
> +        reg-names:
> +          maxItems: 1
> +
>    - if:
>        properties:
>          compatible:
> @@ -250,7 +276,7 @@ allOf:
>          reg:
>            maxItems: 1
>          clocks:
> -          minItems: 8
> +          minItems: 7
>            maxItems: 8
>      else:
>        properties:
> @@ -258,7 +284,7 @@ allOf:
>            minItems: 1
>            maxItems: 2
>          clocks:
> -          minItems: 8
> +          minItems: 7

I'm getting confused by the clock requirements for qcom,ice. Why does specifying
the qcom,ice phandle require these clocks? These are the UFSHC clocks and
already defined above.

- Mani

>            maxItems: 11
>  
>  unevaluatedProperties: false
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

