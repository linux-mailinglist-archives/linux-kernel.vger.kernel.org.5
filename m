Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815A0772B06
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjHGQen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjHGQe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:34:27 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6FC1990
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:34:14 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1bb89ac2013so3503592fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426053; x=1692030853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=355u3wxzUAPBEukgqITBwq4f3qWHBLHWp7l/yfnQN6k=;
        b=GZRu27dbzX8FvcS00nyGqmOQinIcuRBNRqiXH9h+pzDxYmJ2DdGcJO0QhC9lDGZykv
         pcsw8NV2H0J2eH1n18WceZW+1s0+HHTPh8vMxuJs8eAZ/rn5p80qpeDorwos+gqwipBy
         LO8vAvCK1i0MRS62hpnUaQNPB3ul5zTEBCxf4dxD1L9Iik3WJZAjUyg05BjD0fmJiGb9
         wK4mgYRT0mX2L70fYdcKnIwOOIEXKhe5WDSrWw3CZnHk+gwucgvYgv14fLvCJDARqLna
         cBnG6qqXOGkXdhErecJDXNZxqX25dvcLwXds+F8QBT5CZkecihhS5FDQizHkTTeENevC
         yfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426053; x=1692030853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=355u3wxzUAPBEukgqITBwq4f3qWHBLHWp7l/yfnQN6k=;
        b=Y+EhtbFEftTD+IUkHr2T3scftPqShJtHeXzjQ7C33HhRcs1DlxnUIFVTTBJmZmawC/
         qVlk70k7HbRwReaGWNS4LrfvXvg4ZT2O/26PsmTGqwZOYXqumxmzYEblHjlATeZH/YRg
         YgFJ55l0Duuz5R2rTfkFnaVL5vkouKNukQlGCCobiVZaEVp5EwmNo2bEn+UrBjvq4TAV
         oEqYWqkshfD0yv2b25ehvIP95cgFPKIVFCEZut/fcUyrYaFruiSL29emxTlu9SEZ8HiA
         7kOEdpPmoJ9Ua2FWB0DIgUO8ztBboBr7NHd8VYq87qZ6WZJpSadm/J2rIOr/TyyNuPw1
         NBvQ==
X-Gm-Message-State: AOJu0YxVhJG/OQKTmz2QH972sjyEq2yhn332zOVyRKEPH2M4+kUV+olD
        H934bO6XKCnwuHJsHX/YJX4RY3OMceflGprrBms=
X-Google-Smtp-Source: AGHT+IFC5BE479wBcqELZQpVQeGM0HBTQWCDcSzbvqyZzNr9zNQh+18S5QX8gg7gH5GWza1EoxxEYGNZsKrKryI5Vco=
X-Received: by 2002:a05:6870:4724:b0:1be:f23f:99b with SMTP id
 b36-20020a056870472400b001bef23f099bmr12307708oaq.42.1691426053066; Mon, 07
 Aug 2023 09:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230801061529.6269-1-sunran001@208suo.com>
In-Reply-To: <20230801061529.6269-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:34:02 -0400
Message-ID: <CADnq5_PizYO5faQR3AoGyZRq__sccQr9_6VuSqxv_DqKoM8SqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in smu7_powertune.c
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

