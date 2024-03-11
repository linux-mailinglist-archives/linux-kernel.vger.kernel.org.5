Return-Path: <linux-kernel+bounces-98973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC618781C0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29B61F229BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD0C42065;
	Mon, 11 Mar 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tXydkk09"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD5E41236;
	Mon, 11 Mar 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167824; cv=none; b=mX9iP6rcpJPBfMx6nz48k7x3eSklFwVWeaj9r4GQjHCVzKJ48nVtekLqEj5IBOm8yX32O0kNLbmhS5yHzfQ2KG8qJXyG9pmsfT7+g//6U3l5NlJs5E8RW04xz5852yq5KJgwTQQ+ajPgnn+eE5UKLpZtJqvc/VqLqExQL7tWZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167824; c=relaxed/simple;
	bh=xV3mfmooKuHKOZRsW6Ju1vuf71tCKRTrqOwkJmIhNYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RL/Lep9M4TRjPCw8EWa3K6o6mD4plmRDfwvNsFoFa/JV6y+4jyhOZfwTsSTwpjW6lnrZCK4if4P2jrUgSHtibBN4mS+4uaftAeWU47b4cOSASk1kUp7gSkPZAWwk/m+DMVZC/heg1PxvNFcqe9pvRu/OsFh0wkXM801CaJA5wdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tXydkk09; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710167821;
	bh=xV3mfmooKuHKOZRsW6Ju1vuf71tCKRTrqOwkJmIhNYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tXydkk09ykO9Jk9RfZphYwABfRpMwSKeP9nvOwPyalsb5dLb/giICI6NzPaPNzecc
	 UPRouqI2i8zBat+k0HXwjUoeZPVBTwpN5+AHLcaRqEPu3h6BwtCrQtb4gGBEhJte+r
	 0ik6kVPINg8WPu2FhCFAG116Zv6NBgFGkEdces8cuGhvcmeeKZmbrrC5Kbc+qyFvNz
	 HcK6EwHcX6lelXKEVPli4XYYN+s/lepj565GQ5Mpz3CqH5CnbfS789l563F5X1VJRj
	 SghFDfnhxvQiKWZGC8Mm/5icc4giGX2ipnBLzTh5JUPGSuSzYT4jfThwRVzZeTYghB
	 rGSTHkeMemucg==
Received: from [192.168.1.36] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 858CB378206B;
	Mon, 11 Mar 2024 14:36:59 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 11 Mar 2024 10:36:16 -0400
Subject: [PATCH v2 2/2] docs: handling-regressions.rst: Update regzbot
 command fixed-by to fix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240311-regzbot-fixes-v2-2-98c1b6ec0678@collabora.com>
References: <20240311-regzbot-fixes-v2-0-98c1b6ec0678@collabora.com>
In-Reply-To: <20240311-regzbot-fixes-v2-0-98c1b6ec0678@collabora.com>
To: Thorsten Leemhuis <linux@leemhuis.info>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, regressions@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 workflows@vger.kernel.org, Chris Bainbridge <chris.bainbridge@gmail.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

On the reference documentation for regzbot, the fixed-by command has
been renamed to fix. Update the kernel documentation accordingly.

Link: https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
Link: https://gitlab.com/knurd42/regzbot/-/commit/6d8d30f6bda84e1b711121bb98a07a464d3f089a
Reviewed-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 Documentation/process/handling-regressions.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/handling-regressions.rst b/Documentation/process/handling-regressions.rst
index 42b13f77b019..ce6753a674f3 100644
--- a/Documentation/process/handling-regressions.rst
+++ b/Documentation/process/handling-regressions.rst
@@ -432,7 +432,7 @@ or itself is a reply to that mail:
  * Mark a regression as fixed by a commit that is heading upstream or already
    landed::
 
-       #regzbot fixed-by: 1f2e3d4c5d
+       #regzbot fix: 1f2e3d4c5d
 
  * Mark a regression as a duplicate of another one already tracked by regzbot::
 

-- 
2.44.0


