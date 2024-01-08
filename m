Return-Path: <linux-kernel+bounces-19485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FDA826D9F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90A11C223BD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB44F3FE55;
	Mon,  8 Jan 2024 12:18:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3303FE46
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rMoZR-000761-BP; Mon, 08 Jan 2024 13:17:33 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rMoZP-001FLT-Rm; Mon, 08 Jan 2024 13:17:31 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rMoZP-0008v2-2U;
	Mon, 08 Jan 2024 13:17:31 +0100
Message-ID: <c2abc08d1b442fdcba7c41e2e1cc1617516441b2.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/4] reset: Instantiate reset GPIO controller for
 shared reset-gpios
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami
 <bgoswami@quicinc.com>,  Bjorn Andersson <andersson@kernel.org>, Konrad
 Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>,  alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org,  linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Sean Anderson
 <sean.anderson@seco.com>
Date: Mon, 08 Jan 2024 13:17:31 +0100
In-Reply-To: <20240105155918.279657-3-krzysztof.kozlowski@linaro.org>
References: <20240105155918.279657-1-krzysztof.kozlowski@linaro.org>
	 <20240105155918.279657-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fr, 2024-01-05 at 16:59 +0100, Krzysztof Kozlowski wrote:
> Devices sharing a reset GPIO could use the reset framework for
> coordinated handling of that shared GPIO line.  We have several cases of
> such needs, at least for Devicetree-based platforms.
>=20
> If Devicetree-based device requests a reset line, which is missing but
                                                    ^^^^^^^^^^^^^^^^
Nitpick: the "resets" property is missing, not the reset line.

"If Devicetree-based device requests a reset line, but there only is a
 reset-gpios property instead of a "resets" property, ..." maybe?

> there is a reset-gpios property, instantiate a new "reset-gpio" platform
> device which will handle such reset line.  This allows seamless handling
> of such shared reset-gpios without need of changing Devicetree binding [1=
].
>=20
> All newly registered "reset-gpio" platform devices will be stored on
> their own list to avoid any duplicated devices.

That's not strictly true. The reset_gpio_device_list only contains the
of_phandle_args for lookup.

> The key to find each of
> such platform device is the entire Devicetree GPIO specifier: phandle to
> GPIO controller, GPIO number and GPIO flags.  If two devices have
> conflicting "reset-gpios" property, e.g. with different ACTIVE_xxx
> flags, this would spawn two separate "reset-gpio" devices, where the
> second would fail probing on busy GPIO reques

request.

Is that true? The code below looks like overwrites of_phandle_args so
that only one reset-gpio device is spawned for each gpio node.

> Link: https://lore.kernel.org/all/YXi5CUCEi7YmNxXM@robh.at.kernel.org/ [1=
]
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/reset/core.c             | 176 ++++++++++++++++++++++++++++---
>  include/linux/reset-controller.h |   4 +
>  2 files changed, 167 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 4d5a78d3c085..ec9b3ff419cf 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/acpi.h>
> +#include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/reset-controller.h>
>  #include <linux/slab.h>
> @@ -23,6 +24,10 @@ static LIST_HEAD(reset_controller_list);
>  static DEFINE_MUTEX(reset_lookup_mutex);
>  static LIST_HEAD(reset_lookup_list);
> =20
> +/* Protects reset_gpio_device_list */
> +static DEFINE_MUTEX(reset_gpio_device_mutex);
> +static LIST_HEAD(reset_gpio_device_list);

I would call this reset_gpio_lookup_list or
reset_gpio_phandle_args_list.

