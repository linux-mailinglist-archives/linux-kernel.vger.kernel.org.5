Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08BD7F2777
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjKUIaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKUIaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:30:15 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2028E95;
        Tue, 21 Nov 2023 00:30:12 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-462a3085cbdso462992137.3;
        Tue, 21 Nov 2023 00:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700555411; x=1701160211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Frv37yPvfcDooKdSS0NeyQY4VlcSJhlXGgNXBAAYfKw=;
        b=Rz1QDYuGdZGBRdFH9eCTh4VavLtyCrXAiKIirZH4xvc77ZnbTiwMqLWNZUvJrywo8V
         dNPSYOWmxSHqx0iRSt1snQuZVEW8uM6gx3g9d1hloGC7UBKOOklk2VGxwB8mavSWCxJg
         +qIX8kXeIEcrm/HR3AOfS7Q1NP9hhyud87xG2sRg9g+G7aOsqhwYLoJqRnAtzMoJ8NYZ
         IaKNhyG/Xv9Aak+JNRSo0wNB3CJvm2TqzfFn1aJQdp4ZD7/cPFVUNecfCGi3c7IOG5Fi
         L/2xg+BWhrEA24m7DUl7zOeWio/dOUcFaI4+xlo9ccgMMDFg27mCp20cMCR2qBGj5dHy
         dqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700555411; x=1701160211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Frv37yPvfcDooKdSS0NeyQY4VlcSJhlXGgNXBAAYfKw=;
        b=pXuNBknqoBGcQcL7esyyAYa74uiCphQVosphWb4gdlfg9VGsvjh41/KkaY3dYl08WJ
         t0GojGgddbOymmRV9kJHTNxylyK2oQ5MN9xo85g4TEI97m1VKvlKc5m5j2gS6vIVXIem
         05NmF7yElv7LVZJ4ZLLGrK1G96s+p19L5IbfOjNhIfONRabInMVj365P0ibgT/nto2fh
         6GFXHGusjwQbtHgr944ruHlUtOR77LjWESCiaYm2BTaE3KemIpu8z1MhxfXEa2dlRm/m
         UdVfXjXpVMXBlNoDFZZep3Stu4qJlsu6tzCWOBrmYOEK5ts9/RyynyfU2AgmNj4m60eu
         v+9Q==
X-Gm-Message-State: AOJu0YxU94qev3eVRLBvvv+CPYmv8o7UbeKQ+IM0kpj6FolkSOAymq87
        Nx7vhm/PHdER3xKJ0aiA+Vbbf9UFD77BOg7B0hs=
X-Google-Smtp-Source: AGHT+IFKaJPxsoTCICP8q5NW0HXCrokbDTSZi1sivBUDzHTLTjaPbIBdZjRFUlSi10h3ecjYVbW0x0zBv7eFOaAzOUs=
X-Received: by 2002:a05:6102:378:b0:462:71ee:5ef6 with SMTP id
 f24-20020a056102037800b0046271ee5ef6mr4561942vsa.17.1700555411054; Tue, 21
 Nov 2023 00:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20231120091214.150502-1-sxwjean@me.com> <20231120091214.150502-2-sxwjean@me.com>
In-Reply-To: <20231120091214.150502-2-sxwjean@me.com>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Tue, 21 Nov 2023 17:30:00 +0900
Message-ID: <CAB=+i9SYr8vMVzRhj2zpK3zX8Qj2pf8yrvVC0_g=cqbOa8n0uA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Documentation: kernel-parameters: remove slab_max_order
To:     sxwjean@me.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 6:12=E2=80=AFPM <sxwjean@me.com> wrote:
>
> From: Xiongwei Song <xiongwei.song@windriver.com>
>
> Since slab allocator has already been removed. There is no users about
> it, so remove it.
>
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 65731b060e3f..c7709a11f8ce 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5887,12 +5887,6 @@
>                         own.
>                         For more information see Documentation/mm/slub.rs=
t.
>
> -       slab_max_order=3D [MM, SLAB]
> -                       Determines the maximum allowed order for slabs.
> -                       A high setting may cause OOMs due to memory
> -                       fragmentation.  Defaults to 1 for systems with
> -                       more than 32MB of RAM, 0 otherwise.
> -

Good catch!

By the way I think noaliencache can be removed too in this patch together:
>        noaliencache    [MM, NUMA, SLAB] Disables the allocation of alien
>                       caches in the slab allocator.  Saves per-node memor=
y,
>                      but will impact performance.

Thanks,
Hyeonggon
