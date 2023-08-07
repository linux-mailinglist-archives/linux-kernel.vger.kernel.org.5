Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB4F772BD7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjHGQ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjHGQ6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:58:40 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088B5210E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:58:24 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b9defb36a2so4491043a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427503; x=1692032303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdIDxHlj3CBjEs4/nbCl29OQGxlIEXIjwPDyccsPxDE=;
        b=andONpF4M/88tEP2nqehwpuHN7tQ3fImuVgkX8eWzlSKV2lc/RwxoVl8VmJ+UYCnEg
         A2m1Ix+2Imf1UdtHZTL34HJOrtIUX8TNly1xld4iUVqveSQTyAL0SpGbSyMyKC/Uc0XR
         WMQcMQmwirnQz84Hq7m2G40WowDjwGoTNP6yPVsDsx5AYXS0tooNBAq4onubGWjhCwT9
         Q89Dt3yomRLyYM7myoltbdOy8uqHFGj90EojIyg7S915cS/qFabiUvF8qaHJz3RJf/sB
         4qZADKs9BFyKsxUCmS90fa0pVMHQ4hSK9/cb3WJlRqO1nmtmgj1zmzIKPZI/mcy9Hjv9
         iqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427503; x=1692032303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdIDxHlj3CBjEs4/nbCl29OQGxlIEXIjwPDyccsPxDE=;
        b=d/4ff6QOhO0BgG24kf01o2+inkgY3AelJO4NUI0y65FIb0qwCbIHyv+SEMon2WhDBL
         Qiukl8eijHIjQFLF9q7Nj8vaSYx+lJtwItCS9tk06j9QSFgNounHCMP2EEs9DjAfIQl2
         iAMn2FdfiEhhZnaQXY21nH4zoaR6fWRU6PQyOnaTDbz2Xc45BuV3bry8rbhq0dKgLdpg
         8SLstCSQ8qkw0pDgiO4tbrRNNJdjV4OQldNnLfkVMBx0/s+Jg11cbQwRVTJj20cWTxIN
         etZWO/CODZOTp/2PJFGyaz20qvOiEKHhv77krDvM/3uwUIqgNqVJqFRmB1tjbDBsWvnA
         47/g==
X-Gm-Message-State: AOJu0Yxq7tDrxztokoEESFeoOoRgkYm7e/MURL4fLqUKgJHatxtfj0Se
        oernSE3Cu9dKGBZX7VD+KD2TXJ1Gf9Kij7wfvSw=
X-Google-Smtp-Source: AGHT+IFTGh7xGv1PL5QDFuVB2WyIhIetxgTZttc29LRUs6RK4LBIlMq8AQYuQjrD5hikB7bp3y/QblOCIXCtkrvwk+g=
X-Received: by 2002:a05:6870:5694:b0:1bf:1246:4e8c with SMTP id
 p20-20020a056870569400b001bf12464e8cmr13106946oao.11.1691427503318; Mon, 07
 Aug 2023 09:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230802013818.8766-1-sunran001@208suo.com>
In-Reply-To: <20230802013818.8766-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:58:12 -0400
Message-ID: <CADnq5_O6nh6jxUWhvf_ZTyfDzrFWqLCpO6mkasxw02c__oCYag@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in pp_thermal.h
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

On Tue, Aug 1, 2023 at 9:38=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h b/drivers/=
gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
> index f7c41185097e..2003acc70ca0 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
> @@ -25,14 +25,12 @@
>
>  #include "power_state.h"
>
> -static const struct PP_TemperatureRange __maybe_unused SMU7ThermalWithDe=
layPolicy[] =3D
> -{
> +static const struct PP_TemperatureRange __maybe_unused SMU7ThermalWithDe=
layPolicy[] =3D {
>         {-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 9=
9000},
>         { 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000,=
 120000},
>  };
>
> -static const struct PP_TemperatureRange __maybe_unused SMU7ThermalPolicy=
[] =3D
> -{
> +static const struct PP_TemperatureRange __maybe_unused SMU7ThermalPolicy=
[] =3D {
>         {-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 9=
9000},
>         { 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000,=
 120000},
>  };
> --
> 2.17.1
>
