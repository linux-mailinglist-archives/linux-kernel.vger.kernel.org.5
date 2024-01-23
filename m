Return-Path: <linux-kernel+bounces-34605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9068382C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE3D1F27399
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04915F579;
	Tue, 23 Jan 2024 01:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="qucMjGIL"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C29B5024B;
	Tue, 23 Jan 2024 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974449; cv=none; b=s76hSHyO6kfCQN4nes3gMkx7HMm3W8aegW5vyg4N/flR2VsVG+uqIcFnvxRx0PhTPM4VzYW7dcREN9UsexbvUv9HthzR9Or+OtQFWghyttDnjwc2Nj/nZ9gJ7LGUH4/rBlBjn3YkU8TkGgzDNnm83IZkyFoaPLXShSsqot1BWO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974449; c=relaxed/simple;
	bh=YJfPUc9JPqplbqb8Uk3tshtQpjNjIQojMn1nswK+Auo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c9DfYDCNIfi/gaZ2psVYNcLCCZ6DpM9zIJp3L+yWsnWlyI0rJrGAHC+ybp/tOz9LFoA7wsP293UVeF0jToBvA1aELdxcbtr/Sh+oVYUPN5XjYWqyQpfQ1p4LTh7IWXaeVfqvfLToZ7oplM2/IPatC44LRjsxN0pIul3dJYMHJ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=qucMjGIL; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1705974439; x=1706233639;
	bh=4YREAB+lLFhLYt23yOuuQE8IjzcG54BZ+WRgblN4Okw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qucMjGILNV9xcag759X1TuTYlyL0txyxsfKThwXcZbwH7piqvdGUkheC7w6oM1ne1
	 cy9kEbGzLwMMKqQTrXDFvV22FAr4bI7QK6ntMZJuP7ORlhJDak+fRg6cfr90FQ4jNI
	 S63nvaYljxfj+Ohg4Xw9URE0+p/sJdX1bcdaVP3KTjV0lxCdDBj+03g21N42sUMhj2
	 ATg+V4N1Pfl58CD7kt51GLnK/tg526xMjnQanL/loJ2Vqge7nrqwhZx9L4aN5iGsDR
	 424DxiwHM7Yj8SJAp/Z56wmUqxnauuipqmRstjuOOKWRXEKOJqdEqdUPltuer/QV6E
	 NlrBgyN1KmpSA==
Date: Tue, 23 Jan 2024 01:47:01 +0000
To: devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
From: Michael Pratt <mcpratt@pm.me>
Cc: Michael Pratt <mcpratt@pm.me>, saravanak@google.com, abel.vesa@linaro.org, alexander.stein@ew.tq-group.com, andriy.shevchenko@linux.intel.com, bigunclemax@gmail.com, brgl@bgdev.pl, colin.foster@in-advantage.com, djrscally@gmail.com, dmitry.baryshkov@linaro.org, festevam@gmail.com, fido_max@inbox.ru, frowand.list@gmail.com, geert@linux-m68k.org, heikki.krogerus@linux.intel.com, kernel@pengutronix.de, linus.walleij@linaro.org, linux@roeck-us.net, luca.weiss@fairphone.com, magnus.damm@gmail.com, martin.kepplinger@puri.sm, miquel.raynal@bootlin.com, rafal@milecki.pl, ansuelsmth@gmail.com, richard@nod.at, sakari.ailus@linux.intel.com, sudeep.holla@arm.com, tglx@linutronix.de, tony@atomide.com, vigneshr@ti.com, dianders@chromium.org, jpb@kernel.org, rafael@kernel.org
Subject: [PATCH v1 3/4] driver core: fw_devlink: Add function device_links_fixup_suppliers()
Message-ID: <20240123014517.5787-4-mcpratt@pm.me>
In-Reply-To: <20240123014517.5787-1-mcpratt@pm.me>
References: <20240123014517.5787-1-mcpratt@pm.me>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

If the supplier fwnode of a link is a child firmware node
of a real device, the probe of the consumer device can be indefinitely
deferred in some cases like when the consumer is registered as a device
and attempts probe first.

Add a function to fixup or recreate both fwnode and device links
to a consumer device before probing gets deferred.

As noted in the previous commit,
descendant fwnodes of the real supplier device only become flagged
with PARENT_IS_DEV when the real supplier device probes,
which is necessary in some cases for knowing how many ancestors up
in the tree the fwnode representing the real device is.

