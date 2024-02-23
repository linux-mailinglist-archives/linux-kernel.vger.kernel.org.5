Return-Path: <linux-kernel+bounces-79208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17CB861EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE052853BF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A530E149395;
	Fri, 23 Feb 2024 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vct6CQRT"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C19149382
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723497; cv=none; b=OlTF6KxN3vQ6MDPhWhY5LPKw5ActTL86iqnEIRUp0xUvU1GR9tO5qTmcX5ilSsazUV8j/+9SNWEkINiwLU2/3hPVDPU8e+PZtGncdTRzesKH5yXqjozXB52vb+fbtzABMdRAQ9HIsg3F7pUMR16LYrlWox6/ErrobQtmyYpYuBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723497; c=relaxed/simple;
	bh=FvyHoKuJyRa2YSuYvwYb58L/t6J6cqmjt53b8ta4lpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVKlUVp20/TL1G1Kp8HQ9v+GFs1Eolp10NRXjLq0SOKdZTUP39YHz84pyIvQ/kLjTZQK0P0vQkLqZwp+1DDjiP5Wc22d3ew4N+xB7n2oNp7Uj1WXuSPZ0xZSQ+t1fm1wAsl+0EmVHERjQqidbFCwEzcmlZ7NI6QaaO+izwYVIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vct6CQRT; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-608cba5507aso6380147b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708723493; x=1709328293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wgdv/OJ7jeihH3J71yo7/tj9HKsPe0FnbUozf7yDTNQ=;
        b=Vct6CQRTBzWbruPsv5t+6DPHxnvlQZ8kApu6H0jleKJOC6lNp3ZwC8N0L57nqWIWUb
         JVveM4muy5iQLwSjqxKMNTYbF8imUTBAgtvYFis8BrPcjD/Cr7F19HjcWVPtkTO0MdUM
         0R7lmYvZiyN7d8P3zB6BcRmS+QD1UC8kkOxLb9vL3OPFkwMEoTRGUIDF/yfPzj9OqGT8
         hNQdXAxg8Qjj6Csd9CvwTp8+Fd6DqsjfFKV1pdSn1w0N3S0ytb2Q9RCswO+gnfuNdf1a
         OvsccS55TvJ62OaKlSJJEIsGxeH5gyW405XtEwmGKhYGw/VrNY6MBb7LaaJABzfa0maP
         W4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723493; x=1709328293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgdv/OJ7jeihH3J71yo7/tj9HKsPe0FnbUozf7yDTNQ=;
        b=S2FbjTUnArP51uLiXXawlXlp1Yvs1rwqIKdJGUu/jfpQlYil2aQmzzJBnWq7nX/IcJ
         DsvccqxHiSigDtnrj+WC3oK40JmpwD0XlnHdfgBF7w0tzdRDryrsdyxrQhcS9dC4tZRf
         otXN117RJ+DECXeVZ7x0k8jyc7ur6i+k6uNjwpcQcFptqkvOROZZoNNVG3Nbb+YNWPJR
         NGB/kPbwJBjmlwUtQ3Eyck+XwOg7hwf7/GofZ6Q/UIFeI/bCvUVAx8HYRuEO2zcYq6kD
         ojKjVzP+1seEX/d/DCihiRz4v+/1PUYdZZfpfKT4z/scG4wN9bsIcJi/mezKKlTV2sqD
         ruEA==
X-Forwarded-Encrypted: i=1; AJvYcCWRZ1A0iBvyXs9PW+aUE/2cIe2WjjrQAdB4V9ADbr8U6bWr8BG3ltQQG6mJ96O1k9gvkjZT50GpHNdqiowBnYe5lbuLFeSgSagVFGDo
X-Gm-Message-State: AOJu0YwwtkI317BIsAkeajb46X7Pj7anLIs8mvUPevxoqijpIgjJciDR
	HTQacIeTiYUnqTDFAhym8rVfcK+hSPg6SVvjg1rjGwzhOmLZ1NkuFDP0vnumbyqC9uWlTXkiC9M
	7XO0WIEDDwacblLlzeCW5aZBSpn0mDBdDmYOS9Q==
X-Google-Smtp-Source: AGHT+IFMmUBgDbCE2Q2G9lsAmZpvVhtEQwvP+lU1HPMuQilfEiaGC1y+Wv7lhCQH4132jTFroLi4zQTtEiwxKXXZKTw=
X-Received: by 2002:a25:3082:0:b0:dc6:c2b2:c039 with SMTP id
 w124-20020a253082000000b00dc6c2b2c039mr998519ybw.41.1708723493452; Fri, 23
 Feb 2024 13:24:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org> <20240219-topic-rb1_gpu-v2-4-2d3d6a0db040@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v2-4-2d3d6a0db040@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 23 Feb 2024 23:24:42 +0200
Message-ID: <CAA8EJpqnAoCDer93V34BaFHf5mhiNOFMQTP1Xaeoio0BWaPzhA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] drm/msm/adreno: Add missing defines for A702
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 23:21, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Add some defines required for A702. Can be substituted with a header
> sync after merging mesa!27665 [1].
>
> [1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27665
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx.xml.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

