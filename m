Return-Path: <linux-kernel+bounces-9479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE481C643
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FB51C24EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FCEC8C8;
	Fri, 22 Dec 2023 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d6Y5sDHu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC9FC127
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33666fb9318so1402764f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703232634; x=1703837434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lM68vCaPXNUUDycrx+XvGL33ppz+BtAdK19lvJ8+7sw=;
        b=d6Y5sDHuqyCvrWYWxiAnUR1oz+P7orSsVe2sgqjcKNkgEysy8DYzRoZ4loy1YIW00s
         dp+TUTyEMVd4dQjNVE9xoL7RnBa63iCyv1tIImSlQRMwk8GK4M2h43DaCxuE903fFf67
         Fm0Mzdvxcmg/GmaQqvRAxoINczmQu0SrOHeQtIfe/069/rd3OGVq7myUng/x1WkPgIHH
         y0s8XRDxe4UUy5EGpwXiOKhdtB6FfxbHX4bAp4hLaLsOhzNBGX8Xs7ROP7M0W53Jynz2
         OZZcZZck/qw5YVORY1SM0eemctgWuzR7R6RDXTUcBHE0TM1OeoxtP7pRQuJMC6tUlO2m
         i7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703232634; x=1703837434;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lM68vCaPXNUUDycrx+XvGL33ppz+BtAdK19lvJ8+7sw=;
        b=JO5UgCJPcy6i2Lovm6+qQ/3M1SqF76ygR0Y7VcXsyRhYg7BylBG9CE/duRr+eYlARC
         6wFtd2JmN3Ai5eKVTBk+YHR+hkat+QTVoUHUvDNtKqEEE/6FTEcOk+I9A1jY7u5t5UjF
         j6iaD6rCTLS9Lnh1aVmeipPcAppTinkIW+Nmv2oxq2DH9dtViR3q+ccvQVVcS4bRfWuH
         DILUQjqtZ1RHQOVb06zIsteXPFQ3Bnyf48D+AjUN5mCWdXL7mG3Y8OybWr+322ZfO50+
         b9xMXveNlN2hOf0tQJDlUqbb1HZEnJxoBxv5QGvQ4UUJb0SBFxOKoi+3JIbQIaYCBYbn
         driA==
X-Gm-Message-State: AOJu0Yzw7qF9K25yqR0tED0xojnQlTaDMQCiH+xxn9sUsBELdkqDZkhC
	cGrsbpccT1mkAh4+nFpB7Ue2154Br4QhJA==
X-Google-Smtp-Source: AGHT+IEXWH54whXuzJ+v2aRaRnfaeKABy4t4cZ8sKiFBmqzByppB9AgX/JMhJXGJHk1onMtQ80/7DA==
X-Received: by 2002:a05:600c:6010:b0:40d:4a25:ee0e with SMTP id az16-20020a05600c601000b0040d4a25ee0emr16278wmb.11.1703232634442;
        Fri, 22 Dec 2023 00:10:34 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c001100b0040d44dcf233sm1527024wmc.12.2023.12.22.00.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 00:10:34 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20231221124339.420119-1-raphael.gallais-pou@foss.st.com>
References: <20231221124339.420119-1-raphael.gallais-pou@foss.st.com>
Subject: Re: (subset) [PATCH RESEND v1 0/8] Introduce STM32 LVDS driver
Message-Id: <170323263335.3968091.3418124758627043970.b4-ty@linaro.org>
Date: Fri, 22 Dec 2023 09:10:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Thu, 21 Dec 2023 13:43:31 +0100, Raphael Gallais-Pou wrote:
> This serie introduces a new DRM bridge driver for STM32MP257 platforms
> based on Arm Cortex-35. It also adds an instance in the device-tree and
> handle the inclusion of the driver within the DRM framework. First patch
> adds a new panel compatible in the panel-lvds driver, which is used by
> default on the STM32MP257.
> 
> Raphael Gallais-Pou (7):
>   dt-bindings: panel: lvds: Append edt,etml0700z9ndha in panel-lvds
>   dt-bindings: display: add dt-bindings for STM32 LVDS device
>   drm/stm: lvds: add new STM32 LVDS Display Interface Transmitter driver
>   drm/stm: ltdc: add lvds pixel clock
>   arm64: dts: st: add ltdc support on stm32mp251
>   arm64: dts: st: add lvds support on stm32mp253
>   arm64: dts: st: add display support on stm32mp257f-ev
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/8] dt-bindings: panel: lvds: Append edt,etml0700z9ndha in panel-lvds
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=021a81e7ac8f579b049e5bc76efabd9e67bd627c

-- 
Neil


