Return-Path: <linux-kernel+bounces-106260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B18CB87EB94
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205DA282529
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2674EB46;
	Mon, 18 Mar 2024 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H7MnHRfk"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD73E20EE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774329; cv=none; b=e2UX4KxtW7Ha/+/10brk4Ltwc4norp6Cn37QqLC7EShv4eOlVhNglWFEPMPrtzwfwl+eDI3pLd3mLrsFVqpoTdlKBX4kzuyF4fDZ6aV6WXfvx7D4hdWzXI89oXxhdFLBkPgUOH2WzBwZdoj0gAWsXtDZ7bCHxlGpt7OnrtJkJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774329; c=relaxed/simple;
	bh=RoQuI/es24H/nAqPRbUV7hKZQxcAqymp229/lw/eVsQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r8LXxs+ECfmS7fKGCnJ7SclEcn24UZvhxdaFMtBIYtgqXw5t8R1K/LLlSpxHyR6jCGaYg76w5qR+2P8dy0nZnd71bapDp//itt89rj/I3SLJuQcaHKtlg1U6IF05flePyHUmLG4em2ErOgQv3r3TQOKQAgjb4Tg1BqWaA/YJ+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H7MnHRfk; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513da1c1f26so4798714e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710774326; x=1711379126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lw55mJTDDxZ1K/cIy6WxXdv3l0985blDRwLkE03YRpI=;
        b=H7MnHRfknn2KmOlkgVBp5u5nVwWeqBdDdeJR/eGYuj6hV7ifc055xZH23yiOghteh2
         SRBP24JsWfxNlg0Y53TaZ1v4PILWH3+8WxpWhybs+BlkjzsXMjhWLs/luNbzGUjobLfd
         jGiTPHZ7AaJEmb6p0or6kdZwnDbVimwdDqMFlwRWnF25J4eCvl6Kd/hsxnOWaIzrVs4b
         N9T9aaL5sllxie2XXhzBZe65wp3QOy+v5cfijRk+VejIuuJLiz0aLDpLITmD/xRGCYQ7
         Fk1tqM+Kl9B4pmSTzCxrrM8ELv9auDMpuJCfbt0MSC1eF+mus2NkpZnYl8D+eKja58eQ
         gP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710774326; x=1711379126;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lw55mJTDDxZ1K/cIy6WxXdv3l0985blDRwLkE03YRpI=;
        b=XrW45yiTPmrGAjRQ9dQLvoPLoxyXXiIbgyEtiaxwxJpxOBxNu6PWXHIiL01co6tspN
         9Qdgc/GIt8Oa8ARLT/+b4vCEBsIfokXjWQR3GDXHI0RhKGE6P5sGES6EVNTgA4k+6FTy
         HzQUniaO54EGJ53qlWczFDS99nk8DMvs/L98c5ztqTxLNsdk8goGiHd7k2iP9B34RsQG
         mvLK7a22rkNai4o3Wzu3p85AU8fmcKwFteYO1ObgrINn1z2UP4gqzQGTd2kkDrM9UmAW
         oQRNUeXbwwheNL7X53i4ljk05PddNptiFH5c6PFD0kV9xtcSYEk0L0Zrjlf6rX8cZHH+
         EOuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqDweb3DZR1P9c7GQm55ijkNYbp0L8PwBeW2dYEHauNFtHahf1zGUkozDYcdXl8F5iLlAfFh1WOgA/maBpZFUZTvCBXwA8Z+aWOfFk
X-Gm-Message-State: AOJu0YyB+G9XYW9+2yfTf0m9rHr9PaF/FZCZFRJN2Ru0V1BSCOXMwedi
	JUhh2Kn+UfxA+arrf+0NzKvriMUYXomlPoBokAdsL0HHroYyTa+j2gqO3mqGE7g=
X-Google-Smtp-Source: AGHT+IHCgOcwR7UDs/bvxSOUb3fBuHIJicmJyacnVaRq5aIkQS/vidxg7StuFD6lZdBoGgYfzuNIPw==
X-Received: by 2002:a19:3850:0:b0:513:5a9e:78af with SMTP id d16-20020a193850000000b005135a9e78afmr8028856lfj.58.1710774325631;
        Mon, 18 Mar 2024 08:05:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b004140e9211e7sm4556317wmo.35.2024.03.18.08.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 08:05:25 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Imre Deak <imre.deak@intel.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240318-revert-select-drm_kms_helper-for-drm_panel_bridge-v1-1-52a42a116286@linaro.org>
References: <20240318-revert-select-drm_kms_helper-for-drm_panel_bridge-v1-1-52a42a116286@linaro.org>
Subject: Re: [PATCH] Revert "drm/bridge: Select DRM_KMS_HELPER for
 DRM_PANEL_BRIDGE"
Message-Id: <171077432467.2094782.16965623014261223688.b4-ty@linaro.org>
Date: Mon, 18 Mar 2024 16:05:24 +0100
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

On Mon, 18 Mar 2024 15:16:21 +0100, Neil Armstrong wrote:
> This reverts commit e3f18b0dd1db242791afbc3bd173026163ce0ccc.
> 
> Selecting DRM_KMS_HELPER for DRM_PANEL_BRIDGE leads to:
> WARNING: unmet direct dependencies detected for DRM_KMS_HELPER
>   Depends on [m]: HAS_IOMEM [=y] && DRM [=m]
>   ...
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] Revert "drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE"
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/dbd9698830ebafcb6f3be6498fd4a6968dcbf89a

-- 
Neil


