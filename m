Return-Path: <linux-kernel+bounces-137835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D68689E825
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC34B1F25B75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D207D8BF0;
	Wed, 10 Apr 2024 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIVXz2yV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E751C2E;
	Wed, 10 Apr 2024 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712716059; cv=none; b=YHk3Do2u8KRMexlFqt6qjlKOBi6ozyext75IAtOy4x2suOVTK/QAI1MmkBZMn+CusiQmksu62iNYBOWHgJjnqothySTmYfE2U2hdyRGoCZehgGJOIt/NCJpjSvS9LlfLcllRirOL4nuA9knUP7Hzin80n57ttmAu3W6gGHwXkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712716059; c=relaxed/simple;
	bh=KCZk5Jghp9ioOCljK8ePjGa/GSS059iFLxQINPpp1zg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Atw2RrmbHK5LxYkpT7snLzJrf4O6umXI12sEJapq0UPkBAzz5RlHPXepiuBvDWUDOisjG25aQhntasI9ddA3OfnOx6ttpo94iqAq/U1VMFzTUdKaICqHeV3XtlqH/N5l5rUAlQKiMz9k9JC0xKyPUUUjNx6EpbwSpUlGKb3Km8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIVXz2yV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7921FC433C7;
	Wed, 10 Apr 2024 02:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712716058;
	bh=KCZk5Jghp9ioOCljK8ePjGa/GSS059iFLxQINPpp1zg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=cIVXz2yVe7ImcNYM7wBUtIVH3Cy2FfbisfRQ6w1VZOtS98YSFvZBVemDOxX2wRjlh
	 qp9KtrdBV4GqnI4PQE3m42UGIqt2xiOrQI7AadLeMSEKX8h+SDl6ae7vSnSWaE+7il
	 1xPhVhzCMwkZbrffA4beBS9yVbxTWNX8sjxYNRd7NzlmRB4Sk96MkOpblZSZmFMRmY
	 fdY5cy3BCh0lC516EQNQxKmmq8FHiV6gBJ7pyQop6ShhDd+VaZ0qxlDxxEKvpBzJU/
	 YJQZu0B0Yfg8lKTvD5B55HrdrBE7sLIQkKM5KqpKdGA5M9ucZ0x+yWOXu9pO6qbkzX
	 5uUSILmGfGBtQ==
Message-ID: <dde59dd2ef4da81528e31f65844e0b3f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240409-shallow-voice-c84ed791bc7d@spud>
References: <20240328010831.884487-1-jan.dakinevich@salutedevices.com> <20240328010831.884487-2-jan.dakinevich@salutedevices.com> <1j7chfiz8e.fsf@starbuckisacylon.baylibre.com> <e3a85852b911fdf16dd9ae158f42b3ef.sboyd@kernel.org> <f01cdd910ab35316b8012795f73fd2b34c8e6f8e.camel@pengutronix.de> <13617b7a892424d2b024c725505a6f4f.sboyd@kernel.org> <20240408-numerator-escargot-a642507a598e@spud> <20240409-shallow-voice-c84ed791bc7d@spud>
Subject: Re: [RFC PATCH v2 1/5] clk: meson: axg: move reset controller's code to separate module
From: Stephen Boyd <sboyd@kernel.org>
Cc: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Jerome Brunet <jbrunet@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Neil Armstrong <neil.armstrong@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Conor Dooley <conor@kernel.org>
Date: Tue, 09 Apr 2024 19:27:36 -0700
User-Agent: alot/0.10

Quoting Conor Dooley (2024-04-09 05:05:37)
> On Mon, Apr 08, 2024 at 06:05:51PM +0100, Conor Dooley wrote:
>=20
> > > > Seconded, the clk-mpfs/reset-mpfs and clk-starfive-jh7110-sys/reset-
> > > > starfive-jh7110 drivers are examples of this.
> > > >=20
> > > > > The auxiliary device creation function can also be in the
> > > > > drivers/reset/ directory so that the clk driver calls some functi=
on
> > > > > to create and register the device.
> > > >=20
> > > > I'm undecided about this, do you think mpfs_reset_controller_regist=
er()
> > > > and jh7110_reset_controller_register() should rather live with the
> > > > reset aux drivers in drivers/reset/ ?
> > >=20
> > > Yes, and also mpfs_reset_read() and friends. We should pass the base
> > > iomem pointer and parent device to mpfs_reset_adev_alloc() instead and
> > > then move all that code into drivers/reset with some header file
> > > exported function to call. That way the clk driver hands over the data
> > > without having to implement half the implementation.
> >=20
> > I'll todo list that :)
>=20
> Something like the below?
>=20
> -- >8 --
> From a12f281d2cb869bcd9a6ffc45d0c6a0d3aa2e9e2 Mon Sep 17 00:00:00 2001
> From: Conor Dooley <conor.dooley@microchip.com>
> Date: Tue, 9 Apr 2024 11:54:34 +0100
> Subject: [PATCH] clock, reset: microchip: move all mpfs reset code to the
>  reset subsystem
>=20
> <insert something here>
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Looks pretty good.

