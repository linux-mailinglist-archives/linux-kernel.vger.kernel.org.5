Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8191575CCD4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjGUP6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjGUP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:58:01 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679601BD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:58:00 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1baf05702c4so1590401fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689955079; x=1690559879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZeUxWgbZbQOOu9zXQEd/H5BFiiNhJpxf25MCPQVsN8=;
        b=MUMpaDMWH5he4qGhTVt7ozEMWcR7DMqcNO6xs7rfA48c7LYr9BpeQdWzSiscdSq/hc
         EvrPAIhe9fAewXoibGXavDXBGIDA2kU2VFfETITSld9Uc/iCHNUAvy9f1gXuv9TJoCuZ
         QaoWRLlfkycCNCA64SVz80bBILvNczGOxPSNA4gnKqoWrC3kiJAwPRRovB/200jupVrH
         ibtU3wwjszBsW7HymyuwDOW04KioZzANfyYSVpYN1aG4+06Dga+5UbQdJwDHLf38Uo8t
         kLySeB/lILj2pdpZmQlUNsQjOOuxJ/VSZU7iuAvV/HVpo08golw6nXTIwwjiRLkA9feM
         NrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955079; x=1690559879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZeUxWgbZbQOOu9zXQEd/H5BFiiNhJpxf25MCPQVsN8=;
        b=P0xu1ypBfpKFD/DtT3AZPmOqqh8RkPV2W2R+qvA6COQyd/oGeuwbpSqKK1TKFna/yI
         goNIJU+Q4V6eBi+7RTfv++HwyZ8sVOh1JZzor4/uTguX6+aWitnIyn1FZB/BFHqgG1V9
         ykZgbnlskkDCYGiMqWcCTm3gmBvCau674pbIYe27KUlQAcfR+RBfROFO3MjFwrq9tCYU
         94NVrhuGy+dq0eohAqXA+kNLMNhjnYNl8xGo4i7oYi/BXaVp/eOjSCg5/lGIAaLTz4yz
         J6z+n63cE3XjICf5+K6YVafWlR/3iwa79n9/yyvsWMVIvxGC9O+aGiz6SUVk5uNDj4l7
         2OWA==
X-Gm-Message-State: ABy/qLYDqPvgkPVqjeCjugHds66EFrByUsH//uwCTu4VEajAG9gIwPNM
        wwZ0bZGLQD6Ryyn57Lw9lArHIid0BgJ/Lt9IVAs=
X-Google-Smtp-Source: APBJJlH444C8IPtwpejKuE6GYLqPtYKQIDgpO4RYWXSo+9vxTzDLITTa4MyNdiFO8dR1GpO8+vWqmwKb/wVp0tgirGE=
X-Received: by 2002:a05:6870:eaa3:b0:1b0:b15:245 with SMTP id
 s35-20020a056870eaa300b001b00b150245mr2852819oap.16.1689955079677; Fri, 21
 Jul 2023 08:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230721033048.4840-1-xujianghui@cdjrlc.com> <d0906df99cdf6f76220e298bebaa5029@208suo.com>
In-Reply-To: <d0906df99cdf6f76220e298bebaa5029@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 21 Jul 2023 11:57:48 -0400
Message-ID: <CADnq5_P0hQbv81OnSjp7_RS92yOMzuNQfJZf_DKY7K_viSz5Vw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: open brace '{' following struct go on the
 same line
To:     sunran001@208suo.com
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Jul 20, 2023 at 11:32=E2=80=AFPM <sunran001@208suo.com> wrote:
>
> ERROR: open brace '{' following struct go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> index 52045ad59bed..eec816f0cbf9 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> @@ -24,8 +24,7 @@
>   #ifndef __AMDGPU_PM_H__
>   #define __AMDGPU_PM_H__
>
> -struct cg_flag_name
> -{
> +struct cg_flag_name {
>         u64 flag;
>         const char *name;
>   };
