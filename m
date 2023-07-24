Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D20B760158
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjGXVko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjGXVkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:40:42 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442611987
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:40:27 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-565db4666d7so3019575eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690234826; x=1690839626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMfua460X0apacBl5wqrH5vgW/88RJ55cY6fU8YFXfA=;
        b=lYGdh2YK5Fg5BkCX4oqNyWwUPhziLbMzoDETdbKONtA8QpFD85AFZjCKIcbkmTVQjw
         A5RqQGx5iyo2Z9yBn8ODp0Uh3rOiv4RrRXgfB8zqxF351PtJ1FkbDMXLcpmqeZsF9o29
         sSN68FinuSEYXQzJdt4aJvOyV4ebADAxreHn57F4uRnuYYCrnxFnXs0242YDPBTIdwe2
         zf91jhq+OmAGmLVUT2zmW/JIjDb/KR6gdQhpD8uYkVu6era/3U1tS8qzl7d9AJVfutNN
         E2TZUe4gQlfOA9F45aV8ifXO/7n07blK0+bzPw88tZ1KHPT35L2PZxKyWAt6Rbv3xG6p
         RSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234826; x=1690839626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMfua460X0apacBl5wqrH5vgW/88RJ55cY6fU8YFXfA=;
        b=RkGXGtu12T2kG67t8s3cFSb/WspvYe5lOg1abwTtdswkM3iZRzw9nclMAL0dUfKoKF
         ZVOj+7br+yyZ2SfaqPYFy0UGaPUytIGYt77krMhql0IvmKKwaTKxT1krOttWQLyQ1HVA
         JoJTTt2om1JyUBkUlLGqaH5oYiczozCvGgXN9gj3AGqkdzRg/DnVyMVrTRMUQdI+G/mY
         P62PJvZsfGHPLidwCDIrbsoMZQ8uZTLlBwcDXTOE4MDUIbNUmRXeB9MQsJbZj8eGyV6D
         zpsiiQ5sx16FkuVBk+ySVJ/QKfIaZWvfy4fQEkqaTEI8/rW/SY+gW7LEUzEhXFpTtob7
         7z+A==
X-Gm-Message-State: ABy/qLYMNS/uYpWvSwc5JrIGksUaPlljf4RcU02VJXoqDiEnSMQHWPdf
        1JcjzTRQvfcCjKXRWbgHV5itWiVTCwvx3+c2TUU=
X-Google-Smtp-Source: APBJJlE8rJYaFVv1WEucDG903MNh9x+vPzM+y7XkVmyGxftiixebysG6dVf3Mz8h4nHXdpxCd9ypl8ARGVcIR5CCaFU=
X-Received: by 2002:a4a:7607:0:b0:566:6b6a:e1f with SMTP id
 t7-20020a4a7607000000b005666b6a0e1fmr8635081ooc.7.1690234826537; Mon, 24 Jul
 2023 14:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230724033555.8039-1-xujianghui@cdjrlc.com> <e30b4bea0907fe4f94459e0afd5c24a9@208suo.com>
In-Reply-To: <e30b4bea0907fe4f94459e0afd5c24a9@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jul 2023 17:40:15 -0400
Message-ID: <CADnq5_M_Mu+L2HNBbWn5Q1jEmxXSPAd-=0hg9+smWV6oG0i5tA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: that open brace { should be on the previous line
To:     sunran001@208suo.com
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Sun, Jul 23, 2023 at 11:37=E2=80=AFPM <sunran001@208suo.com> wrote:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/radeon/clearstate_si.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/clearstate_si.h
> b/drivers/gpu/drm/radeon/clearstate_si.h
> index 356219c6c7f2..7da8418704fe 100644
> --- a/drivers/gpu/drm/radeon/clearstate_si.h
> +++ b/drivers/gpu/drm/radeon/clearstate_si.h
> @@ -23,8 +23,7 @@
>
>   #include "clearstate_defs.h"
>
> -static const u32 si_SECT_CONTEXT_def_1[] =3D
> -{
> +static const u32 si_SECT_CONTEXT_def_1[] =3D {
>       0x00000000, // DB_RENDER_CONTROL
>       0x00000000, // DB_COUNT_CONTROL
>       0x00000000, // DB_DEPTH_VIEW
