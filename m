Return-Path: <linux-kernel+bounces-67028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFC3856506
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707B51F2901C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5166D131753;
	Thu, 15 Feb 2024 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEwU5uSl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8B712FF88;
	Thu, 15 Feb 2024 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005248; cv=none; b=DucGMEiYa5QVX/HuJbQR/V87LF95oe/iaMxbfEMDRYe7VjrzrOHyrB70cnWzEikuOpMWYZUcYD7jNJcGjFny8prdcaszRWnbhX8ZtKcgT9oXHBKvM/nAMcyG081NfmU/OM4zdXoQZ+5bBseEf7nezGtZwIoKPzmEUBI1LeqSSZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005248; c=relaxed/simple;
	bh=n69g760oqJtfdIPmojCNzHW8ipClX64Jsl5E2Nt2zdU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X7C/b1ToZHniz9aqheUYc9ep2gPl1hO7+QJJhIn0mPuQ1i4XtpWxpx8eblt3UPfOgWLhc3zl/fxXBd4KLJ+VEiMyRSyUOd6kysHHC2LtNyL3nlZfQEwJfO2Qx5LjdOurmCBQxv8EL4xi0JgvIh5xfdQJFuOnaux7sKtmyO5E9dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEwU5uSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA683C433F1;
	Thu, 15 Feb 2024 13:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708005248;
	bh=n69g760oqJtfdIPmojCNzHW8ipClX64Jsl5E2Nt2zdU=;
	h=From:To:Cc:Subject:Date:From;
	b=KEwU5uSlEvQIwFWbYsV9xqLkAF3SPwgyg6NFYK64S8u0lnJdAox77QPHab9L8f2vb
	 fRgtKzRzg81HK0LLGjPOL2mhX61w9FAsOIafRTDl7HgxJ7x63mCuI7e9//TKlOBrR4
	 WcuZokS1qfbqHhPCX638GQEQA5xW67DHZ4VTWEZTpohno32iw0LRXsAV3/dU4V2/Jb
	 HWBKuPezAPZFET9ag99lUbtiXnZMeGolHBKCsZrzfPUJeondRYlwmv2qjPMnIt2AhX
	 ZwkabCmTsCOzAEV84beLpuwTHqKOVNRIjzcZTny+GiPQ8iLvrbg3W6mZ4RpUh9VCJb
	 sBLfOUZNG7mtA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-sound@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: seq: remove redundant 'tristate' for SND_SEQ_UMP_CLIENT
Date: Thu, 15 Feb 2024 22:53:04 +0900
Message-Id: <20240215135304.1909431-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'def_tristate' is a shorthand for 'default' + 'tristate'.

Another 'tristate' is redundant.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 sound/core/seq/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/core/seq/Kconfig b/sound/core/seq/Kconfig
index c14981daf943..0374bbf51cd4 100644
--- a/sound/core/seq/Kconfig
+++ b/sound/core/seq/Kconfig
@@ -71,7 +71,6 @@ config SND_SEQ_UMP
 	  among legacy and UMP clients.
 
 config SND_SEQ_UMP_CLIENT
-	tristate
 	def_tristate SND_UMP
 
 endif # SND_SEQUENCER
-- 
2.40.1


