Return-Path: <linux-kernel+bounces-7343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36F681A62C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0477F1C24989
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4263E47A42;
	Wed, 20 Dec 2023 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Mp+Uy0Gj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3374777A;
	Wed, 20 Dec 2023 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14926E0006;
	Wed, 20 Dec 2023 17:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703092590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2v8j8FMGgvlnwys74dv3ie6XPojNdA6uGhHbiuXVbM=;
	b=Mp+Uy0GjnJBMED9RCwpywpUuXmmLPlMR1gB21k7VDUHUFvAe7kW8n8KMv9Kg0lRwmAx4rL
	NwU1rhC2WsSPwiZZ49eKdpSyZfd8wwA+WzGnpySWEQo9+9ENmTdqSFwW2dJloEBymJKypL
	M1Pj1Lno0kbkN8p2lWzC6VxmfqFrUDCElBH8n6rviqv3GBBcGorfCRneHZfLqd4ckko+aQ
	i8QyeeYooRCtJCLiP7iG1littaYX1eo/PJ6HejqDXJfHbCPkbCSiKqeskoQVsv57wkm3E6
	uje/RV5oUrWA3gxm0ODZJ4cm808LQ+1N02GRCXEdzoxXZz5Lp/drGrmVPAMhoA==
Date: Wed, 20 Dec 2023 18:16:27 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Lizhi Hou
 <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 0/2] Synchronize DT overlay removal with devlink
 removals
Message-ID: <20231220181627.341e8789@booty>
In-Reply-To: <CAGETcx-F8G3dcN-VTMrbya_=19zXP=S2ORA_qZqy+yND7S41_Q@mail.gmail.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	<20231206171540.GA2697853-robh@kernel.org>
	<CAGETcx-F8G3dcN-VTMrbya_=19zXP=S2ORA_qZqy+yND7S41_Q@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Saravana, Rob, Herv=C3=A9,

[+Miqu=C3=A8l, who contributed to the discussion with Herv=C3=A9 and me]

On Wed, 6 Dec 2023 19:09:06 -0800
Saravana Kannan <saravanak@google.com> wrote:

> On Wed, Dec 6, 2023 at 9:15=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
> >
> > On Thu, Nov 30, 2023 at 06:41:07PM +0100, Herve Codina wrote: =20
> > > Hi, =20
> >
> > +Saravana for comment =20
>=20
> I'll respond to this within a week -- very swamped at the moment. The
> main thing I want to make sure is that we don't cause an indirect
> deadlock with this wait(). I'll go back and look at why we added the
> work queue and then check for device/devlink locking issues.

While working on a project unrelated to Herv=C3=A9's work, I also ended up
in getting sporadic but frequent "ERROR: memory leak, expected refcount
1 instead of..." messages, which persisted even after adding this patch
series on my tree.

My use case is the insertion and removal of a simple overlay describing
a regulator-fixed and an I2C GPIO expander using it. The messages appear
regardless of whether the insertion and removal is done from kernel code
or via the configfs interface (out-of-tree patches from [0]).

I reconstructed the sequence of operations, all of which stem from
of_overlay_remove():

int of_overlay_remove(int *ovcs_id)
{
    ...

    device_link_wait_removal(); // proposed by this patch series

    mutex_lock(&of_mutex);

    ...

    ret =3D __of_changeset_revert_notify(&ovcs->cset);
    // this ends up calling (excerpt from a long stack trace):
    // -> of_i2c_notify
    // -> device_remove
    // -> devm_regulator_release
    // -> device_link_remove
    // -> devlink_dev_release, which queues work for
    //      device_link_release_fn, which in turn calls:
    //      -> device_put
    //      -> device_release
    //      -> {platform,regulator,...}_dev*_release
    //      -> of_node_put() [**]

    ...

    free_overlay_changeset(ovcs);
    // calls:
    // -> of_changeset_destroy
    // -> __of_changeset_entry_destroy
    // -> pr_err("ERROR: memory leak, expected refcount 1 instead of %d...
    // The error appears or not, based on when the workqueue runs

err_unlock:
    mutex_unlock(&of_mutex);

    ...
}

So this adds up to the question of whether devlink removal should actually
be run asynchronously or not.

A simple short-term solution is to move the call to
device_link_wait_removal() later, just before free_overlay_changeset():


diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 1a8a6620748c..eccf08cf2160 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -1375,12 +1375,6 @@ int of_overlay_remove(int *ovcs_id)
 		goto out;
 	}
=20
-	/*
-	 * Wait for any ongoing device link removals before removing some of
-	 * nodes
-	 */
-	device_link_wait_removal();
-
 	mutex_lock(&of_mutex);
=20
 	ovcs =3D idr_find(&ovcs_idr, *ovcs_id);
@@ -1427,6 +1421,14 @@ int of_overlay_remove(int *ovcs_id)
 		if (!ret)
 			ret =3D ret_tmp;
=20
+	/*
+	 * Wait for any ongoing device link removals before removing some of
+	 * nodes
+	 */
+	mutex_unlock(&of_mutex);
+	device_link_wait_removal();
+	mutex_lock(&of_mutex);
+
 	free_overlay_changeset(ovcs);
=20
 err_unlock:


This obviously raises the question of whether unlocking and re-locking
the mutex is potentially dangerous. I have no answer to this right away,
but I tested this change with CONFIG_PROVE_LOCKING=3Dy and no issue showed
up after several overlay load/unload sequences so I am not aware of any
actual issues with this change.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.g=
it/log/?h=3Dtopic/overlays

Luca
--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

