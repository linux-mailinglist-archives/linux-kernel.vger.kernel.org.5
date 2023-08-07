Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2500F772CCB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjHGRZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjHGRZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:25:05 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB79107
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:25:04 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bc9efb5091so3141643a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429104; x=1692033904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLvst6Zccwh0wf7EIu3L9mB0yryAQ4IriShfN7o2rso=;
        b=jWN9RHNdtgKdUKLtAsIovNcE4VyCmk/n5s7+1X+Wr126XMU1E3mH61625YKVvoV2H+
         066KNAhA5cAB2IneultQlG6pKkTzabzX4Dg9H2SyyY570qhirgvWV+FHHsf0uW+BEqnh
         cUfiMOqSPw31WBcq8t/DgiLYRmjRw7dVQH1EZNOSt2E2kzZ2MmArjdJAj8Giq+dJk3z8
         1RwQK4GvZ1IiqNLzOoNVyObP4oz207ziRhne5JS0RE0Qa5vc3WMe/U6UmTId9XmEI5+u
         Dei6c8Qv+b7ytKF74FvDTJNAIVkRhVbHK7C1d7NRBeQtvdTioDLb3f5E4GgrI6ITbaxl
         sfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429104; x=1692033904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLvst6Zccwh0wf7EIu3L9mB0yryAQ4IriShfN7o2rso=;
        b=VbIbgdu2/9JLoxiHIAymIx/Bx6mRRc0cRZbh2Bh6z9VDmYTfjZceNwgO2/zrrmW/jj
         912urILv+jDD54g2S6iBCRmdRSmfs0S0fpouP1miWxacxEn/zn0nMazK5Np8h7Dko6P5
         1+/sG4jtcoSeKTlIbuA2nLTwPl6V74a9RD5LcR+86xwbUKOt1Fl6ahUm1BaKFRO5fR00
         NHj8twSZv9Yhl8+21/rRVsBlHXasuqVlmo1rTP/jPAK+asMzuQHdHo7wDVVsB2UxSfOm
         9XVzdKbEoQ2A1gQvFHKqNe4k20PIcPwG7b640nvRanPo3cTeVrrboWMwG5iaKM+cpatt
         Piaw==
X-Gm-Message-State: AOJu0YyfLsoDUW0BogGswQzh1HlZAka1sNGnAlfDNBaPomd2lsTRZbzD
        DXHaeTdyN9CSxQ/mK+sUqd9Eu9ITan9/NTpPgAM=
X-Google-Smtp-Source: AGHT+IGgJVtr6qXj+2p5kOMV/EpBlIffMAz2jT7+vqJphZZDzvI7CUyNOajNYT9Mxo/5yYmXiRnTcPynAPmw1Ocm6eg=
X-Received: by 2002:a9d:611c:0:b0:6bb:1ec3:9ac1 with SMTP id
 i28-20020a9d611c000000b006bb1ec39ac1mr5578212otj.13.1691429103905; Mon, 07
 Aug 2023 10:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230802071201.12717-1-sunran001@208suo.com>
In-Reply-To: <20230802071201.12717-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:24:53 -0400
Message-ID: <CADnq5_O6H-YLDHxDM0baTpmLgrfdASsyFX4CPRQfZ9WyD8_ZRg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/jpeg: Clean up errors in vcn_v1_0.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Aug 2, 2023 at 3:12=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: space required before the open parenthesis '('
> ERROR: space prohibited after that '~' (ctx:WxW)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 16feb491adf5..25ba27151ac0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -473,7 +473,7 @@ static void vcn_v1_0_disable_clock_gating(struct amdg=
pu_device *adev)
>         if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
>                 data |=3D 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
>         else
> -               data &=3D ~ UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
> +               data &=3D ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
>
>         data |=3D 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
>         data |=3D 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> @@ -1772,7 +1772,7 @@ static int vcn_v1_0_set_powergating_state(void *han=
dle,
>         int ret;
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> -       if(state =3D=3D adev->vcn.cur_state)
> +       if (state =3D=3D adev->vcn.cur_state)
>                 return 0;
>
>         if (state =3D=3D AMD_PG_STATE_GATE)
> @@ -1780,7 +1780,7 @@ static int vcn_v1_0_set_powergating_state(void *han=
dle,
>         else
>                 ret =3D vcn_v1_0_start(adev);
>
> -       if(!ret)
> +       if (!ret)
>                 adev->vcn.cur_state =3D state;
>         return ret;
>  }
> @@ -2065,8 +2065,7 @@ static void vcn_v1_0_set_irq_funcs(struct amdgpu_de=
vice *adev)
>         adev->vcn.inst->irq.funcs =3D &vcn_v1_0_irq_funcs;
>  }
>
> -const struct amdgpu_ip_block_version vcn_v1_0_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version vcn_v1_0_ip_block =3D {
>                 .type =3D AMD_IP_BLOCK_TYPE_VCN,
>                 .major =3D 1,
>                 .minor =3D 0,
> --
> 2.17.1
>
