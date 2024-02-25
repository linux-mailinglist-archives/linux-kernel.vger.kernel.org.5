Return-Path: <linux-kernel+bounces-79968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9994886290B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 05:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA62281FF3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02D0944E;
	Sun, 25 Feb 2024 04:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="gzfGNrbQ"
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2BF8F55
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708833997; cv=none; b=LuQXC4cfSmyfzSyXbY58Zwr8kFvXbIP9cdg8BDtmRpR0QWbiuF7MvE33FBlEdhu2CgBC+FT4ung4EXGUftMbLsxPQadd5yyZD4Be/EjTK02sr9JJRlLHj9zN8hTM0E+pjZjPOQcmahAX7UGPEGqglfrc8Adi5Rkt4YDSz/PAzX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708833997; c=relaxed/simple;
	bh=e5AVl2ANYvMw9N2sa9FyVacc4tJHJrJOSKOahOrMncE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NOmxTkPSGHdQbCTqWrb3GTxmbItbv4uo8pebbnZZlnB6AoHH/zrsoJwEi1OIW3iisC6UHjhL4fjawfmh/o2KfkE7cdKJes5RHFH4wfzvXJ6QmnMOyoc7PC/2cegXSzBbBlSi/C44xSgill5tcUcyD9l1mga0rw/bLYxW/qB9h70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=gzfGNrbQ; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708833992;
	bh=kz5lRhDy5wWwgey/c2k6rCr2dAMwayc5iymGADo4jSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gzfGNrbQrLQfxGpqUi3kyJOObNozSeKh0+SuDwY2wzUQ77pnPebWEXaLfuHTfnMqo
	 jeQ8pLi8YibV7PiKeXun6nYSWdi5Z8f40uE5YrWtuREb2jFm90HuVhf7woKIoVwYvl
	 36VeRhhewqaDgogYZxxBSBfx2POw5ojH/TM5eiUQ=
Received: from localhost.localdomain ([2409:8a60:2a61:ef40:480f:5c56:cca3:1b20])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 18993038; Sun, 25 Feb 2024 12:06:09 +0800
X-QQ-mid: xmsmtpt1708833981tm17norn6
Message-ID: <tencent_B6BFA2E7C5AA16EAADA0A44999743B661B07@qq.com>
X-QQ-XMAILINFO: MvTK+AXQ7a4FI67fVnk9OUz74OFyJLvk50+sgH3sj0llM/pitKfIOnKai3pgXx
	 d+3RDni8PSTEcgoQ9KvJ+JTAymJ4VlkbSWmgEsrunFiJJVcJWeGIXOlctAGE7uymymcDddT4H347
	 tIRPeVgS2geeYp+6nH4psXGaklXTRP3sDRkaRwHw/ygagR0oQZmAy2EDMmHZpS6Pf3y6Y8PWei+G
	 61u774YEeiaRSmI0x54MAHrMxMn2rRBxXarkezVwVzEBKds1wDzF671WsjThSCJyvxcuRD8m+Ood
	 GYqWF8oyF2VjLrBQnGyn2XSf8MLMm7xxstr+Fk/xa0CyU4yH+1+wJVTYqv8yFT4XG4CSXmF/0JWB
	 P2Faocdx5W0qxzc55ZzmjjeUzQD0nTEAjYjVuHtnym6dzrbQoq4fdkg+fLOrqNLlULX7sH8bShC2
	 MrmGRs0a583gPrg+tA2SXydBRLGt6OwUZ8ru0qncgjblaRkvUQk9e/l9J0tyE9ummBP5GG89MLIe
	 GX/d/8pPgGa6/eynEmVyMGipizz8MuFMh1ojS7Pg+Qx+IjsJgV3ZMPZcdvill4K77C1RylR7v6sA
	 rVvmVeYrEzE9SAzmAPSNv0aKs2avWNJyT5q+IfV9aEKexUbY2bsmZINfQtdvxyJ/keSyXVIlOFPE
	 kFBFg1wDqCEZWV+r7w+dSIrXA+JuHTsHz1g3B50KiQK5F9Ag0zP0DDJrMHUClKLSrpUMWyQ92J6x
	 Y9s8sQHSA4UzOG4MKSfPs3nPfOvQlNTEF1/pIUejFg1K9bOdbLZlDzzCv/l5eK24z9rjxyGJsQLk
	 TYJ9EMu9Q5y5eDUI2YN0wqaWmuCdsr0wCkyh+lLVzu7tSQxbhWLV7cqgz6GAVohSZ6wwlkmKRrHV
	 tRhmeePFST51Sl94/btuB5Wm5dlx5KjeNufXfwAsL74VIOBjJJjcxYrVutui5K06PRoBwOfWH68U
	 +tZdhdA5ImngJySh42JoD9T2zv340IlKF6U19A+wmQwzP6Ycp5EELlKdCmbejKHg+sj0eS156ZM8
	 3skNmb8y3n9rWo1pYYvFW8lkJUR3yyr3mZvXFp1A==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: wenyang.linux@foxmail.com
To: Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>,
	davem@davemloft.net,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] rxrpc: delete these duplicate static variables n_65535 and four
Date: Sun, 25 Feb 2024 12:05:32 +0800
X-OQ-MSGID: <20240225040538.845899-3-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240225040538.845899-1-wenyang.linux@foxmail.com>
References: <20240225040538.845899-1-wenyang.linux@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

Since these static variables (n_65535 and four) are only used for
boundary checks and will not be changed, remove them and use the ones
in our shared const array.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 net/rxrpc/sysctl.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/rxrpc/sysctl.c b/net/rxrpc/sysctl.c
index ecaeb4ecfb58..4e2230cf6ff6 100644
--- a/net/rxrpc/sysctl.c
+++ b/net/rxrpc/sysctl.c
@@ -11,9 +11,7 @@
 #include "ar-internal.h"
 
 static struct ctl_table_header *rxrpc_sysctl_reg_table;
-static const unsigned int four = 4;
 static const unsigned int max_backlog = RXRPC_BACKLOG_MAX - 1;
-static const unsigned int n_65535 = 65535;
 static const unsigned int n_max_acks = 255;
 static const unsigned long one_jiffy = 1;
 static const unsigned long max_jiffies = MAX_JIFFY_OFFSET;
@@ -86,8 +84,8 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
-		.extra2		= (void *)&n_65535,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_U16_MAX,
 	},
 	{
 		.procname	= "max_backlog",
@@ -95,7 +93,7 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&four,
+		.extra1		= SYSCTL_FOUR,
 		.extra2		= (void *)&max_backlog,
 	},
 	{
@@ -113,8 +111,8 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
-		.extra2		= (void *)&n_65535,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_U16_MAX,
 	},
 	{
 		.procname	= "rx_jumbo_max",
@@ -122,8 +120,8 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
-		.extra2		= (void *)&four,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_FOUR,
 	},
 	{ }
 };
-- 
2.25.1


