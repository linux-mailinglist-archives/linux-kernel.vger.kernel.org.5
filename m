Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9123E7868DB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbjHXHom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240394AbjHXHoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:44:21 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D16D10F4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:44:20 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44d3666c6cfso2204716137.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692863059; x=1693467859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vbnvrj8jD+jFxmIgPUBsLHTIdjYzkW13qtC1PHUVzMg=;
        b=2AtQmNlP4CjrQ7nLLUuHBL1+iBuxJeioF0wgb5a9oAa0e8E28lxZtsK8MjpJLeEr7v
         VISToIgd/eBP1Uu1YCDkVLYew4KLJNY4bHK53IIOZRMFEUMLSiaJSUdABxiuPvQObGCy
         cecF0IVVdyINhyKYis+bldc/fhIhcPIfSfpT8T0nWIOtVaw+yfqMucGm2zbrofhJBdu0
         hLa/CVaeF0FgCEk1XICpyM3F9kMAVW0Q/cGkrdkcsXXuVd+bBSIHEj23Em5Zs6lrbV+c
         gQ5eWCs2beCeA+IwHuArgBllx/nImQ2CwbyA44Bbe6r0Z6yy1+qHtM4W75HpRiQa85dP
         s7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692863059; x=1693467859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vbnvrj8jD+jFxmIgPUBsLHTIdjYzkW13qtC1PHUVzMg=;
        b=MHVTt2OWPMTHy10h4odtdB0p3ZgYhj815yJnRqiEPLsvHbNDMAeutPXAfUse52S6wL
         E/WaMPNvRg4DEftIZVg9mAs5qCIp9onTnG73rCUKUOGdnsxlkpTkwVSkTlEN4yslZ06L
         Mx5u1bm2HMmTpwPemi07UcHuI7NwDYVKq9Y8W/JpBjznTgSLQg0k2bKr1CZrBRzBafOx
         jP+bbe97XZOXoqscwDYiIeRdZwOfEQbizDogsV0/NXULtrhOtgpKiG2sZy/J18tx/FDa
         k7rm7gHjhVeytiiRR8P6rjb1AbRr69JzCrqLu4GwSSXnmrGsEcKrKjRaE1ik7PdZc42/
         QULg==
X-Gm-Message-State: AOJu0Yw9tzuuVtp4TbDDRAHJ++2GUqKUzV3knOW95yFWT/VLc3fryCrX
        fBD/fswg+mrhOC2UKr2T98IkNiZXGgvuNztfQWDiEg==
X-Google-Smtp-Source: AGHT+IGpAXZI8kTnpgAkhlHjfliupu+y8oncXlWQ/jH2NUqV8pLRu+hFNCwO3b6YH6Gl0Xbqg6CM///rSyrVY4WAP6U=
X-Received: by 2002:a05:6102:1cf:b0:44d:50f0:f43e with SMTP id
 s15-20020a05610201cf00b0044d50f0f43emr9500732vsq.30.1692863059115; Thu, 24
 Aug 2023 00:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230823165637.2466480-1-robh@kernel.org>
In-Reply-To: <20230823165637.2466480-1-robh@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 24 Aug 2023 09:44:08 +0200
Message-ID: <CAMRc=Mc5RaCWBs1DKPLbbgHdZ+xr+9WaCu50j4OavtVeaq5fXw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: davinci: Drop unused includes
To:     Rob Herring <robh@kernel.org>
Cc:     soc@kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 6:57=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> of_platform.h include is not needed, so drop it. It implicitly includes
> of.h (for now) which is needed.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Arnd, Here's one more that slipped thru the cracks. Please take
> directly.
>
> v2: Fix subject to be 'davinci' not 'keystone'
> ---
>  arch/arm/mach-davinci/pdata-quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci=
/pdata-quirks.c
> index b8b5f1a5e092..b5b5c7bda61e 100644
> --- a/arch/arm/mach-davinci/pdata-quirks.c
> +++ b/arch/arm/mach-davinci/pdata-quirks.c
> @@ -5,7 +5,7 @@
>   * Copyright (C) 2016 BayLibre, Inc
>   */
>  #include <linux/kernel.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
>
>  #include <media/i2c/tvp514x.h>
>  #include <media/i2c/adv7343.h>
> --
> 2.40.1
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
