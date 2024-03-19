Return-Path: <linux-kernel+bounces-108025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3298804F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF72F282157
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B847C39847;
	Tue, 19 Mar 2024 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5+YTTjR"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D5239FD0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873350; cv=none; b=PdCCucAeX1eGe7huHZH7K3yB6BuG7+YNcJljdxcHfScdN4vZSJ2qahy2jay3ztrfi3njCqOY4i0BMHQB0XEmBZR8LK2QyNYQjcdF7sGT+aIUtru3SNACm8nZwmMqAe0mFiRltH/SZkPMq5+oP/U60X+XTRxcK+ttJFM5zyU0PRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873350; c=relaxed/simple;
	bh=5Otyfm6zp0UVqj3jZp6Te5CgJP3KPff+6b1od85AMT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0PEfBlTdkHhypq+VN6iQ/Ct2A9SmJLrXCrwvHn1PoefWNBXoNNcUyypxMy/85nn2yTUlDBn5VsNrB/drfn69jAXHGqzINt7pSiSLTV1xgnm44IVoX/gmIfwC93sgsToIjghKsH4GxB94lJ9LDALT3X7FUpkBSCAcjQacc17pKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R5+YTTjR; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-609f24f447cso64966667b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710873347; x=1711478147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl/lQ7Cc4c2hO/fqExBYwIoyN+wDkSHsXx0gNDbMeuA=;
        b=R5+YTTjR/iiArRhp+1D4TUqY0C05eK9wvJ52oy6KhOD9S9FNQqY/XcuFpjoAUZakkJ
         vvjReVIA5yKhLGuVyOI7WpMB9eCO0LUyGWqrgC7hs58bgWnBPD9Wv0GyIqdjLZmHMoQn
         O/lgcqQScwyul+VTt8zmpebF9pqfDmBcuJ9Mw25c+3Zhug54k+D+BKxxyr5mK6gCGUOy
         JeYp0K44N6fXfFYrk47jPHTie5LYCEOVUZ31p04fwXE1Q5xFWSrHAjtc3odzvysRA+kE
         YM2H1n36D8RnIZeOaEGob3VQW+F5SHf6TaaoBH1sM/6c+B7YK68RjxZWnKBTFL6KBznI
         LAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710873347; x=1711478147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rl/lQ7Cc4c2hO/fqExBYwIoyN+wDkSHsXx0gNDbMeuA=;
        b=Ll3pRZL11h+iy9WZSjLVrsCJBK5SHY+1QdcR9XBxgrPtXpPgpv7Z6uqFI6kztFyHMi
         Cw+nV2G5X27/A9dKkVRngB3a+gyGSSsliV1pWbte51wAeld6UyDzcAWe5isYsQ4HxeBh
         EzCDn2zmP+X0+4zDbPM71lkpsf4/2F2fpXHXXgwkc02HeLLfGOfwdIj7FfuDXG6vfXXd
         Sc/gpeUD/wmZS33RD0z0KJ7XWYVwW8wO8L4N+FmB0aGqZq1u9dZF7ZmNz+mRqhXR+cQk
         95U9c6H8+DBF1a9cfi9qq6XM/pudw0juLN65Ox8pynKmM6AceY1SFjhUsc+fHNWinVbf
         Wsbw==
X-Forwarded-Encrypted: i=1; AJvYcCWkmYCpWYoLBFF10qx+J/6GHITTHRTKJS8jd+fLGRXQ4Jnku8i/jvsPCdOpI/Bx14ruByGYUCf1ABsVrtC679zxgqlzf4mi+8R1ITMY
X-Gm-Message-State: AOJu0Yzd8KOuLrCA1ntEhZQwA2Q/WtCZiX6v2yY8tmCa5E0smo31MWDv
	kjY785L2NB3fWZvC9WZvhyh4eoVMmGn3k1s5k+qkYyU4fG10L1c2fKP8AR13I/AU5p2euNyK+3G
	U/eaROSzFeLLBuTQwcHswML2avDiZoOIf5EcEYA==
