Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BA676017A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjGXVqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGXVqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:46:16 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58F5120
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:46:15 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-558a79941c6so2781942eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690235175; x=1690839975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NnStTipjate4A8hMy4OAO5j3l8ghoR4SvTd3Ty1jyA=;
        b=dETYlOp9BARBq6hRFY+R8WX/Iwt59GSuDbKPOaJYNmKrIEJ/aptALOufrEn6ziZI+M
         aPwnnUkPJU58oBT2NAXQls7+2gxAQ8AL/Iu5qlc0bGVhVWw2LSpC/Yc//qwTa2mcR/0C
         06nYQffkUtioyMpim1sSeJoJleQS1qMjej6MibXErkHJTGXfv10sk2cjIS5OWcselqBe
         mNm4f3ag2LGexG5kcUbx5ap7s9DcwOv7zPY3ntzH6yxfPybyocYQHdNnAuWRSemrNVo9
         p+9N2T+AK5UqnfBsbBbQPXaiG7iIp868qVgAWUluBv6DPCBC3QHKzVo8OMik4elEM7Fr
         vzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690235175; x=1690839975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NnStTipjate4A8hMy4OAO5j3l8ghoR4SvTd3Ty1jyA=;
        b=fmpfufZOiSOwHdSNFzkCgsREHV277LDXx8sbW/XH9iqZy/A3cv38pe9nRYkdUm7Y/P
         PsEqjzuw8G/4iSYFYkmxsAtYklCVZSKGm1VZuC8E0jYU5R+r8TUl7qdo1YBlagMbB/Py
         i9Az/3kyeOEXen6xH2iaVF6E3heTihphrNS3ZBue7nDMcA+JzMsjL95MDAPiPGO0ST1d
         uVKavd3nQdNcJoz5u0moLwYUjK/m7yWcyHST9uAJsKbi4Zve1OFOGqEUhwbc3+Pn/Aob
         s55uBX6wYiOdP1TvYDFwg4VD9ZGiAH/R9J5/3xBerKQKCHalaGW1Z9L3P48I3HD9ZNFb
         p7zg==
X-Gm-Message-State: ABy/qLb7lRkdDJbZlNrsTWFD9ZBQO6Pz5SAvq8um6QKd5OovKxOi+HJ5
        OGcRrhs/vh1vnNe02X2D/Tlj4CXc+REdFkUk7tCyX1VZ
X-Google-Smtp-Source: APBJJlFMsa/ns3DFCqUpFXCd4aDEpig5u/kEDwcEKFQTS7TJz776r8oPtP60y4QiG9ksz9ois6VQjAzAeialh7bVvPE=
X-Received: by 2002:a4a:2449:0:b0:566:f62b:7b91 with SMTP id
 v9-20020a4a2449000000b00566f62b7b91mr8751740oov.8.1690235175070; Mon, 24 Jul
 2023 14:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230724070049.8540-1-xujianghui@cdjrlc.com> <7ad78e88ddb94a0811947b48b04dfb2c@208suo.com>
In-Reply-To: <7ad78e88ddb94a0811947b48b04dfb2c@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jul 2023 17:46:04 -0400
Message-ID: <CADnq5_MMhpBVbHzaUNNoyxhk-m_2HjF-2kaK3z5mjmrHiORuLg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: add missing spaces before '('
To:     sunran001@208suo.com
Cc:     airlied@gmail.com, daniel@ffwll.ch, alexander.deucher@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Mon, Jul 24, 2023 at 3:02=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> ERROR: space required before the open parenthesis '('
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 8a8ba25c9ad7..a7569354229d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -262,15 +262,15 @@ static int renoir_get_profiling_clk_mask(struct
> smu_context *smu,
>                         /* mclk levels are in reverse order */
>                         *mclk_mask =3D NUM_MEMCLK_DPM_LEVELS - 1;
>         } else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
> -               if(sclk_mask)
> +               if (sclk_mask)
>                         /* The sclk as gfxclk and has three level about m=
ax/min/current */
>                         *sclk_mask =3D 3 - 1;
>
> -               if(mclk_mask)
> +               if (mclk_mask)
>                         /* mclk levels are in reverse order */
>                         *mclk_mask =3D 0;
>
> -               if(soc_mask)
> +               if (soc_mask)
>                         *soc_mask =3D NUM_SOCCLK_DPM_LEVELS - 1;
>         }
