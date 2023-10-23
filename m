Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB887D406B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjJWTmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjJWTmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:42:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E048B4;
        Mon, 23 Oct 2023 12:42:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso5841836e87.1;
        Mon, 23 Oct 2023 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698090133; x=1698694933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2ftM92OKCvSHhh6kb+Glq3Mcgd9kOqth29i32E6zLk=;
        b=nSFIIjZlgDhwPVaKTaBCbptV3T9XiW4JVcjIokitb5AsuggcKlc3vegyu+Lddcngcx
         mR+92B42ET6SVpnAKtSq0geUZy5dBmDcJkGtsKBpmhr0DGbYtojdqTz/URbVj5gTs3gS
         hIcenGMJI0zQvCXWfd+CAlvJ5Zb0NugogPiILU5wD7FnZh9cT5wq4F1MZVdKSzoTS4Fl
         rCF/g6XoJZWbE6ptJEC8gJB2BwJrScXjHIsErcOVVRWte4Sg3sNjCqxXoeql1oRuQdgk
         TdIbuhZq5WsCPin5uK9wkEybyiKw88w8HqpWwT3H5X0E8h+ATJ5ZyHk9Oo/ybCo6wDOD
         CRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698090133; x=1698694933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2ftM92OKCvSHhh6kb+Glq3Mcgd9kOqth29i32E6zLk=;
        b=seIwQA2ocMF0I0rcWzLGN/fAvHjCQFoyCeaO4yy++I85gAHWjitUU5pJ3MS3osmuQq
         KBcNRad7ts084OpoTsfjBQPGawitgwqS5XFAC2yp/6cUd51RMxTU+RkEoCgUMgtoj/EE
         qIQpIUngPMfNykzmauGGvAPttqtTHUQx7ieNI8sL8nRmFPpaEbv88I81EW4ClJ6DfXfT
         VZwxW21dGb7z8EAI8tn319VaiSGmLY6s1lGUCoc2rj4FkWZW5iOt/An+cR1zBv0NaZJy
         CAycQkPysaxs/OntXv+U/OQFItPSHWglf6IzUJnJEBmEyA78cn/DgDw0US4cgB7jcqgm
         w+WQ==
X-Gm-Message-State: AOJu0YyN9k/7I54pI3kbaxp4vYQSgjN5EB+SZpNmfqKYK/rKG5ukrCPg
        Sr5c9Wvrbn1AX7MZoChm65NzOixlOg8dza40+es=
X-Google-Smtp-Source: AGHT+IF4lDMnNBYukqzCpYss3e4EVRZ5jF5bIM8cAJMJ+yDp9VG5fMNFAGPBIuG0X89cUrHMw6pPpByRVz55Skj4vcA=
X-Received: by 2002:ac2:5edb:0:b0:500:aed0:cb1b with SMTP id
 d27-20020ac25edb000000b00500aed0cb1bmr7346416lfq.24.1698090133099; Mon, 23
 Oct 2023 12:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231023-topic-adreno_warn-v1-1-bb1ee9391aa2@linaro.org>
In-Reply-To: <20231023-topic-adreno_warn-v1-1-bb1ee9391aa2@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 23 Oct 2023 12:42:01 -0700
Message-ID: <CAF6AEGuS3PhNbh9Gmu1g9YpUcr3LOh1gZK-XBE+urdb5jRjorg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: Drop WARN_ON from patchid lookup for new GPUs
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
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

On Mon, Oct 23, 2023 at 7:29=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> New GPUs still use the lower 2 bytes of the chip id (in whatever form
> it comes) to signify silicon revision. Drop the warning that makes it
> sound as if that was unintended.
>
> Fixes: 90b593ce1c9e ("drm/msm/adreno: Switch to chip-id for identifying G=
PU")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.h
> index 80b3f6312116..9a1ec42155fd 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -203,11 +203,6 @@ struct adreno_platform_config {
>
>  static inline uint8_t adreno_patchid(const struct adreno_gpu *gpu)
>  {
> -       /* It is probably ok to assume legacy "adreno_rev" format
> -        * for all a6xx devices, but probably best to limit this
> -        * to older things.
> -        */
> -       WARN_ON_ONCE(gpu->info->family >=3D ADRENO_6XX_GEN1);

Maybe just change it to ADRENO_6XX_GEN4?

BR,
-R

>         return gpu->chip_id & 0xff;
>  }
>
>
> ---
> base-commit: e8361b005d7c92997d12f2b85a9e4a525738bd9d
> change-id: 20231023-topic-adreno_warn-42a09bb4bf64
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@linaro.org>
>
