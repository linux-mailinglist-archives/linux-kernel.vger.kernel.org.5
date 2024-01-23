Return-Path: <linux-kernel+bounces-34601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C29838281
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D7E285CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0775C8E1;
	Tue, 23 Jan 2024 01:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ZmOMA9SE"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585B5BAFD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974370; cv=none; b=MXbCk22DIKibISSHxqBsWlKCVeEDv+UkOC8B0ZUVtwdcYMGcBtleBs1577jIHNT+v2D9Mx6ggH4zNxH8OQYkMXIeaViIkyOIh4E+h66PofjQG/s5G0Xbmf8Jew7QaJTREP6BB3+29WUu9GWDQaknKX6/mV2x8t5ob+P5KKAyxVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974370; c=relaxed/simple;
	bh=qyuUV4biQ9BgcZ062xbxtCnTDimYnE9pTcwOc+yL45M=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=R8AyTCBhfvmqtHe7ARzR7KanYnD8ZgMAD5Wy8bxymFmGXDpdc55I+rU7Z+W/9u9A1/IWSHzv0pYEN5esboc3zFn5kdMErucLuqYgrvNXCSDcdrbWpZkiU6RvHbqNFFPk8acwsDSku5jz/HM+oemr0bQ+p4EK86USvUhjcl6oLfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ZmOMA9SE; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1705974359; x=1706233559;
	bh=mcnYv4ICnO11P0Sn1Sa919eKhcJsfwhNHOsnLcCSFLU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ZmOMA9SEjwO5R/DphCqeNUxcfZ0eau0G2khHbnS+2J0y93asuCsTrmjKIJDAevRu2
	 H5Z/UBaA4U+RI3IwWSfsQUwOKUjJ+NvX1XnPDOC6q6nKQvjW0EgdXshqA9A4VYeHht
	 secP1ACWeMucxCpK3VmcbrL1GFbGnZZCIQyvLyRBer8Zue2pPpo8UF78fFrEv73OMt
	 zjKz3tcR0cfj/1q5ErRk/ssYn+lTbTHe9y465UnTtLcXn95apE/iVi8xHOstlEDDaz
	 zB+E4chA+Ds7S82Mg2Lbj/qOpgNYs4/eLZCC9pSfKtrT724YgSWHFFziWKwrOLVELF
	 vKIug3QMKOKMg==
Date: Tue, 23 Jan 2024 01:45:48 +0000
To: devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
From: Michael Pratt <mcpratt@pm.me>
Cc: Michael Pratt <mcpratt@pm.me>, saravanak@google.com, abel.vesa@linaro.org, alexander.stein@ew.tq-group.com, andriy.shevchenko@linux.intel.com, bigunclemax@gmail.com, brgl@bgdev.pl, colin.foster@in-advantage.com, djrscally@gmail.com, dmitry.baryshkov@linaro.org, festevam@gmail.com, fido_max@inbox.ru, frowand.list@gmail.com, geert@linux-m68k.org, heikki.krogerus@linux.intel.com, kernel@pengutronix.de, linus.walleij@linaro.org, linux@roeck-us.net, luca.weiss@fairphone.com, magnus.damm@gmail.com, martin.kepplinger@puri.sm, miquel.raynal@bootlin.com, rafal@milecki.pl, ansuelsmth@gmail.com, richard@nod.at, sakari.ailus@linux.intel.com, sudeep.holla@arm.com, tglx@linutronix.de, tony@atomide.com, vigneshr@ti.com, dianders@chromium.org, jpb@kernel.org, rafael@kernel.org
Subject: [PATCH v1 0/4] fw_devlink: generically handle bad links to child fwnodes
Message-ID: <20240123014517.5787-1-mcpratt@pm.me>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

First off, if you are CC'ed here, it's likely because you were
involved in or CC'ed in a patch series by Saravana Kannan for fw_devlink,
and for consistency, I'm kindly asking for review from you all as well.
If you think this may not affect your use cases, feel free to ignore this.
I'm also CC'ing Christian and Rafal from the Openwrt project.

This series is following up on some excellent work from Saravana [1]
which is another patch series that includes some changes
that helped make it possible for fw_devlink to work with MTD partitions
that are a supplier fwnode by being a NVMEM provider. For an MTD partition
to become an NVMEM provider, it must be registered as a platform device
using of_platform_populate() or similar function
which was done in a previous commit [2]
but this also resulted in fw_devlink to apply
to those fwnodes and their child fwnodes.

That regression caused consumer devices to defer indefinitely
while waiting for probing that will never happen or for device links
to form from fwnode links with fwnodes that are not associated
with any real device or driver that probes
(e.g. describing the location of a MAC address).

Saravana's patch series helped in two ways:
First, by moving consumers from a child fwnode (in this case,
the "nvmem-cells" compatible node) to an ancestor fwnode
that represents the actual supplier device when that device probes,
which handles the case where
the supplier device has a probe attempt first. [3] [4]
And secondly, by specifically marking "nvmem-cells" compatible nodes
as populated during MTD partition parsing which also occurs during
the supplier device probe, which handles both cases of initial probe order,
but only for that node type. [5]

