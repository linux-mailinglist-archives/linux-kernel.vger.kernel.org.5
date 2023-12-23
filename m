Return-Path: <linux-kernel+bounces-10302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBB681D25A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6941C229AD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B474A63A0;
	Sat, 23 Dec 2023 05:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CURBrnjb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49B6107;
	Sat, 23 Dec 2023 05:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=TecqbtCcymQ3rvhJ2ZipmZypmX00cwuzg6ClZBGWfU4=; b=CURBrnjbUmS/0otY8oX7VJL3Y4
	ppkWhmCvhQRiq6/hYB6K9jCPxF4ayRgFifYxGdQk8msGwbAHBZVLni3RhDnpeR0KMGLhFZUVpEO7t
	w7t6HZQ5L4EBSPQhLn6D3nOZFpgJvf36KsexWlNQHJw2/r8rczyNpwUqAieT5iacYzu7SLQQdeSUf
	uCKxk0b3oUzR0OsG+rbCgw4CqpfshqrPUB0IsTVJFdgNlhXUJ/vaXWRXFvNxjQ3sQiO+yPKMvQNB1
	Yks7+Qp2IgNczFMTWbmW05d/A+NvHciu8zTeSNM4VZe5Q39Bk0EzkKchxOvYHWYWULyzX+/sr8RZQ
	yZxyoTCQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGuDW-007OlN-1i;
	Sat, 23 Dec 2023 05:06:30 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: linux/spi/spi.h: fix Excess & missing kernel-doc description warnings
Date: Fri, 22 Dec 2023 21:06:30 -0800
Message-ID: <20231223050630.14008-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove one struct member description and add another one to prevent
the kernel-doc warnings:

include/linux/spi/spi.h:778: warning: Function parameter or struct member 'last_cs_index_mask' not described in 'spi_controller'
include/linux/spi/spi.h:778: warning: Excess struct member 'multi_cs_cap' description in 'spi_controller'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
---
 include/linux/spi/spi.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -- a/include/linux/spi/spi.h b/include/linux/spi/spi.h
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -422,8 +422,6 @@ extern struct spi_device *spi_new_ancill
  * @bus_lock_spinlock: spinlock for SPI bus locking
  * @bus_lock_mutex: mutex for exclusion of multiple callers
  * @bus_lock_flag: indicates that the SPI bus is locked for exclusive use
- * @multi_cs_cap: indicates that the SPI Controller can assert/de-assert
- *	more than one chip select at once.
  * @setup: updates the device mode and clocking records used by a
  *	device's SPI controller; protocol code may call this.  This
  *	must fail if an unrecognized or unsupported mode is requested.
@@ -454,6 +452,7 @@ extern struct spi_device *spi_new_ancill
  * @cur_msg_mapped: message has been mapped for DMA
  * @last_cs: the last chip_select that is recorded by set_cs, -1 on non chip
  *           selected
+ * @last_cs_index_mask: records value of the last @cs_index_mask in &spi_device
  * @last_cs_mode_high: was (mode & SPI_CS_HIGH) true on the last call to set_cs.
  * @xfer_completion: used by core transfer_one_message()
  * @busy: message pump is busy

