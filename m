Return-Path: <linux-kernel+bounces-149326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D078A8F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 751E9B212E8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06461126F11;
	Wed, 17 Apr 2024 23:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hIi5bZbV"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36A8594D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713397447; cv=none; b=ip6gsJTFUYkEN7LvJGliBLy5JTguLHeVvZgNyOPwVrLpxg2EQusTAGDFwo2Fv7R9piC51anKFMDPkQuZp4c5j56Yzo/YEqrUszuDwzBHiln2nJT+aWxxJcA71RXhOoOBoHSBvEHVmS2AUZwxkguIwR+2I6NYxBgMOHTxtIxkk70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713397447; c=relaxed/simple;
	bh=UaZ1PhBhO3QCAsKNZAAEh3te/Tpq/ISFTdys8kgJiYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzNRAXQJhqIF2eEY0fV5qLIYAikJ/KIH1LyB7SQ2VSzhNwYWODc59McOoB+uZ6wFSQm1+kQyYh+0KgOCsr6943s2zCxR4Fqf3kRVKiuOKhiVSCSeREnwJmTe1F1KoH/EeTjUxF8BeqascjZjZOWTo91NUmJAfM8ESi26FVIjKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hIi5bZbV; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516f2e0edb7so278635e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713397444; x=1714002244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4dYJ1ClH4O5pb9/mVyQ9/1Y0nfz72c0FqGgqO6+NBFs=;
        b=hIi5bZbVJAmj/aLD2UtlSP3OiAgSb5JWlL3hjWHNdYOrxCorpTja2QLYhKLdx+mOQW
         4Lnoyt3SN0Gth07UYqP/xWCkPP9e+Vtr6BlH3dTp30um5+FpXtoQQMW1qSKvEgoIhf78
         J8fw4IInAjSCX4c+5cX6JbSNLJMOFhzVbUb3R/T0B8CZBontrH8kEX9ofyXSl/iX10gQ
         NkI32jhy2diVNX0yGemH0/RHWU1dA4QGPICE218JvYJdhITO2GRjt2oqP/KO5mTLS062
         KJ9b7ZCCSqP1m/Ivl4OxJedyMTxnUFwEUkfZe6JGqMlhXas3iNEWyIfMVTcr1Ifh+BcM
         fYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713397444; x=1714002244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dYJ1ClH4O5pb9/mVyQ9/1Y0nfz72c0FqGgqO6+NBFs=;
        b=U3bvj2KPw9Do5GhQ/HXKtchYZICJihT5DKD/P76BJxa7xx0qP2uBhCqrLUAF0lKDXi
         YZkZhmIugf6iB5mWr1pSQ7KJxfwZrA74idbpviYSw0eNkDzP0o+TY+1D5dpKT4uFx7f3
         xv5mqnRhl6FIj5ZxaUTU5NCNjpdFSWyC4Cn/E0o1ClLZOp4gU8eSg5CG7l1U+WYoVANc
         R57190Nh1BrhvP1MTG1r7ua8YxJCL8j/JJJAATEFc2y5a0CSkTKluuWnlnwhhfV/4sRW
         ka7rYFqDhsodCBHVps6aj0YvOS6CFYEsCGMfSGmoDlKMrhHbuYMlspYCJlPWqaktsExu
         vWrA==
X-Forwarded-Encrypted: i=1; AJvYcCUqyinJ+8eJadjNCGjyIks+LyXaNmYBshClK5qtY+DwcKeDLEeLOv7IHfa1yi4wHoRu+gchUlKhoT4D41ES6RYQoNxEJ3VxAVzHDEuh
X-Gm-Message-State: AOJu0YxIqSwDRjusjj2sbW+SkG4LTcxNSJ3LtZBXx2HNGGR9CpX/scyO
	93X1m8tDc5AgLrOOhBPbvnGfIbtC8zq1gp89lVF6Bry1oHyY5XsEQ/jxnNBFqb8=
X-Google-Smtp-Source: AGHT+IE5TTewc1NQU6pjDvIINRLdTRyEr93ooSR0k+a7QtvsqWnNHglfNzFwEISYjtKIqilM46tyXw==
X-Received: by 2002:ac2:5605:0:b0:515:cc50:9376 with SMTP id v5-20020ac25605000000b00515cc509376mr350592lfd.22.1713397443931;
        Wed, 17 Apr 2024 16:44:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id b27-20020a056512025b00b00516dc765e00sm37612lfo.7.2024.04.17.16.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 16:44:03 -0700 (PDT)
Date: Thu, 18 Apr 2024 02:44:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 4/7] drm/msm/adreno: Add speedbin data for SM8550 /
 A740
Message-ID: <wuxp2yusymxlbmiktheulgw42aexmp3pro2ookzjppn6pxwz3h@ohj6jlnq6g35>
References: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
 <20240404-topic-smem_speedbin-v2-4-c84f820b7e5b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-topic-smem_speedbin-v2-4-c84f820b7e5b@linaro.org>

On Wed, Apr 17, 2024 at 10:02:56PM +0200, Konrad Dybcio wrote:
> Add speebin data for A740, as found on SM8550 and derivative SoCs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

