Return-Path: <linux-kernel+bounces-127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C359A813C92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012621C2094A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819B154275;
	Thu, 14 Dec 2023 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MbFXx0ZW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E7154279
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-425928c24easo88121cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 13:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702589186; x=1703193986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mhf9WflZRAY4Fk+Lgl28+c0grxjrzNUPXiwh2v8HVeY=;
        b=MbFXx0ZWXSAOT7kSQeGDiIjmNq2PA3fa+ind5aFIg3B3kDwUGLiwkt7hIjZn2oE2mD
         /hHpeSJOKxg8MbBJTDSokTyMWg19xhrlhGvyXHQV5Fzj8XQY6xg2zs7zw3LvMOPgV0IK
         5F5r7Uw02o7OJkkF5AFyAmkAvbQfbnONmgsXlqsqZJ1hoD5epGWhev15+MmWUC6VEnCD
         F+4GE8hSjqd26v0hg9QkzWwp1/nLtZzkaLAIq8VmF9kyVkofZ6Gu3ga/xerrqEtuCrkt
         SS2tPrSqzxjW3ZhKFqdIScMBmB12B57lXzgRGrVGK+FAbE8Wqod1O3G8ZaTlRrZHiZPt
         Z3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702589186; x=1703193986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mhf9WflZRAY4Fk+Lgl28+c0grxjrzNUPXiwh2v8HVeY=;
        b=djTSLeJlfCdzJ1Z2WiTDGiDIlHqkq0iHI2TRcmo7EbxA1lTDj/NuDOXWmt4wGOC99e
         9375JL9I0BR3cc78X4xYOIc/rHZuwWmRr+YmrFXoao7hSK7FIljoQyeHrAJmsljkoQgA
         Nx2MdJGCcbr5Ek3dd8P4yLDmYcnUpnhCWTD8dizNV3+5aL2cZnITYq02pJhJaKD2+M5D
         Q4+sirMCTIDkCHQyUCumEIOjWqfaOFnh+b4PHxINRVq/fQc6pNi1Pu7nFsWMhhfbaW6O
         LiQ9yRB+DV+Q0ZRZqROv/KhSjcCnIXxmFslC/Z2SHKnZhQvUCKYbP6pWmzSVW5YvjykQ
         1h0Q==
X-Gm-Message-State: AOJu0YzvVovnVWVibi/HUT58Go5dDZ7oiRBpbrhH95F8q5+740ngDyKY
	gUcrY518Zn0DYX5aaujrQ2EgQR7lca51uCiMhC9bCw==
X-Google-Smtp-Source: AGHT+IEwX58D2SeaZ0xdLw5jOv5+L3eK0VxaqundXQosAWlvkMCJnh9yNkkBmuvAaDTMtGEYX2cFo77D/m3frIkB2qs=
X-Received: by 2002:a05:622a:1818:b0:425:946d:4299 with SMTP id
 t24-20020a05622a181800b00425946d4299mr1673126qtc.9.1702589186326; Thu, 14 Dec
 2023 13:26:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214123752.v3.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
In-Reply-To: <20231214123752.v3.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
From: Guenter Roeck <groeck@google.com>
Date: Thu, 14 Dec 2023 13:26:12 -0800
Message-ID: <CABXOdTf2WovgDwcU_oq8QtOhg94KFi+b6biB=za4-8ZTKwnixw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/bridge: parade-ps8640: Never store more than
 msg->size bytes in AUX xfer
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Guenter Roeck <groeck@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Philip Chen <philipchen@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Boyd <swboyd@chromium.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:38=E2=80=AFPM Douglas Anderson <dianders@chromiu=
m.org> wrote:
>
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
> Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX chan=
nel")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v3:
> - Never return more than msg->size as the number of bytes we read.
>
> Changes in v2:
> - Still read all the bytes; just don't write them all to the buffer.
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bri=
dge/parade-ps8640.c
> index 8161b1a1a4b1..d264b80d909d 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -330,11 +330,12 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_d=
p_aux *aux,
>                                 return ret;
>                         }
>
> -                       buf[i] =3D data;
> +                       if (i < msg->size)
> +                               buf[i] =3D data;
>                 }
>         }
>
> -       return len;
> +       return min(len, msg->size);
>  }
>
>  static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
> --
> 2.43.0.472.g3155946c3a-goog
>

