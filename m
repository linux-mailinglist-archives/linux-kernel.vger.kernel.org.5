Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93AA772C76
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjHGRPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjHGRPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:15:00 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F20D10D3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:14:43 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1bb717ece50so3546683fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428479; x=1692033279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWD6TxvdwSAH/B9jUxdL6rJdTRaVEm9tb0ibIt4x1Y4=;
        b=AQH7GqBt/UT+Q1k+/kh20XyTPgdDGza18M0j8AVGijLPA7XvfvjiKyi7JIKWUsv3lt
         fkWVLoAXk9SB6IKJjCgTMDTg4TiumV37XFx3n3uqS6VayjEpgOZbM8c7Pq2/mKCtgDEa
         aeJZjnUkxVaSfiq9nf3SkuCOrqhAZhs8D+O/YW29zzRuHcgs1zY3YsubQ9jz3Rfm7+2f
         kZJ213yEGjGjYgUFK79NZK7CrZRUf6lsbK9Z0XzsV8wcPnwPmaOdqp9NaT6UxrwYNkZt
         shn/XTI+c4MxxbWAtGvb3mCsDgPavYWAO5W/lWiOxj0wfHbhj9asvWgUQxN1VxiYKvNT
         uu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428479; x=1692033279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWD6TxvdwSAH/B9jUxdL6rJdTRaVEm9tb0ibIt4x1Y4=;
        b=DVzpiytNVd8E0aiaXQ/1qUSQF+tOsXcBeQyttOmcd2v+cIk6Pv+HMrvPkgGnOK2Umf
         IX+FIwKpODTck6CtDY2CswDaJ1UGqAt6eM3KOAkG0WPoVzwbwj/40UR/SX/P1EXs3XBk
         1QPBXIyd8hv49xC0IHWBEDpTmIFG7Ca/kMJV3wQsWoe4L4ag7C+hW/TJXeR2pbdcUeWn
         jzOTfLtsrT1zoFFaMhJlDoVzvkQfoaUteffcCiYbeD74vxDJKzhIJvJZIjGhdbYhZN3B
         ddyTyD0aMsn3LI0dqt8Csxuw8B83zsGpEVIHL7DrdrJoLbP4Z6thgHecfmvK2X9zyku/
         XnmA==
X-Gm-Message-State: AOJu0YyHx6n0UxOGwsEMblhC2Bs0uf5Of5B2rXG5JttDOGZsMUGv6NSN
        X+NZKF++Ie6zefCUq0fiTcDlImJiG7gMDDpZaJk=
X-Google-Smtp-Source: AGHT+IE+ptLVBkibVh5g1Pp3F+dxRftBDAb7kEDscU/+Vga6QjAdNv9SbXnNPKKp77IsK5KFrgqzXxisWYrLw4tvEGU=
X-Received: by 2002:a05:6870:6392:b0:1b3:d457:f27a with SMTP id
 t18-20020a056870639200b001b3d457f27amr12770303oap.50.1691428479622; Mon, 07
 Aug 2023 10:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230802061635.11243-1-sunran001@208suo.com>
In-Reply-To: <20230802061635.11243-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:14:28 -0400
Message-ID: <CADnq5_PwxZ1-0K=AR7DTdZb6vuTT66h_Op5hVnRW_VAqHP3bng@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up errors in dcn10_dpp_dscl.c
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

On Wed, Aug 2, 2023 at 2:16=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: else should follow close brace '}'
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/driv=
ers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
> index 7e140c35a0ce..5ca9ab8a76e8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
> @@ -197,8 +197,7 @@ static void dpp1_dscl_set_lb(
>                         DITHER_EN, 0, /* Dithering enable: Disabled */
>                         INTERLEAVE_EN, lb_params->interleave_en, /* Inter=
leave source enable */
>                         LB_DATA_FORMAT__ALPHA_EN, lb_params->alpha_en); /=
* Alpha enable */
> -       }
> -       else {
> +       } else {
>                 /* DSCL caps: pixel data processed in float format */
>                 REG_SET_2(LB_DATA_FORMAT, 0,
>                         INTERLEAVE_EN, lb_params->interleave_en, /* Inter=
leave source enable */
> --
> 2.17.1
>
