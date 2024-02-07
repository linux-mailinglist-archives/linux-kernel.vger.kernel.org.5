Return-Path: <linux-kernel+bounces-57129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43EE84D44F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE2E286065
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239C514FFA5;
	Wed,  7 Feb 2024 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIraho5s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E7C14FF8D;
	Wed,  7 Feb 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341056; cv=none; b=Z2lSO0kK/Z50jU/+F6+Dz+NLz9OAq1ry6OOHoQvRM/wsQPcdvuLgW1r9BiEqPSc4Ueihnsu/2b+u+8/9zqY4Q/w3Va1luOXdSrdeWoAHxr4q+0j0A9Xey7ajmkF5k3ruAgaY/p/jVJIjQualXpjHEjn72xYojSJ/aqDLCDLn2OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341056; c=relaxed/simple;
	bh=xD7h6kS43z3E7rm1p4ubRVHLoBhiPX+EKNxAczT8Weg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t58VhM/Ae1OZm0j+1hGVz4aDmw6jF5LPg/kQD/uh9Dt0wtu7nSVX3MMKbY2W1gXLEyscfFNMjkZN/DIwBbd+h78couAH0HK5wWJq1SopaZMXX1gWzP6Hx0Dgxi53P7VkeIh/xy5I7bV6JuIWBW7sJNOs0zNe6PoZ0qIZ8LZbkIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIraho5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF968C43390;
	Wed,  7 Feb 2024 21:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341056;
	bh=xD7h6kS43z3E7rm1p4ubRVHLoBhiPX+EKNxAczT8Weg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIraho5stjz5+/cui0sjuKHGAtpgx49pEEHta8c9U7gC685vociFiFrp7Csw/vbaT
	 1PqchR5aemRrGxsN8/7/fwcBtKQvvJcdQbutZR/Qy9yHxE0DEqMbkT6Qlsbxd5LG+L
	 ukWKqX915sJZkn7MD1LDfcBzXCik3zx5Ohakq4/EsWNAs08nCHPS8GiifIkbs6Hhpz
	 1YdDu0wqJbL5k6nZ+PV7cg/LFrXnWbK90XG069k6g1wO/FE0wFvOwsg6zmsfMJ9U0e
	 yYGexN5c35URXVHe1pe9JWxMK7cqD90GCp5UGJDb2aFUZGKpCgyKfaJg6snDFrGgCv
	 wDHtYwaJm3AUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brenton Simpson <appsforartists@google.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	vi@endrift.com,
	swyterzone@gmail.com,
	carl.ng@hp.com,
	matthias.benkmann@gmail.com,
	luca@z3ntu.xyz,
	christophe.jaillet@wanadoo.fr,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 19/38] Input: xpad - add Lenovo Legion Go controllers
Date: Wed,  7 Feb 2024 16:23:05 -0500
Message-ID: <20240207212337.2351-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Brenton Simpson <appsforartists@google.com>

[ Upstream commit 80441f76ee67002437db61f3b317ed80cce085d2 ]

The Lenovo Legion Go is a handheld gaming system, similar to a Steam Deck.
It has a gamepad (including rear paddles), 3 gyroscopes, a trackpad,
volume buttons, a power button, and 2 LED ring lights.

The Legion Go firmware presents these controls as a USB hub with various
devices attached.  In its default state, the gamepad is presented as an
Xbox controller connected to this hub.  (By holding a combination of
buttons, it can be changed to use the older DirectInput API.)

This patch teaches the existing Xbox controller module `xpad` to bind to
the controller in the Legion Go, which enables support for the:

- directional pad,
- analog sticks (including clicks),
- X, Y, A, B,
- start and select (or menu and capture),
- shoulder buttons, and
- rumble.

The trackpad, touchscreen, volume controls, and power button are already
supported via existing kernel modules.  Two of the face buttons, the
gyroscopes, rear paddles, and LEDs are not.

After this patch lands, the Legion Go will be mostly functional in Linux,
out-of-the-box.  The various components of the USB hub can be synthesized
into a single logical controller (including the additional buttons) in
userspace with [Handheld Daemon](https://github.com/hhd-dev/hhd), which
makes the Go fully functional.

Signed-off-by: Brenton Simpson <appsforartists@google.com>
Link: https://lore.kernel.org/r/20240118183546.418064-1-appsforartists@google.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index e2c1848182de..d0bb3edfd0a0 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -294,6 +294,7 @@ static const struct xpad_device {
 	{ 0x1689, 0xfd00, "Razer Onza Tournament Edition", 0, XTYPE_XBOX360 },
 	{ 0x1689, 0xfd01, "Razer Onza Classic Edition", 0, XTYPE_XBOX360 },
 	{ 0x1689, 0xfe00, "Razer Sabertooth", 0, XTYPE_XBOX360 },
+	{ 0x17ef, 0x6182, "Lenovo Legion Controller for Windows", 0, XTYPE_XBOX360 },
 	{ 0x1949, 0x041a, "Amazon Game Controller", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0002, "Harmonix Rock Band Guitar", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
@@ -491,6 +492,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x15e4),		/* Numark Xbox 360 controllers */
 	XPAD_XBOX360_VENDOR(0x162e),		/* Joytech Xbox 360 controllers */
 	XPAD_XBOX360_VENDOR(0x1689),		/* Razer Onza */
+	XPAD_XBOX360_VENDOR(0x17ef),		/* Lenovo */
 	XPAD_XBOX360_VENDOR(0x1949),		/* Amazon controllers */
 	XPAD_XBOX360_VENDOR(0x1bad),		/* Harmonix Rock Band guitar and drums */
 	XPAD_XBOX360_VENDOR(0x20d6),		/* PowerA controllers */
-- 
2.43.0


