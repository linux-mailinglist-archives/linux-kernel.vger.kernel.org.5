Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF2A7CDDF4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344782AbjJRNy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjJRNyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:54:54 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0226083
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:54:52 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1e12f41e496so4211521fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697637292; x=1698242092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQtk85yAlUtWvDHsaGA/g7mDe6/47cka+lCUyYH/oYo=;
        b=KoRRg+QBJVhmAOriIZXg5F3S/XjZNMCxw1Pw3ZYaKIchiSpZKS10JKgmxpV37PaKn8
         XFApXl2RTCNlHpS4HnFHXW2PTyosJ+7GRoT25lKwqnzNHDfVRjtrsXpT8i/4MfevX/mP
         MUj1uO74o8k962PGYhkeDsz8TJWlj+4Ac6ltqVb8B1GuUVF7CoL7Bx42dhXP07VIFmWd
         vzayU0xQP8C3byA8mY1Vd+te0L//o9K27ZZy3sFiP33SISo039TL4DF7Wd+L4sGgA2HY
         l6SlPuFDzXT4Vbw7qdOgI0RH4MTuQU7CVOAE3rWBSmJAC+P8XCb872DwVF9nstcL7OQQ
         rJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697637292; x=1698242092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQtk85yAlUtWvDHsaGA/g7mDe6/47cka+lCUyYH/oYo=;
        b=fk0wSulyXszezNIkOWN/LxRbs3g1IY4Nny18h1SQssbjWynX8pfk/nQCcK8GTa9UKF
         o7Ki2PIGLw0B0KP2eDkcJHJf7RLg5SdwJQcoUYzRDoORvbIhS2LOorDiK1pEx4zSd4U6
         RkIW2L+rIIenitetP1GrflCCUNO23H2fb8YlpJyswunapFuN6p6liA5g2F398fHFsCsf
         +E4ihOmNX2I+3aHX2YFkqYwVOBfY5vayxOVAuyVdEsqO7UyN/DNcUGjPJK77INHtxOYn
         JuE5g+PRCGpHIr2TdtfGFVe5kbzrLd4S+TIcvngp6hM2JtyExfHcV0ZezDeSsaGDblM9
         sYqg==
X-Gm-Message-State: AOJu0YywS1ugW+sS1O+ZJg6xhipbVLDf9Z2HnaBhG4PG/lj0/Js6UGCx
        cleyBIhVVlrXdAaZw8cwpzyIClY04sWUU4zK3nk=
X-Google-Smtp-Source: AGHT+IFlaoizvKWMcFlZPTzHVe9b4XIs0EXekcyzuBDq5Az+Rq7X9x4hmvFDljDEuaGPMfkJvfYECf4RXcy3tA5IzIo=
X-Received: by 2002:a05:6870:d60e:b0:1d6:567b:7a93 with SMTP id
 a14-20020a056870d60e00b001d6567b7a93mr5985350oaq.11.1697637292212; Wed, 18
 Oct 2023 06:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230928011351.110093-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230928011351.110093-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 18 Oct 2023 09:54:41 -0400
Message-ID: <CADnq5_Ps0gfiu9iadfKzYiG=N06QznOq=p8aJYibxLmuxJDmDQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: clean up some inconsistent indentings
To:     Yang Li <yang.lee@linux.alibaba.com>
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

