Return-Path: <linux-kernel+bounces-6118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 960298194D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49EB71F24970
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EEA3FB21;
	Tue, 19 Dec 2023 23:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BZzeEuPP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2773440BE0;
	Tue, 19 Dec 2023 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4E3632AE;
	Tue, 19 Dec 2023 23:55:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4E3632AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1703030132; bh=EXq6rWek7Ihcua6GQcHpZR4rHtTXCSQsjBPcDo0bgYA=;
	h=From:To:Cc:Subject:Date:From;
	b=BZzeEuPPsI1uDYd4TlY8Q+Euo89z8zsKuR8O9P5rl5Nk0qXX8A013GzquNUTlX4Y5
	 Z5/w5Tgj2Vx/zD5SGfkwONokhWWeZbYSLkuBlpozS5itGfdVPDz4y2oH8MPijx0x/U
	 qKF2CITgydhq2Av12VdjiHHVlxZPv8MVuzaSiTwHzxPLdYAZkAPOIWLaYF3Oex0tLs
	 WVGOcse6sh8F/mTtWovthNwb7dn3mhafhbc5p0HVBAmRSv3IofcLaYit6+BdxNK7KT
	 rHiholnf3XHH6EKqg4+8jKwjMxR/wxkQ+M5yuPqewPDSFuxIqnAYwuzh6Fq3O7CoC2
	 viWeEzJ14cMEw==
From: Jonathan Corbet <corbet@lwn.net>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH net] ethtool: reformat kerneldoc for struct ethtool_fec_stats
Date: Tue, 19 Dec 2023 16:55:31 -0700
Message-ID: <87v88tg32k.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The kerneldoc comment for struct ethtool_fec_stats attempts to describe the
"total" and "lanes" fields of the ethtool_fec_stat substructure in a way
leading to these warnings:

  ./include/linux/ethtool.h:424: warning: Excess struct member 'lane' description in 'ethtool_fec_stats'
  ./include/linux/ethtool.h:424: warning: Excess struct member 'total' description in 'ethtool_fec_stats'

Reformat the comment to retain the information while eliminating the
warnings.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/linux/ethtool.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 689028257fcc..77c7a9ac0ece 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -409,8 +409,10 @@ struct ethtool_pause_stats {
  *	not entire FEC data blocks. This is a non-standard statistic.
  *	Reported to user space as %ETHTOOL_A_FEC_STAT_CORR_BITS.
  *
- * @lane: per-lane/PCS-instance counts as defined by the standard
- * @total: error counts for the entire port, for drivers incapable of reporting
+ * For each of the above fields, the two substructure members are:
+ *
+ * - @lanes: per-lane/PCS-instance counts as defined by the standard
+ * - @total: error counts for the entire port, for drivers incapable of reporting
  *	per-lane stats
  *
  * Drivers should fill in either only total or per-lane statistics, core
-- 
2.43.0


