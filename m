Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164EB772CFF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjHGRbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHGRbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:31:18 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21C6107
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:31:16 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-56cc461f34fso2827762eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429476; x=1692034276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qod5ilU5NMCuYABqWl1EUZiybqxTkFSupdOBDiWIwRU=;
        b=SJn3HAsXO6yEmMDIkJ9yWQkrqPEc2KzFkVJ0ShZWnldFsvftJf3ECrJ/2hzhMub6mr
         8YmbyZpHha8GChHbn7ehrbt7dnLnU/A497c+Hn4dHP5jmCK5R5G5PEXHWtkV784oi3jp
         RHnf/6gvtyiT1XkeOS9nutjVdnJfaaiUpT3wFsDG0NplfuNSPGs/6BA+vuvVxLILj1e2
         N7KxAR5gRTzaIVGy2AVIScoWRRpYcC9oIuZtgvdDnFPTVneh6C6dsthhecoCg2+B8qgC
         /Kc9MRuHNEPKA+vjUWZHlxltfBEx6TAzrz/Tts9iptrE0Juj/eiHW/aawoQzDno79A7r
         7bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429476; x=1692034276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qod5ilU5NMCuYABqWl1EUZiybqxTkFSupdOBDiWIwRU=;
        b=apkQtzfhKx1NXPI29O66Ic8/PEcnof3hRkxQFlYDTOXbAFCvEO+QsolosPdKXcnj4w
         tF1t5FMdpmtcgO8dIIT271vF3yC+ywgGzUkXKCbBXAO4CwXMh6IrhF/pH4YIYxmk/4ps
         SiKCFfermzLQgIcNl9gezEMZXUa1zFT4Lb0KEOZXZUqRhk7nSV7uGYwTshx4pbJO5tz5
         UTpHLek41iQoAnZmd6kk0J4ER49GN6QlkMNsSUHrWWAW40aKzSHZZVKH4q424K7gkvdb
         OQ93saJJ5W5E2Ll37Oxg+mPl9hpfuKWBcVj6xr57CIA4WaC+fKyRQelemRSdt/tnw3V2
         snFA==
X-Gm-Message-State: AOJu0YwO8A1vVslToTEQYAtzTTGOMn+ka6dzLhvOsRAuKemZgT1ps6uA
        35fRNRt13nVsg9Vemku/8Wgq7t/qIbXceM5mAJw=
X-Google-Smtp-Source: AGHT+IEVIihYiKP4M3IF6i2MpyJEiOQILtmqR+qZI3b4Mjg1G5d9WRQ99MTXk+RHgQTWwKTJ9yAY2ZpiY3BQUo/RqHo=
X-Received: by 2002:a4a:2750:0:b0:56c:cefc:55d with SMTP id
 w16-20020a4a2750000000b0056ccefc055dmr9289982oow.4.1691429476124; Mon, 07 Aug
 2023 10:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230802073715.13598-1-sunran001@208suo.com>
In-Reply-To: <20230802073715.13598-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:31:05 -0400
Message-ID: <CADnq5_NqdXju2Wf2PgiFX_83idVdy0E7AT0vMZ6JCn+inn6P5w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in uvd_v3_1.c
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

On Wed, Aug 2, 2023 at 3:37=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v3_1.c
> index 0fef925b6602..5534c769b655 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -815,8 +815,7 @@ static const struct amd_ip_funcs uvd_v3_1_ip_funcs =
=3D {
>         .set_powergating_state =3D uvd_v3_1_set_powergating_state,
>  };
>
> -const struct amdgpu_ip_block_version uvd_v3_1_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version uvd_v3_1_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_UVD,
>         .major =3D 3,
>         .minor =3D 1,
> --
> 2.17.1
>