On Tue, Aug 1, 2023 at 2:15=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
> ERROR: space required after that ',' (ctx:VxV)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
> index 21be23ec3c79..edab3ef09d33 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
> @@ -520,8 +520,7 @@ static const struct gpu_pt_config_reg DIDTConfig_Pola=
ris12[] =3D {
>         {   0xFFFFFFFF  }
>  };
>
> -static const struct gpu_pt_config_reg DIDTConfig_Polaris11_Kicker[] =3D
> -{
> +static const struct gpu_pt_config_reg DIDTConfig_Polaris11_Kicker[] =3D =
{
>  /* ---------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------
>   *      Offset                             Mask                         =
                       Shift                                               =
Value       Type
>   * ---------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------
> @@ -646,7 +645,7 @@ static const struct gpu_pt_config_reg DIDTConfig_Pola=
ris11_Kicker[] =3D
>         {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_=
STALL_CTRL_ENABLE_MASK,   DIDT_TCP_STALL_CTRL__DIDT_STALL_CTRL_ENABLE__SHIF=
T, 0x0001,     GPU_CONFIGREG_DIDT_IND },
>         {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_=
STALL_DELAY_HI_MASK,      DIDT_TCP_STALL_CTRL__DIDT_STALL_DELAY_HI__SHIFT, =
   0x0001,     GPU_CONFIGREG_DIDT_IND },
>         {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_=
STALL_DELAY_LO_MASK,      DIDT_TCP_STALL_CTRL__DIDT_STALL_DELAY_LO__SHIFT, =
   0x0001,     GPU_CONFIGREG_DIDT_IND },
> -       {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_=
HI_POWER_THRESHOLD_MASK,  DIDT_TCP_STALL_CTRL__DIDT_HI_POWER_THRESHOLD__SHI=
FT,0x01aa,     GPU_CONFIGREG_DIDT_IND },
> +       {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_=
HI_POWER_THRESHOLD_MASK,  DIDT_TCP_STALL_CTRL__DIDT_HI_POWER_THRESHOLD__SHI=
FT, 0x01aa,     GPU_CONFIGREG_DIDT_IND },
>         {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__UNUSE=
D_0_MASK,                 DIDT_TCP_STALL_CTRL__UNUSED_0__SHIFT,            =
   0x0000,     GPU_CONFIGREG_DIDT_IND },
>
>         {   ixDIDT_TCP_TUNING_CTRL,            DIDT_TCP_TUNING_CTRL__DIDT=
_TUNING_ENABLE_MASK,      DIDT_TCP_TUNING_CTRL__DIDT_TUNING_ENABLE__SHIFT, =
   0x0001,     GPU_CONFIGREG_DIDT_IND },
> @@ -666,8 +665,7 @@ static const struct gpu_pt_config_reg DIDTConfig_Pola=
ris11_Kicker[] =3D
>         {   0xFFFFFFFF  }  /* End of list */
>  };
>
> -static const struct gpu_pt_config_reg GCCACConfig_VegaM[] =3D
> -{
> +static const struct gpu_pt_config_reg GCCACConfig_VegaM[] =3D {
>  // ---------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------
>  //      Offset                             Mask                         =
                       Shift                                               =
Value       Type
>  // ---------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------
> @@ -703,8 +701,7 @@ static const struct gpu_pt_config_reg GCCACConfig_Veg=
aM[] =3D
>      {   0xFFFFFFFF  }  // End of list
>  };
>
> -static const struct gpu_pt_config_reg DIDTConfig_VegaM[] =3D
> -{
> +static const struct gpu_pt_config_reg DIDTConfig_VegaM[] =3D {
>  // ---------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------
>  //      Offset                             Mask                         =
                       Shift                                               =
Value       Type
>  // ---------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------
> @@ -831,7 +828,7 @@ static const struct gpu_pt_config_reg DIDTConfig_Vega=
M[] =3D
>      {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_STA=
LL_CTRL_ENABLE_MASK,   DIDT_TCP_STALL_CTRL__DIDT_STALL_CTRL_ENABLE__SHIFT, =
0x0001,     GPU_CONFIGREG_DIDT_IND },
>      {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_STA=
LL_DELAY_HI_MASK,      DIDT_TCP_STALL_CTRL__DIDT_STALL_DELAY_HI__SHIFT,    =
0x0001,     GPU_CONFIGREG_DIDT_IND },
>      {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_STA=
LL_DELAY_LO_MASK,      DIDT_TCP_STALL_CTRL__DIDT_STALL_DELAY_LO__SHIFT,    =
0x0001,     GPU_CONFIGREG_DIDT_IND },
> -    {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_HI_=
POWER_THRESHOLD_MASK,  DIDT_TCP_STALL_CTRL__DIDT_HI_POWER_THRESHOLD__SHIFT,=
0x01aa,     GPU_CONFIGREG_DIDT_IND },
> +    {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_HI_=
POWER_THRESHOLD_MASK,  DIDT_TCP_STALL_CTRL__DIDT_HI_POWER_THRESHOLD__SHIFT,=
 0x01aa,     GPU_CONFIGREG_DIDT_IND },
>      {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__UNUSED_0=
_MASK,                 DIDT_TCP_STALL_CTRL__UNUSED_0__SHIFT,               =
0x0000,     GPU_CONFIGREG_DIDT_IND },
>
>      {   ixDIDT_TCP_TUNING_CTRL,            DIDT_TCP_TUNING_CTRL__DIDT_TU=
NING_ENABLE_MASK,      DIDT_TCP_TUNING_CTRL__DIDT_TUNING_ENABLE__SHIFT,    =
0x0001,     GPU_CONFIGREG_DIDT_IND },
> --
> 2.17.1
>
