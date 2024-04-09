Return-Path: <linux-kernel+bounces-137452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 622A389E25D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C1E1C229ED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F81A156C4D;
	Tue,  9 Apr 2024 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h2QPffnU"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829EE15697F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686506; cv=none; b=bILeIMOy9e1unaWYuH1iqP5ObVnRrFN2WPP3B4/2j+2jV6G5hy4uvO8B1iBgXTUuTGybAwKRemGeRnPEW/FcI2BMuBhaNToOE1VPCkUpNCfTIg25tDqqzS2/TPmaKDVCxAaQEk5uuBKa5p2I+qOcni7xR/inyKvYTuSd1xbc3og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686506; c=relaxed/simple;
	bh=sbGHHFlpL9YsBX0ez9GGxxHfkJj/rAi+BMHy4PFypsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBuLB1eq1WHZjPMUfcIkknvuKMgp09uOnaqvC37Ocek+++U0lg07NYNROPsIjJwkrtj5cUP4HOezbISGFR30BPzGDG9o3zeNk5BdycRaWEtKIqlyKUKF/GF5wd4H5wAe80hwsD+QKTk/zfult5nesAFiARsW8h7dVClxxHHyAEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h2QPffnU; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516dc51bb72so4184224e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 11:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712686503; x=1713291303; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ewKuaTnqHSwqnUjo+3mcr8T+Gr8KjmBfRFfdV1X9/cs=;
        b=h2QPffnU4p0hdlw2SV9+Q/qxKeKqyS49C15EkolHbff2M60yiShEqstq7aJlbRQTnM
         iKi1PMQkJBYqxH0DXqAP5V+rfo0e020+yNJDi86/j72AScn4VSMrHVpqYuCLDKny50vc
         l2C+PPxqoZL72Hnkrn/22vrn0jDHssrmeORO66wfDNW6w9yuqMI/8dTM3Kac+fndbodH
         yRn3y9S21WNx/HTYN29GkeITmZeXTI4cUch0ilKKhOEu2BBVdqX61/aLYmow8utehWVW
         hr33CoaX6A+BW5jxJZuYsLye/TDpc1hKTw7lkBqZbLGenx8pw9usiv6fBB/JPl29eWLu
         7bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712686503; x=1713291303;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewKuaTnqHSwqnUjo+3mcr8T+Gr8KjmBfRFfdV1X9/cs=;
        b=pUvcKdNfk8nLQgVPgEjqtViEvdzw0/ppXOSVkVxwAtayIUlPnWm3+Irs09F5fzf/NL
         r7Apneq7tFSBT1AOmOJjjCf8B1OCa01ZWjJ6PskdQkZsHv2x9cksH6LBMZme8Hu7VAun
         qu+HBnnPsQ7IEdAJre8g0pilkH5HA+yvpD/B5uxoa3sEnYtVLeAVpK+PjJKJA08wOvPb
         m/8fOIpU/73oZs69Xxp3d7cGpwYQkI3yYxVjXUhUKZ5Gc3XkbUgUJWiqCVhaN89xfJZ2
         m0agwk7lbhMTAEGRY8ZOdqC3kv2wRYa0kkOkwt0wb507oTglfySIFBTnZn17qtg85BbO
         CpIA==
X-Forwarded-Encrypted: i=1; AJvYcCXSWYYJcMG4vq45Y+l2iUxCAeFFhvtH1aWlN9XfDI6C47ClADtjess7rNmSlFhzfuV6gRlzrgMnF+PcjZYLY5GTZsB6CYwGdmmx0Xk2
X-Gm-Message-State: AOJu0YyMNewcq2OJNoFcqzLbsMMC/ipbq03RT73uIPfH7W+t9wdhL4mF
	JZl/DzEslLLw5QirUhbndVRNtxkmXgiCznOO9oC6NI1/fGanI7/uCyzQeN2vY8k=
X-Google-Smtp-Source: AGHT+IHOKBwRqaPV0hoQ1y6C/IX+BnMAettrHDxj6xlDe+g9x3LGTn5SnxAhCQ1SAG+5VeqE77F9qw==
X-Received: by 2002:ac2:494b:0:b0:515:9783:938d with SMTP id o11-20020ac2494b000000b005159783938dmr126302lfi.63.1712686502552;
        Tue, 09 Apr 2024 11:15:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id b22-20020ac25636000000b00516d30a8d61sm1584192lff.67.2024.04.09.11.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 11:15:02 -0700 (PDT)
Date: Tue, 9 Apr 2024 21:15:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/6] drm/msm/adreno: Allow specifying default speedbin
 value
Message-ID: <x4sgmdodoacsu6culbjjsw52ucaylpqj2ll6tkeppllzhfqiqn@lysclxogvcfq>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
 <20240405-topic-smem_speedbin-v1-3-ce2b864251b1@linaro.org>
 <pncr7ecf4eir36skul3iwt2nf5bpuwd5zjfzzfwwnxjwe4hoes@6z2xe54crijp>
 <d8a2ef87-f29e-4bdb-a9b8-591b8bd5d2b2@linaro.org>
 <tkcbl2iwcy3feoggbk737gx32qsxe5p4ad6lfrujy2pazccrhm@kif3guuzay6h>
 <CAF6AEGsg2xCCC27t_Gqu=MMQ6tckVw=Zj90p4x7EuOm+VKA=ig@mail.gmail.com>
 <quil2y6tbilihgont2xekay4joxgnsanu3khgo77omtwkolslp@ozuaajpv5uon>
 <b77a3161-9a18-4523-8528-31c2f2f4f476@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b77a3161-9a18-4523-8528-31c2f2f4f476@linaro.org>

On Tue, Apr 09, 2024 at 08:07:56PM +0200, Konrad Dybcio wrote:
> 
> 
> On 4/9/24 20:04, Dmitry Baryshkov wrote:
> > On Tue, Apr 09, 2024 at 10:12:00AM -0700, Rob Clark wrote:
> > > On Tue, Apr 9, 2024 at 8:23 AM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > > 
> > > > On Tue, Apr 09, 2024 at 05:12:46PM +0200, Konrad Dybcio wrote:
> > > > > 
> > > > > 
> > > > > On 4/6/24 04:56, Dmitry Baryshkov wrote:
> > > > > > On Fri, Apr 05, 2024 at 10:41:31AM +0200, Konrad Dybcio wrote:
> > > > > > > From: Neil Armstrong <neil.armstrong@linaro.org>
> > > > > > > 
> > > > > > > Usually, speedbin 0 is the "super SKU", a.k.a the one which can clock
> > > > > > > the highest. Falling back to it when things go wrong is largely
> > > > > > > suboptimal, as more often than not, the top frequencies are not
> > > > > > > supposed to work on other bins.
> > > > > > 
> > > > > > Isn't it better to just return an error here instead of trying to guess
> > > > > > which speedbin to use?
> > > > > 
> > > > > Not sure. I'd rather better compatibility for e.g. booting up a new
> > > > > laptop with just dt.
> > > > 
> > > > New speedbin can have lower max speed, so by attempting to run it at
> > > > higher freq you might be breaking it.
> > > 
> > > Usually there are some OPPs in common to all speedbins, so picking a
> > > freq from that set would seem like the safe thing to do
> > 
> > Well, the issue is about an uknown speed bin. So in theory we know
> > nothing about the set of speeds itsupports. My point is that we should
> > simplfy fail in such case.
> 
> Or we could allow e.g. the lowest frequency (or 2) which if often shared
> across the board to work, giving a compromise between OOBE and sanity

That's also an option. But we should not be using existing speed table for
the unknown bin.

-- 
With best wishes
Dmitry

