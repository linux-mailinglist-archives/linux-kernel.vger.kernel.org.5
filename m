Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD637D65C3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjJYIuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbjJYIuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:50:05 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F0718C;
        Wed, 25 Oct 2023 01:49:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 299B61BF205;
        Wed, 25 Oct 2023 08:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698223795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kDKzSwobFKhvPb/S7FCw9CUUuZRhjo3hWw2I68BBVaY=;
        b=Uf/Ua3orfZI1c+SkYBr68sRjaF4DhtsrTNk9WD9Z5StYN8qvR7Uy+08duhBLMTFV6JQj8v
        aySWILmMdvmyNHjvzOJ636mC2pEjy0NHAlTxmL5Vkzm6/Wh5vAudTspmNHqmEid+BQWJh9
        o95X3xvKTcrGcuqX/XvGQU5KyDLyaPp5si+x5NLCMR6EmdRXvwN/nFcn+38kN9YaoHzOHG
        Rck3Au7Udt5s3YJNLK3FjJD6MGTzwTsQMFKfTEuqlJLwiCr8TEKUfozN9sLETe0Mr7LGbR
        kWPFqFe9Jr/O1MnVtAC1W+vFyzN+1Pr2jct0yfqOyBnGZFww1mEmT7UiGc8J/g==
Date:   Wed, 25 Oct 2023 10:49:53 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, ezequiel@vanguardiasur.com.ar,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com
Subject: Re: [PATCH v8 2/3] media: rockchip: Add a driver for Rockhip's
 camera interface
Message-ID: <ZTjWsf69QdXoJNKj@aptenodytes>
References: <cover.1697446303.git.mehdi.djait@bootlin.com>
 <3790470ff7606fc075ec742d43254e52dde5d120.1697446303.git.mehdi.djait@bootlin.com>
 <ee4034b9-85f6-42cc-abca-d61004aa0a6c@wolfvision.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IqvARDLe+FQx9dTB"
Content-Disposition: inline
In-Reply-To: <ee4034b9-85f6-42cc-abca-d61004aa0a6c@wolfvision.net>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IqvARDLe+FQx9dTB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon 23 Oct 23, 15:28, Michael Riesch wrote:
> Typo in the subject: "Rockhip's" -> "Rockchip's"
> I think this typo has been in there for a while now ;-)

Great hips make for great dancing!

> On 10/16/23 11:00, Mehdi Djait wrote:
> > Introduce a driver for the camera interface on some Rockchip platforms.
> >=20
> > This controller supports CSI2 and BT656 interfaces, but for
> > now only the BT656 interface could be tested, hence it's the only one
> > that's supported in the first version of this driver.
>=20
> "CSI2" -> "MIPI CSI-2" ?
> "BT656" -> "BT.656" ?
> Also, additional interfaces are supported by some units, e.g., the
> RK3568 VICAP also supports BT.1120.
>=20
> But most likely it becomes too complex to list everything, and it would
> be better if you simply described the unit in the PX30. I think this
> would clarify the commit message a lot.

For now I would just stick to mentionning parallel (aka DVP). Indeed we don=
't
need to list every possible parallel setup and MIPI CSI-2 is not supported
in the current version of the driver.

