Return-Path: <linux-kernel+bounces-113359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DC08883B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD3E1B21295
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C94D19BBB0;
	Sun, 24 Mar 2024 22:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKtXdLeX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8969719BB93;
	Sun, 24 Mar 2024 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320160; cv=none; b=ZJIEenlUNf0Nels9cK3DqljWCLPMeEuDStMMLREV87/eQigrBJPWpE+1gqjoe/8o74pmYGgZe09LxRTN9wcDFKbSFyOHh4z1ncURD/sVFLr1ZB7GOoGmNfYHg0IJ6M0+dfyNwapDQqh5pUvdcqXGAWmSsiROYrgCqt15izghGuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320160; c=relaxed/simple;
	bh=8BK6+/8kcaLej6DGTBCcocnkWvmX8qwCPKlOjlJU6Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiA6lF0t++WIaPd9lMVMkCv9muVTt3g1EJfsEJ8odqo3RTJLZ2sQqG+KwzizVfNwUj4pkgNeudlh8eKY0mSZLYdeHFiHDyzMJMY4NlGxKaABN/WvOd1C6zUczHOAOlRiw+oYGMnfnw8wR9zN0koARHENLwCyUel0o+bDq26zgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKtXdLeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B10C433F1;
	Sun, 24 Mar 2024 22:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320160;
	bh=8BK6+/8kcaLej6DGTBCcocnkWvmX8qwCPKlOjlJU6Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MKtXdLeXajB6BOoJrE2Nwa6fpbLFLQ736Lhneae/V4xW8KBS0o7zy2Y0a3+zKlsEs
	 U7NgU7ZxFLIpLCu/RDX7bW6U2TCBRffJ276qpN0su+QCu1XbWmpjZAhqbjyr8RIJwe
	 RLbWue2bUKb9I1ZSF68wG8Ude/SvurUH/otxVJUYss9ELwyCCV1V0kkoTFrASYhntd
	 9u2q+D3luRDgp4o1lCKP+s6XLPcsVgWzFMW6PYTTa53890c5K1TBxq+ZYCkofXexgV
	 FBAbiyKidzWZXC/EDer9PoxdHKD/NnLDXJztuwDWBXhD2bpPi63TOx6sZjjSxqqrWb
	 4XF4/9v/sgu6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Guerin <adam.guerin@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 468/715] crypto: qat - removed unused macro in adf_cnv_dbgfs.c
Date: Sun, 24 Mar 2024 18:30:47 -0400
Message-ID: <20240324223455.1342824-469-sashal@kernel.org>
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


