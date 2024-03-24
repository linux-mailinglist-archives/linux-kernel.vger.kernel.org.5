Return-Path: <linux-kernel+bounces-115507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD31889C02
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3E81F337DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E302237B62;
	Mon, 25 Mar 2024 02:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Stn0laVz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC8E1EC63A;
	Sun, 24 Mar 2024 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320950; cv=none; b=ZaeLtE7r42AOfyGSMQyj9CNC9BAg9+jS8sjO/IYx72voDfg66+9k5Mbw9aPkdQDNrjK4W9KqEEH62X/DZCT/yKGmK6NpHuEqRpCnktQyaGyVql3Z5wpJ5DNZyWCTj6P1DvVLFHp+VxhUU6E7YD0LfoOsj2mSQ4Ayjo51hIECC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320950; c=relaxed/simple;
	bh=kHv9No8I6LDPw0P6eGHj7N9MFtUF53asyk1Zu9Yl0Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atULxyCSJHp6Psi1wL30ITxmsuuf8OPpzPQVchzyZY+WENBArQCcgRrKklBTQXfgUAICthki00bznYzF2UqcXUK3NlRZcdtEwbpMSzYK1nIpbe0R9rSpxUt2CgDUddWfkttGM2k7tJ6V8by5dH5Hyf+OZwYQ4GpxNQDxDESHlrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Stn0laVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59A1C43390;
	Sun, 24 Mar 2024 22:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320950;
	bh=kHv9No8I6LDPw0P6eGHj7N9MFtUF53asyk1Zu9Yl0Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Stn0laVz18FDH1seVx23u1x5kEVXP4ZptfDY/se7kVEfMNfKuzKn2U31R6zXDz5wT
	 xpGzWa6/UjCxq2E6N/s9CwBN51WSov5Xf6A6/YWhIEzxEs0QMsjZo6w1AsfuA0Az3+
	 8agZAPyR6/0PghjfXmHasdMk98RMDyrC/kwvzhjkX6A9Skf5Z0+P4F8XuAZZEsuIFo
	 es8EBpL6/vaNIQT2gpt03dREt+3P5kbSwikt9oEN6ZcKKrAauxdyFPKOQzHB9SGy41
	 QM2wP0pr8A3nVkWRi8g91FvgNCWp1Kiee3ESHVzRwJaFXCGmGn58scBaeGjejZQFpz
	 dUiRvod8t7aJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Akshata MukundShetty <akshata.mukundshetty@amd.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 514/713] HID: amd_sfh: Update HPD sensor structure elements
Date: Sun, 24 Mar 2024 18:44:00 -0400
Message-ID: <20240324224720.1345309-515-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

[ Upstream commit bbf0dec30696638b8bdc28cb2f5bf23f8d760b52 ]

HPD sensor data is not populating properly because of wrong order of HPD
sensor structure elements. So update the order of structure elements to
match the HPD sensor data received from the firmware.

Fixes: 24a31ea94922 ("HID: amd_sfh: Add initial support for HPD sensor")
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
index 70add75fc5066..05e400a4a83e4 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
@@ -90,10 +90,10 @@ enum mem_use_type {
 struct hpd_status {
 	union {
 		struct {
-			u32 human_presence_report : 4;
-			u32 human_presence_actual : 4;
-			u32 probablity		  : 8;
 			u32 object_distance       : 16;
+			u32 probablity		  : 8;
+			u32 human_presence_actual : 4;
+			u32 human_presence_report : 4;
 		} shpd;
 		u32 val;
 	};
-- 
2.43.0


