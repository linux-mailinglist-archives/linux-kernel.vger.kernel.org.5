Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70087911AE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 08:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbjIDG5F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Sep 2023 02:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjIDG5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:57:04 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCE311D;
        Sun,  3 Sep 2023 23:57:00 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5922b96c5fcso10947337b3.0;
        Sun, 03 Sep 2023 23:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693810620; x=1694415420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Qt1h+KcRhcARBqVl0JQIPp9LYHPCSaiLn/hvDrNKng=;
        b=f3qeChN39tE7Wqa5gwC84pVRVkP/7ryI1/9wkumU3pvNM+0Aczoimt/R8pmlbNXm6S
         RiOv/+sGvCqFTIiU0NZILpb2K8KdKlvC0fK9hfigSIZefz0KzMv01Is4RXD98A8Ef8gu
         RmwZAMTvBhX0psS0xUiJwBPlbBW8bS1xi5iAxjJnq/wGyo0rGGrODPqXI4lFoFM/XGmR
         bjSZURxc13/RVtkMDysyX2EQMNnieAab4OQ32u+ZlYOVqZI6UkCCX3BZeujc0I6v5JZ4
         aPOMQP1qWv8ZIrOZGxB0owT35H6GK4ypu7SJlJTYlVGGFUxkrDqEPwnmsziWAYwm3Klm
         GWtA==
X-Gm-Message-State: AOJu0Yy93ME/wx0eJTxLnPDnycFVSPqpJGhmbWieOluljLQoeEtNbw+7
        Ph+f0w1IToJi/YXM0Gr4PwUk3qydK0Bhjw==
X-Google-Smtp-Source: AGHT+IFHJK4AumhU/RHieCntR6RxOuUDXuR9vjHlFSw6z4T2tyOBsJKK4CHwgopLweDNXcwpw6JADg==
X-Received: by 2002:a81:ab46:0:b0:579:efbb:cbe3 with SMTP id d6-20020a81ab46000000b00579efbbcbe3mr9474659ywk.43.1693810619995;
        Sun, 03 Sep 2023 23:56:59 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id e188-20020a81a7c5000000b0059812d9719fsm1849067ywh.8.2023.09.03.23.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 23:56:59 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-58fb73e26a6so10967007b3.1;
        Sun, 03 Sep 2023 23:56:59 -0700 (PDT)
X-Received: by 2002:a25:ac3:0:b0:d7e:b89c:9919 with SMTP id
 186-20020a250ac3000000b00d7eb89c9919mr5162434ybk.1.1693810619371; Sun, 03 Sep
 2023 23:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230903133709.8049-1-adiupina@astralinux.ru>
In-Reply-To: <20230903133709.8049-1-adiupina@astralinux.ru>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Sep 2023 08:56:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXA0QgVuw4jEA3Q=cREhCjpoYq=+uMeDL+X187oTYDCBQ@mail.gmail.com>
Message-ID: <CAMuHMdXA0QgVuw4jEA3Q=cREhCjpoYq=+uMeDL+X187oTYDCBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/rcar-du: fix comment to rcar_du_group_get()
To:     Alexandra Diupina <adiupina@astralinux.ru>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandra,

On Sun, Sep 3, 2023 at 7:10 PM Alexandra Diupina <adiupina@astralinux.ru> wrote:
> rcar_du_group_get() never returns a negative
> error code (always returns 0), so change
> the comment about returned value
>
> Fixes: cb2025d2509f ("drm/rcar-du: Introduce CRTCs groups")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>

Thanks for your patch!

> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c
> @@ -200,7 +200,7 @@ static void rcar_du_group_setup(struct rcar_du_group *rgrp)
>   *
>   * This function must be called with the DRM mode_config lock held.
>   *
> - * Return 0 in case of success or a negative error code otherwise.
> + * Always return 0.
>   */
>  int rcar_du_group_get(struct rcar_du_group *rgrp)
>  {

This is debatable: future changes may make it possible for the
function to fail.  In addition, the (single) caller does check the
return value.

If we are sure the function can never fail, and everyone agrees, its
return type should be changed to void, and the caller should be updated.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
