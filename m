Return-Path: <linux-kernel+bounces-73690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C613385C5FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8ABD1C20F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B83314F9C8;
	Tue, 20 Feb 2024 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ryVnO8jn"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBB869D10
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708461648; cv=none; b=qEC6iqKnDQDM3U5zzgKe450WbT0pi5f8ZlqBA0gbOoWOkIjK0fQLZoA9WlL6jltJf6/i1fohKveBYVxmq1gSsbeB2S716ybEPSZVVKvChOoEhjmLB3qeQwXHZ3ICSwtD/uh7t9C5xFMuKvnZiRI1x+auOSWZB7kzaRqiMY5VOBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708461648; c=relaxed/simple;
	bh=rME8eUgwZt94gZ6W9SGNTbT1DkNB++TlYKL76AGK5Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uk7nBCW2BW2iTaNUXnR3r8bb4JAe4TGFCUPTjG0yiUSUdXZ4Kc8hzRfP66pN/VHWpH2XQlBsJ8vdT3gvXeAIJ9BoZGGWZnBjvO4bI2TqbvAoMzXbi6izoLzx/2NznOSe2m7lughKmXnkOjMmaDQ+aH79SdlIBkEY1wHSTxgG5Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ryVnO8jn; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc74435c428so5467554276.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708461645; x=1709066445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ERjxTaztc8+qMLOOT/4NvQ4ZOQbk2ui26rupVTyGkI0=;
        b=ryVnO8jndmYCCSJnvU8Qz1VNCnoDiThpfFUSZKFv/iJHiuM/GZs5+JlrHeQ2zVolwf
         ECTW6KFO80lJWkmMrwzjcbR81MEc3isIgvP7vm2GTsQ0k2+7HwRW02EvgwfBzpd7O6MN
         UjHOixtNFXDKoeb5K9SwzE8svsouS7Y5wT4SUbLGiX1CyaWa2QzRBldug1sOruHL1a0o
         V0kgq9fDL1Yo8LuS0kBPuGsZG69pfLfpfsEPdP3bDIkY+NUNVjolwU+052Iq27+3IKzr
         9VDJeB4Cu2EpIJZs5dlzDZbsaIvWzb5X1d7YgybUF5yH7sMzpYmZ1VMI1frEVDVlYepi
         yu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708461645; x=1709066445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERjxTaztc8+qMLOOT/4NvQ4ZOQbk2ui26rupVTyGkI0=;
        b=nSyFjAEC2R5C93AXxruxuOByKHgQ0yYmUZoW6cx3wTmeaXNidDbS9cBYKG7Kw5Xsrh
         uAeItYBotj5tT8865TVut6kkyVwK3Z4VUM1RCw+XbTkkOMNYJMhlf2ERKYGbo4XatckL
         pOrr1q9i69HU3UKy4HAg5/Vpp/yhEKocgB4lAHvU8yNkv5/7TJwKTLgF6zcB8SnMtvUg
         Z7v6hAHA7/kEnIuIlzXhXPOgrlibjM5qQ0igm6897tZ+dxsG0vyER3BpH+vW2Lw07p/J
         20xwyuXtPAAS8dJtXrYz8MIBXxm9rRVqKljaQxcgGEHN3En4eR3F3wQgcBhT9R8I6DnP
         rtIA==
X-Forwarded-Encrypted: i=1; AJvYcCU5JJvu4W+3wyooWH8LQHv1jTYylEKY6pCD3I65aLCF1Sqe0aE4GqTvS1LzGUit6z16hGRuhLblROCrAIJffcGSG/Wz6GxaJOYWECtL
X-Gm-Message-State: AOJu0Yy49Jod2XKVGoTtZf7jkGUt4nahmSjr2J0gVmcRRDtv9NI/Qcby
	q+NYmfBeSo56fmW3cmisustlTWMOwBgvkE/APoF9tnUrNAIjnDJfhVPvRkov8vS0tevDtDefLJY
	l34nm7Y+WM1bpLZENyBNAtcCy+z7eH6Dmkz9H0g==
X-Google-Smtp-Source: AGHT+IETjPhkjxz2MThECRusOlTB+9xatw+N7NRhVCuCJgBvswJsF8s8Ii9I89OOkXNE59trLPn3GZNF74HOEleBXVU=
X-Received: by 2002:a81:494b:0:b0:608:6e94:9855 with SMTP id
 w72-20020a81494b000000b006086e949855mr2008876ywa.26.1708461644963; Tue, 20
 Feb 2024 12:40:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220195348.1270854-1-quic_abhinavk@quicinc.com> <20240220195348.1270854-2-quic_abhinavk@quicinc.com>
In-Reply-To: <20240220195348.1270854-2-quic_abhinavk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 20 Feb 2024 22:40:33 +0200
Message-ID: <CAA8EJppP6Axd3amPpDrd1Y9dwNYOuSnLiSwwMDv1xm7i+2y9HQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/dp: drop the size parameter from drm_dp_vsc_sdp_pack()
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, robdclark@gmail.com, 
	freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	ville.syrjala@linux.intel.com, quic_jesszhan@quicinc.com, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 21:54, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Currently the size parameter of drm_dp_vsc_sdp_pack() is always
> the size of struct dp_sdp. Hence lets drop this parameter and
> use sizeof() directly.
>
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 8 ++------
>  drivers/gpu/drm/i915/display/intel_dp.c | 3 +--
>  include/drm/display/drm_dp_helper.h     | 3 +--
>  3 files changed, 4 insertions(+), 10 deletions(-)

Thank you!

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



-- 
With best wishes
Dmitry

