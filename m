Return-Path: <linux-kernel+bounces-124804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9CD891CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A120286FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01E819069D;
	Fri, 29 Mar 2024 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrEVfMEl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC2190681;
	Fri, 29 Mar 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716163; cv=none; b=Yw3SQ/McSnT1iIoL+SPgpW0+bT27nCkNtCdx3A82/Ju56MPhON1LSZLQ/z6BSrxcTw28RetdvzvYP2Yxstk8TrN/ScK2HAki9w3siJppevx0+gqd7NxhdMb2BlNAl8yqqg4Ac/BGhBs7jxphBasoXO68Vi8N4vrGUkQSQ6Vf2Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716163; c=relaxed/simple;
	bh=2xC5XMYS0wCtsfNCx5VDLX0oiPi8F81qE/iLV7BLswc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcoKPCxaN+yJ6fCL1rThlnBCEKKLyK3d6DLN0shVg/jT61jWBc5usoswsHzBZU9R6VMl7zN6/wH0Az+gLysroP2wlH0GIR59LHcU3gKQh6wYFf1E1Yl/dvwrbJTfpwxLjbFYGc7XcYXiqfD2RVsYqFzvbbLmKxa1VH4P9c05NEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrEVfMEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76FBC43394;
	Fri, 29 Mar 2024 12:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716162;
	bh=2xC5XMYS0wCtsfNCx5VDLX0oiPi8F81qE/iLV7BLswc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jrEVfMEljhexTio74B6pjEP67gH2S2WJDSapadCnK7oNulO0cn4WMNFaZusmzG/tF
	 WMQ7cckerAUq0+ErkscTOFPrdb8nk2jXrPcCXaIQRuUlCd2qPxZpsslW7iONIBEH+e
	 Il9pEqa9Y+X+cO6OCG+BZUCnAhsESECcSbyREMIAzkxeiHXkMH/gRPubZRxm7IZ7Fa
	 r2KCDFMGuhHJ3RDLIOJdI8JlEd4PYK9XYHS6eDI0xLLiOoihayfCtcrVtfPlIi/OcH
	 LAAsFJ53gqFFkBdRNrGvW/d3XCIdA5jCVbhe543I3UxLVUmZJ6/BYgOVMnRl899F6b
	 nMafSvJ5MUN4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alban=20Boy=C3=A9?= <alban.boye@protonmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hdegoede@redhat.com,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 93/98] platform/x86: touchscreen_dmi: Add an extra entry for a variant of the Chuwi Vi8 tablet
Date: Fri, 29 Mar 2024 08:38:04 -0400
Message-ID: <20240329123919.3087149-93-sashal@kernel.org>
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
index 975cf24ae359a..c6a10ec2c83f6 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -1217,6 +1217,15 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
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


