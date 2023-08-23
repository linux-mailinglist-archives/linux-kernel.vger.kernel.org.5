Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBD77856BC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjHWLcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjHWLcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:32:13 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4FEE5A;
        Wed, 23 Aug 2023 04:32:11 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5711f6dff8cso140523eaf.3;
        Wed, 23 Aug 2023 04:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692790331; x=1693395131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BESIYsoydvZiBIe9fSP1rmQvOVRq1L1S9N0ieUFEhq4=;
        b=ss8a1Oo9Rij/yq7kt5hv/6q+mnEJZqhsFQ9PzskBglvzR2EIZWu6VaaOTSifB63qmi
         hVh+7EfC40vYUQDm2K2gpmQo7tbBikyQVBg7rhLj5tls9u3XZNrI9yFbpY4b5bdDun41
         2mc7qH10Vb+ft+s20M9+Cwab/HDJVIPrXcGbwvI4tZyXvkjBdeNB4UN9hjNyhYOfURyK
         /Snk/ju45H0jdegNGD9uMfFyxzvXXZXi8E1d4lJ4ZrwCgEy/PpY/KQ1KMkd+tdlPS/H/
         iAGihiowcxoA9YH+ynxA4bCrLXm0xD/rAXhIktro7jPge3CeSxm+nn6dz/8vVBaMMoIg
         Ikxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692790331; x=1693395131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BESIYsoydvZiBIe9fSP1rmQvOVRq1L1S9N0ieUFEhq4=;
        b=iT+jrbef0VR2G6RrEl80cV9yw0NwEe9FNAo1ZnQY6SHar/uOrHmEkCgAp7X+bWcQ2C
         QSOa0jUV1NXiM8cvai9qJV4FyzS6VBBTPeF2/QY55/xrudnc6k+ARUhNrjgXVNQTD6ZH
         V7RpRq1FsYblO8CIrkgoQ9EROvxO+7gfwCLgC/sFNwSPK3DDo40vUsibiPTk6pQOWNVT
         D7yYMKmK5DPF0wNhYwEbXSV9+mrQwoC87JCnbJnJTzJ13Nh5EAeq9Gyl466fdefrBb/d
         sw3amYL7f8MLEPtgRSLl6mDi68k5uHyO5NRFzkniNN2dGTg9c6Bn2VrWkeVIURXa/yCs
         L1gg==
X-Gm-Message-State: AOJu0YyjNvGX8yZjHYeXR4pWN4vrp71LUzOCSxUPhBlkI01Cc2UOimaR
        S9nJd8Utf2ere8Xq1FN8E4oi0399X+v75tSdViPpZqGrSLpGLg==
X-Google-Smtp-Source: AGHT+IG6rFbjqA4R3FXmRn0GW7RP1j0BHun38i1fbHL1hrlaMoXT9zLIqp0TAUthZYck+p+HjViAPpJpMYhW8mdpUrE=
X-Received: by 2002:a4a:275b:0:b0:56c:e856:8b2c with SMTP id
 w27-20020a4a275b000000b0056ce8568b2cmr10832032oow.9.1692790330668; Wed, 23
 Aug 2023 04:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230823085258.113701-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823085258.113701-1-krzysztof.kozlowski@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 23 Aug 2023 14:31:34 +0300
Message-ID: <CAHp75VdSaZTT8a-QFmiqPLYH-nK6ycZzV10CFFdv_LS3BVG_5w@mail.gmail.com>
Subject: Re: [PATCH] gpio: mlxbf3: use capital "OR" for multiple licenses in SPDX
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
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

On Wed, Aug 23, 2023 at 11:53=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
