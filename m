Return-Path: <linux-kernel+bounces-115962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC298898DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7F71F309FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5E7268039;
	Mon, 25 Mar 2024 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIK/KPsu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6B62308DA;
	Sun, 24 Mar 2024 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322233; cv=none; b=YOPMe9muf63qexIlQ5Smvzq1lP0YBex8CPfzKRxLf5FrKRhEVWN3joElBF4HAJYmTnNnE3qLS4QhxxhcL/+RLKkCZ+Ym8NH+fgMhpJsGc8Dzn8HConQFceV2V5/MClE8wWyflnPf2W3Vu2u3yQKmCN3STw3FBNrYAebzRKMrG9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322233; c=relaxed/simple;
	bh=sNhpLvjMeFCtra/NlqSxc7EpcnEV+/QgYQhLbAoVDpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAHJB4TJT07YNeFdU+HPsy848GJi32jiU/TzZJBaJfXo1BFu+UXx6W9Y0WbfRGxuuyglL+guwkh6ZoUmgEMZjZ5ngu5bNWu9ENrV089Z5H8okHSjKi9DHKrevS65oC10LV8iOXTGbuWzMGzgiPTDB7gPgOEzgJm3STZw0t3LLuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIK/KPsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A16C43399;
	Sun, 24 Mar 2024 23:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322233;
	bh=sNhpLvjMeFCtra/NlqSxc7EpcnEV+/QgYQhLbAoVDpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIK/KPsub7sonKRaXCLFta7gokQCbAsqxq8KHwzcXsWfYycyEnjG05CHWQsrAURZi
	 TtkCu85L/fgAxEumdT6XF3H9RsHpJYY/0AXrnCqRk8bs08+yUQXjPt8HdXh3lY8pM7
	 o3UwRGOQMRVgQgi37yB6+ik7g5NH17YAObqlRakFPUYn7cfI4+/Xjv23AQgxh5bsfZ
	 nGbXGGFWEMFtNlYPlvl3DgpRUKB2KZozKR8fz5nsHM8vjXq+dfUE+sSX5CREbZJlDN
	 KywtoHYDzGyU3l2QsLJsRmHZ57Y/8keQKYKPTt+OIvPEMqGGqAQZq3sftc70ICCvOd
	 tddAebK/GsKQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Robert Elliott <elliott@hpe.com>,
	Christoph Biedl <bugzilla.kernel.bpeb@manchmal.in-ulm.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 314/451] crypto: jitter - fix CRYPTO_JITTERENTROPY help text
Date: Sun, 24 Mar 2024 19:09:50 -0400
Message-ID: <20240324231207.1351418-315-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit e63df1ec9a16dd9e13e9068243e64876de06f795 ]

Correct various small problems in the help text:
a. change 2 spaces to ", "
b. finish an incomplete sentence
c. change non-working URL to working URL

Fixes: a9a98d49da52 ("crypto: Kconfig - simplify compression/RNG entries")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218458
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Robert Elliott <elliott@hpe.com>
Cc: Christoph Biedl <bugzilla.kernel.bpeb@manchmal.in-ulm.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index d779667671b23..edf193aff23e7 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1285,10 +1285,11 @@ config CRYPTO_JITTERENTROPY
 
 	  A non-physical non-deterministic ("true") RNG (e.g., an entropy source
 	  compliant with NIST SP800-90B) intended to provide a seed to a
-	  deterministic RNG (e.g.  per NIST SP800-90C).
+	  deterministic RNG (e.g., per NIST SP800-90C).
 	  This RNG does not perform any cryptographic whitening of the generated
+	  random numbers.
 
-	  See https://www.chronox.de/jent.html
+	  See https://www.chronox.de/jent/
 
 config CRYPTO_KDF800108_CTR
 	tristate
-- 
2.43.0


