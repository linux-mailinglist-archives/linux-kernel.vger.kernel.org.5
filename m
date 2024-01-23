Return-Path: <linux-kernel+bounces-34606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA318382C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD82E1F279F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E705F57B;
	Tue, 23 Jan 2024 01:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="aGnzN1SP"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57DD5EE70;
	Tue, 23 Jan 2024 01:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974450; cv=none; b=AXxjxReKSXmabEpt//fUIihtFNwnFv8xI7fy2neeYEAYhrF4pKDzd143dJpXaL7gazq9MSrem+O4DzIYCi3pT4u+4gODAMvJSPDkSaJQ7LYPVelsZ4PJhVZzCYKSfhV8/XG7q5XRNerTL8Yn3t9ch4EPV49eRhReiRXpG0VIZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974450; c=relaxed/simple;
	bh=fxYcyr7pTg3CIHphjSaf+5XlmBylc2uV3tWOoWgMT1I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFHlJ37ygjddoSbZoHmqzda3zN2X9vIXdh6AByykVyKkR/KZblpc0XHp7DaZfSuc0en2degbq3lvrMcc1wFqlifLajJ56RHQphS35VCo9Rzv18ixzf072soUu20lHjhqserL2e6AU9OyaNt+O4IgM5rYfLHkz42ntPOts/3kHQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=aGnzN1SP; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1705974445; x=1706233645;
	bh=fxYcyr7pTg3CIHphjSaf+5XlmBylc2uV3tWOoWgMT1I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aGnzN1SPVWxRuRi4Z7/2pPvz4qx+/sZqPAlwic66PqRSxOz12oLYuDGQ81TT554FJ
	 TC87LdXQB4+y5NNUcRyw+NUf1ATXMcvo60pdGxwkWaTxojIUnhUdqZDAAuQMdzMRm2
	 bkYw5wkE59UC79vNsYKEgfr/jb3crCY9wFBdB8WcdW0eF3nQO6gytc/kMFKAr4vvO/
	 yODQ/be5Z8x5JSbkUf3/0ITSXJAEsm7f/QcU442N1e1TNZ6hAvmfE7hDlybzHK4loE
	 ag2xjQmep00Z8ojpE+BUIKCKoG2hoVEpzH5DpbXa6HHKfgjBokN0IAnKlbp6WOhm69
	 zOQFz43uWo9dg==
Date: Tue, 23 Jan 2024 01:47:21 +0000
To: devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
From: Michael Pratt <mcpratt@pm.me>
Cc: Michael Pratt <mcpratt@pm.me>, saravanak@google.com, abel.vesa@linaro.org, alexander.stein@ew.tq-group.com, andriy.shevchenko@linux.intel.com, bigunclemax@gmail.com, brgl@bgdev.pl, colin.foster@in-advantage.com, djrscally@gmail.com, dmitry.baryshkov@linaro.org, festevam@gmail.com, fido_max@inbox.ru, frowand.list@gmail.com, geert@linux-m68k.org, heikki.krogerus@linux.intel.com, kernel@pengutronix.de, linus.walleij@linaro.org, linux@roeck-us.net, luca.weiss@fairphone.com, magnus.damm@gmail.com, martin.kepplinger@puri.sm, miquel.raynal@bootlin.com, rafal@milecki.pl, ansuelsmth@gmail.com, richard@nod.at, sakari.ailus@linux.intel.com, sudeep.holla@arm.com, tglx@linutronix.de, tony@atomide.com, vigneshr@ti.com, dianders@chromium.org, jpb@kernel.org, rafael@kernel.org
Subject: [PATCH v1 4/4] mtd: mtdpart: Allow fwnode links to NVMEM compatible fwnodes
Message-ID: <20240123014517.5787-5-mcpratt@pm.me>
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

This reverts commit fb42378dcc7f247df56f0ecddfdae85487495fbc
("mtd: mtdpart: Don't create platform device that'll never probe").

That commit is a manual named exception in order to avoid fw_devlink links
to an "nvmem-cells" compatible node which is a descendant of the fwnode
that represents the real supplier device that probes.

The commit does not work for newer cases, like the "fixed-layout"
compatible nodes, but instead of adding another compatible string,
remove this workaround as it is no longer needed after
the previous few commits which handle the situation in a generic way
for all supplier nodes that are a child or further descendant fwnode
of a parent device that can probe, including when the consumer device
has a probe attempt before the supplier device, by using an existing
incorrect fwnode or device link to recreate the correct one.

Signed-off-by: Michael Pratt <mcpratt@pm.me>
---
 drivers/mtd/mtdpart.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 6811a714349d..dd2b27674f56 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -582,7 +582,6 @@ static int mtd_part_of_parse(struct mtd_info *master,
 {
 =09struct mtd_part_parser *parser;
 =09struct device_node *np;
-=09struct device_node *child;
 =09struct property *prop;
 =09struct device *dev;
 =09const char *compat;
@@ -600,15 +599,6 @@ static int mtd_part_of_parse(struct mtd_info *master,
 =09else
 =09=09np =3D of_get_child_by_name(np, "partitions");
=20
-=09/*
-=09 * Don't create devices that are added to a bus but will never get
-=09 * probed. That'll cause fw_devlink to block probing of consumers of
-=09 * this partition until the partition device is probed.
-=09 */
-=09for_each_child_of_node(np, child)
-=09=09if (of_device_is_compatible(child, "nvmem-cells"))
-=09=09=09of_node_set_flag(child, OF_POPULATED);
-
 =09of_property_for_each_string(np, "compatible", prop, compat) {
 =09=09parser =3D mtd_part_get_compatible_parser(compat);
 =09=09if (!parser)
--=20
2.30.2



