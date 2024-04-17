Return-Path: <linux-kernel+bounces-149330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7E68A8FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4932838FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCCB86642;
	Wed, 17 Apr 2024 23:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wLiMXiYf"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA5986634
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713397773; cv=none; b=Zlla8a4AJTLriVRFOGnJUhddE9NEcnAD2AXici8DuJu9LF51LRVkEHXnB3dhnR+1+npOe5lQ/yPA4WU46tgBWCJOe0I+LjSr5mAs+vTbjUrxy2TXau4nAIdeyMEMthJ40ZhxUuOIXhwrEwNA+kVdatNkk1Fle2WRJ0nh7bwSbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713397773; c=relaxed/simple;
	bh=tlqRCKx02DY699x9+WjnG6mz6EwDvyHTPJ2Fyqrda4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bl0wti2XNja8L8nDUnoyxX8W+4flXyxy5R6unnmX87WEgOAolzUm8AGhGqv6bLnpPUUammhFiSG0B+oo2JclpTLTxsNRqKBO5N/GOq6A9FcaHSiyi1AFhYzRmWAJMiePIiS8BLLZKhQL6Ybe+1EvdfssOHjXRbeGZJfLyfc16d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wLiMXiYf; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2db13ca0363so4583311fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713397770; x=1714002570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IDyTmfUTB48zbrRJ3Ex/J4eaqhXRSOEtnoHY2dxsblE=;
        b=wLiMXiYf2b7jVK60Y4Xk80xrnrYpwkFRF0QRtTjIJNbCiiCKCis7dGA2A0n8h7nETZ
         blrDyIZY3JqybtERQzTtW0YSC9c/izXJ5D7rkDOY703lOOTW7Jz9uqnNK7WNRnuLJ5l+
         GlB4LsRojZIL4jCYaaIUHJxKPBAIJ91maa19rJRqPSl9FI45t3QUxKdJmzhLy2a0eOk0
         o0uUKEWByurYKGjpO0CsdeDeWOXrmQDSaJh75SeDX6eRFEld18hy3JNyyW/ZWKpurNx/
         w29kBDCOFmTeDu2VqWVSPbYmx0G7iVWdxR5IM1Hif93/U/tSZkHwVXvFmT2vuEEOYNho
         L/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713397770; x=1714002570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDyTmfUTB48zbrRJ3Ex/J4eaqhXRSOEtnoHY2dxsblE=;
        b=qJaQN9x1jocAPA4ti8NPNB0L7NVzyAvo2aYvOyS6jD9FIYUBxSG6JllRRAqkjp2bzp
         jIA2QSGm/cS01aaQ0ZvQGt6ntNKtzF9JSiF3B8UtllmkeLGMPFI1lXNKLHNfDsBPqOfm
         G8qsyooy1iQhVcCnpM7AVMKpRmq6XchWJ9xN273fuy698BIwL5E8wJ7TPbt/RXtNgsav
         7wPpzoHm6F7ZqLcc7+6h31xjfNaDGpIOVdlyfcKXvkbrqVhpSq8VvzmAwM4E5IpqPc2s
         hAQVjbLD7fjzTZj1obWlJRg4pgh2JhbivyLpGPnK2/TYoTL/5cv7eGdgFjMoHeMHGWmV
         TO+g==
X-Forwarded-Encrypted: i=1; AJvYcCU1Amv5I8EAhuJqTddmapOk22/fNX4x8YGWvvYA/oCmvXvrcGSnvWK69dOnOq9zNrQybc5kUBQL0TrCjJVFx6D0BowRKqco8YWlS98a
X-Gm-Message-State: AOJu0YzwCA6S+1iX6ph9YNlUiwesxe1sNfB9V/6VSly9P6Mslrtc8l/O
	LkKNyOU9XEOveIo5xdHfX31N1MBeq4N9m7vuILPs+eBIovCUIKgohls8+XrWVsI=
X-Google-Smtp-Source: AGHT+IH/MUOBgyPCemAoyY2nfZkjc3UXoMr2/x45ATSbPEjenP4BTGIPiOlkgeZVrWhJMW0EEXYW4w==
X-Received: by 2002:a05:651c:50c:b0:2d4:6893:24e1 with SMTP id o12-20020a05651c050c00b002d4689324e1mr536858ljp.50.1713397770075;
        Wed, 17 Apr 2024 16:49:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id e21-20020a2ea555000000b002d70a040f21sm35241ljn.91.2024.04.17.16.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 16:49:29 -0700 (PDT)
Date: Thu, 18 Apr 2024 02:49:28 +0300
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
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: sm8550: Wire up GPU speed bin &
 more OPPs
Message-ID: <hykql6t7xy5uajvnzbslagrki6xvg3mjuba5hpjha36ue5ra76@4s3m2vsbxjav>
References: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
 <20240404-topic-smem_speedbin-v2-7-c84f820b7e5b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-topic-smem_speedbin-v2-7-c84f820b7e5b@linaro.org>

On Wed, Apr 17, 2024 at 10:02:59PM +0200, Konrad Dybcio wrote:
> Add the speedbin masks to ensure only the desired OPPs are available on
> chips of a given bin.
> 
> Using this, add the binned 719 MHz OPP and the non-binned 124.8 MHz.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

