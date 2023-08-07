Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CCF772A8D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjHGQYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjHGQX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:23:58 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F182E173D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:23:32 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bcccbd9365so3641702a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691425386; x=1692030186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7MLgX//c9aErISuUZEec4pqzAsW+rw0jQNMnk+tMag=;
        b=YTfBQIIP3baZBzHLZfZAMXXo1vU4qQaj4/9FJAZ5yCXXUFTOmBSm5XOSFICbcXZN34
         cr4MqOZpTff4/J6LFvhwCPmHLfyAC/y3y9pB3W1oUiWI3YTqzj/zezcF/tDCrrGdxAsX
         QbLxFWWYIWY9uqW4feTfYHsMF8/iWFW+Ujq7V08hj974ZQWAk9xMlzEO8CaSbm139ZHK
         0hHba4i4DViLEzTdrUQpKuaoAAw0HilZqSTPJ/lc2gVUk6B0cJTENI7FomaHjao9vs5h
         7YrsUvOXPQepjT6wKL/PgoViCoa7EmoIVXlgnX56+SFK9nMsecw44IMBrg39+2nhMUJJ
         rTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425386; x=1692030186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7MLgX//c9aErISuUZEec4pqzAsW+rw0jQNMnk+tMag=;
        b=Qd/lViKJCTs4uwQ5Mpwwi/vecwJNzfWj/TvR1JK9GhhkxGwK56ejIqcbX6gajIHJLz
         3xC5zPV81XxWJK2Tf+Mtl3qSw6RoDK4SEKXD2n9iC4nNy3COjaN4xYSmAaq794WU9Fn6
         wrd83fMV3XlsVOX2P58YwmrnBMz0KI1ankXEkMPdid8Jn0gscNbYH4DuIH2mHcNszJIw
         rkKbCleJWHnnTd1Hqpec2uPE4lNp8wZBrX0V9fVLazGw8ZC9ZFcQ+8fWWJQj+o9m7ikE
         Q5mFcuXNs8+UxN5SuRQGwAD4zBNCl0de7ogunYF4PbriYSM5p4FbxxlpyLhB3Rj27x9f
         wjsw==
X-Gm-Message-State: AOJu0YxZ+zUMR93NopURdBFLxatQDxotT7hLmySLEpsYLTsbqiYFciE1
        Y7v3o7hx4QcLA1AQjqjjoo7D6uuUtY1Rq6Ko8N0=
X-Google-Smtp-Source: AGHT+IFPbosy3FdWE+KBz+V5wTA/k7xCp/jTZ0S6fFWDwY+GhxsenpyI5P9bf18tADOmQWbNFhp2w+gBiVrjFRBItqQ=
X-Received: by 2002:a05:6870:d611:b0:1bf:7b3:5116 with SMTP id
 a17-20020a056870d61100b001bf07b35116mr12624311oaq.47.1691425386563; Mon, 07
 Aug 2023 09:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230801021129.4458-1-sunran001@208suo.com>
In-Reply-To: <20230801021129.4458-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:22:55 -0400
Message-ID: <CADnq5_NZLtJjmRPo=GXhftc1_g=8OsJBawb6j1sCAKs1788JEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Clean up errors in smu_v13_0_5_ppt.c
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

On Mon, Jul 31, 2023 at 10:11=E2=80=AFPM Ran Sun <sunran001@208suo.com> wro=
te:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: space prohibited before that ',' (ctx:WxW)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/dr=
m/amd/pm/swsmu/smu_internal.h
> index ceb13c838067..bcc42abfc768 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> @@ -61,14 +61,14 @@
>  #define smu_feature_get_enabled_mask(smu, mask)                         =
       smu_ppt_funcs(get_enabled_mask, -EOPNOTSUPP, smu, mask)
>  #define smu_feature_is_enabled(smu, mask)                              s=
mu_ppt_funcs(feature_is_enabled, 0, smu, mask)
>  #define smu_disable_all_features_with_exception(smu, mask)             s=
mu_ppt_funcs(disable_all_features_with_exception, 0, smu, mask)
> -#define smu_is_dpm_running(smu)                                         =
       smu_ppt_funcs(is_dpm_running, 0 , smu)
> +#define smu_is_dpm_running(smu)                                         =
       smu_ppt_funcs(is_dpm_running, 0, smu)
>  #define smu_notify_display_change(smu)                                 s=
mu_ppt_funcs(notify_display_change, 0, smu)
>  #define smu_populate_umd_state_clk(smu)                                 =
       smu_ppt_funcs(populate_umd_state_clk, 0, smu)
>  #define smu_enable_thermal_alert(smu)                                  s=
mu_ppt_funcs(enable_thermal_alert, 0, smu)
>  #define smu_disable_thermal_alert(smu)                                 s=
mu_ppt_funcs(disable_thermal_alert, 0, smu)
>  #define smu_smc_read_sensor(smu, sensor, data, size)                   s=
mu_ppt_funcs(read_sensor, -EINVAL, smu, sensor, data, size)
>  #define smu_pre_display_config_changed(smu)                            s=
mu_ppt_funcs(pre_display_config_changed, 0, smu)
> -#define smu_display_config_changed(smu)                                 =
       smu_ppt_funcs(display_config_changed, 0 , smu)
> +#define smu_display_config_changed(smu)                                 =
       smu_ppt_funcs(display_config_changed, 0, smu)
>  #define smu_apply_clocks_adjust_rules(smu)                             s=
mu_ppt_funcs(apply_clocks_adjust_rules, 0, smu)
>  #define smu_notify_smc_display_config(smu)                             s=
mu_ppt_funcs(notify_smc_display_config, 0, smu)
>  #define smu_run_btc(smu)                                               s=
mu_ppt_funcs(run_btc, 0, smu)
> --
> 2.17.1
>
