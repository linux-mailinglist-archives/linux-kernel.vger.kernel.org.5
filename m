Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E4F7FFD73
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376869AbjK3VY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376849AbjK3VY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:24:57 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073BE133
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:25:04 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54af1daf6a9so2241028a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1701379502; x=1701984302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8c4Eu/Dubr5HSF4fDhNSD3Be+bs9dIetpJRDNp7v/M=;
        b=AZXKaZglrga8zJSFfonIzWWCD8rBCBLroR7NAUEwCCey2gOBjhJlv1Zppywp8uWrEx
         Ac2JxQ6SiMbT5igfh8/EyvPwoKZ8WK8DfFCbFf+foXp0D75W2ZftdWdZBsk2wLngef30
         mZ/tEyLdt8lNdXgTIPG781oAyyF9VEOLH9T0MvuaNYA3sUJyfMo9HQ3xdjC3lJwQEd35
         M5XvYOTG46VwCX1sJTB9Ir3DDGw4ifjEs3PvVGigbLqZp1Y0cOBJ3ZSOthgROZ7Mfgxj
         8+8TAykkqkfkOHfPK1ld47rLhmb529L9FslMLElS3cZyHaozSDIaPU6zPUHhuYXJi3PD
         UHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701379502; x=1701984302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8c4Eu/Dubr5HSF4fDhNSD3Be+bs9dIetpJRDNp7v/M=;
        b=Hggao8DzICunMPc3KZY9IK+dLT8bl0tf07BVNsYHIkhfngz9mDz+SgiA2B2YTolmxR
         R8CyxGWhpmlTNrVBYiuZwFibrsSko4LD3XaLoG7BdzyGCOgcwLA10NxdYkLeVhDGnv+k
         XXsZr0AwBgs7OBd432mj6Dxn6WgXjunS4gV0s4Df/HU8F50/olnZxAadrv7JQSc4bFRw
         7943EOgpxyHogsV7O28M/wMLQNSTbWWlQnhNwsdc8qW1zzJA2E0vHTE0G+RXWihxVDkg
         HPz/JThSNjOH3DwmPC/5Chp8wiR2jJjW5ipzUsrj8NMVVJhd9da3sojrSlZ7U3vbP4e0
         nrQQ==
X-Gm-Message-State: AOJu0Yy9yPWxfTm2KxWjhfi1f4Do+HixXme7bTtVRGrTZUxf4gv2qxRx
        NowixfDpHd6V/MMXCTCE+JalPua9cDlNmpHY6M83Lw==
X-Google-Smtp-Source: AGHT+IG0ta2XtylneHDppsL8gcmXtn/Q/+7/EPbWdZikXUYS2NOvcQ4OqXc4VNcjnztwP5GcK+tdQYNKGciNXohB/fY=
X-Received: by 2002:a50:aa9b:0:b0:545:3b25:d142 with SMTP id
 q27-20020a50aa9b000000b005453b25d142mr198098edc.15.1701379502435; Thu, 30 Nov
 2023 13:25:02 -0800 (PST)
MIME-Version: 1.0
References: <20231130192119.32538-1-robdclark@gmail.com>
In-Reply-To: <20231130192119.32538-1-robdclark@gmail.com>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Thu, 30 Nov 2023 15:24:51 -0600
Message-ID: <CAKXuJqgrKLw7rFdJcgueR4=tUdpP52i0P8pJoins6-9z6=sxfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Correct UBWC settings for sc8280xp
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Danylo Piliaiev <dpiliaiev@igalia.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 1:21=E2=80=AFPM Rob Clark <robdclark@gmail.com> wro=
te:
>
> From: Rob Clark <robdclark@chromium.org>
>
> The UBWC settings need to match between the display and GPU.  When we
> updated the GPU settings, we forgot to make the corresponding update on
> the display side.
>
> Reported-by: Steev Klimaszewski <steev@kali.org>
> Fixes: 07e6de738aa6 ("drm/msm/a690: Fix reg values for a690")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mds=
s.c
> index 6865db1e3ce8..29bb38f0bb2c 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -545,7 +545,7 @@ static const struct msm_mdss_data sc8280xp_data =3D {
>         .ubwc_dec_version =3D UBWC_4_0,
>         .ubwc_swizzle =3D 6,
>         .ubwc_static =3D 1,
> -       .highest_bank_bit =3D 2,
> +       .highest_bank_bit =3D 3,
>         .macrotile_mode =3D 1,
>  };
>
> --
> 2.42.0
>
Tested on Lenovo Thinkpad X13s
Tested-by: Steev Klimaszewski <steev@kali.org>
