Return-Path: <linux-kernel+bounces-161458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35B08B4C37
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63B56B2129A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1383941ABE;
	Sun, 28 Apr 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="pkSnX7Nk"
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3601E89A;
	Sun, 28 Apr 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714315574; cv=none; b=D12uwfE1uCNdo2AWEv1fS5qbzdFpQKLMnJNhNFqTtZ2kjly3712GYDkKCbEg8aSKboNmB0ewjfacUWmAaEoUpHkiRG6H0/lb9D/mEC57nnYiwa12jurcMKd2vDYGc+pPZbpzWC1j+ONdVYsAmJYJ5B94B5nC/7ioVEk62fja08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714315574; c=relaxed/simple;
	bh=2gtxsJmO0Yl29VT9YxKKpnmC4LGKvavZ6mZzgqja+fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f8oXpe8iNF9bdOf2NCHRoUOnocbSs64qqKqSPuNGyx0opMh83t2VGyDr5zrIr0+Xtv4HIwYY5Ae8G3fQZNYr2B2P1nFFdCYaITKRdcetv3IllwNisnS3ou+/hGYyoUpuyAXi/TxTtMEagFKW9EqXDxnoQWdNr4YKDIssJaQSk+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=pkSnX7Nk; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:41f:0:640:22c7:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 9667760903;
	Sun, 28 Apr 2024 17:46:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tjQeFr9Sga60-GbvMPXHt;
	Sun, 28 Apr 2024 17:45:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1714315559; bh=1rb9DsOYv/HCrsFxBDIIM2h3mC32NpYupGiI69vo6Ro=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=pkSnX7Nkz/0vjh/8OSNniLUlm5xi43RIQDarkknVLAsiVHx2QPqT9PkPdlbv7u+a/
	 wwLL+nQtqMt8CXO+lEk61CRoP9dFOEFcoKHjcjPleE598jCZpjJxX0ZKYebAj2UIUx
	 2abapW2KHiCsoVGS/unfw/tr+Fq7I24fl8jkYgeQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin Pugin <rilian.la.te@ya.ru>
To: 
Cc: krzk@kernel.org,
	conor@kernel.org,
	lkp@intel.com,
	vz@mleia.com,
	robh@kernel.org,
	jcmvbkbc@gmail.com,
	nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com,
	corbet@lwn.net,
	ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de,
	Maarten.Brock@sttls.nl,
	linux-stable@vger.kernel.org,
	Konstantin Pugin <rilian.la.te@ya.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 0/1] serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
Date: Sun, 28 Apr 2024 17:45:32 +0300
Message-ID: <20240428144541.80812-1-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When specifying flag SER_RS485_RTS_ON_SEND in RS485 configuration,
we get the following warning after commit 4afeced55baa ("serial: core:
fix sanitizing check for RTS settings"):

    invalid RTS setting, using RTS_AFTER_SEND instead

This results in SER_RS485_RTS_AFTER_SEND being set and the
driver always write to the register field SC16IS7XX_EFCR_RTS_INVERT_BIT,
which breaks some hardware using these chips.

The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND modes, so fix
this by announcing support for RTS_ON_SEND.

This patch is extracted from my XR20M117X series as it is affect all SC16IS7XX hardware.
This bug affects all kernel series from 6.1 onwards.

Konstantin Pugin (1):
  serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND

 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 660a708098569a66a47d0abdad998e29e1259de6
-- 
2.44.0


