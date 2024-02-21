Return-Path: <linux-kernel+bounces-75676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DBB85ED44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDE4282B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B79712AAE0;
	Wed, 21 Feb 2024 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ra/5B1wO"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03983127B70
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558998; cv=none; b=YK1EJTg4CFN/omUJ9iJHJ2wH1r5gQaO+ILvM+D/W9B+xepMTiycKEt9068R7LbbvbaN5XAoStsf65fBwaBGRyrnInNE5bgiiPYs8vlxuRVAmbK50MlA88NN7b78axv2zbrXxyubY/rSnRejfF3KvcnZYXsgxDUkRpbT4aHGzWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558998; c=relaxed/simple;
	bh=/YFr+KKxijw6h0HemmOAPDT4OuqNlZU/nP9qnoL9f6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7bIG4tMGcHWvXeMJcBEhfXafmTb2/MmF5hVxfumyUN4MKIcYZI2tHxZFjpCzt23TlyIRhAHwMZZUG8zDF94ZofUCVRlbkj1ipNRIA3pVvyYDp397PqEI7TyQuhd0RSEw4lAol4ep2+5i+v3ql4DFkQi+4rSNbnz+R/TLR4hVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ra/5B1wO; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso8016905276.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708558996; x=1709163796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WFR+rdCdcNXgjwmjuY7WFWRvujdikiPSr9iXFhu+1EA=;
        b=ra/5B1wOIxcFhFIfRjZTmBFm+29T76Z7c9GwqjaHS1c0xFdKvdu3bf2rg1NMCBRV9U
         Q2AElrKtsgfU/eXNv9RhDkIYQPBnrcrvL8XhLy2RgyrC0hRjI6+YpgAJbRmpkMSM0e7b
         wUGGw1Jx0Yfps9rYYfy6rh8yBrsdyC+uHY/uaKsIS/0M3FsnbgqJf8AXvV6rvuwqAqMQ
         ubK2yOQukVQsPKZzbeXtHp/iVWd01UCdglzPS3au2V+gWN1RJabDwmL1VPJFiMTLqRSA
         a0AkV1RT985UOBJWxwvxwXcDsavE8By8M1bYnPEBu+an4mqp7EdkW87i2KGnQvLI/nv6
         Gufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708558996; x=1709163796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFR+rdCdcNXgjwmjuY7WFWRvujdikiPSr9iXFhu+1EA=;
        b=PCVm9ycgmJF6615JuCHClAmqRjGhJSdei2p5xIjQ4CCvnXsbkza+oef7q9P83/g+L8
         cWOLNdNmkZeT8Hs0AD1aIZxH+94KaK3VQVmwcpR0xffxMMkbPiJFC6GAxrUy9zCGPfoG
         3Z6BuBck2qXvyqWlv/8IEkjhcvxii64XbeJ1CYERF7513iEfuslvGwpK/RYMfZe0rlJ3
         37nTTB1eVF1fQKpGDKzOh1zVRVIWQXjdTaVVND8La1Nc6hnw4rIAxUIx03KYDPnc/gXu
         bU9Ey3NfcHVVY+OdGgRAueU0HHsxdhh6qPJklGiLrO5ZombZ7n3yK3SRT4VcTKPLpPwS
         c8Sw==
X-Forwarded-Encrypted: i=1; AJvYcCW3h2GDcrjmDrTENQAZWQARDQD3qz/uOfRMVh95qltMNsI9ZqPSbBgMVVtyQseP/O3hwNUKS5o/0Z9jFfYfvj1NlHcqV5IibBlCoZ9u
X-Gm-Message-State: AOJu0YzTM3/0klWS1M/2OLGEJ5/e1/GvmUjNPdSr/HMzHuRis6WqtZsK
	Ksaq9rz7GU6W2k8wME/i+mmrkyILDiaFg8Sf1ldUa+pJi/MGnPOxNjDSdPC1wQl6w5pW9y3Aj6v
	UOl+obwWYxkdG6htThiRufhykr5u2Z+/v+EAcCw==
X-Google-Smtp-Source: AGHT+IFjJBtN7MtXNcf/QQ3e4+26sEK2XOSpTmqDfd6w2TNPck5yPGYCu8CgXttPPvLLkfQppUj/9j3CGsKu8RzEuYE=
X-Received: by 2002:a25:b1a0:0:b0:dcc:693e:b396 with SMTP id
 h32-20020a25b1a0000000b00dcc693eb396mr916615ybj.2.1708558995841; Wed, 21 Feb
 2024 15:43:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com> <20240221-rb3gen2-dp-connector-v1-2-dc0964ef7d96@quicinc.com>
In-Reply-To: <20240221-rb3gen2-dp-connector-v1-2-dc0964ef7d96@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 22 Feb 2024 01:43:04 +0200
Message-ID: <CAA8EJppPM9M0Jsb=GtqE4sdzWsKewEwkgKtF=Kb+n0tXZNSHkA@mail.gmail.com>
Subject: Re: [PATCH 2/9] arm64: dts: qcom: sc7280: Make eDP/DP controller
 default DP
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 01:19, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> The newly introduced mechanism for selecting eDP mode allow us to make a
> DisplayPort controller operate in eDP mode, but not the other way
> around. The qcom,sc7280-edp compatible is obviously tied to eDP, so this
> would not allow us to select DisplayPort-mode.
>
> Switch the compatible of the mdss_edp instance and make it eDP for the
> SC7280 qcard.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 2 ++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi       | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

