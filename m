Return-Path: <linux-kernel+bounces-19178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E1E826955
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BEA1F21C5C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E04BA33;
	Mon,  8 Jan 2024 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nh0y+/W+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB6CB65E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbe39a45e8eso673900276.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 00:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704702033; x=1705306833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HMbiqG8ChZxBryomK+7l9NLbRmnfN/R8I1A0uwEXdM=;
        b=nh0y+/W+XOG8evQX3JzFG/Fk2o/ZxrbQV0kPpSCrdBeb7P2RVFz2iiCdNkEJ2Q7iOB
         rmR0Dqc7lEGgEsU4EMDjGMYBxo2ceVVOexMCpA23yqEd/KTdM6ce71vWpfwTASB+AhCH
         /Mln9bLJpkux3dt4RTX9Y9EGSXGM30zJc8sXzf7c8J+nLmOtuMktbeu3C0Y5k/kSIxvd
         ccK3Zo4ALzOV+dxDxVpdLwdSBdIB9+bWTh66wRLpBGIeauHf8z3ZGriogz9hnu8B69fe
         HHGXdNk+hoWxcCiIO5ImGRhgu+AnBKd6jsJDJUJR/QdQ6zyeNYYcdYr2uhKpw8hXxKrl
         0A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704702033; x=1705306833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HMbiqG8ChZxBryomK+7l9NLbRmnfN/R8I1A0uwEXdM=;
        b=f8LSZrJcu2M954S3cGG22P86Ae8sYtkAi+wSiaUneW5q5Q8CCWGx/abDdWE/WafRbV
         WC53OosOYByOt4MMRravYLJIRc5X2a1jF9RVN6j6Geo5XW4woi85UEsiLJR/oFitursM
         tQcJkM+02C5kHNcb+SYmP7UKzrGaMTy//xM9Vc6nA9BruUHH6CG1DseiyUH8mcEivEwS
         aaf5Wu9mSmhGXWsibfKhIk8u4CMnHpDhQjVtCCQ8ER8MIVUUxbDgfN/8358JfZy54DkN
         DGcoPyg4SAA6M8CMFa7maq//MSB8uvbz6fH1Vje+ZLJiplIa/ws44hxD503vp0cfXbqz
         HubQ==
X-Gm-Message-State: AOJu0Yw4DO0nr1MZl6FEsSWM+jwJeaWZ4WuEebwNDJj1P40utqxijK+1
	tSRBeXKU8RjGs7hyM07/tz9/WdKfCVTVMBlGx5o4Esbor0lTgwcGQW186akh
X-Google-Smtp-Source: AGHT+IHMiO4upr0AvuxbnYzHHdp5azUyT28gcKKireut/Cz4/IMtjynVPM39+2xqwQ7S9lhur+XAQpuD6Oa5A17sB0Q=
X-Received: by 2002:a25:9391:0:b0:dbe:cf37:c838 with SMTP id
 a17-20020a259391000000b00dbecf37c838mr866827ybm.1.1704702033344; Mon, 08 Jan
 2024 00:20:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103-si902x-fixes-v1-0-b9fd3e448411@ideasonboard.com>
In-Reply-To: <20240103-si902x-fixes-v1-0-b9fd3e448411@ideasonboard.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 8 Jan 2024 09:20:21 +0100
Message-ID: <CACRpkdbcmh-YwKii=2sHfpZ97Z5mQcz_e0Fy=MqgXrL3qG9QjQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/bridge: sii902x: Crash fixes
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Boris Brezillon <bbrezillon@kernel.org>, Peter Rosin <peda@axentia.se>, 
	Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Jyri Sarha <jsarha@ti.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Nishanth Menon <nm@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 2:31=E2=80=AFPM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:

> Two small fixes to sii902x for crashes.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

These look good to me!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

