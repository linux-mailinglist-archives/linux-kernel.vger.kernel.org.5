Return-Path: <linux-kernel+bounces-147515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D9D8A7579
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E061F2609B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216A913A404;
	Tue, 16 Apr 2024 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0ifN/NG"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BBE139D16
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713298860; cv=none; b=ZmJwkI3047DJLvXPess6wRLImrKIYiIe1fyyApo5/P13SZaakuomN1/t+pgDCODGSTmPOw+w9+miNDoxcuH615wky43lnk/m4JQyRUi9/we3aJT3A+04JlvTltFeMnwQ67dN7SyvtJZvsG1Yixz8dm4wYHQ+4tj+DS/expCoznE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713298860; c=relaxed/simple;
	bh=A3TDYDRTO+FDIf/6e818pBZ/XwAhsKSgsT50AzDWnng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBHo1vwhDLNSVi030hx0QqXvIActvgD5IdcibjsxF0BLeNXdVF3w0+KSx/vdQLDZmQJRLQqzpip0CVBJW84HyOtR1jUYhFPeXKNk6jzeZnzgqM1OHkZeMS2JDf3KspMX2rUIFTS7vodmd1gkW3mrEdtf3B1gzqy335UcNhM8/4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l0ifN/NG; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d0162fa1so6196171e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713298857; x=1713903657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qywwJq5nbSjHA1aLQQKg5o6c3/lkaJluN4xzLrwZMAw=;
        b=l0ifN/NGJs5sWKs0zF3hlJI2/VDy8PVEKjWl0HLMRbFp3CE41wMKnoK9bUxcCXwwBw
         +YXpI8M3JH06DBgrbD5doiXDl1kToi35/VQhxbTrKNN8zbWbskxOnHvtssQTBY7otnSt
         xDRgyXMS8M3uaTIkEqohOF/co6m5N6+Ri1x1eq6NW8vQLIa34yKhycChlN51gHpqmdK6
         aJE4DAtqptpT9MUXe3Gmmh4xfZ4IW0/U17gzj5TpsKwHMZOqTFpeqkGRSP5Z5fvi4UdK
         6Ur0YgroXIB4pooiO4smiZQGsNNXpyI571bEJokqP/74aan3rDMIyeA2BPEiPnrQ4EQF
         DL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713298857; x=1713903657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qywwJq5nbSjHA1aLQQKg5o6c3/lkaJluN4xzLrwZMAw=;
        b=d+pGWnyeRBFg8Ck+iqvvhVeXpzNgdD0xK12VexybIQ2bI3JxhIKWppfiPil+pSg1HJ
         b0EuKQTJzX1ZB/fATALnJ/KplWxHGz7QxgqH5zTrKhJ+Oh+pqCW0mkJyctpf33ZiapVj
         n89khNiqSQf3BASg7W1aHS//Wy3MrO0Cyut857/Xt/mGg9osUGdY2BDxmmlE6zHLmeMm
         I6sFShD8b5w/TO8dMTql8k0Ilv8LpGsJwCfx3BczoyKa2gWrfmqNpCUaAdblR4Ws5jk/
         weTGJIJe4TF2PqrIbmhX8PFLTvLAItSQlLqMHmErBccermbJx6Nr0s7dqYWnM+M26TeI
         HaXg==
X-Forwarded-Encrypted: i=1; AJvYcCW2v85dY+kWDr1vxUsqdc8Jd1UVwwVo59lB7cRklzgx9YFoGkSdvXEMdrxxlIYwpITdvmgaerr6FfxOcvfXbyLBhYdWmuCe8mS5ayFf
X-Gm-Message-State: AOJu0Yw/qvcoIn5EVB0nHFrPVEmZbyhNaZfjUBaFoCjMs8Rv5Z+Tmb9l
	z7CNSXkfpGNi/kPFUwJbE/7hNF3BbMTPyj7Gs3Jboc5anE6kU2/JzNjon0zaG8w=
X-Google-Smtp-Source: AGHT+IGvXeB5YIW/C8iZDJh9O5u8lqiFkQF8Sa94t87snOvbhlCLdYH6yE/raC6L6AjmGsPjbyDCtw==
X-Received: by 2002:ac2:410a:0:b0:518:c69b:3a04 with SMTP id b10-20020ac2410a000000b00518c69b3a04mr6070306lfi.0.1713298856688;
        Tue, 16 Apr 2024 13:20:56 -0700 (PDT)
Received: from eriador.lan (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id g10-20020a19e04a000000b00515b5cd2361sm1719519lfj.164.2024.04.16.13.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 13:20:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Matthias Kaehlcke <mka@chromium.org>,
	Harigovindan P <harigovi@codeaurora.org>,
	Ritesh Kumar <quic_riteshk@quicinc.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/6] drm/panel: small fixes for visionox and novatek panel drivers
Date: Tue, 16 Apr 2024 23:20:54 +0300
Message-ID: <171329879926.1936150.2583859281547375422.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404-drop-panel-unregister-v1-0-9f56953c5fb9@linaro.org>
References: <20240404-drop-panel-unregister-v1-0-9f56953c5fb9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 04 Apr 2024 13:07:58 +0300, Dmitry Baryshkov wrote:
> While taking a glance at the novatek-nt36672e driver I stumbled upon a
> call to unregister the DSI device for the panel, although it was not the
> panel driver that registered the device.
> 
> Remove this call and a similar call from the visionox-rm69299 driver.
> While we are at it, also optimize regulator API calls in these two
> drivers and in the novatek-nt36672a driver.
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/6] drm/panel: visionox-rm69299: don't unregister DSI device
      commit: 9e4d3f4f34455abbaa9930bf6b7575a5cd081496
[2/6] drm/panel: novatek-nt36682e: don't unregister DSI device
      commit: 941c0bdbc176df825adf77052263b2d63db6fef7

Other four patches were not reviewed and they are not fixes, so they are still
pending.

Best regards,
-- 
With best wishes
Dmitry


