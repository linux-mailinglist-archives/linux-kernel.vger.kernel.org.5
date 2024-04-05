Return-Path: <linux-kernel+bounces-132444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D868994FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F0B281077
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB60A36136;
	Fri,  5 Apr 2024 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsMWJEWo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E9D36114;
	Fri,  5 Apr 2024 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297334; cv=none; b=jlr2vIWIn79yD/YNfC9Ja9ixrN3rBa2jAgkOxebwtM7oOVM5+y/uR1gHK9zDhdJwhQWUcU9Zf4Mi9tPykxNyUnJEwtZHmyOYhkZEfRPLMjin0vgCfKLIMIMhh1a/VSy7A5Y7UDnaowuMW/JE2DrVJ83uXlMZln1TlFEdbPGowNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297334; c=relaxed/simple;
	bh=ABWyGemdevLy8WsvPHNbBGBHcbCMGV5EaSGQyEJYhLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMx5Ge62+W3JdRI7ZaPpnIbrsuG8IULugMyaFALg+gRtkp21Nzyx4/7KznA3NPzCz0k8DuQgjGr6j15AWVa6PQN/nik1cYHyQkLdlA8lLE4fSw8mDiqXB23AHBPxVO2XDteCh+4zIXvtpphoo/n93u1LOLUD5YnsQRMLaAq+5lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsMWJEWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9207C433F1;
	Fri,  5 Apr 2024 06:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712297334;
	bh=ABWyGemdevLy8WsvPHNbBGBHcbCMGV5EaSGQyEJYhLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fsMWJEWo8wh3kSunC+1n86eFpxAu3xIx7xaHqGJCD29lZPpUwsnaiz9juJ102dnqP
	 sdrwtcf7IVKUfnoAi6UxmmmsgXRpQCOyz4JfqqDjJGK2eWCMhA+tEVkEk+R4JqZsSc
	 KTJD/SSuE7PpgvBt9NxxLQng556zVDV9NjoONeqSrqPNl9QnDojn8/yJsuQWP/6HwO
	 tdNTo/pbkXNjFv/3yDKcgpgic3m33SjucrA5JPgpy/3K0gPYwmFZsRKQPbxvrk7qdE
	 ET1bXS738ZvVD6tkw6y8umJ4SU28XNQvc1DGddTPKBMnPrB9lITQxtGT0VYJLrL6ek
	 YoUJnddjq6gWw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 08/15] kfifo: fix typos in kernel-doc
Date: Fri,  5 Apr 2024 08:08:19 +0200
Message-ID: <20240405060826.2521-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405060826.2521-1-jirislaby@kernel.org>
References: <20240405060826.2521-1-jirislaby@kernel.org>
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