>  static const struct of_device_id mpfs_clk_of_match_table[] =3D {
> diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
> index 7f3fb2d472f4..27cd68b4ee81 100644
> --- a/drivers/reset/reset-mpfs.c
> +++ b/drivers/reset/reset-mpfs.c
> @@ -137,9 +139,67 @@ static int mpfs_reset_probe(struct auxiliary_device =
*adev,
>         return devm_reset_controller_register(dev, rcdev);
>  }
> =20
> +static void mpfs_reset_unregister_adev(void *_adev)
> +{
> +       struct auxiliary_device *adev =3D _adev;
> +
> +       auxiliary_device_delete(adev);
> +       auxiliary_device_uninit(adev);
> +}
> +
> +static void mpfs_reset_adev_release(struct device *dev)
> +{
> +       struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> +
> +       kfree(adev);
> +}
> +
> +static struct auxiliary_device *mpfs_reset_adev_alloc(struct device *clk=
_dev)
> +{
> +       struct auxiliary_device *adev;
> +       int ret;
> +
> +       adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
> +       if (!adev)
> +               return ERR_PTR(-ENOMEM);
> +
> +       adev->name =3D "reset-mpfs";
> +       adev->dev.parent =3D clk_dev;
> +       adev->dev.release =3D mpfs_reset_adev_release;
> +       adev->id =3D 666u;
> +
> +       ret =3D auxiliary_device_init(adev);
> +       if (ret) {
> +               kfree(adev);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return adev;
> +}
> +
> +int mpfs_reset_controller_register(struct device *clk_dev, void __iomem =
*base)
> +{
> +       struct auxiliary_device *adev;
> +       int ret;
> +
> +       mpfs_reset_addr =3D base;

Instead of a global this can be stashed in adev->dev.platform_data and
grabbed in the driver probe?

> +
> +       adev =3D mpfs_reset_adev_alloc(clk_dev);
> +       if (IS_ERR(adev))
> +               return PTR_ERR(adev);
> +
> +       ret =3D auxiliary_device_add(adev);
> +       if (ret) {
> +               auxiliary_device_uninit(adev);
> +               return ret;
> +       }
> +
> +       return devm_add_action_or_reset(clk_dev, mpfs_reset_unregister_ad=
ev, adev);
> +}
> +
>  static const struct auxiliary_device_id mpfs_reset_ids[] =3D {
>         {
> -               .name =3D "clk_mpfs.reset-mpfs",
> +               .name =3D "reset_mpfs.reset-mpfs",
>         },
>         { }
>  };
> diff --git a/include/soc/microchip/mpfs.h b/include/soc/microchip/mpfs.h
> index 09722f83b0ca..0b756bf5e9bd 100644
> --- a/include/soc/microchip/mpfs.h
> +++ b/include/soc/microchip/mpfs.h
> @@ -43,11 +43,11 @@ struct mtd_info *mpfs_sys_controller_get_flash(struct=
 mpfs_sys_controller *mpfs_
>  #endif /* if IS_ENABLED(CONFIG_POLARFIRE_SOC_SYS_CTRL) */
> =20
>  #if IS_ENABLED(CONFIG_MCHP_CLK_MPFS)
> -
> -u32 mpfs_reset_read(struct device *dev);
> -
> -void mpfs_reset_write(struct device *dev, u32 val);
> -
> +#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
> +int mpfs_reset_controller_register(struct device *clk_dev, void __iomem =
*base);
> +#else
> +int mpfs_reset_controller_register(struct device *clk_dev, void* __iomem=
 base) { return 0;}

static inline

