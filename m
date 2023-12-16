Return-Path: <linux-kernel+bounces-2073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C09815789
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F2228700E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF5A10A19;
	Sat, 16 Dec 2023 04:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YL6KJ4e5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7989210A00;
	Sat, 16 Dec 2023 04:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+EMdx3GheWRvQiEGB4Br4TQx4XQJxBAp1x6hT3lQeyQ=; b=YL6KJ4e55x4O+Kl8WZPwwtm0b/
	AX4fW15lZoXhLB8vXu/f80wqxkThRF1qIe4ZdWc8+91Mv0Py60WlGu8hTTk4mQQE8PYuhU41bzM5e
	rrKrrx8JVgFKxl1BGwiyNkteeP7UZVHdqZJEYxmN6o+/JGa2//YfhC6EPjwSOJE7wsOjtq/iCToWT
	0574wJZ9eXQ29ZK69pF4PR4kAQ2r9Yye2taTOh1InLeke9VtP7WGBJQJCLrvjBK2XOfBdu5QZmDaY
	vMq09LKSEKecbJe+73sNH1Xa9+ewDX0L76Dd3uSLq/6vjiBpa90Oeelstji1ajyO3LcsDc+Mz7sNx
	KeR7C9ww==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEMUl-005Ox1-0D;
	Sat, 16 Dec 2023 04:41:47 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH] mtd: rawnand: fix Excess struct member description kernel-doc warnings
Date: Fri, 15 Dec 2023 20:41:46 -0800
Message-ID: <20231216044146.18645-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete 2 lines to prevent warnings from scripts/kernel-doc:

s3c2410.c:117: warning: Excess struct member 'mtd' description in 's3c2410_nand_mtd'
s3c2410.c:168: warning: Excess struct member 'freq_transition' description in 's3c2410_nand_info'


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312150611.EZBAQYqf-lkp@intel.com/
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
---
 drivers/mtd/nand/raw/s3c2410.c |    2 --
 1 file changed, 2 deletions(-)

diff -- a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -105,7 +105,6 @@ struct s3c2410_nand_info;
 
 /**
  * struct s3c2410_nand_mtd - driver MTD structure
- * @mtd: The MTD instance to pass to the MTD layer.
  * @chip: The NAND chip information.
  * @set: The platform information supplied for this set of NAND chips.
  * @info: Link back to the hardware information.
@@ -145,7 +144,6 @@ enum s3c_nand_clk_state {
  * @clk_rate: The clock rate from @clk.
  * @clk_state: The current clock state.
  * @cpu_type: The exact type of this controller.
- * @freq_transition: CPUFreq notifier block
  */
 struct s3c2410_nand_info {
 	/* mtd info */

