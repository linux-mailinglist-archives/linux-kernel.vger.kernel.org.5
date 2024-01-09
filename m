Return-Path: <linux-kernel+bounces-20810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110B3828582
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8770B233B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6086A381C0;
	Tue,  9 Jan 2024 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="DGqhDSB4"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1D13716B;
	Tue,  9 Jan 2024 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 633D062DD19A;
	Tue,  9 Jan 2024 12:45:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1704800748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=a70FyQBxFFn5JMG0Q0O4V6pTeF/ihUmX4t9eLgwGQF0=;
	b=DGqhDSB4nGcCz1L/RON79NbamG4X/0oPyGnwnny6lfWxgIHTP/puu8xt2PgR79CtpJmYsv
	mRl230oLNKyo699ndw3aPSHNgdddA4dBttlQRbiF1l/Bl6LUjfiyKu0uSbQIpYVpNovUUr
	diazVmBU8quAK6UVw0fJO5kcxnVVfOY=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
 Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
 Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Hans de Goede <hdegoede@redhat.com>
Subject: Flood of logitech-hidpp-device messages in v6.7
Date: Tue, 09 Jan 2024 12:45:37 +0100
Message-ID: <3277085.44csPzL39Z@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8321016.T7Z3S40VBb";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart8321016.T7Z3S40VBb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Subject: Flood of logitech-hidpp-device messages in v6.7
Date: Tue, 09 Jan 2024 12:45:37 +0100
Message-ID: <3277085.44csPzL39Z@natalenko.name>
MIME-Version: 1.0

Hello Hans et al.

Starting from v6.7 release I get the following messages repeating in `dmesg` regularly:

```
Jan 09 10:05:06 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
Jan 09 10:07:15 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: Disconnected
Jan 09 10:16:51 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
Jan 09 10:16:55 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
Jan 09 10:16:55 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
Jan 09 10:36:31 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
Jan 09 10:37:07 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
Jan 09 10:46:21 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
Jan 09 10:48:23 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: Disconnected
Jan 09 11:12:27 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
Jan 09 11:12:47 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
Jan 09 11:12:47 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
Jan 09 11:38:32 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
Jan 09 11:43:32 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: Disconnected
Jan 09 11:45:10 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
Jan 09 11:45:11 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
Jan 09 11:45:11 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
Jan 09 12:31:48 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
Jan 09 12:33:21 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
```

I've got the following hardware:

* Bus 006 Device 004: ID 046d:c52b Logitech, Inc. Unifying Receiver
* Logitech MX Keys
* Logitech M510v2

With v6.6 I do not get those messages.

I think this is related to 680ee411a98e ("HID: logitech-hidpp: Fix connect event race").

My speculation is that some of the devices enter powersaving state after being idle for some time (5 mins?), and then wake up and reconnect once I touch either keyboard or mouse. I should highlight that everything works just fine, it is the flood of messages that worries me.

Is it expected?

Thank you.

-- 
Oleksandr Natalenko (post-factum)
--nextPart8321016.T7Z3S40VBb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmWdMeEACgkQil/iNcg8
M0u9kRAAmQK0aeOpOEO+/c+yK/Yo1nWVpA+8lwE9ymnqlMMnkd25LWsW1CCda7bw
h3UGk4Hcn4X9Ljop2mmt8k1IycWUlKAdUpTM/qwHu/PygH9OfHwa/TyUYjMqQrYR
zz36lg77GrfjVN0RlkUNG2lcQmJbV8lv5hjzvKLiAVWl7zR7qoK8Xnw22xvwqcgo
UsxYdQjU08jj1IU7jgcHVatXBSVIfHqozZ5dxtLCxwC/rupkWcLo5Ag1v5wMfzR+
wnQkQcBG0gFeoWvqC7yRZ2sr885eABJnEvUsEehz5I31Y4fJ/mrnXefMX/Y2e9L2
JWssOo5R0eT8AuS6+aB2CrrYLONEA9TTqPwOjQxoR3bZxWMmlW4rJrgk84XNde2g
AyV25a1zeXBU+ka/dhUM8r1cDrBso/eokMnYhKUxRcqQ8qoy8B3DIogunGFa/OAI
6KUmKnASo8YzySDz+wGm+lY3SG8bcjhnVSoIo1DihG9IUbdaZF0y47eYLoHeuTQ5
lPPosqG/o0pIBbpW/3xAYY1og5aGAyvhIOyX+6dfjTTRhdXB/cCySayyEAoxP+mY
/TL3kMOT9IM869afydLTOlsS+ivkj2Q0ahkJyhXpAKmN7aSeGK7tHSixmj8fWL3a
FrcVWVpChXHSq8w1QBeSHhVj/0AsO6qFHgXIiaiJR2QnOv+xcRs=
=nVhh
-----END PGP SIGNATURE-----

--nextPart8321016.T7Z3S40VBb--




