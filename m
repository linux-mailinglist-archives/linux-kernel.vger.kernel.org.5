Return-Path: <linux-kernel+bounces-67061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 898D6856591
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4589F293D94
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE997131E32;
	Thu, 15 Feb 2024 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj2Z5EPB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25549129A73;
	Thu, 15 Feb 2024 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006316; cv=none; b=TfLqWrZQ1F/5lbxpIxWhq6LEpHlJ36R9sH9hfIIvLtchCIU43ZP5rw/nE6h79kpIvGmP+cEfY4IPzHpUxw9is9nRPuiTpbFEMxpqoLxOgskpz4qTovARcr7eOKyJC28uR/LnyDnovwfB3lKxDaIyjSH09hspooMq4n96YSB1eFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006316; c=relaxed/simple;
	bh=XYy3bP49P7oTo4EDSM48Irjob5M4yfFqIMI+8HpA4Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R1czyJHtsNcTRjjS9XU3pzLwYEcPvBOHR2myWLTWkdmfZQ8Tt4Tm9o5TYckB59OsBj8jMbiLYguA/s/PQ7hDJu94iNhQJdN77I1V/tZSrzaeCwk5v40un+Dq+7LmbSSARY8WCGbrTsmPbtYT3+FP7bpb2Fp6rW+I6yhIlKrFfjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mj2Z5EPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AC0C433C7;
	Thu, 15 Feb 2024 14:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708006315;
	bh=XYy3bP49P7oTo4EDSM48Irjob5M4yfFqIMI+8HpA4Zk=;
	h=From:To:Cc:Subject:Date:From;
	b=mj2Z5EPBwwjr9MVw11FS1gD+zb68uRxKFzhTOq5vTkyNbIPmLaC4czEwxNn39Ir/T
	 wfbbEbkTAk8+ip05WTU+grx9GdpfPjdUfcoLM2QbCZ7PCsVcNq1DpUa7gIRWEF9W16
	 cseTMk4zU3uIZM7+IFCuzE//qQVtZdv7m33U7menH/AG9XghIIdBell59zNhZMTPzo
	 5TXafuK4Hv3Lsle8kdeX8WZMiNfIt3aIyIFUBmAMcYwzgyADNeYKPDbWiAoCpc2cD0
	 TKQbyU6v62uaesWKBBH+Qae2+2NXzpqMy9hrO81W0hp/uBpV0pQOwzpc+KBiEdD9pv
	 VuuQepdfvEYXA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] alpha: merge two entries for CONFIG_ALPHA_EV4
Date: Thu, 15 Feb 2024 23:11:19 +0900
Message-Id: <20240215141120.1911369-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two entries for CONFIG_ALPHA_EV4, on line 337 and line 368.
Merge them together.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/alpha/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index d6968d090d49..70e8343d00ba 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -338,6 +338,7 @@ config ALPHA_EV4
 	bool
 	depends on ALPHA_JENSEN || (ALPHA_SABLE && !ALPHA_GAMMA) || ALPHA_LYNX || ALPHA_NORITAKE && !ALPHA_PRIMO || ALPHA_MIKASA && !ALPHA_PRIMO || ALPHA_CABRIOLET || ALPHA_AVANTI_CH || ALPHA_EB64P_CH || ALPHA_XL || ALPHA_NONAME || ALPHA_EB66 || ALPHA_EB66P || ALPHA_P2K
 	default y if !ALPHA_LYNX
+	default y if !ALPHA_EV5
 
 config ALPHA_LCA
 	bool
@@ -365,10 +366,6 @@ config ALPHA_EV5
 	bool "EV5 CPU(s) (model 5/xxx)?" if ALPHA_LYNX
 	default y if ALPHA_RX164 || ALPHA_RAWHIDE || ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_RUFFIAN || ALPHA_SABLE && ALPHA_GAMMA || ALPHA_NORITAKE && ALPHA_PRIMO || ALPHA_MIKASA && ALPHA_PRIMO || ALPHA_PC164 || ALPHA_TAKARA || ALPHA_EB164 || ALPHA_ALCOR
 
-config ALPHA_EV4
-	bool
-	default y if ALPHA_LYNX && !ALPHA_EV5
-
 config ALPHA_CIA
 	bool
 	depends on ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_RUFFIAN || ALPHA_NORITAKE && ALPHA_PRIMO || ALPHA_MIKASA && ALPHA_PRIMO || ALPHA_PC164 || ALPHA_TAKARA || ALPHA_EB164 || ALPHA_ALCOR
-- 
2.40.1


