Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78189772CEB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjHGR25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjHGR2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:28:54 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA5B10D2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:28:53 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1bfc2b68090so1706950fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429332; x=1692034132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfKREUB/ze/gPaxCIXzG9vbzEZPQ/IuHH12Y4Awob7s=;
        b=bxty7KM+L7WPzdm3wHFGTYyysg+SYH9BXSLV007seXB5Q19wt8VQlX8oeXht3QmZf1
         Y/OlgyVCs8kpIpvICbPmjbcdzA2U1M2vkRhCABjMfR5Yz1dDerNBN+EEBKw/B2nBn/OK
         TV+XH2r598HMG0LhdZkGZCA4JgKUpVUJqxkr5/i2J+bRFGaq8rIag2FYyO0Wgs8JNpNY
         /eWlmwjtEKJVLZsOr6SSqT/aZqkpFtGCEtcklMHw9WD1ECaS3dkayeo98EvX1vkghs03
         OuM1UA82Fygy2vXkuDnhpQfLa8PeL3KuT8IYjcOUkNXkh9e2DaJFFGMOxxn4+ycN+380
         nN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429332; x=1692034132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfKREUB/ze/gPaxCIXzG9vbzEZPQ/IuHH12Y4Awob7s=;
        b=NKJISGych+mud7C3O48aTyqgkd7dPMTXgd/lLbCQ07jb62qIXWH434BxrRtdfx772r
         YoYNcbzm2eDoW9WmLQbxZNTm9Vk4qrA7jkH1DDDnzzvfa41yf2X5QxohwBOn8EjaGcvi
         8GrM6P08Lew1c29NJ/0HkryTWgc9yTd5B0cCoXtYCppMgd4kHJEe68YgZv2HjOB/d6rn
         0aW1E2SEIyqPiTMKjbV2VVpl2lFCeD75s2l1d3Kw9cWgW/qlypTQbahUHx8QQsJInkUW
         3IR9F2g26vlAoQQhblZu7H6KDkdg9glKbSLOy/nrIeq77WbFO1HjXoDSigZ4hsGKP2tY
         dDEQ==
X-Gm-Message-State: AOJu0YzJ6+F9RP9dxJf2wzk3ZFSSdNe42LJsbbX7FCfZP3/IUokUhG0S
        LREJ/1QXk/tfLjvkzGlhK+76WODxmtReXSlI2V4=
X-Google-Smtp-Source: AGHT+IEGDjI/OhRxZswgmS5XS3cRKcjbbEKil1UqockkIM0pWFuIygjmrKnTeLBH5/k2i/hodn6aQ45KdNBTTbqHyzQ=
X-Received: by 2002:a05:6870:ac22:b0:1bb:9c27:c7e6 with SMTP id
 kw34-20020a056870ac2200b001bb9c27c7e6mr13777329oab.41.1691429332553; Mon, 07
 Aug 2023 10:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230802072813.13252-1-sunran001@208suo.com>
In-Reply-To: <20230802072813.13252-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:28:41 -0400
Message-ID: <CADnq5_P__8hWvVZfUzck8cd6-5aHD9P=G+FiCCw8c978gi32dg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in amdgpu_ring.h
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

On Wed, Aug 2, 2023 at 3:28=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: spaces required around that ':' (ctx:VxW)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index 028ff075db51..e2ab303ad270 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -389,7 +389,7 @@ static inline void amdgpu_ring_write_multiple(struct =
amdgpu_ring *ring,
>         occupied =3D ring->wptr & ring->buf_mask;
>         dst =3D (void *)&ring->ring[occupied];
>         chunk1 =3D ring->buf_mask + 1 - occupied;
> -       chunk1 =3D (chunk1 >=3D count_dw) ? count_dw: chunk1;
> +       chunk1 =3D (chunk1 >=3D count_dw) ? count_dw : chunk1;
>         chunk2 =3D count_dw - chunk1;
>         chunk1 <<=3D 2;
>         chunk2 <<=3D 2;
> --
> 2.17.1
>
