Return-Path: <linux-kernel+bounces-74842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F89785DD2A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECAEE1F218EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2D37C6E9;
	Wed, 21 Feb 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJOzAspe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE0F78B7C;
	Wed, 21 Feb 2024 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524111; cv=none; b=X8uUSWVEgWmSkkqQgk/OAEp00NS0MhhpM+4SVsJ7enFAEYfUcsHOHx6E/J2aguyzSKoG0JjnH2Pf3C3j9z6gQurp0PCO/VlmbdlhUrJGLVGgLJDiYhPZxJ9rU+7yeEpVRekUQuKQZzhBrkxeXOMYQ3Rquf/ItApobky76sJntQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524111; c=relaxed/simple;
	bh=GE0697UuXm6vFYHofIySgfsQscukTkUkSRnVzRFwygs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W6FzaCzlaBcOJhQnIAV4KlGQZin99q1rvSh9JdK9OoWruVHZkz/htIuvc9YHyI6dYxkLIERpDJNRbvTPnTc6iGYgISHzQbDtpR9+vmNnzhVZuVQC/fIbrsQivGpoLfhYaYHbK47xHUoOOkPSAmF3BhKbOCz1u76WPUEyZ3fsHRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJOzAspe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C553C433C7;
	Wed, 21 Feb 2024 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708524110;
	bh=GE0697UuXm6vFYHofIySgfsQscukTkUkSRnVzRFwygs=;
	h=From:To:Cc:Subject:Date:From;
	b=TJOzAspeUcgIe8ZxNoxmbLXrZhK6627MUdEJdgslgSQaQLchr61Kzb7cTsgGIgR6p
	 tnnpaH0Dls1fpM46uBsDhWshIU4ZsN9pdlY6pUvoiErhjeC7rAzmC3LSrJwE91oMFa
	 iyZjci6nmLvS3reTDxpN4i6LShBokiVZp8UAatVIgBxopJHyUrcsQGTIF4mbC2aFmE
	 NefAW5gb3kJm3k5pcz1+5yBlcteCfsWexnB0AmbbtA+RnnHexux8wJM6IMt06NIgSD
	 vr14cdinXxsUPVQ0kJvu7/Ulni73uaz+008yBCfw/3VWjxvaV7ctQY6OizH/DV1GmQ
	 AjoX8oe+hyKkA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	linux-alpha@vger.kernel.org
Subject: [PATCH v2 1/2] alpha: merge two entries for CONFIG_ALPHA_EV4
Date: Wed, 21 Feb 2024 23:01:44 +0900
Message-Id: <20240221140145.2658672-1-masahiroy@kernel.org>
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

(no changes since v1)

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


