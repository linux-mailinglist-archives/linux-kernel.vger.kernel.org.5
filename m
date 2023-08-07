Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C817772CE2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjHGR1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjHGR1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:27:39 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5438FF9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:27:35 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1bb7297c505so3310712fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429254; x=1692034054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uy8OaIJgFMpn7QR7vmhG8Oa1kwr3LNfFFiT4wDabSGs=;
        b=aNzTBw0dQkfFi6QOd1CtTyKHTFBTA1odulG1qsOqUcuP7ajAukURSRCe7lf2vO3C7u
         B+juC6Somiij0/9+xUOI72Wrj/gTkGw4IZn6Ro6xOdYIFqeGed1fz2Cqh0rxvUjGi8BD
         J5VnqvdCPyFm+mCuc7KuwjoqhTVY53Ro78yibGYRC6npSeROyqV7bi3xtxCWh1SWXq0S
         ArqhENY6nI5uE6LL/7PuUZwt/00uJ7YFUQFI3Y0FEcdFDdCqQxF0X0KUYj8CkRZ5vrxw
         2yp34KzaUyqkqt1whMbtrhaboFO4XekoYwr6Ka7MzVengX9vH7yXjfH+otJn8YFhbBdG
         dVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429254; x=1692034054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uy8OaIJgFMpn7QR7vmhG8Oa1kwr3LNfFFiT4wDabSGs=;
        b=CJsqn9tUFa9uWXnfNtfTUyNIx3KOAV0AotGEKM5NTZxQ1Jaxe8rZX3/JXTRO7QK/XT
         XN5Zo8buwBHVzdHAlZ1gqcWeGIvdWXdve97JBauPusbhJZne0CWi/BUY0CsCPnWU6jWF
         XNcJQN9VYcySB84sWJXEUF1MQ89pGui5dotF4YoFs1MBKYHFcTOO9Eet5FTbX9HNLB++
         Pw+sYbXhdEyvl5Vz3DrWQI+adTh8ff4yHr4RPF2qcY8PhVu0fmNw6ZeaKp0qIfub2T5v
         Q6VmOlggMBz1ado61UckwvGkG6XIJ/Uwo+0l2WyKw9Af2Je9eaMjOay9XaxGsadd8Gwa
         0lpA==
X-Gm-Message-State: AOJu0Yzw9lQR5jZt3iOWaOewQQeA5K8Z1e2sIEebPr/iTuIxrJggy2Es
        gpyArV+CSsOt4GIlMwKQE6kd9yrVo6zFHjBU6as=
X-Google-Smtp-Source: AGHT+IF9twltV5H6cpjANiMAhCIRdMwPSczCeycCQvUJnSN1tfjwNZHEhKHRe4cYFPryGugJn7iU7fc63rzPR4cUpnI=
X-Received: by 2002:a05:6870:65a0:b0:1ba:caf2:acc3 with SMTP id
 fp32-20020a05687065a000b001bacaf2acc3mr12280535oab.5.1691429254628; Mon, 07
 Aug 2023 10:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230802072440.13073-1-sunran001@208suo.com>
In-Reply-To: <20230802072440.13073-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:27:23 -0400
Message-ID: <CADnq5_OOd_VbWQZC1NoGLa70riT490PTATf2yumWvwndJh8LcQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in mes_v11_0.c
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

On Wed, Aug 2, 2023 at 3:24=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: else should follow close brace '}'
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 11fda318064f..6827d547042e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -788,8 +788,7 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *rin=
g)
>                                     DOORBELL_SOURCE, 0);
>                 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
>                                     DOORBELL_HIT, 0);
> -       }
> -       else
> +       } else
>                 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
>                                     DOORBELL_EN, 0);
>         mqd->cp_hqd_pq_doorbell_control =3D tmp;
> --
> 2.17.1
>
