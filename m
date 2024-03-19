Return-Path: <linux-kernel+bounces-107336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E6A87FB32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD54B282C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F51C7D09C;
	Tue, 19 Mar 2024 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFLPImIo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FBC7E797;
	Tue, 19 Mar 2024 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842015; cv=none; b=k8RXYcHAEuOpQ3G/O5NF1dfh/5gJo2qQfGH/ErIBvWxX/ZQkMmZ+H57mC8w4dMLc1eB5vMJpwMWLfbtinH9eUSKIIggMmpApQjH5g1rmdb+77UhGHHhfuTBku8r/G7SudZRgQhnppW3DdmGwpni9Ez0V3vhDi1kder6W2M+sDhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842015; c=relaxed/simple;
	bh=mGgNsYPzZ25IdsQy+436tZTCd+Dedkm6W3A4qITGUiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSP4wVjT5PF3/uQB6V787ZdPgdT6pl2VvLmw+X3xTniBe2nZ8XoAaXUZ2s74NkkskTQz9Gr6GeP82YAEJUmUeXl39FD+SdRs8BHd4k5WL2QHrNRJ+ihKrvCJQqyq4ccd4puLyQWKU2oSHFDwqAjXw5BQ044c7F9eGxaBlV2YKn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFLPImIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8D5C43390;
	Tue, 19 Mar 2024 09:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710842015;
	bh=mGgNsYPzZ25IdsQy+436tZTCd+Dedkm6W3A4qITGUiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nFLPImIowfUp+tvWFfch8PYBZqx5vs6IAUBVIwLYJAECN+nIr4DyFZ0oaWhIjdUPQ
	 YGx2dpOru2ZKTCajDGvH5GO0kvjo9u5wV/zlopJkPAZs7K4tomBYAcrx9pbxqQw040
	 eJB7ZsYdOj4a3FDq/w5fz8WSEh1EXssO3Xpv8rBCDuU8I5vQ2jXnOguKT1LfAM4TAl
	 vhT1rcX8wv2rpCGIW89MjbYkncGLs2fllMiPQg3cq43jIVNXmX9Q1lDuYgO4lmV7W+
	 nvVr6/C0/m8AWeh3rwQ3whQ7rxro/RVscSSDYOqotpKAvGNvCowU+CT5rUIvvl8JIK
	 mNxTDgWMcgHBg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/4] kfifo: fix typos in kernel-doc
Date: Tue, 19 Mar 2024 10:53:03 +0100
Message-ID: <20240319095315.27624-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319095315.27624-1-jirislaby@kernel.org>
References: <20240319095315.27624-1-jirislaby@kernel.org>
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


