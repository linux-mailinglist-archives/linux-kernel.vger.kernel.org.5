Return-Path: <linux-kernel+bounces-105715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA41687E35A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D25B20E60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D542209D;
	Mon, 18 Mar 2024 05:50:13 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2154C84;
	Mon, 18 Mar 2024 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710741013; cv=none; b=mN6riCA8O6AV5JrnRe2O/0nFS0B+4L6xEeJzgLq2diE5awRqa/XJBATg3aAyWuD72E+yPOMNtPvkCjFDR1D4gIgAqwKGXLTv4t+TEBaJDZ5wwgN5elt2TyQTJPpYvqDtrXXEQdNNzI0CNPBOo7BajyTJtKTEumfNMKq1GAMEV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710741013; c=relaxed/simple;
	bh=315hZUHrLgSekS/IuWfU15QejyNM4xhAiLV6xbvwO2I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L9xmKzdWekunX/oSNxTix22iYnHMZc7+ENUYZAp8bdgWo+uPU57V30fHIIf8IA4ByZNWGX1VhJYxSuprbR5MWYJLqWVkTNhtvE4nkbjzn//0ODCQwX0cHxjMhgbnPnsRi+IRXjvBaKM8PpGDMijITxOZi1S27ZyY7zywqw18jb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id OYO00055;
        Mon, 18 Mar 2024 13:48:55 +0800
Received: from localhost.localdomain (10.94.10.250) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.35; Mon, 18 Mar 2024 13:48:55 +0800
From: Deming Wang <wangdeming@inspur.com>
To: <miriam.rachel.korenblit@intel.com>, <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Deming
 Wang <wangdeming@inspur.com>
Subject: [PATCH] iwlwifi: api: remove the double word
Date: Mon, 18 Mar 2024 01:48:53 -0400
Message-ID: <20240318054853.2352-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2024318134855aaf06486cee3c593eebb65434549c418
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Remove the duplicate "the".

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index d9e4c75403b8..c9d7f68e8cb8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -191,7 +191,7 @@ enum iwl_tx_offload_assist_flags_pos {
  *	cleared. Combination of RATE_MCS_*
  * @sta_id: index of destination station in FW station table
  * @sec_ctl: security control, TX_CMD_SEC_*
- * @initial_rate_index: index into the the rate table for initial TX attempt.
+ * @initial_rate_index: index into the rate table for initial TX attempt.
  *	Applied if TX_CMD_FLG_STA_RATE_MSK is set, normally 0 for data frames.
  * @reserved2: reserved
  * @key: security key
-- 
2.31.1


