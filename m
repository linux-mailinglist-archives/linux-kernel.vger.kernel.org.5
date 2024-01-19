Return-Path: <linux-kernel+bounces-31140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCDA83299F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CE8285A04
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187D251C33;
	Fri, 19 Jan 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+9ePfNv"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A5A4F1F0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705668116; cv=none; b=pUMKQMCcjg6TVe1Wid4WgEXxs9RxvQbgOHN10DEooerNhJpuqPWm7Rll7M5lajwPle3UA+evXX9yW/M4AHF2LKGBzxAiexXkokBgrMcN4/FqX9P8vHJhCcpkam6cVZvGq4++yL/6dveVeaM8n/+xChtBRd0QOjIEzzeQN2u8nk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705668116; c=relaxed/simple;
	bh=2cb5Al6biJuuZyVOrVmyIzVVgdjZLf1RVBZLRdAK/Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rr0LGniz5gNoqR4aQD8f68M9+asgRqKSYtQPZ6wtH5+43u7TWCq48bI7IfQLeermnX3c0ZaBfgNihN/UN/E2y/kWdJUPNwXNkJsE2h5ElnwJx9hPGb+zUY15IfCxCiof5RNe9oIG63nKloPcm3vG8HtRhQsENMsW5v2BWUVbFfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t+9ePfNv; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ff9ba70977so6717857b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 04:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705668114; x=1706272914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=23vuA1+7BgcGfSlqZ4nH0qFr70mqNSgh0bqFZoyYKpg=;
        b=t+9ePfNvhYNx+/khQCkZFXtSyaj07YyMRs3M82d2NLreYcHORg+GSVl1gglcBWI3Qg
         hBrtPfqOf+Uq7pnx6Gp6gTDBMdlynUfC91pqFwVXhNJ/nKtVMJzbLh8WOJk9dILc2vp9
         Y5V8LRSpFMBYuCZP3otygBUq+LyE/iTHJBADqPOkTrdH0UaCO3DQAyvg2MKs3LFvbARj
         foxbv6Ym+jBpABfIHCk6ydxv678vg8wsR8lUWkYgZuGarMZtXFUcDsOJ2qAp9fXfrOE4
         vnpnQOGHLSbsgMu1mhy7vcYjfaoBpULeedxFhWZT7cGvLG9ustKBHp2Hq9bomkkDE4cI
         /4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705668114; x=1706272914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23vuA1+7BgcGfSlqZ4nH0qFr70mqNSgh0bqFZoyYKpg=;
        b=KojVaFTa4wlytTv5CpPmrQ8WOUKr9H5bRImbQUrBblwUll1tkTR33GlU0o5ikW4QkX
         1GOMYuqLM0cBD1jH0rgS1aQzgEJgGJSCG8wpzJpVfOM6cGgixT2SxP6walhmrO4IAIxS
         FQ0+rM5ugptZcPbisTlGMXk71kV0hB6T6swckIePfeoZWCVvkQ+lb5/mJzh+1e/H24G6
         lfeJz0DTYveJzlCPKbjHa9T0lMXrgV/E3IUigwusUEOE07NuKwUNyi3nyNj+BIdlqjne
         2XLjjN1Wg90WpGlS/0g1iC1qp4ayanG5N/CR/kMhHqIJJFFmu/R+kXuIjKMFCJPnvdqd
         nLkA==
X-Gm-Message-State: AOJu0Yx3zxHA5XfX7RN2zu2tpMEZhk4fvE7t74iRGN1wLc3BsXhNA5CR
	QgCJyHoIeD3SnDgNNSLIssNc8QFg/FZDQehcr/kxs5QyvUlCadEpdYXHeXNMW0+q+mkN/Jl8jEg
	a9BuppXqo9niS51t0KRx7L8Z+g0qZiLuHSpdwBw==
X-Google-Smtp-Source: AGHT+IGXaB/Qo5C8K/AVwVpt0k+i3/3nYM44JB7FzXsWZairbE64gJOEa8s/VJ7iEick4vjqREgSJWa6nU4h2xbXln0=
X-Received: by 2002:a0d:df17:0:b0:5ff:7cca:a434 with SMTP id
 i23-20020a0ddf17000000b005ff7ccaa434mr2084545ywe.51.1705668113943; Fri, 19
 Jan 2024 04:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705526010-597-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1705526010-597-1-git-send-email-quic_khsieh@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 19 Jan 2024 14:41:43 +0200
Message-ID: <CAA8EJpqm5KW_UOkvV1JhX+LEh_e8bo549NNQ1AgAXMZ=ZPVCOA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dp: return correct Colorimetry for
 DP_TEST_DYNAMIC_RANGE_CEA case
To: Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, robdclark@gmail.com, sean@poorly.run, 
	swboyd@chromium.org, dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch, 
	airlied@gmail.com, agross@kernel.org, andersson@kernel.org, 
	quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com, 
	quic_sbillaka@quicinc.com, marijn.suijten@somainline.org, 
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 23:13, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> MSA MISC0 bit 1 to 7 contains Colorimetry Indicator Field.
> dp_link_get_colorimetry_config() returns wrong colorimetry value
> in the DP_TEST_DYNAMIC_RANGE_CEA case in the current implementation.
> Hence fix this problem by having dp_link_get_colorimetry_config()
> return defined CEA RGB colorimetry value in the case of
> DP_TEST_DYNAMIC_RANGE_CEA.
>
> Changes in V2:
> -- drop retrieving colorimetry from colorspace
> -- drop dr = link->dp_link.test_video.test_dyn_range assignment
>
> Changes in V3:
> -- move defined MISCr0a Colorimetry vale to dp_reg.h
> -- rewording commit title
> -- rewording commit text to more precise describe this patch
>
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_link.c | 12 +++++++-----
>  drivers/gpu/drm/msm/dp/dp_reg.h  |  3 +++
>  2 files changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

