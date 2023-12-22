Return-Path: <linux-kernel+bounces-9942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4421781CD93
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED19B285B77
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3F128DD3;
	Fri, 22 Dec 2023 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EyUOgtLV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02D28DBB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7cc242dad2bso406277241.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703266276; x=1703871076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNBg0y+Bd68VL0xW77WB7jMSRPSja3ZQujiu0gSBfM4=;
        b=EyUOgtLVQisnCM5EAaMnDjLwyWrE7bAGR9sgsQy/yvKJVSHibwXDdRfUGmLDgDqeuD
         qIqs8DdwPGiza/x/qTb4iLU+nRARbnKfbm8vowXdhkQxDo1rjQCYjFQCroUt2UYB3vJW
         CRkTjHMWGfn1HxOlFB6XvXwNlrZWyH3NZ8i76Is/kJP4cd2rAvd8Xc6xtGpmHgPElF3u
         l1ibA7aayUrPPCC0O0q6e0nxyNBr0s8G3arEPYHIUxoOSSOfSW25yk9AoseXwtBwbQVO
         uQkrwAJcelIrhokcDc9fW0RFiVmP8+FsMSqgEacY0kAXW5+IGTFH/bhAV1V6XZtGfAsX
         iv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266276; x=1703871076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNBg0y+Bd68VL0xW77WB7jMSRPSja3ZQujiu0gSBfM4=;
        b=c8AghJjROLMuCGyIQNzwlqHTXjZfuL1jrkkz2aeWWj4eD7QEYDOgKoWZVthJryM112
         PjtHst0Fjy4e295myq/axb943vnx/VG2PRVJNPWXSAGrc7DudWmDOWROIULvfV4uKiVZ
         U6EMKK3lfRPqk+G8Kc9MIwhKcq4GYwGclf5UhFiVQCGUyqPgre8x1gYWon2hO6M4ovYG
         2mLLzmOzUAc7vBnuPwFaasCFsPzVt8zU6mJehVMamWCJkTrCmgs1dCmKyqtmgAb65M1t
         vwskkCv/biBlAaJzXckV6GeZUb9Q3KrPceB+uUUz5ZNqJdZyPq0OgjRqqTwMVHikwxA/
         4uFQ==
X-Gm-Message-State: AOJu0YxL4SY+Ng+smyxYcSPbgFlNRSl1brt7YSL6q38yxXH43VRO777l
	m1zz1CYMYZoGT81HKeMg0bZ7dthHjcPkPzWaN1j+v/3dTQiH5g==
X-Google-Smtp-Source: AGHT+IGqLB66JX2gzTB1urxa7lDtLfALa1+ydylvLoLSgnxVdq2TDvAEO7RX0xIhIqnPbSyiHZDZBoecmHefDqpDxl0=
X-Received: by 2002:a05:6122:3bc3:b0:4b6:c5ae:26cc with SMTP id
 ft3-20020a0561223bc300b004b6c5ae26ccmr719754vkb.14.1703266275645; Fri, 22 Dec
 2023 09:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222150133.732662-1-krzysztof.kozlowski@linaro.org> <20231222150133.732662-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231222150133.732662-2-krzysztof.kozlowski@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 22 Dec 2023 18:31:04 +0100
