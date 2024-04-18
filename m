Return-Path: <linux-kernel+bounces-150638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFE18AA226
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBFE1F222AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBA217A93E;
	Thu, 18 Apr 2024 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Hi3Jp4sw";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Hi3Jp4sw"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A056C3D62;
	Thu, 18 Apr 2024 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465587; cv=none; b=J7UaJ2JqtX3yHm0Cugjeb0o1DQ/juQ1Y1815/e+sG3Ogc/R+WTj08oYS4qZhOj7xH/NShS7mHMY93lLpJRT96oC5QP6HF+jkT9otAyqzI/kE0sjNkRLmKjqboKRentHenUR9kMVqPA+CVZvbFubS0Ldxz2Ccku+HN4uay6tmYro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465587; c=relaxed/simple;
	bh=hBSDSV+mnBi/oihnn1Z5oOHvH7BDERKVHnf9AkoBfdQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Y6caRIA6ez71ujOrBDdJ+Zkvhv2yIYqQgmgjtT1PIJKCZjZd8nO++LcG+mTzG5AmQ1mo1FEKAzPzpksfF8UTEEc0TjX3PML71FEUm3cTtuXTUbDSwvx67QEetQoDh000fSAeguiaVf1ejLyEvSl9TPn4C+lzj8CqYzaAVrzoT6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Hi3Jp4sw; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Hi3Jp4sw; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1713465584;
	bh=hBSDSV+mnBi/oihnn1Z5oOHvH7BDERKVHnf9AkoBfdQ=;
	h=Message-ID:Subject:From:To:Date:From;
	b=Hi3Jp4swtunpUUSDRzYKoZzDepM/4wvqeeW6sAcrEOSAt6xZTS9VYHndPqTiI1eLg
	 dLMEM7L9S+9JkiZxHJA7nEZoNiHr+hsL/hE8VAE8WLmHWQngBKGOToQ3xHST3s8lfd
	 wJb5mWBg3wH4SdV9aFzvTQ/5y9WqUuxAvZCQJ5wo=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C6A6B1280BEA;
	Thu, 18 Apr 2024 14:39:44 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id hG39kuRMLoYQ; Thu, 18 Apr 2024 14:39:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1713465584;
	bh=hBSDSV+mnBi/oihnn1Z5oOHvH7BDERKVHnf9AkoBfdQ=;
	h=Message-ID:Subject:From:To:Date:From;
	b=Hi3Jp4swtunpUUSDRzYKoZzDepM/4wvqeeW6sAcrEOSAt6xZTS9VYHndPqTiI1eLg
	 dLMEM7L9S+9JkiZxHJA7nEZoNiHr+hsL/hE8VAE8WLmHWQngBKGOToQ3xHST3s8lfd
	 wJb5mWBg3wH4SdV9aFzvTQ/5y9WqUuxAvZCQJ5wo=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1221E1281015;
	Thu, 18 Apr 2024 14:39:44 -0400 (EDT)
Message-ID: <14ac270fbf39d20eb8fd8a94a73cb2ae75d9acec.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.9-rc4
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Thu, 18 Apr 2024 14:39:42 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Two minor fixes: one in the core to improve the handling of warnings
and unconditionally clear the command flags when ending a request and
the other to add missing table values needed for bandwidth scaling in
qualcomm ufs.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Bart Van Assche (1):
      scsi: core: Fix handling of SCMD_FAIL_IF_RECOVERING

Manivannan Sadhasivam (1):
      scsi: ufs: qcom: Add missing interconnect bandwidth values for Gear 5

And the diffstat:

 drivers/scsi/scsi_lib.c     | 7 +++----
 drivers/ufs/host/ufs-qcom.c | 8 +++++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 2e28e2360c85..5b3230ef51fe 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -635,10 +635,9 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 	if (blk_queue_add_random(q))
 		add_disk_randomness(req->q->disk);
 
