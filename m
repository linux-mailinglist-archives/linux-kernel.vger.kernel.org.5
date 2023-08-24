Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F357872E7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241923AbjHXO6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241948AbjHXO55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:57:57 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0851919A9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:57:56 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a5ad44dc5aso4867865b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692889075; x=1693493875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L8ZdCdslGV7lYgC2z8wsXPTGJqpToifU7gdWaRf1Mc=;
        b=GDNXuEPpzUgkKkWX+WqGCrRSnHLAzkx9ZUozaEdFTipr9OHJo+Viq+6VPSvHv2/P7g
         vub+stjA29kQOGOX480A6X32PcLxzPabgbLd70d3XwyVaBVsfvM+8wH94TzOpUJmLszf
         X+5qnxiWCKtIzK51fOEvCAXrwM6GJSLwHjGRLGDrSqMrBICp7H4otLWRhnmrNqOt6UKO
         bBJSOM2qyAz267xWs/y8LfFI0IpLDxkTES680/ZD1nxFe3fHjOrelBhi0BGA0F0AgyDp
         2pzdkZ7e2xWlTFBDjxdmJLL4GH5yVmpazkyno7RGPxpA40dEqvzofXcuxuuDr8MFPoup
         qqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692889075; x=1693493875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0L8ZdCdslGV7lYgC2z8wsXPTGJqpToifU7gdWaRf1Mc=;
        b=lGE0zND86Q9qWrRvDVIRgPLao7qCuwyeIRCRQx2MsFTWPIzCGU3ENnIJTFDcxDuxTU
         hljLr0b/rRVEemhTdYidDKlK0c5o0dZag08aImuu6gvXSTL8D8TxjGdq69ZC7J2OU6xd
         vwnc2+mh1jZuwNY6ole3B+7gIHexjOPIdNhyFWlJmZwlJnjQKAdazG065T8jn99/o0k8
         gEBkQW5er4/LJypIgTBhKCfK83SzgoiTK4jNdUh+XYoqHcg00P6KZVMvV2kbvSqvu+tp
         XHqGnZwn/Jmmpuuw9j3s8p2pUA8ey+mdjkBrxl5cLSVj5ugWzDDv7aRqgh+PRG/iXFVD
         ml9g==
X-Gm-Message-State: AOJu0Yxnpffc4j8C6YTAEzaEkOlox9UoGGRiXAvYvkKriWZ6So3vXOVG
        3cQ1IQF0esfdbRYnSpJ3JyvH+rmD9HpkKf0CH78=
X-Google-Smtp-Source: AGHT+IEzP66V0cPoFpKqDmO6GqrtdNmngPSWLKjGGYM0VIAt4kyZ16VL2U55cqbLGl4fqQHiq6yBqErfFEEAlfIZRyk=
X-Received: by 2002:a05:6808:138b:b0:3a7:6b1c:8142 with SMTP id
 c11-20020a056808138b00b003a76b1c8142mr23414816oiw.25.1692889075365; Thu, 24
 Aug 2023 07:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230824073710.2677348-1-lee@kernel.org> <20230824073710.2677348-21-lee@kernel.org>
In-Reply-To: <20230824073710.2677348-21-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 24 Aug 2023 10:57:44 -0400
Message-ID: <CADnq5_NC5nmOKj+_-osrM1Taak=-TiF-pV+DWTcg7AzRJROiWA@mail.gmail.com>
Subject: Re: [PATCH 20/20] drm/amd/amdgpu/imu_v11_0: Increase buffer size to
 ensure all possible values can be stored
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
>  drivers/gpu/drm/amd/amdgpu/imu_v11_0.c: In function =E2=80=98imu_v11_0_i=
nit_microcode=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/imu_v11_0.c:52:54: warning: =E2=80=98_imu.bin=
=E2=80=99 directive output may be truncated writing 8 bytes into a region o=
f size between 4 and 33 [-Wformat-truncation=3D]
>  drivers/gpu/drm/amd/amdgpu/imu_v11_0.c:52:9: note: =E2=80=98snprintf=E2=
=80=99 output between 16 and 45 bytes into a destination of size 40
>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/imu_v11_0.c
> index 4ab90c7852c3e..ca123ff553477 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -39,7 +39,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_4_imu.bin");
>
>  static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>  {
> -       char fw_name[40];
> +       char fw_name[45];
>         char ucode_prefix[30];
>         int err;
>         const struct imu_firmware_header_v1_0 *imu_hdr;
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