> +
>  /**
>   * struct reset_control - a reset control
>   * @rcdev: a pointer to the reset controller device
> @@ -63,6 +68,16 @@ struct reset_control_array {
>  	struct reset_control *rstc[] __counted_by(num_rstcs);
>  };
> =20
> +/**
> + * struct reset_gpio_device - ad-hoc created reset-gpio device
> + * @of_args: phandle to the reset controller with all the args like GPIO=
 number
> + * @list: list entry for the reset_lookup_list
> + */
> +struct reset_gpio_device {

Similarly, I would call this reset_gpio_lookup or
reset_gpio_phandle_args.

> +	struct of_phandle_args of_args;
> +	struct list_head list;
> +};
> +
>  static const char *rcdev_name(struct reset_controller_dev *rcdev)
>  {
>  	if (rcdev->dev)
> @@ -813,13 +828,119 @@ static void __reset_control_put_internal(struct re=
set_control *rstc)
>  	kref_put(&rstc->refcnt, __reset_control_release);
>  }
> =20
> +static bool __reset_gpios_args_match(const struct of_phandle_args *a1,
> +				     const struct of_phandle_args *a2)
> +{
> +	unsigned int i;
> +
> +	if (!a2)
> +		return false;
> +
> +	if (a1->args_count !=3D a2->args_count)
> +		return false;
> +
> +	for (i =3D 0; i < a1->args_count; i++)
> +		if (a1->args[i] !=3D a2->args[i])
> +			break;

Just return false in the loop and simplify the following to return
true.

> +
> +	/* All args matched? */
> +	if (i =3D=3D a1->args_count)
> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + * @node:	node of the device requesting reset
> + * @reset_args:	phandle to the reset controller with all the args like G=
PIO number
> + */
> +static int __reset_add_reset_gpio_device(struct device_node *node,
> +					 struct of_phandle_args *args)
> +{
> +	struct reset_gpio_device *rgpio_dev;
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	lockdep_assert_not_held(&reset_list_mutex);
> +
> +	mutex_lock(&reset_gpio_device_mutex);
> +
> +	list_for_each_entry(rgpio_dev, &reset_gpio_device_list, list) {
> +		if (args->np =3D=3D rgpio_dev->of_args.np) {
> +			if (__reset_gpios_args_match(args,
> +						     &rgpio_dev->of_args)) {
> +				ret =3D 0;
> +				goto out_unlock;
> +			}
> +		}
> +	}
> +
> +	/* Not freed in normal path, persisent subsyst data */
> +	rgpio_dev =3D kzalloc(sizeof(*rgpio_dev), GFP_KERNEL);

Since this is persistent, instead of letting the reset-gpio driver call
of_parse_phandle_with_args() again, this could be passed in via
platform data. Is there a reason not to do that instead?

> +	if (!rgpio_dev) {
> +		ret =3D -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	rgpio_dev->of_args =3D *args;
> +	pdev =3D platform_device_register_data(NULL, "reset-gpio",
> +					     PLATFORM_DEVID_AUTO, &node,
> +					     sizeof(node));
> +	ret =3D PTR_ERR_OR_ZERO(pdev);
> +	if (!ret)
> +		list_add(&rgpio_dev->list, &reset_gpio_device_list);
> +	else
> +		kfree(rgpio_dev);
> +
> +out_unlock:
> +	mutex_unlock(&reset_gpio_device_mutex);
> +
> +	return ret;
> +}
> +
> +static struct reset_controller_dev *__reset_find_rcdev(struct of_phandle=
_args *args,
> +						       bool gpio_fallback,
> +						       const void *cookie)

Unused cookie.

> +{
> +	struct reset_controller_dev *r, *rcdev;
> +
> +	lockdep_assert_held(&reset_list_mutex);
> +
> +	rcdev =3D NULL;
> +	list_for_each_entry(r, &reset_controller_list, list) {
> +		if (args->np =3D=3D r->of_node) {
> +			if (gpio_fallback) {
> +				if (__reset_gpios_args_match(args, r->of_args)) {
> +					/*
> +					 * Fake args (take first reset) and
> +					 * args_count (to matcg reset-gpio

match

> +					 * of_reset_n_cells) because reset-gpio
> +					 * has only one reset and does not care
> +					 * about reset of GPIO specifier.
> +					 */
> +					args->args[0] =3D 0;
> +					args->args_count =3D 1;

I'd expect args to be an input-only argument, but here its contents are
overwritten after a match. Why?

This has an effect in __of_reset_control_get(), that I find hard to
follow. See below.

> +					rcdev =3D r;
> +					break;
> +				}
> +			} else {
> +				rcdev =3D r;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return rcdev;
> +}
> +
>  struct reset_control *
>  __of_reset_control_get(struct device_node *node, const char *id, int ind=
ex,
>  		       bool shared, bool optional, bool acquired)
>  {
> +	struct of_phandle_args args =3D {0};
> +	bool gpio_fallback =3D false;
>  	struct reset_control *rstc;
> -	struct reset_controller_dev *r, *rcdev;
> -	struct of_phandle_args args;
> +	struct reset_controller_dev *rcdev;
>  	int rstc_id;
>  	int ret;
> =20
> @@ -839,21 +960,50 @@ __of_reset_control_get(struct device_node *node, co=
nst char *id, int index,
>  					 index, &args);
>  	if (ret =3D=3D -EINVAL)
>  		return ERR_PTR(ret);
> -	if (ret)
> -		return optional ? NULL : ERR_PTR(ret);
> +	if (ret) {
> +		/*
> +		 * There can be only one reset-gpio for regular devices, so
> +		 * don't bother with GPIO index.
> +		 */

I don't understand this comment. The GPIO index should be checked as
part of __reset_gpios_args_match(), or should it not?

> +		ret =3D of_parse_phandle_with_args(node, "reset-gpios", "#gpio-cells",
> +						 0, &args);
> +		if (ret)
> +			return optional ? NULL : ERR_PTR(ret);
> =20
> -	mutex_lock(&reset_list_mutex);
> -	rcdev =3D NULL;
> -	list_for_each_entry(r, &reset_controller_list, list) {
> -		if (args.np =3D=3D r->of_node) {
> -			rcdev =3D r;
> -			break;
> -		}
> +		gpio_fallback =3D true;

Is there a reason not just call __reset_add_reset_gpio_device() here?
With that, there should be no need to call __reset_find_rcdev() twice.

>  	}
> =20
> +	mutex_lock(&reset_list_mutex);
> +	rcdev =3D __reset_find_rcdev(&args, gpio_fallback, NULL);

This gets called with args as parsed. If there is a match, this will=20
overwrite args (in the gpio_fallback case) and return NULL.

> +
>  	if (!rcdev) {
> -		rstc =3D ERR_PTR(-EPROBE_DEFER);
> -		goto out;
> +		if (gpio_fallback) {
> +			/*
> +			 * Registering reset-gpio device might cause immediate
> +			 * bind, thus taking reset_list_mutex lock via
> +			 * reset_controller_register().
> +			 */
> +			mutex_unlock(&reset_list_mutex);
> +			ret =3D __reset_add_reset_gpio_device(node, &args);

So this will also be called with args as parsed.

> +			mutex_lock(&reset_list_mutex);
> +			if (ret) {
> +				rstc =3D ERR_PTR(ret);
> +				goto out;
> +			}
> +			/*
> +			 * Success: reset-gpio could probe immediately, so
> +			 * re-check the lookup.
> +			 */
> +			rcdev =3D __reset_find_rcdev(&args, gpio_fallback, NULL);

And this will again be called with args as parsed and overwrite args
again.

> +			if (!rcdev) {
> +				rstc =3D ERR_PTR(-EPROBE_DEFER);
> +				goto out;
> +			}
> +			/* Success, rcdev is valid thus do not bail out */
> +		} else {
> +			rstc =3D ERR_PTR(-EPROBE_DEFER);
> +			goto out;
> +		}
>  	}

So at this point args is overwritten in the gpio_fallback case. I would
find it much clearer to just overwrite args here and make the first
parameter to __reset_find_rcdev() const.


regards
Philipp

