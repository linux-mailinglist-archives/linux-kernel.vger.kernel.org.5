Return-Path: <linux-kernel+bounces-68063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75DF857581
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314571F243FE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8978B12E67;
	Fri, 16 Feb 2024 05:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ikfMUqwn"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE1B149E0D;
	Fri, 16 Feb 2024 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708060602; cv=none; b=JZzQZ2aTA7fCtkTlZP6FCLdNgP6OdiRFAzi/BY0ODeybgvr0vmD0vf9uxWNFyCCb+T12xAAUs9uAKPqGBceX+/zvBY+1h6RR3ee4LD5LjI//xdYWp0RNVDpUfp/WelIUzSwcMEdHuUXe9AcK1XW696HlA+2bQNzfc/2mN3OQqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708060602; c=relaxed/simple;
	bh=rkbPUj9WoAcVfyHOhHqhnbvphHLdHXFwVyZw3xLKxWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SazVDhtujQllWkQpzKVTPo6XGUs3NY3ZqKQsW+jyspQizIH0YbETULrJQ1jrnLMSSwIwnNRNf7N/hdqY703+385UM96wGTmLcTeXH25PgnJ9yUNhgKJ/OqnouPguH6flnfE/5gAN45Mq5TQqt7gZxOZ/FkH8BhmW9axQjVJID8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ikfMUqwn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=X0MGq7CH0jqL6zN/5YH5WmRXuWM0TxaTkyW5nWr14jo=; b=ikfMUqwndoD/ATerf3pEWG1j+S
	4Tk9huM5XoWgvE3N38lzYf5FnCzl4pIWNdrW5An+SgMr3wairx9Q+b+bU/UQU2MdKUHeQbli1L1Yo
	D2a44nX/b7PLfgCE8voQIC7K46hMAuyuoGfZ1Jwf0xIfCsWbyAnWbO1x4WrRJsEltOAEB6d2/2r5p
	3OJNwE/nX7vsuuBR7NHVnB7iqIMEvZx1vYhADF1cORZJZiAPCpHzJXYp2+OQga/AyZMcesCFNbmvB
	IAf+fuL5DsluWN0GMh1YzSyWOS3o28lL1W+8au2Z4lbqOlpf2XIpHgZVmMHbPLveEAdoRrP1rt2pi
	2wSopX5g==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raqaT-000000016tb-2YQJ;
	Fri, 16 Feb 2024 05:16:37 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Dhruva Gole <d-gole@ti.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH -next] spi: spi-summary.rst: fix underline length
Date: Thu, 15 Feb 2024 21:16:37 -0800
Message-ID: <20240216051637.10920-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The change to use "target" requires an underline to be extended by
one more character to fix a documentation build warning:

  Documentation/spi/spi-summary.rst:274: WARNING: Title underline too short.
  Declare target Devices
  ^^^^^^^^^^^^^^^^^^^^^

Fixes: hash ("spi: Update the "master/slave" terminology in documentation")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dhruva Gole <d-gole@ti.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
---
 Documentation/spi/spi-summary.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -271,7 +271,7 @@ an external clock, where another derives
 settings of some master clock.
 
 Declare target Devices
-^^^^^^^^^^^^^^^^^^^^^
+^^^^^^^^^^^^^^^^^^^^^^
 
 The second kind of information is a list of what SPI target devices exist
 on the target board, often with some board-specific data needed for the

