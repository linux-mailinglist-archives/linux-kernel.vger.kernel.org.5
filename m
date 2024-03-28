Return-Path: <linux-kernel+bounces-123778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41921890DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7239B1C31B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD3E225D9;
	Thu, 28 Mar 2024 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TzGSCSlJ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF04200DE;
	Thu, 28 Mar 2024 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711665224; cv=none; b=cS+1txc/bLaVI8pkig9MxT7kkDh/r5b3WUFStURVx4GGeFuSeTQGZSn2JMrDAmq3Xi2efJ3e2JnwiCLGrUafhJXO4Fokejq7qcxfzJhrWWzICDXMjVZO6whotmFrHgx/zYoEn4hzBS6iwfiGMfd8CA5hjv6y0g8CaDn5ySryUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711665224; c=relaxed/simple;
	bh=e3+KVkTxu83PkOtk2obguOKILuGUpps+YAeNoi9R4Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2Gs+g593vX+u12uvljaArbMSl3Eulbb9UHaogrJKLofEeDdE8ErPLiqfUBFLgCLkREtAw4Fkt1Gbs5MDnR/2wBglHN9XSez2MJhSJz48kS3iWxZvGPL+aRyi61n0wwWJG+n4eR5yz2g/lrLSq8s6oBO4jEEFgrsmeCGO9+Ln/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TzGSCSlJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=YwRQMa4SHqiIHy0Pshzjh35gsaCpmuIJA/rF8ajEMj4=; b=TzGSCSlJ95ONspJ/AmbYypbo4B
	332uhGx7IpjJYUvtuz9CpaqJZc7LEBPCs6eBo269fiNyooVbJXnmLdSgCsBh32OA/dkfm4RvaU0J4
	8cjGU82EkCrHBKtYJ8Kp9Bm87tLzwelS/G7epRhAnfQhmsFhnd/f/p0XVcSMnVmlwmAL3m2LUVBx7
	JvkO1MrAj8RzBmvlGKctYTyVqtYuv+pl24BTDZyBpNS9RItk1MaRPkzpnjgy9aO8s4VT5Boz3C15v
	Q7YwQpZTn5WiAq0yeLSUI6SYabcjowksYmNP3Z/v6CTC6EidoOaqF4HHUsmEgeMaXQrvLiUONnQp0
	aCYNdf5g==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyJZ-0000000FxJV-46LL;
	Thu, 28 Mar 2024 22:33:42 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v2] spi: spi.h: add missing kernel-doc for @last_cs_index_mask
Date: Thu, 28 Mar 2024 15:33:40 -0700
Message-ID: <20240328223340.17159-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-doc complains about last_cs_index_mask not described, so add its
description.

spi.h:778: warning: Function parameter or struct member 'last_cs_index_mask' not described in 'spi_controller'

Fixes: 4d8ff6b0991d ("spi: Add multi-cs memories support in SPI core")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>

v2: fix spello in commit message (Andy)
    add Fixes: tag (Andy)

 include/linux/spi/spi.h |    1 +
 1 file changed, 1 insertion(+)

diff -- a/include/linux/spi/spi.h b/include/linux/spi/spi.h
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -453,6 +453,7 @@ extern struct spi_device *spi_new_ancill
  * @last_cs_mode_high: was (mode & SPI_CS_HIGH) true on the last call to set_cs.
  * @last_cs: the last chip_select that is recorded by set_cs, -1 on non chip
  *           selected
+ * @last_cs_index_mask: bit mask the last chip selects that were used
  * @xfer_completion: used by core transfer_one_message()
  * @busy: message pump is busy
  * @running: message pump is running

