Return-Path: <linux-kernel+bounces-122402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50A888F675
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A00B1F26195
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C6F39AC9;
	Thu, 28 Mar 2024 04:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fnHMhdxo"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518EF28E6;
	Thu, 28 Mar 2024 04:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711600728; cv=none; b=hELk+th78NjoVxNEQvgKVr7Hk6Pop3I8wHG0RJpa7WhRNQs926P6IXnYrUbwM718W/KRzRAh9CikJdxiYTgXy+K8GZhDOvo6SPXsp66depyhW50SnKjJ2KZKKmD2Wo9LltxapGYdnbTXTxlAK2IyhdD2gcDLCBtflZFClgbU8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711600728; c=relaxed/simple;
	bh=UQt70vAkiaaCvAuoBncUOZWI5xsL+A6vYuGPERra61M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcWatKVx2Fwfseizjj9UoIC1xgXt+MAkZ+pFXiwv5qSde5F61RWIYlzwr+GOAJmS95TihGJzsz/YWmUoNuxB4BD7cBy7nJDpcU35la1+zd0eaJi2loc6NfhWpiFyRPWm/ONg91kuourv8YQwMIxmUeKSr9lUr80prcZ2j0uP55Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fnHMhdxo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xqc3wCt9hsEsM7CdvGBkX++ytxnYM2OrJrMC82sR1kg=; b=fnHMhdxoitqZmrX1PqBAmtkAjO
	CqGgHbm9jcQ/u3UGY4jjFNJu05jZmhR82P66Xz2+AS8lV9KulG/HwDN9z+tMPoj9OHkAup7Ov+xST
	mM0SsA/IL4GrWIa7Ife0Dc53usgOtnNeu9zZd5gixuQrnNHe8ufRtGwiP4FhSViRL/O8OgkIwOr1E
	PM6wQE8jKqCEHqPS6+wwzVKZdX+TaEiHgnX8eqtKWHe4ShFnogo+PngJGu32Z4yrCgynQcUAHcDZ2
	b1QSc9zWd3U4lNnoOghiytzDrPvrfuEr8zCdc7nmdpCPkuDg5kamq4fFySIg1YC62E9mWjM/uG6VC
	VhTbY/PQ==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphXJ-0000000CPVp-3aBO;
	Thu, 28 Mar 2024 04:38:45 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: spi.h: add missing kernel-doc for @last_cs_index_mask
Date: Wed, 27 Mar 2024 21:38:45 -0700
Message-ID: <20240328043845.28882-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-doc complains about last_cs_index_mask not described, so add its
decscription.

spi.h:778: warning: Function parameter or struct member 'last_cs_index_mask' not described in 'spi_controller'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-spi@vger.kernel.org

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

