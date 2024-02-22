Return-Path: <linux-kernel+bounces-77371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A10B86047E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4571C228B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795D012D207;
	Thu, 22 Feb 2024 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXs5O9Eh"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95F73F14
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636291; cv=none; b=gdtQ9Cg1s5dZ9U2Ib5yyxZQMiGyjylUOkisDTS9Xb5c1SKfcMnOrnMxkh3kE8qxW1kRo88DFWQtDcVBNV/ceusUCASx2wbb0/1ItP3CKC38UnuzfkCj0PE06yt/1czpAerMXc9X4iPk8FnNjuyZWMDIbidHxrQgQf8X9pkbdEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636291; c=relaxed/simple;
	bh=4lvUACcF/m/1OgHfKrNiwXVgw0JcCGJNrv4rn/OYioM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2A+CM3MRmOCNPky7CnAV/DXrVrOThkhvAj3TIYuVIO3cGnN+aVaxmAGsy577TQE9C3TUN2fovShGrgGd02LZMx0mQ31K92zxGDe4ygmZuUg2CukhsRB3K7zUHekuqHmH/FRFUq5z7fnsRgrqVywyNlwaG8FTr6K7e2mdP3WsPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bXs5O9Eh; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6087396e405so11631627b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708636289; x=1709241089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6LQ9AKd6x9Ppr8V8DrGvzfthJpW9UNBDUhPwgck2Wa8=;
        b=bXs5O9Eh4G1d2kyqAL75Bt/VkAD2I/r8E3zDy4JqWZF/nLvZxK1RL8Y8OStNn/N28r
         mx6PplzOjmTqMqr/1cLRnlRkYR8mS1fTWg9DqO22Q+2nqWjuHL1ApHPRfkIV3k09c+Rz
         0P7jFSLywAJJuXEzmDRMsmMVpjJ67EqMdeFahj0fxw+pGeG73/Wrb8H8IifwVudwOtbc
         aPRYdSxb86SRla7o8n/Lxorl3ZxbVYJjrrxZCG8Ob+pBjwYyddlGsHlcE42GZ1oamG2J
         o6wtfBfYg/weenJu3yACGn84ZiUBD4qQgfuxaaXlnUu2rkvWaRv9myGnhJ47z1Ua8/Nb
         QmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708636289; x=1709241089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LQ9AKd6x9Ppr8V8DrGvzfthJpW9UNBDUhPwgck2Wa8=;
        b=pnO8pTJGXvMA0G/7VqQytYMyiGtf+JPq11dEpgPIRox0P+7lCyXFM2pag52+DxV6Xu
         /0gxYm7qMtVTWlDJ3WW5C1VtQbe5MV+LVHKhGZ6D2324vhJ21+HJQrRj6AKWaN/URZZT
         IVx2OWc9KDAr3NGWcAAHVwrxXVgSF7ynA4y/qDneLBwruGAWHj8k4q4Ox3t2urEQTAQZ
         olWTl9rcsYR2zMCRCI9SQO9APrz1FBmRHl+xZU/VEnRPRd7k6/0oHAFNPCtNmpMrlS41
         DlHja/LoZ7tDkz4B4YMvtnDn34rnP+UUqXLtdPg2GwgqbPWmxExmgzoiBxo0aY1zWkHA
         SJ0g==
X-Forwarded-Encrypted: i=1; AJvYcCV0c6INjHXjsz+Eh/3wBwAlUy3E/YCo7aFuPG7OI1mRvKnlJskKROZhNNyFRNE9P7qoasE0rPWkjO0epXkOWW3lrP3giZZdsx8YBUXn
X-Gm-Message-State: AOJu0YyG+mXTcZ0v83Hob0eULsKyKY51rnMJodc19Kla6GjwE9ds/kPR
	iuxAMhOtUXJHQryEESHm9HG+YIvzavIlHZhuMPU4HS7oxPVUALFCHJ0N60zzm07+Wz+0ehv3A5h
	BdSG1SeZzu/DO3UIaqj8SYoWnPX8nwIDevZIPHw==
X-Google-Smtp-Source: AGHT+IGr40bVHUaWXhi2S3xmL6UJgO5Qya3+KW1Y3uj1TASqY4EfBpznUda1BUrj++1QaDRzC2B4Zta0+WKsL88FVd8=
X-Received: by 2002:a81:451a:0:b0:608:821a:15e1 with SMTP id
 s26-20020a81451a000000b00608821a15e1mr146315ywa.9.1708636289156; Thu, 22 Feb
 2024 13:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217150228.5788-1-johan+linaro@kernel.org> <20240217150228.5788-6-johan+linaro@kernel.org>
In-Reply-To: <20240217150228.5788-6-johan+linaro@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 22 Feb 2024 23:11:17 +0200
Message-ID: <CAA8EJppnHY=jDYjgTn+2dF_zmGwM9+KsUS6vOyPB_wa9W0v-UA@mail.gmail.com>
Subject: Re: [PATCH 5/6] phy: qcom-qmp-combo: fix drm bridge registration
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Vinod Koul <vkoul@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, stable@vger.kernel.org, 
	Bjorn Andersson <quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 17:03, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Due to a long-standing issue in driver core, drivers may not probe defer
> after having registered child devices to avoid triggering a probe
> deferral loop (see fbc35b45f9f6 ("Add documentation on meaning of
> -EPROBE_DEFER")).
>
> This could potentially also trigger a bug in the DRM bridge
> implementation which does not expect bridges to go away even if device
> links may avoid triggering this (when enabled).
>
> Move registration of the DRM aux bridge to after looking up clocks and
> other resources.
>
> Note that PHY creation can in theory also trigger a probe deferral when
> a 'phy' supply is used. This does not seem to affect the QMP PHY driver
> but the PHY subsystem should be reworked to address this (i.e. by
> separating initialisation and registration of the PHY).
>
> Fixes: 35921910bbd0 ("phy: qcom: qmp-combo: switch to DRM_AUX_BRIDGE")
> Fixes: 1904c3f578dc ("phy: qcom-qmp-combo: Introduce drm_bridge")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Bjorn Andersson <quic_bjorande@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

