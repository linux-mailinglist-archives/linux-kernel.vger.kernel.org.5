Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B5677BF51
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjHNRwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjHNRv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:51:58 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E82894
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:51:58 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a76cbd4bbfso4367771b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692035517; x=1692640317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIBMc1Pc73jtTeqexlKEiDPeJffujSakc49ekoQBfEw=;
        b=X0GzjxNkFGdsC2FAJ0D0BeFPlg+0QkEZzweKtNqg/6IpcR6A5qVnbDZ7ykD+TV3iNd
         DxOGLsXpcrRQqI4uqKBxBkK9mSnlO6Jem1upRzZgaHX3y1iV+bxfijkDp3c3Ls0OAwLa
         eNPNIzbaoXxiOBRP1V7ZHkBkR4GRqhiHoH6T4QOG65szHCi4+0FSal6iGsbR2yUJhaW7
         V3R+9sQu5AiPrdrnx9LhOA4jVUHS1cGOpH0IsVHGw/JZnr1eUsjyMJdu3o0atm2j1fEE
         z7SYvdSF3cpcUxyJ0jYj/DIbea7BtKhumoYnhgsi9uWasa9UmcNzRSvRpdCu0J1gWvuq
         PwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692035517; x=1692640317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIBMc1Pc73jtTeqexlKEiDPeJffujSakc49ekoQBfEw=;
        b=T+YwW1DTOf6E44SBmi7Jdy/b+XPALV/k5PgCYSQxF4UucIvMaCExS31cPvfQc1P9Nm
         qeCRX+FJVC4+shhQ4PwU69xPdC1jfm3B3yW5B24Ebp8n8VEDkOoeRrtu4grYYdhjIY8r
         wLSHjLO3H/FyF9A/vgK0PAZClWvZ6qQIXFS6nuah+RFtklsYtOECxCaig8k0kyxvDfKc
         862RD2IyYp19BjC1BKOtFL0xS6w1pizeR/KSKpoC4yZb4zMBR+s6mz2wK14Va6d45Nbk
         E1GeNZgeYWw/zKLKAi04Ot5jRJRFESPddRciXDuaujcXvmuzsHYvemmP4Ofvd8rosEUh
         yqNQ==
X-Gm-Message-State: AOJu0YxjGlXJ250I1I5dhULupVNy7O1TPTBn/VUow7T3Id0p0do0WDoQ
        8ETQqkgIbR/PF2GwAyCR2tschmngkBJPtNA4v7E=
X-Google-Smtp-Source: AGHT+IESEwrsFUbztJaxvtJi++NMkNad4w1FKUijFhYl0d8tpjrbfjvVvQgcHh1aXZsKt+AHt+JbeThdt46h0wcJr2o=
X-Received: by 2002:a05:6808:1316:b0:39a:bd0e:43d with SMTP id
 y22-20020a056808131600b0039abd0e043dmr14466780oiv.36.1692035517491; Mon, 14
 Aug 2023 10:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230731092108.3162-1-sunran001@208suo.com>
In-Reply-To: <20230731092108.3162-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 14 Aug 2023 13:51:46 -0400
Message-ID: <CADnq5_P0L5Np9U5N11EKXKW1K7K8S7GGiBRJDU1Hh3a0Bmts4w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu_v11_0_pptable.h
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

On Mon, Jul 31, 2023 at 5:22=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: trailing whitespace
> ERROR: open brace '{' following struct go on the same line
> ERROR: code indent should use tabs where possible
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h  | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h b/drive=
rs/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
> index 0116e3d04fad..df7430876e0c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
> @@ -101,8 +101,7 @@ enum SMU_11_0_ODSETTING_ID {
>  };
>  #define SMU_11_0_MAX_ODSETTING    32          //Maximum Number of ODSett=
ings
>
> -struct smu_11_0_overdrive_table
> -{
> +struct smu_11_0_overdrive_table {
>      uint8_t  revision;                                        //Revision=
 =3D SMU_11_0_PP_OVERDRIVE_VERSION
>      uint8_t  reserve[3];                                      //Zero fil=
led field reserved for future use
>      uint32_t feature_count;                                   //Total nu=
mber of supported features
> @@ -127,8 +126,7 @@ enum SMU_11_0_PPCLOCK_ID {
>  };
>  #define SMU_11_0_MAX_PPCLOCK      16          //Maximum Number of PP Clo=
cks
>
> -struct smu_11_0_power_saving_clock_table
> -{
> +struct smu_11_0_power_saving_clock_table {
>      uint8_t  revision;                                        //Revision=
 =3D SMU_11_0_PP_POWERSAVINGCLOCK_VERSION
>      uint8_t  reserve[3];                                      //Zero fil=
led field reserved for future use
>      uint32_t count;                                           //power_sa=
ving_clock_count =3D SMU_11_0_PPCLOCK_COUNT
> @@ -136,8 +134,7 @@ struct smu_11_0_power_saving_clock_table
>      uint32_t min[SMU_11_0_MAX_PPCLOCK];                       //PowerSav=
ingClock Mode Clock Minimum array In MHz
>  };
>
> -struct smu_11_0_powerplay_table
> -{
> +struct smu_11_0_powerplay_table {
>        struct atom_common_table_header header;
>        uint8_t  table_revision;
>        uint16_t table_size;                          //Driver portion tab=
le size. The offset to smc_pptable including header size
> @@ -145,14 +142,14 @@ struct smu_11_0_powerplay_table
>        uint32_t golden_revision;
>        uint16_t format_id;
>        uint32_t platform_caps;                       //POWERPLAYABLE::ulP=
latformCaps
> -
> +
>        uint8_t  thermal_controller_type;             //one of SMU_11_0_PP=
_THERMALCONTROLLER
>
>        uint16_t small_power_limit1;
>        uint16_t small_power_limit2;
>        uint16_t boost_power_limit;
> -      uint16_t od_turbo_power_limit;                //Power limit settin=
g for Turbo mode in Performance UI Tuning.
> -      uint16_t od_power_save_power_limit;           //Power limit settin=
g for PowerSave/Optimal mode in Performance UI Tuning.
> +      uint16_t od_turbo_power_limit;                //Power limit settin=
g for Turbo mode in Performance UI Tuning.
> +      uint16_t od_power_save_power_limit;           //Power limit settin=
g for PowerSave/Optimal mode in Performance UI Tuning.
>        uint16_t software_shutdown_temp;
>
>        uint16_t reserve[6];                          //Zero filled field =
reserved for future use
> --
> 2.17.1
>
