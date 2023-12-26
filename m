Return-Path: <linux-kernel+bounces-11206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5458F81E332
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BB81C213BC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD47842AB7;
	Tue, 26 Dec 2023 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6ZTP91b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7941C63;
	Tue, 26 Dec 2023 00:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7951C433C8;
	Tue, 26 Dec 2023 00:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550055;
	bh=qnBv+MA5+OSvfMweucRioK2vOvMaXE+NW2x5Nw5qGZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6ZTP91bMB4pDNTuiR0MTaJoQ/ulQiRdFkE39gpumZqrpCeiPp1WuBFfVoix3S8uF
	 8uGkzNWHU+7poILA8ULyTJBEzgXiFe4alEjgNgo/Q3AkM+Aa3qA2aWF7eR+DPyWpHg
	 /4Z8MKtP5gJDgC7cBTjhEbY2y4+qtVu+upeqDlJiw/FHGakTJL8Or2mvw7RkPDaFMG
	 JVa4+NutOcnNZQm1DWKgP4NXcOZLsXXgOx1uZqi0pVW5LIIOHCiFRP9eUYTIBWHzn7
	 X5Bnocf/yalDsPnAzsOxzA9sUp1rNz+auV93TW/oPWqi4eCGlg8OaAe6sQGO4gCzeI
	 N4Kk783AfN32g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vineet Gupta <vgupta@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 13/39] ARC: fix smatch warning
Date: Mon, 25 Dec 2023 19:19:03 -0500
Message-ID: <20231226002021.4776-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Vineet Gupta <vgupta@kernel.org>

[ Upstream commit 4eb69d00fe967699b9d93f7e74a990fe813e8d2b ]

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202311280906.VAIwEAfT-lkp@intel.com/
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/kernel/setup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 4dcf8589b708a..d08a5092c2b4d 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -153,7 +153,7 @@ static int arcv2_mumbojumbo(int c, struct cpuinfo_arc *info, char *buf, int len)
 {
 	int n = 0;
 #ifdef CONFIG_ISA_ARCV2
-	const char *release, *cpu_nm, *isa_nm = "ARCv2";
+	const char *release = "", *cpu_nm = "HS38", *isa_nm = "ARCv2";
 	int dual_issue = 0, dual_enb = 0, mpy_opt, present;
 	int bpu_full, bpu_cache, bpu_pred, bpu_ret_stk;
 	char mpy_nm[16], lpb_nm[32];
@@ -172,8 +172,6 @@ static int arcv2_mumbojumbo(int c, struct cpuinfo_arc *info, char *buf, int len)
 	 * releases only update it.
 	 */
 
-	cpu_nm = "HS38";
-
 	if (info->arcver > 0x50 && info->arcver <= 0x53) {
 		release = arc_hs_rel[info->arcver - 0x51].str;
 	} else {
-- 
2.43.0


