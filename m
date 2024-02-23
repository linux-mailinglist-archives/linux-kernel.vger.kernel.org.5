Return-Path: <linux-kernel+bounces-79207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B94A861EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AEB51F266D4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143A11493A5;
	Fri, 23 Feb 2024 21:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hv4K9X47"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44E1493A2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723474; cv=none; b=dUy+izfEG1fdt1hWG/9Cr+dZH7Pyecg8DWThveQmIom/qr7NDjnfVBNKefXZLCZl2iMmeKWmRVj9CEtJGIGFzzLFFegNHFugUB4u5eJsp6V2SSzwQDyhZL1M32Y2fUkAx4JdCaC4hV+B5jfENK7OCpjG/U3MyscZwFwOjAeikYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723474; c=relaxed/simple;
	bh=H/tJhqv8w47L674SEcvyX50L+C3QiQZtQ8jkIBC/B54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+KUWtZzVaxiIdXOS2fN5TCTeKrelMmZ1/086jppL56oUauiPaWICezw+KRm8pY3xFVGF4+hM2cszgLJzaNH2QpE9F6wdXsRHOBP/ujKJUOVa9VrQRyVzT+nYQSkDHEg6X282otrqNqs0XdomeoGH1bX3DFp+FFmtUGlzRCzjjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hv4K9X47; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso1298172276.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708723471; x=1709328271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=akuPkkgI0y/oHinOKr0HxoZmwUf171P0m6vGM5/O5Js=;
        b=hv4K9X47aldLnHaFXYeYX2ZhiYjXGK1bQUZFnv8mm+NWj72tgPiNw7CJllytkU3wSj
         17U9T+RadYGszAvbjVFGZbrHC+I6a3IUsk8RD+JXljHi8gv7abpXm8SoD+i3MofH9Wdc
         Zt51DLzfpXIR0tU/AWRMUeRqJfCXkNH56TtM4Cd1myobOEBqG73he4W1UPR1YtwSFgq4
         UrPdkJB4qLOlc/1RK/u8cte1x92bj7K7cX7WTovIvXSV3sh0zCId/aVaIOXEL7cQl95w
         mRfIA2n2ZXJXDfVCo79FcCjMm9giiequxNZGsmn2DeOHfHdjFTynQYs4zZ2D4rQdppe/
         akig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723471; x=1709328271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akuPkkgI0y/oHinOKr0HxoZmwUf171P0m6vGM5/O5Js=;
        b=sn65gdEkjYr8NaX8Woe7wkfPdKVmbjZ7Nvah7c76wy3xHIYIJsHxR5GedzCHeon/jJ
         FhdBvbYXSl5qkw4BLbjpfUVqHr2mXWCfu5mBTNN+6dbejHnDiqztT/7kYKntvpnvXK9W
         bmUEAzwNR7NBUxMWwWRbDHqT9iLIL9JbuJ51pmbk4k+KluLZ7ldGaJqvm0Hgu30QA4ZS
         WlEj6CHp0LRboLDssQYGzSDQVbUZV/I1US2Rf9dqL6PdUFItuBOu385Z/mKybaIDR6gU
         6I+7XGhLBPWgy1rYlhbyywJIQFpY0wJXyBjGzrOEh+fN5qtWkpn7zXryjlO0BGbop0xB
         hTcA==
X-Forwarded-Encrypted: i=1; AJvYcCVfNKZOwtEeErxabsWWQA17pb2yWOXwzQKF69s8Lq8F6OYe1nIhW+kRYCl3di422NbetslpxfaexTm+BY1ToEayldgb+o1jfIi0en63
X-Gm-Message-State: AOJu0YzctnJdvgsANsq9ov4yGBk3Yl5HtVWC13/52HqD+lc48iGhW+Se
	vOdTXf7oGxWUqbEVKuojWaFWRxTXckiBini745tMo5ReIZT2SDUV8KL674Gre5B8nUMH4KZaPTG
	2uUiERB3RbaQksmIV9ilS7Rsk0VFxax7FPcdzYA==
X-Google-Smtp-Source: AGHT+IFbG9R3qzPDyULutJwOdT2KkYVwoLnuTNnZQAQUOT10IOJuFq9jx8p8pvPNgR7Ok5iVzV0j+sTC9nwDRCxlZ88=
X-Received: by 2002:a25:c511:0:b0:db9:9537:2c39 with SMTP id
 v17-20020a25c511000000b00db995372c39mr1121626ybe.2.1708723471023; Fri, 23 Feb
 2024 13:24:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org> <20240219-topic-rb1_gpu-v2-2-2d3d6a0db040@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v2-2-2d3d6a0db040@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 23 Feb 2024 23:24:19 +0200
Message-ID: <CAA8EJprR=tPUsFit7DEzh0U9TDOm8TY29m=JVJwXQwH6vEN49A@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] clk: qcom: clk-alpha-pll: Add HUAYRA_2290 support
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
> Commit 134b55b7e19f ("clk: qcom: support Huayra type Alpha PLL")
> introduced an entry to the alpha offsets array, but diving into QCM2290
> downstream and some documentation, it turned out that the name Huayra
> apparently has been used quite liberally across many chips, even with
> noticeably different hardware.
>
> Introduce another set of offsets and a new configure function for the
> Huayra PLL found on QCM2290. This is required e.g. for the consumers
> of GPUCC_PLL0 to properly start.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 47 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/clk-alpha-pll.h |  3 +++
>  2 files changed, 50 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

