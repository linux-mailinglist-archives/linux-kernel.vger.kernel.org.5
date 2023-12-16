Return-Path: <linux-kernel+bounces-1910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3D58155A8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B0628619A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA0710FE;
	Sat, 16 Dec 2023 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VoB0Kly6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559037F2
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 00:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JGm64yDc8jR+dkgAioiLsX1CTnOIIQnPYRMG7T++vsY=; b=VoB0Kly6iH+E06eL2Vwul1/5Uo
	fz03reJglm6VjG0LtDUI0/YG6R7mJpqxmWNZqZjR1wxCUshJ77K38EWZicp4b4/N1m8juMIBvcS5t
	IJ15dV7mxQnTD45ocRl1d6sWwC55NFahEb7YD0AJileQ5X1XjqL83NDbTIVzKIlBwIFXYkIiSsdML
	rY7kfEMFJdA2EiwY2eTuXQgF9L2SRzzrG7cv+LGppl9LkVijky1RvyjO1nTinR2dpQEc8dwmgtQqf
	ZxLWOxSISf9N34NrkyWTW3eAdvMVfIeWXPPkINetKg4jFKrI5MUBaiPAxaxQ2sQA4YtUPmcX1Demx
	Z9xiHrWw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEIkf-0052D0-0Y;
	Sat, 16 Dec 2023 00:41:57 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mailbox: zynqmp-ipi: fix an Excess struct member kernel-doc warning
Date: Fri, 15 Dec 2023 16:41:56 -0800
Message-ID: <20231216004156.26967-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel test robot reports 2 Excess struct member warnings:

zynqmp-ipi-mailbox.c:92: warning: Excess struct member 'irq' description in 'zynqmp_ipi_mbox'
zynqmp-ipi-mailbox.c:112: warning: Excess struct member 'ipi_mboxes' description in 'zynqmp_ipi_pdata'

The second one is a false positive that is caused by the
__counted_by() attribute. Kees has posted a patch for that, so just
fix the first one.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312150705.glrQ4ypv-lkp@intel.com/
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/mailbox/zynqmp-ipi-mailbox.c |    1 -
 1 file changed, 1 deletion(-)

diff -- a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -81,7 +81,6 @@ struct zynqmp_ipi_mchan {
  * @remote_id:            remote IPI agent ID
  * @mbox:                 mailbox Controller
  * @mchans:               array for channels, tx channel and rx channel.
- * @irq:                  IPI agent interrupt ID
  */
 struct zynqmp_ipi_mbox {
 	struct zynqmp_ipi_pdata *pdata;

