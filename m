Return-Path: <linux-kernel+bounces-166517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD988B9BC1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50B5284181
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212FE13C3FF;
	Thu,  2 May 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPUfs/ob"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26B041C60
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657323; cv=none; b=EzqMJCJOrK5sGvQQdiljjo4brFUFg2HaF7KfEKcBo8JTgu4+4XaPFxDmzS8haB7fBLgWpwqvhf4C6NDJ8y+e+JhTVptPgmRIxmXAjQh+HRq3JnJQ2FzSPqlwoGiHZ8bS7AQUWf46ZHqpAGYZZ8kLbpCvf9eYdg1w6EyJLMfMiGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657323; c=relaxed/simple;
	bh=6mNAUPwTXtGNfeXAY0CnFqxe0yDpZcMGNhXVEGvyMYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zcdis8qiZMynJmn7cy1FFjYZmO1QV68DrwWwq8WVums4K/xrrF6eCVbR24+WeoekMpLTi5vwUzihYF9cOffyhht1VdJq/NK92HWYshoOzq6qn1Pjib0LycZCC9UBJDgOMWG11swiKArivlKyp6EBZq9ZCS7XzCVpG+0Hlyir1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LPUfs/ob; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so8420392276.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714657321; x=1715262121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSQ9jjwtyIhReugDAg/DErQbocu2WPTjK2mXdU1pXf0=;
        b=LPUfs/obVIC0p8qEqmAhAXHQi7/2rFcI59Ndda4DexG8R2eQaT5Pgq33Tax6FeGD9U
         ZM2r/96Zj3/oTl1oCJnjNig38JIfWxsBzplATGe6YNLdGagZIxXqaty2ZlRo4t4TQ9Ei
         rPVCnOZgrw8Yay74sSLWC7bgZ/7+06HXorTUe2M3Dx4SJvh6r3mHDwCCI2M+KybOnPQV
         q7brmXKnCX2xyOc1HdduzDkaTuIoUmrJ54tTadoaoH4qi4CvdR+umRHvnxt48LdKl0jf
         9q8uFvJ+sQenVIHbsiLUDxN3lw1XSMiS8CRXxmrbOe5f2vEQAXI0FV0UAp4SVkxZvzl+
         gQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714657321; x=1715262121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSQ9jjwtyIhReugDAg/DErQbocu2WPTjK2mXdU1pXf0=;
        b=A+8pP0DxBUigss3S6RAqnc/21FocDcxXLrkJ4rtJdPTt7Axha7ATbdUib3n0j4s+qL
         OB2jY8pOJBBKJPs5AgfZ2dP7CqmJ1O546dfG1ZyOo85yvuFdVKxrVEmMfnjGCPkJr4SL
         /Ph1EvF4e47eTa/NUY1lRId6f0r1+zaSQn8yaSWXQFbdvrlIWRr7vd6n+jVX42O6boDF
         SJNafCjqiFnt0GQBuXzhXv/Zx1tDEkK29BjjRDEjtE0l1rgMEquL97mp5rr3L+ev2IBE
         xNYnXaLbcLpLGQuMyoKRPRqn5vN3y6QEmHAahsFrnTjlTNyFiguCDvuwdmjJtbDgQqsj
         iv8w==
X-Forwarded-Encrypted: i=1; AJvYcCW42XaNnbHHhglcKdYxU85nZoUJZ77DBsxVIB9JkN9jrhL63luCKNhtLbwffRxOhQHdPfr9zSkMQ0hYlTbCcccsDvgLWG1yQLGOL/gs
X-Gm-Message-State: AOJu0Yw0nVpDxMduDjWyEWujya5JxdkdIwOlioLugv+bsx55GBt8Bk2J
	t44CaUMThXSZx78VySxoUsfasgio+51UKs2LrStKHAeZB6+PnHqw9t5gjy7R4S6UFBWhMXte8hY
	OktCstork9s5vMDd50gsjMtQ7dHBsVdxtQX265A==
X-Google-Smtp-Source: AGHT+IFnyaNOlkzEnYx4fySQeWTRVZOBY9XK6ANMyQKfRl+c5CgqI/KpfwGJX+7xZ2lVwZT21nYQ5vgQh0qY2R92CeE=
X-Received: by 2002:a25:dc09:0:b0:de6:12ce:abce with SMTP id
 y9-20020a25dc09000000b00de612ceabcemr5746180ybe.43.1714657320644; Thu, 02 May
 2024 06:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501154251.3302887-1-dianders@chromium.org> <20240501084109.v3.7.Ib5030ab5cd41b4e08b1958bd7e51571725723008@changeid>
In-Reply-To: <20240501084109.v3.7.Ib5030ab5cd41b4e08b1958bd7e51571725723008@changeid>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 15:41:49 +0200
Message-ID: <CACRpkdYiND3uLAbFqyGEYgi5+ycOTYoncmSYGTsYtTZ7Ox=4DQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] drm/panel: boe-tv101wum-nl6: Don't use a table for
 initting panels
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, Hsin-Yi Wang <hsinyi@google.com>, 
	Brian Norris <briannorris@chromium.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Javier Martinez Canillas <javierm@redhat.com>, 
	Joel Selvaraj <jo@jsfamily.in>, lvzhaoxiong@huaqin.corp-partner.google.com, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 5:43=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:

> Consensus on the mailing lists is that panels shouldn't use a table of
> init commands but should instead use init functions. With the recently
> introduced mipi_dsi_dcs_write_seq_multi() this is not only clean/easy
> but also saves space. Measuring before/after this change:
>
> $ scripts/bloat-o-meter \
>   .../before/panel-boe-tv101wum-nl6.ko \
>   .../after/panel-boe-tv101wum-nl6.ko
> add/remove: 14/8 grow/shrink: 0/1 up/down: 27062/-31433 (-4371)
> Function                                     old     new   delta
> inx_hj110iz_init                               -    7040   +7040
> boe_tv110c9m_init                              -    6440   +6440
> boe_init                                       -    5916   +5916
> starry_qfh032011_53g_init                      -    1944   +1944
> starry_himax83102_j02_init                     -    1228   +1228
> inx_hj110iz_init.d                             -    1040   +1040
> boe_tv110c9m_init.d                            -     982    +982
> auo_b101uan08_3_init                           -     944    +944
> boe_init.d                                     -     580    +580
> starry_himax83102_j02_init.d                   -     512    +512
> starry_qfh032011_53g_init.d                    -     180    +180
> auo_kd101n80_45na_init                         -     172    +172
> auo_b101uan08_3_init.d                         -      82     +82
> auo_kd101n80_45na_init.d                       -       2      +2
> auo_kd101n80_45na_init_cmd                   144       -    -144
> boe_panel_prepare                            592     440    -152
> auo_b101uan08_3_init_cmd                    1056       -   -1056
> starry_himax83102_j02_init_cmd              1392       -   -1392
> starry_qfh032011_53g_init_cmd               2256       -   -2256
> .compoundliteral                            3393       -   -3393
> boe_init_cmd                                7008       -   -7008
> boe_tv110c9m_init_cmd                       7656       -   -7656
> inx_hj110iz_init_cmd                        8376       -   -8376
> Total: Before=3D37297, After=3D32926, chg -11.72%
>
> Let's do the conversion.
>
> Since we're touching all the tables, let's also convert hex numbers to
> lower case as per kernel conventions.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Wow that's a *VERY* nice patch.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

The metrics surprisingly reports more compact object code,
I wasn't expecting this, but it's nice.

Yours,
Linus Walleij