> > This controller can be fond on PX30, RK1808, RK3128 and RK3288,
> > but for now it's only been tested on PX30.
> >=20
> > Most of this driver was written following the BSP driver from rockchip,
>=20
> "rockchip" -> "Rockchip"
>=20
> > removing the parts that either didn't fit correctly the guidelines, or
> > that couldn't be tested.
> >=20
> > In the BSP, this driver is known as the "cif" driver, but this was
> > renamed to "vip" to better fit the controller denomination in the
> > datasheet.
> >=20
> > This basic version doesn't support cropping nor scaling, and is only
> > designed with one SDTV video decoder being attached to it a any time.
> >=20
> > This version uses the "pingpong" mode of the controller, which is a
> > double-buffering mechanism.
> >=20
> > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
>=20
> Two things below:
>=20
> >[...]
> > diff --git a/drivers/media/platform/rockchip/vip/dev.h b/drivers/media/=
platform/rockchip/vip/dev.h
> > new file mode 100644
> > index 000000000000..eb9cd8f20ffc
> > --- /dev/null
> > +++ b/drivers/media/platform/rockchip/vip/dev.h
> > @@ -0,0 +1,163 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Rockchip VIP Driver
> > + *
> > + * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
> > + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> > + */
> > +
> > +#ifndef _RK_VIP_DEV_H
> > +#define _RK_VIP_DEV_H
> > +
> > +#include <linux/clk.h>
> > +#include <linux/mutex.h>
> > +#include <media/media-device.h>
> > +#include <media/media-entity.h>
> > +#include <media/v4l2-ctrls.h>
> > +#include <media/v4l2-device.h>
> > +#include <media/videobuf2-v4l2.h>
> > +
> > +#define VIP_DRIVER_NAME		"rk_vip"
> > +#define VIP_VIDEODEVICE_NAME	"stream_vip"
> > +
> > +#define RK_VIP_MAX_BUS_CLK	8
> > +#define RK_VIP_MAX_SENSOR	2
> > +#define RK_VIP_MAX_RESET	5
> > +#define RK_VIP_MAX_CSI_CHANNEL	4
> > +
> > +#define RK_VIP_DEFAULT_WIDTH	640
> > +#define RK_VIP_DEFAULT_HEIGHT	480
> > +
> > +#define write_vip_reg(base, addr, val)  writel(val, (addr) + (base))
> > +#define read_vip_reg(base, addr) readl((addr) + (base))
>=20
> Please provide those helpers as proper inline functions. As to the
> naming, the "_reg" suffix seems unnecessary.
>=20
> Alternatively, you could consider converting the driver to use regmap.

Come to think of it, I feel like it would make more sense to have an inline
function which is given a struct rk_vip_device instead of having to derefer=
ence
it every time in the caller to access the base address.

