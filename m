Return-Path: <linux-kernel+bounces-39480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A2483D1D9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0063D28AF7F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001DDEBE;
	Fri, 26 Jan 2024 01:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Dakj2rcw"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E06387;
	Fri, 26 Jan 2024 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230941; cv=none; b=UlW0hmU8xxwX3pF4OQj/OOEkt6J/xQW3IbQ9NpMtwvtFJduiSAca5nFe9ps59cTLSHTztyFtfsseR/OVIvsEzvg0n4fQ1nZPkWQIiexWehlBXWnasKN3R6DqpR63+ElsSkTO+uasyA14H7x7CWDiXoqFmCwpNuqupe5Ks12Np6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230941; c=relaxed/simple;
	bh=o/H7UB9xeWtg7kwRYBvkwSfAVrMMvmyhuI7LB/3Ct3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m62MzdWKRKJTquHw1b8WTsvhAlrmPgQffLx+dJqjgNpFVB1F4gOEOlUibLr+wE3u1QA6eIek6DuspBhG6Rkw4armBYHvUMQd4/zoT83qqnYteO1f6U26qhX+p3tZnul/lj4ADKlDPOKUuwj+TA1Y3kPqdzrWkfZ78UEXPqPgPZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Dakj2rcw; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706230930; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vDo8wakidq0YhelFiycaIU58VxgIfIBAMQhbwJMl6T8=;
	b=Dakj2rcw9XbqZIiIFsaT4nsnJONxcFxmVhnr1us6lkIsblT2t077iwXn6+tXo+GYpS7/VD6Mryy2pM7ZbH8iQCg6Jm8tD9Pq6ZZGMZ0CbyNC4g2NCTVV51NqbmkzOj8gt4HPh701aHl61rZw9EvLuyocfJrhteHPX0XR+JOQ0kE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.LcmOc_1706230928;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W.LcmOc_1706230928)
          by smtp.aliyun-inc.com;
          Fri, 26 Jan 2024 09:02:09 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: tony.luck@intel.com,
	bp@alien8.de,
	Yazen.Ghannam@amd.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] RAS: Remove unneeded semicolon
Date: Fri, 26 Jan 2024 09:02:07 +0800
Message-Id: <20240126010207.25957-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes the unnecessary semicolons at the end of the
switch-case statements which cleans up the code and ensures consistency
with the rest of the kernel coding style.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/ras/amd/atl/denormalize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
index 01f1d0fb6799..80d72b857076 100644
--- a/drivers/ras/amd/atl/denormalize.c
+++ b/drivers/ras/amd/atl/denormalize.c
@@ -469,7 +469,7 @@ static int denorm_addr_df4_np2(struct addr_ctx *ctx)
 	default:
 		atl_debug_on_bad_intlv_mode(ctx);
 		return -EINVAL;
-	};
+	}
 
 	if (ctx->map.num_intlv_sockets == 1) {
 		hash_pa8	= BIT_ULL(shift_value) & ctx->ret_addr;
-- 
2.20.1.7.g153144c


