Return-Path: <linux-kernel+bounces-78468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B99FB8613D5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27617B22DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3054780BEE;
	Fri, 23 Feb 2024 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uuix5bik"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F198061F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697903; cv=none; b=GIkVvFQcmLxHvPkGZrgi3hpJJT0qs6YpUD1lwoCZe1XXK8nF89Hfx4VzW6Ne82nB+v+83JnDfAG+FXdF8IX3iNQu4LdzD5RgbB4d9KcglRbam4fjSB1H5DFj5++XsSeT/AjGm3VmukOd0xx7uVayh0tvQbUDoSnEIOXRx0leqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697903; c=relaxed/simple;
	bh=HX4TUSWSsGsJPJcz5laMwy2GWSZ/MRJtO55N1YPwBtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlLdjxfeL3jMz+kT1qdIXQCa0GvMDiZFXj00ioOLgHPs9FB6Rb9BJpVs/AQIeDcSjY4f6EiPwmTZF1pCJuKI+GimLt5TQgF/vs0l0m5Azao/7QrJZ/wf6yfoa2TQ11O8Y4HpTGFyJvlMPnyfQYsFZzfu1qFS0s0m1V5C0G8xvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uuix5bik; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso907675276.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708697900; x=1709302700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R19d00zAe0ESb2W1wfQWoMVwkbh2mKJoTeu+62qXKLU=;
        b=Uuix5bik05hshGSFS+elh24cUmuSawIIxz+Z0ZYmu0RAIJ6/qMBF92f+Kf25yC54jj
         VDJnu211xVQPfp3BLphWiWw0wPSjlN1E0hZeBnPd/iDETrxfTDBb05oRFWiBaRHdq8UQ
         Ai9JWsdO3zPhWL1jBk7z9yDiY2bSHw9Kz4ee3cYRBs0OViy8zsGxNduqb9A5EIHmYTvi
         F+43srEtFbOf5VYQSjrkj6fObI9uc/jdZVxN9BCV5eyS1EApJWnlWG5/aeMi1MJC5L83
         wutcUuYT4opGw0F5483FkaQVGb2aT6yMpTCx9x0+WBK19tuUVQqdjsa/HA3oLWRUmWQT
         p72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708697900; x=1709302700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R19d00zAe0ESb2W1wfQWoMVwkbh2mKJoTeu+62qXKLU=;
        b=VSbGFF8ARASOHCcJSpd4r6nj5qCcXQG+T7RK4a/2+gz45ZtizOOjV8TAb2itM84Nmi
         g7iFBlwSyamPYeZZB+3ziaCTWyPT/wnPoJNhLGeFh6NmZ0suQHS/WgXBDY2qSz8Cs6vk
         KYP1zIF/BEOTuwfTjnkJJwrZNdgLstumRAlUR3nTeMzzNPZQ1slNPT3XsWeD4us3LXhJ
         mjlvB5jeFTQwtWmlvT4opewb7Ph1thTWQVqni30OotUz76iKdRxK1s3U6k0srOqTC4hf
         ZsYfWzlviuoqgcwcrAQqdG7d4Un6M48maO9vHM3c9OxED8KbrwwmLPkzXVVGHQsPu/Uc
         fBoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlRTNuTpSLayfvnVpZ4Ggrxm60xAYc5QzTR35DhcnovulQ+c1a+fQsYQ1FctqEYpmODSYngV3lO+fwvpCO74f0FX6kUzv19WzlAe7z
X-Gm-Message-State: AOJu0YwpDst8tccSrxz8XQuFj2WMtcnphYpaCHRn8n9Y0yl1lw1DMB6r
	yxPv5V8/p/+U+Yb8yGnWWYFH8NrcWXx6ZVgBsrP9kll1M0VkWCyVW6vzkmiAtdmZ5ieKGer5p5O
	xY4tAPZrB7PTKjMULAeidopMDeX9j+nABIRLO3A==
