Return-Path: <linux-kernel+bounces-124803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BCE891CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91D5B25793
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50588190686;
	Fri, 29 Mar 2024 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idYjUPli"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D2190672;
	Fri, 29 Mar 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716162; cv=none; b=eu5qPv/ElbyUz++IXUHTW2NnuDmY61YpxGODSWKhFmMQ48uVn9twob+Yx4U0pTf4md4j2Q1KHL7xuDi/Hci3YWTXG3mHfKLBt9lNk51NrdL5nwUUH6JndIxdxRyxuc7052HBa04tBv9MQKMrpJ67MN1maXylM8G+gHW6dTFsJBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716162; c=relaxed/simple;
	bh=zBlT7bR9VLPwwSZRmRbDyaaaSQltXRwQNSVd2zkZ1BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YELxcWx4z6pSnf8kPiVNZyVNxANp9Cp3CMvImlLTYVoXoBXWnXwT56W0AXXhRQQTwbH5rav678Kz441uvSlBssN9hXg750vUf52MhMVRfQdsDLfaCFYj4tz6Z+zFF58PUyl5UAgem9JlLVyZcHrdx8b3bEecwyT9pWOmE0GSANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idYjUPli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658ECC43390;
	Fri, 29 Mar 2024 12:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716161;
	bh=zBlT7bR9VLPwwSZRmRbDyaaaSQltXRwQNSVd2zkZ1BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idYjUPli3CSegQdnT+q0w+doPxgBtV/wSZFOIfdbE8/2qObbsvJTj/ABefdsP0Sgt
	 AqdycdA9F8N9sR4dZmVv9uOKbJ4LzIc4bhlIn1wWhM0b7jLPdxU2wdypAw9WZWjCcJ
	 crRu5Vwdyu+nH+q3xF8gQ9I8T7QqyscmPW9wjUrx/Vbl2GILRpSppcIf7lC3gy3i2R
	 ocAEvAUuXgDYnYZ6Mk3Rz/Lj/Fw6fmjPZD8ey1/Kq4/f0zB8N+/L+3OQbjjxulN6Ah
	 sIKCrYyZtqwK6dE8bT/o8zHpUTZtApb8BtAlDmdPYqRYxllMI7CIHC0/wCf01oog23
	 6AMdStHCax7YA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: SungHwan Jung <onenowy@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jlee@suse.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 92/98] platform/x86: acer-wmi: Add predator_v4 module parameter
Date: Fri, 29 Mar 2024 08:38:03 -0400
Message-ID: <20240329123919.3087149-92-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: SungHwan Jung <onenowy@gmail.com>

[ Upstream commit f9124f2a454a6f1edb4eae9f0646b1a61fd74dba ]

This parameter allows predator laptop users to test and use features
(mode button, platform profile, fan speed monitoring) without
adding model names to acer_quirks and compiling kernel.

Signed-off-by: SungHwan Jung <onenowy@gmail.com>
Link: https://lore.kernel.org/r/20240220080416.6395-1-onenowy@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/acer-wmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 771b0ce34c8f9..ee2e164f86b9c 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -276,6 +276,7 @@ static bool has_type_aa;
 static u16 commun_func_bitmap;
 static u8 commun_fn_key_number;
 static bool cycle_gaming_thermal_profile = true;
+static bool predator_v4;
 
 module_param(mailled, int, 0444);
 module_param(brightness, int, 0444);
@@ -284,6 +285,7 @@ module_param(force_series, int, 0444);
 module_param(force_caps, int, 0444);
 module_param(ec_raw_mode, bool, 0444);
 module_param(cycle_gaming_thermal_profile, bool, 0644);
+module_param(predator_v4, bool, 0444);
 MODULE_PARM_DESC(mailled, "Set initial state of Mail LED");
 MODULE_PARM_DESC(brightness, "Set initial LCD backlight brightness");
 MODULE_PARM_DESC(threeg, "Set initial state of 3G hardware");
@@ -292,6 +294,8 @@ MODULE_PARM_DESC(force_caps, "Force the capability bitmask to this value");
 MODULE_PARM_DESC(ec_raw_mode, "Enable EC raw mode");
 MODULE_PARM_DESC(cycle_gaming_thermal_profile,
 	"Set thermal mode key in cycle mode. Disabling it sets the mode key in turbo toggle mode");
+MODULE_PARM_DESC(predator_v4,
+	"Enable features for predator laptops that use predator sense v4");
 
 struct acer_data {
 	int mailled;
@@ -734,7 +738,9 @@ enum acer_predator_v4_thermal_profile_wmi {
 /* Find which quirks are needed for a particular vendor/ model pair */
 static void __init find_quirks(void)
 {
-	if (!force_series) {
+	if (predator_v4) {
+		quirks = &quirk_acer_predator_v4;
+	} else if (!force_series) {
 		dmi_check_system(acer_quirks);
 		dmi_check_system(non_acer_quirks);
 	} else if (force_series == 2490) {
-- 
2.43.0