-	if (!blk_rq_is_passthrough(req)) {
-		WARN_ON_ONCE(!(cmd->flags & SCMD_INITIALIZED));
-		cmd->flags &= ~SCMD_INITIALIZED;
-	}
+	WARN_ON_ONCE(!blk_rq_is_passthrough(req) &&
+		     !(cmd->flags & SCMD_INITIALIZED));
+	cmd->flags = 0;
 
 	/*
 	 * Calling rcu_barrier() is not necessary here because the
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 06859e17b67b..7a00004bfd03 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -47,7 +47,7 @@ enum {
 	TSTBUS_MAX,
 };
 
-#define QCOM_UFS_MAX_GEAR 4
+#define QCOM_UFS_MAX_GEAR 5
 #define QCOM_UFS_MAX_LANE 2
 
 enum {
@@ -67,26 +67,32 @@ static const struct __ufs_qcom_bw_table {
 	[MODE_PWM][UFS_PWM_G2][UFS_LANE_1] = { 1844,		1000 },
 	[MODE_PWM][UFS_PWM_G3][UFS_LANE_1] = { 3688,		1000 },
 	[MODE_PWM][UFS_PWM_G4][UFS_LANE_1] = { 7376,		1000 },
+	[MODE_PWM][UFS_PWM_G5][UFS_LANE_1] = { 14752,		1000 },
 	[MODE_PWM][UFS_PWM_G1][UFS_LANE_2] = { 1844,		1000 },
 	[MODE_PWM][UFS_PWM_G2][UFS_LANE_2] = { 3688,		1000 },
 	[MODE_PWM][UFS_PWM_G3][UFS_LANE_2] = { 7376,		1000 },
 	[MODE_PWM][UFS_PWM_G4][UFS_LANE_2] = { 14752,		1000 },
+	[MODE_PWM][UFS_PWM_G5][UFS_LANE_2] = { 29504,		1000 },
 	[MODE_HS_RA][UFS_HS_G1][UFS_LANE_1] = { 127796,		1000 },
 	[MODE_HS_RA][UFS_HS_G2][UFS_LANE_1] = { 255591,		1000 },
 	[MODE_HS_RA][UFS_HS_G3][UFS_LANE_1] = { 1492582,	102400 },
 	[MODE_HS_RA][UFS_HS_G4][UFS_LANE_1] = { 2915200,	204800 },
+	[MODE_HS_RA][UFS_HS_G5][UFS_LANE_1] = { 5836800,	409600 },
 	[MODE_HS_RA][UFS_HS_G1][UFS_LANE_2] = { 255591,		1000 },
 	[MODE_HS_RA][UFS_HS_G2][UFS_LANE_2] = { 511181,		1000 },
 	[MODE_HS_RA][UFS_HS_G3][UFS_LANE_2] = { 1492582,	204800 },
 	[MODE_HS_RA][UFS_HS_G4][UFS_LANE_2] = { 2915200,	409600 },
+	[MODE_HS_RA][UFS_HS_G5][UFS_LANE_2] = { 5836800,	819200 },
 	[MODE_HS_RB][UFS_HS_G1][UFS_LANE_1] = { 149422,		1000 },
 	[MODE_HS_RB][UFS_HS_G2][UFS_LANE_1] = { 298189,		1000 },
 	[MODE_HS_RB][UFS_HS_G3][UFS_LANE_1] = { 1492582,	102400 },
 	[MODE_HS_RB][UFS_HS_G4][UFS_LANE_1] = { 2915200,	204800 },
+	[MODE_HS_RB][UFS_HS_G5][UFS_LANE_1] = { 5836800,	409600 },
 	[MODE_HS_RB][UFS_HS_G1][UFS_LANE_2] = { 298189,		1000 },
 	[MODE_HS_RB][UFS_HS_G2][UFS_LANE_2] = { 596378,		1000 },
 	[MODE_HS_RB][UFS_HS_G3][UFS_LANE_2] = { 1492582,	204800 },
 	[MODE_HS_RB][UFS_HS_G4][UFS_LANE_2] = { 2915200,	409600 },
+	[MODE_HS_RB][UFS_HS_G5][UFS_LANE_2] = { 5836800,	819200 },
 	[MODE_MAX][0][0]		    = { 7643136,	307200 },
 };
 


