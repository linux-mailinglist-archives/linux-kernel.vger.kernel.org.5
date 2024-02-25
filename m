Return-Path: <linux-kernel+bounces-80281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB2A862CDC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACB0283159
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B031017997;
	Sun, 25 Feb 2024 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="blFS+gck"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25D42CA9
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708893471; cv=none; b=rCzl6mSJhYMqoTylYjxFA2oCs7ZSUX9LWFMMgsz421NEDgZoZlMMmDsGOtKU7CZXdZ0leQKc1qUb26UC5lbFEEF+WcKn44pEHgfOJb/El3IBOP5fauVMeIwbVrsnUsY3DdXDgV/um0QhG5JS1UOM3swUJOWRpeKNUcuxd5DC4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708893471; c=relaxed/simple;
	bh=o+f5YbI4M5UPfaTvg/Fku0fzIM2l31BIbDrylqVTkQs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6m0AE0bXYa6RF2VU+iAox3qYI2nfdfsRfAccMNlMdj/zhdvO0kR+tqKK5gUalZP0QUX+U3huF6YA0uWtBLgTge/+bM58rz+Nz9HsfenOB9prxwRE0WtEoIZPGe7Gsr3ymCF1HfRRZ6Ron6ObQuCfGc4TUws/pI8og/hgomapwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=blFS+gck; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1708893467; x=1709152667;
	bh=o+f5YbI4M5UPfaTvg/Fku0fzIM2l31BIbDrylqVTkQs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=blFS+gckOD8y6d+oUfM2gLvszlsnY7Rr3d+JNHIXl44ZBfrmxlPRv/cxljaxBMxwS
	 tBUdPGM7xVuwYGUGdvrUY2cqdYgIsBthrv4BlzBegh3Nh2bhVcUjSfombvmUTTJI7y
	 m2QQRkGFksKIE5mJ8iq7GSQXBKuol+RTh+sHqm4722xp2pGAtUjQIne3GUrHtLckEr
	 IRTbWN6+i4wXhyFsbjnSlcbnkZ8eWPHGkJvzJ1hsVWwkOou+KcTubhU0MTaY0ypRXy
	 EGGzLyZ1vr/E6CmAP+7/12vlV9BfskaSnaaYKYoSzaT/MHcXE0ujDqdiuSWrtZtII2
	 j0ca40T6nmhfw==
Date: Sun, 25 Feb 2024 20:37:42 +0000
To: Saravana Kannan <saravanak@google.com>
From: Michael Pratt <mcpratt@pm.me>
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, abel.vesa@linaro.org, alexander.stein@ew.tq-group.com, andriy.shevchenko@linux.intel.com, bigunclemax@gmail.com, brgl@bgdev.pl, colin.foster@in-advantage.com, djrscally@gmail.com, dmitry.baryshkov@linaro.org, festevam@gmail.com, fido_max@inbox.ru, frowand.list@gmail.com, geert@linux-m68k.org, heikki.krogerus@linux.intel.com, kernel@pengutronix.de, linus.walleij@linaro.org, linux@roeck-us.net, luca.weiss@fairphone.com, magnus.damm@gmail.com, martin.kepplinger@puri.sm, miquel.raynal@bootlin.com, rafal@milecki.pl, ansuelsmth@gmail.com, richard@nod.at, sakari.ailus@linux.intel.com, sudeep.holla@arm.com, tglx@linutronix.de, tony@atomide.com, vigneshr@ti.com, dianders@chromium.org, jpb@kernel.org, rafael@kernel.org, Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v1 2/4] driver core: fw_devlink: Link to supplier ancestor if no device
Message-ID: <WfZQTVQwRumG8L5YEf32cJoQCFo_5pAh7QH6Giq1CGI8J-PTcwXV-aWtWQqQCdkI2ZVQbbCVdVXxLhorucDAeKDlJoXW0A2Xfm0-cVvdhSo=@pm.me>
In-Reply-To: <CAGETcx8S6B09T==dSp38-vX+rYjRyTaRwVqF0c2Nh-KxwDFAtw@mail.gmail.com>
References: <20240123014517.5787-1-mcpratt@pm.me> <20240123014517.5787-3-mcpratt@pm.me> <CAGETcx8S6B09T==dSp38-vX+rYjRyTaRwVqF0c2Nh-KxwDFAtw@mail.gmail.com>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

Thanks for taking a look at the patch series.
I'm going to write a longer reply to the rest of what you said later.

On Monday, February 5th, 2024 at 14:25, Saravana Kannan <saravanak@google.c=
om> wrote:

>=20
>=20
> On Mon, Jan 22, 2024 at 5:46=E2=80=AFPM Michael Pratt mcpratt@pm.me wrote=
:
>=20
> >=20
> > Signed-off-by: Michael Pratt mcpratt@pm.me
>=20
>=20
> NACK for a bunch of reasons.
>=20
> 1. This logic should not be in fwnode_link_add(). That's supposed to
> do the exact linking that the firmware meant. This logic should be
> where the fwnode links are converted to device links or deferred
> probing decision is done.

Yeah, I can definitely make this change without any problems.

>=20
> 2. If we handle one parent above correctly, it should be easy to
> handle multiple parents above too. So why not fix it where we handle
> multiple parents above?

I can do this too, but since going one parent up would have to occur
multiple times, it would still end up being a recursive search for the flag=
.
Without finding the right fwnode right away, the new fixup function here
would have to recursively call itself 3 or 4 times instead of once or twice=
,
and each call would result in going through the entire loop of=20
fw_devlink_link_device() for the consumer which would overall take a little=
 more time.