Message-ID: <CAMRc=MdYPuW8C_+EAY4UTCjqNggx6RAkp9OmLU-hRxjZNRQRHw@mail.gmail.com>
Subject: Re: [PATCH 1/4] reset: instantiate reset GPIO controller for shared reset-gpios
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sean Anderson <sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 4:01=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Devices sharing a reset GPIO could use the reset framework for
> coordinated handling of that shared GPIO line.  We have several cases of
> such needs, at least for Devicetree-based platforms.
>
> If Devicetree-based device requests a reset line which is missing but
> there is a reset-gpios property, instantiate a new "reset-gpio" platform
> device which will handle such reset line.  This allows seamless handling
> of such shared reset-gpios without need of changing Devicetree binding [1=
].
>
> The "reset-gpio" driver follows shortly.
>
> Link: https://lore.kernel.org/all/YXi5CUCEi7YmNxXM@robh.at.kernel.org/
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/reset/core.c             | 70 +++++++++++++++++++++++++++-----
>  include/linux/reset-controller.h |  2 +
>  2 files changed, 61 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 4d5a78d3c085..a1f0f515a7e0 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -10,9 +10,12 @@
>  #include <linux/export.h>
>  #include <linux/kernel.h>
>  #include <linux/kref.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_gpio.h>
>  #include <linux/acpi.h>
> +#include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/reset-controller.h>
>  #include <linux/slab.h>
> @@ -813,13 +816,59 @@ static void __reset_control_put_internal(struct res=
et_control *rstc)
>         kref_put(&rstc->refcnt, __reset_control_release);
>  }
>
> +static int __reset_add_reset_gpio_device(struct device_node *node,
> +                                        const struct gpio_desc **out)
> +{
> +       struct platform_device *pdev;
> +       int gpio;
> +
> +       /* Don't care about deprecated '-gpio' suffix. */
> +       gpio =3D of_get_named_gpio(node, "reset-gpios", 0);

Sorry but NAK. This is a legacy API, we've managed to remove all of_
GPIO interfaces but this one. Please don't use it. Any function that
deals with the global GPIO numberspace is deprecated. See below how I
would approach it.

Side note: do we have any formal way of deprecating interfaces in the kerne=
l?

> +       if (!gpio_is_valid(gpio))
> +               return gpio;
> +
> +       pdev =3D platform_device_register_data(NULL, "reset-gpio",
> +                                            PLATFORM_DEVID_AUTO, &node,
> +                                            sizeof(node));

You seem to make an assumption (in __reset_find_rcdev()) that this
device will get bound to its driver before this function returns.
There is no such guarantee. There are many situations where this may
not happen immediately (think loading the reset-gpio driver as a
module from the filesystem). You should set up a notifier callback on
the platform bus that will get invoked on bus events and wait for this
device's BUS_NOTIFY_BOUND_DRIVER event.

> +       if (!IS_ERR(pdev))
> +               *out =3D gpio_to_desc(gpio);
> +
> +       return PTR_ERR_OR_ZERO(pdev);
> +}
> +
> +static struct reset_controller_dev *__reset_find_rcdev(const struct of_p=
handle_args *args,
> +                                                      const void *cookie=
)
> +{
> +       struct reset_controller_dev *r, *rcdev;
> +
> +       lockdep_assert_held(&reset_list_mutex);
> +
> +       rcdev =3D NULL;
> +       list_for_each_entry(r, &reset_controller_list, list) {
> +               if (args && args->np) {
> +                       if (args->np =3D=3D r->of_node) {
> +                               rcdev =3D r;
> +                               break;
> +                       }
> +               } else if (cookie) {
> +                       if (cookie =3D=3D r->cookie) {

As I said in private: there's no guarantee that the same GPIO
descriptor will always reference the same GPIO line. It happens to be
the case currently but it's an implementation detail.

> +                               rcdev =3D r;
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       return rcdev;
> +}
> +
>  struct reset_control *
>  __of_reset_control_get(struct device_node *node, const char *id, int ind=
ex,
>                        bool shared, bool optional, bool acquired)
>  {
> +       const struct gpio_desc *gpio =3D NULL;
> +       struct of_phandle_args args =3D {0};
>         struct reset_control *rstc;
> -       struct reset_controller_dev *r, *rcdev;
> -       struct of_phandle_args args;
> +       struct reset_controller_dev *rcdev;
>         int rstc_id;
>         int ret;
>
> @@ -839,17 +888,16 @@ __of_reset_control_get(struct device_node *node, co=
nst char *id, int index,
>                                          index, &args);
>         if (ret =3D=3D -EINVAL)
>                 return ERR_PTR(ret);
> -       if (ret)
> -               return optional ? NULL : ERR_PTR(ret);
> +       if (ret) {
> +               ret =3D __reset_add_reset_gpio_device(node, &gpio);
> +               if (ret)
> +                       return optional ? NULL : ERR_PTR(ret);
> +
> +               args.args_count =3D 1; /* reset-gpio has only one reset l=
ine */
> +       }
>
>         mutex_lock(&reset_list_mutex);
> -       rcdev =3D NULL;
> -       list_for_each_entry(r, &reset_controller_list, list) {
> -               if (args.np =3D=3D r->of_node) {
> -                       rcdev =3D r;
> -                       break;
> -               }
> -       }
> +       rcdev =3D __reset_find_rcdev(&args, gpio);
>
>         if (!rcdev) {
>                 rstc =3D ERR_PTR(-EPROBE_DEFER);
> diff --git a/include/linux/reset-controller.h b/include/linux/reset-contr=
oller.h
> index 0fa4f60e1186..c0a99a8ea29e 100644
> --- a/include/linux/reset-controller.h
> +++ b/include/linux/reset-controller.h
> @@ -61,6 +61,7 @@ struct reset_control_lookup {
>   * @dev: corresponding driver model device struct
>   * @of_node: corresponding device tree node as phandle target
>   * @of_reset_n_cells: number of cells in reset line specifiers
> + * @cookie: for reset-gpios controllers: corresponding GPIO instead of o=
f_node
>   * @of_xlate: translation function to translate from specifier as found =
in the
>   *            device tree to id as given to the reset control ops, defau=
lts
>   *            to :c:func:`of_reset_simple_xlate`.
> @@ -74,6 +75,7 @@ struct reset_controller_dev {
>         struct device *dev;
>         struct device_node *of_node;
>         int of_reset_n_cells;
> +       const void *cookie;
>         int (*of_xlate)(struct reset_controller_dev *rcdev,
>                         const struct of_phandle_args *reset_spec);
>         unsigned int nr_resets;
> --
> 2.34.1
>

I dislike this approach entirely. Here's what I would do:

In the reset core: parse the phandle of the reset-gpios property. Use
the resulting node with gpio_device_find_by_fwnode(). If the device is
not up yet, defer probe. You'll now have the GPIO device object.
Retrieve its label using gpio_device_get_label(). Now you should have
everything you need (the offset and flags of the GPIO you'll get from
__of_parse_phandle_with_args()) to set up the lookup tables. See
include/linux/gpio/machine.h. An example of that would be in:
bcm2835_spi_setup() in drivers/spi/spi-bcm2835.c.

Then with a lookup table in place, you instantiate your device and
it'll get its GPIO as it should. This is not ideal but much better
than the above.

Bartosz

