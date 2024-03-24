Return-Path: <linux-kernel+bounces-115516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BB3889C17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2AAA1F35A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BD323C3EC;
	Mon, 25 Mar 2024 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRJ05uII"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5954112B160;
	Sun, 24 Mar 2024 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320966; cv=none; b=rY1R9y0TzKUGn0uEHWD8rm9hiIygp2ymrHlSwfFLqPpM7EGYV3Rd5YNfhc891r/ezQlZwAJPRlQpsHSWrMsbRsUNhOclajs5GBf1LPberwHuQ0GmBnBEtoGUcO6lL/5CwMtVypSvenB37X4RcOflRL4E+asTjaHeHmU0H1JQjtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320966; c=relaxed/simple;
	bh=c4K8ZsQm+zOTS2fUOLLnP8gSNrKbnjB+6Do1gx198Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5RRJmdNKDpx1fmFnoOrZmJ2LfspdZCioe4NHUXu6/NgrTdloLoMCJbCkIMPO04nFaunpW0DJYbIDfKrLPTJT2Jq1qH9igG4Wr4h674kU+LVTPGY8WQd360dsGjfdQco4Z4KdnlSTDTJFzojTKLxk3GbnuHM2T86I7QK99UK8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRJ05uII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99081C433F1;
	Sun, 24 Mar 2024 22:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320965;
	bh=c4K8ZsQm+zOTS2fUOLLnP8gSNrKbnjB+6Do1gx198Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRJ05uIIiJu0NsmI/R5GSFkgZTbFVw+TRPChuIimlFd4L8ZIfN+vt06u7jCbU06t+
	 pZAQfcnD+pHym0NlZbflO2KnjJP1nUuQudeOOG3sf5uuT35TWpnlLtdRpOVn5SNN70
	 aK0owvnOaOp/poECNr9/Egu5XcfB17FOggq2pNdimlOmy1wT2dyPxW/fyu21aV3I6k
	 oYR5apDE6SscYTQAfTGhGtIYwuSo8oVhIHvun6goSkmO1frI1Xt/gRBmfrmDtL0mgR
	 lLZx4aj577CMs++JmlMcBy61haaG2cYs5i0srif9sgRQ8nM809mQwIcOD2na8jDWl1
	 j+PWLDyGC95UA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 528/713] powerpc/32: fix ADB_CUDA kconfig warning
Date: Sun, 24 Mar 2024 18:44:14 -0400
Message-ID: <20240324224720.1345309-529-sashal@kernel.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit b72c066ba85a131091498a15a62d6068997278a4 ]

Fix a (randconfig) kconfig warning by correcting the select
statement:

WARNING: unmet direct dependencies detected for ADB_CUDA
  Depends on [n]: MACINTOSH_DRIVERS [=n] && (ADB [=n] || PPC_PMAC [=y]) && !PPC_PMAC64 [=n]
  Selected by [y]:
  - PPC_PMAC [=y] && PPC_BOOK3S [=y] && CPU_BIG_ENDIAN [=y] && POWER_RESET [=y] && PPC32 [=y]

The PPC32 isn't needed because ADB depends on (PPC_PMAC && PPC32).

Fixes: a3ef2fef198c ("powerpc/32: Add dependencies of POWER_RESET for pmac32")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Tested: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240211221623.31112-1-rdunlap@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powermac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
index 8bdae0caf21e5..84f101ec53a96 100644
--- a/arch/powerpc/platforms/powermac/Kconfig
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -2,7 +2,7 @@
 config PPC_PMAC
 	bool "Apple PowerMac based machines"
 	depends on PPC_BOOK3S && CPU_BIG_ENDIAN
-	select ADB_CUDA if POWER_RESET && PPC32
+	select ADB_CUDA if POWER_RESET && ADB
 	select MPIC
 	select FORCE_PCI
 	select PPC_INDIRECT_PCI if PPC32
-- 
2.43.0