In the case where the consumer device has a probe attempt
before the supplier device while the correct supplier fwnode
is multiple ancestors up from the fwnode being linked,
the unknowns present before the supplier device probes
causes incorrect fwnode links that either become incorrect device links
or in some cases, fwnode links are unable to become device links at all,
which leads to the need to redo the link between the devices
after a probe defer of the consumer, therefore,
when the original supplier fwnode is flagged PARENT_IS_DEV
after supplier device probing,
and the consumer is about to be deferred again from a missing supplier,
flag the original supplier fwnode as NOT_DEVICE also
and recreate the relevant fwnode/device links to the consumer device.

In the case where the supplier probes first
but a descendant fwnode is the one linked to the consumer,
the link recreation happens on the first probe attempt of the consumer.

Because of the fwnode flags, the links will be handled differently
when deleted and recreated compared to before the consumer probe attempt
by linking the consumer with a ancestor of the original supplier fwnode,
which at this point represents a device that already probed successfully.
In the future, a way to develop "deferred device links" may be possible,
but that is likely much more complex.

The existing function device_links_check_suppliers() is not suitable
for these fixup changes because of the case where a different supplier
may also cause a deferred probe for a completely different reason.
Handle this in a new function device_links_fixup_suppliers()
which will be called before device_links_check_suppliers()
which is where it is decided whether or not the consumer must be deferred.
Checks in the new function exactly match checks in the function
device_links_check_suppliers() for consistency.

This new function is now the last opportunity to interact with
device links before probe is deferred, which stops device links from
being processed until re-probe or the next time device_add() is called.
This makes it an ideal location to finally assume that the supplier
must have probed at that point in time, unless there is an issue.
This should be called at every probe, because it is important to
handle as many device link changes as possible before probe deferral,
since deferred_probe_initcall() will only be called *once*
at late_initcall, and another probe defer at that point or later
can cause the consumer to be deferred indefinitely,
and the fact that in some cases, a probe deferral can be
avoided entirely if the real supplier device probes first.

Also, make sure that the device links are not handled earlier
than the fixup function for these cases.
Otherwise, before deferred probes are started again,
the link will be converted to sync-state only.

Signed-off-by: Michael Pratt <mcpratt@pm.me>
---
 drivers/base/base.h |  1 +
 drivers/base/core.c | 91 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/dd.c   |  2 +
 3 files changed, 94 insertions(+)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index eb4c0ace9242..96593650a861 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -229,6 +229,7 @@ bool device_links_busy(struct device *dev);
 void device_links_unbind_consumers(struct device *dev);
 void fw_devlink_drivers_done(void);
 void fw_devlink_probing_done(void);
+void device_links_fixup_suppliers(struct device *dev);
=20
 /* device pm support */
 void device_pm_move_to_tail(struct device *dev);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7f2652cf5edc..96edcd842b42 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1773,6 +1773,9 @@ static void fw_devlink_relax_link(struct device_link =
*link)
 =09if (device_link_flag_is_sync_state_only(link->flags))
 =09=09return;
=20
+=09if (link->supplier->fwnode && (link->supplier->fwnode->flags & FWNODE_F=
LAG_PARENT_IS_DEV))
+=09=09return;
+
 =09pm_runtime_drop_link(link);
 =09link->flags =3D DL_FLAG_MANAGED | FW_DEVLINK_FLAGS_PERMISSIVE;
 =09dev_dbg(link->consumer, "Relaxing link with %s\n",
@@ -2286,6 +2289,94 @@ static void fw_devlink_link_device(struct device *de=
v)
 =09mutex_unlock(&fwnode_link_lock);
 }
