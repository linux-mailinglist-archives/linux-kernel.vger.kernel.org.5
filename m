Return-Path: <linux-kernel+bounces-145936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1368A5CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7275F2848F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F1C15746A;
	Mon, 15 Apr 2024 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpUgDnVx"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDC8125C9;
	Mon, 15 Apr 2024 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216791; cv=none; b=Ud83st4D/BDVN7alnJqwld2TuRnwaG8V4kHIHlX2lEKmkcfnzc6EL7qGHzLMbLqJTXuWwy1MtZYXoEY6z2Z5nKPHBZxTf6b4pQqZw/UoXSaQ0mgIJpF1/RQgLSmmLIyQKAwoW82ClSTa58bcbbAPILYLDAY7N++6E89xUIHE4ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216791; c=relaxed/simple;
	bh=4dQXK8rM5riTwBJcZYfqprll9axw8fcL3Iwa1nRYEr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jeTOF174Z+hfFLnhkwaMdfPJZmqhUDmaL07VCBK+WT42+YmPcElD0lrg+QBAw6bXY0yKIQQwspdDXWK84NGXDd7o8Qe8YynD2PeJh6he7EFq7jLuKewGf8zwsz0X6kWFrihox7mM/zIrDP10GnWcDBkpGP8MBBOkHWgtMelWke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpUgDnVx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41551639550so23060355e9.2;
        Mon, 15 Apr 2024 14:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713216788; x=1713821588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvC0crxQ4hv14tVfrEC0cLFgOk4kwCtX5f1hXnZbvIs=;
        b=CpUgDnVxjhtP+1MrQK79zAhuRgzG8yPJ8gy13iQ0cmn8LPeiqd7NA2nahpGHssyE9U
         Bk7/U92Yz6aULesu4yFnqo0OVJaGRB97ueMgg/WigePSgNDVcrdN9pd9fLESRfhKWBSp
         /KQScW1pnwgvZwQc2Oi50st26iGFwWqXAnVJfSuT3koUp8DSmdDLx23Qf0XiAYyfb89A
         1SEVV7O4QVns3jfDVSw2y/buAw59zSzV6DQbuV/kJO7m1hGVltvqqX1c8aY7sA2mNjm2
         vjydCd0sHTWwlOzUVP/1U0Pq+A3tVmT+5bZ34rTTbEvOckxQehr8RvVCtZBFBmljQHdH
         cNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713216788; x=1713821588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvC0crxQ4hv14tVfrEC0cLFgOk4kwCtX5f1hXnZbvIs=;
        b=Rc8uY6BQvYnugpfyuXTTDB+IdiUaGAMIot0S6H0Qfy7nFTSBo9rtXTUWGjrCucgTza
         5mneqSn8V0cAg/JFQOrwbY2lE0cjQRGnZp5z0TzNllv6/YYsWh/eVpwiUjlSmC3e5p8h
         O8Ib5mOZzc/uymPOBPOB01wzzO7IVUhlpx03O4/s4bgC8IVwTsUI0wATTOdT+gHvXhi3
         SDlxPlZKPkdja5Fjf/l2ULHy9VJYrPJV9GbK3FdYHEMqROP7XqW6kZM6+b+QCnBnanVm
         JvGlKdKuUfWgRfCH4ZyrLvMI3OHx0MqMa08xHDGZkoZqcHeSjcaNcARO530+cZwO/xqL
         ousA==
X-Forwarded-Encrypted: i=1; AJvYcCVORoTpyQ1wzlRZUtNsrfGrB8NOX1T6MwCKZ8S1wLj6MygbQPifsmVWb4UDpsEUYfJOIhhL+WVR9hwWp/d80IEU8g5B8EawchryHU5dSw+aBVMCjftdXky4kl6cdTtLiwDdPaN0ik77Bg==
X-Gm-Message-State: AOJu0YwLZ8xc33OCacPdvex2IGwc3xGomR3SrXK2uzYnjYx70xOgu5OR
	nyEuRurRY2oMWUVO44kFY+OA6gSJkPeeux4nLMplB4LXhIqiWqUW
X-Google-Smtp-Source: AGHT+IGbVwjwj6P/XwJYoeDaKXfrZhxrIYcAxjHA9f44sCvNTZGbYDkW0+pIuu1H7oDt8UlPAumR3w==
X-Received: by 2002:a05:600c:358d:b0:416:b75e:ffbe with SMTP id p13-20020a05600c358d00b00416b75effbemr8521621wmq.32.1713216788218;
        Mon, 15 Apr 2024 14:33:08 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b00416b163e52bsm20901026wmn.14.2024.04.15.14.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:33:07 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Maxime Ripard <mripard@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-sunxi@lists.linux.dev, linux-mips@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 5/7] ARM: configs: sunxi: Enable DRM_DW_HDMI
Date: Mon, 15 Apr 2024 23:33:06 +0200
Message-ID: <8399384.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <20240403-fix-dw-hdmi-kconfig-v1-5-afbc4a835c38@kernel.org>
References:
 <20240403-fix-dw-hdmi-kconfig-v1-0-afbc4a835c38@kernel.org>
 <20240403-fix-dw-hdmi-kconfig-v1-5-afbc4a835c38@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne sreda, 3. april 2024 ob 12:56:23 GMT +2 je Maxime Ripard napisal(a):
> Commit 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper
> module") turned the DRM_DW_HDMI dependency of DRM_SUN8I_DW_HDMI into a
> depends on which ended up disabling the driver in the defconfig. Make
> sure it's still enabled.
> 
> Fixes: 4fc8cb47fcfd ("drm/display: Move HDMI helpers into display-helper module")
> Reported-by: Mark Brown <broonie@kernel.org>
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Applied, thanks!

Best regards,
Jernej



