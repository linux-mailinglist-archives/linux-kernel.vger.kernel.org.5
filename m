Return-Path: <linux-kernel+bounces-153933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA738AD512
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2B3284884
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC0A155354;
	Mon, 22 Apr 2024 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gelMmyJQ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDCB155335
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815089; cv=none; b=pewQuTemAnrGQA/mLbf/4rtwD2yOdKku6ju97EwZAo96mjdlkLFz/NzqvqO24khJPGOJuP5TBHRilkVNWE1AJLLYCjqhHeFBgb4A2kzYXwvpgUcdrqG/9mNXlxEDFga1meK5d4x0eXNalRofVhJJGcS5TCkqjwNX4GqU0G5fwRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815089; c=relaxed/simple;
	bh=9Nx8Aoim3ajZIbu1UpzqCFqC7ex9zJqVAjHbfqFAjec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPPdZUa2w533llED8H0K3KPqlv3nEcFK5nDOhkOax2XL3ClCCdYG2vdLgtMTneEGiHWLn8AfFxUZMaxfW1mdDczwHIVFL1MwdyaYz6L5Fo/aCASAwwCUYchYYKa4M1DgoRgCMoS2ZiDiCQDsNT6xgirdzEhbYDcPz4HqDjXJO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gelMmyJQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5194cebd6caso5786392e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713815086; x=1714419886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O5xyyivQsMTHQ7dLcNsluj0Jp99yRb62wMbu9zf5p5s=;
        b=gelMmyJQcKALWwhKJj9/ckv7vWNIkD0wVzZUcfU/o6RQiRHdoRksHtLuvS5RD+eyYS
         bcxM9tiT8zNfkzGCmRrG3AGaYAl40dVSckOjfvKpHNQo17mbeBx7PSxc5Ni6BIbn6JEX
         LPEcW7OpilQhB8KHu2Z6cStQ7TZpP0TUMW907kO7CVkHjIO4rF0At33a6h+RzOH0BgAC
         tLusNMwXIixRCEV6cape1TX1Jm5WfB2HFV0vRmVkL8CcjkB3lBu/iZeaUKiRq8Y84v+5
         1yWA2jpclUlVRw23UfCB0T3BTbDTKNQilxrVGTrA0xtJ7Pmwgy1gsvMjuXzHB7kzEPVr
         wp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713815086; x=1714419886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5xyyivQsMTHQ7dLcNsluj0Jp99yRb62wMbu9zf5p5s=;
        b=H4p46Ix4Q3vOQYdv8o7gC6PHEla+4JycITy0maWYd7+NdjZ/oS4bt63eqDNnECCnfB
         Z19x1gRl8bAijm4skvPrpCd6++4ek2DR7i0JcScJmgU157gJ/9755OAk1dhgG5nEtmxB
         1sOObczyJHjMbkILmPhxiXGozlbGvQzRxUOgr3ILMKhxWjp5U/6CiyzP4EZq+BFdyvZi
         cfSVpXGKYrs+aHedlz1eOVDVU9aJgO11J7Ssqd7ApKBhpUsqvWaYzgS5dYzq/uGkeaI1
         fQmJbZtIbHb8rM+ZOtczmTI0bZN5rDBCA+Da5TTxn7xCoAZlJ4rA4hiApPkJufV0scte
         zfJg==
X-Forwarded-Encrypted: i=1; AJvYcCVfV+Bbiq4f9tA41hnSsoLjazxmz0ns0rGys5+Y6kHC8aUCz/KG61v1iROIzd8sKBjPukOWz9ny2xAONVInOJn1Ein8cRi+18tVVA5F
X-Gm-Message-State: AOJu0YyNjGLBlZam69vkf0x3KohEpqZNK4CxllXoCTvzpjNJ7q/5VXl4
	6pYomAnR/cIbw9fcT4HrYKV4COpyTp+e68ziXCpSO+vfBXL7CnygRf4bez5uY04=
X-Google-Smtp-Source: AGHT+IFB1Kv7g4uVpDs46ZAzOEBDJZtGjxsU0UGxK762fiEgaJ1n/WHkpnV0MuYvu79JTdl4W3x0SQ==
X-Received: by 2002:a05:6512:3af:b0:51a:d7c7:769f with SMTP id v15-20020a05651203af00b0051ad7c7769fmr4830577lfp.65.1713815085997;
        Mon, 22 Apr 2024 12:44:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id r1-20020ac25a41000000b00516c1fa74e3sm1824681lfn.207.2024.04.22.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:44:45 -0700 (PDT)
Date: Mon, 22 Apr 2024 22:44:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/msm: don't clean up priv->kms prematurely
Message-ID: <ohzwt5llvvogo46757iemkrnqwdzwqldi3bhbgvk4pxsp3wpuo@enc4bzir3uur>
References: <20240420-mdp4-fixes-v1-0-96a70f64fa85@linaro.org>
 <20240420-mdp4-fixes-v1-1-96a70f64fa85@linaro.org>
 <67fbd629-3e80-b706-83a3-7baff3efd6c1@quicinc.com>
 <n7eet54g72usmuh4hdz6yce3i4ieweu4orgd7gewu7y53ejucc@dzmq2a2wdxkc>
 <456bb6f6-03cc-aae1-b7d5-9d97300ba383@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456bb6f6-03cc-aae1-b7d5-9d97300ba383@quicinc.com>

On Mon, Apr 22, 2024 at 09:12:20AM -0700, Abhinav Kumar wrote:
> 
> 
> On 4/21/2024 3:35 PM, Dmitry Baryshkov wrote:
> > On Sat, Apr 20, 2024 at 04:02:00PM -0700, Abhinav Kumar wrote:
> > > 
> > > 
> > > On 4/19/2024 7:33 PM, Dmitry Baryshkov wrote:
> > > > MSM display drivers provide kms structure allocated during probe().
> > > > Don't clean up priv->kms field in case of an error. Otherwise probe
> > > > functions might fail after KMS probe deferral.
> > > > 
> > > 
> > > So just to understand this more, this will happen when master component
> > > probe (dpu) succeeded but other sub-component probe (dsi) deferred?
> > > 
> > > Because if master component probe itself deferred it will allocate priv->kms
> > > again isnt it and we will not even hit here.
> > 
> > Master probing succeeds (so priv->kms is set), then kms_init fails at
> > runtime, during binding of the master device. This results in probe
> > deferral from the last component's component_add() function and reprobe
> > attempt when possible (once the next device is added or probed). However
> > as priv->kms is NULL, probe crashes.
> > 
> 
> Got it, a better commit text would have helped here. Either way,

I'll update the commit text with the text above.

> 
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

-- 
With best wishes
Dmitry

