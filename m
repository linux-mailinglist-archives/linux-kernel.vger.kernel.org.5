Return-Path: <linux-kernel+bounces-163366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C05D8B69F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E031F230B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5FE1758C;
	Tue, 30 Apr 2024 05:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGqmjBER"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638385256
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714455094; cv=none; b=Fp6n10mQQLS/vblQ1e1QJtRqLWNCH7vh/T/oCCXWqxE3NPcnSA3HRK7jGKL/zDD5+jbVS+N8tLIlXOoeuhfnodX0VmzYXH7kjOx+XZjCbn2x7hzMZv5zIBs0Y6AKFxukJ37HoOugDQ0Mwhy/xMUgeKKSUbtOmH+8Ya/Sws/dUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714455094; c=relaxed/simple;
	bh=qizGv4q2/Fbfp1Vgltwn3jrxKqTwsXYZYMFjavraeFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOl1fWZsGHwmvEESzVQCcEHFnyBaaqEzGt5y2bzf4tLiKup33YAObzWpv9EYDKqdDt8fBsVu898mmNzSDQnfbDGe8WGsMGY3yOkkUc5y2zXfPGhrNZTMAcO6gx9xoDBsy+0AyJ/kV3na5zjF80Gw2nfm+5/XpqqLVr0Gg80z5t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VGqmjBER; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e8fce77bb2so40626605ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714455092; x=1715059892; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VfHOB8SXAPuzmllcKSu0Zlo52yjCYkknhySEalAGkw4=;
        b=VGqmjBERlQU75bf/gEVtlTHZ3h0PBm349PuewppT189+OJoAv0D4YmHk84OT/XDP0R
         iuIgqoXdImczn0SSUWOrhDI9BMjCJMafw89AQNY4cW3mOGko2Eh6MfiUh4fNYSimkzH6
         JslnDcX4WBYWcQPQrLoCVQC2zy/0pi8kLtpB+8rKbJ7z4YcbJTf5ajm6tdrAMYxXMxFg
         kXTb6bPrgtchslLMUeL0bX0Yj1zNpoUPOt0tVIbiQQDgYc8KFbc7wAcH4w6/Xcv5FjBX
         DL6QwKmhw2GMsLuVEdpzoIgk0KCjUVz09Sk/EWtDQVYJoVceuwwWDb6XGUV4VEHCUpMH
         WWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714455092; x=1715059892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfHOB8SXAPuzmllcKSu0Zlo52yjCYkknhySEalAGkw4=;
        b=IJD69lYdXOMsNDfENbtHu/DQSENZAE3NoLYEFDKIOnpor/bb7ajgdct1VKRruDXm/3
         ojk717cgxV1jUvExiIMrAsFk5JN5iWC/w7q9jqBtE3+Dk1E8DMtRRJGBCgRfIz6QWycu
         8vWPJ4VEhG2EYzA8rbMBvs+II6QNoLh/vCzfMFMAOQMsHjIHkkpuJ6BEvutROzIl5haR
         la8974p1B84wqx7Rxlascl+zMrnkjFYELMfEhGOIN+qhdSrYQ3zUXiplR+SSSDNFohD1
         /P7l7R6OrgvBEZQ/+wCNOliQFpeXZNKg2rMgf09pc88QGiqSqx7cvlkYV+1eNgwkASgX
         Jgag==
X-Forwarded-Encrypted: i=1; AJvYcCXKdsh2v+Jwgp1YU3v0e43X5BstcFjL/PeomM6ZN2hK1T7wi6Xh2PBy+6T5B6paS41GukLAiYPsW073CF7ev8Qlib6XYOcxde6o5RCx
X-Gm-Message-State: AOJu0YzUmGnY7rq50mHLUFcOzZhK0aDKJX31uiAo6px/NizRE9GVlAxn
	otUOm1SVOPCxlV+x1Tf7ZTmBMaIqZJhOHs6Kmxj2tqwGItllPlEianFwozIjTA==
X-Google-Smtp-Source: AGHT+IErHY0aeCgYx3Eg8BZQUT5i4gOzQfyzK5nVz/+A9MaPVNIq3EbBBlsUSZlkwJMHRrYmAEOGtg==
X-Received: by 2002:a17:902:ba98:b0:1e3:f6dd:b04b with SMTP id k24-20020a170902ba9800b001e3f6ddb04bmr1503995pls.26.1714455091596;
        Mon, 29 Apr 2024 22:31:31 -0700 (PDT)
Received: from thinkpad ([220.158.156.15])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b001ebd72d55c0sm2925454pla.18.2024.04.29.22.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 22:31:31 -0700 (PDT)
Date: Tue, 30 Apr 2024 11:01:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom,pcie-sm8350: Drop redundant
 'oneOf' sub-schema
Message-ID: <20240430053127.GF3301@thinkpad>
References: <20240417200431.3173953-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417200431.3173953-1-robh@kernel.org>

On Wed, Apr 17, 2024 at 03:04:30PM -0500, Rob Herring (Arm) wrote:
> The first entry in the 'oneOf' schema doesn't work because the top
> level schema requires exactly 8 interrupt entries. The 2nd entry is just
> redundant with the top level. Since 1 entry appears to have been a
> mistake, let's just drop the entire 'oneOf' rather than reworking the
> top-level to allow 1 entry.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../bindings/pci/qcom,pcie-sm8350.yaml        | 22 -------------------
>  1 file changed, 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
> index 9eb6e457b07f..2a4cc41fc710 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
> @@ -71,28 +71,6 @@ properties:
>      items:
>        - const: pci
>  
> -oneOf:
> -  - properties:
> -      interrupts:
> -        maxItems: 1
> -      interrupt-names:
> -        items:
> -          - const: msi
> -
> -  - properties:
> -      interrupts:
> -        minItems: 8
> -      interrupt-names:
> -        items:
> -          - const: msi0
> -          - const: msi1
> -          - const: msi2
> -          - const: msi3
> -          - const: msi4
> -          - const: msi5
> -          - const: msi6
> -          - const: msi7
> -
>  allOf:
>    - $ref: qcom,pcie-common.yaml#
>  
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

