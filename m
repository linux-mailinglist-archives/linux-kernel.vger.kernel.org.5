Return-Path: <linux-kernel+bounces-27145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0234282EB31
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4092854B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7258C125C8;
	Tue, 16 Jan 2024 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yeRE25ab"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346AF125BA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-336746c7b6dso8182013f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 00:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705395596; x=1706000396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR57Dsv6KO4M/E5diixGfumQSaUt17CRwRBIvEe196w=;
        b=yeRE25ab6zll3M/F3D7b1/WPjnxXZYp19xOOuwqvK+/gGAVdMK3cM1x6ACVqu6uBGc
         zq11QftGWGrku8l/RMBTarkW5eF+KS55bwUV82Tbx6ppNEIgtIu0e9BRfkix8ihjqFTA
         NBHEJsez4ZkPwJl1MGM5BsPEc51mavQ8NPHiDkQvl91eZae0RYYtRej3kRQjSWgLpYTQ
         0oV9tdl91cuZ/cbrp6ZsS4oawqV+/5+2CHUx5ccJBzBMRiy9G+fFhkSJmWKY9b9FqrBf
         sjwf0ekXEkzb9FCXHYeNUsdkXDzrnRoxw6zGprAwXdCe6j6U60/DxYr2p1akAy8Coxhn
         XVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705395596; x=1706000396;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR57Dsv6KO4M/E5diixGfumQSaUt17CRwRBIvEe196w=;
        b=kJm2XNaqrGb5fV6OY5sFGZWlQSoNDNEFCRrU2DVBO5gV8JGXdL6DsQ8HNP94wu/2gi
         ObijK7cgNFhZc/8wFptF5gCV2++NW9izyJE2x12ma+mB3x6Wi8nfUSqbDsMNKwiSvsYu
         MkjvQK5epA7+IazaI0WFH86dU+wcVfWjV2XPzERFyFAxffdckJM9OxeQ+zyHSBpP4ihv
         Kqb6Q5MiyRf36MFQmBBkvQAe1+mXdGQVSj9jHhskNHtd8LlfTIbrhGQxwAHMxcGPv42N
         Ga+1JVY+tUP+nJ1vthGk7bQhPqreJbEK/SBmzyQZCTXlLDaTMj7xA79/Ig7j79qgzY6U
         x0Ig==
X-Gm-Message-State: AOJu0Yw2BNuloZwNIY4p+wtU4+8NDXleon6KJXt2XusneM0jeB/Un0c5
	Ks8o+XD1XGw5z6XNSgMsNAra1ntY+Bc8ng==
X-Google-Smtp-Source: AGHT+IFuae2aMp3x3YiybSHmGPStiStnzK99Ia28OBoswGBvqpJyRAs32GRTCmNYCzp3Exl6pyMajA==
X-Received: by 2002:a05:600c:5491:b0:40d:7347:f5e8 with SMTP id iv17-20020a05600c549100b0040d7347f5e8mr3771459wmb.25.1705395596394;
        Tue, 16 Jan 2024 00:59:56 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c501300b0040e813f1f31sm2895704wmr.25.2024.01.16.00.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 00:59:55 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Boris Brezillon <bbrezillon@kernel.org>, Peter Rosin <peda@axentia.se>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Fabrizio Castro <fabrizio.castro@bp.renesas.com>, 
 Jyri Sarha <jsarha@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Nishanth Menon <nm@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240103-si902x-fixes-v1-0-b9fd3e448411@ideasonboard.com>
References: <20240103-si902x-fixes-v1-0-b9fd3e448411@ideasonboard.com>
Subject: Re: [PATCH 0/2] drm/bridge: sii902x: Crash fixes
Message-Id: <170539559536.1557628.14676800886096987878.b4-ty@linaro.org>
Date: Tue, 16 Jan 2024 09:59:55 +0100
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

On Wed, 03 Jan 2024 15:31:06 +0200, Tomi Valkeinen wrote:
> Two small fixes to sii902x for crashes.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/2] drm/bridge: sii902x: Fix probing race issue
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=08ac6f132dd77e40f786d8af51140c96c6d739c9
[2/2] drm/bridge: sii902x: Fix audio codec unregistration
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3fc6c76a8d208d3955c9e64b382d0ff370bc61fc

-- 
Neil


