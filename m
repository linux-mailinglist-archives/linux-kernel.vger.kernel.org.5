Return-Path: <linux-kernel+bounces-70383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41D18596DB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 13:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7206C1F21AB8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 12:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B4363506;
	Sun, 18 Feb 2024 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.ch header.i=flurry123@gmx.ch header.b="mYjbRZIs"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C24F1F2;
	Sun, 18 Feb 2024 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708258569; cv=none; b=TS9A3ZVbPyAlWlCo6ZeKEzh6e5oK3iUFI6k62vXgt3Uu0N90upfBvoeKkvUBUcc1B7b02ZAN+jBirmGoIyH4pdZaHNBqUIwWE6UjpB1vwaRYwyF3Bjr/S1hatSLeGUkLMuw097gliU/8Sn85cnTQveKDp5kZWjUZuBR1EDe14ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708258569; c=relaxed/simple;
	bh=tvp9s4NI2xT/fRdDh4gNHGAwqzllSAl0NRrc4HGP2m8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QmxDAuw8as+IWJc2XxJmjBDYS4mJWPc9lXFdQMgnFartCHshXU20AfEfKh23Ng0kP4p3bvHS0LOn/qNOjCS4ci82qT6IkOg1ggKAKr+ModzE8rsZ0P89G7CY7CoyWiamo8kY5T4FCCTlQ92Nstp1fTR/KaSLtnhi11q6hLl+7aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.ch; spf=pass smtp.mailfrom=gmx.ch; dkim=pass (2048-bit key) header.d=gmx.ch header.i=flurry123@gmx.ch header.b=mYjbRZIs; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.ch; s=s31663417;
	t=1708258563; x=1708863363; i=flurry123@gmx.ch;
	bh=tvp9s4NI2xT/fRdDh4gNHGAwqzllSAl0NRrc4HGP2m8=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=mYjbRZIsBOJret5vmJsRa4EpWuAdI+mdtTUr7KyjQKULAMhZ7TjuFvHRBMf6qi5V
	 gga6z7W+bWn7I762aEG/5Hn8QEtLlz2VQzOxHpe0sOWLfcf68WIcraZLmnRTV0feq
	 bXX8SdB/M8qSDazy2YwOpJDBiNv7XWluHmCNS94F06Oz+gIKZNs/iz1Di5geLyTIF
	 2EIH8c7OVi0nTiE/yt6ZoRP7B8QaRVaqg9p7rjZmtjlYqBcGwRiXc6JLuIzxhm5bz
	 wyOWtav3iTBWZWKt8yiMBeVPEC4y7hYCdQB6/lXkx19pDkHzhe6tD1fILb4gMCQRE
	 kPyadxbiz9sqTdmmAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.2.15] ([84.155.142.60]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH5Q-1r5eBz2BMS-00cimC; Sun, 18
 Feb 2024 13:16:03 +0100
Message-ID: <a170992c-2acf-42f9-9dcc-b5dae5fffa67@gmx.ch>
Date: Sun, 18 Feb 2024 13:16:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
From: Hans Peter <flurry123@gmx.ch>
Subject: [PATCH] ALSA: hda/realtek: Enable Mute LED on HP 840 G8 (MB 8AB8)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jHz1QthafGp2Z8K1VzHn6CjPuzIw7Fm8uJlghoQwwNL7kEVzQEy
 QxzTbpdSwZsh7h9hxlh0irTbun3G5figr3Zm1u5pz4HGtyjvfoSqyi6j022kRbnOIa9iCv7
 au+g9HLWhTKQu1PfmoWIw5rfKUuWN6+el9+SlL9tUPjuWJb4eO3N118W8p5bd70d/9YfrXr
 X4p1UGg1o9Uqkemi5gOIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Bk53n1Br+Z4=;9VKuH8SdWEUInY+RhY3Mjw4JVsi
 6qy3NqVwCvLupYjwxSW4hR9o9avX0/woW2z/x1+KIBorC0dRl3mvRwC2UU08+RI8hXKmpwyNM
 tMmIEyECE9dusrZR+Rd3bNKom/cRZKl48Lsvl/6heQqZo3lRZ3yxn9wq98rq+q3rU+VXO33NV
 bVGfP+BWgrSWr/ooFJIbPL4um3AnV5FWGp6mrbYcMdU/uIIdLmOLM33Fj7dc46MBraJKGE+0d
 ZBiarux6pxxjQxq/lB2sfa4XCa5WYvMmyL+pG0KawG+Kgb9K93+rDQ/0nzIhLMz1vppp5dR9v
 6CtGBONDxn0aj524WxeiSW7HwX0udMy+rSYc7vubwVyn1aN/mtGZj08j2wPry1F5PGmEr7fYG
 44Fqf0nY8QLhu7EJLD0v4/CxO/Cq1uVrnKWVJlFPiCl6N4rB9A2EK1kbU9i6V16Vo3o6zLBgd
 8uhoeMG4GnTdGWUQLn9OQ1YFhInTlUADAEnfZEuZPWNaBIZhHxE16UCJ36A/e+/R8AvShi8je
 xQOfNyJd71pIAdliyYyGc0OAkatAl3YpLhv/DCJnL+qW12eysNuMREng7zMxQpZrMoGlPOwZV
 /mayipJfGiWCME/6fDjypFhoxVd7TsoY4BKyd/lR7fD5kMCARnCxw5o6PwqQn86ynPi0QLYrF
 IUfXKTTQuUB/Axxm/xs/XihkrmNh674+4I/B60vKgtB9MKapCAhODpBgoi3wGfbapGcukX6t3
 W9ysRjc1QUpNX5BXtFs/pTNxM0WmJT26cAGVS7CWwfXAWQrUmJwX8iRAcWJ0nWmi13lL08ri0
 FRsJIZWigVFNCkecwB8GmkJR4rmc/Ppos9HZOKwOtIw/k=

The HP EliteBook 840 G8 seems to be circulating with different
subsystem-IDs. alsa-info.sh showed on my box:

!!DMI Information
!!---------------

Manufacturer:      HP
Product Name:      HP EliteBook 840 G8 Notebook PC
Product Version:   SBKPF
Firmware Version:  T37 Ver. 01.15.02
System SKU:        5S7R6EC#ABD
Board Vendor:      HP
Board Name:        8AB8

..

!!HDA-Intel Codec information
!!---------------------------
=2D-startcollapse--

Codec: Realtek ALC285
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0285
Subsystem Id: 0x103c8ab9
Revision Id: 0x100002


So an additional quirk enabled mute led for me:

=2D-- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9752,6 +9752,7 @@
  	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)",
ALC236_FIXUP_HP_GPIO_LED),
  	SND_PCI_QUIRK(0x103c, 0x8aa8, "HP EliteBook 640 G9 (MB 8AA6)",
ALC236_FIXUP_HP_GPIO_LED),
  	SND_PCI_QUIRK(0x103c, 0x8aab, "HP EliteBook 650 G9 (MB 8AA9)",
ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8ab9, "HP EliteBook 840 G8 (MB 8AB8)",
ALC285_FIXUP_HP_GPIO_LED),
  	SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9",
ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
  	SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook
PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
  	SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook
PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),