On Wed, Sep 27, 2023 at 9:14=E2=80=AFPM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn35/dcn35_fpu.c:261 dcn35_=
update_bw_bounding_box_fpu() warn: inconsistent indenting
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  | 144 +++++++++---------
>  1 file changed, 72 insertions(+), 72 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
> index 4d5ee2aad9e4..4f284c31de5d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
> @@ -258,85 +258,85 @@ void dcn35_update_bw_bounding_box_fpu(struct dc *dc=
,
>
>         dc_assert_fp_enabled();
>
> -               dcn3_5_ip.max_num_otg =3D
> -                       dc->res_pool->res_cap->num_timing_generator;
> -               dcn3_5_ip.max_num_dpp =3D dc->res_pool->pipe_count;
> -               dcn3_5_soc.num_chans =3D bw_params->num_channels;
> -
> -               ASSERT(clk_table->num_entries);
> -
> -               /* Prepass to find max clocks independent of voltage leve=
l. */
> -               for (i =3D 0; i < clk_table->num_entries; ++i) {
> -                       if (clk_table->entries[i].dispclk_mhz > max_dispc=
lk_mhz)
> -                               max_dispclk_mhz =3D clk_table->entries[i]=
.dispclk_mhz;
> -                       if (clk_table->entries[i].dppclk_mhz > max_dppclk=
_mhz)
> -                               max_dppclk_mhz =3D clk_table->entries[i].=
dppclk_mhz;
> -               }
> +       dcn3_5_ip.max_num_otg =3D
> +               dc->res_pool->res_cap->num_timing_generator;
> +       dcn3_5_ip.max_num_dpp =3D dc->res_pool->pipe_count;
> +       dcn3_5_soc.num_chans =3D bw_params->num_channels;
> +
> +       ASSERT(clk_table->num_entries);
> +
> +       /* Prepass to find max clocks independent of voltage level. */
> +       for (i =3D 0; i < clk_table->num_entries; ++i) {
> +               if (clk_table->entries[i].dispclk_mhz > max_dispclk_mhz)
> +                       max_dispclk_mhz =3D clk_table->entries[i].dispclk=
_mhz;
> +               if (clk_table->entries[i].dppclk_mhz > max_dppclk_mhz)
> +                       max_dppclk_mhz =3D clk_table->entries[i].dppclk_m=
hz;
> +       }
>
> -               for (i =3D 0; i < clk_table->num_entries; i++) {
> -                       /* loop backwards*/
> -                       for (closest_clk_lvl =3D 0, j =3D dcn3_5_soc.num_=
states - 1;
> -                            j >=3D 0; j--) {
> -                               if (dcn3_5_soc.clock_limits[j].dcfclk_mhz=
 <=3D
> -                                   clk_table->entries[i].dcfclk_mhz) {
> -                                       closest_clk_lvl =3D j;
> -                                       break;
> -                               }
> -                       }
> -                       if (clk_table->num_entries =3D=3D 1) {
> -                               /*smu gives one DPM level, let's take the=
 highest one*/
> -                               closest_clk_lvl =3D dcn3_5_soc.num_states=
 - 1;
> +       for (i =3D 0; i < clk_table->num_entries; i++) {
> +               /* loop backwards*/
> +               for (closest_clk_lvl =3D 0, j =3D dcn3_5_soc.num_states -=
 1;
> +                       j >=3D 0; j--) {
> +                       if (dcn3_5_soc.clock_limits[j].dcfclk_mhz <=3D
> +                               clk_table->entries[i].dcfclk_mhz) {
> +                               closest_clk_lvl =3D j;
> +                               break;
>                         }
> +               }
> +               if (clk_table->num_entries =3D=3D 1) {
> +                       /*smu gives one DPM level, let's take the highest=
 one*/
> +                       closest_clk_lvl =3D dcn3_5_soc.num_states - 1;
> +               }
>
> -                       clock_limits[i].state =3D i;
> -
> -                       /* Clocks dependent on voltage level. */
> -                       clock_limits[i].dcfclk_mhz =3D clk_table->entries=
[i].dcfclk_mhz;
> -                       if (clk_table->num_entries =3D=3D 1 &&
> -                           clock_limits[i].dcfclk_mhz <
> -                           dcn3_5_soc.clock_limits[closest_clk_lvl].dcfc=
lk_mhz) {
> -                               /*SMU fix not released yet*/
> -                               clock_limits[i].dcfclk_mhz =3D
> -                                       dcn3_5_soc.clock_limits[closest_c=
lk_lvl].dcfclk_mhz;
> -                       }
> +               clock_limits[i].state =3D i;
>
> -                       clock_limits[i].fabricclk_mhz =3D
> -                               clk_table->entries[i].fclk_mhz;
> -                       clock_limits[i].socclk_mhz =3D
> -                               clk_table->entries[i].socclk_mhz;
> -
> -                       if (clk_table->entries[i].memclk_mhz &&
> -                           clk_table->entries[i].wck_ratio)
> -                               clock_limits[i].dram_speed_mts =3D
> -                                       clk_table->entries[i].memclk_mhz =
* 2 *
> -                                       clk_table->entries[i].wck_ratio;
> -
> -                       /* Clocks independent of voltage level. */
> -                       clock_limits[i].dispclk_mhz =3D max_dispclk_mhz ?
> -                               max_dispclk_mhz :
> -                               dcn3_5_soc.clock_limits[closest_clk_lvl].=
dispclk_mhz;
> -
> -                       clock_limits[i].dppclk_mhz =3D max_dppclk_mhz ?
> -                               max_dppclk_mhz :
> -                               dcn3_5_soc.clock_limits[closest_clk_lvl].=
dppclk_mhz;
> -
> -                       clock_limits[i].dram_bw_per_chan_gbps =3D
> -                               dcn3_5_soc.clock_limits[closest_clk_lvl].=
dram_bw_per_chan_gbps;
> -                       clock_limits[i].dscclk_mhz =3D
> -                               dcn3_5_soc.clock_limits[closest_clk_lvl].=
dscclk_mhz;
> -                       clock_limits[i].dtbclk_mhz =3D
> -                               dcn3_5_soc.clock_limits[closest_clk_lvl].=
dtbclk_mhz;
> -                       clock_limits[i].phyclk_d18_mhz =3D
> -                               dcn3_5_soc.clock_limits[closest_clk_lvl].=
phyclk_d18_mhz;
> -                       clock_limits[i].phyclk_mhz =3D
> -                               dcn3_5_soc.clock_limits[closest_clk_lvl].=
phyclk_mhz;
> +               /* Clocks dependent on voltage level. */
> +               clock_limits[i].dcfclk_mhz =3D clk_table->entries[i].dcfc=
lk_mhz;
> +               if (clk_table->num_entries =3D=3D 1 &&
> +                       clock_limits[i].dcfclk_mhz <
> +                       dcn3_5_soc.clock_limits[closest_clk_lvl].dcfclk_m=
hz) {
> +                       /*SMU fix not released yet*/
> +                       clock_limits[i].dcfclk_mhz =3D
> +                               dcn3_5_soc.clock_limits[closest_clk_lvl].=
dcfclk_mhz;
>                 }
>
> -               memcpy(dcn3_5_soc.clock_limits, clock_limits,
> -                      sizeof(dcn3_5_soc.clock_limits));
> +               clock_limits[i].fabricclk_mhz =3D
> +                       clk_table->entries[i].fclk_mhz;
> +               clock_limits[i].socclk_mhz =3D
> +                       clk_table->entries[i].socclk_mhz;
> +
> +               if (clk_table->entries[i].memclk_mhz &&
> +                       clk_table->entries[i].wck_ratio)
> +                       clock_limits[i].dram_speed_mts =3D
> +                               clk_table->entries[i].memclk_mhz * 2 *
> +                               clk_table->entries[i].wck_ratio;
> +
> +               /* Clocks independent of voltage level. */
> +               clock_limits[i].dispclk_mhz =3D max_dispclk_mhz ?
> +                       max_dispclk_mhz :
> +                       dcn3_5_soc.clock_limits[closest_clk_lvl].dispclk_=
mhz;
> +
> +               clock_limits[i].dppclk_mhz =3D max_dppclk_mhz ?
> +                       max_dppclk_mhz :
> +                       dcn3_5_soc.clock_limits[closest_clk_lvl].dppclk_m=
hz;
> +
> +               clock_limits[i].dram_bw_per_chan_gbps =3D
> +                       dcn3_5_soc.clock_limits[closest_clk_lvl].dram_bw_=
per_chan_gbps;
> +               clock_limits[i].dscclk_mhz =3D
> +                       dcn3_5_soc.clock_limits[closest_clk_lvl].dscclk_m=
hz;
> +               clock_limits[i].dtbclk_mhz =3D
> +                       dcn3_5_soc.clock_limits[closest_clk_lvl].dtbclk_m=
hz;
> +               clock_limits[i].phyclk_d18_mhz =3D
> +                       dcn3_5_soc.clock_limits[closest_clk_lvl].phyclk_d=
18_mhz;
> +               clock_limits[i].phyclk_mhz =3D
> +                       dcn3_5_soc.clock_limits[closest_clk_lvl].phyclk_m=
hz;
> +       }
> +
> +       memcpy(dcn3_5_soc.clock_limits, clock_limits,
> +               sizeof(dcn3_5_soc.clock_limits));
>
> -               if (clk_table->num_entries)
> -                       dcn3_5_soc.num_states =3D clk_table->num_entries;
> +       if (clk_table->num_entries)
> +               dcn3_5_soc.num_states =3D clk_table->num_entries;
>
>         if (max_dispclk_mhz) {
>                 dcn3_5_soc.dispclk_dppclk_vco_speed_mhz =3D max_dispclk_m=
hz * 2;
> --
> 2.20.1.7.g153144c
>
