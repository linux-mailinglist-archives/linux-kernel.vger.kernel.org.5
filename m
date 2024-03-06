Return-Path: <linux-kernel+bounces-94512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50118740DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6168B287392
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1DD140E23;
	Wed,  6 Mar 2024 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VnMYL8c8"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5213BAF4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754782; cv=none; b=dcrTGbPct1cuqYBuotRxv7bHKJDnP9uU7/Xm6XWsrjB3evKXdEdCA1BlN4u7KY2CYvTTluJyRtJCbzFQdw97Wv2D1/YXQnrSAIDa1uGAWPdx0Jcb9+qfGqnGY1MIJUsFpWUqZeGzD0HOEF/IWq+261MYvY+1+GOrGXCwtn6J8Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754782; c=relaxed/simple;
	bh=zA6b2D7k6EWEqApIOQnoeySCJz/6P755dOue36qffME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jq1Pqi1KStGubMFnzUiopbemOxFGHnZIxT4Z2OzN2QUVtm1MY/ok1ZU3DQY8UJJUpKXYacBTIknMzIzddPfSEn+slLQCxjouchVSFmH48MWca3k+4sBiJaCmZiqoOD0SC4P9kgOehXAFfwhRtIhADZvWonkv1AOd7wdHe84g5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VnMYL8c8; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso55137276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709754780; x=1710359580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d27KImFrNXS8TH5Uy9ti36RCHItgUnUBpBlO5w+2ibI=;
        b=VnMYL8c8BqsEm0MxumNfTmtMnhSEhMcpH1WmiRk6EKlfEVwTIE7JhRB3XRFveIq2RL
         JKZxfBDuD0N34Pj/cGLYlDFJ3Q2dzpK9LrzWTR7GIMOtWrhfSa/TAp3H1KnDj76oaLRV
         2gSszhtUNSVzED3V21baw7xNHsfYHhqQ+PTY1Ulugh8C/0u5wGlp28eu2Ob1kbDcARxb
         u8YLB78sTeZy0jLyjxUa0UKZDa+uQOUtuS+BJKYdQFbsnhHtkr0ITGJQAqbFq9vW+KzL
         N9kKaGymUJpm75xpf7V9o3PPA1E5+LjUspoYeHucgg42x9wnRbotInsdqHgUr2BY9YWO
         D0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709754780; x=1710359580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d27KImFrNXS8TH5Uy9ti36RCHItgUnUBpBlO5w+2ibI=;
        b=b9rBlvDHWrWTqLq7uy+Xp+Fek0aS1NFZyta5ULJzpSa0uTj2pbSkOEcdLVJC+/nyTS
         TpU6RtTsilwMV0IBZB8GoN17ksa/H8Od2onCNGg6lpUTxf8tJSZNz7PtBwLNhkTXY7UB
         XkpG5OCHqYuqtjdvSsxEpSNyZSCiOFxdYvE6uiyVdDYYZxO1xU54WGiHB21G44IHmCxn
         ykgiW0hXLqKEni/wWjVAh6S4Hlp1jQW2l40LD8GK1YF/+NCoIwYsi8aavOaio0JoAPfI
         LhZAnfyWCflY3c1he9HdiyrhgQGQ5m0fyBDIcKPsc/5HAofBDlL/w1/bt6aFjVXcDFG2
         BUgg==
X-Forwarded-Encrypted: i=1; AJvYcCXbx1gLq0I4amiByJ5oV+3cuBw7ucAJzCq7r8JCK/8hKM7mVDNPXAXZanS8E07a2eYvhYgaxtkvc6dNct9OXE5/0YJvqrZwMOVo4lYZ
X-Gm-Message-State: AOJu0YzQjGJYAN8uHtv8VZU7vhomSIyDOi3vJGYA9DU6MbNxV8Z0vt6q
	dZSqF585HqJtTw1ihlbflVYmSMeskPg6qMZBJmZYzccU/oCpSVMqI2SgncFTaD04u7OSVgqaz3Z
	Z8SCo6A7I/RpYI6HG3C6G8GQOuf0ure28FucBQA==
X-Google-Smtp-Source: AGHT+IGHfNDjfh7hFs/ZwG4KT9lA9AimK6yKN74rJTfSS+TfmaWUA5IQ4eiis9rUmiQWP7vtu12pPVkJnV3wZTUiXuk=
X-Received: by 2002:a25:8a08:0:b0:dbe:4f15:b5cf with SMTP id
 g8-20020a258a08000000b00dbe4f15b5cfmr12953825ybl.15.1709754780141; Wed, 06
 Mar 2024 11:53:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306195031.490994-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20240306195031.490994-1-quic_abhinavk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 6 Mar 2024 21:52:48 +0200
Message-ID: <CAA8EJpq=5=L5RdVZRkf=e2wyjQufnSzEC+=19FjCCF9S6SSEJA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/msm/dp: move link_ready out of HPD event thread
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	swboyd@chromium.org, quic_jesszhan@quicinc.com, quic_parellan@quicinc.com, 
	quic_khsieh@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 21:50, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> There are cases where the userspace might still send another
> frame after the HPD disconnect causing a modeset cycle after
> a disconnect. This messes the internal state machine of MSM DP driver
> and can lead to a crash as there can be an imbalance between
> bridge_disable() and bridge_enable().
>
> This was also previously reported on [1] for which [2] was posted
> and helped resolve the issue by rejecting commits if the DP is not
> in connected state.
>
> The change resolved the bug but there can also be another race condition.
> If hpd_event_thread does not pick up the EV_USER_NOTIFICATION and process it
> link_ready will also not be set to false allowing the frame to sneak in.
>
> Lets move setting link_ready outside of hpd_event_thread() processing to
> eliminate a window of race condition.
>
> [1] : https://gitlab.freedesktop.org/drm/msm/-/issues/17
> [2] : https://lore.kernel.org/all/1664408211-25314-1-git-send-email-quic_khsieh@quicinc.com/
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 068d44eeaa07..e00092904ccc 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -345,8 +345,6 @@ static int dp_display_send_hpd_notification(struct dp_display_private *dp,
>                                                          dp->panel->downstream_ports);
>         }
>
> -       dp->dp_display.link_ready = hpd;
> -
>         drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
>                         dp->dp_display.connector_type, hpd);
>         drm_bridge_hpd_notify(bridge, dp->dp_display.link_ready);
> @@ -399,6 +397,8 @@ static int dp_display_process_hpd_high(struct dp_display_private *dp)
>                 goto end;
>         }
>
> +       dp->dp_display.link_ready = true;

Do we need any kind of locking now?

> +
>         dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
>
>  end:
> @@ -466,6 +466,8 @@ static int dp_display_notify_disconnect(struct device *dev)
>  {
>         struct dp_display_private *dp = dev_get_dp_display_private(dev);
>
> +       dp->dp_display.link_ready = false;
> +
>         dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
>
>         return 0;
> @@ -487,6 +489,7 @@ static int dp_display_handle_port_status_changed(struct dp_display_private *dp)
>                 drm_dbg_dp(dp->drm_dev, "sink count is zero, nothing to do\n");
>                 if (dp->hpd_state != ST_DISCONNECTED) {
>                         dp->hpd_state = ST_DISCONNECT_PENDING;
> +                       dp->dp_display.link_ready = false;
>                         dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
>                 }
>         } else {
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

