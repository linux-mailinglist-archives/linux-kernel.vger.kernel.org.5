Return-Path: <linux-kernel+bounces-74843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6797D85DD2E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FD82826D6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FC47BB02;
	Wed, 21 Feb 2024 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AewEnIyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1F27E76D;
	Wed, 21 Feb 2024 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524113; cv=none; b=a8MCxUnozlnfByARk7y7CF96hCcZkzEzrwHu5pLYqDVI3IFGW1bOgbCatgJA406TofqEO+9ErC3E04Ejz+7pbVEp31nowRwqyOU4YCDIpHjgIqucNmJbND04kjWGNGjlr088O4Y6HgnKBqUTXjUlPdxmvn4ETQ0vhAfVVTNMK2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524113; c=relaxed/simple;
	bh=tOPetmVZd5nriXjwm0xC4K1pqFu30tsSqsbo9u/5sZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l5N0Ne0/LXbRm0jkFqCVz9UosVbUXq/h9kNl+DdswMap4IRpgzDWHGItKPdO6IXvKz7yOsClL1VRntte4CssB/WEwg/TMtaxVKtaObqUoJ7puP019nyQOzNjcVcihh9tWmLBBAPqyxBWq2bb+C4nVwaAzh1I8IEj9omYfTcd2jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AewEnIyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7018CC433F1;
	Wed, 21 Feb 2024 14:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708524112;
	bh=tOPetmVZd5nriXjwm0xC4K1pqFu30tsSqsbo9u/5sZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AewEnIyy777/EeptGwRt71ElB8skmaU4o+fqRZsSNKKxnS6ImqSO4Eq53iN/eArsY
	 6k+zgEkZxybRB8iV+5YntiKda9vR9/gkcsgyp8bFqFVx+ue3BinNRv9P3Wtlf7n/4u
	 KKm9pUaY1gzwbnI7cVHlGS4txIQ9j2IsvNbOZsfP/S8GP73ffvGVOm4f7cz3brOTvT
	 jGZcYe/94HchbESbwqtw8DTVKYy9AebP7Fg2VnYWDWW76Sb4Bo1uZWMe8l6Pazjt35
	 ba33s958lTY/QFowNdzt0ou96D3U525UQk/C7ZhdApyNBv9LNscUsc7GxXSrs19UNM
	 gVRzyPhaQ2NiA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	linux-alpha@vger.kernel.org
Subject: [PATCH v2 2/2] alpha: merge two entries for CONFIG_ALPHA_GAMMA
Date: Wed, 21 Feb 2024 23:01:45 +0900
Message-Id: <20240221140145.2658672-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240221140145.2658672-1-masahiroy@kernel.org>
References: <20240221140145.2658672-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two entries for CONFIG_ALPHA_GAMMA, with the second one
7 lines below. Merge them together.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Fix the 'depends on' line

 arch/alpha/Kconfig | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 70e8343d00ba..fe5ae3aea999 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -390,16 +390,12 @@ config ALPHA_PRIMO
 	  Say Y if you have an AS 1000 5/xxx or an AS 1000A 5/xxx.
 
 config ALPHA_GAMMA
-	bool "EV5 CPU(s) (model 5/xxx)?"
-	depends on ALPHA_SABLE
+	bool "EV5 CPU(s) (model 5/xxx)?" if ALPHA_SABLE
+	depends on ALPHA_SABLE || ALPHA_LYNX
+	default ALPHA_LYNX
 	help
 	  Say Y if you have an AS 2000 5/xxx or an AS 2100 5/xxx.
 
-config ALPHA_GAMMA
-	bool
-	depends on ALPHA_LYNX
-	default y
-
 config ALPHA_T2
 	bool
 	depends on ALPHA_SABLE || ALPHA_LYNX
-- 
2.40.1


