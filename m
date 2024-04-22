Return-Path: <linux-kernel+bounces-152956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E688AC696
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CE51C212BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAA4502B0;
	Mon, 22 Apr 2024 08:18:13 +0000 (UTC)
Received: from mail-m12782.qiye.163.com (mail-m12782.qiye.163.com [115.236.127.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E2E4F213;
	Mon, 22 Apr 2024 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773892; cv=none; b=AjUle09YsIg3+Sf7FVSbFr+kl1SQwkyntBJTX9AVc4CjkIuCH0Z74+f8+auspQDTPQUFJEqvcInrTJ2LkM+F1SxVB4zo+bUznYf51ZFBbIRMU7+4ffZfvCbRdkx15FVaYgep1/8fUC783SS0q1FsiY9u+1+UQdgIks7Lhu78/QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773892; c=relaxed/simple;
	bh=hK1pR1teR7regKqZMnBinJhZ56OjV/M+wxIscIgvv5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aqvBqfuJwBY3CnLuKNkWW2P4lRb1UZpVCkRJkrF+mBj+DIs/uNTGddz+MnfClZY9OrgBbL3XxfX5JEXMraM0d+bWkV2M1B6SQGlSpFe5+q7/x5y0E6jL0LUUWtPz6Hw9/yMRs41aSiFcV/N3kCJzYdGmSr2HMVVS8BmxoKipg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=115.236.127.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from ubuntu-22-04.. (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id E72FF860209;
	Mon, 22 Apr 2024 15:01:33 +0800 (CST)
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
To: dan.j.williams@intel.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 2/3] cxl/memdev: Document security state in kern-doc
Date: Mon, 22 Apr 2024 07:01:24 +0000
Message-Id: <20240422070125.52519-4-dongsheng.yang@easystack.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422070125.52519-1-dongsheng.yang@easystack.cn>
References: <20240422070125.52519-1-dongsheng.yang@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGUpDVhlDHx0fTENJS0NLGFUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f049c2988023ckunme72ff860209
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxQ6Fww*Ljc1FRwRMhEtGU8s
	HU4KCyNVSlVKTEpITE1CSUJPTU9MVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBSUlLQjcG

From: Davidlohr Bueso <dave@stgolabs.net>

.. as is the case with all members of struct cxl_memdev_state.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20230726051940.3570-3-dave@stgolabs.net
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/cxl/cxlmem.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 499113328586..f3aca828fbec 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -434,6 +434,7 @@ struct cxl_dev_state {
  * @next_persistent_bytes: persistent capacity change pending device reset
  * @event: event log driver state
  * @poison: poison driver state info
+ * @security: security driver state info
  * @fw: firmware upload / activation state
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
-- 
2.34.1


