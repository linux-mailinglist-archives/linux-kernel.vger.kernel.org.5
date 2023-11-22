Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB997F512F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344491AbjKVUHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbjKVUHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:07:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AC51B9;
        Wed, 22 Nov 2023 12:07:09 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a00cbb83c80so20364466b.0;
        Wed, 22 Nov 2023 12:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700683626; x=1701288426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+L61SKuaqdPJ0pWGJ+zDllcaQ6DEfFaFPXxIkSYtNiQ=;
        b=QhyE6oSjlQ57Rl43QucuzGfb4m/Q/eL79VXSvVv40/ALWBtpAnHkyv8R4FW9XkTRsv
         Hgy3VEh0jnF1noKmg/956DJvc0/00U2i80lewSsQ5LKJNZASomBvjsBbYoPUOB6fufHx
         H1Ai/Ap0xhF++gyo2J2FC9X8YVdxtSHiHbC4kaltk+LPoyg7GzxhrXW7O95CfMIKa6Dk
         U6O61TlqLRMYOT7Enqy/XfLDJbAnAp8HPO4Dp1vqtw5Bi9kK8zaOxk1/LupNw+J7SxIR
         pOHBJuBVnVlIIz31IYKTX+kJamBglqmiVIb7nBCbDGi1ysxGz1pQJVr6q+iMB+b/JIrc
         MHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700683626; x=1701288426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+L61SKuaqdPJ0pWGJ+zDllcaQ6DEfFaFPXxIkSYtNiQ=;
        b=WEgxn1JHZJL+nrTVTAYuA2e01p/w6M75m2nHzk7NTMR7fzVIKM6j3hNlSdMLbdZ5q1
         ev0ux01Gbc8E6CF5SIeWbv4m8g1h8oJVxB2d+/7HlGMBPX7Y2+CRof0I8b9n7armq53Y
         4ebmGEKgHNvHJTyJRgFV6J4etiXugDyu2J+JC5OW6Oczfkp7k9HfO5f5YGGMFReEzaKl
         CWDImGQoeNIS7xvlN9NpZJyhqkbrtWC+R/zfRODljibbx0unlhESSSMWWbKCQ6siXzCX
         Pf9lPc2Vc09baKyTx6zR28lKYl6bNR73UcT7/4DJe3d8GHz10t8JvEruD/S2IsK0ty8K
         QUug==
X-Gm-Message-State: AOJu0YxRYmwHim0W/B4vY23lQYIz6qyhb5zH+hEUSPs1eJTCYJR4wuwu
        7fsyx45SiOKUkcaDzYvfCzZR71Nf94bzE9WeQk8=
X-Google-Smtp-Source: AGHT+IEH461L+MOzwH1bI62kSWPMlLrms+mgJrNtM9dVtt6dBKiT4eWKM/iPdNgdqvSic24FnKIs5t1RipucM1sLvyQ=
X-Received: by 2002:a17:906:308a:b0:9fe:5d39:41c6 with SMTP id
 10-20020a170906308a00b009fe5d3941c6mr2441746ejv.51.1700683625887; Wed, 22 Nov
 2023 12:07:05 -0800 (PST)
MIME-Version: 1.0
References: <20231122153212.852040-1-sashal@kernel.org> <20231122153212.852040-12-sashal@kernel.org>
In-Reply-To: <20231122153212.852040-12-sashal@kernel.org>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 22 Nov 2023 21:06:54 +0100
Message-ID: <CAKXUXMxiRL-ay9eMz4AZNORbO-mhyZECGE2SDg0rTB7wZdHSRA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 12/17] linux/export: clean up the IA-64
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 4:32=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
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

I am a bit surprised that this is picked up for v6.6. This commit only
makes sense after IA-64 architecture is removed and I do not think we
want to backport that change to v6.6. So, this change here should not
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
