Return-Path: <linux-kernel+bounces-113364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B558883BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61B81C21994
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B787A19D1A5;
	Sun, 24 Mar 2024 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrxSzL3b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848C19CAF1;
	Sun, 24 Mar 2024 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320166; cv=none; b=Yw6Opx9sh9KRO2p65ebzbxUEwINFfXhonjKvofVk2gQdPTPMLTcy/7jY8x0dQcwT69px+O+2z6eKhMMGUoAjxH7XcOuiam50cRl5U7gqtkMrAqNWbhOO3ybDCy5CN2OUr6QhiVWPM45CRTp/8rW5g2p8HQk02WK+38n7iNdiAGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320166; c=relaxed/simple;
	bh=Pwr9JTI1lW88i45ASza7K28OaiCIZy6DkegWIHpOUZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2ghyTYJcF0ANJWFJZ5P+V3CO3k5nug+e+6o6g9ow4gmglVkptYrLsT6g+nL9qpV0FU/qvh1eH1zK1KUIbAA07Zaes1VG0Pzbea3AgxxD39p37F87PSBM28DetEMTvMj821rNfLJ4FIWn0h/BH73JgYGupkxPhevRkIYhwVPHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrxSzL3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F42C43394;
	Sun, 24 Mar 2024 22:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320165;
	bh=Pwr9JTI1lW88i45ASza7K28OaiCIZy6DkegWIHpOUZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QrxSzL3bHgMvrgocDKjYKqqXD6IiMtSRRakIJmcCaBGJVAbG9kfOodnOmOexeyLRC
	 FRk/Qzky7u5bqgdIjv24hUY7tVK3qr3NGS+hHqQ3SBENRhlIot7JHPLeyOf4WyiaqX
	 UiUNJbm7GV/yhu8XhkQA5gQLVT7voCl5yrKl6Ma0DvuyQik4YtaT2B7LVoGAL+ZcdM
	 J3rdgYKYTEaUmUgaWQwhaYDbOJRKkYQkPMsbVZKdjdIsX+N/C5jkGyIUzdEK+zDIg8
	 77lEIttNdJjgytcSkPEqG7pxnjLXLAaWFuiU2mYw5fYxi4lHlpOmr8aQ2VTE/XXRKm
	 nRTp8+2gbBGFQ==
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
Subject: [PATCH 6.8 473/715] crypto: jitter - fix CRYPTO_JITTERENTROPY help text
Date: Sun, 24 Mar 2024 18:30:52 -0400
Message-ID: <20240324223455.1342824-474-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 7d156c75f15f2..44661c2e30ca5 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1269,10 +1269,11 @@ config CRYPTO_JITTERENTROPY
 
 	  A non-physical non-deterministic ("true") RNG (e.g., an entropy source
 	  compliant with NIST SP800-90B) intended to provide a seed to a
-	  deterministic RNG (e.g.  per NIST SP800-90C).
+	  deterministic RNG (e.g., per NIST SP800-90C).
 	  This RNG does not perform any cryptographic whitening of the generated
+	  random numbers.
 
-	  See https://www.chronox.de/jent.html
+	  See https://www.chronox.de/jent/
 
 if CRYPTO_JITTERENTROPY
 if CRYPTO_FIPS && EXPERT
-- 
2.43.0


