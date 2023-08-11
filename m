Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902987793F2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjHKQKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbjHKQKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:10:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6E730E7;
        Fri, 11 Aug 2023 09:10:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so4482310a12.0;
        Fri, 11 Aug 2023 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691770205; x=1692375005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym004eIRmvmMFQo8mUbbqDbth7KmZWTntlVbAplj16M=;
        b=iD5mOfGxgwYbY4SoQbmOj0BMdVHU4yRk7G3NLwTQquvdrbyWGeUX9haPDSdK5LogCl
         9vvVug8VoC6A2cRxOyi9yn0HHK9MSitEZKaNBzS58kno/La6t8knzqqDWfZkwM78ac3p
         hcl2bS8TO9I/xQSXreNkna2iTPdSqVSNL6XnSbmtMNN8a4DpTlconPn8WzccE7Zgfv3Z
         0b0NKr6kjxTAWJqtAni/G8GCexoKnUbRpwc5SNl1HjN06FCGIw50SxW5nstDsL4QclgN
         icMBcCDFaICHZlpciGDBdv82vNk01z40ABV5nGfAvkrD1ZNhzFQnoXCNbo6H8Ioak3+B
         4UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691770205; x=1692375005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ym004eIRmvmMFQo8mUbbqDbth7KmZWTntlVbAplj16M=;
        b=ibBrHas4UPUOCPOVGcxUFu0ktUGK+dl9NUU0vIOm6sTnJaj8P/gnjy5hfEKIax6N0c
         LItlFzDZVw0MeU4E8H3cEh9UbUNSz2QKfy7RFN/0w98NxHf5Ecodgs7TVAZ9XYu05tK5
         PIQXI6sVpKjx+f0rbgs1/sKbxGmCqkuzQoTVw1cVtW0oxs7IErdYBNXsUQzUHfaeCfZ4
         H0FW0JMU+C/ZGpdbOaXDdfeHPQvIhVmIN+rAsK/zjughISY+jfvScqjLxvDgxYOSjOa3
         1Ok56cnGzWrob3B3z1SC40WVAC8mGt0m38NgnSp49C1rXNKQ/1JrJ5oHe6s00jSsn7bt
         wbOg==
X-Gm-Message-State: AOJu0YzbX60S589RMYf5yTBgZRPy6NqgjR2KWH9KPd312KbT40+KS9c4
        QsF6LdTD92HziOQ82HKxDsU1tiAUT+KaDPZ7KvE=
X-Google-Smtp-Source: AGHT+IHFkb/ctd4mXB81bdEaX7yilHpZjHUErqKs2itmxeawzkk3HbLSyuejRPO1s9uFEBweGkHUzrCThnuI87955+M=
X-Received: by 2002:aa7:c683:0:b0:523:3e27:caa7 with SMTP id
 n3-20020aa7c683000000b005233e27caa7mr2262400edq.20.1691770204710; Fri, 11 Aug
 2023 09:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230811160505.174574-1-robdclark@gmail.com>
In-Reply-To: <20230811160505.174574-1-robdclark@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 11 Aug 2023 09:09:51 -0700
Message-ID: <CAF6AEGtNgCxsOLyF31=WCdag4Gb7+2FvFEvOWDcqd_TxiTeE3w@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a690: Switch to a660_gmu.bin
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Fri, Aug 11, 2023 at 9:05=E2=80=AFAM Rob Clark <robdclark@gmail.com> wro=
te:
>
> From: Rob Clark <robdclark@chromium.org>
>
> There isn't actually a a690_gmu.bin.  But it appears that the normal
> a660_gmu.bin works fine.  Normally all the devices within a sub-
> generation (or "family") will use the same fw, and a690 is in the a660
> family.
>

possibly this could be considered as:

Fixes: 5e7665b5e484 ("drm/msm/adreno: Add Adreno A690 support")

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm=
/msm/adreno/adreno_device.c
> index 1ed270dae148..756a9cfe1cbf 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -478,7 +478,7 @@ static const struct adreno_info gpulist[] =3D {
>                 .family =3D ADRENO_6XX_GEN4,
>                 .fw =3D {
>                         [ADRENO_FW_SQE] =3D "a660_sqe.fw",
> -                       [ADRENO_FW_GMU] =3D "a690_gmu.bin",
> +                       [ADRENO_FW_GMU] =3D "a660_gmu.bin",
>                 },
>                 .gmem =3D SZ_4M,
>                 .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> --
> 2.41.0
>
