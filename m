Return-Path: <linux-kernel+bounces-83213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B636869056
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311831F2A043
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BEB13B797;
	Tue, 27 Feb 2024 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="HZPan/Vw"
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB0C1386A0;
	Tue, 27 Feb 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036503; cv=none; b=d9bYnVGom2xdF2bC3IGNJHZcTBf3/jvJFG8eBtyHZ7tMD2WhIBKJYJIwhUJRk/h0T+gD2nJMvLYYuJZqwD0mWjhJBj7PzfJ75KOxP4OXfn/MyMMhpBrSb3NcMSB2ly0Eajtcskox9lTcUKo+BLWQJBSpthenoklNrnK3x53v3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036503; c=relaxed/simple;
	bh=ik+Z/voXstuOO72kbjvQlbbmHlI6qZ1wkXyfgafSHfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0Y+9dJGkGFJi2UEAJFIeHTe2IpIY2Zk8CcSa0PO90Lm2Coic/jzi+iTX/lN2GYjrm3JBgQfTfsOu0ivOUtN/1ZBTJsiT3YNN47Lv4uWxm1MRJLHUfaoDO53qIpHyIbW4lUmMToZbgqUuRYO4y1ilmIOa2e2u928SYLcBe0jfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=HZPan/Vw; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06291DB0B5;
	Tue, 27 Feb 2024 13:12:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1709035934; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=HlqPVVDAgE1kBRHpHlFn58H7IQi71P0Ptm3D/QaiOsQ=;
	b=HZPan/VwL2tZs2N/8SB+oIggl4sL6ZaRbGhk7GHj3TWCmqjfVGHpb9ARqpcQ6Er8Wi3/Gl
	f0gZUwEs+0koPFJ9/4EKUsMeDUPTnR6taKQXl3MMhQTCOo1qNI75j0s23ESbVTkD/2tXIk
	3VbgnCPl89687wpDw8H/5sdztSgqavqCPYXg/2pU/Ce3lVLabk9hHuHwVVxjPnXhSv9kQ8
	hfDMi6NmDxsb0yfwMybD6OzvZ6FFB4ZnzUoFeTyfXkfpmMKF1Keg5B59snaERy/5bZRQ6C
	0x/dRmpFLLHN/OpbngNHic8AEHCJANlOLv/MNnq1War3iBxDiGDg8lQ5hQUJDA==
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>,
	 <linux-rt-users@vger.kernel.org>,
	 <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 1/1] Linux 4.19.307-rt133
Date: Tue, 27 Feb 2024 13:12:04 +0100
Message-ID: <20240227121204.30720-2-wagi@monom.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227121204.30720-1-wagi@monom.org>
References: <20240227121204.30720-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

v4.19.307-rt133-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index ecff281e807f..c2c7e0fb6685 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt132
+-rt133
-- 
2.43.2


