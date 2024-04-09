Return-Path: <linux-kernel+bounces-137208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD45989DEE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8873E299A6F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B605E1327E1;
	Tue,  9 Apr 2024 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofoEURwW"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573A61304AB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676190; cv=none; b=PO0ub6DMjhjx2wHgpxkRZspm2uw8YigQw6KJkY4k6qbc8MQf3G+7fW6pjziadlKGW9llG6a+SXG5D+Ay8lVHYdOkWfToX8x3TlZvrlLzfzv3cMY+3BX0q9k6q+FSwClOQrHTtReIDg5xjZzrrhq+DGSB3TB3TorocnZ4vEs1amg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676190; c=relaxed/simple;
	bh=lwgrpuLlnQidXBRAJjUDoX6XQIX2kCvA7rwH3DqWPgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izoYgWT3qYJ+TyCHZH/+twskWYsRf3NVJCPC3MsM9+dhtYkDg3uOTpy+QFME62/5MBEFhn5/6iWa7zDcOPZQ2d7ESyrlH3XDm21Gez8NBmHiYDYmxYta/7hfb/Bt48uNODVzU4h0tJv6nQSkr6ck3g0G5hzHVP6fHqpnrCMQ10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ofoEURwW; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso11582781fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712676186; x=1713280986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2tCjiKMLu67Fkz+iezt/yHgHaFuwGLbY1Fvrb5eqfo=;
        b=ofoEURwWg9NJGvXyRSfOne8RT5Pj7/tUKfFUYAuACFD+zUWaSK6BmTjdG7VvlvUP9N
         H7r+hjqrZYIyJU7/vCOkTD+JwmRYEz5ohfblNWXkhdg9VUabSdh4xa+qVwNiNkWnKpTd
         de/kBs0KJ1TkeJZRzIV7ocBo1OK+ptIhBMZEYGhCdZBaGlnANrGJQ/Z26UbhEko1lz8x
         5fq1xKv9B3/MEfXnZAeprUp1lESuZlpG7xc0on0QrCTFAQVcMokU3M2Tn1iE0kaxm247
         zLP64NQ1rBxnvcv/IntLQqNTLVjWodBGg9Dzzc3Kb7HGKkOrvHBAJ03DyuALCwlbfEdi
         oFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676186; x=1713280986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2tCjiKMLu67Fkz+iezt/yHgHaFuwGLbY1Fvrb5eqfo=;
        b=QSvQdCwergOXnn7/U6RSJ+Oddv3G4Ie1bM7jJkGwIramC+D2xFMVWaEMBEIv02YmDW
         w41EmpNTMHY6kQ0THYRD/5kMqtpg4uUBt3s45XySVNhjyQJbKX4MfghXkSe6cGUmDsIg
         mWkKm1P6sv9TK932t6y3l6swAfniADbc4Wmhwjm17SAgm+HIMrdXWjoydXRFVFJvAOp6
         N8238kPV8aXWRGRQoY2kDz7KXl7XMVgCG0KQxTz9MGxgJNDCVBo5vDG1a+BWGLD277q7
         kfzq8ZRJjrNmKDglVEGK6fsf3Sjp1A7/1hc56RXPJZcMrbegLphaRe+BjPHYp2F5srs4
         Adww==
X-Forwarded-Encrypted: i=1; AJvYcCVHRBINHTEJ2s1g1hvInylBB2ZGfcEWhcqLPyu5KDd8fd1UVj5z2lW94ioWtJU48r56Du9EI1ukxIHaDjdGLTBkCIVIzuK5TtchUBvJ
X-Gm-Message-State: AOJu0Yz6wLgomfsp/q8h8CaAaPeZUzAmjNXsSwrHzVm1XDssDHm4dIj6
	C/alO9Au+9YXSruckRTu/G5qGdvfQm9fjFXFkcImGJY/xFjYshbevfZ94fRvI2o=
X-Google-Smtp-Source: AGHT+IGd1MRTD1fygLkZGj0gGNROnqZWAPn+yiWrzGgkFdwm6W4JiIoDmuUFWhKDLN7YxgE/yllZVA==
X-Received: by 2002:ac2:454b:0:b0:516:bf06:cab7 with SMTP id j11-20020ac2454b000000b00516bf06cab7mr8930457lfm.35.1712676186541;
        Tue, 09 Apr 2024 08:23:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id c22-20020a056512325600b00516a302f32asm1593546lfr.132.2024.04.09.08.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:23:06 -0700 (PDT)
Date: Tue, 9 Apr 2024 18:23:04 +0300
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
Subject: Re: [PATCH 3/6] drm/msm/adreno: Allow specifying default speedbin
 value
Message-ID: <tkcbl2iwcy3feoggbk737gx32qsxe5p4ad6lfrujy2pazccrhm@kif3guuzay6h>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
 <20240405-topic-smem_speedbin-v1-3-ce2b864251b1@linaro.org>
 <pncr7ecf4eir36skul3iwt2nf5bpuwd5zjfzzfwwnxjwe4hoes@6z2xe54crijp>
 <d8a2ef87-f29e-4bdb-a9b8-591b8bd5d2b2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8a2ef87-f29e-4bdb-a9b8-591b8bd5d2b2@linaro.org>

On Tue, Apr 09, 2024 at 05:12:46PM +0200, Konrad Dybcio wrote:
> 
> 
> On 4/6/24 04:56, Dmitry Baryshkov wrote:
> > On Fri, Apr 05, 2024 at 10:41:31AM +0200, Konrad Dybcio wrote:
> > > From: Neil Armstrong <neil.armstrong@linaro.org>
> > > 
> > > Usually, speedbin 0 is the "super SKU", a.k.a the one which can clock
> > > the highest. Falling back to it when things go wrong is largely
> > > suboptimal, as more often than not, the top frequencies are not
> > > supposed to work on other bins.
> > 
> > Isn't it better to just return an error here instead of trying to guess
> > which speedbin to use?
> 
> Not sure. I'd rather better compatibility for e.g. booting up a new
> laptop with just dt.

New speedbin can have lower max speed, so by attempting to run it at
higher freq you might be breaking it.

> 
> > 
> > If that's not the case, I think the commit should be expanded with
> > actually setting default_speedbin for the existing GPUs.
> 
> I think that should be addressed, although separately.

I'd prefer to have it as a part of this patch, but I'd not NAK it just
for this reason.

-- 
With best wishes
Dmitry

