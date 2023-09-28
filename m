Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D957B11B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjI1Esz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1Esw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:48:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8AB136
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:48:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-532784c8770so15437383a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695876525; x=1696481325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heHPGL1VWDNNf6XFxEEfiRz4HN3qiwrjyD3dIT3TT3Y=;
        b=iFtUSMQ2WG+o3eku0DMh8DgE/Lz1f2VH6+eYClR1+G8JlIHRsTFy84+FWsSdyZxq21
         8fL4JATtWSDiuj9CnY1bYHTy++1A6GWWFmsoGOheEGiQst3VVIPGcD1C40Wljbcu6qSE
         XaXvL55UpA3b/JOh7C305laFdjoJnz3TpRU0lJ+jAUBzbDf0bLapd9z4Bhyokn21YZRU
         9B6wfV55CiHS8oxLsRv6FjDi+PeD83EqF/7yvZrGQNvcv1nllpA2UnD8Vt71Ffls44wI
         ogqyU2GIDRKtW3WNPPy8z8NIOZgYVx1R0CjLfkDIzEESSCCd6ii9LZZeomD5gbjwUk30
         Wz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695876525; x=1696481325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heHPGL1VWDNNf6XFxEEfiRz4HN3qiwrjyD3dIT3TT3Y=;
        b=eNZIRACCZgBAOnwrmmP7bRVAuilxdv9l3WSgrfwpEqJXtfyH8vHnYgyEaJBo/36F+j
         tD+xxKgakQRqjgq1O89Wdy+o+gVHkSLg4ALetnTBXgRia6Wi2uYIZTTUgfBveE83PACU
         5ttfCijwhaKZGXt0Ny8D8ER1twqXinkeCZt1cTbwnIHM1sVbBJS1Y69RRvtSB0iuO5hn
         201o/12LjTeZ3Cq9F7g8vLDjijqq7A4a5nRXqbavGEZ0cIYxwYTUGMtNuXaUtVHU/paC
         LVwdcrh3RsrcbUjtzlQpOKJVjt3PttRiv103aoFBG1U09GZzdPhdaGeFIwPfCX4dl8ad
         EZHA==
X-Gm-Message-State: AOJu0YzmxuUwAAekObQo2DabbPvJyvVRk/NyZ/ARn1dSfpnO34u2ozX3
        qKIjZ2RF86vE9XW0Jy6C4MUh3Q/DHYBXzgWUpTO0/Q==
X-Google-Smtp-Source: AGHT+IGiiFxnaM49SGb+63NiClG0YLueyxu9CNO9+fTK7ufBWNBl6F+BFa5pFCOChXf1fAyEMh5KUhanvrUUAun0FOY=
X-Received: by 2002:a17:906:8a77:b0:9ae:5848:3f8e with SMTP id
 hy23-20020a1709068a7700b009ae58483f8emr150816ejc.49.1695876525470; Wed, 27
 Sep 2023 21:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175319.work.096-kees@kernel.org>
In-Reply-To: <20230922175319.work.096-kees@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 28 Sep 2023 13:48:34 +0900
Message-ID: <CAFhGd8qdBmqwxAWsxDmmRYweOTRK33nFXWdM_QpqHtv6=bOcOQ@mail.gmail.com>
Subject: Re: [PATCH] cxl/acpi: Annotate struct cxl_cxims_data with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
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

On Sat, Sep 23, 2023 at 2:53=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct cxl_cxims_data.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good.

The reordering of the count assignment is crucial here otherwise
the runtime checks will trip when `cximsd->xormaps` is used as
memcpy destination.

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  drivers/cxl/acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index d1c559879dcc..40d055560e52 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -14,7 +14,7 @@
>
>  struct cxl_cxims_data {
>         int nr_maps;
> -       u64 xormaps[];
> +       u64 xormaps[] __counted_by(nr_maps);
>  };
>
>  /*
> @@ -112,9 +112,9 @@ static int cxl_parse_cxims(union acpi_subtable_header=
s *header, void *arg,
>                               GFP_KERNEL);
>         if (!cximsd)
>                 return -ENOMEM;
> +       cximsd->nr_maps =3D nr_maps;
>         memcpy(cximsd->xormaps, cxims->xormap_list,
>                nr_maps * sizeof(*cximsd->xormaps));
> -       cximsd->nr_maps =3D nr_maps;
>         cxlrd->platform_data =3D cximsd;
>
>         return 0;
> --
> 2.34.1
>
>
