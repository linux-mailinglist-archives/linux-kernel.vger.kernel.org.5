Return-Path: <linux-kernel+bounces-2424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CDF815CF1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 02:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DB21F222E1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 01:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC6DA35;
	Sun, 17 Dec 2023 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AtICvnj/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BBD7F4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cc63b3ed71so6894991fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 17:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702775298; x=1703380098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZvP4fL3Nz75ZyOFfSnsYpgH0MiazCjRnOKU1EHMPm8=;
        b=AtICvnj/OVGwwOt5zt4wNyDHbEdWlRqakgbuQ6TZxvOS32jXk6boHfvMdZJxhRdfYb
         XYfdSGO/1BqJVgI6Ci3IswEpTFidvF3k4T47EZJa2xYExVMAFs/Mq4vwsI5H6rZpkURF
         DGpYLJXC307vegjMxV6fbPwooYP6ZorFnc7oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702775298; x=1703380098;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZvP4fL3Nz75ZyOFfSnsYpgH0MiazCjRnOKU1EHMPm8=;
        b=mf4R20nIH8WJ2KKT4FwroS6E0N0aoWYFUPFdfpVVaC2Uwy70Rhg5LmB4zBYlleVdg2
         dO1zTB1nQwmZsq3tahIf1olNYVgwjjp/rynn3AkitkGPtf0O1xcyshKILn14QtBvKIQy
         2+cPs4nn44Ow7ZQMcJMm5ZprjlMIXL0Y9bNFCr/H9x7ti8FrJtwXgTnYptXyLcMyIu9L
         ZGWasDfswMbnFcYq4ix8gJtdiQB33DDVC/CGE8fCGRpBS0qQXAyuj1ZtKInSyHa4H78o
         JR9gA9VScb7qM6CawW3zk6uCB6kfvfiF1HqeHUU83nJrdCo5h1oEwK8IioGpZ6MUSekS
         9/HQ==
X-Gm-Message-State: AOJu0YyteQPrh3d2qB4lpN+pNF+TjUTutx1qLSFYzBO8Pa8DPSqF3ewG
	elreiO+qM6dr6MMhBnRZ+XuttguDWqMs3JttTse6EQ==
X-Google-Smtp-Source: AGHT+IEtsTVdo91RRo/T0ysvJXNkeuxkKFctEkemIJaU/LFJ344lorZ2hh3+CSEcbgLa2Zg87ZJvzN4cpfivGY6x0e4=
X-Received: by 2002:a05:651c:2002:b0:2cc:30dd:1b59 with SMTP id
 s2-20020a05651c200200b002cc30dd1b59mr3443489ljo.84.1702775297334; Sat, 16 Dec
 2023 17:08:17 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 Dec 2023 01:08:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231214123752.v3.2.I7b83c0f31aeedc6b1dc98c7c741d3e1f94f040f8@changeid>
References: <20231214123752.v3.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
 <20231214123752.v3.2.I7b83c0f31aeedc6b1dc98c7c741d3e1f94f040f8@changeid>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Sun, 17 Dec 2023 01:08:16 +0000
Message-ID: <CAE-0n52nK6fs_K8s1pfwGw0K_6HCzAMPfjNruxkVmWZfbEUTDA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/bridge: ti-sn65dsi86: Never store more than
 msg->size bytes in AUX xfer
To: Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org
Cc: Guenter Roeck <groeck@chromium.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Douglas Anderson (2023-12-14 12:37:52)
> For aux reads, the value `msg->size` indicates the size of the buffer
> provided by `msg->buffer`. We should never in any circumstances write
> more bytes to the buffer since it may overflow the buffer.
>
> In the ti-sn65dsi86 driver there is one code path that reads the
> transfer length from hardware. Even though it's never been seen to be
> a problem, we should make extra sure that the hardware isn't
> increasing the length since doing so would cause us to overrun the
> buffer.
>
> Fixes: 982f589bde7a ("drm/bridge: ti-sn65dsi86: Update reply on aux failures")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

