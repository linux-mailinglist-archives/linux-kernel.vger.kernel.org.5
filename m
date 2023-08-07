Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0350F772A97
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjHGQZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjHGQZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:25:18 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6441BC8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:25:07 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-56d6879dcaaso1322497eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691425506; x=1692030306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOWOgyUv1qrx+9DmmFpIQpCVfnmLKrcEfAnIcHRhdZs=;
        b=s4nBDeDhgnn0DtVRgUkqUUbApXJue9T4uVFIFUPgNM1dYs3VFIDrG+fZyR8Fnzx+xk
         ucLapytaUbg4ZOTBpkKRPOHgqqUXbyKVRxnYZyOfql03n15oL+y96fOlFUb7A4NQ4UCo
         PmdvH9Uhs+Z/fezk0PP9PMZHr43jFqmHM6FBr2sUYsupkWnZrtb4sg42CjzNqEfjPNGM
         IIVnqEg/2Qwk7ka5cBx1hOSOTXB1qQYuChoR6pJqRzYn8jeZe+xHETu71HWRmfVUgITL
         0ZdZI0gsGYK2hQbnhqvvnwyWeTygqZhy6KVfrXsE2COuDARkVWOHTj2yNVkEOs03a7kk
         eLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425506; x=1692030306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOWOgyUv1qrx+9DmmFpIQpCVfnmLKrcEfAnIcHRhdZs=;
        b=iZZsYuFGYpaOxTR5M7ZCnd1e94TtEI9nMYSNWtTarBS+ne+BQ9U5B6Ks4DxfIeHmmo
         bb0vvomdzDNrYWzQfcwcUHBlVqytPwcUYBRdwX7YFhsKSogey4V+6qtPMzEuDEEEk1pE
         mUdP8d8d4wbbjudllRVJ9WZ44+ghYaEVqjfDw4D1qvOqES5hs5nz/CfdE8ldhCPL4VD5
         VzT5R58oTGIL7862KuR8RuoMpj77+Rx6Fb7YukeTnCxLXaMGcFX0JAqR26QHJE3+uKjc
         kXetEmKCggNNWf7Dbudk/jGbWJwsUhB5WZGSHqCAJEqS4NOBk4rvRdkwqjnZ4c1Ckkhq
         /Lpg==
X-Gm-Message-State: AOJu0Yy9XUH6wrSgjIssQNJTsZEO0ruxydn3OB/kbWJpr2Iv2MyJSwZ9
        ZyjjKLHab4Uy3wbbIVLTiXjpFn+j95iSOyeyj9o=
X-Google-Smtp-Source: AGHT+IHoGDnJkdKJd57JSppSx0FZ3g/L3aeLHmPRvBh3gPJZJymQwuBQvcISwk0qOsAZz6TrB9OBfNswDJLtwJ7ghPE=
X-Received: by 2002:a05:6870:56aa:b0:1bf:2661:4871 with SMTP id
 p42-20020a05687056aa00b001bf26614871mr10898197oao.4.1691425506060; Mon, 07
 Aug 2023 09:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230801024448.4848-1-sunran001@208suo.com>
