Return-Path: <linux-kernel+bounces-32443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8343D835BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD32B25023
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E5818624;
	Mon, 22 Jan 2024 07:39:11 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFDA2FE15;
	Mon, 22 Jan 2024 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909151; cv=none; b=qq6Zdd0tKJuY7hM/e+6XpN57ayVYLvelhbk05Pqa4Jt1x2xtKqDtT7THOhK+C0M73jYPQjdcRlPpLJQ4SdaSbKGhqiYWCrIrIWXZS2+uE5wDsft1fyP1WkzX1TCWgQ6Te4L196kGXCNdINGEg00N6vkY8GaTLstNz9ES+nrQfsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909151; c=relaxed/simple;
	bh=ASkvNL+WBKTxbaQNMIjBmg1cXddIy1p77kjdfuRrvQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rB43jXMgFN4Z2jGxKjBENo4UCtqsPHP1o7Sm6WVfGdXBXNjh9Mz/D/QqRwnCn6+jea36AWlX5KenmDd30+2W/G5IUURfhJoYJRYDC6VamjOXTixc9g/p84kxCthcdk9ff1ptXbBu/50Abahz0s8tvx1yrYDDpEoYZWOYyv5ab7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TJMX905Vqz1xmYs;
	Mon, 22 Jan 2024 15:38:17 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D2B41A016B;
	Mon, 22 Jan 2024 15:38:52 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Jan
 2024 15:37:40 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v2 5/7] tracing: add new type "%pd/%pD" in readme_msg[]
Date: Mon, 22 Jan 2024 15:40:13 +0800
Message-ID: <20240122074015.4042575-6-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240122074015.4042575-1-yebin10@huawei.com>
References: <20240122074015.4042575-1-yebin10@huawei.com>
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
index 2a7c6fd934e9..13197d3b86bd 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5745,7 +5745,7 @@ static const char readme_msg[] =
 	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, char, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
-	"\t           symstr, <type>\\[<array-size>\\]\n"
+	"\t           symstr, %pd/%pD <type>\\[<array-size>\\]\n"
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t    field: <stype> <name>;\n"
 	"\t    stype: u8/u16/u32/u64, s8/s16/s32/s64, pid_t,\n"
-- 
2.31.1


