Return-Path: <linux-kernel+bounces-141572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E428A202C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7175B1F254A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347C01D526;
	Thu, 11 Apr 2024 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="uILZbEWM"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A017BD4;
	Thu, 11 Apr 2024 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867165; cv=none; b=Le8tHkLAHwKLywvxg1ICQoxN3+4OQsc4Wv7TrufU0bZahNKuxXUpcNj4wt+mKc6gN52fC+fz26HWRUhC23YBjrdwUlMyOA4j4Sen05RBenGOjMAp8ELcAJGB3x+s0aMUl+mxMB1UwvlUg7VDYUSlO9sQ3rs+bEhaRa1fI4qtECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867165; c=relaxed/simple;
	bh=LDIXVCb6LHYhQvsivq7jCY36uodU+fCNx85pPyntecI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKOqHUye7AjBbeQqSPpkKUeaJeMzMfBy1BqDPYKu+HTs40IZsjzrRhrAU3ZzgL6UTEBBL9JDSksiijl3rcO8klvop0YY8flTnvwBIp+gvac+dW2nVky2Y6Fs8DgsY3/4k4vK/ZuldzjRJTy1e2xJ3SCFFrDzUcJEU009wkTaH/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=uILZbEWM; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712867157; x=1713471957; i=parker@finest.io;
	bh=TCukniCmiJlFXJkYUeOOK8Y0LFIFkQtEUht+JsI0uWU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=uILZbEWM0Dx0HwskptMO62BgJqkQDp6uOdlGv4+8iyGdIv2tmc+eCrXiDKNJNX05
	 yjeg60DONDbh59uHYJ8cJC7OipxIzuIPSObI2z2do2FMAZIC6e5jr4YLG4QpqKuY8
	 E2GlTLwtINXA/RLdeXsQUGG228EON/u1o4mqWocC31BdnFYxzfWaxx2fKpIFBL6hv
	 zZ1VfJPNFTA4ZaUnpLAw1hr5IIY+TjIEZeHb3y2YzwaKlpNTUTEPNiM93gu2bHLQm
	 tlePDZQnI9NTUCtolay3zfeItPbl+8N+TXMQb7959ZnV8uwJ6FJ1lDQ5CFbAYO8OD
	 vCBXYLC//pxJoIwSLg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MhBdX-1s8R6b3j2v-00W18b; Thu, 11 Apr
 2024 22:25:56 +0200
From: parker@finest.io
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 0/7] serial: exar: add Connect Tech serial cards to Exar driver
Date: Thu, 11 Apr 2024 16:25:38 -0400
Message-ID: <cover.1712863999.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:keuYo7IoL7zHMss6ufd5ZM/kGYYN/UQgpmS2Phj6qju4LM//Aoi
 KYGu5gpsu+Id//c7ZXkCB//saBrCNYartYQ3A2bCAKJ6HVo8G12jskb/kWN+guR8GZsT4iw
 WzruQnjnM1B4r+IR/HuAHid9F22GFv3lj8pjSW4Ng4C3sXKTBJHoC9XxhpAxrAafG+CyvsI
 t+B+04EUDRQOvBVNaCv+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:znEOoshHSL0=;0/XCIqmQMvCFYHqy32hpX9+MZWA
 +rRcK6F3PdzmjW2mz5XdrIC9ZhGmNx6mSAIgdCX+GENSFkeIGs0FcE+3o905IZLGTQM/piFGW
 QVIeecU6I8UYWNlGUasuUcOkU/lw18Q73XX0XEyY4SZeZ0Jr6AW7/ivGT+6ArCBM8aKawsE+C
 x+TBzcvZ4s5i3Ma1oNJbCRTzDrnL7gPWFNCWGr8sdE0xPQD9+KNMOU76yTlIks/pfQy7K2AZF
 4UgYMuiv9cjohLfyh5pjbLlO0F1Xiq0s7D4meddOJqmV772Glo8v/PgafG+dZrvXzA0RigBks
 szFm6as04GtE0W+ePde1qQSZatUBPcyS1DUTIL/dKvXkGS2ukTaE7nTR9v6a8VSahMYwJMmtS
 x1vzUoSs5MVMvKsxlRQY6a32Ls97UP7dYQKyhTH6dwLTIbU2V+dItjATCF+PYfZX8fcTySRLK
 GaYAgXMjCKcougzpt7nZl1aqXXcLqIWgf1d2FJEzwW52WS5dJHiFnskeqT2e1EUZ8iyu/y3MR
 8+Xm5jpXPr67fepEXhO1aqT5Y/YzVgJGO6EmeGyLU+ygiKP9LDKMNEIPvMMHQ0nEvHCGNMnT7
 yHhp5tKEMgcpTewHRSw5bllraaViJkdApwlMEga8Pe5s5szqZaQlFGTdmn3FcfVOqAI2STbx5
 dn5iS7SsOFo9zR2Q+JWcStgPamokLAZHuO/NKgY35uaZBH6s8eDMrGp2vOGTTV2Krjpez8AWH
 rIuPTAHyuX9oAXBu1GDxzdCtbFf+d/V/z/GKDF/RdqFgEsJ9BOgDH4=

From: Parker Newman <pnewman@connecttech.com>

Hello,
These patches add proper support for most of Connect Tech's (CTI) Exar
based serial cards. Previously, only a subset of CTI's cards would work
with the Exar driver while the rest required the CTI out-of-tree driver.
These patches are intended to phase out the out-of-tree driver.

I am new to the mailing lists and contributing to the kernel so please
let me know if I have made any mistakes or if you have any feedback.

Changes in v2:
- Put missing PCI IDs in 8250_exar.c instead of pci_ids.h
- Split large patch into smaller ones

Thank you,

Parker Newman (7):
  serial: exar: adding missing CTI and Exar PCI ids
  serial: exar: add support for reading from Exar EEPROM
  serial: exar: add support for config/set single MPIO
  serial: exar: add optional board_setup function
  serial: exar: add some CTI helper functions
  serial: exar: add CTI board and port setup functions
  serial: exar: fix: fix crash during shutdown if setup fails

 drivers/tty/serial/8250/8250_exar.c | 1083 +++++++++++++++++++++++++--
 1 file changed, 1017 insertions(+), 66 deletions(-)


base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
=2D-
2.43.2


