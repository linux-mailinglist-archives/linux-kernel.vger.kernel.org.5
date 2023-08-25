Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6B78917A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjHYWNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjHYWMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:12:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CC22137
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:12:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso1704222e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693001570; x=1693606370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkDyGFLOPkor6CsSqEx1av4BTza+8feNyKNHk0yvR74=;
        b=pO2A3xQ1p8QFqLOQ0bEKirF5S5oukYeUe2XGdbYZ6OYDoM/sGVEVJMGZUPCYO8E3wY
         CbVG26ghtYSa48fA70Zk/DaiAWgdqADDyEiSZ5KFABWLlYJVivaWxhTW3bm9AJ1LcUlm
         BrdPbWrS/tlfrjCtdHz5US/69yvF4rs5e5+MA7HgZQUcxWg9qIybpMxbwAToyKGlOkEA
         2uS5kOWXuVGOZ1NeLjTXeOhTaTbl7szklIOnHr2WI5FmCVY3W2sYYrU92ak7bBoWD8U/
         lYFO6K8We2XMAeF51MOGiXayhC77U97OCmNIcil4BGmUND0py5ta3JbutTOYRXeGLdw0
         F7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693001570; x=1693606370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkDyGFLOPkor6CsSqEx1av4BTza+8feNyKNHk0yvR74=;
        b=PrkjWzRvRutNx9lAE/Y11aPf5POveQk1d+ADrzNEGnldzR0kEsji5qkkSelfeUxCsd
         qlY0JUtu6OFfgU4RaCcpXT4fPrMOcTGiSnHvzIYTdqqnEROUsSYeGbZ/lcISmtk0tm2P
         xw4ouXLrumgHsqzgHvCV9LkcEx95cBhOTaehLB0qkXuSPVEljAxtSqquU54Zn9W5puDB
         bn3sGqMqqhLGMsLIHoeQQAiQrLOefEwIZYRszCPYfJ2+L9n0ore7+DrJFfLuaLbVPccV
         U/ZQgdxMgx5WaSI5Az5yzpisESc0HoskO69XgZWXxO8DtZ0UjqpM6/SvX8M+iilo1Ddz
         ybnQ==
X-Gm-Message-State: AOJu0YzioLfuo+26VjpTQfIoAO5tVulzVK4Ln3mA7OGAF2uHUXOd9+68
        WDBJJpiWJ4R+hRq9FHarni291BWYd+5TvRb6H5Woeg==
X-Google-Smtp-Source: AGHT+IEn2JzE6UCZ8KIXqUJv+vx7r5gB/pBzvkXtK/pE4WNVUOx5eUKdVpuE9DHm9KftwRSaJ0dXd/SmBDpcBsaSXXo=
X-Received: by 2002:a05:6512:31c8:b0:4fe:8f66:28a3 with SMTP id
 j8-20020a05651231c800b004fe8f6628a3mr15305230lfe.0.1693001569644; Fri, 25 Aug
 2023 15:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230824-strncpy-drivers-accel-habanalabs-gaudi2-gaudi2-c-v1-1-1a37b65576b4@google.com>
In-Reply-To: <20230824-strncpy-drivers-accel-habanalabs-gaudi2-gaudi2-c-v1-1-1a37b65576b4@google.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Fri, 25 Aug 2023 15:12:38 -0700
Message-ID: <CAFhGd8pzgNDYwBSpnvLzWTVeN=0TTCARPAyCN46jF=86F1NM8w@mail.gmail.com>
Subject: Re: [PATCH] habanalabs/gaudi2: refactor deprecated strncpy
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch as well as two other related patches were combined into a
single patch [1]

On Thu, Aug 24, 2023 at 1:45=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> `strncpy` is deprecated for use on NUL-terminated destination strings [1]=
.
>
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
>
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-n=
ul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/accel/habanalabs/gaudi2/gaudi2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/hab=
analabs/gaudi2/gaudi2.c
> index 20c4583f12b0..755b2d92357d 100644
> --- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
> +++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
> @@ -2431,7 +2431,7 @@ static int gaudi2_set_fixed_properties(struct hl_de=
vice *hdev)
>         prop->pcie_dbi_base_address =3D CFG_BASE + mmPCIE_DBI_BASE;
>         prop->pcie_aux_dbi_reg_addr =3D CFG_BASE + mmPCIE_AUX_DBI;
>
> -       strncpy(prop->cpucp_info.card_name, GAUDI2_DEFAULT_CARD_NAME, CAR=
D_NAME_MAX_LEN);
> +       strscpy(prop->cpucp_info.card_name, GAUDI2_DEFAULT_CARD_NAME, CAR=
D_NAME_MAX_LEN);
>
>         prop->mme_master_slave_mode =3D 1;
>
> @@ -2884,7 +2884,7 @@ static int gaudi2_cpucp_info_get(struct hl_device *=
hdev)
>         }
>
>         if (!strlen(prop->cpucp_info.card_name))
> -               strncpy(prop->cpucp_info.card_name, GAUDI2_DEFAULT_CARD_N=
AME, CARD_NAME_MAX_LEN);
> +               strscpy(prop->cpucp_info.card_name, GAUDI2_DEFAULT_CARD_N=
AME, CARD_NAME_MAX_LEN);
>
>         /* Overwrite binning masks with the actual binning values from F/=
W */
>         hdev->dram_binning =3D prop->cpucp_info.dram_binning_mask;
>
> ---
> base-commit: f9604036a3fb6149badf346994b46b03f9292db7
> change-id: 20230824-strncpy-drivers-accel-habanalabs-gaudi2-gaudi2-c-0b3f=
717bee12
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>

[1]: https://lore.kernel.org/r/20230825-strncpy-habanalabs-combined-v1-1-da=
a05a89b7e3@google.com
