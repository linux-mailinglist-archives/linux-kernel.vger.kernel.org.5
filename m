Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045F67687B1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjG3Tvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjG3Tvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:51:41 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9882110D8;
        Sun, 30 Jul 2023 12:51:40 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a3e1152c23so2823789b6e.2;
        Sun, 30 Jul 2023 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690746700; x=1691351500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHvT5rWiwN9JTOjUQCWvnN3rxvp307NJiZOh7jWcA4Q=;
        b=hv1EQSmiZSBWHUOsFQk4+Autq+erFQR2PHw5EFtMoUQRuqmrSUDD7gXyEAz7J+GN20
         yYa4JWy/C+u2aQZFygd1id/icETI4mCyC5ZEZOFD6AWnJKasGyxl7un9kQoRVgCO4qN5
         ihbC3OaLt6mIBjzB2jLyxCjShYiJT4EcUQKdKnemkL4JCN0fVqIpvIezneAkcwVEUpmm
         vaeWfzLUL8b6C0Vq1Q3b/zxG8/rqNJpCMZoVyKWu7taM/2ys8PQy0ld2DhP6ASjC9q5D
         h9AWe5oDvb7H0TjZKlZewLiBGHxktVXKGUfY+3Iu1O6FzHz5UR9gALtoorzzTH7iY6BS
         IZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690746700; x=1691351500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHvT5rWiwN9JTOjUQCWvnN3rxvp307NJiZOh7jWcA4Q=;
        b=N/Npy97IGHPfcAdD+u+rTrOGBBnquffKYxgGeLJvXsf1dEujo7ph3evO/ZITzDVgpH
         4OiYIYS1I6kZWDn9MTJVVKwa6NUX2OdIxrYf89z/Ni0kytCMIHEOVtQK05wUXFCWJkHo
         yo3xh3oyvXLg8KMGtJ/EjM7TLbvkjuu0Se26w4eypFcW2XUV/LujnaHGnmuZD24S8zZJ
         tTockHyViT539GhRssfjvCevdyZ/ldbTviTxlLDIVo8xs19LRXvDAIkVvvkBXgrw8R+F
         ivnconGirB3qFjP72iwvYXbYsxgImaoTwGfp1sjAFntcqTM8M3n97EVzRjAdKO2Gtg6g
         m1pA==
X-Gm-Message-State: ABy/qLZIM7DJD13RMZmA8P6uy/6z+dDgiJbCqgp28bOwxhYmup+rc8HF
        iDh0TyYhDAJQAJt3XwTH6Os5DEQb2ZinpOxavZN8t/hfbW4=
X-Google-Smtp-Source: APBJJlFZTTEVkc+7XrD3sDqzaG9rme7HMsQS7kVJ6nvYgTut5GE5waKnXSC6MctlwoofLhnoVYLIBoEr3peQ7EIiKvI=
X-Received: by 2002:aca:1318:0:b0:3a3:7977:8995 with SMTP id
 e24-20020aca1318000000b003a379778995mr7982881oii.47.1690746699823; Sun, 30
 Jul 2023 12:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230728182009.18445-1-aboutphysycs@gmail.com>
In-Reply-To: <20230728182009.18445-1-aboutphysycs@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Jul 2023 22:51:03 +0300
Message-ID: <CAHp75VePhbnM_yo1cWPQ3dFvSRKr+Br9eWs+6QSh3DuPWcUVPQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: rc5t583: remove unneeded call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Alexandru Ardelean <alex@shruggie.ro>
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

On Fri, Jul 28, 2023 at 9:20=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
com> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
