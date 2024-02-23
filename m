Return-Path: <linux-kernel+bounces-78256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BB18610D2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F58286744
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24BC7A722;
	Fri, 23 Feb 2024 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7ut2uuV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159467D418
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689125; cv=none; b=YFUTi1fSdzKUN7Z+sdsxeUm/Jm1/cu+gETGeoYiH3z22lCf7bmsus8yrGb944xH2Ckrs7WCYnlepPsphrY/AwAzWql+ALZ5SpACKPPwNWl/gdVPonsvhCODPaArr6GAX+DOCUOBuLkZyCnfZ6GafsjErwJB2H74cCUTu1tYSenM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689125; c=relaxed/simple;
	bh=mGgNsYPzZ25IdsQy+436tZTCd+Dedkm6W3A4qITGUiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZqjNOA3cr3Cn0fwHXoWVh49t9DDO6LTP0nzI+jl1qRiU1JdpeVflBUoyh8YJJj/Q5Frs8TKO+dw4W6FVva8ALziKmB8dtp00OsmxXOmrgMiGvwZNt74FuCYvfzRyS1m/myZD2aqaSQYQQehB7jpbLIg0g4jVM1aN3KUeEakPNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7ut2uuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE11C43399;
	Fri, 23 Feb 2024 11:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708689124;
	bh=mGgNsYPzZ25IdsQy+436tZTCd+Dedkm6W3A4qITGUiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r7ut2uuVDj2VUFcFQJzZriprXKbw91IgHM8eAGM7mn4xoxeB/x+9/xY7Ui5aLNjSZ
	 g2xQAh4q7/i019vO0wmF7aoYsd7Rqr7O2sbgEKP6jmokQMiF6/fWLb1wYRX80em5vR
	 hKHSvifiuQuWzy+u9EB4W0I5Tn2C3xR51rEGkW/K1JWzn1CxRgM4cXFUO0XkbJC8zn
	 cjB40UedVPVE8PHDYqgU9ZEtbbBmSdCt9/E4tPGZQzqVpymEnaVNI5FKenzZ3xbyCw
	 pk2LZEfsKSAB90f73OQX2KwyWK37qpm+5AWYjBWTVg8CujLQwBbAzpPjXrqF492lVw
	 WAZfyYR97htPA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: stefani@seibold.net
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/4] kfifo: fix typos in kernel-doc
Date: Fri, 23 Feb 2024 12:51:55 +0100
Message-ID: <20240223115155.8806-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223115155.8806-1-jirislaby@kernel.org>
References: <20240223115155.8806-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Obviously:
"This macro finish" -> "This macro finishes"
and similar.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Stefani Seibold <stefani@seibold.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/kfifo.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 0491bc526240..d8533e700bed 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -584,7 +584,7 @@ __kfifo_uint_must_check_helper( \
  * @buf: pointer to the storage buffer
  * @n: max. number of elements to get
  *
- * This macro get some data from the fifo and return the numbers of elements
+ * This macro gets some data from the fifo and returns the numbers of elements
  * copied.
  *
  * Note that with only one concurrent reader and one concurrent
@@ -611,7 +611,7 @@ __kfifo_uint_must_check_helper( \
  * @n: max. number of elements to get
  * @lock: pointer to the spinlock to use for locking
  *
- * This macro get the data from the fifo and return the numbers of elements
+ * This macro gets the data from the fifo and returns the numbers of elements
  * copied.
  */
 #define	kfifo_out_spinlocked(fifo, buf, n, lock) \
@@ -739,7 +739,7 @@ __kfifo_int_must_check_helper( \
  * @fifo: address of the fifo to be used
  * @len: number of bytes to received
  *
- * This macro finish a DMA IN operation. The in counter will be updated by
+ * This macro finishes a DMA IN operation. The in counter will be updated by
  * the len parameter. No error checking will be done.
  *
  * Note that with only one concurrent reader and one concurrent
@@ -790,7 +790,7 @@ __kfifo_int_must_check_helper( \
  * @fifo: address of the fifo to be used
  * @len: number of bytes transferred
  *
- * This macro finish a DMA OUT operation. The out counter will be updated by
+ * This macro finishes a DMA OUT operation. The out counter will be updated by
  * the len parameter. No error checking will be done.
  *
  * Note that with only one concurrent reader and one concurrent
@@ -807,7 +807,7 @@ __kfifo_int_must_check_helper( \
  * @buf: pointer to the storage buffer
  * @n: max. number of elements to get
  *
- * This macro get the data from the fifo and return the numbers of elements
+ * This macro gets the data from the fifo and returns the numbers of elements
  * copied. The data is not removed from the fifo.
  *
  * Note that with only one concurrent reader and one concurrent
-- 
2.43.2


