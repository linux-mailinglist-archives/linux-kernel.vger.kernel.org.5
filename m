Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AAF772C87
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjHGRQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjHGRQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:16:15 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACCCE66
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:15:51 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1bbaa549c82so3735288fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428550; x=1692033350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4m3xuKNdJcZIePVdi/jofYqM8RdbxjSwEerdMBOOUK8=;
        b=SCCOePbPZnapZSA5B1Ros9GJtERXnzDGC0xiuzNykqYbvoP4bswsdxYEwz9Mvj7QIs
         D6Ob6OLoQ0fcmHdcSbXP+EQWUulW5emO1lAB0RXt1wCnAQFB/TZdCYHvsJg1IRZ6tlbU
         D0fW1IHN8vKYrDRjdSDGnMibrU1Aca6zv/QEq0IScIVz7HujGSINIvAkQ3bgekbnPyft
         YI08shKQm7OsBrfkIMna9La9tK8RG+PcflLVHHcnoNVIb46zwxBQRCeRe44aQkQ0C6aV
         0FhtLvOWGvz2AteQw24dMO11cukntHgRkQRymnIhzvRf/v8YXzx3eWAbf93A5fc9LZap
         1Hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428550; x=1692033350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4m3xuKNdJcZIePVdi/jofYqM8RdbxjSwEerdMBOOUK8=;
        b=UmHd+Gr1otNrEO5NhjWhpi2175R+dq0IFWSKYcJY0+EsbJLaq9YJ9HVZ7cuGUMnzLg
         kx3rSD5Qt07Kq36rCYEtWnG6xHLKU6XditdsGKjDySrutBR1ZjduY7edzLgF6i+AEJmN
         4e5J4Isl9u5G63zHhEvDHLKL/ljdiBNK1eZv2BJrtKmM3Yvrro0ht9+849HJ4T2bP78v
         tPblNdzD49y8TYd1D21ciAdNvPmn+TZ6wieoxEdsAtR9lWJK2uhsrRaCmon8jFlCLocn
         WSoLPEA5llL5AwFMK20YqPWf38ikLa0I8V6N1bfoNQHC/IJ+58o+vR6WirliJKaTpaX4
         afOQ==
X-Gm-Message-State: AOJu0YzrZ3YUCwJ/zr+YKC/VkStSh0y6ZVk6dp3CcpCYP/ixMxBug8av
        JIcCeFnlk8sv+so/uUIhu780ccfJgcdu/oDuz6TWAyx2
X-Google-Smtp-Source: AGHT+IFtgkgUChmpyB8Apd1TuU9yc73Zlt+MN4s5triOEcUmrMommjPckPwTZuc3AHbgXbIjMhGv/KjtP9AYdXx8cNo=
X-Received: by 2002:a05:6871:5c6:b0:1be:c688:1c0 with SMTP id
 v6-20020a05687105c600b001bec68801c0mr12673762oan.47.1691428550102; Mon, 07
 Aug 2023 10:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230802062559.11421-1-sunran001@208suo.com>
In-Reply-To: <20230802062559.11421-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:15:38 -0400
Message-ID: <CADnq5_P=vzR3yka11aaLrfLobTFfn+-pvD1yR7F0ccRFN=Qk7g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up errors in dce_clk_mgr.c
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

On Wed, Aug 2, 2023 at 2:26=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: spaces required around that '?' (ctx:VxE)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c b/drivers/g=
pu/drm/amd/display/dc/dce/dce_clk_mgr.c
> index 07359eb89efc..e7acd6eec1fd 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
> @@ -640,7 +640,7 @@ static void dce11_pplib_apply_display_requirements(
>          * on power saving.
>          *
>          */
> -       pp_display_cfg->min_dcfclock_khz =3D (context->stream_count > 4)?
> +       pp_display_cfg->min_dcfclock_khz =3D (context->stream_count > 4) =
?
>                         pp_display_cfg->min_engine_clock_khz : 0;
>
>         pp_display_cfg->min_engine_clock_deep_sleep_khz
> --
> 2.17.1
>
