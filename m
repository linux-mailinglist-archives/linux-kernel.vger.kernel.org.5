Return-Path: <linux-kernel+bounces-25754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6BC82D553
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F651C2135E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBB3F4F6;
	Mon, 15 Jan 2024 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POlnsRfR"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C697BF4E7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e80046246so305425e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 00:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705308646; x=1705913446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TYJFKCqRjvcAOZScXqGwljNrNcwX1RWIF5kTzj+ztc=;
        b=POlnsRfRj34pgYRpdGgejTz3uEmAyxJVPUSHupOu38wigeA4ndEukN3DKVGL415osk
         N0YtRHMsYsCR3ZaGnQ7u3HIkNyOkVLNxm3vAzKr/cTsRGxVmWV6hhPPloAewFlzT0Vs0
         Gtwvo2YJUHKsN0oojt/WptR5X2j0K1qjSoYJWWY+YiSu/ThnXVKZdAZlBK33MJ00lw47
         VBC4ePZz+tVadTcEXZlowVsVgcbzv5iyZAAs62oi1Gu3xKJPKjGpgmfH4noIkevb2Sij
         sATYSm1M+53GPzM3tqT/KI0MB6xNx0vW1L8L7DClsZ4EwH05R7NTcY6RnTUH/s9oYHnf
         zpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705308646; x=1705913446;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TYJFKCqRjvcAOZScXqGwljNrNcwX1RWIF5kTzj+ztc=;
        b=cQSkjbBB3pg5y1wMie6+YqH2FxA+GKKkbkbAYxSx/xpJ8+61PTJbPs6dlnGysiP9jH
         m+krRD+hCyvyG4Pxai9jGjCJxOqnnLjGEYKjca84KvCggXHhU08kq6EBMjfa71EUw4Zh
         4D0iqsLsqqIyV1Nt/yji0BGLFuokQonXciiwtWlZZ1IpOvzKiCbtNIKn2CHS5Snv/byF
         juq0HUue3BOme7uZKrlzvbO4YXl8fzyzouUFzxNvhbDh7ZV/f9Y7NhyjgXvfhNZw5+Ei
         wmPPB7spniaXZWUWbJw5eJq9kPsFC7sBS9HRZ5WDluyHYiRfXKsqekQ2Be5tUe5Mv6RY
         tklw==
X-Gm-Message-State: AOJu0YyjGk7akS5AjwVhoqNwzehCX2lOs3zVfbsgBqkgJP7RHuNKXpVi
	OIUPTKDiD/eZEqLnJLbzJODn8hd14us6Hg==
X-Google-Smtp-Source: AGHT+IE+yek29mqri2fMFu5ocqEYCMOXGL6XkoH7oGse6lZ1GjJ+72Vk1tyBF0FQJfUvGEfnIiMn8w==
X-Received: by 2002:a05:600c:2484:b0:40e:4cae:a3f1 with SMTP id 4-20020a05600c248400b0040e4caea3f1mr2569303wms.77.1705308645938;
        Mon, 15 Jan 2024 00:50:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id i10-20020a5d438a000000b00336344c3c3fsm11224128wrq.90.2024.01.15.00.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 00:50:45 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jianhua Lu <lujianhua000@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240112140047.18123-1-lujianhua000@gmail.com>
References: <20240112140047.18123-1-lujianhua000@gmail.com>
Subject: Re: [PATCH] drm/panel: nt36523: Set 120Hz fps for xiaomi,elish
 panels
Message-Id: <170530864497.3765652.8786048172008911730.b4-ty@linaro.org>
Date: Mon, 15 Jan 2024 09:50:44 +0100
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

On Fri, 12 Jan 2024 22:00:47 +0800, Jianhua Lu wrote:
> After commit e6c0de5f4450 ("drm/msm/dpu: try multirect based on mdp clock limits")
> merged, 120Hz is working on xiaomi,elish panels, so feature it.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: nt36523: Set 120Hz fps for xiaomi,elish panels
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=de8ac5696ebc3a2d89c88b70aa3996ee112e76ef

-- 
Neil


