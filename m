Return-Path: <linux-kernel+bounces-149968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46338A988C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448512843CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF3F15E7ED;
	Thu, 18 Apr 2024 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p7gOe1Hj"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DE715E5BC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713439775; cv=none; b=cPsEPWzYHl9FHX6vmRDAbttKel9kOlxILAgGzPTRiFbb5D2vNqtNa/xMJnh/+LTtHVd/k0onwHlgP9poOh1HKjaURfMHpW6hA9f8sI/lUPR7WwYJ/K4j9qUdBnXIHM6GI7MYzzpLMRoG2xayFWYCc8G+4+MEubR+2Co6OmM4wiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713439775; c=relaxed/simple;
	bh=lN1vDTT/1GpDlMc7dTQoQFul/16jZ2rP94h7wx/6jI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsWSujxJJqgTfPD6Mkh26b3BCWDV1aUebE8AOTmKGIcBZ3jBuC7O+sTCT8y+7w+2e968rvpl15D27EjBohR4PVPAForRzmD2W3bDrKe+5WMw9KDGckUAFzaM9SfiQ37H1A9N+BuFuCQJOg1UFc2rv69Dl8MaH/2fgh/bAveMSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p7gOe1Hj; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d88a869ce6so9568141fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713439772; x=1714044572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnnE/IfmzmlA5CHyUgqh20yYFBPuvnnShtetUjnyr8w=;
        b=p7gOe1HjaE+WJl5Zyf9NG4wwUdgRLiy+jDK0WDsxYVRzvQzwOm+RFdvrER9BKtoSgz
         44nuQxIsUkS0qzaRojKw1AvN/jbJOXPyblXD3pBGl4G0+SGaI4fMkp4lxFsmhXtWyPG6
         /mChTzrIJ5nzXEOa5CcAErL7dtSN7Ytpy/8zsQB9myWsTFI4le/wRBqMpTvcjGUtsznw
         OCENGPeKjsf1cTF7wxSoo12xCMYaOOA5N5ekBqfwQ/njkUf10RdoTZQtrgr6WpCLi9Ie
         AHBqDn3mAvFbnzeyVmx/efq+1Omf01GH6kSkyUePCBklZzoPXRS4vh7kPVskt5pyv/Pc
         PnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713439772; x=1714044572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnnE/IfmzmlA5CHyUgqh20yYFBPuvnnShtetUjnyr8w=;
        b=Uk2dnWeR0atqSbywoSfte5dmbLi/l23Yix5fsVWI1xIKlE86q8uaTp2ELN+z5D0ifw
         RQ9qNcp9QAseWCLY97RP0zrWCSnetm0hMWI88JdnJ86baLIyhd/tVeHTUW2OsU51mauI
         4PqUw6dCTvjvF4oZtdFXGK6ryo+qZ1pubZtgj/I28y00nG5UChiRX90QmaZ2cTlA8TEm
         kA757JIR5MLVT9Qc5z290trvePyCzM6nxslkhv/ceE6Clzt3RhsqRtwKXqd4mNxBrwXB
         WSzwkYoOIWf4pv8CBNK/ySyQ16XXKIUZbmZPe0C+PsQYmoy5bdhsxln3rYrr12ELSQ1d
         nUjw==
X-Forwarded-Encrypted: i=1; AJvYcCWlmZcBB0QZHD5fbNe9RSoKQPvywRsRfP+m2d8E7nW80JWL/hXOFCighkVsKfdt137oZacOXr8WIbqIAsB54Q/0cnmP/EDTC2jCHcjw
X-Gm-Message-State: AOJu0Yzx5JBlNHHh9RzMoB4FOdcfbnIa/pGdMZh26o4q4F4IYcfrrxgZ
	rZexv0BOA2QwdW5Ugnp5adFox0wQU9ScvfvWcjDiSe/jNGFgI+HvCWY7uTPnq3s=
X-Google-Smtp-Source: AGHT+IHDv6oDHXnx691EqLgUPOwR5cVUUBZLA5KH4jyaTEU8AhEQ4q2Ks28SwOSGF59XRR6bH5r3jg==
X-Received: by 2002:a05:6512:158d:b0:519:591b:6d7a with SMTP id bp13-20020a056512158d00b00519591b6d7amr2116064lfb.7.1713439771793;
        Thu, 18 Apr 2024 04:29:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id n17-20020a056512389100b005175dbca53bsm202809lft.185.2024.04.18.04.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:29:31 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:29:29 +0300
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
Subject: Re: [PATCH v2 6/7] drm/msm/adreno: Redo the speedbin assignment
Message-ID: <2ha26ft5hliicfgaiu6uk7cywyjhhl4x6gygg7rhqqftyfmwqo@qpqf6xr4zudy>
References: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
 <20240404-topic-smem_speedbin-v2-6-c84f820b7e5b@linaro.org>
 <rilfqdvei26bjyz76hdsh5wlh4s2lcn235up2vxbs65pnolyty@rs77jbxxqzye>
 <132c1e03-f55c-46ba-8a22-9cea1ebdfae1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <132c1e03-f55c-46ba-8a22-9cea1ebdfae1@linaro.org>

On Thu, Apr 18, 2024 at 11:57:35AM +0200, Konrad Dybcio wrote:
> On 18.04.2024 1:49 AM, Dmitry Baryshkov wrote:
> > On Wed, Apr 17, 2024 at 10:02:58PM +0200, Konrad Dybcio wrote:
> >> There is no need to reinvent the wheel for simple read-match-set logic.
> >>
> >> Make speedbin discovery and assignment generation independent.
> >>
> >> This implicitly removes the bogus 0x80 / BIT(7) speed bin on A5xx,
> >> which has no representation in hardware whatshowever.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> 
> [...]
> 
> >> +	/* No speedbins defined for this GPU SKU => allow all defined OPPs */
> >> +	if (!info->speedbins) {
> >> +		adreno_gpu->speedbin = ADRENO_SPEEDBIN_FUSE_NODATA;
> >> +		return devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
> > 
> > BIT(0)
> 
> You mean for &supp_hw, or "1"?
> 
> 1 is the "count" parameter, supp_hw is a "u32 supported_hw[count]"

I see. It confused me. This way it's getting set to UINT_MAX, which
will match against any non-zero opp-supported-hw. Ack.

> 
> > 
> >> +	}
> >> +
> >> +	/*
> >> +	 * If a real error (not counting older devicetrees having no nvmem references)
> >> +	 * occurs when trying to get the fuse value, bail out.
> >> +	 */
> >> +	ret = adreno_read_speedbin(adreno_gpu, dev, &fuse);
> >> +	if (ret) {
> >> +		return ret;
> >> +	} else if (fuse == ADRENO_SPEEDBIN_FUSE_NODATA) {
> >> +		/* The info struct has speedbin data, but the DT is too old => allow all OPPs */
> > 
> > Missing assignment to adeno_gpu->speedbin ? Or is it fine?
> 
> Good catch. Only mesa (and I suppose you :D) read this value.
> 
> > 
> >> +		DRM_DEV_INFO(dev, "No GPU speed bin fuse, please update your device tree\n");
> >> +		return devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
> > 
> > BIT(0)
> > maybe #define it?
> 
> (ditto)
> 
> Konrad

-- 
With best wishes
Dmitry

