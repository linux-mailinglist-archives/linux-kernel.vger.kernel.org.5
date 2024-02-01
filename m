Return-Path: <linux-kernel+bounces-48042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1E2845691
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55DF1C27A66
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C329115D5D1;
	Thu,  1 Feb 2024 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aY6gtS1i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B18615D5D3;
	Thu,  1 Feb 2024 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788407; cv=none; b=NPA58JAfAED8npPL3F74wJ5Ms5MVtaMdpBz4xwlbCSRvI95tgXUuRBedF3fZJ+50mQlDiZRBWAqCngZoGA5lfRQ7zqdsHu7XQjndz+QCT30g92lszC+3MYFjBIWr1DV1N1bTYoiAm443V7vIukvIRtxxQ93dwdlfxNyznbJ2W9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788407; c=relaxed/simple;
	bh=PDYxQCUZCAsEiRe/Tu00xGBkJEs17Kao85ABA/4E6Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6KfrL2sJdgtyahgP0r6tqiLFFQrTsqE7NnmHyh+tD9JBXBx0fu/SiJzY7fcLdpF7bX8wZGx44kQlOKNuhxc+5IoaiYnvoLnHZ9ROVTBVIqGXurOWEMQQCPVY6upod55HMfVWQYw/NychkNhSe7EY4a6V//S/DX9mJKtXW1rZpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aY6gtS1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83DEC43394;
	Thu,  1 Feb 2024 11:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706788406;
	bh=PDYxQCUZCAsEiRe/Tu00xGBkJEs17Kao85ABA/4E6Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aY6gtS1iITIj11OBDRVD94Kzzg1MjAWqHY/VKBiof1s45yUxpxM+qv8lociQJ2ywy
	 tEC/2K7eiesQsqFoyPVnAJv9NKEhLc/iPy6niD6pdwAHZvBLRiubp97DYpSLc1uhRs
	 5Fl8dLCj7SYRcagcaP8EJ6W20VpFs3ipoNhDnxLTO7XfispCGKfKOp5f197UJkhCr0
	 L//Y0LMrPmfBdijQSZoNt5uvCtLFc9VKn3DmLnLxuYjeBF8aSeDsh+2niLpfs/si9N
	 cwR0W+PCgg3ZTMSnv6scrBLWjxNqLKrRHyncOn6zAvrnRvTTRHdZV4BRVYtngGSK+C
	 cipiSuxNcOl2Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Paul Pawlowski <paul@mrarm.io>,
	Aun-Ali Zaidi <admin@kodeit.net>,
	Aditya Garg <gargaditya08@live.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/7] HID: apple: remove unused members from struct apple_sc_backlight
Date: Thu,  1 Feb 2024 12:53:14 +0100
Message-ID: <20240201115320.684-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201115320.684-1-jirislaby@kernel.org>
References: <20240201115320.684-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The backlight members in struct apple_sc_backlight are unused. They were
added in commit 9018eacbe623 (HID: apple: Add support for keyboard
backlight on certain T2 Macs.), but never used.

As this is not a struct to communicate with the HW, remove these.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Paul Pawlowski <paul@mrarm.io>
Cc: Aun-Ali Zaidi <admin@kodeit.net>
Cc: Aditya Garg <gargaditya08@live.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-apple.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index b9c7c0ed7bcc..bd022e004356 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -79,7 +79,6 @@ struct apple_non_apple_keyboard {
 struct apple_sc_backlight {
 	struct led_classdev cdev;
 	struct hid_device *hdev;
-	unsigned short backlight_off, backlight_on_min, backlight_on_max;
 };
 
 struct apple_sc {
-- 
2.43.0


