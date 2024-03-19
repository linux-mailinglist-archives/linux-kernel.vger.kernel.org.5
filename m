Return-Path: <linux-kernel+bounces-107341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF9A87FB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE83A1C21BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B8F7F7FF;
	Tue, 19 Mar 2024 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/GocJNN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8467F7EE;
	Tue, 19 Mar 2024 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842024; cv=none; b=XKtxdu2uA9iNjXZ4hD0UrqFdM6VVLxPWX+o+0LdHabb+TW6Qehy8TYvXArVG2Gj/MllvOml/XpAapD2KZKB7iCloSyOyPOXwLhjUeF3qIP3iDrDQ+rqIn3CrwkIpq0Hp1ignAFHxMZVgUca5uX33Y0ViVgQal1Dakv5EUJCjOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842024; c=relaxed/simple;
	bh=ABWyGemdevLy8WsvPHNbBGBHcbCMGV5EaSGQyEJYhLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccygMMj1JdKNugs482faD9byMjnUajbh39VGfVKB7cw/QQdGiOy5nA/Du+hSxFW+x1RH48soqvL65mt5MFq/gjXkBi+Et2Kyq1BzrfMcai6IxN1H/WDLesYkeFPhCJloD2oRrx2E84rF5pjoOn0lK0ktzIuFiHUJ1dCF5sWbf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/GocJNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7937C43390;
	Tue, 19 Mar 2024 09:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710842024;
	bh=ABWyGemdevLy8WsvPHNbBGBHcbCMGV5EaSGQyEJYhLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/GocJNN9prwOikvbvCq4ayHy5jrjzX6avLN/9kz55jC9hvVQXfh9Q6d8EDmt0UGH
	 fGZJdYXI+qpKGxPh9sCFs90n3ceG7lQ0YBhrlljBDOHrQ5rNQaUQGlbBDvnd2w0eZX
	 kSqz7YVieLF5ZBDnQwzUnaZTIH4dgO/hMBcIKlPwM7c5WDpYUOjlHMlSeAhDtehgpz
	 qK3e3oG/kXpuNIKHztCPhv2Vdd/uZ5RSKfxzDwv8Az8yxP6EwxxlKkmxn0HoDdxqgn
	 p1+rtpHr7YYNckfJpGnfqbgwJw254Ku8b2RqBUj71Wxm/m27qVyB8iKmxUvpYu+ZAR
	 4329QKg5+8/2w==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFT 08/15] kfifo: fix typos in kernel-doc
Date: Tue, 19 Mar 2024 10:53:08 +0100
Message-ID: <20240319095315.27624-10-jirislaby@kernel.org>
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
index c7cc25b2808b..d613748de7ff 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -585,7 +585,7 @@ __kfifo_uint_must_check_helper( \
  * @buf: pointer to the storage buffer
  * @n: max. number of elements to get
  *
- * This macro get some data from the fifo and return the numbers of elements
+ * This macro gets some data from the fifo and returns the numbers of elements
  * copied.
  *
  * Note that with only one concurrent reader and one concurrent
@@ -612,7 +612,7 @@ __kfifo_uint_must_check_helper( \
  * @n: max. number of elements to get
  * @lock: pointer to the spinlock to use for locking
  *
- * This macro get the data from the fifo and return the numbers of elements
+ * This macro gets the data from the fifo and returns the numbers of elements
  * copied.
  */
 #define	kfifo_out_spinlocked(fifo, buf, n, lock) \
@@ -745,7 +745,7 @@ __kfifo_int_must_check_helper( \
  * @fifo: address of the fifo to be used
  * @len: number of bytes to received
  *
- * This macro finish a DMA IN operation. The in counter will be updated by
+ * This macro finishes a DMA IN operation. The in counter will be updated by
  * the len parameter. No error checking will be done.
  *
  * Note that with only one concurrent reader and one concurrent
@@ -801,7 +801,7 @@ __kfifo_int_must_check_helper( \
  * @fifo: address of the fifo to be used
  * @len: number of bytes transferred
  *
- * This macro finish a DMA OUT operation. The out counter will be updated by
+ * This macro finishes a DMA OUT operation. The out counter will be updated by
  * the len parameter. No error checking will be done.
  *
  * Note that with only one concurrent reader and one concurrent
@@ -818,7 +818,7 @@ __kfifo_int_must_check_helper( \
  * @buf: pointer to the storage buffer
  * @n: max. number of elements to get
  *
- * This macro get the data from the fifo and return the numbers of elements
+ * This macro gets the data from the fifo and returns the numbers of elements
  * copied. The data is not removed from the fifo.
  *
  * Note that with only one concurrent reader and one concurrent
-- 
2.44.0


