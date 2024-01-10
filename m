Return-Path: <linux-kernel+bounces-22251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE8E829B70
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AFC1C2129D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC12C4A9BA;
	Wed, 10 Jan 2024 13:34:38 +0000 (UTC)
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6048CD0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=27534d3e5e=fe@dev.tdt.de>)
	id 1rNYio-00FmwR-67; Wed, 10 Jan 2024 14:34:18 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1rNYim-00BCNT-Ie; Wed, 10 Jan 2024 14:34:16 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 2F006240049;
	Wed, 10 Jan 2024 14:34:16 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id AB0BC240040;
	Wed, 10 Jan 2024 14:34:15 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id B211B3346A;
	Wed, 10 Jan 2024 14:34:14 +0100 (CET)
From: Florian Eckert <fe@dev.tdt.de>
To: Eckert.Florian@googlemail.com,
	lee@kernel.org
Cc: sfr@canb.auug.org.au,
	gregkh@linuxfoundation.org,
	m.brock@vanmierlo.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] leds: update led-trigger-tty ABI documentation
Date: Wed, 10 Jan 2024 14:34:10 +0100
Message-ID: <20240110133410.81645-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1704893657-A678E464-7890D8E2/0/0
X-purgate-type: clean
X-purgate: clean

The 'led-trigger-tty' uses the same naming in the ABI documentation as
the 'led-trigger-netdev'. Which leads to the following warning when
building the documentation.

Warning: /sys/class/leds/<led>/rx is defined 2 times:
Documentation/ABI/testing/sysfs-class-led-trigger-tty:7
Documentation/ABI/testing/sysfs-class-led-trigger-netdev:49
Warning: /sys/class/leds/<led>/tx is defined 2 times:
Documentation/ABI/testing/sysfs-class-led-trigger-tty:15
Documentation/ABI/testing/sysfs-class-led-trigger-netdev:34

Renaming the 'What' path by prefixing it with 'tty_' solves this problem.

Fixes: 6dec659896b4 ("leds: ledtrig-tty: Add additional line state evalua=
tion")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 .../ABI/testing/sysfs-class-led-trigger-tty        | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-tty b/Docu=
mentation/ABI/testing/sysfs-class-led-trigger-tty
index 30cef9ac0f49..308fbc3627cd 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-tty
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
@@ -1,11 +1,11 @@
-What:		/sys/class/leds/<led>/ttyname
+What:		/sys/class/leds/<tty_led>/ttyname
 Date:		Dec 2020
 KernelVersion:	5.10
 Contact:	linux-leds@vger.kernel.org
 Description:
 		Specifies the tty device name of the triggering tty
=20
-What:		/sys/class/leds/<led>/rx
+What:		/sys/class/leds/<tty_led>/rx
 Date:		February 2024
 KernelVersion:	6.8
 Description:
@@ -13,7 +13,7 @@ Description:
 		If set to 0, the LED will not blink on reception.
 		If set to 1 (default), the LED will blink on reception.
=20
-What:		/sys/class/leds/<led>/tx
+What:		/sys/class/leds/<tty_led>/tx
 Date:		February 2024
 KernelVersion:	6.8
 Description:
@@ -21,7 +21,7 @@ Description:
 		If set to 0, the LED will not blink on transmission.
 		If set to 1 (default), the LED will blink on transmission.
=20
-What:		/sys/class/leds/<led>/cts
+What:		/sys/class/leds/<tty_led>/cts
 Date:		February 2024
 KernelVersion:	6.8
 Description:
@@ -31,7 +31,7 @@ Description:
 		If set to 0 (default), the LED will not evaluate CTS.
 		If set to 1, the LED will evaluate CTS.
=20
-What:		/sys/class/leds/<led>/dsr
+What:		/sys/class/leds/<tty_led>/dsr
 Date:		February 2024
 KernelVersion:	6.8
 Description:
@@ -41,7 +41,7 @@ Description:
 		If set to 0 (default), the LED will not evaluate DSR.
 		If set to 1, the LED will evaluate DSR.
=20
-What:		/sys/class/leds/<led>/dcd
+What:		/sys/class/leds/<tty_led>/dcd
 Date:		February 2024
 KernelVersion:	6.8
 Description:
@@ -51,7 +51,7 @@ Description:
 		If set to 0 (default), the LED will not evaluate CAR (DCD).
 		If set to 1, the LED will evaluate CAR (DCD).
=20
-What:		/sys/class/leds/<led>/rng
+What:		/sys/class/leds/<tty_led>/rng
 Date:		February 2024
 KernelVersion:	6.8
 Description:
--=20
2.30.2


