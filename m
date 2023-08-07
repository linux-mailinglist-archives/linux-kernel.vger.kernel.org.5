Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E31772BDF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjHGQ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjHGQ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:59:48 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1C099
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:59:47 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1bba254a7d4so3704420fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427587; x=1692032387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ax9C43p8yvCgXdr8o1/JSyuVrQ/jKmhK3V7gAOikHI=;
        b=N+jfvJK8Hv+xuffyYqQQ/xDO4j1Pib9L9fTUxisONol4F/95bG9aAb0ruUDAkLphce
         KYdoIC61zE4e2iWAgT5gEoodXPh0XsnBAqqkJHutbIv0b4nsozjUPKR2bod1hdYflDi+
         ijg/gTRvb7xF8+8thNNf4ZxccNzUfCsuCmWPv/jVzMHLhI3gk1xTs45d8Nl/tb8GNDCH
         e/W9Zhpp1On2fZmRJ2slgL/B1Yij7thbKfK+9JOyCMHl73Xmm82vAfVtpBCsVEbg/+5U
         o5Oc1wvySZyqwxkGMStRNlivbzpYheyzahPCvDPq5VAqULiNQGAeGc61bP66lF1Tzf5f
         fT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427587; x=1692032387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ax9C43p8yvCgXdr8o1/JSyuVrQ/jKmhK3V7gAOikHI=;
        b=LfSCJ+7Mhztb0anY5AcYnlgIxe5lBXyvRkq9h32dR0+C8IihMGcWlRcV9ImM6JNiFt
         GvVo24eMD9GABrhzK9ZSrxZQGFG7tu+WxUH4WnQqzoUlX3+v8Rmz19k5gCEULPU/swZB
         sZ8tI2AEXz2s6qJvHOaB49XjXY7zXb25lUB2zSnB/RoXCm380yLzEGfhZbETIbKQUlJv
         PSW5gCYu2z8faJtKruHTgfhYzJrKKlsWt92tz4RXfKNtrKl/d1aJe7/gR8ax6RHm3EtQ
         ReX2Jw6KcxHCWoJ2TJ3F62Uy6xkUJNdnsejmz7CsbeXF0Q0B1TueWDrZaDP8BX6jPD/B
         SADA==
X-Gm-Message-State: AOJu0YyYRVoLIAoQ4thJahPLbS8mg9Qocc+q/ofhYCNN+2iKgSI9Iope
        /AY6qMSsuiasUxLV0r//pbNg0/COiQvZAi2AbVI=
X-Google-Smtp-Source: AGHT+IFmme4ushlh2m2FZxt8mISEYn+sHW9P8tCSwnkoeWtKO4qfTLMRlv9PUG+aufP2O3fRjzdFNcv0UOVJGV0GRnk=
X-Received: by 2002:a05:6870:fbaa:b0:1b4:7191:6d62 with SMTP id
 kv42-20020a056870fbaa00b001b471916d62mr11720054oab.35.1691427587021; Mon, 07
 Aug 2023 09:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230802014800.8945-1-sunran001@208suo.com>
In-Reply-To: <20230802014800.8945-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:59:36 -0400
Message-ID: <CADnq5_N5jZMTTBCkEZ8YBY=ab01biGi0LstzrQzCzJ_xUnB30A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in hwmgr.h
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

On Tue, Aug 1, 2023 at 9:48=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
> ERROR: Use C99 flexible arrays
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/d=
rm/amd/pm/powerplay/inc/hwmgr.h
> index 612d66aeaab9..81650727a5de 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> @@ -190,8 +190,7 @@ struct phm_vce_clock_voltage_dependency_table {
>  };
>
>
> -enum SMU_ASIC_RESET_MODE
> -{
> +enum SMU_ASIC_RESET_MODE {
>      SMU_ASIC_RESET_MODE_0,
>      SMU_ASIC_RESET_MODE_1,
>      SMU_ASIC_RESET_MODE_2,
> @@ -516,7 +515,7 @@ struct phm_vq_budgeting_record {
>
>  struct phm_vq_budgeting_table {
>         uint8_t numEntries;
> -       struct phm_vq_budgeting_record entries[1];
> +       struct phm_vq_budgeting_record entries[0];
>  };
>
>  struct phm_clock_and_voltage_limits {
> @@ -607,8 +606,7 @@ struct phm_ppt_v2_information {
>         uint8_t  uc_dcef_dpm_voltage_mode;
>  };
>
> -struct phm_ppt_v3_information
> -{
> +struct phm_ppt_v3_information {
>         uint8_t uc_thermal_controller_type;
>
>         uint16_t us_small_power_limit1;
> --
> 2.17.1
>
