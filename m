Return-Path: <linux-kernel+bounces-115500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D73B8896E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3125C1F35256
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8332233CEE;
	Mon, 25 Mar 2024 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baz52nHw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD71EBD4B;
	Sun, 24 Mar 2024 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320936; cv=none; b=HM504+c6vJPt7ZNmzzmhLTnLeMmywir8nkEg9G+7hPjWcUtsmx+/gaxa9WbGQZ4AenmDgCkkD/9WsTUROgjOwDaf7wySdNjK1rjXnkTmj/Dl771p3xD4Xp0bFbaWKRLGXvKKb5RdsWESiaxD6UVoMvpE3/bbNfRtcuWj9FieanQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320936; c=relaxed/simple;
	bh=8BK6+/8kcaLej6DGTBCcocnkWvmX8qwCPKlOjlJU6Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHSUadfZ2kJeTvb+Pu/IoECw2CcBOebhp0ptKfEiWuOnPsBtwkj3b9LIkqT9AIRPA1PL04c+s7bWJgle7BGb1URR1eQbalEqvM2t6RMwaUQthBFmx4agsG5p6dpSY7APvF/TqVvxgJDuKIYoefGfdKsk43Azc+ZO82/piTMCHas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baz52nHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCD8C43142;
	Sun, 24 Mar 2024 22:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320936;
	bh=8BK6+/8kcaLej6DGTBCcocnkWvmX8qwCPKlOjlJU6Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=baz52nHwfapAeBUyB7iNVpnPloh5OqBYMhcV1ZF3qPqJ5WAqaycLH6I5am7iuQzZF
	 p2f7WXFokAhEhRdhPgvSuHAtusPQ7fYYRnlDjTzDidA79vpk/82JYFHUbD05SJRThz
	 /rQ0vbNcdrEwj8fVe2buUwkj91YkAVc4I41Sv1m7xLIGdhUsWaQ1zUS4rDrDd53Wjp
	 cggZA184sGW0SQzt8t3XkWqv+L12UID+8e0vG2EljXgdwYnukk97EyLdP9fpNyQMix
	 78mnW5eF2xB5w9tdAi2DEvUkVyioAnm8UUSTAPmLoUy7NkJl6XGuioqdck5mb5/CY8
	 bhNTk6xcYjz7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Guerin <adam.guerin@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 499/713] crypto: qat - removed unused macro in adf_cnv_dbgfs.c
Date: Sun, 24 Mar 2024 18:43:45 -0400
Message-ID: <20240324224720.1345309-500-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Adam Guerin <adam.guerin@intel.com>

[ Upstream commit 9a5dcada14d5e027856a1bc38443e54111438da6 ]

This macro was added but never used, remove it.

This is to fix the following warning when compiling the QAT driver
using the clang compiler with CC=clang W=2:
    drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.c:19:9: warning: macro is not used [-Wunused-macros]
       19 | #define CNV_SLICE_ERR_MASK              GENMASK(7, 0)
          |         ^

Fixes: d807f0240c71 ("crypto: qat - add cnv_errors debugfs file")
Signed-off-by: Adam Guerin <adam.guerin@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.c b/drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.c
index 07119c487da01..627953a72d478 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.c
@@ -16,7 +16,6 @@
 
 #define CNV_ERR_INFO_MASK		GENMASK(11, 0)
 #define CNV_ERR_TYPE_MASK		GENMASK(15, 12)
-#define CNV_SLICE_ERR_MASK		GENMASK(7, 0)
 #define CNV_SLICE_ERR_SIGN_BIT_INDEX	7
 #define CNV_DELTA_ERR_SIGN_BIT_INDEX	11
 
-- 
2.43.0