X-Google-Smtp-Source: AGHT+IHepHkMu9ldn57yrc+Ity8F4+LF2O/kh+sFvEN/Qqu/19Kr2md5XAj4OM7RQRke7LidV/dc8JD+dKGi+/3Ipfo=
X-Received: by 2002:a25:870a:0:b0:dcc:6d85:586a with SMTP id
 a10-20020a25870a000000b00dcc6d85586amr11027642ybl.49.1710873347086; Tue, 19
 Mar 2024 11:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319111432.1.I521dad0693cc24fe4dd14cba0c7048d94f5b6b41@changeid>
In-Reply-To: <20240319111432.1.I521dad0693cc24fe4dd14cba0c7048d94f5b6b41@changeid>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Mar 2024 20:35:35 +0200
Message-ID: <CAA8EJpq-NjmYkWHAVsuP5jA_Z7Xx0jCiqEDgU-0ni9BCg7Opuw@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: Clarify that wait_hpd_asserted() is not optional
 for panels
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	linux-tegra@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Imre Deak <imre.deak@intel.com>, 
	Jani Nikula <jani.nikula@intel.com>, Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 20:15, Douglas Anderson <dianders@chromium.org> wrote:
>
> In response to my patch removing the "wait for HPD" logic at the
> beginning of the MSM DP transfer() callback [1], we had some debate
> about what the "This is an optional function" meant in the
> documentation of the wait_hpd_asserted() callback. Let's clarify.
>
> As talked about in the MSM DP patch [1], before wait_hpd_asserted()
> was introduced there was no great way for panel drivers to wait for
> HPD in the case that the "built-in" HPD signal was used. Panel drivers
> could only wait for HPD if a GPIO was used. At the time, we ended up
> just saying that if we were using the "built-in" HPD signal that DP
> AUX controllers needed to wait for HPD themselves at the beginning of
> their transfer() callback. The fact that the wait for HPD at the
> beginning of transfer() was awkward/problematic was the whole reason
> wait_hpd_asserted() was added.
>
> Let's make it obvious that if a DP AUX controller implements
> wait_hpd_asserted() that they don't need a loop waiting for HPD at the
> start of their transfer() function. We'll still allow DP controllers
> to work the old way but mark it as deprecated.
>
> [1] https://lore.kernel.org/r/20240315143621.v2.3.I535606f6d4f7e3e5588bb75c55996f61980183cd@changeid
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I would consider changing the docs to say that implementing
> wait_hpd_asserted() is actually _required_ for any DP controllers that
> want to support eDP panels parented on the DP AUX bus. The issue is
> that one DP controller (tegra/dpaux.c, found by looking for those that
> include display/drm_dp_aux_bus.h) does populate the DP AUX bus but
> doesn't implement wait_hpd_asserted(). I'm actually not sure how/if
> this work on tegra since I also don't see any delay loop for HPD in
> tegra's transfer() callback. For now, I've left wait_hpd_asserted() as
> optional and described the old/deprecated way things used to work
> before wait_hpd_asserted().
>
>  include/drm/display/drm_dp_helper.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
> index a62fcd051d4d..b170efa1f5d2 100644
> --- a/include/drm/display/drm_dp_helper.h
> +++ b/include/drm/display/drm_dp_helper.h
> @@ -422,7 +422,13 @@ struct drm_dp_aux {
>          * @wait_hpd_asserted: wait for HPD to be asserted
>          *
>          * This is mainly useful for eDP panels drivers to wait for an eDP
> -        * panel to finish powering on. This is an optional function.
> +        * panel to finish powering on. It is optional for DP AUX controllers
> +        * to implement this function but required for DP AUX endpoints (panel
> +        * drivers) to call it after powering up but before doing AUX transfers.
> +        * If a DP AUX controller does not implement this function then it
> +        * may still support eDP panels that use the AUX controller's built-in
> +        * HPD signal by implementing a long wait for HPD in the transfer()
> +        * callback, though this is deprecated.

It doesn't cover a valid case when the panel driver handles HPD signal
on its own.

>          *
>          * This function will efficiently wait for the HPD signal to be
>          * asserted. The `wait_us` parameter that is passed in says that we
> --
> 2.44.0.291.gc1ea87d7ee-goog
>


-- 
With best wishes
Dmitry

