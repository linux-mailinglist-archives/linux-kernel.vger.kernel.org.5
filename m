Return-Path: <linux-kernel+bounces-104096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F3787C8EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6371C20F70
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0336917C6B;
	Fri, 15 Mar 2024 06:54:25 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D084713AE2;
	Fri, 15 Mar 2024 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710485664; cv=none; b=B2foDgLtlngckAM0HG6GuC2bGiWruAEPH+mdlgxNc/I6XRuuWf72v7pTjBJ3MAOMX+Qu16ATKOxXurL9bHjxDXtGWe81x4lf8n9VnLRv5zIWikCJ7VtoBZ4xNgNWry0d6Qk3votuuZJWNRrdFixZ6xc3Yq5Ogh4uU3Q3VCQNLcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710485664; c=relaxed/simple;
	bh=QEHYEKZn/nfC/bCEp7pLWNVR586Kb/4ue5St/ROhyu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTa2ARUjDBVOwy5XS+f5YAkebGTTDLh2hMK+1IWzv1zAszttQbR3eZiY7dxMYpBYb+bq/tNelf/wczNYV0jqkucnYseK5IC2o2ZnUDWp1M2dbmvKyPgbHI/hkf9Cs5ORP4RyxOrD8R0zKP271NDnKwLpsKTZZzyOGMzMY8SKP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tww2f3Q2nz1FMLf;
	Fri, 15 Mar 2024 14:54:02 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B946140157;
	Fri, 15 Mar 2024 14:54:20 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 15 Mar
 2024 14:54:19 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v6 5/8] tracing: add new type "%pd/%pD" in readme_msg[]
Date: Fri, 15 Mar 2024 14:55:37 +0800
Message-ID: <20240315065540.1181879-6-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240315065540.1181879-1-yebin10@huawei.com>
References: <20240315065540.1181879-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b12f8384a36a..831dfd0773a4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5510,7 +5510,7 @@ static const char readme_msg[] =
 	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, char, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
-	"\t           symstr, <type>\\[<array-size>\\]\n"
+	"\t           symstr, %pd/%pD, <type>\\[<array-size>\\]\n"
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t    field: <stype> <name>;\n"
 	"\t    stype: u8/u16/u32/u64, s8/s16/s32/s64, pid_t,\n"
-- 
2.31.1


