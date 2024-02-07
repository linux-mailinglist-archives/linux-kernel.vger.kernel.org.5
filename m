Return-Path: <linux-kernel+bounces-57119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8324284D437
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58741C21E07
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346DD1487FA;
	Wed,  7 Feb 2024 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPMAzmAI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5E91487CF;
	Wed,  7 Feb 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341034; cv=none; b=LDnaw/map1wlfEB/sx3LzpP+mRGTRRoOyhJqQfHwFys5fis7DTDhBJelEux28Mb99/cMyn2NMMltQNEoaXXSXDQTe9spPr1sIcVVZ6+KHYMClH+ydEk1O5zowUxWPMN31VKgcjdd0b9/mV/irQ0EeYstG1aWELAPoNseFrr7yy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341034; c=relaxed/simple;
	bh=73gobveBCfcwgCL9kNg4UHI8MzRQDi5tMXWlU9/XIE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsYMYViZNtOsK5iSEl5gwMacO1GVXRuneF2rICbrmzFndlStbzeYT7OBioj6NUzayJrg1Mwmg8Yi/eHH0yZeNGmu2z2dRlGUfUSlnTHsNq74IP/yEekRXwsfv5EMITv61GkRh/4H1zeXLNSHXs19L7Jobcff6J5nRQFqSyLX0Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPMAzmAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90CDC433C7;
	Wed,  7 Feb 2024 21:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341033;
	bh=73gobveBCfcwgCL9kNg4UHI8MzRQDi5tMXWlU9/XIE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OPMAzmAIRWtELUkE5Hh52+hg3HwOPOiDfV+UiyKS/nmWta2OcimUTO730Y/PK84Aw
	 7OCv5zKDXT4uH1oL5uSByXNubIVG/rv1mHCMDHRYEpxfu2XgPeC7AW4JBFbRVMCu2M
	 GGLUacUjgmAp1lXNYpY+nbLopGZ1wT5+hXIhgxIIUmJUDF512p4tuXw9Ux1TqHvx/m
	 W4i356pj1VLTjLC7yUFxifgebsD1M7ecuB4iBuhWR96PVgkI8u0Oj/sTskZiIwbIB9
	 EucGlZYKHSiaohoC0UJ2sJVqq6mfINT3MigtN0rr2KZ4S0/HHj+Vr63PosNTEFS0JA
	 OSoBXfn1O6GWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.com>,
	=?UTF-8?q?Marcus=20R=C3=BCckert?= <darix@opensu.se>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/38] HID: logitech-hidpp: add support for Logitech G Pro X Superlight 2
Date: Wed,  7 Feb 2024 16:22:55 -0500
Message-ID: <20240207212337.2351-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Jiri Kosina <jkosina@suse.com>

[ Upstream commit afa6ac2690bb9904ff883c6e942281e1032a484d ]

Let logitech-hidpp driver claim Logitech G Pro X Superlight 2.

Reported-by: Marcus Rückert <darix@opensu.se>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 7bf12ca0eb4a..4519ee377aa7 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4650,6 +4650,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
 	{ /* Logitech G Pro X Superlight Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC094) },
+	{ /* Logitech G Pro X Superlight 2 Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC09b) },
 
 	{ /* G935 Gaming Headset */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0x0a87),
-- 
2.43.0


