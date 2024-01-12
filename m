Return-Path: <linux-kernel+bounces-24485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EA882BD48
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A7F1F21413
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78655787C;
	Fri, 12 Jan 2024 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNtoHOV1"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7E756B92
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so5351954f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705051788; x=1705656588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Vv19tHpCjReP2da8tPiV42geQgpc5fReO5lF8jALPM=;
        b=UNtoHOV1Hm8yCoCq8Ew0anaP5/hjjeIpxaA3/1vwVMhLOHDIxIbfFjk8/2RpvobgrX
         CyNih2qLbhhZ5XQknfkuK7TAIcJQ6rj/quxwyIEO/8QWVXeqpkWXgIy2aYBg5BST+mPZ
         MYBDQcOGexVZoNOXN3NF2uQ2k/54MzkdU+PA99CnHy8zHUN/dMzH3GZF4v6HmUchFYoZ
         L6th/W5AIMgOmGTIx30QT10NsPqgxhYjPqYqFQxeiygw3LsJcmDphuMPXMQcyUgrnZ9s
         UGXE97mEbGle73gROQ9KxBg0etrMqR3RJKZvkP7cbRmPeiN9aqiYZDqjW531YeKJCW+C
         KmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705051788; x=1705656588;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Vv19tHpCjReP2da8tPiV42geQgpc5fReO5lF8jALPM=;
        b=ox/jB2xK8j+9fVMkMwWNrrgf9fAcOr5yg1pDhPJmNpSqwzNrONV0A473r9JANVSXJc
         X6x7+evDLLgT3gxRS5HY0MdXTWltAGoGSnEJRmH02eyHwYVEHVkKY+uB9i4w394PT70l
         8Ga9q9+0sF/xoFiKembYQF/ONmD8o4MqxzOHWDPSswEOdvju5wzYLC+yklTcGhg1Fxy+
         ai3vsIb1vZvqV4J71WdFmsDkA3nYkv8iZ371cTYbrDvTMqGCVnkfP6XjWI/2z0y2/9SR
         0MYUcXVt1U5mhAquNMzZ6XW9PTnM+bmRQsVkruBykzc/bLAcDv+5mapVs2M4VgRNbi1J
         hzBg==
X-Gm-Message-State: AOJu0YxYjsUJB0PPosFqzAk8mojx0wUo6lilWWgLY1FBLcaksVeOJVLX
	IPb6eHKT+FeQ4xl2wvz+cg+HiT/CiuelJg==
X-Google-Smtp-Source: AGHT+IHfq+p21PmuJzKnW1fi5VR1SlCHI4I3IuV5Ahp8PV8nI/aY/qvkOQ9nVhXNsSsv24cVvR6Nbg==
X-Received: by 2002:a5d:65c7:0:b0:337:767f:c989 with SMTP id e7-20020a5d65c7000000b00337767fc989mr558407wrw.12.1705051787821;
        Fri, 12 Jan 2024 01:29:47 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d688c000000b0033718210dd3sm3311184wru.103.2024.01.12.01.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 01:29:47 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20231023115619.3551348-1-arnd@kernel.org>
References: <20231023115619.3551348-1-arnd@kernel.org>
Subject: Re: [PATCH] drm/panel/raydium-rm692e5: select
 CONFIG_DRM_DISPLAY_DP_HELPER
Message-Id: <170505178684.964410.13503818885603270120.b4-ty@linaro.org>
Date: Fri, 12 Jan 2024 10:29:46 +0100
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

On Mon, 23 Oct 2023 13:55:58 +0200, Arnd Bergmann wrote:
> As with several other panel drivers, this fails to link without the DP
> helper library:
> 
> ld: drivers/gpu/drm/panel/panel-raydium-rm692e5.o: in function `rm692e5_prepare':
> panel-raydium-rm692e5.c:(.text+0x11f4): undefined reference to `drm_dsc_pps_payload_pack'
> 
> Select the same symbols that the others already use.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] drm/panel/raydium-rm692e5: select CONFIG_DRM_DISPLAY_DP_HELPER
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=589830b13ac21bddf99b9bc5a4ec17813d0869ef

-- 
Neil


