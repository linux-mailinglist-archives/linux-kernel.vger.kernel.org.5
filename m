Return-Path: <linux-kernel+bounces-114334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28538888FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA16D1F29FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4D5170A3B;
	Sun, 24 Mar 2024 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAhVzytY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D4D212D15;
	Sun, 24 Mar 2024 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321723; cv=none; b=juABazKVh8ijjdDIHcQGZU/iCqRJKF2j94WGt3UwVQHblU/QqmOUwPzIkepiDc26WsbAZP0VKk9SglGDhVVn4CVT3qnBitN2G6gYdrsBO1E10WCiTYSENJV020ExyMZIoM3jSe81zEjl29pP97yJ2nXqmeapxeGmmAllmBnbjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321723; c=relaxed/simple;
	bh=bEFwOH24HrKwMPXmCzemBmSfiw4FFBe+8kr1qdnfUho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwuqDn8CrHjxY/b+aTV0d8ckvhTeaB9/J49WADBaqUhMpJfTHh/Cdv6yz1X+U3A2FM3xSdVdPXIRxPOYKcUp92F+wYtpZy/m+CUCH2kM+Uap1PAVd5jmlf7/nsw0KQ6poW15UlxRXEmTstelran4kpF1jIKmMWvBZ9N5yLO0Z68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAhVzytY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDB7C43394;
	Sun, 24 Mar 2024 23:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321722;
	bh=bEFwOH24HrKwMPXmCzemBmSfiw4FFBe+8kr1qdnfUho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAhVzytYjAmVfuNtRTsyWmquSADp8dr2jcbjWAg8zMgFC8yepmtONPQEtm4+4vBfr
	 n5aebm2O1xMtdYPhBYF5b2L5Okz6uO2Z45RlSI7mP9eoLldzsh0At576JI9/qIBiuJ
	 8vfwO1XU8l1Kc1B7wFudGg7mnAkXTkkQ8FcLlDT602Mk1UZP6S7x/KnS3r6Ijh7aob
	 2l4CFh9raSPZV/HYU2t+i2minuMCsVkDJ1jc5ylxJIF/gjPNKO5AnrKKnwFkA7RN7r
	 tIYUQAgsxCkE2zhRHmhIz4kdeAgPw9cQn/DHlRICxkNlbckmTWRuOrkaz6VL96wp8M
	 7E9eCvfpBQCvA==
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
Subject: [PATCH 6.6 450/638] crypto: jitter - fix CRYPTO_JITTERENTROPY help text
Date: Sun, 24 Mar 2024 18:58:07 -0400
Message-ID: <20240324230116.1348576-451-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 650b1b3620d81..fc0f75d8be01d 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1291,10 +1291,11 @@ config CRYPTO_JITTERENTROPY
 
 	  A non-physical non-deterministic ("true") RNG (e.g., an entropy source
 	  compliant with NIST SP800-90B) intended to provide a seed to a
-	  deterministic RNG (e.g.  per NIST SP800-90C).
+	  deterministic RNG (e.g., per NIST SP800-90C).
 	  This RNG does not perform any cryptographic whitening of the generated
+	  random numbers.
 
-	  See https://www.chronox.de/jent.html
+	  See https://www.chronox.de/jent/
 
 config CRYPTO_JITTERENTROPY_TESTINTERFACE
 	bool "CPU Jitter RNG Test Interface"
-- 
2.43.0