X-Google-Smtp-Source: AGHT+IF70UF5LUoWVCUdf5eKhR2KmxVP4WJANJz9muRW2tleCLa7psg2DI+FTnDe298CK4P04Z21/Fhm5EKyGZLzPvY=
X-Received: by 2002:a25:6b03:0:b0:dc7:32e5:a707 with SMTP id
 g3-20020a256b03000000b00dc732e5a707mr1990018ybc.61.1708697900641; Fri, 23 Feb
 2024 06:18:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217150228.5788-1-johan+linaro@kernel.org>
 <170868613914.4029284.5549880672870201262.b4-ty@linaro.org>
 <3c4246b6-431a-442e-8ace-3b0d0e67743f@linaro.org> <ZdiU2z8rzo542_Ih@hovoldconsulting.com>
 <d4049823-ad24-4426-887b-9c66cdd96318@linaro.org>
In-Reply-To: <d4049823-ad24-4426-887b-9c66cdd96318@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 23 Feb 2024 16:18:08 +0200
Message-ID: <CAA8EJppYHdSmsWMk-u=QaAaHWqjFj8zs4CF947eeex6iV4dsYw@mail.gmail.com>
Subject: Re: [PATCH 0/6] soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
To: neil.armstrong@linaro.org
Cc: Johan Hovold <johan@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Vinod Koul <vkoul@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Jonas Karlman <jonas@kwiboo.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 15:52, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 23/02/2024 13:51, Johan Hovold wrote:
> > On Fri, Feb 23, 2024 at 12:03:10PM +0100, Neil Armstrong wrote:
> >> On 23/02/2024 12:02, Neil Armstrong wrote:
> >>> Hi,
> >>>
> >>> On Sat, 17 Feb 2024 16:02:22 +0100, Johan Hovold wrote:
> >>>> Starting with 6.8-rc1 the internal display sometimes fails to come up on
> >>>> machines like the Lenovo ThinkPad X13s and the logs indicate that this
> >>>> is due to a regression in the DRM subsystem [1].
> >>>>
> >>>> This series fixes a race in the pmic_glink_altmode driver which was
> >>>> exposed / triggered by the transparent DRM bridges rework that went into
> >>>> 6.8-rc1 and that manifested itself as a bridge failing to attach and
> >>>> sometimes triggering a NULL-pointer dereference.
> >>>>
> >>>> [...]
> >>>
> >>> Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)
> >>>
> >>> [1/6] drm/bridge: aux-hpd: fix OF node leaks
> >>>         https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9ee485bdda68d6d3f5728cbe3150eb9013d7d22b
> >>> [2/6] drm/bridge: aux-hpd: separate allocation and registration
> >>>         (no commit info)
> >>> [3/6] soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
> >>>         (no commit info)
> >>> [4/6] soc: qcom: pmic_glink: Fix boot when QRTR=m
> >>>         (no commit info)
> >>> [5/6] phy: qcom-qmp-combo: fix drm bridge registration
> >>>         (no commit info)
> >>> [6/6] phy: qcom-qmp-combo: fix type-c switch registration
> >>>         (no commit info)
> >>>
> >>
> >> To clarify, I only applied patch 1 to drm-misc-fixes
> >
> > Ok, but can you please not do that? :)
> >
> > These patches should go in through the same tree to avoid conflicts.
> >
> > I discussed this with Bjorn and Dmitry the other day and the conclusion
> > was that it was easiest to take all of these through DRM.
>
> I only applied patch 1, which is a standalone fix and goes into a separate tree,
> for the next patches it would be indeed simpler for them to go via drm-misc when
> they are properly acked.

I think PHY patches can go through a usual route (phy/next or
phy/fixes). For patches 3 and 4 I'd need an ack from Bjorn to merge
them through drm-misc-next or drm-misc-fixes.


-- 
With best wishes
Dmitry