=20
+/**
+ * device_links_fixup_suppliers - Fix bad device links to suppliers of @de=
v.
+ * @dev: Consumer device.
+ *
+ * This should be called after the suppliers of @dev have a chance to form
+ * device links and @dev is probing so that, even if the consumer device
+ * has had it's fwtree parsed and it's attempt to probe started first,
+ * the suppliers are guaranteed to have an attempt at probing
+ * thanks to the dependency defined through the existing device links.
+ *
+ * In driver core, the suppliers have had an opportunity to probe at this =
point.
+ * Therefore, this is an ideal position to handle corner cases where,
+ * for whatever reason, the supplier is not optional, but the link to
+ * a supplier is bad and causing the probing of the consumer to defer.
+ * This is the last opportunity to handle a bad device link before
+ * that link will cause a probe defer of the consumer.
+ *
+ * If a fwnode link has not been translated to a device link at this point=
,
+ * or if a device link has not successfully resulted in the supplier probi=
ng,
+ * we know it is not possible for that node to represent a real device tha=
t
+ * provides functionality to the consumer, but an ancestor of that node mi=
ght be.
+ */
+void device_links_fixup_suppliers(struct device *dev)
+{
+=09struct fwnode_link *fwlink, *fwtmp;
+=09struct device_link *link, *tmp;
+
+=09mutex_lock(&fwnode_link_lock);
+=09device_links_write_lock();
+
+=09if (!dev->fwnode)
+=09=09goto no_fwnode;
+
+=09/* Keep flag checks in sync with fwnode_links_check_suppliers() */
+=09list_for_each_entry_safe(fwlink, fwtmp, &dev->fwnode->suppliers, c_hook=
) {
+=09=09if (fwlink->flags & FWLINK_FLAG_CYCLE)
+=09=09=09continue;
+
+=09=09/* The supplier may be a child fwnode of a device, if so, relink */
+=09=09if (fwlink->supplier->flags & FWNODE_FLAG_PARENT_IS_DEV) {
+=09=09=09dev_dbg(dev,
+=09=09=09=09"Linking to ancestor of fwnode %pfwf\n",
+=09=09=09=09fwlink->supplier);
+=09=09=09fwlink->supplier->flags |=3D FWNODE_FLAG_NOT_DEVICE;
+=09=09=09dev->fwnode->flags &=3D ~FWNODE_FLAG_LINKS_ADDED;
+=09=09=09__fwnode_link_del(fwlink);
+=09=09=09mutex_unlock(&fwnode_link_lock);
+=09=09=09device_links_write_unlock();
+=09=09=09fw_devlink_link_device(dev);
+=09=09=09mutex_lock(&fwnode_link_lock);
+=09=09=09device_links_write_lock();
+=09=09=09continue;
+=09=09}
+=09}
+
+no_fwnode:
+=09/* Keep flag checks in sync with device_links_check_suppliers() */
+=09list_for_each_entry_safe(link, tmp, &dev->links.suppliers, c_node) {
+=09=09if (!(link->flags & DL_FLAG_MANAGED))
+=09=09=09continue;
+
+=09=09if (link->status !=3D DL_STATE_AVAILABLE &&
+=09=09    !(link->flags & DL_FLAG_SYNC_STATE_ONLY)) {
+
+=09=09=09if (!dev->fwnode || !link->supplier->fwnode)
+=09=09=09=09continue;
+
+=09=09=09/* The supplier may be a child fwnode of a device, if so, relink =
*/
+=09=09=09if (link->supplier->fwnode->flags & FWNODE_FLAG_PARENT_IS_DEV) {
+=09=09=09=09dev_dbg(dev,
+=09=09=09=09=09"Linking to ancestor of %s\n",
+=09=09=09=09=09dev_name(link->supplier));
+=09=09=09=09link->supplier->fwnode->flags |=3D FWNODE_FLAG_NOT_DEVICE;
+=09=09=09=09dev->fwnode->flags &=3D ~FWNODE_FLAG_LINKS_ADDED;
+=09=09=09=09__device_link_del(&link->kref);
+=09=09=09=09mutex_unlock(&fwnode_link_lock);
+=09=09=09=09device_links_write_unlock();
+=09=09=09=09fw_devlink_link_device(dev);
+=09=09=09=09mutex_lock(&fwnode_link_lock);
+=09=09=09=09device_links_write_lock();
+=09=09=09=09continue;
+=09=09=09}
+=09=09}
+=09}
+=09mutex_unlock(&fwnode_link_lock);
+=09device_links_write_unlock();
+}
+
 /* Device links support end. */
=20
 int (*platform_notify)(struct device *dev) =3D NULL;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 85152537dbf1..24b8a506bc51 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -606,6 +606,8 @@ static int really_probe(struct device *dev, struct devi=
ce_driver *drv)
 =09=09=09   !drv->suppress_bind_attrs;
 =09int ret, link_ret;
=20
+=09device_links_fixup_suppliers(dev);
+
 =09if (defer_all_probes) {
 =09=09/*
 =09=09 * Value of defer_all_probes can be set only by
--=20
2.30.2



