Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A560A80D456
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344571AbjLKRn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbjLKRnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:43:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C38CD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:43:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4E9C433CA;
        Mon, 11 Dec 2023 17:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702316609;
        bh=XO5UnE3l9FoJonkWKncREOJcAIBzPv6VU7wsH1kOpxM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pBGWQZBu3OtoFtjr3cSc29srAxT/KHzA081G8QCNhH9Dha5xJWMwCZ//QqbRAy4Wg
         cl/vLS7ULMNtY/bVFEgE6Ub8DY8LFGN3E/CsKLqMxpIOj6NjaPMDEb1FzjswlG++hn
         6+JYb+gsKdnA/z3vNNLxwsQK+Ne+Betq0yHK1LhkMunfBMRZdyY4vTVOcqKH1DBFGL
         DrWZ640hjOioGS+/41LrmWYW4Mwo9tSJXFeQ7cKHOoVjljaSMW/2LEHy04jyMBYeJe
         w0l9OLMZ1DyrvpzoIelVA88VjbAYbzP36dTAMzH7pXwT+4YTtJh1XsJqfWSUMA7FVs
         MeLyCIyPYZkGA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2c9e9c2989dso63235771fa.0;
        Mon, 11 Dec 2023 09:43:29 -0800 (PST)
X-Gm-Message-State: AOJu0Yy2+BTDVOXBZExySzOoMvQAtmqCB/DB9ntcJDuUGcrS4GCeMW2H
        xZ9EmLxe/QeA2dJUzm25vtOMoH204msdz76Rzw==
X-Google-Smtp-Source: AGHT+IGc6D0UVRfS6W81ZqHgRyau/738i7lc5EmYgEf+WLZ/K6dTwMaHtj36ALgXX389kp1ZtWpPh9DW0XRQKLSG3HA=
X-Received: by 2002:a05:6512:b9c:b0:50c:180:2162 with SMTP id
 b28-20020a0565120b9c00b0050c01802162mr2102140lfv.99.1702316607874; Mon, 11
 Dec 2023 09:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20231205074723.3546295-1-chou.cosmo@gmail.com> <20231205074723.3546295-4-chou.cosmo@gmail.com>
In-Reply-To: <20231205074723.3546295-4-chou.cosmo@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 Dec 2023 11:43:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+xPAvQoUX=Td4QgbbL7Xhs-3hj8pQLCdOj6fDvCz0_ug@mail.gmail.com>
Message-ID: <CAL_Jsq+xPAvQoUX=Td4QgbbL7Xhs-3hj8pQLCdOj6fDvCz0_ug@mail.gmail.com>
Subject: Re: [PATCH 3/3] hwmon: Add driver for Astera Labs PT516XX retimer
To:     Cosmo Chou <chou.cosmo@gmail.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, heiko@sntech.de, jernej.skrabec@gmail.com,
        macromorgan@hotmail.com, linus.walleij@linaro.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        cosmo.chou@quantatw.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 1:49=E2=80=AFAM Cosmo Chou <chou.cosmo@gmail.com> wr=
ote:
>
> This driver implements support for temperature monitoring of Astera Labs
> PT5161L series PCIe retimer chips.
>
> This driver implementation originates from the CSDK available at
> Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/=
retimer-v2.14
> The communication protocol utilized is based on the I2C/SMBus standard.
>
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> ---
>  Documentation/hwmon/index.rst   |   1 +
>  Documentation/hwmon/pt516xx.rst |  48 +++
>  MAINTAINERS                     |   8 +
>  drivers/hwmon/Kconfig           |  10 +
>  drivers/hwmon/Makefile          |   1 +
>  drivers/hwmon/pt516xx.c         | 648 ++++++++++++++++++++++++++++++++
>  6 files changed, 716 insertions(+)
>  create mode 100644 Documentation/hwmon/pt516xx.rst
>  create mode 100644 drivers/hwmon/pt516xx.c

> diff --git a/drivers/hwmon/pt516xx.c b/drivers/hwmon/pt516xx.c
> new file mode 100644
> index 000000000000..824798559fe1
> --- /dev/null
> +++ b/drivers/hwmon/pt516xx.c
> @@ -0,0 +1,648 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/hwmon.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_device.h>

You probably don't need this header and the implicit includes it makes
are dropped now in linux-next. Please check what you actually need and
make them explicit.

Rob
