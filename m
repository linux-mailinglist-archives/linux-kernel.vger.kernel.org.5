Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071D1787283
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241844AbjHXOyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241873AbjHXOyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:54:16 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5689D1995;
        Thu, 24 Aug 2023 07:54:14 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1cc87405650so2806042fac.2;
        Thu, 24 Aug 2023 07:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692888853; x=1693493653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uq2Rz/w+UiLDK0KSC/5EPK5xtKDfT2UzyQDOd90+rl8=;
        b=r/u41aDOlFvgovHMmxhiPpcEp8F3dJl8NxdLPxd0RxgM7IeYIS2+Y1e22SXn2H4JK9
         wAAj07E/4rQfvEHH78dkNfzgCtH8kkUhQ/+e1oEUwY9SAawpg7of/CSO1oMJJ4tBJQoN
         32yY0NGzLKwGIBxObrFeqoO6/fFyk3DmUiI6RzHZQDiYGTYIk4033+rCnWnXwzBHaPwv
         eDa2wI4zP9HwCaZrxWax2aFgAEQiwoOVvI790S2dd2iPQABKg3DvytsQ3hnfosUuLv8X
         Lot58yYxx9ceTIJw7VJqNmkroxkti/8y949toMoaUOgtm1A1DSdd4Pc+yWWedC3nAom9
         +c2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692888853; x=1693493653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uq2Rz/w+UiLDK0KSC/5EPK5xtKDfT2UzyQDOd90+rl8=;
        b=geNpATnCn8kd5c3Ptxf3lNxI+2sUOWgaS5aAvz95vaJ23RJnEQY7k6zI3RwRSpnw01
         /Qp5SavgAosTeAgqyrsWCciwEeLL5vgAdpm6F/evEGEPi6rr2E5hCAqNV7A4Z0PN2LUR
         6we6RyhWE9IGvnik+rZwLpzwdcYOF7xYWNL6stsxpx6hpUVBkRvnhxFmegWK8CI2Dsxa
         VFGa2rqkhuYm6kuuQAC4MoK8H4dbQJ56b3jcU6qurMXk8uY+IQaagjWl5+EC4BcCztPd
         csxQHNEuQakWdSigOG/LKDrVNKbSlsiDAOgbgtH/R3i2X0Yw1Q4nctqAU5sS8jY4OlR3
         rBmQ==
X-Gm-Message-State: AOJu0YxDwfFgEPUCsOL7oueyazfTzG1QMFHoZkn88zpJb/JdiClC8MLY
        UBgAWaNlOIjtwcEGGiFiCdT3MglxE/qJZLuIi2zr3UUM
X-Google-Smtp-Source: AGHT+IHUyRZ/s5Z6miDsZM4/btsiHyGcD5fOaPP18HwdLud7Ptz241jKPAZW2574frmcEqtpe95tmk35JGOaA0yWEFY=
X-Received: by 2002:a05:6870:702a:b0:1b3:54b5:ac6e with SMTP id
 u42-20020a056870702a00b001b354b5ac6emr19528580oae.50.1692888853662; Thu, 24
 Aug 2023 07:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230824073710.2677348-1-lee@kernel.org> <20230824073710.2677348-13-lee@kernel.org>
In-Reply-To: <20230824073710.2677348-13-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 24 Aug 2023 10:54:02 -0400
Message-ID: <CADnq5_MHVEyxf0-xnbWq7q83OPVmp-0os+Fekaa6BEpXijA_xw@mail.gmail.com>
Subject: Re: [PATCH 12/20] drm/amd/amdgpu/amdgpu_device: Provide suitable
 description for param 'xcc_id'
To:     Lee Jones <lee@kernel.org>
Cc:     "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org
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

On Thu, Aug 24, 2023 at 3:38=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:516: warning: Function parame=
ter or member 'xcc_id' not described in 'amdgpu_mm_wreg_mmio_rlc'
>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e77f048c99d85..d4f0e4327dd3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -507,6 +507,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
>   * @adev: amdgpu_device pointer
>   * @reg: mmio/rlc register
>   * @v: value to write
> + * @xcc_id: xcc accelerated compute core id
>   *
>   * this function is invoked only for the debugfs register access
>   */
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
