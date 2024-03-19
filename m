Return-Path: <linux-kernel+bounces-108188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D24B88073F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80C21F22FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C517E5A0E5;
	Tue, 19 Mar 2024 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.li header.i=thomas.kuehne@gmx.li header.b="tVnB1lC9"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E10C51C5B;
	Tue, 19 Mar 2024 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710886987; cv=none; b=Kn5jQGrRDWOsqUohDJpGa/wyjtCFMs3mh0YbWgc/sEbeBXXu+ycfqfROTWROVQKHQVNOSA0n4DZbeuKRzOb8oO2rNaZcwq88Hv2nzrBCsYySofqawCmkyRDA0jWBaeUaQve6RX/M9Y2coKAolcKGwF96x4bfDM/5FyPVL2CMESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710886987; c=relaxed/simple;
	bh=Fmol6iXLZOVChPokUhuktqes1qyFzQxgTiZHmF7oYJc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gtzJ9EEfSNA3M7Fr/SgqhCf+J2hLb6Ahp1JsrC3k/v30IA4VsE/noyge644v2zGmESy0m/Oq1BDTgIOVsuxnFcWKae9zWGRcikqN2PcNvs7CRZk7/ivt9/tg+FWz0mBTHBNnNbcVW8y0VXrc5JN7DFDzSK+00oK6XZPFLdWYDeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.li; spf=pass smtp.mailfrom=gmx.li; dkim=pass (2048-bit key) header.d=gmx.li header.i=thomas.kuehne@gmx.li header.b=tVnB1lC9; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.li
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.li;
	s=s31663417; t=1710886983; x=1711491783; i=thomas.kuehne@gmx.li;
	bh=i48cImo9t+BdT//pMNbETc/yaDKl4mj4URnyodDYANk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=tVnB1lC9KBOl8bSrs8pF6NE2nWNJ0gM3L6tUo6iWxWbWtUnQinPl2WHzXnmxTIJi
	 N6tK7Bz8AmyAg0hDHiO6F8TSS6WheICawoPgIOtp4yOjwB9Cdn0CPgRVzS3fND9kQ
	 A2TE0MfWx6mgwYE2SgXNhrfzFnGthvlLIGWYgMvHEzlNBCKBwRqo2wldoSnLSrH5T
	 K9T0kreapooq1Omdwt9LBAi+qLVxJspNdMyf5J0tRytvZ2AFWWs6w5ksemMi6tgic
	 jPTYJjixq7pfAywUJiMkC+6mZ3CkcRgJuGv+OM+bdvTHGtdkU4Ha+h33arkwmGkaE
	 slnIyTrYGm+RL2i6HQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from black ([2.59.122.5]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KUT-1qh1GI0ooL-016iFW; Tue, 19
 Mar 2024 23:23:03 +0100
Date: Tue, 19 Mar 2024 22:23:54 +0000
From: Thomas Kuehne <thomas.kuehne@gmx.li>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hid-debug: add missing evdev and usage codes
Message-ID: <ZfoQegWDHee5EFaY@black>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:InAFh9DOFtvezkgwLcfMhJ7uYzH0KSiu4QqOEb+YF0kEscdzKAu
 p1kJW4l4WpHpKVRuPxE8xt7p5iUo1Yu6Rbk9laGM2FZhZaCveBrFPf23JfvSkuMeEcWoUQY
 dHJMqgXn0Whj0qx4kCTkoQqiVfbqN74hK2F3GLGKAUpnCQCOWMClRMsElzXygup4b9bBx64
 VH9CbqTEGLZ42DNqEphHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4vYloEEGFbo=;eNI6RZl0X7jTjS5um6GIkIWxBMx
 iPBSt3VLqWtX8PljVhfKm4y1TaVrYeePFFid0FRvJ6+cT4Rk+N4HPIDzeSAwuqLH29R/mZE/D
 2qvGdTM8OxMMr7YtDJ5UYr3PEgrU3wxeMQeZEmvdwfFN53McHRxI994hSCdZt30uUgtnPRBdz
 eektCA8TdzxEUEXbLk5HWTUh1IeZt9k8NrohIDU9QMEkNbZgN69sYjMZaGpu4BwqDRjRJE3fC
 FcgvAZk+46CYo+wQ+uYvuN7fK/4K9yQNxasliOiJPKZUcPE+3uNdJQqxOJAsJvVtK4RtpDS44
 7IDTf++6YR54PpcO2WMmNHVyb8N+7p7cfPcgtskRJe8QNJm7WO2k8u2qkcYPoSdlfzHnzitP3
 8OCf3MBJ4or57C6S6GHtJNnSlDlNwPhMjb9JMupob43v69+UrHPncGGNHj0QUVov8/z8QnIjB
 dR0BpfB8AV6EAUpP+dmJaYx2bz8I9eLjvc/qwXSFMMxPLRjJyyuxu+wuXE8U1WtioCsKuc7hO
 iAWwZc2azrjI6VCZycwEmLi5Rznbh8lzfgizYUAcq5E0ijpZuImIrnYcme2o3gLJakI/H57iP
 JqDm03TmoH0kAYv1xzEJc/4JjLAA1q5KZL6ZAheewTvmPpbwExCO6cbgSbb9KUF+nz71u4wnw
 ibcqUd5JzcU9eRlbBbNycZpEooyi6/IRm69gqNXebplQ/46l0+skLEb8+9d4ceHZWV1yNoPBC
 Os1WhRlTdMewQP4ktAVaiHmo+kE8qJ7oYfLFE5TEPUBeAriT1qyuL5fj/NOh90aeBywICggSy
 XHATrXWVjjXWaMQVZi11w8E66GhY0T5V/2+ldmQ9qjwnM=
Content-Transfer-Encoding: quoted-printable


Hid-debug's rdesc output for a game controller contained a few question
marks and numeric IDs instead of the expected descriptive names.

This happens because hid-debug's mapping data is missing a few HID
usages supported by hid-input.

Add missing codes for LEDs, simulator axis and gamepad buttons.

Signed-off-by: Thomas Kuehne <thomas.kuehne@gmx.li>
=2D--
 drivers/hid/hid-debug.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 7dd83ec74f8..67216a52fd2 100644
=2D-- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -103,6 +103,9 @@ static const struct hid_usage_entry hid_usage_table[] =
=3D {
       {0, 0xbd, "FlareRelease"},
       {0, 0xbe, "LandingGear"},
       {0, 0xbf, "ToeBrake"},
+      {0, 0xc4, "Accelerator"},
+      {0, 0xc5, "Brake"},
+      {0, 0xc8, "Steering"},
   {  6, 0, "GenericDeviceControls" },
       {0, 0x20, "BatteryStrength" },
       {0, 0x21, "WirelessChannel" },
@@ -118,7 +121,12 @@ static const struct hid_usage_entry hid_usage_table[]=
 =3D {
       {0, 0x03, "ScrollLock"},
       {0, 0x04, "Compose"},
       {0, 0x05, "Kana"},
+      {0, 0x09, "Mute"},
+      {0, 0x19, "MessageWaiting"},
+      {0, 0x27, "StandBy"},
       {0, 0x4b, "GenericIndicator"},
+      {0, 0x4c, "SystemSuspend"},
+      {0, 0x4d, "ExternalPowerConnected"},
   {  9, 0, "Button" },
   { 10, 0, "Ordinal" },
   { 12, 0, "Consumer" },
@@ -995,6 +1003,26 @@ static const char *keys[KEY_MAX + 1] =3D {
 	[KEY_MACRO22] =3D "Macro22", [KEY_MACRO23] =3D "Macro23", [KEY_MACRO24] =
=3D "Macro24",
 	[KEY_MACRO25] =3D "Macro25", [KEY_MACRO26] =3D "Macro26", [KEY_MACRO27] =
=3D "Macro27",
 	[KEY_MACRO28] =3D "Macro28", [KEY_MACRO29] =3D "Macro29", [KEY_MACRO30] =
=3D "Macro30",
+	[BTN_TRIGGER_HAPPY1] =3D "TriggerHappy1", [BTN_TRIGGER_HAPPY2] =3D "Trig=
gerHappy2",
+	[BTN_TRIGGER_HAPPY3] =3D "TriggerHappy3", [BTN_TRIGGER_HAPPY4] =3D "Trig=
gerHappy4",
+	[BTN_TRIGGER_HAPPY5] =3D "TriggerHappy5", [BTN_TRIGGER_HAPPY6] =3D "Trig=
gerHappy6",
+	[BTN_TRIGGER_HAPPY7] =3D "TriggerHappy7", [BTN_TRIGGER_HAPPY8] =3D "Trig=
gerHappy8",
+	[BTN_TRIGGER_HAPPY9] =3D "TriggerHappy9", [BTN_TRIGGER_HAPPY10] =3D "Tri=
ggerHappy10",
+	[BTN_TRIGGER_HAPPY11] =3D "TriggerHappy11", [BTN_TRIGGER_HAPPY12] =3D "T=
riggerHappy12",
+	[BTN_TRIGGER_HAPPY13] =3D "TriggerHappy13", [BTN_TRIGGER_HAPPY14] =3D "T=
riggerHappy14",
+	[BTN_TRIGGER_HAPPY15] =3D "TriggerHappy15", [BTN_TRIGGER_HAPPY16] =3D "T=
riggerHappy16",
+	[BTN_TRIGGER_HAPPY17] =3D "TriggerHappy17", [BTN_TRIGGER_HAPPY18] =3D "T=
riggerHappy18",
+	[BTN_TRIGGER_HAPPY19] =3D "TriggerHappy19", [BTN_TRIGGER_HAPPY20] =3D "T=
riggerHappy20",
+	[BTN_TRIGGER_HAPPY21] =3D "TriggerHappy21", [BTN_TRIGGER_HAPPY22] =3D "T=
riggerHappy22",
+	[BTN_TRIGGER_HAPPY23] =3D "TriggerHappy23", [BTN_TRIGGER_HAPPY24] =3D "T=
riggerHappy24",
+	[BTN_TRIGGER_HAPPY25] =3D "TriggerHappy25", [BTN_TRIGGER_HAPPY26] =3D "T=
riggerHappy26",
+	[BTN_TRIGGER_HAPPY27] =3D "TriggerHappy27", [BTN_TRIGGER_HAPPY28] =3D "T=
riggerHappy28",
+	[BTN_TRIGGER_HAPPY29] =3D "TriggerHappy29", [BTN_TRIGGER_HAPPY30] =3D "T=
riggerHappy30",
+	[BTN_TRIGGER_HAPPY31] =3D "TriggerHappy31", [BTN_TRIGGER_HAPPY32] =3D "T=
riggerHappy32",
+	[BTN_TRIGGER_HAPPY33] =3D "TriggerHappy33", [BTN_TRIGGER_HAPPY34] =3D "T=
riggerHappy34",
+	[BTN_TRIGGER_HAPPY35] =3D "TriggerHappy35", [BTN_TRIGGER_HAPPY36] =3D "T=
riggerHappy36",
+	[BTN_TRIGGER_HAPPY37] =3D "TriggerHappy37", [BTN_TRIGGER_HAPPY38] =3D "T=
riggerHappy38",
+	[BTN_TRIGGER_HAPPY39] =3D "TriggerHappy39", [BTN_TRIGGER_HAPPY40] =3D "T=
riggerHappy40",
 };

 static const char *relatives[REL_MAX + 1] =3D {
@@ -1041,7 +1069,8 @@ static const char *leds[LED_MAX + 1] =3D {
 	[LED_SCROLLL] =3D "ScrollLock",	[LED_COMPOSE] =3D "Compose",
 	[LED_KANA] =3D "Kana",		[LED_SLEEP] =3D "Sleep",
 	[LED_SUSPEND] =3D "Suspend",	[LED_MUTE] =3D "Mute",
-	[LED_MISC] =3D "Misc",
+	[LED_MISC] =3D "Misc",		[LED_MAIL] =3D "Mail",
+	[LED_CHARGING] =3D "Charging",
 };

 static const char *repeats[REP_MAX + 1] =3D {
=2D-
2.40.1


