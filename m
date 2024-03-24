Return-Path: <linux-kernel+bounces-113880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF7588871D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18091292ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EE4139586;
	Sun, 24 Mar 2024 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY7sS0Gh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1881EBD47;
	Sun, 24 Mar 2024 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320936; cv=none; b=PKSTH8COAZhI4e0NdSrozo8RBSuNGqTFQXql8c2OM1udW0xiR6zgX5pO8u/I6c8sX4NiBPyfOdXxjdH68zdzWpEJSyN33uExBnMOrRI3IhTrcbzzEc1A8foIF+nZvc28WKYYIzOdTw3pVGL6VOZwynkYmL+Ypg6MICDisoGKi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320936; c=relaxed/simple;
	bh=eFw53uz7Utyd3JbrNXm2U9OSaLEXN0g6S7t/oGiM3VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOnrzDExGH0J+nkZmqOn0pyD1ly6E7h0gYIx9EnL+nyjFsiVy1aTfFT9aOVVgA3lDKq8O47MEggcxjtSAsv1/CvkDlA4+EbD66C3x3aHPvKHpigmEl6AXeyEp0XPEv9nzSVAsbGtjhfANLFQt+iiHTmstzEmAU/oOz1GQRDYuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY7sS0Gh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAC1C433C7;
	Sun, 24 Mar 2024 22:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320934;
	bh=eFw53uz7Utyd3JbrNXm2U9OSaLEXN0g6S7t/oGiM3VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dY7sS0GhVOJZRpvZAB+nRE5F6i8hhTPvoVgmYQ025hPks6lDnrOBeYooOFgxEnZsm
	 vjKgMwjjeXGFNenRrqc0EXkdWfHc3iE4f38nqDtqfaOD9Gz/nZMj66prTu3VtFe7Uh
	 MUVrkNmyux9G6nRUaxeX4daXbJmNFHVLLJOnOF7fDDoYE3zgJxEjuP2RJeNF8e78ns
	 Q78C3cMG096IiiJ7+1rqLsY/eWQPnubfkt19yr1M/IgLefkKEyGrdWhliOqOjeL+D7
	 MuWLo3JSYV1GYbSUXcBwt2GiB0LCa+S6d+mIpLF1qtyoKplUIWeEqqaNs2gjJpxbEj
	 DWzROcAnCa9SA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Guerin <adam.guerin@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 498/713] crypto: qat - remove unused macros in qat_comp_alg.c
Date: Sun, 24 Mar 2024 18:43:44 -0400
Message-ID: <20240324224720.1345309-499-sashal@kernel.org>
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