In-Reply-To: <20230801024448.4848-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:24:55 -0400
Message-ID: <CADnq5_PzOPWca4mU12MCaibRS8=tgY1-o7853sh0tf_Twh2ukQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in vega10_baco.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Mon, Jul 31, 2023 at 10:45=E2=80=AFPM Ran Sun <sunran001@208suo.com> wro=
te:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: space prohibited before that ',' (ctx:WxV)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/vega10_baco.c  | 26 ++++++++-----------
>  1 file changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_baco.c b/drive=
rs/gpu/drm/amd/pm/powerplay/hwmgr/vega10_baco.c
> index 46bb16c29cf6..6836e98d37be 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_baco.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_baco.c
> @@ -31,24 +31,22 @@
>
>
>
> -static const struct soc15_baco_cmd_entry  pre_baco_tbl[] =3D
> -{
> +static const struct soc15_baco_cmd_entry  pre_baco_tbl[] =3D {
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIF_DOORBELL_CNT=
L), BIF_DOORBELL_CNTL__DOORBELL_MONITOR_EN_MASK, BIF_DOORBELL_CNTL__DOORBEL=
L_MONITOR_EN__SHIFT, 0, 1},
>         {CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIF_FB_EN), 0, 0, 0, 0},
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO=
_CNTL__BACO_DSTATE_BYPASS_MASK, BACO_CNTL__BACO_DSTATE_BYPASS__SHIFT, 0, 1}=
,
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO=
_CNTL__BACO_RST_INTR_MASK_MASK, BACO_CNTL__BACO_RST_INTR_MASK__SHIFT, 0, 1}
>  };
>
> -static const struct soc15_baco_cmd_entry enter_baco_tbl[] =3D
> -{
> +static const struct soc15_baco_cmd_entry enter_baco_tbl[] =3D {
>         {CMD_WAITFOR, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_=
CNTL__SOC_DOMAIN_IDLE_MASK, THM_BACO_CNTL__SOC_DOMAIN_IDLE__SHIFT, 0xffffff=
ff, 0x80000000},
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO=
_CNTL__BACO_EN_MASK, BACO_CNTL__BACO_EN__SHIFT, 0, 1},
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO=
_CNTL__BACO_BIF_LCLK_SWITCH_MASK, BACO_CNTL__BACO_BIF_LCLK_SWITCH__SHIFT, 0=
, 1},
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO=
_CNTL__BACO_DUMMY_EN_MASK, BACO_CNTL__BACO_DUMMY_EN__SHIFT, 0, 1},
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_SOC_VDCI_RESET_MASK, THM_BACO_CNTL__BACO_SOC_VDCI_RESET_=
_SHIFT, 0, 1},
> -       {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_SMNCLK_MUX_MASK, THM_BACO_CNTL__BACO_SMNCLK_MUX__SHIFT,0=
, 1},
> +       {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_SMNCLK_MUX_MASK, THM_BACO_CNTL__BACO_SMNCLK_MUX__SHIFT, =
0, 1},
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_ISO_EN_MASK, THM_BACO_CNTL__BACO_ISO_EN__SHIFT, 0, 1},
> -       {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_AEB_ISO_EN_MASK, THM_BACO_CNTL__BACO_AEB_ISO_EN__SHIFT,0=
, 1},
> +       {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_AEB_ISO_EN_MASK, THM_BACO_CNTL__BACO_AEB_ISO_EN__SHIFT, =
0, 1},
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_ANA_ISO_EN_MASK, THM_BACO_CNTL__BACO_ANA_ISO_EN__SHIFT, =
0, 1},
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_SOC_REFCLK_OFF_MASK,     THM_BACO_CNTL__BACO_SOC_REFCLK_=
OFF__SHIFT, 0, 1},
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO=
_CNTL__BACO_POWER_OFF_MASK, BACO_CNTL__BACO_POWER_OFF__SHIFT, 0, 1},
> @@ -58,13 +56,12 @@ static const struct soc15_baco_cmd_entry enter_baco_t=
bl[] =3D
>         {CMD_WAITFOR, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO_CNTL__B=
ACO_MODE_MASK, BACO_CNTL__BACO_MODE__SHIFT, 0xffffffff, 0x100}
>  };
>
> -static const struct soc15_baco_cmd_entry exit_baco_tbl[] =3D
> -{
> +static const struct soc15_baco_cmd_entry exit_baco_tbl[] =3D {
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO=
_CNTL__BACO_POWER_OFF_MASK, BACO_CNTL__BACO_POWER_OFF__SHIFT, 0, 0},
> -       {CMD_DELAY_MS, 0, 0, 0, 0, 0, 0, 10,0},
> -       {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_SOC_REFCLK_OFF_MASK, THM_BACO_CNTL__BACO_SOC_REFCLK_OFF_=
_SHIFT, 0,0},
> +       {CMD_DELAY_MS, 0, 0, 0, 0, 0, 0, 10, 0},
> +       {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_SOC_REFCLK_OFF_MASK, THM_BACO_CNTL__BACO_SOC_REFCLK_OFF_=
_SHIFT, 0, 0},
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_ANA_ISO_EN_MASK, THM_BACO_CNTL__BACO_ANA_ISO_EN__SHIFT, =
0, 0},
> -       {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_AEB_ISO_EN_MASK, THM_BACO_CNTL__BACO_AEB_ISO_EN__SHIFT,0=
, 0},
> +       {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_AEB_ISO_EN_MASK, THM_BACO_CNTL__BACO_AEB_ISO_EN__SHIFT, =
0, 0},
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_ISO_EN_MASK, THM_BACO_CNTL__BACO_ISO_EN__SHIFT, 0, 0},
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_PWROKRAW_CNTL_MASK, THM_BACO_CNTL__BACO_PWROKRAW_CNTL__S=
HIFT, 0, 1},
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_SMNCLK_MUX_MASK, THM_BACO_CNTL__BACO_SMNCLK_MUX__SHIFT, =
0, 0},
> @@ -74,13 +71,12 @@ static const struct soc15_baco_cmd_entry exit_baco_tb=
l[] =3D
>         {CMD_WAITFOR, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), THM_BACO_=
CNTL__BACO_EXIT_MASK, 0, 0xffffffff, 0},
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(THM, 0, mmTHM_BACO_CNTL), T=
HM_BACO_CNTL__BACO_SB_AXI_FENCE_MASK, THM_BACO_CNTL__BACO_SB_AXI_FENCE__SHI=
FT, 0, 0},
>         {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO=
_CNTL__BACO_DUMMY_EN_MASK, BACO_CNTL__BACO_DUMMY_EN__SHIFT,  0, 0},
> -       {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO=
_CNTL__BACO_BIF_LCLK_SWITCH_MASK ,BACO_CNTL__BACO_BIF_LCLK_SWITCH__SHIFT, 0=
, 0},
> -       {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO=
_CNTL__BACO_EN_MASK , BACO_CNTL__BACO_EN__SHIFT, 0,0},
> +       {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO=
_CNTL__BACO_BIF_LCLK_SWITCH_MASK, BACO_CNTL__BACO_BIF_LCLK_SWITCH__SHIFT, 0=
, 0},
> +       {CMD_READMODIFYWRITE, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO=
_CNTL__BACO_EN_MASK, BACO_CNTL__BACO_EN__SHIFT, 0, 0},
>         {CMD_WAITFOR, SOC15_REG_ENTRY(NBIF, 0, mmBACO_CNTL), BACO_CNTL__B=
ACO_MODE_MASK, 0, 0xffffffff, 0}
>   };
>
> -static const struct soc15_baco_cmd_entry clean_baco_tbl[] =3D
> -{
> +static const struct soc15_baco_cmd_entry clean_baco_tbl[] =3D {
>         {CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_6), 0, 0, 0, =
0},
>         {CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_7), 0, 0, 0, =
0},
>  };
> --
> 2.17.1
>
