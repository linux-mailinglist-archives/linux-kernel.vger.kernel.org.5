Return-Path: <linux-kernel+bounces-57190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0E384D4E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC2E283BB3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B33179A11;
	Wed,  7 Feb 2024 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxUXX8tX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65C5179A06;
	Wed,  7 Feb 2024 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341193; cv=none; b=teLYwaECbIhoNUbEnC/SkY28zxr07t1j3Z+tLRc00xBWGIGOFy8fTahsIyEENHSQYfhGMXIf3I10wtptvGZspIsdABCV+pEhOmtWlgMLZaXCHWIPDtDgEWJHTZcCALh9vkhH+Ap5sfa8bY8OnMf8HaU2xM7TcRtB0JuAeMbZQO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341193; c=relaxed/simple;
	bh=R0dOcXmanYZWpCUfSoSQ5uZPRgUSkvXD7HI1oiHj4bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=az2Cvj3m9uZwK+ZlUwzKWRGLGV/Cbr6syb0qGfGWhdBAQW4n1NaiK3zzOfNDf/yfBCweZPmLWWkyOFnkdfmXfya05w95uGhud6TpqGpXhALlul9SoiFyl73S1y+TovKh6m6GFsSRBOIA/Fs8kwDErRV9KXH6TXCI0yAzcHZCh7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxUXX8tX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CD6C433F1;
	Wed,  7 Feb 2024 21:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341193;
	bh=R0dOcXmanYZWpCUfSoSQ5uZPRgUSkvXD7HI1oiHj4bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kxUXX8tXTC3vOC2C/Fk2FlgU49YqGu3E64D6B0elQQq/QhvKt+GTAX/CyHpu4zYek
	 lByq7YZ/S8/SJfdON21hT9Mw3UOie69GjTao5EFE0RGra8jnn+ZgVnNCZDwYq+p3n5
	 +jj7FWUr4IHNVcvNzsD7FpEN+ai+zs4xvRj9ZGR9UX3e6pcCIj6CY8lM2x8g19cGfg
	 ce+5mdW7ksaru6mb2TRVK6DXp1scwZMp5njsW0fd0w1BLZQoXEPirlnfs+V+1Hj1pw
	 kJNbnaW+1jlez4tMDTpEwtHR8ATY1qusW53ndmY+2vd5rHBE8L+RhAUzLmieyfP0Yg
	 IeY3ANV0AL/nA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brenton Simpson <appsforartists@google.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	vi@endrift.com,
	swyterzone@gmail.com,
	luca@z3ntu.xyz,
	slouken@libsdl.org,
	pgriffais@valvesoftware.com,
	matthias_berndt@gmx.de,
	christophe.jaillet@wanadoo.fr,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 11/23] Input: xpad - add Lenovo Legion Go controllers
Date: Wed,  7 Feb 2024 16:25:52 -0500
Message-ID: <20240207212611.3793-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 1ff0d4e24fe6..f0b1dac93822 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -276,6 +276,7 @@ static const struct xpad_device {
 	{ 0x1689, 0xfd00, "Razer Onza Tournament Edition", 0, XTYPE_XBOX360 },
 	{ 0x1689, 0xfd01, "Razer Onza Classic Edition", 0, XTYPE_XBOX360 },
 	{ 0x1689, 0xfe00, "Razer Sabertooth", 0, XTYPE_XBOX360 },
+	{ 0x17ef, 0x6182, "Lenovo Legion Controller for Windows", 0, XTYPE_XBOX360 },
 	{ 0x1949, 0x041a, "Amazon Game Controller", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0002, "Harmonix Rock Band Guitar", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
@@ -464,6 +465,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x15e4),		/* Numark X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x162e),		/* Joytech X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x1689),		/* Razer Onza */
+	XPAD_XBOX360_VENDOR(0x17ef),		/* Lenovo */
 	XPAD_XBOX360_VENDOR(0x1949),		/* Amazon controllers */
 	XPAD_XBOX360_VENDOR(0x1bad),		/* Harminix Rock Band Guitar and Drums */
 	XPAD_XBOX360_VENDOR(0x20d6),		/* PowerA Controllers */
-- 
2.43.0


