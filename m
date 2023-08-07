Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2175A772B95
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjHGQxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjHGQxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:53:41 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E362A1989
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:53:31 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1bff2d2c141so580838fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427211; x=1692032011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLRoozb0+Gs5ofW34vZ6zv9jitiui+Q1IYSegK3uXaU=;
        b=Yw4WkyWsnCJUsB1QLoWXYxFXxP4HJWUK6ELdleOp2COMgHeAQYvnJPhoRW4cftlUhO
         u/V7sVOnnO50KrGOJ6TMpDCeyAKCROa8E++y+zhkmDm0RGDF19e5W+uU1iFm7zb+S9/8
         92nJV6rZ5VzOfryX01lMSxPMzr1lUsp6/+VBPy6yFbsMdotuoo/OWip56MP10wCMqorF
         hmGXhy2MbXqNl6WldWihgNxBdPogffOMOJdY40ANcViWd3EbQCP/M0sy0nrmIYrTUXj6
         gOXozOIGlAo4VTY2lMGhZli178Lebu6ZIviXQ4NckaT7h/kneM9Biz9nqXOoAGWwNj6M
         gF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427211; x=1692032011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLRoozb0+Gs5ofW34vZ6zv9jitiui+Q1IYSegK3uXaU=;
        b=R+G57yFflCAUlj/uhEoSa1YeJiy1UIMg3ubgTdY6eqVhGTXLA9vARV2nZ/YsvnsEfj
         v3TWulOeyphe1UsNbt7fjGJy5Oqrrz6uIeJsXAN1m1l6FLtmeYpZ8vaKqow+A6tIAZEj
         CZ27Kqi4ikYZHo7Q4uJkMiALxLV8TRJm/p0fZBDco9WunaJ39j6Jhq8dOvBC0GkJvXmQ
         8ix1EeX3Kg+7izTMs94YXqPHuMtNnwTSmwHUQqJHoHBpxk/KW+pBMCa7S0N6psZbPqeN
         5wwXl0D2zbU33tGWCXftGqsYlSKbZc/NbEdHtLj55PSUvYkBhPpAH1hgp9e0l0cgcoGC
         a/CQ==
X-Gm-Message-State: AOJu0Ywo8n3FG4W1Na/2J559ztNGIvty2FszWs1y1sYza/3gi8cW3jbr
        k00HF+9HUEUZIiGcFehzGYiT6iZ0T/sHROA+0oc=
X-Google-Smtp-Source: AGHT+IFq83Az3S8S2tZiqWs8mYYSFPtms9A2S2DaQFzDZtAmCStVFdHp4lMV8d34R91aGAFliySthbf+c/Ic5OIPfxE=
X-Received: by 2002:a05:6870:d252:b0:1bb:8cc2:8c3e with SMTP id
 h18-20020a056870d25200b001bb8cc28c3emr9703625oac.15.1691427211035; Mon, 07
 Aug 2023 09:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230801095056.8120-1-sunran001@208suo.com>
In-Reply-To: <20230801095056.8120-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:53:20 -0400
Message-ID: <CADnq5_N4tdXL2Fc0j5ZoYAjV=ZDfWctk1J=sOHgRB6CjHzNwgA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu9_driver_if.h
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Aug 1, 2023 at 5:51=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: space prohibited before open square bracket '['
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../drm/amd/pm/powerplay/inc/smu9_driver_if.h | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h b/driv=
ers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
> index faae4b918d90..2c69a5694f94 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
> @@ -178,20 +178,20 @@ typedef struct {
>    uint8_t      padding8_2[2];
>
>    /* SOC Frequencies */
> -  PllSetting_t GfxclkLevel        [NUM_GFXCLK_DPM_LEVELS];
> +  PllSetting_t GfxclkLevel[NUM_GFXCLK_DPM_LEVELS];
>
> -  uint8_t      SocclkDid          [NUM_SOCCLK_DPM_LEVELS];          /* D=
ID */
> -  uint8_t      SocDpmVoltageIndex [NUM_SOCCLK_DPM_LEVELS];
> +  uint8_t      SocclkDid[NUM_SOCCLK_DPM_LEVELS];          /* DID */
> +  uint8_t      SocDpmVoltageIndex[NUM_SOCCLK_DPM_LEVELS];
>
> -  uint8_t      VclkDid            [NUM_UVD_DPM_LEVELS];            /* DI=
D */
> -  uint8_t      DclkDid            [NUM_UVD_DPM_LEVELS];            /* DI=
D */
> -  uint8_t      UvdDpmVoltageIndex [NUM_UVD_DPM_LEVELS];
> +  uint8_t      VclkDid[NUM_UVD_DPM_LEVELS];            /* DID */
> +  uint8_t      DclkDid[NUM_UVD_DPM_LEVELS];            /* DID */
> +  uint8_t      UvdDpmVoltageIndex[NUM_UVD_DPM_LEVELS];
>
> -  uint8_t      EclkDid            [NUM_VCE_DPM_LEVELS];            /* DI=
D */
> -  uint8_t      VceDpmVoltageIndex [NUM_VCE_DPM_LEVELS];
> +  uint8_t      EclkDid[NUM_VCE_DPM_LEVELS];            /* DID */
> +  uint8_t      VceDpmVoltageIndex[NUM_VCE_DPM_LEVELS];
>
> -  uint8_t      Mp0clkDid          [NUM_MP0CLK_DPM_LEVELS];          /* D=
ID */
> -  uint8_t      Mp0DpmVoltageIndex [NUM_MP0CLK_DPM_LEVELS];
> +  uint8_t      Mp0clkDid[NUM_MP0CLK_DPM_LEVELS];          /* DID */
> +  uint8_t      Mp0DpmVoltageIndex[NUM_MP0CLK_DPM_LEVELS];
>
>    DisplayClockTable_t DisplayClockTable[DSPCLK_COUNT][NUM_DSPCLK_LEVELS]=
;
>    QuadraticInt_t      DisplayClock2Gfxclk[DSPCLK_COUNT];
> --
> 2.17.1
>
