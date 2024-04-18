Return-Path: <linux-kernel+bounces-149949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 900818A983A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E939BB23107
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1117B15E5A8;
	Thu, 18 Apr 2024 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjrGAeHy"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914CC15E207
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438457; cv=none; b=OskB0MxTkrWVQ/PXI9domSLT+eG7VLpV+XA8GliJgRmg42vH+PayHSKnigFyiqD8u/aYLnWsjMTXscVWT2BohAE3lT9TFe8jMmdDdtXBRZfqA4rVEYwD570dno92u2LUML17Y6YTIpJlq5JvXJpe26e+FNZ4nsTEljHMYJJO+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438457; c=relaxed/simple;
	bh=uVSRpt8F3GFhGujnI01U5SChDc2eJ2JPLMzVIQUMANQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLWBx+TkQ1USIKiu1TciEWXr4cb8w78r0XUnEtxjCD+dXqYR5DUeGig1vGty9PAI7DbvF/1Bexhdq1ftI1wdLdFjDUpTA2hxlydUQKFcHR+HH5iN8rx8BoGSSiaYSPBQDwUwC5LC+d16oGYBqJcJ8dAgEpBV7Csg6O9CnjsUKPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mjrGAeHy; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d2600569so906034e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713438453; x=1714043253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MyO/GjotGUHlFltRGjYbztp9IACAS8Q+nLylpcG9+Rw=;
        b=mjrGAeHySRDtvBpntukQETGWe7ArFTV4Mc7D8bj2g1MTbd5whEtkLswF0qf2NoTCN8
         DzoGS9XeTu7SFZ2gcIj4lfO6WORu0cfD0iZzrAU1dT6RMv+2yGRkXeYkUrqzsrx/rJCW
         f3Do5/S8rfoWlmcBG6zif5GzjAyHxh0ZfWdzPzwodI8BAlV/oFBOOvMSgjFvj46T+Bgl
         tCM2SVztDCpV2ibYcLsJrYK/W8576pwZZbYMHCCv58vjeGjYk4gLGX+bosEHy7nMHSjA
         NZc6JXwb+3d7wkR+/pND8jNUdVr0k7I5EsR7R1mVrs8nMxDkqvd/Emjkbl/Q3hZLgOG/
         /EPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713438453; x=1714043253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyO/GjotGUHlFltRGjYbztp9IACAS8Q+nLylpcG9+Rw=;
        b=Hnsr0W0yde2DypomQzkyqGJFtcjB0YCqZqETARFXHa4wzqqKQBlPYeu3aOx26SU2tg
         WE7HTQCzhXsOw7lyMI8luqWxv3Ecn6yufJuBhh/cNncui1ICo8bc1IU/q2a5JKuj8whP
         k1PeRzfltZAz20XU8jelLz4sbwAbvTd21nUKFqnNcjwuqzJUfDohfvLzQLPtBunS04v7
         eJcCAGjS+cTB80rVqq/AfwD23A1WG5p7/QtQTTzAYAKWkrDrxGNaAsIKGJS9SGgtJxQd
         YD6jo8e8A+9gxDSFAyRH/I3hauk4PO2cljDXygDCslB2z2oJlU8XnVvTw05iey3bG6Yt
         BRDw==
X-Forwarded-Encrypted: i=1; AJvYcCWCQGImZHRJCNSvjoCNBv9TdmeP9YODQKCUL3bg8xth9K9HrUtO29Bb3XIPKG344/iS1Nfc9ftIa0ovo4yUAEGZ/6jZ4mo/UTnm32vo
X-Gm-Message-State: AOJu0YwUqq460lnk8SMgMxi+adezJPEaDlTahYfB8q6g+VCdsetgXvhD
	ZdSMuUBC9FtDCa0ykBadMJ8mg9k1WqQg1RxWG+iQFZOCKLw//zrig8uSk7l5GkM=