> > +
> > +enum rk_vip_state {
> > +	RK_VIP_STATE_DISABLED,
> > +	RK_VIP_STATE_READY,
> > +	RK_VIP_STATE_STREAMING
> > +};
> > +
> > +enum rk_vip_chip_id {
> > +	CHIP_PX30_VIP,
> > +	CHIP_RK1808_VIP,
> > +	CHIP_RK3128_VIP,
> > +	CHIP_RK3288_VIP
> > +};
> > +
> > +enum host_type_t {
> > +	RK_CSI_RXHOST,
> > +	RK_DSI_RXHOST
> > +};
> > +
> > +struct rk_vip_buffer {
> > +	struct vb2_v4l2_buffer vb;
> > +	struct list_head queue;
> > +	union {
> > +		u32 buff_addr[VIDEO_MAX_PLANES];
> > +		void *vaddr[VIDEO_MAX_PLANES];
> > +	};
> > +};
> > +
> > +struct rk_vip_scratch_buffer {
> > +	void *vaddr;
> > +	dma_addr_t dma_addr;
> > +	u32 size;
> > +};
> > +
> > +static inline struct rk_vip_buffer *to_rk_vip_buffer(struct vb2_v4l2_b=
uffer *vb)
> > +{
> > +	return container_of(vb, struct rk_vip_buffer, vb);
> > +}
> > +
> > +struct rk_vip_sensor_info {
> > +	struct v4l2_subdev *sd;
> > +	int pad;
> > +	struct v4l2_mbus_config mbus;
> > +	int lanes;
> > +	v4l2_std_id std;
> > +};
> > +
> > +struct vip_output_fmt {
> > +	u32 fourcc;
> > +	u32 mbus;
> > +	u32 fmt_val;
> > +	u8 cplanes;
> > +};
> > +
> > +enum vip_fmt_type {
> > +	VIP_FMT_TYPE_YUV =3D 0,
> > +	VIP_FMT_TYPE_RAW,
> > +};
> > +
> > +struct vip_input_fmt {
> > +	u32 mbus_code;
> > +	u32 dvp_fmt_val;
> > +	u32 csi_fmt_val;
> > +	enum vip_fmt_type fmt_type;
> > +	enum v4l2_field field;
> > +};
> > +
> > +struct rk_vip_stream {
> > +	struct rk_vip_device		*vipdev;
> > +	enum rk_vip_state		state;
> > +	bool				stopping;
> > +	wait_queue_head_t		wq_stopped;
> > +	int				frame_idx;
> > +	int				frame_phase;
> > +
> > +	/* lock between irq and buf_queue */
> > +	spinlock_t			vbq_lock;
> > +	struct vb2_queue		buf_queue;
> > +	struct list_head		buf_head;
> > +	struct rk_vip_scratch_buffer	scratch_buf;
> > +	struct rk_vip_buffer		*buffs[2];
> > +
> > +	/* vfd lock */
> > +	struct mutex			vlock;
> > +	struct video_device		vdev;
> > +	struct media_pad		pad;
> > +
> > +	struct vip_output_fmt		*vip_fmt_out;
> > +	const struct vip_input_fmt	*vip_fmt_in;
> > +	struct v4l2_pix_format_mplane	pixm;
> > +};
> > +
> > +static inline struct rk_vip_stream *to_rk_vip_stream(struct video_devi=
ce *vdev)
> > +{
> > +	return container_of(vdev, struct rk_vip_stream, vdev);
> > +}
> > +
> > +struct rk_vip_device {
> > +	struct list_head		list;
> > +	struct device			*dev;
> > +	int				irq;
> > +	void __iomem			*base_addr;
> > +	void __iomem			*csi_base;
> > +	struct clk_bulk_data		clks[RK_VIP_MAX_BUS_CLK];
> > +	int				num_clk;
> > +	struct vb2_alloc_ctx		*alloc_ctx;
> > +	bool				iommu_en;
> > +	struct iommu_domain		*domain;
> > +	struct reset_control		*vip_rst;
> > +
> > +	struct v4l2_device		v4l2_dev;
> > +	struct media_device		media_dev;
> > +	struct v4l2_ctrl_handler	ctrl_handler;
> > +	struct v4l2_async_notifier	notifier;
> > +	struct v4l2_async_connection	asd;
> > +	struct rk_vip_sensor_info	sensor;
>=20
> Using "sensor" as name does not seem correct. As pointed out above it
> could be a video decoder just as well. Something with "subdevice" maybe?

Agreed. I suggest renaming the struct "rk_vip_sensor_info" -> "rk_cif_remot=
e"
and just calling the member "remote".

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--IqvARDLe+FQx9dTB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmU41rEACgkQ3cLmz3+f
v9G18gf9HjBe+Tt1f9LvHCxhOiq2bRyWFVPqyjlYlU4B0jK3yg6o5UcssDHUSXLT
/LtsfEKeVMMQRGDw1cAn0tafarUqk7eWQjfw4+uyPn8OMhX7CiYdKSMNaaa6KNje
PhDqijyDw4P7Hxt9vbXmJnDsrS0iKJ1PMoDLTdaqJPyCenwLjornfDqJUoOxokoX
wx8xO+ngwfzo0iTcx9djHBqw1xqJe/CoSdOxXm8rmz/gXhGxQmwAdUoArrFKzkD6
kRHf/OYepU5G8JodRIYPmng3+s1/EnkXQutDFMDQlo/xqk0b1/9MEj6g/f2U1nij
wZJTO0sfRvzQOy/PdwdaYJ3PRC8dQQ==
=iFRN
-----END PGP SIGNATURE-----

--IqvARDLe+FQx9dTB--
