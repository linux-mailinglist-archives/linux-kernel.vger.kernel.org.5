Return-Path: <linux-kernel+bounces-57086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC0884D3E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3778B2826B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87C3137C37;
	Wed,  7 Feb 2024 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4tBJI61"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EAF137C2D;
	Wed,  7 Feb 2024 21:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340945; cv=none; b=nm0mkOsz2hVoS9/mUyK6G7m5IFhTzqu98KYCFflF85udXGSGNaMKuqcqP9+Id8eY5RZHR95oOD/U42tJNBZT6yhP4u5nfHRDZcR9i0KxdCruoTn8pTCzhzM4ASmE2wIrcK7sOmHl2bj3JZwiHV26hIhKm2BOG2TLL9E1vbvc42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340945; c=relaxed/simple;
	bh=xD7h6kS43z3E7rm1p4ubRVHLoBhiPX+EKNxAczT8Weg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9zuiwXO1GSPznjMl5lDTWp//WHTD7DJl9JSF+YrND12WRHh6V4nRyC3MOuLkeAaRUgf9MMcLHsqN/Q6sRvRdoFqAro1B6kKx3a4bhubAIB3AdKGL57QgxzaoDne9qKBdqUM3sy3oZ4j98qOsksK87MUudYpdG4CT8YwcN806fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4tBJI61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B636C433C7;
	Wed,  7 Feb 2024 21:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340944;
	bh=xD7h6kS43z3E7rm1p4ubRVHLoBhiPX+EKNxAczT8Weg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4tBJI61AzM6Hp8wNJLnYoeZryoy7eJA/rHQspXu45WBvqiG3QLCdnt9+bf2D/sN0
	 TiRvNBKTj+iCNz9THFtM8Gd2ZNDvtpVNMdget9gd+PkEHm9mDz/kdLTnN122zvaJh/
	 TTRvnv3tzNn6W0TkvpMBfi/54n3uwCtoajDg04Bzo7JYcLfnATRq9oDYRdKLtL3Ju4
	 G3CwcoFASxlKsS/8auyafD4RT4gjFa1p1HTkE7nRzGDnxGaFFFNPshPY5puWSq/JMF
	 KnnOlWOqZypy0+QlJktRtx2tCtzmMoBmSed/ywzBt/AONE39o1P7Z1cQbyvVRZ8d+M
	 jtS+Mdc16ECcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brenton Simpson <appsforartists@google.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	vi@endrift.com,
	swyterzone@gmail.com,
	matthias.benkmann@gmail.com,
	pgriffais@valvesoftware.com,
	christophe.jaillet@wanadoo.fr,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 21/44] Input: xpad - add Lenovo Legion Go controllers
Date: Wed,  7 Feb 2024 16:20:48 -0500
Message-ID: <20240207212142.1399-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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


