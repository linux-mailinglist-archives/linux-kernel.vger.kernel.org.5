Return-Path: <linux-kernel+bounces-117727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBC888AED6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE271C37109
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497364500C;
	Mon, 25 Mar 2024 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="K2GnprUL"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228CA1C692;
	Mon, 25 Mar 2024 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391890; cv=none; b=k6w372om/ln5DQFtmRJDIU9m0pjIYzev17VoN+rBv+7DU0x/1UAHumbuy9mdbwUCHY1Tm907DBq06+Qm97QliViC2o5V5zezvlGDOfRV9G/qcaVbrV8CuaboNBzzj3jiidVlo2zgX104D5QG20jicJlWangUpce9g5AN0hzZcnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391890; c=relaxed/simple;
	bh=viZRDFgQ679+5CJBF0vP+M/VT7GFWhILcghVo56T7is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OObr3v4wtomcrMkAlDytsyS/NdnsNiMrycApOb1nBIKqnaI55bHig8na97N+w5J95UFENh653GvzrXBmnlPtezk8AOC7aLTzLfuHFldr2J1qgBBJlZnlSA6YqtW1f2z0hZabmGn7ijq57Kxsrfcz+IGzW4EbVbeC+iuPp9cJ0wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=K2GnprUL reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 35A0C40E024C;
	Mon, 25 Mar 2024 18:38:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xGuzX56VolEU; Mon, 25 Mar 2024 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711391881; bh=ts5OgcwfchSOjPifiRjEKaKY+SL4SiaTuxvODBQ/mWE=;
	h=From:To:Cc:Subject:Date:From;
	b=K2GnprULN7boAVQdnPtFdnJKnr3cP0qzAqqzZZsqIQSeqbz3h9bP+fm1ST7xda7Yl
	 wRWIfeMM/UJ6W6QDG9frpltC5kGDfoUhvfnAlXixGb7kJp2lLfm5g5JNYmUOgEngFt
	 iFNEL2sLLb/G0QQP6ZzCL1jwiEPItDAVH3DSM9HMs8jw3TjRmNVHlIrbNVEBliNy4z
	 a6P0fYmKNJf5qWg0kHOIbijRfbpBCNdsW5jsNiMtXsWO/VoFlhuULJ6pmQYN7Leo33
	 uG9GFRMKomszW81qoralRsBq+I9aLYWZIyXjrJ3/3vfodWVda4ye+Q5mhpAXuuj6gS
	 +jF0NeqW0BkF8vZzO9XQ8C1n9WEylG7SDpORqbCePIvoJYTa5vMH1O+U2kynBc9T0n
	 Q8SVgKDgIrMHbWhiPKBxXHHSa+LJg5xm8ULJfkcUcC+N77CweyM7WZbhioPZGAZfHv
	 Xnf5/DVkijHLQRQ4v0C7ktBeMTZ5JgzGvDd6m0+9pCgDdlNGneRtWCisAk6K9lD27+
	 bTSgXEV7VT6T25Rii5X8NEqKJPrMGgv2zn25QrhzxTE2kkXaSOWDrOG9OGeVuqOQYF
	 TvqoAOUoDXl2tbfvwKgNJQ0pH9BP3+EwY9ZedjzGBtZ6155EXxaBfRTord13BiR89U
	 AnnBr3iqIiBd42TUWi6RcKzM=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 475BE40E016C;
	Mon, 25 Mar 2024 18:37:57 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: linux-edac <linux-edac@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"anthony s . k ." <akira.2020@protonmail.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] RAS/AMD/FMPM: Fix build when debugfs is not enabled
Date: Mon, 25 Mar 2024 19:37:55 +0100
Message-ID: <20240325183755.776-1-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Have the driver depend on DEBUG_FS as it is useless without it.

Fixes: 6f15e617cc99 ("RAS: Introduce a FRU memory poison manager")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218640
Reported-by: anthony s.k. <akira.2020@protonmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/ras/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index fc4f4bb94a4c..41697e326fa6 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -37,7 +37,7 @@ source "drivers/ras/amd/atl/Kconfig"
 config RAS_FMPM
 	tristate "FRU Memory Poison Manager"
 	default m
-	depends on AMD_ATL && ACPI_APEI
+	depends on AMD_ATL && ACPI_APEI && DEBUG_FS
 	help
 	  Support saving and restoring memory error information across reboot
 	  using ACPI ERST as persistent storage. Error information is saved wit=
h
--=20
2.43.0


