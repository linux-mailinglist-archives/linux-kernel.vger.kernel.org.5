Return-Path: <linux-kernel+bounces-4160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F6F8178A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44253B23034
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3CD5A852;
	Mon, 18 Dec 2023 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H/3pqxVe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6334878F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5534abbc637so1723060a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702920304; x=1703525104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsmrM2oHtRClB02QA8pjdjW9Wbdn73CBnuj1SfAdY/I=;
        b=H/3pqxVeoWDxSZohDemKe0annUfP0d8fGUsUeitPxiFlsBqxhyZwdAjwFjG+umFayD
         ZmXXlCDTuzawCKqIS+RdRQWyrjESSnbkycQsc3Kr5sO0MioTbhIy8Jbn7d+P0uIexL27
         4f+fVwBMJIw8RCzcbGESkPkoyrFTDdTKzSKSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702920304; x=1703525104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsmrM2oHtRClB02QA8pjdjW9Wbdn73CBnuj1SfAdY/I=;
        b=b29Tyf4C6hw9EsTixhwh0QJHWlDAsM5w2SBRQ9tBDm7kqW/pPMclDElaHax5sIFcjx
         BesuTpxKy00pKHLai7GMiBLel4XX3bOZZ/tBmvVrUKJGJbXECS/R0tQ4XcJVfIokeMvB
         t8gpa/lPUDwOtC/Gq78ApOC8gY141J+W1A6yZhq/pI1UvCZ9WuzzgXNXc8iWrTErMAqf
         rGEccI0G5viL3RIYTrEPLsrOTA/Q209m26p228dX0JX+jvtJjamNjgkfaePqy6LYJKO+
         geK3xpWs39DbQCUKPzpnvBVtqFvjGKptRsbDKY9RjB7M/UbE8gqTZYLAyAyRyxaSeQhs
         Q4TA==
X-Gm-Message-State: AOJu0YxfmATwkgy9D3Y0CDdrsf6AXE61zPYmtcP2bV3zsLjhpctbS92+
	xXbLA9UgBKm5QD1G9uAzn1KxxnDqtRmcJi54FaMh3pE6
X-Google-Smtp-Source: AGHT+IHwRpiecl4p65DvWOGT/H/4dxIwU+brSNiZYtGjmwx8Rt9P6OJKVxNBpNXTfINz2cNN8o3ASA==
X-Received: by 2002:a05:6402:1342:b0:54f:5017:e54b with SMTP id y2-20020a056402134200b0054f5017e54bmr8478537edw.34.1702920304461;
        Mon, 18 Dec 2023 09:25:04 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id t16-20020a056402241000b00552743342c8sm4616652eda.59.2023.12.18.09.25.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 09:25:04 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c38e520e2so103875e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:25:04 -0800 (PST)
X-Received: by 2002:a05:600c:3550:b0:40b:4355:a04b with SMTP id
 i16-20020a05600c355000b0040b4355a04bmr365476wmq.6.1702920303831; Mon, 18 Dec
 2023 09:25:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218090454.1.I5c6eb80b2f746439c4b58efab788e00701d08759@changeid>
In-Reply-To: <20231218090454.1.I5c6eb80b2f746439c4b58efab788e00701d08759@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Dec 2023 09:24:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xpp16ptOuQz=5UYfgm8B-WbNXF95YwA1t-FTkzOYRE_A@mail.gmail.com>
Message-ID: <CAD=FV=Xpp16ptOuQz=5UYfgm8B-WbNXF95YwA1t-FTkzOYRE_A@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Fix size mismatch warning w/ len
To: dri-devel@lists.freedesktop.org
Cc: Guenter Roeck <groeck@chromium.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 18, 2023 at 9:05=E2=80=AFAM Douglas Anderson <dianders@chromium=
.org> wrote:
>
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
> Fixes: 26195af57798 ("drm/bridge: ps8640: Drop the ability of ps8640 to f=
etch the EDID")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Sorry for sending this hot on the heels of the other patch, but for
> some reason that other patch compiled fine for me until I picked it
> back to my downstream tree. I'll see if I can track down why. In any
> case, as soon as I see a Reviewed-by tag I'll land this.

Ah, I found it! <Phew> this makes me less worried that I had some
failure in my testing. I believe that upstream things weren't a
problem because of commit d03eba99f5bf ("minmax: allow
min()/max()/clamp() if the arguments have the same signedness.").
...so at least what's landed isn't actually broken upstream, just
downstream. It still feels reasonable to change this to "size_t",
though.

-Doug

