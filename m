Return-Path: <linux-kernel+bounces-111332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29F5886ACD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F9C2873B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981673F8F0;
	Fri, 22 Mar 2024 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="25h+Zmx2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UqGrHAw/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE603CF79;
	Fri, 22 Mar 2024 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105102; cv=none; b=buP/qIlKXgCdnVemoXQ8SqMFeeMHH2QUMbADWy0kMinElePrs0d8QJfYozAb7JcyzWJKpy1D0dsOfjF+aj7LIJ4WU/PTe8InYvfwkipJhQv5qnry0qaqDbcsLDd8KRhMhGgd0TcoChaoLxD8i74rgPfTnfM4YFPPcElAWMKAL8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105102; c=relaxed/simple;
	bh=du/RyorNYJaSOdH+SK94mWj59rhDrB0eMa/9FDO56QA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cFIIA4Mgbtim6u5iisqVL900+EFdNmxbnAYLiHDUCiuauGmRmrvS16F27uJrWYILtdEqI6aSDY4oIEfqV0Yfc3mm67oWLa/BiX5DRMOYGF5ZgqwOZ66869ARiirHKdyamCljv5N3KhDCngkDx0welrADmcLOk1sUBCb3hn0Nlnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=25h+Zmx2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UqGrHAw/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 10:58:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711105094;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njPGq1K1+bmrc0wxTVarMwLPYuhqB6UaiS+5OrpG8tA=;
	b=25h+Zmx2bet596gvqtA+eQgFJ4rTpmm0SUhNKeKp5HeXB5QqcHhfiemiEVvjoEjj8o5nWn
	idY3vgUNI7MWTfkTEeIi76qmNRXD9l0LpKDlIs74D1gbNeRk+YBdQbIZb3zJu/JfNc+ZAj
	3u6nIKU7i74WLiy/aOCBEkhMkZXfkaSKre5aUxWwcxUZP9L4HhZ0qMnrKGs3HQiEoGXgX1
	yJbOc+qQY4rJEibX9UaCZrX28oLFOSz9Y+Env72tszwSSa2bAIWdXL8b3cL4FOMbPpUb3W
	2V3cs4OQsWXe6uToZUg+V6lJuLOJIyx8XxBmf7vnz6HlBWH7Z5xTdqhQtJFfcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711105094;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njPGq1K1+bmrc0wxTVarMwLPYuhqB6UaiS+5OrpG8tA=;
	b=UqGrHAw/qI1DBbRGYp8BQVlJJDte7zVEtMUdaWjDSLuRhA3wCWFyRE7urcN5ptsNM8pzXx
	8iWn63QncvC9UIDQ==
From: "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] context_tracking: Make context_tracking_key
 __ro_after_init
Cc: Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240313180106.2917308-3-vschneid@redhat.com>
References: <20240313180106.2917308-3-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171110509322.10875.11552915656583883472.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4eab44a8ae98df53e59f6af3c860142177235507
Gitweb:        https://git.kernel.org/tip/4eab44a8ae98df53e59f6af3c860142177235507
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Wed, 13 Mar 2024 19:01:04 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 11:18:18 +01:00

context_tracking: Make context_tracking_key __ro_after_init

context_tracking_key is only ever enabled in __init ct_cpu_tracker_user(),
so mark it as __ro_after_init.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240313180106.2917308-3-vschneid@redhat.com
---
 kernel/context_tracking.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 70ae70d..24b1e11 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -432,7 +432,7 @@ static __always_inline void ct_kernel_enter(bool user, int offset) { }
 #define CREATE_TRACE_POINTS
 #include <trace/events/context_tracking.h>
 
-DEFINE_STATIC_KEY_FALSE(context_tracking_key);
+DEFINE_STATIC_KEY_FALSE_RO(context_tracking_key);
 EXPORT_SYMBOL_GPL(context_tracking_key);
 
 static noinstr bool context_tracking_recursion_enter(void)

