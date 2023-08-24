Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC577872CC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbjHXO5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241944AbjHXO4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:56:55 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEBD1995
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:56:51 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-56d8bc0d909so4214986eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692889010; x=1693493810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlcXwQ+/lXfgHKsvPhtLOQCn3QX2DeYFbnPXFqzydHI=;
        b=HU6LW1B2SsNfR94cbSDMGTPaz88t/ZKs7rY4d+RaBdxLGhAoo3IH4IBlNIzjMv9Kd/
         CeXYy0mf0OiyyOTq04aM7gY+iqcZ+pHjWO8UaXzin7eiIhczfnzFtNOMTriqM5H4uRBK
         fSN37Vh/UjfXaNXEhB1F4fnlOXTS4CQxqefTmHRaQhOa4UqCys7NFbQs6ajrj1KWTG1B
         2wRzDxeexeAUp2yVvqp8O2goxiLQivnoZU8/GfHC8FNQN0ysgQD7+0B/RegYc4PUVXUU
         BhbPWswjbosgilnztPzHNXGqDgnJAkEbQtCI2NF4Fg9CmZxVRWaVHG98xXDdtRiQkxq6
         3HXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692889010; x=1693493810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlcXwQ+/lXfgHKsvPhtLOQCn3QX2DeYFbnPXFqzydHI=;
        b=lwZCRJlhFClCJDlxZiq5fpF50dcinAWhGu28q0RJjFAAVJrwZ1Eie+Tw8VkEc77gnO
         Lq67euVk179rQ+RE53Njwk8M4Bs4qeq556VdNykIftMXN7exdE+Z8Smi+0onG9MugO+x
         aKinc3ba9gDThACU9LAnYmSgCOfdVg/QRogc6lrZKsoAPkkdVcEDhgVUQLB6vI6gCfV3
         q9ZQ91AI475tK5l5V1XkDUpaifiUaI1WhMjGrIRphP/ZjC6Op+DJhD8msJiyxebfWULu
         +ogjMvP8FMKyarJ6SmH3Fs9+Q0cFQqwJ2MckolPa3RL3y0pInbniny3MLtYdeWAX+tII
         XRoA==
X-Gm-Message-State: AOJu0Yzw2vKWoBDcg7pu/hXMGw0RkncdFLwc3KqRJcQ5+p+qpSIOwie7
        1QbI1/ncD/r4Rm21+qJN9LN2xsciljt6SDLzM0A=
X-Google-Smtp-Source: AGHT+IG4J0uzwUdCGMigPK38FQL18XegkqRc6MfGFZit80x/D2PQ+IVpsh5ToiPkSjIUWb+70TCg3Qx7JYZz/McsWxA=
X-Received: by 2002:a4a:d1d7:0:b0:56c:7a55:f6b3 with SMTP id
 a23-20020a4ad1d7000000b0056c7a55f6b3mr2465522oos.5.1692889010331; Thu, 24 Aug
 2023 07:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230824073710.2677348-1-lee@kernel.org> <20230824073710.2677348-20-lee@kernel.org>
In-Reply-To: <20230824073710.2677348-20-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 24 Aug 2023 10:56:39 -0400
Message-ID: <CADnq5_Pucn7UidJLtkaLhB=1AGgrZeN2ax2fFj3PXMYO6iDyag@mail.gmail.com>
Subject: Re: [PATCH 19/20] drm/amd/amdgpu/amdgpu_sdma: Increase buffer size to
 account for all possible values
To:     Lee Jones <lee@kernel.org>
Cc:     "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c: In function =E2=80=98amdgpu_sd=
ma_init_microcode=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:217:64: warning: =E2=80=98.bin=
=E2=80=99 directive output may be truncated writing 4 bytes into a region o=
f size between 0 and 32 [-Wformat-truncation=3D]
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:217:17: note: =E2=80=98snprintf=
=E2=80=99 output between 13 and 52 bytes into a destination of size 40
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:215:66: warning: =E2=80=98snpri=
ntf=E2=80=99 output may be truncated before the last format character [-Wfo=
rmat-truncation=3D]
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:215:17: note: =E2=80=98snprintf=
=E2=80=99 output between 12 and 41 bytes into a destination of size 40
>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index e2b9392d7f0de..572f861e3f706 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -208,7 +208,7 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *=
adev,
>         const struct sdma_firmware_header_v2_0 *sdma_hdr;
>         uint16_t version_major;
>         char ucode_prefix[30];
> -       char fw_name[40];
> +       char fw_name[52];
>
>         amdgpu_ucode_ip_version_decode(adev, SDMA0_HWIP, ucode_prefix, si=
zeof(ucode_prefix));
>         if (instance =3D=3D 0)
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
