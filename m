Return-Path: <linux-kernel+bounces-138208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A49489EE13
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002042837C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0C3154C0B;
	Wed, 10 Apr 2024 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zG9PSrBi"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2B713DBA2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712739296; cv=none; b=KvpWBY3G6xrfpmDTLTCRPh23I73LdB2Jbs/mXXSiPwBKeJw+Az/Edr2OZvwB6bRTOC1ujDwqnKP+aiHmbD4f41Op+MCXeuaAXr0Hu+nAdoV4ejIwGSlYUtsNC5F+4YjX1akA2ML1eKfFWdU5L5ZwtRuYp14y+KiI8kNTWalhTkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712739296; c=relaxed/simple;
	bh=qaSlRpF5l5QKXd1++qFFuKLIqORYYOeuXBF91UP5sCA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rTbtFItEtpS3r785YWS0d24oarAQt6lBWI3mv8Gj2RY07i+wRA/Pu/81kNfbPmPBeNZpSSJC5IvCoBbo8i0Ctx5cAQXqFFuh1mp2AzbWgcNfoDWDbVRvhAVv2oWWCTa6I9ft/rW7/MM0GuOWtID6TXg3zBRi646ayOPsRYvzfqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zG9PSrBi; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d4d80d00so6081505e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712739292; x=1713344092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9n9bIdxiQcPgRyTX+n58GNtmNfwkau4b2336NlqK0w=;
        b=zG9PSrBiAqQKK7iBHZiRVpeZjf7lcMM4NMrgyObmw0+rqNeJ4NOz7uol9dODwQ+WL6
         vQlreQsBQWoWx1rbNQpKtnU89zVXFlFib9wyOYeKC6ByITamARhhORyaXyYG22WED69R
         9B1lnqA+0BjMlyHRGyjq9DKgZgTuQ7V56ckAslEhuYUsCOBpwMrsMkBUQ8b68nFa51yH
         nOpvJpx7SFNp0RASc4xwu696xt+Dbbr4Whiwe3+ohoaPjiH9HwIX8Gn75OUZ3l3JB0ft
         b7eTZSCUYQxg/3UGLqcYMvVIWYOZ1XnHmLo/YfbDVLoZCKd4O7tZgGbJf3p7Y1HQqYXm
         6kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712739292; x=1713344092;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9n9bIdxiQcPgRyTX+n58GNtmNfwkau4b2336NlqK0w=;
        b=MyY5dAJz3Fo9VIktBmH4xwMjWnrzusaUNgE4YvTtALnbRaTH2f59ozZ59kjE3zOREr
         pOKt2wF8UbtRfXNl9P3qkZmykyqzRSLzpKUJHX2rnTNOmsWJZOKtpOYJ7nJHkIxBookD
         Si9ky6hmO6qRPzlxxUHlK/0bcEY48+9uvMw4vmSQ8VNLYE9VjwPPiJrJtIoLZON1W3fK
         Qbn0DaWxlKF9ncBOXxiB8bLPshx1xTCuMT6ypjhPBm9MSr+p5t3bhX47oZeaWQv76SQi
         ANX2XVhXjPs/cySAEaila88sHdS08KXlB7jDzzL0g4UFfG46i/VelF63PBysPALdvS/Q
         Agjw==
X-Forwarded-Encrypted: i=1; AJvYcCVV1bYpHtkQjlwr14eMLzVyo3EhN915+zT0g9fTkXJQ/8aGIFpW5QruqNlJL50ySoHqPazJ3afm9CaHH04eLo/n3X2SWLK787PXdDB5
X-Gm-Message-State: AOJu0YzHMpO0Mv54tVXfNKnk0AHZSeV8u6pDWXcqQw9A9o8mgVEWcVJU
	IByHdvjiaaaO/ZrJIHLqQGPgGY6louewMxzzaXWU2DcA/eQPuAuw9qg3dAIuMGI=
X-Google-Smtp-Source: AGHT+IFNFRt4eMSzQqZ/7NkG1db8x/cM2BTv+GM3c/HklSBaajG7sctnDL9a2AdHlmfF903QzBJ7Tw==
X-Received: by 2002:ac2:47f0:0:b0:516:d30c:7236 with SMTP id b16-20020ac247f0000000b00516d30c7236mr1322034lfp.18.1712739292455;
        Wed, 10 Apr 2024 01:54:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j1-20020a05600c1c0100b00417be508e44sm408832wms.34.2024.04.10.01.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 01:54:52 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>
In-Reply-To: <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-0-99ecdfdc87fc@linaro.org>
References: <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-0-99ecdfdc87fc@linaro.org>
Subject: Re: (subset) [PATCH v12 0/7] drm/meson: add support for MIPI DSI
 Display
Message-Id: <171273929144.3191460.10788273510731412114.b4-ty@linaro.org>
Date: Wed, 10 Apr 2024 10:54:51 +0200
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

On Wed, 03 Apr 2024 09:46:31 +0200, Neil Armstrong wrote:
> The Amlogic G12A, G12B & SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a),
> with a custom glue managing the IP resets, clock and data input similar to the DW-HDMI
> glue on the same Amlogic SoCs.
> 
> This is a follow-up of v5 now the DRM patches are applied, the clk & DT changes
> remains for a full DSI support on G12A & SM1 platforms.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.10/arm64-dt)

[1/7] dt-bindings: arm: amlogic: Document the MNT Reform 2 CM4 adapter with a BPI-CM4 Module
      https://git.kernel.org/amlogic/c/ef5a84d716042871599ff7c8ff571a6390b99718
[5/7] arm64: meson: g12-common: add the MIPI DSI nodes
      https://git.kernel.org/amlogic/c/6f1c2a12ed1138c3e680935718672d361afee372
[6/7] arm64: meson: khadas-vim3l: add TS050 DSI panel overlay
      https://git.kernel.org/amlogic/c/2a885bad5ba4d553758d3f1689000cee8e6dae87
[7/7] arm64: dts: amlogic: meson-g12b-bananapi-cm4: add support for MNT Reform2 with CM4 adaper
      https://git.kernel.org/amlogic/c/fde2d69c1626bebb3a8851909c912e582db1ca95

These changes has been applied on the intermediate git tree [1].

The v6.10/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


