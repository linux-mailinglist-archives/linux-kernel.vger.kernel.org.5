Return-Path: <linux-kernel+bounces-113358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A51B08883B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DBA28231A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15D719BB9B;
	Sun, 24 Mar 2024 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbudAzXm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0071C6E61D;
	Sun, 24 Mar 2024 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320160; cv=none; b=GTSjLGD7W196pKxR4m+czeSft/BUie+f0S+KPJ947yKSfLK19Dyc0R775HOQaM7doc9pVvhr7DQwapZg+Zh64OTx0XawqiyGAjljI01kaRjKDKZ8gog2u0yG/T1cf5r3JcCIChXY6plhuLO8AtIPXExItHt0OyY29b5PBUc4aUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320160; c=relaxed/simple;
	bh=eFw53uz7Utyd3JbrNXm2U9OSaLEXN0g6S7t/oGiM3VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SarF7JdzbtAv/LMSYzaV9bAlifbLccLysh/dDxO3EFV7sRoZ1dRxwr+KyFBsKb657mtNQ7DrnnraIhUJXaWoW06RSiYtkcl3G3XGfsxTpGY+FyQ2vVhhp/WtI/CiEgCqJtyWQITYnIlxEh1q9oxGD4ivpNHS+MIsX5hirMJDoaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbudAzXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25B8C433C7;
	Sun, 24 Mar 2024 22:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320159;
	bh=eFw53uz7Utyd3JbrNXm2U9OSaLEXN0g6S7t/oGiM3VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbudAzXmkjxgCCKoaXX5axt8yhClGvWjmBoq/97zYOxiJfpYJYdi+PgTkXaJ7A5xB
	 pi02nlTc9y32LCI99Z9qpa6hzrfZrYOKlk6ZrOZm87Z8O1ZVfyyV2B+yHYk4aeVbHL
	 Ha46utFifI7sZ08onX2gM9gZk+YnU5NkzsunRR8JxLpSID0rhrqkrlaaVyORmrVC6Z
	 MyMyEwCPqeuj7GR6zw6MgJtiiAStXdtAX62Z9fL/DEU011ULhUVJrJzYBMecTpZOvo
	 H++MtBGqrbtPBa2ldNjM6fjK1Nh2fgxMfK4SiGgJ9zIkv5T65L0cMXgSo3ltkODuuI
	 1/qEECjucat2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Guerin <adam.guerin@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 467/715] crypto: qat - remove unused macros in qat_comp_alg.c
Date: Sun, 24 Mar 2024 18:30:46 -0400
Message-ID: <20240324223455.1342824-468-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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

[ Upstream commit dfff0e35fa5dd84ae75052ba129b0219d83e46dc ]

As a result of the removal of qat_zlib_deflate, some defines where not
removed. Remove them.

This is to fix the following warning when compiling the QAT driver
using the clang compiler with CC=clang W=2:
    drivers/crypto/intel/qat/qat_common/qat_comp_algs.c:21:9: warning: macro is not used [-Wunused-macros]
       21 | #define QAT_RFC_1950_CM_OFFSET 4
          |         ^
    drivers/crypto/intel/qat/qat_common/qat_comp_algs.c:16:9: warning: macro is not used [-Wunused-macros]
       16 | #define QAT_RFC_1950_HDR_SIZE 2
          |         ^
    drivers/crypto/intel/qat/qat_common/qat_comp_algs.c:17:9: warning: macro is not used [-Wunused-macros]
       17 | #define QAT_RFC_1950_FOOTER_SIZE 4
          |         ^
    drivers/crypto/intel/qat/qat_common/qat_comp_algs.c:22:9: warning: macro is not used [-Wunused-macros]
       22 | #define QAT_RFC_1950_DICT_MASK 0x20
          |         ^
    drivers/crypto/intel/qat/qat_common/qat_comp_algs.c:18:9: warning: macro is not used [-Wunused-macros]
       18 | #define QAT_RFC_1950_CM_DEFLATE 8
          |         ^
    drivers/crypto/intel/qat/qat_common/qat_comp_algs.c:20:9: warning: macro is not used [-Wunused-macros]
       20 | #define QAT_RFC_1950_CM_MASK 0x0f
          |         ^
    drivers/crypto/intel/qat/qat_common/qat_comp_algs.c:23:9: warning: macro is not used [-Wunused-macros]
       23 | #define QAT_RFC_1950_COMP_HDR 0x785e
          |         ^
    drivers/crypto/intel/qat/qat_common/qat_comp_algs.c:19:9: warning: macro is not used [-Wunused-macros]
       19 | #define QAT_RFC_1950_CM_DEFLATE_CINFO_32K 7
          |         ^

Fixes: e9dd20e0e5f6 ("crypto: qat - Remove zlib-deflate")
Signed-off-by: Adam Guerin <adam.guerin@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_common/qat_comp_algs.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
index bf8c0ee629175..2ba4aa22e0927 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
@@ -13,15 +13,6 @@
 #include "qat_compression.h"
 #include "qat_algs_send.h"
 
-#define QAT_RFC_1950_HDR_SIZE 2
-#define QAT_RFC_1950_FOOTER_SIZE 4
-#define QAT_RFC_1950_CM_DEFLATE 8
-#define QAT_RFC_1950_CM_DEFLATE_CINFO_32K 7
-#define QAT_RFC_1950_CM_MASK 0x0f
-#define QAT_RFC_1950_CM_OFFSET 4
-#define QAT_RFC_1950_DICT_MASK 0x20
-#define QAT_RFC_1950_COMP_HDR 0x785e
-
 static DEFINE_MUTEX(algs_lock);
 static unsigned int active_devs;
 
-- 
2.43.0


