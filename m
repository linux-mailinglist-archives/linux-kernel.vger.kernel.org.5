Return-Path: <linux-kernel+bounces-99254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048158785A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361801C21B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D43482C3;
	Mon, 11 Mar 2024 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YYzNun8W"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632E61EB5C;
	Mon, 11 Mar 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175375; cv=none; b=AsTPeh4NdhfkjqKAN0eLuRYsm6YoXc0vUunz/pSB5opq0WnJLnk5jjPoZ4cqmxguvKOa+C1/6DsizWvTJpGtkAekSTuLHTQ+wCnKZQLqcEdstwTtARDvgq6TZxehUwO+Z+MLI7Cl1crCNxp1nH9iLGT4Ze5f+EVpk5eE0435vpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175375; c=relaxed/simple;
	bh=Ttv99q8rQ4U54AZVsuGb8BhkkD678dDrmrAqjSbxBFI=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=W/ij3FxximwGQv9I4P44ONcQzcXPMNo85xj4cPufFasxrhqlwYhy/ofr52QM7eFhqGJzQNeaEc5JuwRpaLAGKkZ+TiC2hISqLqlKVhCgSwp+DARd8yKGIyqiXbxV6Ng0sb0/HOWW5eyrT8hZokLEjPWMPOs7BolhoO6Epe7prg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=YYzNun8W; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 526816BE;
	Mon, 11 Mar 2024 17:42:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710175348;
	bh=Ttv99q8rQ4U54AZVsuGb8BhkkD678dDrmrAqjSbxBFI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YYzNun8Wh3bbNhUmvVfhLiAy3/z1IIcko9n1lghrEC0Qyo4AJRXtQ+GMsPfnSC87k
	 k3FWSdDtAs5bOmLz4Lx8DOAKDG2P4Y2JVhrH8UbufEU1orRIBYhaJJOUQ7xOyLkIid
	 s7t1GzAa2nsQb2w4gRkNRuATBMiixcc2rQNcYMTw=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Ze8xY1bqTiXzRvKp@kekkonen.localdomain>
References: <20240307214048.858318-1-umang.jain@ideasonboard.com> <20240307214048.858318-3-umang.jain@ideasonboard.com> <Zeq7HBMqqrw4nSPj@kekkonen.localdomain> <171016009901.2924028.16001544322304093037@ping.linuxembedded.co.uk> <Ze8xY1bqTiXzRvKp@kekkonen.localdomain>
Subject: Re: [PATCH v2 2/2] media: i2c: Add imx283 camera sensor driver
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>, linux-media@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, willl will <will@willwhang.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Alain Volmat <alain.volmat@foss.st.com>, Paul Elder <paul.elder@ideasonboard.com>, Mehdi Djait <mehdi.djait@bootlin.com>, Bingbu Cao <bingbu.cao@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sebastian Reichel <sre@kernel.org>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, open list <linux-kernel@vger.kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Date: Mon, 11 Mar 2024 16:42:46 +0000
Message-ID: <171017536692.2924028.6522729664515712567@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Sakari Ailus (2024-03-11 16:29:23)
> Hi Kieran,
>=20
> On Mon, Mar 11, 2024 at 12:28:19PM +0000, Kieran Bingham wrote:
> > Hi Sakari, Umang,
> >=20
> > I've replied inline below to a couple of points that I was responsible =
for.
> >=20
> > >=20
> > > > +
> > > > +struct imx283 {
> > > > +     struct device *dev;
> > > > +     struct regmap *cci;
> > > > +
> > > > +     const struct imx283_input_frequency *freq;
> > > > +
> > > > +     struct v4l2_subdev sd;
> > > > +     struct media_pad pad;
> > > > +
> > > > +     struct clk *xclk;
> > > > +
> > > > +     struct gpio_desc *reset_gpio;
> > > > +     struct regulator_bulk_data supplies[ARRAY_SIZE(imx283_supply_=
name)];
> > > > +
> > > > +     /* V4L2 Controls */
> > > > +     struct v4l2_ctrl_handler ctrl_handler;
> > > > +     struct v4l2_ctrl *exposure;
> > > > +     struct v4l2_ctrl *vblank;
> > > > +     struct v4l2_ctrl *hblank;
> > > > +     struct v4l2_ctrl *vflip;
> > > > +
> > > > +     unsigned long link_freq_bitmap;
> > > > +
> > > > +     u16 hmax;
> > > > +     u32 vmax;
> > > > +};
> > > > +
> > > > +static inline struct imx283 *to_imx283(struct v4l2_subdev *_sd)
> > > > +{
> > > > +     return container_of(_sd, struct imx283, sd);
> > >=20
> > > It's a function, you can call _sd sd instead.
> >=20
> > Except then that could 'look' like it is passed as the first and third
> > argument to container_of...
>=20
> It's really a non-issue: the third argument is a field name, not a
> variable.

That's not so easy to determine when the args are the same name.., but
it's fine with me either way.

> > But if it's fine / accepted otherwise then sure.
>=20
> And please use container_of_const(). :)

Ack. Or rather ... I'll leave that to Umang to handle, as he's managing
this driver now.

> > > > +
> > > > +/* Determine the exposure based on current hmax, vmax and a given =
SHR */
> > > > +static u64 imx283_exposure(struct imx283 *imx283,
> > > > +                        const struct imx283_mode *mode, u64 shr)
> > > > +{
> > > > +     u32 svr =3D 0; /* SVR feature is not currently supported */
> > >=20
> > > What does this refer to? I guess you could just drop it as well if it=
's not
> > > supported?
> >=20
> > Keeping this will keep the calculation matching the datasheet, and
> > provide clear value for what to update when we/others return to enable
> > long exposures.
> >=20
> > So it would be nice to keep as it sort of documents/tracks the
> > datasheet.
>=20
> Ack.
>=20
> >=20
> >=20
> > > > +     u32 hmax =3D imx283->hmax;
> > > > +     u64 vmax =3D imx283->vmax;
> > >=20
> > > You're not changing the values here. I wouldn't introduce temporary
> > > variables just for that.
> > >=20
> > > > +     u32 offset;
> > > > +     u64 numerator;
> > > > +
> > > > +     /* Number of clocks per internal offset period */
> > > > +     offset =3D mode->mode =3D=3D IMX283_MODE_0 ? 209 : 157;
> > >=20
> > > Shouldn't this be in the mode definition?
> >=20
> > It could be, but then there would be one copy of 209, and 9 copies of
> > 157.=20
>=20
> That would still be specified explicitly. Someone adding a new mode would
> easily miss this.
>=20
> Or, if you can, derive this from something else that is now a part of the
> mode itself.

I don't understand the above, other than ... That's exactly what we're
doing here.

*Only* MODE_0 has an offset of 209 in the datasheet. All other modes are
157.

This is the table being codified:
  https://pasteboard.co/OsKf4VX7rtrS.png

--
Kieran