However, there's some drawbacks to the second solution
from having to manually name which nodes need the workaround
for the corner case with the compatible string.
Most notably, that it's possible for this corner case
to apply to other nodes types, but also the fact that initial probe order
deciding whether or not everything probes in the intended order, if at all,
through driver core alone is still an issue with fw_devlink,
despite the fact that controlling probe order in driver core
is one of it's goals. In other words, the real problem is in driver core,
but the fix is in the mtd driver.

Unfortunately, with the Openwrt project
we are experiencing this regression again
by implementing the new NVMEM layout "fixed-layout"
after it was accepted into the kernel. [6]
This causes some subsystems of an SOC, like
ethernet or wireless or both depending on hardware and DTS,
and in some cases a completely different function like USB
to never probe once again, and the temporary fix, like before,
is by disabling fw_devlink. [7]

Below is a simplified DTS of an Atheros device with the NVMEM layout:


&eth0 {
=09nvmem-cells =3D <&macaddr_art_0>;
=09nvmem-cell-names =3D "mac-address";
};

&wifi {
=09nvmem-cells =3D <&caldata_art_1000>;
=09nvmem-cell-names =3D "calibration";
};

&spi {
=09status =3D "okay";

=09flash@0 {
=09=09compatible =3D "jedec,spi-nor";

=09=09partitions {
=09=09=09compatible =3D "fixed-partitions";

=09=09=09partition@ff0000 {
=09=09=09=09label =3D "art";
=09=09=09=09reg =3D <0xff0000 0x010000>;
=09=09=09=09read-only;

=09=09=09=09nvmem-layout {
=09=09=09=09=09compatible =3D "fixed-layout";

=09=09=09=09=09macaddr_art_0: macaddr@0 {
=09=09=09=09=09=09reg =3D <0x0 0x6>;
=09=09=09=09=09};

=09=09=09=09=09caldata_art_1000: caldata@1000 {
=09=09=09=09=09=09reg =3D <0x1000 0x440>;
=09=09=09=09=09};
=09=09=09=09};
=09=09=09};
=09=09};
=09};
};


When the DTS is written this way, not only is there a different node
involved for NVMEM, but this node is a new node that is yet another
descendant in the tree. In other words, the "partition@ff0000" node
used to be what designated this device as the NVMEM provider
with the "nvmem-cells" compatible, so the node that represents
the actual probing device is now 4 parent nodes up in the tree
in this example instead of 3 parent nodes up in the tree as before.

For the past year, and even before the "fixed-layout" issue came up,
I had been experimenting with a way to handle these reverse probe order
and linking of distant descendant node issues in a generic way instead of
naming exceptions with the compatible string, and this series is the
culmination of those efforts. It may look strange at first,
but there are a myriad set of cases to handle and other reasons
that led me to develop this approach of using existing bad device links
in order to find the correct fwnode to link to, and then redo
the relevant links for that consumer device altogether.
I'm concerned that doing this another way would be a much more massive
project that would basically rewrite what the fw_devlink feature does.
Or perhaps there would have to be a new, third form of device links
that would be a "placeholder" before it becomes a fwnode link.
Eventually, I came to the conclusion that
there simply is not enough information to form the correct fwnode link
before the real supplier device has a successful probe.

Some of the changes proposed here are made on the extreme side of caution,
for example, checking for null dereference when it might not be necessary,
and reducing the activity of some functions in order to reduce
the amount of assumptions taking place in the middle of driver core
in cases where the new functions proposed here handles that just as well
and closer to a possible probe defer event
(e.g. not declaring a fwnode as NOT_DEVICE before
a probe attempt is expected to have happened).

I have tried to make the commit messages as self-explanatory as I can,
but they might have ended up a little too verbose, and therefore confusing
but I'm ready to explain whatever has not been explained well already.
Lastly, this is my first attempt at sending a larger change to the kernel,
so I appreciate your time and patience very much.

MCP


[1] https://lore.kernel.org/lkml/20230207014207.1678715-1-saravanak@google.=
com/

[2] bcdf0315a61a29eb753a607d3a85a4032de72d94

[3] 3a2dbc510c437ca392516b0105bad8e7970e6614

[4] 411c0d58ca6faa9bc4b9f5382118a31c7bb92a6f

[5] fb42378dcc7f247df56f0ecddfdae85487495fbc

[6] 27f699e578b1a72df89dfa3bc42e093a01dc8d10

[7] https://github.com/openwrt/openwrt/commit/703d667a0cdf6dfa402c08e72d0c7=
7a257ca5009


Michael Pratt (4):
  driver core: fw_devlink: Use driver to determine probe ability
  driver core: fw_devlink: Link to supplier ancestor if no device
  driver core: fw_devlink: Add function device_links_fixup_suppliers()
  mtd: mtdpart: Allow fwnode links to NVMEM compatible fwnodes

 drivers/base/base.h    |   1 +
 drivers/base/core.c    | 144 ++++++++++++++++++++++++++++++++++++++---
 drivers/base/dd.c      |   2 +
 drivers/mtd/mtdpart.c  |  10 ---
 include/linux/fwnode.h |   4 ++
 5 files changed, 143 insertions(+), 18 deletions(-)


base-commit: b0d326da462e20285236e11e4cbc32085de9f363
--
2.30.2



