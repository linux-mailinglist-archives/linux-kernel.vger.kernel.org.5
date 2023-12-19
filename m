Return-Path: <linux-kernel+bounces-4520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D301B817ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED4828620A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A832A10E6;
	Tue, 19 Dec 2023 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Fd3bwcfY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C948D7F;
	Tue, 19 Dec 2023 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 00F272E5;
	Tue, 19 Dec 2023 00:26:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 00F272E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1702945587; bh=NNOsYBK/vPHD2b+kV3MNgqjJSrWgLRuAXXUki4GTPos=;
	h=From:To:Cc:Subject:Date:From;
	b=Fd3bwcfY2gNo4TIzJQYY1IDkRWAfdq1C73MWeNEN9SWMkBizH6B2tm40uFcQt3A3n
	 vvDvMUM+Bm5XflQWVUt+ALlkBBlKeygVcLP+CyWAf8XiCfj36GhA/KKKz/3acDK97o
	 kYNseNGNscTDXgPRRmJY93qOgxL1J38xe0e3GG0nizQBSb8LSiwMUI4Lij+wwbUcxR
	 t8WP0CpBzD+oY8N3O3akAsT9z3rel9tT4grWIfpwGDYdTW2x5QzibW+nZR7f90jtqF
	 7qlwa2K9CYksH1owdGFcFrn5LFwSzcTVUHBuBfhKOoczpuQFm3gTN0KMYZoMUSFhqa
	 LsPvrpLHIZEjA==
From: Jonathan Corbet <corbet@lwn.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: skbuff: Remove some excess struct-member documentation
Date: Mon, 18 Dec 2023 17:26:26 -0700
Message-ID: <87cyv3javh.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Remove documentation for nonexistent structure members, addressing these
warnings:

  ./include/linux/skbuff.h:1063: warning: Excess struct member 'sp' description in 'sk_buff'
  ./include/linux/skbuff.h:1063: warning: Excess struct member 'nf_bridge' description in 'sk_buff'

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/linux/skbuff.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 27998f73183e..1cdab90a10a2 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -742,7 +742,6 @@ typedef unsigned char *sk_buff_data_t;
  *	@dev_scratch: (aka @dev) alternate use of @dev when @dev would be %NULL
  *	@cb: Control buffer. Free for use by every layer. Put private vars here
  *	@_skb_refdst: destination entry (with norefcount bit)
- *	@sp: the security path, used for xfrm
  *	@len: Length of actual data
  *	@data_len: Data length
  *	@mac_len: Length of link layer header
@@ -776,7 +775,6 @@ typedef unsigned char *sk_buff_data_t;
  *	@tcp_tsorted_anchor: list structure for TCP (tp->tsorted_sent_queue)
  *	@_sk_redir: socket redirection information for skmsg
  *	@_nfct: Associated connection, if any (with nfctinfo bits)
- *	@nf_bridge: Saved data about a bridged frame - see br_netfilter.c
  *	@skb_iif: ifindex of device we arrived on
  *	@tc_index: Traffic control index
  *	@hash: the packet hash
-- 
2.43.0


