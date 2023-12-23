Return-Path: <linux-kernel+bounces-10298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E2681D252
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5DD1F21798
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C11B4A15;
	Sat, 23 Dec 2023 05:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4HZRhNiY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DE820E8;
	Sat, 23 Dec 2023 05:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JyfgCRRufOn1EHv8GLn9qHB684YjM7cMDOWBxpHhTaU=; b=4HZRhNiYwJDsCwDZP4zObq3tYL
	OLTcD2Mjd5eQzDYTLOIqAONP9NfUpputUWcmCp6Uw2mZQGakLep+mpJUTIjL/Fjo50blhvaA7UmtH
	PWQkiDTtWaWGaFUBjRAmkEUNaeSJ/AmtjzPudFhVNJ4wxC9bNavZyPsiASKlkmaKXJ8gyiTqKwfgz
	NMa6vn2gOrWAoRD+ZLya6DcdvV2fUsIfWaZ8VdkgRlD3fNQfwza5Ph7gfvhBLeSFzvILFpKsk85Mj
	5SWqIM4E6sefDF2hzC1GDgCWL/3mfyz6wrKAZK8W/bOJNbTAzqUT41TxHAmmzpXg/LhLaNOLpobVy
	c4ZmhXig==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGuCz-007Oek-01;
	Sat, 23 Dec 2023 05:05:57 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: linux/iio.h: fix Excess kernel-doc description warning
Date: Fri, 22 Dec 2023 21:05:56 -0800
Message-ID: <20231223050556.13948-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the @of_xlate: lines to prevent the kernel-doc warning:

include/linux/iio/iio.h:534: warning: Excess struct member 'of_xlate' description in 'iio_info'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
---
 include/linux/iio/iio.h |    6 ------
 1 file changed, 6 deletions(-)

diff -- a/include/linux/iio/iio.h b/include/linux/iio/iio.h
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -434,13 +434,7 @@ struct iio_trigger; /* forward declarati
  * @update_scan_mode:	function to configure device and scan buffer when
  *			channels have changed
  * @debugfs_reg_access:	function to read or write register value of device
- * @of_xlate:		function pointer to obtain channel specifier index.
- *			When #iio-cells is greater than '0', the driver could
- *			provide a custom of_xlate function that reads the
- *			*args* and returns the appropriate index in registered
- *			IIO channels array.
  * @fwnode_xlate:	fwnode based function pointer to obtain channel specifier index.
- *			Functionally the same as @of_xlate.
  * @hwfifo_set_watermark: function pointer to set the current hardware
  *			fifo watermark level; see hwfifo_* entries in
  *			Documentation/ABI/testing/sysfs-bus-iio for details on

