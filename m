Return-Path: <linux-kernel+bounces-125170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6516A89219D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D6B1C25790
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E22B86269;
	Fri, 29 Mar 2024 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGZJBVVy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2DB65E20;
	Fri, 29 Mar 2024 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729606; cv=none; b=t3PgCALxcqOdbQnEHjCk1aJrwgHDnuLRaC+gC4r5k1jV19XpSzh4MeByKICH2gsT+A/ZxXRC79NPggqlP0y/f98YvCxF0icURUprZOE8nfeUivf81hQIVQ9brZ28ycdJzFV0YGGS77I6ECkLS2Fo/y4nzP72WNqUf2ezCbbSl3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729606; c=relaxed/simple;
	bh=QOrM8kFtO8tJJp57UV2H0I4R7+PFvYwNJQA3ikefxuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JPxjjBvMnvFeT2JoiCmJsEKRRoQUnAhjnBBJimUvo1j0qfvWGn47md7PEZLRIihCFMdtgzcEgkbxIZppC4w3iUpvi8ZOujtfrCUA5CySPDRYS8a2dIO8UQ2cmXmBS2y+0XpAzzw+DGMLxPC2TG1rb9xcRhbwpotZNnqxxSPqsEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGZJBVVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93AD0C433C7;
	Fri, 29 Mar 2024 16:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711729605;
	bh=QOrM8kFtO8tJJp57UV2H0I4R7+PFvYwNJQA3ikefxuA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=uGZJBVVyMNnruOLAEvLgFi6Wbey8dT5XXSEB9oj+TttR+ue+xzBaV4uni1l/IdnlJ
	 dLAFNTsSnIYCUT1fRPOONO4h0inDto0JMiDYxkCE1EIFvXDhpy8fCd69NbQCWHB75O
	 3y9H6reS10rDWNtL8NFYzils3XyJ/mO8aTZIsduXmA020uedSjTovw/HlZKKpf74sj
	 jLCl3C1muIK5K2NL+wIeJ0H29OKbjwWQs3MWqirAseL/SL2QlZ9kfmg9CVgW1f9YwR
	 Ki77TulayzTcZb1FvKObhY+nTObPoCANqQmTgduPIRf39rwiFH0j8z6D28IwtFECRU
	 02rFtMlgXE6Ew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856FDCD1283;
	Fri, 29 Mar 2024 16:26:45 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.neuschaefer.gmx.net@kernel.org>
Date: Fri, 29 Mar 2024 17:26:27 +0100
Subject: [PATCH] rhashtable: Improve grammar
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240329-misc-rhashtable-v1-1-5862383ff798@gmx.net>
X-B4-Tracking: v=1; b=H4sIALLrBmYC/x3MTQqAIBBA4avErBPMEqurRAvTMQf6w4kIorsnL
 b/Few8wJkKGvngg4UVM+5ZRlQW4aLcZBflsUFI1sladWImdSNFyPO20oPBGmxbboNBryNWRMND
 9H4fxfT9eQrX2YQAAAA==
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711729602; l=2864;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=ll377MzgwIQchZuz5guGR9RosFjEvQ8Y2LJidGKOZAc=;
 b=AKOA/sMoOEeDv3OZC6kh4SdqPyBCnKK/fx9cHhz8d/3X5L9//4ew+HbZUu8eK/ktTA2IFyyDA
 e9q1mpM3YX0A+c3gyOeENJ0NEGnPe00oAjnnQ0ysO6FLUW3oE3b0/AX
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.neuschaefer@gmx.net/20240329 with
 auth_id=149
X-Original-From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Reply-To: j.neuschaefer@gmx.net

From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Change "a" to "an" according to the usual rules, fix an "if" that was
mistyped as "in", improve grammar in "considerable slow" ->
"considerably slower".

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 include/linux/rhashtable.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 5b5357c0bd8c4..8463a128e2f48 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -633,7 +633,7 @@ static inline struct rhash_head *__rhashtable_lookup(
  * @params:	hash table parameters
  *
  * Computes the hash value for the key and traverses the bucket chain looking
- * for a entry with an identical key. The first matching entry is returned.
+ * for an entry with an identical key. The first matching entry is returned.
  *
  * This must only be called under the RCU read lock.
  *
@@ -655,7 +655,7 @@ static inline void *rhashtable_lookup(
  * @params:	hash table parameters
  *
  * Computes the hash value for the key and traverses the bucket chain looking
- * for a entry with an identical key. The first matching entry is returned.
+ * for an entry with an identical key. The first matching entry is returned.
  *
  * Only use this function when you have other mechanisms guaranteeing
  * that the object won't go away after the RCU read lock is released.
@@ -682,7 +682,7 @@ static inline void *rhashtable_lookup_fast(
  * @params:	hash table parameters
  *
  * Computes the hash value for the key and traverses the bucket chain looking
- * for a entry with an identical key.  All matching entries are returned
+ * for an entry with an identical key.  All matching entries are returned
  * in a list.
  *
  * This must only be called under the RCU read lock.
@@ -699,7 +699,7 @@ static inline struct rhlist_head *rhltable_lookup(
 }
 
 /* Internal function, please use rhashtable_insert_fast() instead. This
- * function returns the existing element already in hashes in there is a clash,
+ * function returns the existing element already in hashes if there is a clash,
  * otherwise it returns an error via ERR_PTR().
  */
 static inline void *__rhashtable_insert_fast(
@@ -1130,7 +1130,7 @@ static inline int rhashtable_remove_fast(
  *
  * Since the hash chain is single linked, the removal operation needs to
  * walk the bucket chain upon removal. The removal operation is thus
- * considerable slow if the hash table is not correctly sized.
+ * considerably slower if the hash table is not correctly sized.
  *
  * Will automatically shrink the table if permitted when residency drops
  * below 30%

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240329-misc-rhashtable-d7578e8f2ed5

Best regards,
-- 
Jonathan Neuschäfer <j.neuschaefer@gmx.net>



