Return-Path: <linux-kernel+bounces-34603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D7683829F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED601F26B47
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1842C5D913;
	Tue, 23 Jan 2024 01:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="SNycMXJi"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3B55C915;
	Tue, 23 Jan 2024 01:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974394; cv=none; b=QIiO5X/y9cZyu97HLnd7h2UJjZ0NMwY3xYOjt5tZ3tFGfdfNoamZXqTLw2tBQ1f17ZUN3hk6dABdseboDiqxX38JAjM1ufDWiKgeV0KB858zqVqHgucGxEyTMkonQgHsX60ugcQ1xU48wUwglNaLPbYNOkdC6tD0Pwdn360oB30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974394; c=relaxed/simple;
	bh=pwOutDgsaOegGCSIfH5khD+lu5VfQJ7Oz385mgijIF4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzbbnYKNZGVw9LDyX6dhRR5rS54L4aoxzSveWVN1ZBi5v+4XuRp6HMh6DseFmRY5QVWydLIvsN7Xn/w6s2yKrjnsk+GTYYLHE3N2V/fJyoLMdpS1WhX9ABaWeJfJR6WEsJaIaSIBvI/Pbgjhth+6BKV3h9jD/jqejp+fqd3DwKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=SNycMXJi; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1705974384; x=1706233584;
	bh=W9fDeKvWcAx5zWuX6Ptj6h/hvIvYxgy0niruIGIV07k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SNycMXJi1xUXbudVK27K6Ff/w7QHAB+U/PohdYu5wEEP8rtIlEBoxxf1fyWL1PEIE
	 Nzl5I0slsPCV3rhtk5v8BMe5DglfMbHSZPjNHd22ISVeAYslobFD0dSK7VI7Myv/ZY
	 mGH/bn4Toh7tVHaLFBgjLwP2VLTyJL6d39sTDIJXyrcu3bO1DXI8K4PD3i09jWUl6c
	 qCkmvqSxF/ci+kJ7dD8Rv3tx9EMhi7ttBhJ1qgaA6X6WrYQYXIS/OtvizZEPsFcwV2
	 xO73OCxrLMXVS0qu4NwT6zgt9vfN2tvjaSlRLBsj/v9XsCWmY1taIer0hIVK7r9UwF
	 gBozSVS8Gxxww==
Date: Tue, 23 Jan 2024 01:46:18 +0000
To: devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
From: Michael Pratt <mcpratt@pm.me>
Cc: Michael Pratt <mcpratt@pm.me>, saravanak@google.com, abel.vesa@linaro.org, alexander.stein@ew.tq-group.com, andriy.shevchenko@linux.intel.com, bigunclemax@gmail.com, brgl@bgdev.pl, colin.foster@in-advantage.com, djrscally@gmail.com, dmitry.baryshkov@linaro.org, festevam@gmail.com, fido_max@inbox.ru, frowand.list@gmail.com, geert@linux-m68k.org, heikki.krogerus@linux.intel.com, kernel@pengutronix.de, linus.walleij@linaro.org, linux@roeck-us.net, luca.weiss@fairphone.com, magnus.damm@gmail.com, martin.kepplinger@puri.sm, miquel.raynal@bootlin.com, rafal@milecki.pl, ansuelsmth@gmail.com, richard@nod.at, sakari.ailus@linux.intel.com, sudeep.holla@arm.com, tglx@linutronix.de, tony@atomide.com, vigneshr@ti.com, dianders@chromium.org, jpb@kernel.org, rafael@kernel.org
Subject: [PATCH v1 1/4] driver core: fw_devlink: Use driver to determine probe ability
Message-ID: <20240123014517.5787-2-mcpratt@pm.me>
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

The function __fw_devlink_pickup_dangling_consumers()
intends to ignore suppliers that are already capable of probing,
but uses whether or not a bus struct is defined in the device struct.

There are some cases where a firmware child node
can be address translatable but not able to probe
(e.g. the use of of_platform_populate() for MTD partitions),
so whether or not a driver is present is a more accurate way
to guess whether a fwnode represents a real probing device here.

This also serves as a preparation step for further changes
to fw_devlink including making the contents of this function
less strict in order to compensate for more cases being passed into
the rest of the function because the return case is now more strict.

"Hey! Who's driving the bus?"

Signed-off-by: Michael Pratt <mcpratt@pm.me>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14d46af40f9a..c05a5f6b0641 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -214,7 +214,7 @@ static void __fwnode_links_move_consumers(struct fwnode=
_handle *from,
  * @new_sup: fwnode of new supplier
  *
  * If the @fwnode has a corresponding struct device and the device support=
s
- * probing (that is, added to a bus), then we want to let fw_devlink creat=
e
+ * probing (that is, bound to a driver), then we want to let fw_devlink cr=
eate
  * MANAGED device links to this device, so leave @fwnode and its descendan=
t's
  * fwnode links alone.
  *
@@ -225,7 +225,7 @@ static void __fw_devlink_pickup_dangling_consumers(stru=
ct fwnode_handle *fwnode,
 {
 =09struct fwnode_handle *child;
=20
-=09if (fwnode->dev && fwnode->dev->bus)
+=09if (fwnode->dev && fwnode->dev->driver)
 =09=09return;
=20
 =09fwnode->flags |=3D FWNODE_FLAG_NOT_DEVICE;
--=20
2.30.2



