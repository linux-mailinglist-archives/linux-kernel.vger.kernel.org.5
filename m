Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F86F75397E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbjGNL3h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 07:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjGNL3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:29:35 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8D92D78
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:29:34 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-579d5d89b41so16764387b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689334174; x=1691926174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZ5pKNtQcVsctQLLt1fcBesVTk5WANpsrcd33LQmiMs=;
        b=RJRjW9g6KIX9acLalUC4mUm+RJWFarYlrjp42tsJt5JNBTB9A/pMjIJagHEWt3ciz5
         TTYeHQh2cSvXO2EscuKLyXSqVOP2JnMuP06XOejrPHBhfrXQxbSsDJ8muURYMWY9QhIj
         hyI+vBozi8iqiOunTzBil0EqsQ6rh4rzQKt6ElVR/0e+a0VTDwvKqq0wl5TSqCt54AWX
         0FVYYli63pgZt/E1Wdjyu5A6evpJ4k6XoB2DEHctHoa3DYKceixO7mhRayhtkifWwDg5
         YMMz46yO8MDLSI3XKP3b++y30Zat9f8j8ILgHljb7hA+aQikNQn4qR8cy9APT1KRvRJV
         SMPA==
X-Gm-Message-State: ABy/qLZz6oELebIc9eh1tff/c/fHJtt8bSUlLCkbIjqeXW2D89Y++J3Y
        8omKqHv881eiKBKYbfz3fC/eLw4j+CeVEw==
X-Google-Smtp-Source: APBJJlGXFtxBSDdIh1pTZ+pCBIUckpwBbRUfQz3dOuOQo/ifIvDyLpMPXoeCCF3lNa0u0DLDba/Prw==
X-Received: by 2002:a81:6cd1:0:b0:57a:8d74:5d9b with SMTP id h200-20020a816cd1000000b0057a8d745d9bmr4865701ywc.42.1689334173952;
        Fri, 14 Jul 2023 04:29:33 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id b126-20020a0dc084000000b0056d443372f0sm2267976ywd.119.2023.07.14.04.29.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 04:29:33 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-cae693192d1so1717515276.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:29:33 -0700 (PDT)
X-Received: by 2002:a25:d045:0:b0:ca9:395f:75f4 with SMTP id
 h66-20020a25d045000000b00ca9395f75f4mr3827226ybg.21.1689334173394; Fri, 14
 Jul 2023 04:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689252746.git.geert@linux-m68k.org> <9090c1b423e0b56c8e906155fe53ff0841830a03.1689252746.git.geert@linux-m68k.org>
 <0KNCLmzXJwmF0RTaQXUBd456dzaM5QsAot8g_yT36aNlEhJbSssTxBOS95x99DJHYkEzUJeMO7zJCX4JGjX6DEmY40BWtLKVZf6nB4HQMSc=@emersion.fr>
In-Reply-To: <0KNCLmzXJwmF0RTaQXUBd456dzaM5QsAot8g_yT36aNlEhJbSssTxBOS95x99DJHYkEzUJeMO7zJCX4JGjX6DEmY40BWtLKVZf6nB4HQMSc=@emersion.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jul 2023 13:29:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUWTse=bOPo7=_4SZK2+ifkpuwbzR797QNNGdy_babygA@mail.gmail.com>
Message-ID: <CAMuHMdUWTse=bOPo7=_4SZK2+ifkpuwbzR797QNNGdy_babygA@mail.gmail.com>
Subject: Re: [PATCH 5/8] drm/client: Convert drm_mode_create_dumb() to drm_mode_addfb2()
To:     Simon Ser <contact@emersion.fr>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Fri, Jul 14, 2023 at 1:01 PM Simon Ser <contact@emersion.fr> wrote:
> On Thursday, July 13th, 2023 at 15:17, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Currently drm_client_buffer_addfb() uses the legacy drm_mode_addfb(),
> > which uses bpp and depth to guess the wanted buffer format.
> > However, drm_client_buffer_addfb() already knows the exact buffer
> > format, so there is no need to convert back and forth between buffer
> > format and bpp/depth, and the function can just call drm_mode_addfb2()
> > directly instead.
>
> By any chance, is the commit message wrong? The title refers to
> drm_mode_create_dumb(), but the description and code refer to
> drm_client_buffer_addfb().

Yes it is, thanks.  Originally, I had copied-and-pasted the wrong
function name. I thought I had fixed all references, but apparently
I missed the one-line summary :-(

Will fix in v2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
