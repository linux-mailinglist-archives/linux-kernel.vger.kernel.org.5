Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7703A7BD684
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345706AbjJIJNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345660AbjJIJNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:13:18 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA9BC5;
        Mon,  9 Oct 2023 02:13:15 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1dcdfeb7e44so3038335fac.0;
        Mon, 09 Oct 2023 02:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696842793; x=1697447593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+6j4vvxY4EqozcmVPKocYKAhoEnZR1RKLlrR38PBlyo=;
        b=d6ziKF0S2B2Sl1ewD2umYwSmLlmj3LWmdBQgnVrRNnwxBuwGo9Gco/pfaLj0V945/t
         tIO0kWWckdVF6LLUP2rT3i2LJMayvOiXPj2fWYGWkQgm9uRjEmIa/Tv9ZoPfuMUU/gDd
         Nh+dCBIuhTQQYeqsSTSNN/2TTLwDQHp6h9zKDTKUByJep1OqU3xP1KMnpHfHgNhp9O2D
         vEBQaa4cPcoXnMw2XltATKY9PNEfA6gtk1ZeQ3fCckvdQWE15vYplhm6gfvSPyapjLSX
         zqcIfS3mnPf/BqNtX5HTvXKecR9zSEralYad7sj43qWcX2HT3un9DHc73fLwtczD05NR
         w1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696842793; x=1697447593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6j4vvxY4EqozcmVPKocYKAhoEnZR1RKLlrR38PBlyo=;
        b=rslnCnzN44sURSdwQhT4bGfPwtfjxa551Q34b2nOxwr1Dz/AGafKbL6tqo+hGMpeOf
         AleXiPuL4cuo+gisOc6EqqANn4VKhlWefQgbNGi4tXTGM9fqkeGkuUDtpoyF3SzNQW8Q
         zs6XHt1ZUM+Pdi/x3nOD+go2+5/iE61FzoPukMayIqZvJ97auLwWS4WTV6Shhz/Rf97h
         ohm+O/dVZhpvAgJ7ZJ4y6V1h8n/GrfzCMaA+4SYKxMjmMklcwX0xoG+3PJl3tFgQQhI7
         tlqHfdZE0DYiN8ESSqrTPD0Q25llS+bEUXVzZtD0qljCG4vvtKaQQLn3/xKshq6g5sBY
         r5cA==
X-Gm-Message-State: AOJu0YxZKkCg5KDAizzAJ7Ae4Isl4TKoCtJ6n3uYvyPDxfgmSQEtR6m+
        fkYyKQkEFXKfvgamXBo9HRY7uFKBoDL/X32lyUKAs0RMSF3/MA==
X-Google-Smtp-Source: AGHT+IFC5K5ukyGxfSgYqssv30cv3lVT+tGyeW1gq1ro6ijzaWIOfHM87jWQp/uZiGRud8xNqHx7+THodnZg3ePCxhs=
X-Received: by 2002:a05:6870:5ba0:b0:1be:f8d9:7bdd with SMTP id
 em32-20020a0568705ba000b001bef8d97bddmr18638659oab.6.1696842793555; Mon, 09
 Oct 2023 02:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-v2-1-8ae12071c138@google.com>
 <202310061323.05B262D@keescook>
In-Reply-To: <202310061323.05B262D@keescook>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 9 Oct 2023 11:13:02 +0200
Message-ID: <CAH9NwWfM2E=M1u_LnRLXkXqbJapR0aga2kex=uc3YBMkdP2fHg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/etnaviv: refactor deprecated strncpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Bo YU <tsu.yubo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr., 6. Okt. 2023 um 22:23 Uhr schrieb Kees Cook <keescook@chromium.org>:
>
> On Mon, Sep 18, 2023 at 01:34:08PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> >
> > We should prefer more robust and less ambiguous string interfaces.
> >
> > A suitable replacement is `strscpy_pad` due to the fact that it
> > guarantees NUL-termination on the destination buffer whilst maintaining
> > the NUL-padding behavior that strncpy provides.
>
> Friend ping. Who can pick this change up?
>

Lucas is the one who is responsible for this job.

>
> Thanks!
>
> -Kees
>
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Cc: Bo YU <tsu.yubo@gmail.com>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