X-Google-Smtp-Source: AGHT+IEwPXTDTwrWeLYeoadFGaTFA9rHj1W+CNy99dyVg08+5SUOCAzomXSQbfzVVzpXPPNwtz7O1Q==
X-Received: by 2002:ac2:4853:0:b0:518:b4a3:dee1 with SMTP id 19-20020ac24853000000b00518b4a3dee1mr1574836lfy.66.1713438452661;
        Thu, 18 Apr 2024 04:07:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id t14-20020ac24c0e000000b00517374e92e9sm191076lfq.167.2024.04.18.04.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:07:32 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:07:30 +0300
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
Subject: Re: [PATCH v2 3/7] drm/msm/adreno: Implement SMEM-based speed bin
Message-ID: <7ynodjzjuxwwqkjgns5jtnkckw52qyldfpsqpjh7645swva4xk@7wucftyjyyy3>
References: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
 <20240404-topic-smem_speedbin-v2-3-c84f820b7e5b@linaro.org>
 <hi7vzqm5ebypzs6m6bw64ghgfwsdzuaxy65jpah37iw5ww7fku@n3c5sucic27i>
 <bfd6aa32-a28e-47a4-82c7-76c5dd99a44d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfd6aa32-a28e-47a4-82c7-76c5dd99a44d@linaro.org>

On Thu, Apr 18, 2024 at 11:51:16AM +0200, Konrad Dybcio wrote:
> On 18.04.2024 1:43 AM, Dmitry Baryshkov wrote:
> > On Wed, Apr 17, 2024 at 10:02:55PM +0200, Konrad Dybcio wrote:
> >> On recent (SM8550+) Snapdragon platforms, the GPU speed bin data is
> >> abstracted through SMEM, instead of being directly available in a fuse.
> >>
> >> Add support for SMEM-based speed binning, which includes getting
> >> "feature code" and "product code" from said source and parsing them
> >> to form something that lets us match OPPs against.
> >>
> >> Due to the product code being ignored in the context of Adreno on
> >> production parts (as of SM8650), hardcode it to SOCINFO_PC_UNKNOWN.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> 
> [...]
> 
> >> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> >> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> >> @@ -6,6 +6,8 @@
> >>   * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
> >>   */
> >>  
> >> +#include <linux/soc/qcom/socinfo.h>
> >> +
> > 
> > Stray leftover?
> 
> Looks like
> 
> [...]
> 
> >> +
> >> +#ifdef CONFIG_QCOM_SMEM
> > 
> > Please extract to a separate function and put the function under ifdef
> > (providing a stub otherwise). Having #ifndefs inside funciton body is
> > frowned upon.
> 
> Hm, this looked quite sparse and straightforward, but I can do that.
> 
> [...]
> 
> >> +/* As of SM8650, PCODE on production SoCs is meaningless wrt the GPU bin */
> >> +#define ADRENO_SKU_ID_FCODE		GENMASK(15, 0)
> >> +#define ADRENO_SKU_ID(fcode)	(SOCINFO_PC_UNKNOWN << 16 | fcode)
> > 
> > If we got rid of PCode matching, is there a need to actually use
> > SOCINFO_PC_UNKNOWN here? Or just 0 would be fine?
> 
> The IDs need to stay constant for mesa
> 
> I used the define here to:
> 
> a) define the SKU_ID structure so that it's clear what it's comprised of
> b) make it easy to add back Pcode in case it becomes useful with future SoCs
> c) avoid mistakes - PC_UNKNOWN happens to be zero, but that's a lucky
>    coincidence
> 
> We don't *match* based on PCODE, but still need to construct the ID properly
> 
> Another option would be to pass the real pcode and add some sort of
> "pcode_invalid" property that if found would ignore this part of the
> SKU_ID in mesa, but that sounds overly and unnecessarily complex.

It's fine, just add a comment please. Maybe we can rename PC_UNKNOWN to
PC_PRODUCTION?

> 
> Konrad
> 
> Konrad

-- 
With best wishes
Dmitry

