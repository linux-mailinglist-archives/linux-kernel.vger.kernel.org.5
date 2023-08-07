Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29997772BF2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjHGRCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHGRCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:02:47 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3112799
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:02:46 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1bfc2b68090so1689606fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427765; x=1692032565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVDRCRyPz3INS8u4EM9etCObKyj/3EsmxYYKXXODKZE=;
        b=nTzR/+6yCKJ7RqlGTmTSGv2vZ0CWsYlLhAtPUxMdevcT/oe6KJeuWJIhJe8XxxTnH6
         udz0UCjZha3wwbr2Lt25n8T55NJwuXeXkFULIgJuEClMVEzbEc6N14z5f471sOb20Oq0
         Xa14Yr3QNlMZRQbD8CBjgoNiRck3QoAc7Q1Pg6SkLqAruSiUpBOyGXhNPZK3axCC315A
         XqM6LZk7TgN3HB2FOv3x8w1XfgPHe3VkVY6ALMthj9RjuIiLoRdTbQqWHaBmMqnG4ucy
         p60p6BLxOkAq/QccN4bnxUsizGKGrkGPdxpJbh2CrimfYjcAqTnzp+cMyetO93fuS/pQ
         fzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427765; x=1692032565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVDRCRyPz3INS8u4EM9etCObKyj/3EsmxYYKXXODKZE=;
        b=azAM/gm7m/nt6R3N9GSc6AjvRAF/81o9W+wlQZLBZeujN5kPPpVtp+Hm8/GpyWLhNM
         U7sqq2uU2XtHo8PplXaRWYMFGAEPtDP3ogTnhsD3O+8mo5JPzqHbqriDYKBdS/c4jNex
         rsVKphciFZZS7b1o8AbBIeHEWunIK0TM1tfpaBO5/jFs/wiCeFaXsRrHsS53iloZV0bG
         sL4tWnv7+Uk4zai/6YSYkjRbuuTuz+PGkMClQZFBL3LW32ukwJ1eD8Y7jMeejIAww5Mb
         Cxg0Q3y5NoV/S1ib2hs+LAVf+n7BsFkrBNMFAhrwWRDaV97XBGXG/FumCrv0ayh5mizA
         bnbQ==
X-Gm-Message-State: AOJu0YzlDdJB4vkyQ4b3smGxvnQ6qwgK5kReJtwhNMXYxQR1SFytUUGG
        oaH6AyVxAVAAPlVDu88EHPcDiUL/SmKHBWK9o3VeE5Bh
X-Google-Smtp-Source: AGHT+IEeNjiTIeipTK+Jbtsq0baJSbOl1Cc9WIM2akrlEBkaEIBuus/uC4NmtBJ0hiKmYUa+/qnglepu+ep70QgGlKQ=
X-Received: by 2002:a05:6870:c222:b0:1ba:59da:31dc with SMTP id
 z34-20020a056870c22200b001ba59da31dcmr13033330oae.24.1691427765434; Mon, 07
 Aug 2023 10:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230802020943.9322-1-sunran001@208suo.com>
In-Reply-To: <20230802020943.9322-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:02:34 -0400
Message-ID: <CADnq5_MSiAwBwHJW=0kOD149miv1heCTGt2Q4RiJNFU1Zq7SaA@mail.gmail.com>
Subject: Re: [PATCH] drivers/amd/pm: Clean up errors in smu8_smumgr.h
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

