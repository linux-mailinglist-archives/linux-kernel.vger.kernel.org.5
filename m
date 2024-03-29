Return-Path: <linux-kernel+bounces-125000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8BD891EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079E21C2279B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5081C1B31D3;
	Fri, 29 Mar 2024 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORlXxmYa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8151B31B5;
	Fri, 29 Mar 2024 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716592; cv=none; b=RxKHKgBrpoDFfhG0uj/kB0EelfIgOocvkMsfE0ibBKOUs+fydTVMXGrGv/KB8bRYQBfiBzla+co8sn0rw5ZfRJqEwsVUQ72sTtrcGBnSl0ePfzHQMmPqCi19xigYi1vjvtH7OLlgmhpbhWxRkmeDF9E22Vp9Bcmw4z93KABPRfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716592; c=relaxed/simple;
	bh=9YD3BM9uRahPuP1kXHn2qyvJIJeAECrE7wwxmS57VZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wagj+8/V/kQEanm2Zs1sd6vyDbAxu6fgXEwuLNZKT0RZRdSGEvvc5zzJWq8rbEpSSJ2DawrXmv8WdMCIK9tjIq7SLQpJxWEOu+9g+iznBEuvCVbFs5JJHEyM3cc+LsLFcXSAscmt9O0OJs9m3GVf5EJ5R+TTMpLffDHuFrV0Oyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORlXxmYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAA1C433F1;
	Fri, 29 Mar 2024 12:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716592;
	bh=9YD3BM9uRahPuP1kXHn2qyvJIJeAECrE7wwxmS57VZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ORlXxmYaQkCS45XSffEMW5KBFPdYIDIRg10qIzUESgaPiOBkJNlwMYiQmQGemOQTQ
	 mCdunaaPdbJkBXepb3YXTTaaL38LIgPrieM5DwpkiaU52QOenyR5ipx6lXAuoezsjs
	 pz3rY1ODu2FVOxA2IcF8eC3LwftjT35Qxuclym3HMaU0NbpZWFrudeognhvqDIPZIj
	 DicjOKFUK6AA74wipAk1okzHCzBJHrpRQbOP6wTtJg5FAllU3HFoApyBVEZcZkqsIG
	 V2eiVMYNWxlq5sQAxnRCiqM+Bejz4r0LAiRZbTVAeR1IRRHWMsB2VpPUNnF2XtS0Lc
	 pILTRJN1ShqOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alban=20Boy=C3=A9?= <alban.boye@protonmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hdegoede@redhat.com,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 29/31] platform/x86: touchscreen_dmi: Add an extra entry for a variant of the Chuwi Vi8 tablet
Date: Fri, 29 Mar 2024 08:48:46 -0400
Message-ID: <20240329124903.3093161-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit

From: Alban Boyé <alban.boye@protonmail.com>

[ Upstream commit 1266e2efb7512dbf20eac820ca2ed34de6b1c3e7 ]

Signed-off-by: Alban Boyé <alban.boye@protonmail.com>
Link: https://lore.kernel.org/r/20240227223919.11587-1-alban.boye@protonmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/touchscreen_dmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index ebe959db1eeb9..fbaa618594628 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -1084,6 +1084,15 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI.D86JLBNR"),
 		},
 	},
+	{
+		/* Chuwi Vi8 dual-boot (CWI506) */
+		.driver_data = (void *)&chuwi_vi8_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "i86"),
+			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI2.D86JHBNR02"),
+		},
+	},
 	{
 		/* Chuwi Vi8 Plus (CWI519) */
 		.driver_data = (void *)&chuwi_vi8_plus_data,
-- 
2.43.0


