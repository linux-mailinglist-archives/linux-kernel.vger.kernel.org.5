Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA93772B73
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjHGQtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjHGQtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:49:14 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD33B172A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:49:13 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56c4457c82eso3097283eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426953; x=1692031753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGmmkCXMMyEo8pM0tNNo4ZW+64gDoL7rhIgRe9x2cRY=;
        b=D010eOd3qhm+mh+wnfbojjbzNHNcJEgWAnKg7JHHoRbkZtgzPGeDjxM9B97GtJoerP
         HnUx9R4j8OJsrvaguVLGIiL68icxr4LtivDlfxekGgZkkTnDoo/Ta4eXdcUdEIoDInKU
         HKliqHBEouvohawZSwuAvXoWBt59s6bv71d3Wt+hbTCxzmwaLI0qLTymsmN0Rl8auc/d
         i8OXV7iyWqPOkMd4kiN5SF+GldxDEgZVyatkFzLuYMZuWCK3/iyk0ITTUpIn/wNMapWS
         2l1Rn2118P6dpoRyTfkme0yZ/4HLNI+w23vq2tVEoJywuU9aqJggcpIATZQlP7Bgxo/R
         Vsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426953; x=1692031753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGmmkCXMMyEo8pM0tNNo4ZW+64gDoL7rhIgRe9x2cRY=;
        b=VIjqf7TEru24gaJp21BGkAxbRUpDxZZpUxzvL2cKmx8IxaRjgNPiMVJ0xXgS4uqaFS
         8Dov86+E0dS/j4tPMlPHNbZv74qKxih38XmjGmKRo8ZuKZSMlhHilOXxGCRpSiFqMouI
         XLWidFxMuTwJr/8uIXn12PIbzmD39uLy4hm3VILHAl5TMpiZEUnZalkka2/rsKwimCO1
         G+wUtczWO8k25TbLcIE1eAbZJI55mOwrlzajxgfNXYjVOHSiCWF+7NXFy1BgEHBvuuVc
         mvRNXU9bxUIdKoBvgrxa9noujyPXSTCT/gnrcRHtFiehAtWoi/yz/Y33bYG/zU6IclKX
         ghPQ==
X-Gm-Message-State: AOJu0YwFc4Tlj9xaYz8LK0bQ5nyJOAEzc+SxPFZDLp29+DViZn6wWwsv
        aCulvmbFrJk96tXS5amYZKSVEiqz++Pjo6aLBpE=
X-Google-Smtp-Source: AGHT+IEjwMBfsazRGEFURdoYzMHl7f5vZKtC+1dPDwjp/CD6DxnxH9EHmcsQMlGT3CF3i+28DIdWOSM5HNCfb02PCv8=
X-Received: by 2002:a4a:7658:0:b0:567:92:c45d with SMTP id w24-20020a4a7658000000b005670092c45dmr9029943ooe.5.1691426952955;
 Mon, 07 Aug 2023 09:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230801093832.7849-1-sunran001@208suo.com>
In-Reply-To: <20230801093832.7849-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:49:01 -0400
Message-ID: <CADnq5_P34srDuav4V-4kZ81y5DdsqvZ9gxDYqjGjii8c3U1hww@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in vega12_hwmgr.h
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Aug 1, 2023 at 5:38=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following enum go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h
> index aa63ae41942d..9f2ce4308548 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h
> @@ -38,8 +38,7 @@
>  #define VG12_PSUEDO_NUM_DCEFCLK_DPM_LEVELS  8
>  #define VG12_PSUEDO_NUM_UCLK_DPM_LEVELS     4
>
> -enum
> -{
> +enum {
>         GNLD_DPM_PREFETCHER =3D 0,
>         GNLD_DPM_GFXCLK,
>         GNLD_DPM_UCLK,
> --
> 2.17.1
>
