Return-Path: <linux-kernel+bounces-4514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A7C817EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43221F24454
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3621510E6;
	Tue, 19 Dec 2023 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CpDgUQwN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CB67F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cc7087c6c4so21146081fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702945157; x=1703549957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeNDDsbD/q7ceEEjIte9s05PpXvza3fs70vppdU/svU=;
        b=CpDgUQwNmc3InyjtkprOnylYIgVkbX3rzD+ke3jxK1/+dNFVVe/Mjw2WxUJSh/0reg
         61a1ZsFvdSmCw/tLJbKDPIkJUiVyC5SjTLo7+mYysmit80nslr9YksWhCgOcpOoyirWf
         5nNXRnYcL8/Xorci/7yfvvY0qbglYoRNlwXO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702945157; x=1703549957;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeNDDsbD/q7ceEEjIte9s05PpXvza3fs70vppdU/svU=;
        b=f2l0Y01qZwPfFN6zXINucSHaEr3KOcffJBQRoPVcI/noL+3bUSZ0OGw23l32At/Qru
         Q4k4+hUAB1v1dL+FUiK4LsdSoiLcZYcENMfnm8O2+mlrTxUc29Y1BPZ1YSsc2TzRJwgc
         IKmxK2nqLjyvWyF0SRugyFEz5P6v+FemmVRXpS3gm1ojJ4eeADYkPwEVdc41VU8cXB7x
         /85mzR5ojqSGwkIMz0hY6Cq3fHMoRmD5JH3OReOYXXB6Y8k7jxyClLp8ZPySaUWwUXgD
         AJKVpdqbyrfUCxxAGZL6nYJtn3h3B1m1f3fBfImKs1JBbyCc+JonE4w1yanHD13u9VEd
         r6pw==
X-Gm-Message-State: AOJu0YyO+ldLpvNUJSRtS8KPWz3TToPjYdgZ2wTAxlSLT2pI7LnxzPpz
	eulaZUe9en/V4IrdG3agYeSaTVW1mjKqaGjTMseyXw==
X-Google-Smtp-Source: AGHT+IFZXiTnaut+pYNCIhuF7uLHM9Suzdi9wtNFcOj+Q77V4jTh9t2mK8I18XuFgpCeLN7qbT2/xQFDDL9J7CuLQlg=
X-Received: by 2002:a2e:9ec4:0:b0:2c9:f108:9ae6 with SMTP id
 h4-20020a2e9ec4000000b002c9f1089ae6mr7701234ljk.1.1702945156916; Mon, 18 Dec
 2023 16:19:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Dec 2023 00:19:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231218090454.1.I5c6eb80b2f746439c4b58efab788e00701d08759@changeid>
References: <20231218090454.1.I5c6eb80b2f746439c4b58efab788e00701d08759@changeid>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 19 Dec 2023 00:19:16 +0000
Message-ID: <CAE-0n51hzBrZLwze4-2z+P56KYM6JucpQxmUx1s+D9+VK-f+sA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Fix size mismatch warning w/ len
To: Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org
Cc: Guenter Roeck <groeck@chromium.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Douglas Anderson (2023-12-18 09:04:54)
> After commit 26195af57798 ("drm/bridge: ps8640: Drop the ability of
> ps8640 to fetch the EDID"), I got an error compiling:
>
>   error: comparison of distinct pointer types
>   ('typeof (len) *' (aka 'unsigned int *') and
>    'typeof (msg->size) *' (aka 'unsigned long *'))
>   [-Werror,-Wcompare-distinct-pointer-types]
>
> Fix it by declaring the `len` as size_t.
>
> Fixes: 26195af57798 ("drm/bridge: ps8640: Drop the ability of ps8640 to fetch the EDID")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

