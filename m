Return-Path: <linux-kernel+bounces-18458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F17825DEB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 03:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15251F245F5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 02:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7015C4;
	Sat,  6 Jan 2024 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyOdidQe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0688B15A0;
	Sat,  6 Jan 2024 02:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2866b15b013so48079a91.0;
        Fri, 05 Jan 2024 18:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704508193; x=1705112993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPX7qJSKC7zBGjoAIF3y+hVE3LHYC0FMBRmwWU1yb78=;
        b=IyOdidQeoly6le+O/+jHoqKwKzJJLKOqw+wdlUAys2YvqNctOrtFz1NeXhVhlP7FsD
         4t/P/8539elDY0/zaBcldAMGf13VQP8Yw4nCiQZH2dC4yzCkOjrPAtK1cp1/qG0rWIGW
         sorRzPnKckwAfgqm0ma9IvqGFH0qLLXohwfFnqTzJTNtxrNeWQM28HruZ5TD4fKoIVu/
         V8lGapKdTwDm03SxON+H2bxp0ArRIx5Y1JxeSyJONJEX1gI6+iaUwpqr9ZrgWllzkoaQ
         4j3rEIhLW6/5n6ePS1k7tfWkBWEEE+oQk0y/WNo6chHm3TvXORGoUfg3wclxDFik7tFK
         2LJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704508193; x=1705112993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPX7qJSKC7zBGjoAIF3y+hVE3LHYC0FMBRmwWU1yb78=;
        b=gDh7uNQn5Vg4Focm3rF99nIxbM+S7p245V4XwR6h2+1FX1I26AQsfLPPprOUnhCK+i
         epAkePYYIqSY8gn3na0r2sYpejTctdjMWc4IPLGy4PYUnuWUC6Q2Z00byUtnELPzWYVC
         DkcI7OwavQpGV5kesrk6QTCy25Oc/XaOO1hKkoLEVfcgGt419t+hJRkaQ7AFMNcbvSsh
         Y8rVloNyX8blAuh4gVr0CWcgnKF0H57QaWbZSwLYTb7sD3miUWX3QJ2Q0+UrfGFFbgWF
         vvbyySKTtlWmvU131cOpvgIJg33EXKXbD2MMkWPINWwVB1v1Q+ax0Qzs5qzrD8jXLpjS
         2O3w==
X-Gm-Message-State: AOJu0YwSX82EFITrDRXbizNH2x8UBFn1+o0VzG8ESDgfJSa7mFP0V9LF
	YV/eQl29HSuRkt6dQ1aME+VFxvIhU261QLd3czs=
X-Google-Smtp-Source: AGHT+IEXDwSaz6j2wlPQbuLx7ykHdUVF2khGx+tE93dmEYsto+uB5HJvfF/6l31SoEAfLfcRScroTs5PvIs9GtN0XGM=
X-Received: by 2002:a17:90a:ab16:b0:28c:fe8c:aa93 with SMTP id
 m22-20020a17090aab1600b0028cfe8caa93mr615127pjq.1.1704508193078; Fri, 05 Jan
 2024 18:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106015623.193503-1-aford173@gmail.com>
In-Reply-To: <20240106015623.193503-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Jan 2024 23:29:41 -0300
Message-ID: <CAOMZO5D6RrTy6e=1gEUKxxR3T5VmqDZmcmR7945qBbnPhihi+A@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] dt-bindings: display: imx: add binding for i.MX8MP
 HDMI PVI
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Lucas Stach <l.stach@pengutronix.de>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Liu Ying <victor.liu@nxp.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adam,

Thanks for moving this forward.

On Fri, Jan 5, 2024 at 10:56=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> From: Lucas Stach <l.stach@pengutronix.de>
>
> Add binding for the i.MX8MP HDMI parallel video interface block.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

You missed your own Signed-off-by tag.

