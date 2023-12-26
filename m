Return-Path: <linux-kernel+bounces-11449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282C681E687
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586CB1C20FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382404D132;
	Tue, 26 Dec 2023 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eNa/a31B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5DC4D582
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703583788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JZxsk+Jzb07h2zuZtmSvZ0zyWEXPJHnNQin19esIT5o=;
	b=eNa/a31B2+Tvl3x5TdZ+1l5iF9uhme41x+em/lthqENyNR5zztGqw/1yvZk7Lo5dNBiXb8
	5h4JKBfpcTMd1EuzLCW8EzpZA9MMbPhkNvoVaTwBEyXRN6x/iNdAZSqcRthIpmsaN22JPD
	TfMJWyMsCH4R8VybN845OZhdkVd+YEA=
From: George Guo <dongtai.guo@linux.dev>
To: horms@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 01/14] netfilter: cleanup enum nft_set_class
Date: Tue, 26 Dec 2023 17:42:42 +0800
Message-Id: <20231226094255.77911-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Correct comments for nlpid, family, udlen and udata in struct nft_table,
and afinfo is no longer a member of enum nft_set_class.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/net/netfilter/nf_tables.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index b157c5cafd14..18ec566cbc34 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -351,9 +351,9 @@ struct nft_set_desc {
 /**
  *	enum nft_set_class - performance class
  *
- *	@NFT_LOOKUP_O_1: constant, O(1)
- *	@NFT_LOOKUP_O_LOG_N: logarithmic, O(log N)
- *	@NFT_LOOKUP_O_N: linear, O(N)
+ *	@NFT_SET_CLASS_O_1: constant, O(1)
+ *	@NFT_SET_CLASS_O_LOG_N: logarithmic, O(log N)
+ *	@NFT_SET_CLASS_O_N: linear, O(N)
  */
 enum nft_set_class {
 	NFT_SET_CLASS_O_1,
-- 
2.39.2


