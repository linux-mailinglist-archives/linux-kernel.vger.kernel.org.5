Return-Path: <linux-kernel+bounces-52868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68635849D9E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED0F286BBB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF292C6A6;
	Mon,  5 Feb 2024 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lf3Rbl7P"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714E32C69F;
	Mon,  5 Feb 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145224; cv=none; b=QhbOyXFwfaA0baIMrZ/P8qUrtCRvyGaHSvEItqTNh2PnlMAPn6lpR+Dzs8XPRRUNRz1nuNQD11tkKTovBwntxW+kgl1BdyFUjMcm5eAswdAtne/R7WrYOpLTc1yBLnVBJZRsws7vloCM/JRLMZRJ01Y1qFygpbqxqRZ8xsr6sVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145224; c=relaxed/simple;
	bh=ve1L7CJmm2ZDVFsiashWwCWlGeakd6/4ipF1GmNi4hg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VxXr1vYX9zLf2os1JLl4e1LVHyys4VkNOr9BL6UuecrgSlCMnHCwsjZMCQj0ndrL6R7Zo4KXVsCZB+yfcCqiG9Cc+rVLJPCYk8u7Ki9yZb1UNaM0tY00gHvjlXLYsgogfFznbeTt6aluz2JDF/VqjIqmkxVmN0BjJzqllZxNL5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lf3Rbl7P; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 678FA60017;
	Mon,  5 Feb 2024 15:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707145218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1WPodUhe/h+mqC6ZYnqckKI3xdNBGby9JuWEoJjCPXA=;
	b=Lf3Rbl7PyJ+xoxB5TMoTgADhXfAF+j3HyBn3Fd54N2T0hcnu2H+XNimSgEoJ28iOJNa52i
	BP8f8r3mm8ivXD5O95q2aUQ9MddM6hq/7yNLrGENLJoZrAcqFAKAES98soOM5Sp8k1VvrD
	XccJAMcJ7NF+HtHUfXTjbCrwiquhg+AuVDYOxhSeImQzbUu6wxERIW+YrevxKh8hCjWPdM
	HxFJ2dI4G7z1LjLd/f6IveA0Cv0WMEAstuJsFR4TXWVbYjh1vP0bAimJdX5Y3n7+lriAjN
	VxlcFjpralO/VadvUCI2Sv9VnSm+op07LZyouk71uEbrA6jGV/MEIiw+0p5yUQ==
Date: Mon, 5 Feb 2024 16:00:11 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michael Pratt <mcpratt@pm.me>
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 saravanak@google.com, abel.vesa@linaro.org,
 alexander.stein@ew.tq-group.com, andriy.shevchenko@linux.intel.com,
 bigunclemax@gmail.com, brgl@bgdev.pl, colin.foster@in-advantage.com,
 djrscally@gmail.com, dmitry.baryshkov@linaro.org, festevam@gmail.com,
 fido_max@inbox.ru, frowand.list@gmail.com, geert@linux-m68k.org,
 heikki.krogerus@linux.intel.com, kernel@pengutronix.de,
 linus.walleij@linaro.org, linux@roeck-us.net, luca.weiss@fairphone.com,
 magnus.damm@gmail.com, martin.kepplinger@puri.sm, rafal@milecki.pl,
 ansuelsmth@gmail.com, richard@nod.at, sakari.ailus@linux.intel.com,
 sudeep.holla@arm.com, tglx@linutronix.de, tony@atomide.com,
 vigneshr@ti.com, dianders@chromium.org, jpb@kernel.org, rafael@kernel.org
Subject: Re: [PATCH v1 2/4] driver core: fw_devlink: Link to supplier
 ancestor if no device
Message-ID: <20240205160011.42d1cf80@xps-13>
In-Reply-To: <20240123014517.5787-3-mcpratt@pm.me>
References: <20240123014517.5787-1-mcpratt@pm.me>
 <20240123014517.5787-3-mcpratt@pm.me>
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
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Michael,

First, I want to say, this is a great job as fw_devlinks in mtd and
nvmem are really not easy to handle. I am willing to help, despite my
very light understanding of what the core actually does with these
flags.

mcpratt@pm.me wrote on Tue, 23 Jan 2024 01:46:40 +0000:

> Driver core currently supports linking to the next parent fwnode,
> but is not yet handling cases where that parent
> is also a firmware child node not representing a real device,
> which can lead to an indefinite deferred probe in some cases.
> In this case, the fwnode that should actually be linked to
> is multiple ancestors up which presents a challenge where
> it is unknown how many ancestors up the node that
> represents the real probing device is. This makes the usage of
> fwnode_get_next_parent_dev() insufficient because the real device's
> fwnode may or may not be an ancestor of the next parent fwnode as well.
>=20
> Introduce flag FWNODE_FLAG_PARENT_IS_DEV
> in order to mark child firmware nodes of a device
> as having a parent device that can probe.
>=20
> Allow fwnode link creation to the original supplier fwnode's ancestors
> when the original supplier fwnode and any fwnodes in between are flagged
> as FWNODE_FLAG_NOT_DEVICE and/or FWNODE_FLAG_PARENT_IS_DEV
> with a new function __fwnode_link_add_parents() which then creates
> the fwnode link to a real device that provides the supplier's function.
>=20
> This depends on other functions to label a supplier fwnode
> as not a real device, which must be done before the fwnode links
> are created, and if after that, relevant links to the supplier
> would have to be deleted and have links recreated, otherwise,
> the fwnode link would be dropped before the device link is attempted
> or a fwnode link would not be able to become a device link at all,
> because they were created before these fwnode flags can have any effect.
>=20
> It also depends on the supplier device to actually probe first
> in order to have the fwnode flags in place to know for certain
> which fwnodes are non-probing child nodes
> of the fwnode for the supplier device.
>=20
> The use case of function __fw_devlink_pickup_dangling_consumers()
> is designed so that the parameters are always a supplier fwnode
> and one of it's parent fwnodes, so it is safer to assume and more specific
> that the flag PARENT_IS_DEV should be added there, rather than
> declaring the original supplier fwnode as NOT_DEVICE at that point.
> Because this function is called when the real supplier device probes
> and recursively calls itself for all child nodes of the device's fwnode,
> set the new flag here in order to let it propagate down
> to all descendant nodes, thereby providing the info needed later
> in order to link to the proper fwnode representing the supplier device.
>=20
> If a fwnode is flagged as FWNODE_FLAG_NOT_DEVICE
> by the time a device link is to be made with it,
> but not flagged as FWNODE_FLAG_PARENT_IS_DEV,
> the link is dropped, otherwise the device link
> is still made with the original supplier fwnode.
> Theoretically, we can also handle linking to an ancestor
> of the supplier fwnode when forming device links, but there
> are still cases where the necessary fwnode flags are still missing
> because the real supplier device did not probe yet.

I am not sure I follow this. In the following case, I would expect any
dependency towards node-c to be made against node-a. But the above
paragraph seems to tell otherwise: that the the link would be dropped
(and thus, not enforced) because recursively searching for a parent
that would be a device could be endless? It feels wrong, so I probably
mis

node-a {
	# IS DEV
	node-b {
		# PARENT IS DEV
		node-c {
			# PARENT IS DEV
		};
	};
};

Besides that, the commit feels like a good idea.

Thanks,
Miqu=C3=A8l

