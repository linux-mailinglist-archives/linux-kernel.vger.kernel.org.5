Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B680579F107
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjIMSUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMSUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:20:41 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C28419BF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:20:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bf924f39f1so1488521fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694629233; x=1695234033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VOQaOs8o5B9GH/mmvpD1aOyQRsVO5OINT7Nf+9h0Zg=;
        b=aYv6Z5EEyCsF/MeaO8m0aGUzuIU/GAs6RNpvVDoHF2Gu/3PM+3Qqjsao6P0mHtFAFD
         RO9ic2hciivZfez6BUOYb6QUndRwe5X9VJrxeIsAoRQ3LS1uZ5WKFqhBunjtDiN+/iN7
         idW+4VD8ZH/eA5mslf+nt2ywJC1hqKNIQVv4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694629233; x=1695234033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VOQaOs8o5B9GH/mmvpD1aOyQRsVO5OINT7Nf+9h0Zg=;
        b=TFj273rFLedzmh7xV/ladWVIlLkuHajQlnKFKUozIyt+IZ8aJ/eHCe1eyANRHpNjwU
         AMYLznMdKhsiDeJocFuY/jQbt/iYPLtBjas4Z/vbSGHP1hd/DmDKvjkJwGzL9mrnEgVt
         DMsEeMZ64x7isUm43AtB4LHu23BNWqOx8CmnZ1rTS8/JQ242gKnvrI24toX9GPFBOPSm
         IeTyfd1BsZe92TbLfy/z5JHLy/vQp/QKEwbMBXQfVGf1aBp21CXCH6g+5Eay/gAPW6VU
         IrBb+ciIyl/cPtWb2sw9ViUCOvrkUt9yxvMxz1hXVgthCaZ8La+2EYkeo7QyczZZ5Jj2
         v63g==
X-Gm-Message-State: AOJu0YxKjm6hewV+1ZJFYNCRY5Rs5zSDG2SxwNKdntD/9H9bLLEtu1cQ
        VVkMxl2S8O+QFyHWnfEQMfSD4iMz6SYtLFBavIWO7vye
X-Google-Smtp-Source: AGHT+IHxP8Tf6HYElCYVq4KbNSzazvpRXsQf0AQWJgSjb8ygIPCmJa0g6Wmi9OoBdC9Oyg2ODnG3GA==
X-Received: by 2002:a2e:9556:0:b0:2b9:e304:5f82 with SMTP id t22-20020a2e9556000000b002b9e3045f82mr2881194ljh.13.1694629233159;
        Wed, 13 Sep 2023 11:20:33 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090690ce00b0099c53c44083sm8766700ejw.79.2023.09.13.11.20.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 11:20:32 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso10325e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:20:32 -0700 (PDT)
X-Received: by 2002:a05:600c:3581:b0:3fe:eb42:7ec with SMTP id
 p1-20020a05600c358100b003feeb4207ecmr162996wmq.1.1694629231997; Wed, 13 Sep
 2023 11:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230804210644.1862287-1-dianders@chromium.org> <20230804140605.RFC.1.Ia54954fd2f7645c1b86597494902973f57feeb71@changeid>
In-Reply-To: <20230804140605.RFC.1.Ia54954fd2f7645c1b86597494902973f57feeb71@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Sep 2023 11:20:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vy0EALn6rEdYeSUNYBj=h3UOB+NrPfhtfgNSSQqU988A@mail.gmail.com>
Message-ID: <CAD=FV=Vy0EALn6rEdYeSUNYBj=h3UOB+NrPfhtfgNSSQqU988A@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] drm/panel: Don't store+check prepared/enabled
 for simple cases
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 4, 2023 at 2:07=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> As talked about in commit d2aacaf07395 ("drm/panel: Check for already
> prepared/enabled in drm_panel"), we want to remove needless code from
> panel drivers that was storing and double-checking the
> prepared/enabled state. Even if someone was relying on the
> double-check before, that double-check is now in the core and not
> needed in individual drivers.
>
> This pile of panel drivers appears to be simple to handle. Based on
> code inspection they seemed to be using the prepared/enabled state
> simply for double-checking that nothing else in the kernel called them
> inconsistently. Now that the core drm_panel is doing the double
> checking (and warning) it should be very clear that these devices
> don't need their own double-check.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  .../drm/panel/panel-asus-z00t-tm5p5-n35596.c  |  9 -----
>  .../gpu/drm/panel/panel-boe-bf060y8m-aj0.c    |  9 -----
>  drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c  |  9 -----
>  drivers/gpu/drm/panel/panel-novatek-nt35950.c |  9 -----
>  drivers/gpu/drm/panel/panel-novatek-nt36523.c | 12 ------
>  drivers/gpu/drm/panel/panel-raydium-rm68200.c | 38 -------------------
>  .../panel/panel-samsung-s6e88a0-ams452ef01.c  | 10 -----
>  drivers/gpu/drm/panel/panel-samsung-sofef00.c |  9 -----
>  .../gpu/drm/panel/panel-sharp-ls060t1sx01.c   | 10 -----
>  drivers/gpu/drm/panel/panel-sony-td4353-jdi.c |  9 -----
>  .../panel/panel-sony-tulip-truly-nt35521.c    | 18 ---------
>  .../drm/panel/panel-startek-kd070fhfid015.c   | 11 ------
>  drivers/gpu/drm/panel/panel-truly-nt35597.c   | 20 ----------
>  drivers/gpu/drm/panel/panel-visionox-r66451.c | 16 --------
>  .../gpu/drm/panel/panel-visionox-rm69299.c    |  8 ----
>  .../gpu/drm/panel/panel-visionox-vtdr6130.c   |  9 -----
>  16 files changed, 206 deletions(-)

In response to the cover letter [1], I proposed landing patches #1-#3
directly from here while we resolve the issues talked about in
response to patch #4 [2]. I didn't hear any complaints, so I took
Linus W's review tag from the cover letter and pushed this to
drm-misc-next.

f8c37b88092e drm/panel: Don't store+check prepared/enabled for simple cases

[1] https://lore.kernel.org/r/CAD=3DFV=3DUFuUsrrZmkL8_RL5WLvkJryDwRSAy_PWTa=
-hX_p0dF+Q@mail.gmail.com
[2] https://lore.kernel.org/r/20230804140605.RFC.4.I930069a32baab6faf46d6b2=
34f89613b5cec0f14@changeid/
