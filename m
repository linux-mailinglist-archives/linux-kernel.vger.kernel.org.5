Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B670F75B3D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjGTQH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGTQHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:07:24 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BC2CE;
        Thu, 20 Jul 2023 09:07:23 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b703cbfaf5so14514761fa.1;
        Thu, 20 Jul 2023 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689869242; x=1690474042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjpaXRyovFt4+Nz0cyo8GxXlLalmODjwxKNY5UBoRaU=;
        b=Hqt2yzKLXcKbOqavhn94wBwXqIJu3Plz2LCMyyB4bhl5kALZFcsnvseez4DpZfb62+
         hwUnc2U0o30h3YG9Dl411XKWjaDXp+jZ7CcIoFwdx8HZn/FQSUz5+oP91htgTQCMPuuJ
         PCJ5FGEcMsYdk7wHbNnfcqeo31LFlG5gXdQmTzV+Yqu/eAD9Vk4KdRhxb5O0GC2dwys6
         469u7QeZlq0OkfTc35GNCrKMx+VU+dYp7bVJutLiEmtO7HwKAS2j5Ruz47JrWPxQ+F1N
         NeX6aSGHtyVCJdl2ULhhtI3RAU7K8c85Vb1uHci+bxOSwySqIGQ5dUmFCnia34QrnDCL
         OOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689869242; x=1690474042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjpaXRyovFt4+Nz0cyo8GxXlLalmODjwxKNY5UBoRaU=;
        b=ZKCbqm2XBS/dWNpD1mclcrhx/DZthh4+1/fS/Q3X0claFOxLyEhYEKZpXIh2g3yx63
         c0rUoQ+G2qjMOkHpvykowlqoiG50P6224ma2gekB33GDCpP+HdF1fNp2mKsDOF/8INbM
         lZvRCGIftOCq5TJc9barVv6lDc9hluJs0Hqr0Yn31nRR5EaXmqERuysttX6YUKQ3pvaf
         rmdghKUv6ZuVBedKRX8g0OZ1au5jeBpDWSHyMZ7bkFpi7LnwA2f++TtbLM5mmTXYyo6a
         EDI/RiDl78A8k727wmRFqYbjKe8qv/Rj/Sc0UIQ8CVUAMB9GFqAP455UD33APN1S9CJK
         ebPQ==
X-Gm-Message-State: ABy/qLZqB2eS5IA8D3H/MUNLMNDccwZW5kZq7lAmX+0qmk6LOCNNy9sX
        chLnrYqsUnfG+Tu7xfKDS+IurQqfbvJsQJBly0s=
X-Google-Smtp-Source: APBJJlFJSrSlbDs0Awxp8kmJS9Vyn69EhNnfWr0kV7di92MBpCh0nr3qtKge//MoYES/ay3jfDxZguEkM/kQsjzJ+Vw=
X-Received: by 2002:a2e:9b5a:0:b0:2b9:4841:9652 with SMTP id
 o26-20020a2e9b5a000000b002b948419652mr2582916ljj.25.1689869241505; Thu, 20
 Jul 2023 09:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230720132535.23413-1-aboutphysycs@gmail.com>
In-Reply-To: <20230720132535.23413-1-aboutphysycs@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Jul 2023 19:06:44 +0300
Message-ID: <CAHp75VeDGa9eKJv+4F13LRLhCutTWOhQcU66CnDaeTLCsSbP8A@mail.gmail.com>
Subject: Re: [PATCH] gpio : max77620: remove unneeded platform_set_drvdata() call
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

On Thu, Jul 20, 2023 at 4:26=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
com> wrote:
>
> This function call is not required because no counterpart
> platform_get_drvdata() call is present to leverage the private data of
> the driver.
> Since the private data is confined to this driver file, external access
> is not feasible.
> The use of this function appears redundant in the current context of the
> driver's implementation.

Use full room of the lines, no need to start each sentence at a new line.

Also, fix the Subject.
It should be prefixed with "gpio: DRIVER: ", where DRIVER is one in
question. This applies to all your last patches.

--=20
With Best Regards,
Andy Shevchenko