On Tue, Aug 1, 2023 at 10:10=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
> ERROR: space prohibited before that ',' (ctx:WxW)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c | 48 ++++++++--------------
>  1 file changed, 17 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/kv_dpm.c
> index 36c831b280ed..5d28c951a319 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -191,8 +191,7 @@ static void sumo_construct_vid_mapping_table(struct a=
mdgpu_device *adev,
>  }
>
>  #if 0
> -static const struct kv_lcac_config_values sx_local_cac_cfg_kv[] =3D
> -{
> +static const struct kv_lcac_config_values sx_local_cac_cfg_kv[] =3D {
>         {  0,       4,        1    },
>         {  1,       4,        1    },
>         {  2,       5,        1    },
> @@ -204,32 +203,27 @@ static const struct kv_lcac_config_values sx_local_=
cac_cfg_kv[] =3D
>         { 0xffffffff }
>  };
>
> -static const struct kv_lcac_config_values mc0_local_cac_cfg_kv[] =3D
> -{
> +static const struct kv_lcac_config_values mc0_local_cac_cfg_kv[] =3D {
>         {  0,       4,        1    },
>         { 0xffffffff }
>  };
>
> -static const struct kv_lcac_config_values mc1_local_cac_cfg_kv[] =3D
> -{
> +static const struct kv_lcac_config_values mc1_local_cac_cfg_kv[] =3D {
>         {  0,       4,        1    },
>         { 0xffffffff }
>  };
>
> -static const struct kv_lcac_config_values mc2_local_cac_cfg_kv[] =3D
> -{
> +static const struct kv_lcac_config_values mc2_local_cac_cfg_kv[] =3D {
>         {  0,       4,        1    },
>         { 0xffffffff }
>  };
>
> -static const struct kv_lcac_config_values mc3_local_cac_cfg_kv[] =3D
> -{
> +static const struct kv_lcac_config_values mc3_local_cac_cfg_kv[] =3D {
>         {  0,       4,        1    },
>         { 0xffffffff }
>  };
>
> -static const struct kv_lcac_config_values cpl_local_cac_cfg_kv[] =3D
> -{
> +static const struct kv_lcac_config_values cpl_local_cac_cfg_kv[] =3D {
>         {  0,       4,        1    },
>         {  1,       4,        1    },
>         {  2,       5,        1    },
> @@ -260,39 +254,32 @@ static const struct kv_lcac_config_values cpl_local=
_cac_cfg_kv[] =3D
>         { 0xffffffff }
>  };
>
> -static const struct kv_lcac_config_reg sx0_cac_config_reg[] =3D
> -{
> +static const struct kv_lcac_config_reg sx0_cac_config_reg[] =3D {
>         { 0xc0400d00, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00=
000001, 0 }
>  };
>
> -static const struct kv_lcac_config_reg mc0_cac_config_reg[] =3D
> -{
> +static const struct kv_lcac_config_reg mc0_cac_config_reg[] =3D {
>         { 0xc0400d30, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00=
000001, 0 }
>  };
>
> -static const struct kv_lcac_config_reg mc1_cac_config_reg[] =3D
> -{
> +static const struct kv_lcac_config_reg mc1_cac_config_reg[] =3D {
>         { 0xc0400d3c, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00=
000001, 0 }
>  };
>
> -static const struct kv_lcac_config_reg mc2_cac_config_reg[] =3D
> -{
> +static const struct kv_lcac_config_reg mc2_cac_config_reg[] =3D {
>         { 0xc0400d48, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00=
000001, 0 }
>  };
>
> -static const struct kv_lcac_config_reg mc3_cac_config_reg[] =3D
> -{
> +static const struct kv_lcac_config_reg mc3_cac_config_reg[] =3D {
>         { 0xc0400d54, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00=
000001, 0 }
>  };
>
> -static const struct kv_lcac_config_reg cpl_cac_config_reg[] =3D
> -{
> +static const struct kv_lcac_config_reg cpl_cac_config_reg[] =3D {
>         { 0xc0400d80, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00=
000001, 0 }
>  };
>  #endif
>
> -static const struct kv_pt_config_reg didt_config_kv[] =3D
> -{
> +static const struct kv_pt_config_reg didt_config_kv[] =3D {
>         { 0x10, 0x000000ff, 0, 0x0, KV_CONFIGREG_DIDT_IND },
>         { 0x10, 0x0000ff00, 8, 0x0, KV_CONFIGREG_DIDT_IND },
>         { 0x10, 0x00ff0000, 16, 0x0, KV_CONFIGREG_DIDT_IND },
> @@ -1173,9 +1160,9 @@ static void kv_calculate_dfs_bypass_settings(struct=
 amdgpu_device *adev)
>                                         pi->graphics_level[i].ClkBypassCn=
tl =3D 2;
>                                 else if (kv_get_clock_difference(table->e=
ntries[i].clk, 26600) < 200)
>                                         pi->graphics_level[i].ClkBypassCn=
tl =3D 7;
> -                               else if (kv_get_clock_difference(table->e=
ntries[i].clk , 20000) < 200)
> +                               else if (kv_get_clock_difference(table->e=
ntries[i].clk, 20000) < 200)
>                                         pi->graphics_level[i].ClkBypassCn=
tl =3D 6;
> -                               else if (kv_get_clock_difference(table->e=
ntries[i].clk , 10000) < 200)
> +                               else if (kv_get_clock_difference(table->e=
ntries[i].clk, 10000) < 200)
>                                         pi->graphics_level[i].ClkBypassCn=
tl =3D 8;
>                                 else
>                                         pi->graphics_level[i].ClkBypassCn=
tl =3D 0;
> @@ -1825,7 +1812,7 @@ static void kv_set_valid_clock_range(struct amdgpu_=
device *adev,
>                         if ((new_ps->levels[0].sclk -
>                              table->entries[pi->highest_valid].sclk_frequ=
ency) >
>                             (table->entries[pi->lowest_valid].sclk_freque=
ncy -
> -                            new_ps->levels[new_ps->num_levels -1].sclk))
> +                            new_ps->levels[new_ps->num_levels - 1].sclk)=
)
>                                 pi->highest_valid =3D pi->lowest_valid;
>                         else
>                                 pi->lowest_valid =3D  pi->highest_valid;
> @@ -3333,8 +3320,7 @@ static const struct amd_ip_funcs kv_dpm_ip_funcs =
=3D {
>         .set_powergating_state =3D kv_dpm_set_powergating_state,
>  };
>
> -const struct amdgpu_ip_block_version kv_smu_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version kv_smu_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_SMC,
>         .major =3D 1,
>         .minor =3D 0,
> --
> 2.17.1
>
