Return-Path: <linux-kernel+bounces-129889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6138B8971AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DB4285749
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA39E14882C;
	Wed,  3 Apr 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfECiOLH"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982C5148820
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152447; cv=none; b=lzSJVqwGTW+WA0Guvp9McPvsbufWySzz4ptuVdh6LN4iK+L395tlMoxqs1j6gellEIXMGodzhBobKwT0c7eb/x/Mglpvn8Y6z+XnotOPMxbniU2EbWmBPmRPDLHcjk7lFmVIeUf8sfougxxOPbd84k8leBBo3AIGDq2Drtb1oZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152447; c=relaxed/simple;
	bh=6j77YuUzUESQrILjthCpboV69/4YqDzZNIS+7UAaB9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnqE932sxBemd5g0UntiG6MKeLVz1D/HorKJeWVWEvANN7SgX+GpTExkpKdbgL4P4ynj49Z9fRhVTDRHaRsVzPiB/7oxqlbkTjg7Kmyfr4/5RuxfQSx/iBiFyrnwWC6NtxrmbKfffeFJ+N5nzI+2uYAvkLZeIlwF61CvPqXEPnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zfECiOLH; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a480985625so4155202eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712152445; x=1712757245; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1OAL06Mg2B7p2mgKMtF0umqm+s4wnDWvZ+hhRFE0Zzo=;
        b=zfECiOLHamGSPjMF81yan7vciO/nsc/LUleAiY+AtMER85KxW31RNy8S9o+C4MTPeq
         IY21xaOw344YBqKC+4P46rfjvFfGH4OGjM1lVXCrhPALPFiSrB8kkc0e2whUyeJ16x3C
         +hceBlueziSrmqF/kYO67H/aFoyIxMAFaPsgrJ2Iz7dGL6OQvlKfzPh1Ek+gRvqvQNvx
         xAL/PNFKwktdfjqLof4ywCzLJGrv4fJtE4TKbCEwM67zXPrkqM+EmwlEMkIOEhrBE2Z6
         1s57+eQ1TvkyHOUAtPZJKPVV2SxOx+Pgve+gHDhsUs+e+MCefSD6CLTT+SQPhiKf0Q0h
         plnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712152445; x=1712757245;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1OAL06Mg2B7p2mgKMtF0umqm+s4wnDWvZ+hhRFE0Zzo=;
        b=iLYSjrjtsLv3SlaW1E3effY1DScDXhvW6lEf427/TEbT0+htZZhfnvpD9ZTTbHwP1v
         59pImQyx4JoOwXZYEZt6RYcZbqLlRMQGCCQCk+yn+DQmdP79d+hayfRqXQ5qishWEvP0
         3CIEBfoGVf22J/VPvBzP4EDMA32r1qUIKKmjR1/zS2Zo9OJy1nvy4bEYVk+cTs3Jh+51
         dPlT+u7gafjSbRJFEv28ciyH0MGL8avhcctW3ThANdWGUBqJzsJb20i1vWnbXLlC7vFL
         L9IyEJMdfIozGMLsdD3l/RQzF72J5Ofxs6R/qloplh3i+iCrekSFCfsWO4l1FmdnkVlf
         Sfnw==
X-Forwarded-Encrypted: i=1; AJvYcCXXiQDklqzC8+jhCcMNXbG0U88UOOLHsJwcY9qCc0tIRyz3MFu5GaseGFw5jKzzS/LqIGg6V4W5ftiMhfnoxs0jUsRn0Y4+7FUjMfJl
X-Gm-Message-State: AOJu0YyLuj+gQZUqDV8vwYVMeB7PxKHFTpT+NFrWl6A2ZNrVW7HxiPaP
	1aFSziC7mqNBxnUOAYTboU1IAPbMBVqjYZmzzrFQyhkEztVv1V88r508oDKOmw==
X-Google-Smtp-Source: AGHT+IF03w0jcECjD5j3s8soEBtUEIJMV7AING8b0+KbubR0veAvTNYHRFP+TmHHg+oq53dMCQ1BVw==
X-Received: by 2002:a05:6358:9486:b0:17f:7807:3204 with SMTP id i6-20020a056358948600b0017f78073204mr19114172rwb.25.1712152444401;
        Wed, 03 Apr 2024 06:54:04 -0700 (PDT)
Received: from thinkpad ([103.28.246.48])
        by smtp.gmail.com with ESMTPSA id dq8-20020a056a020f8800b005f3d54c0a57sm2081588pgb.49.2024.04.03.06.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:54:04 -0700 (PDT)
Date: Wed, 3 Apr 2024 19:23:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
	kishon@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	cros-qcom-dts-watchers@chromium.org, davidwronek@gmail.com,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: qmp-ufs: Fix PHY clocks for SC7180
Message-ID: <20240403135359.GO25309@thinkpad>
References: <20240401182240.55282-1-danila@jiaxyga.com>
 <20240401182240.55282-2-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240401182240.55282-2-danila@jiaxyga.com>

On Mon, Apr 01, 2024 at 09:22:39PM +0300, Danila Tikhonov wrote:
> QMP UFS PHY used in SC7180 requires 3 clocks:
> 
> * ref - 19.2MHz reference clock from RPMh
> * ref_aux - Auxiliary reference clock from GCC
> * qref - QREF clock from GCC
> 
> This change obviously breaks the ABI, but it is inevitable since the
> clock topology needs to be accurately described in the binding.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> index 91a6cc38ff7f..a79fde9a8cdf 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> @@ -86,6 +86,7 @@ allOf:
>              enum:
>                - qcom,msm8998-qmp-ufs-phy
>                - qcom,sa8775p-qmp-ufs-phy
> +              - qcom,sc7180-qmp-ufs-phy
>                - qcom,sc7280-qmp-ufs-phy
>                - qcom,sc8180x-qmp-ufs-phy
>                - qcom,sc8280xp-qmp-ufs-phy
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

