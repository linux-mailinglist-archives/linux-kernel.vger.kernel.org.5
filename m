Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BCC7CDE23
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344838AbjJRN7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344812AbjJRN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:59:33 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0C5113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:59:30 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bd04558784so4758465a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697637570; x=1698242370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJsFVEu0nZS2XQuTUeDLT7XtWcBNpvC9dTMB0YQtl08=;
        b=jgfihO2VPfAbDh85976Fs7ofgR3Ck4yNRIJ6Kog4w28QqeLt+p533nWYcfmtuCQeiv
         cZ8/Tmp3EQ0s72Fmh1umT+cw2aUY6zY306yE0vahZCQYMMk9E1XPnBV1gXmThY44NNRK
         hKmbhfIhMrv6eYI65OE8W9Ti1Z7N6Yrz/wr5/36HEWaNvqSdaqSBNywqNQLmeUpmTnEl
         wRHzqwR3pGtv7HNjz57S7bU/aNmRZe+gPeD17GPr7Tga62QoLtok5IBpdVmKqQ1M+WGK
         VYgOGMc9Qfo7sXD6/w6kWAAPzExHwV9k+tNIGWCsxgoiDJmDGUB8VQfkpuzX7Tf7yJp/
         tPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697637570; x=1698242370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJsFVEu0nZS2XQuTUeDLT7XtWcBNpvC9dTMB0YQtl08=;
        b=knO34bKs7XF+btDn8KhihHTJ/7OQsVXvMSxKjmcoKtTNxqlQUK7WiP7cVvTuu0EYYe
         Q9HbX2jka3aw6xsYQUFUAWAlO78DvjgZr/CXj5jfMOwx8S7px+uE/oIdw/HPI3jKOTl3
         FJFK9czdYv/gl1b6fMHQ8WBXXX37j1LIw0VGjgIlGzulD3skWRwDXi6EWGD8GizX+5Pp
         EyUC26B30iQaggX2bmKPw8yaLbHAD4qsrgZguKf2rZ873GENJC9iIsII8+lFtQ9kpLZV
         A7YM9xF8sA4sIxvCVinO2a/3HT12UUhnAmNPOtdzCrKSAmsCEMK59ASJ4WtHtTtJeFk2
         wzpA==
X-Gm-Message-State: AOJu0YxRIBM4nqLY8GJC61eKJerz3t6Uca5SgTLEBT/tuNgAMNHzTkGz
        2FraTfFroJvvifLbfaIWiDosSKaPW1UMVJdaJCg=
X-Google-Smtp-Source: AGHT+IHcSaXI8TATTgE0uFsyojz0oilu79AqJoPzqbYkazhnwilzrsOpJuwICO2yzMpVi+I/x9RR8bf6OhrrUddnT3U=
X-Received: by 2002:a05:6870:be98:b0:1ea:118d:3e8e with SMTP id
 nx24-20020a056870be9800b001ea118d3e8emr5548202oab.56.1697637570046; Wed, 18
 Oct 2023 06:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231018011614.10883-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20231018011614.10883-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 18 Oct 2023 09:59:19 -0400
Message-ID: <CADnq5_M=tRaFQVivkUQqRO1t_RWOgd5=FnRtuo4scAu5eTg+cg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, harry.wentland@amd.com,
        airlied@gmail.com, daniel@ffwll.ch,
        Abaci Robot <abaci@linux.alibaba.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Tue, Oct 17, 2023 at 9:16=E2=80=AFPM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> ./drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c:464:3-4: Un=
needed semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D6900
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c =
b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
> index 36baf35bb170..f45fbe820445 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
> @@ -461,7 +461,7 @@ static void sort_pipes_for_splitting(struct dc_plane_=
pipe_pool *pipes)
>                                 swapped =3D false;
>                         }
>
> -               };
> +               }
>         }
>  }
>
> --
> 2.20.1.7.g153144c
>