>=20
> Btw, I'm happy to fix this or help you fix this once I understand the
> issue. Just wanted to give a quick NACK to avoid people spending
> cycles on this patch in its current state.


I totally understand. I am still new to kernel things, so I imagine that
whenever I think that I'm finished with something,
that I'm actually just halfway done with it, even though it took forever
to get to this point, haha.


>=20
> -Saravana
>=20
> > ---
> > drivers/base/core.c | 49 ++++++++++++++++++++++++++++++++++++------
> > include/linux/fwnode.h | 4 ++++
> > 2 files changed, 47 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index c05a5f6b0641..7f2652cf5edc 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -92,13 +92,45 @@ static int __fwnode_link_add(struct fwnode_handle *=
con,
> > return 0;
> > }
> >=20
> > +static int __fwnode_link_add_parents(struct fwnode_handle *con,
> > + struct fwnode_handle *sup,
> > + u8 flags, bool loop)
> > +{
> > + int ret =3D -EINVAL;
> > + struct fwnode_handle parent;
> > +
> > + fwnode_for_each_parent_node(sup, parent) {
> > + / Ignore the root node */
> > + if (fwnode_count_parents(parent) &&
> > + fwnode_device_is_available(parent) &&
> > + !(parent->flags & FWNODE_FLAG_NOT_DEVICE) &&
> > + !(parent->flags & FWNODE_FLAG_PARENT_IS_DEV)) {
> > + ret =3D __fwnode_link_add(con, parent, flags);
> > + }
> > +
> > + if (!loop && !ret) {
> > + fwnode_handle_put(parent);
> > + return 0;
> > + }
> > + }
> > +
> > + return ret;
> > +}
> > +
> > int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *su=
p)
> > {
> > int ret;
> >=20
> > mutex_lock(&fwnode_link_lock);
> > - ret =3D __fwnode_link_add(con, sup, 0);
> > +
> > + if ((sup->flags & FWNODE_FLAG_NOT_DEVICE) &&
> > + (sup->flags & FWNODE_FLAG_PARENT_IS_DEV))
> > + ret =3D __fwnode_link_add_parents(con, sup, 0, false);
> > + else
> > + ret =3D __fwnode_link_add(con, sup, 0);
> > +
> > mutex_unlock(&fwnode_link_lock);
> > +
> > return ret;
> > }
> >=20
> > @@ -218,7 +250,8 @@ static void __fwnode_links_move_consumers(struct fw=
node_handle *from,
> > * MANAGED device links to this device, so leave @fwnode and its descend=
ant's
> > * fwnode links alone.
> > *
> > - * Otherwise, move its consumers to the new supplier @new_sup.
> > + * Otherwise, flag descendants of @fwnode as having a parent fwnode fo=
r a device
> > + * that has probed and move bad fwnode consumer links from @fwnode to =
@new_sup.
> > */
> > static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handle=
 *fwnode,
> > struct fwnode_handle *new_sup)
> > @@ -228,8 +261,11 @@ static void __fw_devlink_pickup_dangling_consumers=
(struct fwnode_handle *fwnode,
> > if (fwnode->dev && fwnode->dev->driver)
> > return;
> >=20
> > - fwnode->flags |=3D FWNODE_FLAG_NOT_DEVICE;
> > - __fwnode_links_move_consumers(fwnode, new_sup);
> > + if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)
> > + __fwnode_links_move_consumers(fwnode, new_sup);
> > +
> > + fwnode->flags |=3D FWNODE_FLAG_PARENT_IS_DEV;
> > + new_sup->flags &=3D ~(FWNODE_FLAG_PARENT_IS_DEV);
> >=20
> > fwnode_for_each_available_child_node(fwnode, child)
> > __fw_devlink_pickup_dangling_consumers(child, new_sup);
> > @@ -2071,8 +2107,9 @@ static int fw_devlink_create_devlink(struct devic=
e *con,
> > device_links_write_unlock();
> > }
> >=20
> > - if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
> > - sup_dev =3D fwnode_get_next_parent_dev(sup_handle);
> > + if ((sup_handle->flags & FWNODE_FLAG_NOT_DEVICE) &&
> > + !(sup_handle->flags & FWNODE_FLAG_PARENT_IS_DEV))
> > + return -EINVAL;
> > else
> > sup_dev =3D get_dev_from_fwnode(sup_handle);
> >=20
> > diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> > index 2a72f55d26eb..3ed8ba503062 100644
> > --- a/include/linux/fwnode.h
> > +++ b/include/linux/fwnode.h
> > @@ -30,6 +30,9 @@ struct device;
> > * BEST_EFFORT: The fwnode/device needs to probe early and might be miss=
ing some
> > * suppliers. Only enforce ordering with suppliers that have
> > * drivers.
> > + * PARENT_IS_DEV: The fwnode is a child of a fwnode that is or will be=
 populated as a
> > + * struct device, which is more suitable for device links
> > + * than the fwnode child which may never have a struct device.
> > */
> > #define FWNODE_FLAG_LINKS_ADDED BIT(0)
> > #define FWNODE_FLAG_NOT_DEVICE BIT(1)
> > @@ -37,6 +40,7 @@ struct device;
> > #define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD BIT(3)
> > #define FWNODE_FLAG_BEST_EFFORT BIT(4)
> > #define FWNODE_FLAG_VISITED BIT(5)
> > +#define FWNODE_FLAG_PARENT_IS_DEV BIT(6)
> >=20
> > struct fwnode_handle {
> > struct fwnode_handle *secondary;
> > --
> > 2.30.2

--
MCP

