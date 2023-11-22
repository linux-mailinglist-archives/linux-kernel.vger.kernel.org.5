Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434F87F5138
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjKVUIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVUIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:08:21 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077671B6;
        Wed, 22 Nov 2023 12:08:18 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50aab3bf71fso125891e87.3;
        Wed, 22 Nov 2023 12:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700683696; x=1701288496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8AYC5b9thtMS85qgD6tw6luscvzIXZBbdfYYJ8NDCg=;
        b=j0lr5iMML+ZfzIlKvFagrkAyPIMBcl6MP92HjUquiBC9xWHZv5hLcfKsfkqoJeQs7l
         iI5FgwlLorr5KwvtV8s2EXEB2QKjNnVqhFhgRSbyGm1Erv2FFZzwi0Oi65vmwdXUs9xU
         55JHAUzTaO8CQ26jUA3dKanSzVt9j0RbqtfHhROzomxEmoi8i3rTG+FC3E2qPKb7BnW6
         bzSRBTSiU6weisHhxGY1p8AEGog7A4ts9xLEYd7rKt/Gs5+80SszhI+wi0YE+bHH8oPV
         9ysuvD6dmrpd6jKFqjeId3Ue4SU7XVcoONyUSIYMwJ7cMknvOfqqywsffnmA+30DJbd5
         ikGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700683696; x=1701288496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8AYC5b9thtMS85qgD6tw6luscvzIXZBbdfYYJ8NDCg=;
        b=QM7XFbtBkvYQUNwgG6jXMUpoWbIz6B4cK7TJmTar4NjnXGkIf5OxKTtkFKTs7xWzNy
         20DHAiHlMWlz1DjXcPHKe8i1Zy3urACyeN5tSRgqJDKKf5YIU83k4xVf4aYoeITBLi+A
         BFGW5yHKp6bctx69kqcTpDc/cnzJqrH6IMPprW9k3qNsfUyoqfxAjK+rdaOG2rokAb+y
         bdPukuwurUg+RMPHqP5Pu7SZP+WXMV8HLYkvd/ihv51jK/40AYpEgN04fQElGZxNHUq5
         0eKz0NjKsEdMJjFZM/jayglW5txwu3NQ4977bAj35gRTImgU9UewpC1oL03WStPa57bJ
         suRg==
X-Gm-Message-State: AOJu0YzQ3yQ1LUJN57YXKFNxZuLGbhBQpta8oSwHZoZT3zZo0OHDPHWb
        OxKpGGgR4CN6hL2vSJbNCxZFYytTiQ7Bdb0jyYw=
X-Google-Smtp-Source: AGHT+IHeOS+BuzcW69z2sOufuTCIe9lZXesx/pE1nfP+T+0BS6Ue+nm/AB56N3vDCdXJGvNkWhfr3dUprALYEYSo3aE=
X-Received: by 2002:a05:6512:3fc:b0:50a:6793:6954 with SMTP id
 n28-20020a05651203fc00b0050a67936954mr2037700lfq.9.1700683696006; Wed, 22 Nov
 2023 12:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20231122153340.852434-1-sashal@kernel.org> <20231122153340.852434-10-sashal@kernel.org>
In-Reply-To: <20231122153340.852434-10-sashal@kernel.org>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 22 Nov 2023 21:08:04 +0100
Message-ID: <CAKXUXMyzvx_9Vn0orKWTMFP1iMxY050EV+WT3hWLaKcGRAtkBQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.5 10/15] linux/export: clean up the IA-64
 KSYM_FUNC macro
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>, deller@gmx.de,
        ndesaulniers@google.com
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

On Wed, Nov 22, 2023 at 4:34=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>
> [ Upstream commit 9e0be3f50c0e8517d0238b62409c20bcb8cd8785 ]
>
> With commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture"),
> there is no need to keep the IA-64 definition of the KSYM_FUNC macro.
>
> Clean up the IA-64 definition of the KSYM_FUNC macro.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Same as I wrote for v6.6 applies to v6.5:

I am a bit surprised that this is picked up for v6.5. This commit only
makes sense after IA-64 architecture is removed and I do not think we
want to backport that change to v6.5. So, this change here should not
be backported as well.

Lukas


>  include/linux/export-internal.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/include/linux/export-internal.h b/include/linux/export-inter=
nal.h
> index 45fca09b23194..69501e0ec239f 100644
> --- a/include/linux/export-internal.h
> +++ b/include/linux/export-internal.h
> @@ -50,9 +50,7 @@
>             "   .previous"                                              "=
\n"    \
>         )
>
> -#ifdef CONFIG_IA64
> -#define KSYM_FUNC(name)                @fptr(name)
> -#elif defined(CONFIG_PARISC) && defined(CONFIG_64BIT)
> +#if defined(CONFIG_PARISC) && defined(CONFIG_64BIT)
>  #define KSYM_FUNC(name)                P%name
>  #else
>  #define KSYM_FUNC(name)                name
> --
> 2.42.0
>
