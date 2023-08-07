Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49120772CBE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjHGRXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjHGRXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:23:18 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAF1F9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:23:08 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1bed90ee8b7so2689653fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428987; x=1692033787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHe5wFpuck9FxbQdSwbkpcG9X/3F59XkMZTvwR3jHW0=;
        b=I35OvquxuMieROZKO1UAIz0eH/wAeTrZ3CxA4JRMN5XbO7l53ynGb9/JtssTBXZzgn
         f29cMN7MaxRjgIn6qBbioCXVTOn/ShqRulmra84eVLmomuvK0neQsnkl47G5L8AClxIs
         2avL8zHT22UO48nkML1ckjGEwcnnr6uhDhi9YcNgTisHgGVWhTO06zjPTSLfbRZcLZ6r
         siujggA/TAUy8n1DYLoSoR1Ybc5ugx4Izuu6SYIoHFRkFLEaFMLFjfh8Nu5w5xctP3K1
         AT24QRmhw6qajS+7kbjLerMtI7K2dyBjMaz2iu4jXef/oAsZkli0Bh115phTRsDpHUuk
         MHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428987; x=1692033787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHe5wFpuck9FxbQdSwbkpcG9X/3F59XkMZTvwR3jHW0=;
        b=RMvXKnTaxq7+yl8v9eTKPcDZQ8AR0x29d32huVMIRmBRmFuM/essd79NzpOSD3d2Ra
         f1InAuRSG4jBX5ctGKIuEBump3F3xNJxwLrvmYQ6uNi6HYeWeNklZvEz1XAP1on/ZRIj
         UYnOFiWZEpJIzZ9LPhAg/iC9H/UOJj+JAd4gzutR73vXqzabBPBKxbHxYkTvhpw79T01
         AwVNF+Og/GEsPkpcPdfgV28m5DapjbETNJhzFNMUVhpsCLjSUVxEISqDfsa/liTf75DJ
         w0hlfmUuPdJJZoT7CCQD3XfPlOZD0udAGp1zMmVFfzT9fP8e2lz/oLixAkwfd2594Y2s
         QBjg==
X-Gm-Message-State: AOJu0Yyl1J15XM9h/MFtv4Hp5OH45PKl6lntGD0riO837xEaFb3w36iy
        xh/5CaKkalhna06i5h4f4D1fwedtHKlIjD9r0Hw=
X-Google-Smtp-Source: AGHT+IEqpYfiuoRzZYazqnVHJZFegWBzehLFDJ25obToxUn4mP6Lf0P1qd3skeEa9rUa1TjeH5uUc29E25kfbyZ34qs=
X-Received: by 2002:a05:6870:65ab:b0:1bf:597b:2343 with SMTP id
 fp43-20020a05687065ab00b001bf597b2343mr9676547oab.30.1691428987442; Mon, 07
 Aug 2023 10:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230802065958.12449-1-sunran001@208suo.com>
In-Reply-To: <20230802065958.12449-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:22:56 -0400
Message-ID: <CADnq5_MiXEV7xLWbjsQOiuLn_Xn5z11jDP_xFS+4s+deWnt5rw@mail.gmail.com>
Subject: Re: [PATCH] drm/jpeg: Clean up errors in jpeg_v2_0.c
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

On Wed, Aug 2, 2023 at 3:00=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v2_0.c
> index c25d4a07350b..1c8116d75f63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -807,8 +807,7 @@ static void jpeg_v2_0_set_irq_funcs(struct amdgpu_dev=
ice *adev)
>         adev->jpeg.inst->irq.funcs =3D &jpeg_v2_0_irq_funcs;
>  }
>
> -const struct amdgpu_ip_block_version jpeg_v2_0_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version jpeg_v2_0_ip_block =3D {
>                 .type =3D AMD_IP_BLOCK_TYPE_JPEG,
>                 .major =3D 2,
>                 .minor =3D 0,
> --
> 2.17.1
>
