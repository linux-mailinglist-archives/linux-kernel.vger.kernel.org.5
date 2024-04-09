Return-Path: <linux-kernel+bounces-137210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB0C89DEEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25431F270F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4911327F3;
	Tue,  9 Apr 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CoH2ukWX"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AF01304AB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676259; cv=none; b=j0sUC8lmf5iiJcJTcbl3RjeTEa/Cs46dfAmICLMzqZxA7NWEU5fRq/MOOBDw0LAbqF7aHZo7rVPY4d82MfD/YALz5OXHeLkwfAMgTDfszilhpIyouTRrGaTCpktdoGnhRDRw4cROcaFj6jdhHXvrg6G0GEcC2qlR/oRJFiRYE2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676259; c=relaxed/simple;
	bh=GKUqmsCQggqe9TQ/VlUNrNyugz5nzNQPq9eDIJoV+WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRhL4K106raAGAv8Q6V0w0JA5w7Ul7w9Gg/bwjOaMqvPDjANZGwhYZuukJGdy+9W+0dGMGLjVY/bktOn5iQi1n+grW9yJPQYlBz1VJqGmmlpAfx91HRQBJCMc3kW9JQrsfCihJGrRWSGXnf0OfI8+91im8IcDmu8TDN0WHBQGXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CoH2ukWX; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516ef30b16eso3366361e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712676255; x=1713281055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8W6G8HZYeo1iMSpifmT8ORYKphiMz1er5wWw8HHvUlI=;
        b=CoH2ukWXoeRc/jBCSDg5sZYs0epXkB1+m+AcX7VZjsXjakoIOpkHOcFWYvcKumcvFa
         eN+4FlQutMQT4qcLJP0b5nOE2vI1v8IvVSLMKbwu5KIhbg4OkCOz6OtdWi3EwZASczws
         7tCNla750U9E7rMILRCLs19pXRq4bUG6BYUqyxtnJy75qG4svw8UjPm318bs5Nxj5Cn7
         R05RsZH3iHm0Stgfyd3/ZtAkMWzKWTmsfASNquMHlVfIeHmObIFb2HNUcXOKzNTUNKCF
         TwV0JZN8nvr09/Z8bjFZGOOq+Ad17IJxQ55FUDxICHZT3gMWrcc75MrFu/d0DmncUK2n
         P2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676255; x=1713281055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W6G8HZYeo1iMSpifmT8ORYKphiMz1er5wWw8HHvUlI=;
        b=g8Ym/tDyfwBa/zGAvua4ZkdGd89BFa1tESZUlF6DhubQUUDW3E76at0ylAcyohhyrL
         xv2Zqk94tnOmDjos6wCTiRZrTBdi9rPM1pd67V3m2qoPnX9PA5P+8hbQ8yOzF7xg1Lts
         BbK+gmRmf7vKldWKZSnmHEzFoF/A6Irb8FjmqVxIHVz+uJzzjyVp2mYDTF9tBZ9A/FZj
         7hK5wS3BCAwkhhZgIFNBx2kjq8EgR1CA2BF37KT5NhamXdP1fbJ9stQxJmya0Tp19CIa
         Jd5Jbq14st1qgMFmrDvFwtoe8GoZ0cB7aUflsNCJHVaFf9x52/GkI6TAuQr0gq/hR2zR
         g4DA==
X-Forwarded-Encrypted: i=1; AJvYcCXqBRO1QL4fIcU3ISKVZYgmN+GDXZCZIhvaAvu8xgDL6XsNKLdP23A5QWoQ1EreZKis40VMGJFti1oQqVWesJkTc0+AqQa01A7X8jj2
X-Gm-Message-State: AOJu0Yxv6+pHWbBaqvSnzk7XMeLTG5UV8jkyUVt7NrIMLCMBfZAXBp1+
	okxbeJkLq208UitqXwKPPCGBMq873u0FwnGqsqNzI88UKtWTj9BaGvIjRTMB17KWoAC0KqWd/o5
	t
X-Google-Smtp-Source: AGHT+IGgmNyquLws0Qkisav6dI35WAm8hEi+6R9A8E+K+p3FMjpmyYxLBNTdF+Phz+qzA9Iy+M4e/Q==
X-Received: by 2002:a2e:7807:0:b0:2d8:3a46:8ab6 with SMTP id t7-20020a2e7807000000b002d83a468ab6mr83703ljc.17.1712676255409;
        Tue, 09 Apr 2024 08:24:15 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id s10-20020a2e98ca000000b002d0aad9dcfcsm1584958ljj.59.2024.04.09.08.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:24:15 -0700 (PDT)
Date: Tue, 9 Apr 2024 18:24:13 +0300
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
Subject: Re: [PATCH 5/6] drm/msm/adreno: Add speedbin data for SM8550 / A740
Message-ID: <4ghhtxjtkfjzxeyrajn26get4d6xiq57swwsjmyialcyfivui6@se3ukxxukspt>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
 <20240405-topic-smem_speedbin-v1-5-ce2b864251b1@linaro.org>
 <nek4paofg3hturvjwpa2bnsvmicwmvwixzr6e6iuqstemgrqyo@cagcrnzjsne2>
 <0955cabc-fc4e-4790-a82c-7f6f807fe36b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0955cabc-fc4e-4790-a82c-7f6f807fe36b@linaro.org>

On Tue, Apr 09, 2024 at 05:13:15PM +0200, Konrad Dybcio wrote:
> 
> 
> On 4/6/24 05:25, Dmitry Baryshkov wrote:
> > On Fri, Apr 05, 2024 at 10:41:33AM +0200, Konrad Dybcio wrote:
> > > Add speebin data for A740, as found on SM8550 and derivative SoCs.
> > > 
> > > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > ---
> > >   drivers/gpu/drm/msm/adreno/adreno_device.c | 14 ++++++++++++++
> > >   1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > > index 901ef767e491..c976a485aef2 100644
> > > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > > @@ -570,6 +570,20 @@ static const struct adreno_info gpulist[] = {
> > >   		.zapfw = "a740_zap.mdt",
> > >   		.hwcg = a740_hwcg,
> > >   		.address_space_size = SZ_16G,
> > > +		.speedbins = ADRENO_SPEEDBINS(
> > 
> > I think this deserves either a comment or some info in the commit
> > message.
> 
> "this" = ?

I see two types of speedbins here, it would be nice to understand at
least some reason or some defailts for that (if you know them).

-- 
With best wishes
Dmitry

