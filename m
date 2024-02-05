Return-Path: <linux-kernel+bounces-51995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01453849280
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E6A1C21FE3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755648F6D;
	Mon,  5 Feb 2024 02:42:36 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334BB641;
	Mon,  5 Feb 2024 02:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707100956; cv=none; b=FYPQ8rr3zaz4gnpWBe1Ytyi8iuW4sJGwldozjGE66nkntPuR7HDVEIlv3wQ0evjKQKmCU6VM3+BWMzpdkTh2fxIsSaTSFcbVMLrDR/fDOEQ/lGe4wikdKx4IvhhLX3KgjNbHejBpKYV2o9oz+VXhho5bURxn+5T/ZcNBuMeBFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707100956; c=relaxed/simple;
	bh=HLOV5juc9V21oxs5QlKgUfEkMeIEqmDHRV557PeYu5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ul7PuYKExvfovABrvNsi1BgxDp2b3kQU86/DVOvdNtt8NPTkdl2aNEwoYgpLR3hqZXoATyLsSLjYImq34gJnoDngOUCMeK5gQr1OlbNTlX8VwnqXLhl6KJwM7FSZtn0QaymSUJyfsFPyn+d5jKG5U9BKFUQ7hXAlm9RelCOW8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp71t1707100845t33pzhpj
X-QQ-Originating-IP: tEmptkO3RX7FmDcpxkDieLOniV0tL5NFvlU0xAeyXd0=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 05 Feb 2024 10:40:44 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: q+EIYT+FhZrcpAw8J2l7WYvl1nkWUiMk5YKYvT/b9Yt7WT9Ef3sSYNzREBFwn
	gfqNy+umEk8UOTLeVLbEYL49fYXZ8WvfbX9v7vsGiGxNF/c7na+ZIQxjRURnp4WpzmK8ecM
	Af9captGYMnaoI1MxWe+IgV7UisapmLsv7QgGRookv0v6EzH3n7Kmq4MZ7pNxUtxr0V5b6Y
	xzwvPq+CBgupPWnqqfCMZyrgw0rAksl9UTMQfyspbiL8FSUbma74JDxoYvg0R4JEBjRW7ce
	UzeNk3xSIMjQu3kZ4qHcLpE5W2XRvaAKAT6LVBjpm24S7ZXoGxfPVIUtYPsPsXgeWOof9P0
	7x1A3x7GMb6Hk1NeKxNCm4eQ2TndP92FbXtLDdYM+68BG0J/lin+0Zv/RMUkRQUoUU1EovZ
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1361134515028198652
From: Dawei Li <dawei.li@shingroup.cn>
To: robh+dt@kernel.org,
	frowand.list@gmail.com,
	lkp@intel.com
Cc: stephen.boyd@linaro.org,
	oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH] of: Make explicit cpu_to_be32 conversion to mute sparse warning
Date: Mon,  5 Feb 2024 10:40:33 +0800
Message-Id: <20240205024033.3572617-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <202402042134.GEb3Bgwl-lkp@intel.com>
References: <202402042134.GEb3Bgwl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Kernel test robot reports sparse warning:
sparse warnings: (new ones prefixed by >>)
>> drivers/of/base.c:1337:73: sparse: sparse: incorrect type in initializer
   (different base types) @@  expected restricted __be32 @@  got int @@
   drivers/of/base.c:1337:73: sparse:     expected restricted __be32
   drivers/of/base.c:1337:73: sparse:     got int

Thus, Make explicit conversions to mute warning(Although BE and LE are
exactly same in binary representation for 0/~0).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402042134.GEb3Bgwl-lkp@intel.com/
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/of/base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index b0ad8fc06e80..f71cda9ac09d 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1345,8 +1345,8 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 	char *pass_name = NULL;
 	struct device_node *cur, *new = NULL;
 	const __be32 *map, *mask, *pass;
-	static const __be32 dummy_mask[] = { [0 ... MAX_PHANDLE_ARGS] = ~0 };
-	static const __be32 dummy_pass[] = { [0 ... MAX_PHANDLE_ARGS] = 0 };
+	static const __be32 dummy_mask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
+	static const __be32 dummy_pass[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(0) };
 	__be32 initial_match_array[MAX_PHANDLE_ARGS];
 	const __be32 *match_array = initial_match_array;
 	int i, ret, map_len, match;
-- 
2.27.0


