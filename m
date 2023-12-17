Return-Path: <linux-kernel+bounces-2423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCA8815CEC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 02:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8DA28472D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 01:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D741863;
	Sun, 17 Dec 2023 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="amZUIfDT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647E17EB
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e2786e71fso934005e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 17:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702775176; x=1703379976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4WycKPSFzunUdkSJRY1N3XmhnoQWoEYL5xkeoe24vI=;
        b=amZUIfDTyJkLgazRup7wqFQS11NgBMNH61g3pUbyHBxO/XWFj1EKmR1Om3tByV2WAq
         i9+GdH3hc4tUgiWvb6OnLqfxshTeNbm3iCbsJzL+/kivFZfGtWGn/g9RFoSvINXxHaus
         qu/V3UqzMZq3zzA+nRcr3Pdqdjtol80Be1hsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702775176; x=1703379976;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4WycKPSFzunUdkSJRY1N3XmhnoQWoEYL5xkeoe24vI=;
        b=jZq2aYhXE60H4bB02vNetssJ5vi5ZfdAcW9TUhEjdXOwtobgqvC8x2f7sTwH1Tk6id
         SCdGgcod3bLSJqzyI1N0+FUgjO+DTanUbHXlnCr/R3a2Z6zvtdORrm/icLpC/Yhi4KYb
         ySopLi7dLqDYPqaqaE0hUnLXCZLHuCeq5mImXBAmNFQqATyAAtgitUNAHiNrzUcnzSWW
         eJdJ2szChcAnXVQ/+WRJBcQNcK1NDT8Q/ElZ3oxnRjzUInisXQyQyfuKuzMbr/JfFc0C
         KQwGmvAt+AwVe4lQnVmB0B3piXzl8ug8kT0kO++17EpOo8oDMjxZYBi10w5YS1r0RB/1
         9P8g==
X-Gm-Message-State: AOJu0Yz4Ww03jySv5SHLI1AJTcVbrfNN9vY+LTUqy7hqfqHL7mq/N6OD
	OCoYhBorZfm9pb9vVj1A5n0Fm5ci6v1urWz4JGlRgw==
X-Google-Smtp-Source: AGHT+IFO9xNmf66MdIUeGEiEWBXaFelFHf4mK55JIAy/3AVccBXR5tgQMzTNwFyMQT05VUEWPQ2FtQBbNhcIVJ+J328=
X-Received: by 2002:a05:6512:33c2:b0:50e:1a9f:3c36 with SMTP id
 d2-20020a05651233c200b0050e1a9f3c36mr2788651lfg.15.1702775176464; Sat, 16 Dec
 2023 17:06:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 Dec 2023 01:06:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231214123752.v3.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
References: <20231214123752.v3.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Sun, 17 Dec 2023 01:06:16 +0000
Message-ID: <CAE-0n51EkQt2FbwJUaXqkohwEGRzZ1qYw8c3+cY3o_ubj+YN2w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/bridge: parade-ps8640: Never store more than
 msg->size bytes in AUX xfer
To: Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org
Cc: Guenter Roeck <groeck@chromium.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Philip Chen <philipchen@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Douglas Anderson (2023-12-14 12:37:51)
> While testing, I happened to notice a random crash that looked like:
>
>   Kernel panic - not syncing: stack-protector:
>   Kernel stack is corrupted in: drm_dp_dpcd_probe+0x120/0x120
>
> Analysis of drm_dp_dpcd_probe() shows that we pass in a 1-byte buffer
> (allocated on the stack) to the aux->transfer() function. Presumably
> if the aux->transfer() writes more than one byte to this buffer then
> we're in a bad shape.
>
> Dropping into kgdb, I noticed that "aux->transfer" pointed at
> ps8640_aux_transfer().
>
> Reading through ps8640_aux_transfer(), I can see that there are cases
> where it could write more bytes to msg->buffer than were specified by
> msg->size. This could happen if the hardware reported back something
> bogus to us. Let's fix this so we never write more than msg->size
> bytes. We'll still read all the bytes from the hardware just in case
> the hardware requires it since the aux transfer data comes through an
> auto-incrementing register.
>
> NOTE: I have no actual way to reproduce this issue but it seems likely
> this is what was happening in the crash I looked at.
>
> Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX channel")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

