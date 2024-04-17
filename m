Return-Path: <linux-kernel+bounces-149309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DC58A8F53
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB8F1F21A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A575A85958;
	Wed, 17 Apr 2024 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mt901/BV"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3172485923
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713396665; cv=none; b=uwtRRTuyXeFgYRJRLbiE0P+aKhXgxLR+nMMkMo210puPvU4lBC3hkN2Di00e9OQ0S5ebiEHeEH1HfX2GX4hPtOZzWaDR+IB6VTpMcjjx9fkKFb9YQs8njR2gKVsA70pBYsKnmarwCCctCTJ/Q69nRSwX93eYShqSYfIRpxCCTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713396665; c=relaxed/simple;
	bh=+wnp08U/kyK8/mMyjzZ7MHT+WrYqgAZlIl85tBAgotI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBA8lZajs+ewOxUI/22YKx4mrszzyps9HyltSUAVxsJ7+w9xtXBFkDh8O/SWJMHOaT5NiSrw4XL4MRuHDZ5d3Amo9bYhwliSL63v2TxnVBlG63ebPss2VVSspepUgrnElCdHqhGhaSTfGmfJiuzKGtvaEWchTkQkBUTP8WULPAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mt901/BV; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d487659bso224238e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713396662; x=1714001462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GoRisbGnaphvkOMl0BaR8O6Ht/Z9FTi+nAoLdKSqnlw=;
        b=Mt901/BVD9IfcqJBMFD2nd0S+y1XmXqO/3cdt92DOkgUUT47tvuYpiCs/PpI2h7Z7w
         Zlo3/5axXHgc2BFYSzwK29ipGMeI003MdUCvfbr5RGiOok7Yml5EUdPB4xxPl55yCb38
         zptFjrfHem2rhSaIa9Im1hX4gAN3jwMMDyyxrZH2IEQkGAArwrnAoetpgdKy+9VhkmrH
         0mKHgHGl8UxibaPhyBlfzRhH0mZIrPKUk2o5NOFwL12U41Bqv2FMkuanZDbpKOS6lkqS
         A13pLpYOLnm/KkVt8DXGTaIgvSWeb5R3sQhYS9GX9wUgH8uKddWDJSvMFWk3YTlOqF4A
         c9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713396662; x=1714001462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoRisbGnaphvkOMl0BaR8O6Ht/Z9FTi+nAoLdKSqnlw=;
        b=ollEVxSeN7LEiEEgtiV3JRz6g8EqGm/g1VuZKNBQL/vq5IRDoQSOHP7dMmDbCqBXjY
         MqFf8FpCL87xiB0ayKv5kd0lxMUkyCOYEWE9clZvGx4mvGsShsMSm/LXrSV0CaYVQGTm
         axXlnGSbMtQu4ihehHx5rlt1rMWTsS14Lhmh1zPtQXs2DkuiOioTNz4pEo6WjhSfgLAX
         koygy4M9B1iWroqMKbtx9efMq45MHRpCwMcC/9exE6TLU3MVQ35F0swZHAxCwsYTEIyd
         if2pQJUJ8BUEGeSER/Lt8wjP/56SYmjO+FwbAaZMl7es3Fq4Xl8tB1Onqijsx5cV4bMI
         VSAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqRKN1zB5MB3jHMk/Z5wR3epUvDBqdjI5l1euYlVA9l+o0k3eI813+pwj2PLy7CAenXJvr/tUfXiu3SBu7kgopK4SIOwMvS6zGNOd/
X-Gm-Message-State: AOJu0Yy54H8wflSNB3FhAorOEBGqqf0hMyCHwyNri+69M9M01KDsE3YA
	uVAup5AkBNkye8DSJkBQrrCLLPmvA/uE7DOjjWXnIQSz1wdo+oN8b/9wb0eM5g4=
X-Google-Smtp-Source: AGHT+IFdNJlkHn8NQV8zP3hm/RjD7xvcRdfYhoYaJN6camRxCnIHqiip6JS4Fiw3DsaEK+EVXCYA8g==
X-Received: by 2002:ac2:4e4f:0:b0:515:c102:c825 with SMTP id f15-20020ac24e4f000000b00515c102c825mr352459lfr.19.1713396662157;
        Wed, 17 Apr 2024 16:31:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id y22-20020a197516000000b005195b134404sm34870lfe.103.2024.04.17.16.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 16:31:01 -0700 (PDT)
Date: Thu, 18 Apr 2024 02:30:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Archit Taneja <architt@codeaurora.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Vinod Koul <vkoul@kernel.org>, 
	Sravanthi Kollukuduru <skolluku@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jordan Crouse <jordan@cosmicpenguin.net>, Rajesh Yadav <ryadav@codeaurora.org>, 
	Jeykumar Sankaran <jsanka@codeaurora.org>, ~postmarketos/upstreaming@lists.sr.ht, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Martin Botka <martin.botka@somainline.org>, Jami Kettunen <jami.kettunen@somainline.org>
Subject: Re: [PATCH 5/7] drm/msm/dpu: Correct dual-ctl -> dual-intf typo in
 comment
Message-ID: <76hjmo4sq6sfjgmnvjoienc5aij74pfjtwevnnls65kxinyaxu@y3yydacvcflm>
References: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-0-78ae3ee9a697@somainline.org>
 <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-5-78ae3ee9a697@somainline.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-5-78ae3ee9a697@somainline.org>

On Wed, Apr 17, 2024 at 01:57:45AM +0200, Marijn Suijten wrote:
> This comment one line down references a single, "same CTL" that controls
> two interfaces, so the comment should clearly describe two interfaces
> used with a single active CTL and not "two CTLs".
> 
> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index d9e7dbf0499c..7e849fe74801 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -428,7 +428,7 @@ static void dpu_encoder_phys_vid_enable(struct dpu_encoder_phys *phys_enc)
>  	dpu_encoder_phys_vid_setup_timing_engine(phys_enc);
>  
>  	/*
> -	 * For single flush cases (dual-ctl or pp-split), skip setting the
> +	 * For single flush cases (dual-intf or pp-split), skip setting the

It should be fixed, but in the other way: it's 'single-ctl'. See
sde_encoder_phys_needs_single_flush().

>  	 * flush bit for the slave intf, since both intfs use same ctl
>  	 * and HW will only flush the master.
>  	 */
> 
> -- 
> 2.44.0
> 

-- 
With best wishes
Dmitry

