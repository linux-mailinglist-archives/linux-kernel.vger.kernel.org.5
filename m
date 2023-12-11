Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136A280D3F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344729AbjLKRfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344736AbjLKRfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:35:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E41FF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:35:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FAEC43391;
        Mon, 11 Dec 2023 17:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702316123;
        bh=OA6WY7PsIMKHNNWqKQfhrU0poMqRlsR4oyu4mqLEexM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dOTw12+eR3BKCNSiPZQ9ha2kc68XifXzVT9xAhzQwy5JF280nD9J5sJYk1nLeGkOV
         OChwBQYlIJO0zOhksiKDKX/GQsQin7KgmX0Naq6chv1PJqnoeJw8/d8DYIGhVkUz4z
         b7SikoU8ug14YAo+zmxQW5kstU4uB+ZLulfejueQ5Is7/yEE9lF47EkYIwEqqLv3ym
         REWCcX02EsIPpmU91VtnhwZyM2sWRi+Sd7DKnsT1vmJ4x94nXjf7yb2NAgyD87ugwZ
         vKty4UZK+bMZQ905n2RaOGD9p1hnTm+6yXT8rlGK6iF6/N8sQsz8fekdnpluYL6kX0
         4WFyWx5mDYbvA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50bf4f97752so6052767e87.1;
        Mon, 11 Dec 2023 09:35:23 -0800 (PST)
X-Gm-Message-State: AOJu0Ywlc47JGaKR7m2B/IsSIerfZmCjycgYPOWRFYaI3lRJrXo4HJcA
        iHTS2M4YNEQh0simwrpdU4YJduwo00DgyiVBUw==
X-Google-Smtp-Source: AGHT+IF8mAabQNOevm2mF4ft0Ec2oy4GE7m1ImyfsN8vFMUx+mMAI4J3ZK9luzO+/ENyGmdvmphfs+ANkWm1Aq41l8U=
X-Received: by 2002:a05:6512:ea3:b0:50b:f1e9:c478 with SMTP id
 bi35-20020a0565120ea300b0050bf1e9c478mr3017354lfb.75.1702316121789; Mon, 11
 Dec 2023 09:35:21 -0800 (PST)
MIME-Version: 1.0
References: <20231211074120.27958-1-xinhu.wu@unisoc.com> <20231211074120.27958-2-xinhu.wu@unisoc.com>
In-Reply-To: <20231211074120.27958-2-xinhu.wu@unisoc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 Dec 2023 11:35:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLHpEwFucp+i2EDZ7Th3CDe85=nF14S58vO1uqUmo7JRQ@mail.gmail.com>
Message-ID: <CAL_JsqLHpEwFucp+i2EDZ7Th3CDe85=nF14S58vO1uqUmo7JRQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] usb: typec: Support sprd_pmic_typec driver
To:     Xinhu Wu <xinhu.wu@unisoc.com>
Cc:     gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        xinhuwu.unisoc@gmail.com, zhiyong.liu@unisoc.com,
        peak.yang@unisoc.com, teng.zhang1@unisoc.com,
        bruce.chen@unisoc.com, surong.pang@unisoc.com,
        xingxing.luo@unisoc.com
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

On Mon, Dec 11, 2023 at 1:42=E2=80=AFAM Xinhu Wu <xinhu.wu@unisoc.com> wrot=
e:
>
> Add Unisoc PMIC typec driver.The Unisoc PMIC typec driver handles the
> role and orientation detection, and notifies client drivers using
> extcon mechanism.
>
> Signed-off-by: Xinhu Wu <xinhu.wu@unisoc.com>
> ---
>  drivers/usb/typec/Kconfig           |  11 +
>  drivers/usb/typec/Makefile          |   1 +
>  drivers/usb/typec/sprd_pmic_typec.c | 587 ++++++++++++++++++++++++++++
>  3 files changed, 599 insertions(+)
>  create mode 100644 drivers/usb/typec/sprd_pmic_typec.c
>
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> index 2f80c2792dbd..47b4468315aa 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -110,6 +110,17 @@ config TYPEC_WUSB3801
>           If you choose to build this driver as a dynamically linked modu=
le, the
>           module will be called wusb3801.ko.
>
> +config TYPEC_SPRD_PMIC
> +       tristate "SPRD Serials PMICs Typec Controller"
> +       help
> +         Say Y or M here if your system has a SPRD PMIC Type-C port cont=
roller.
> +
> +         If you choose to build this driver as a dynamically linked modu=
le, the
> +         module will be called sprd_pmic_typec.ko.
> +         SPRD_PMIC_TYPEC notify usb, phy, charger, and analog audio to p=
roceed
> +         with work
> +
> +
>  source "drivers/usb/typec/mux/Kconfig"
>
>  source "drivers/usb/typec/altmodes/Kconfig"
> diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> index 7a368fea61bc..81818c2fa890 100644
> --- a/drivers/usb/typec/Makefile
> +++ b/drivers/usb/typec/Makefile
> @@ -11,4 +11,5 @@ obj-$(CONFIG_TYPEC_HD3SS3220) +=3D hd3ss3220.o
>  obj-$(CONFIG_TYPEC_STUSB160X)  +=3D stusb160x.o
>  obj-$(CONFIG_TYPEC_RT1719)     +=3D rt1719.o
>  obj-$(CONFIG_TYPEC_WUSB3801)   +=3D wusb3801.o
> +obj-$(CONFIG_TYPEC_SPRD_PMIC)  +=3D sprd_pmic_typec.o
>  obj-$(CONFIG_TYPEC)            +=3D mux/
> diff --git a/drivers/usb/typec/sprd_pmic_typec.c b/drivers/usb/typec/sprd=
_pmic_typec.c
> new file mode 100644
> index 000000000000..536f340d8b65
> --- /dev/null
> +++ b/drivers/usb/typec/sprd_pmic_typec.c
> @@ -0,0 +1,587 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Spreadtrum PMIC USB Type-C
> + *
> + * Copyright (C) 2023 Unisoc Inc.
> + */
> +#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

You probably don't need this header and the implicit includes it makes
are dropped now in linux-next. Please check what you actually need and
make them explicit.

Rob
