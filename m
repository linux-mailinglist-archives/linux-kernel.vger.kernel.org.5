Return-Path: <linux-kernel+bounces-149047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28448A8AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97821F2388C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49298172BC3;
	Wed, 17 Apr 2024 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bcKr//mH"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449912F398
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378263; cv=none; b=N1OKTwjWfrMfnhcxyoMPdF4QFW7ZbkiMKJe13JIL9E/TCbwuOX9PgeayYLAVlQCN4u26lbtfuFxJ9dmyH9KQRwgsx9vdG5XZUiCtYQiLpPG0TGim2RPdh5Z4Uis9DYXm3PcXYAaBiHWZXiSZ+2TyHkJQP2uCougWKr5py1g0M58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378263; c=relaxed/simple;
	bh=Bom2TXNGEYr5lUGFhY21H+Ny60Z75gcM070ni5zqxso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iakdi5XfZHbV5e3AsHdzy9N2cYyu/YJ0uIDc4euVCLe7VxFDUGLBBvJL45H3KX8uSuQUA8CSBZW9bAc2M5GXxwQCbm2LKAiPmIrY5ldAWa2/A1L6msRaL/CUb24cm7TvwHYfUZH0dFI9OSI4acvtW8popn/zQHIfUmq1us4mjWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bcKr//mH; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dd045349d42so41625276.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713378261; x=1713983061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wbBYw3GS4uodkC9UhlGoaV3hresTIfXPy+XD31Cgwho=;
        b=bcKr//mHmqgYQTHJWVhRoDG8GG+EBllXkrn3SiOJ/vsenIVE8uhK6I9lAnK4LyEM/C
         zVC6zhkCEv4A6rKlMc1/WQmu25oxoMWYF8wf3OHnmyDajRaMfRtXqQp2OGXtmJPsbdUq
         8zRAderDSAubR9wkYmb4keNdEypDzpr6J4/j1kTGdvaGvGr4O9D2M7OAbA2bt9nvkV5Q
         UvygrHaxxm+gEK96OA8l+909EOqiffjouPNwwbyAJNC+htDm5aInNT0vt+vYapM0nh6y
         3A1wSKZvQWFoBkouwrivnstH7LiP7SOy3e6NtORxHap9/+jwc4Z/lc1CGBQzw367exes
         0lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713378261; x=1713983061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbBYw3GS4uodkC9UhlGoaV3hresTIfXPy+XD31Cgwho=;
        b=eX5NNeOsjHGgypKHT9LHwDN7JfMFlPps6hdhQk762cjv9DJ6Kat3Z7bMrb4LO9DpsQ
         LIA2Mbfsi4ZOBLqjz7N7HkGQnt/C6ND/Y0dnRvzQKJfNA10wcXj1/Nz3U9Nfqe3m4wjt
         1owrubyTexDSUfDBnJNl2nIQDV5syeF7XIc4DKxXtVi0uA16KhMWxKFTaR8P6Nx7A6Gr
         Uh7XqmM+6GWW9GSuhUcA39VfSla3IdKgqxLCtYkLBpkVYiTO2hSWm5EKmlMGPpde6YbC
         MO2LdWYbIo8XcdbvhckjQwFyEUNkdHxq+o0OjONaiU3fpGrwSVpPIuQnLKn2LoBGAccw
         ZJTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzmFdVL5J+0cpXw92uTqjCaia41CcYGNJS8OBci9gtTzZ64pAWzteN0iwm9+Md83afMFITB2FUzloqxuT+rp7WDhtSCivMt6jBfs4v
X-Gm-Message-State: AOJu0YwQfKSNo73eon8XRQIS4pyaHE2bfr7sL5ljW59NR63OP+Dv9mAp
	44X6Rb4t39T9VTQH5nfHDvr4oK4loaiArtX086Kj7z0Vwq1UtlujQ9Vp3dYdSX/KElwSKKXuycU
	4j6nx2M1rss3u66bFQYZaoFzPnT8dwXnqgsr4SQ==
X-Google-Smtp-Source: AGHT+IHHNONy71cySjy3MSKDmtVHvXqanJu+prl/oRyemyL9jS19vxHG/wWUHIq+2kERXydhw5hdws2TBl8ifZE6CeI=
X-Received: by 2002:a25:780f:0:b0:dc7:32ea:c89f with SMTP id
 t15-20020a25780f000000b00dc732eac89fmr144726ybc.15.1713378261334; Wed, 17 Apr
 2024 11:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417120928.32344-1-quic_kbajaj@quicinc.com> <20240417120928.32344-3-quic_kbajaj@quicinc.com>
In-Reply-To: <20240417120928.32344-3-quic_kbajaj@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Apr 2024 21:24:10 +0300
Message-ID: <CAA8EJpqhHDSz0iSzg5zze=caGo=-Tw1Ycy6c5ThSc+8+GHMu8A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable various remoteprocs
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, quic_tsoni@quicinc.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 15:11, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Enable the ADSP, CDSP and WPSS that are found on qcs6490-rb3gen2.
>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

