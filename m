Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD86772B3A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjHGQkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjHGQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:40:43 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915C61BDC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:40:37 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bc93523162so4050827a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426437; x=1692031237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaPYaqaFDCU5jC3MKKmSmMMn4YAXxnsQcK9wgpCcRQ4=;
        b=gBxDE02r5V+myaSbv5/I3zVBzUL6Y08FjzDWLGY9Mn1YOGOSKFx8fQc7Q/GLfqsByL
         v6l002Y37dfvGCR2gZPbCX+vEfczWF2x04zGPK0ZcEI0tz94dVQOvoDRXQaLGL1uSZLn
         JT9lPQ1FeDUMW1cS+wMR3rL6KcPf0lyoIrUU+tL+JoClm9BbxUgOzuuAoCxd9dGCqBlI
         QhD73bDMegwqAgjPMxPrf9/+GWBZrKU15hLCJN0k6XAVRawYtdCZ/nYL4fsJFxyMIqc1
         nWghePP92IQP0v3yXuVaUsGwxiptE83Xk/RwWv+2mv0AIb92L3RjmP0bweW2mfaSKQNV
         4wWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426437; x=1692031237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaPYaqaFDCU5jC3MKKmSmMMn4YAXxnsQcK9wgpCcRQ4=;
        b=AWobcsUfGqvdwNZXBjBw/NpKe7kdbbfMsmirFAPbcfUAH08zPU2W3xHyfv2yxqAAGc
         pNHChRN3bml9ordaFr5iaaT7/Pf4LI1xG32mUGAPLJxEzh68F7S/2DUwIRky+61SLjtK
         7G5km8C5k8SMS2cGtIly08oBkO+5zMKm5nnjqxqA8yOmRdw9+smfsN1XN6XC0DHWOtTg
         nw8vFociO/nVvTPgmvPBuLWfQsZynkwDRcbzfyjlVXjswMpOgGLjnkOrz2Ql1ztAZjVM
         NZ6/mkQ7WP15b/DcuMLNcpDX0bqvTxNQ/Hs8pFI05g59HnthbuHvYYUeyIUgZ5kyyjVs
         q8xw==
X-Gm-Message-State: AOJu0YzB1uWeD7tT6noa6Hpih4ZRUjGWik6ndJNDmMwKnSW7aeT9+NCW
        VWkYg2JgUhOB3W83/2MtVFeSsna78v2xTTYVqVg=
X-Google-Smtp-Source: AGHT+IGFmb5vESGA6g+6euItG2gjeRnrfhDdtSVwLuyAV78N6vIgNdo1FsMx/lyO+M6eZf5E6F3z6P9PQhaHQDGOJ60=
X-Received: by 2002:a05:6870:8a14:b0:1be:c87d:c670 with SMTP id
 p20-20020a0568708a1400b001bec87dc670mr11199409oaq.47.1691426436882; Mon, 07
 Aug 2023 09:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230801091906.7270-1-sunran001@208suo.com>
In-Reply-To: <20230801091906.7270-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:40:25 -0400
Message-ID: <CADnq5_Mb3c1Mks+O-9jP15gH-Be+oL8CX9WJ2zdF3hxvmNT72w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Clean up errors in vega10_processpptables.c
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

On Tue, Aug 1, 2023 at 5:19=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: "foo* bar" should be "foo *bar"
> ERROR: space required before the open brace '{'
> ERROR: space required before the open parenthesis '('
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptable=
s.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
> index bb90d8abf79b..3be616af327e 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
> @@ -372,9 +372,9 @@ static int get_mm_clock_voltage_table(
>         return 0;
>  }
>
> -static void get_scl_sda_value(uint8_t line, uint8_t *scl, uint8_t* sda)
> +static void get_scl_sda_value(uint8_t line, uint8_t *scl, uint8_t *sda)
>  {
> -       switch(line){
> +       switch (line) {
>         case Vega10_I2CLineID_DDC1:
>                 *scl =3D Vega10_I2C_DDC1CLK;
>                 *sda =3D Vega10_I2C_DDC1DATA;
> @@ -954,7 +954,7 @@ static int init_powerplay_extended_tables(
>         if (!result && powerplay_table->usPixclkDependencyTableOffset)
>                 result =3D get_pix_clk_voltage_dependency_table(hwmgr,
>                                 &pp_table_info->vdd_dep_on_pixclk,
> -                               (const ATOM_Vega10_PIXCLK_Dependency_Tabl=
e*)
> +                               (const ATOM_Vega10_PIXCLK_Dependency_Tabl=
e *)
>                                 pixclk_dep_table);
>
>         if (!result && powerplay_table->usPhyClkDependencyTableOffset)
> --
> 2.17.1
>
