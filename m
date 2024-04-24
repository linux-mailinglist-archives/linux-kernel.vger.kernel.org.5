Return-Path: <linux-kernel+bounces-156439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EF48B02CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C377285F37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1CA158214;
	Wed, 24 Apr 2024 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IvejT8SP"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A858313B5A6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941999; cv=none; b=RP0ZkSXx3MATB/hysl1q0F1knPWSbD+TMtqZhX+7wRNsLTH/qCdvW2VfrbJRzRN7WxzR0qnnCqVre+ig9INdD8kM0BkCEHZPVZbqQUYvVOtv4c0fPs/GsQuKe9sDvWbumZX56TzT7haAhJQOi337dAofQxePneki8zPkKO1+mFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941999; c=relaxed/simple;
	bh=T8G5bftwHgcq0krsmbTKFhkq434fBmVmDiqpXS6guPc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VT5lNDsZdXyjPTDt9cSJnulPDZqcZnvYj+KslBTnj82dGQ2Z0co68k6uQrHkfVL077VssJxfNXx+6Q9TtzUEGAcUbma4+QI3qOwH8ixVGDAy6Q4cYTdSTS7jqS6id/iAJtwmX2SYxXBJeZP/C1/xINCq7w+ratsUkLIXUSujbp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IvejT8SP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a0979b9aeso27390485e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713941996; x=1714546796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPFwbO4h6jzZBM5axWH60HSLI0y3GLCj69yTQhf1Lwc=;
        b=IvejT8SPwFk41B6tiB1sAQmDJmewp28rQSHxK9JV4KT238kDNIIKHD/UbMucVesrTe
         eBDw6hYfeQas2HDGWJSn1ihSYKcDHFURMXWtG1Lm/mESxywBqIWXBbLKMcFJuXsnlg6k
         jh9iV4LT5fQGm4Eh2mXwHoDoQ1QlFJ564rWhUHdGTX9aw5bnpus+yBV8IYala/VdDfZL
         GGkNnDcxuJNYMCkCer+SDJMegZucdzy4B+i2IjZIfsuPVX0Kn2/3GXuoEO9mJzYajJcO
         ApwTOo7oyV5ZgVjXEvuZoUYd1odZyStxwxYNsR33g7FuYmIEn7/3f3cK+zRahhWeLR+E
         giBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941996; x=1714546796;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPFwbO4h6jzZBM5axWH60HSLI0y3GLCj69yTQhf1Lwc=;
        b=Q+Fm7CE54PeTFn4Q85eAxQzr6hVIxpP/1910uZFtDFAHX45lAnF8uBZ64q8yfYTlr7
         MIn+aRNYUQarfR+8+soahT+n4T3HEMgAVgmv3wJKZ/SqQ+Yv2MC0vjsrGOKvsKmSDze/
         SrLOtYv3KJzj+S82QwiDQhlFFQsuUkZM7hnZIwK/JJdBW+gbXKyqemTtpKEdxCLu/oMa
         rqnwtGYktGGBD73VvIBoDzyiaElpP+hKonguIfSDaQIJz74u9p+3la0YGSjd5InmY2pR
         Z7zxc7isIQlSGY+KP4uEF+CJu49aVVj9LMFA26FvAwQQleAHuXNmcflLGNDDwQUyFwgC
         5P6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWL/3fbNFKY3Ap+SRj45jZHXADUHYXPsPfcmlPOagKped/Qs7EW/Us7kTe8jXb8PfM9y8CVp4nj+oGX/WmmTRktD4pDT3DB3AZX8rTW
X-Gm-Message-State: AOJu0YxvsJwOklLEuaFIiZZOThbiE58sFLcdACG5N8TJ7c8o38OZ4m+s
	2yik9g5kS7sR5QNFjeYjvjWL+6lpjphYHFj18eJjMwUbkQ7fMljA7856Hry2x1M=
X-Google-Smtp-Source: AGHT+IHE7xlJLAL51oWENP3DMTrQpY2csVQxTK9xxwJMvq7ioVE9w7534flnkEPfl3NdW6hNie0/Ug==
X-Received: by 2002:a05:600c:358b:b0:418:ec7a:4493 with SMTP id p11-20020a05600c358b00b00418ec7a4493mr1452481wmq.12.1713941995771;
        Tue, 23 Apr 2024 23:59:55 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b004186c58a9b5sm22465392wmb.44.2024.04.23.23.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 23:59:55 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 y.oudjana@protonmail.com
In-Reply-To: <20240423-jdi-fix-v1-1-808970662b40@gmail.com>
References: <20240423-jdi-fix-v1-1-808970662b40@gmail.com>
Subject: Re: [PATCH] drm/panel: jdi-fhd-r63452: make use of
 prepare_prev_first
Message-Id: <171394199490.1308236.12321198986126755514.b4-ty@linaro.org>
Date: Wed, 24 Apr 2024 08:59:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

Hi,

On Tue, 23 Apr 2024 22:54:33 +0200, Barnabás Czémán wrote:
> The DSI host must be enabled for the panel to be initialized in
> prepare(). Set the prepare_prev_first flag to guarantee this.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: jdi-fhd-r63452: make use of prepare_prev_first
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/4edd73d174de5e8ec43f0de303f4a8b80e643529

-- 
Neil


