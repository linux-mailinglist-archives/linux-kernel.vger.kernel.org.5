Return-Path: <linux-kernel+bounces-90551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32698870108
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4192282A55
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098143C497;
	Mon,  4 Mar 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0v/CEmQX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F6IWcZnD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85873B299;
	Mon,  4 Mar 2024 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554508; cv=none; b=L9xJFm/2HK7wHp7tjUIjsVq+TdZAnkaJsqKv7ER4xWsLUVuYiG22IyqcCt2AkWifBjyTDMnap2WDSo3CIEfu1Iv9jM9wCYQ9D13T8ZswkX4MFU0u6ZjXB1jlRYT/tb16NRQkUaRPQj4R88TeIGwCZH0TiNO81z3THw567tqkYAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554508; c=relaxed/simple;
	bh=Cht3KwzEy01gpPcomWQCxxHp1q5bdvzLjZL+3MLEnWg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VuisPGtFrgllZGpBwT6ueaS78GlJuq9lpYX60zJcm/USkyDC97O/9SxBH47V029Xg1clUd8fs+E52eXPwISaMd/HRLINQh+gfIDMAiGc0kZ04lPUp5bVFm8OI3YHv6tKOZkGG9v7hZPnNt7u/YE50SQzyEFoCxiaCClbUsAjFrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0v/CEmQX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F6IWcZnD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 12:15:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709554505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sIhrgrHBnHrRIKUrM/taT00TdU9ovrNieXezNI1Kd+M=;
	b=0v/CEmQX0JSuw1+YPB7clJ9PLkqR4eZ4BtUGa4Tou1wZDhIj5nxbawp1iH5Ka4zAYAfp+I
	hv+BM2WD2ltIBep5XSli0PDVGAd7jdxSnj2NqGvR1ORLas2k1CYhXNTUmiCKCOVnIpPipr
	Q03gCR6v5YBH+DuZzWAcyLSlcki01winu2sY+IO9qpHAfbVYBZFs3gIBJ5GD5B/Ph7sjhz
	xtyg85qmlDJWNxLr4nVnwoGZ9hBRjYSmWSNkroXNWaGQ+fsc+DK18adW1jndtb/tMtMYBc
	IA+jQpw+Z8nVIhsKxERG9j4uE+1WwdfdAviapCd+BNvZpjDLNml3itLIIRUbNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709554505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sIhrgrHBnHrRIKUrM/taT00TdU9ovrNieXezNI1Kd+M=;
	b=F6IWcZnDTSRE/LjScbEsV+4sIK0gyTuV7Zru0YjajvdfKMtK4H5KxPXfUzsy3ejMEmBSV/
	joLFdV2bsM/HVoAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/cpu: Use EXPORT_PER_CPU_SYMBOL_GPL() for
 x86_spec_ctrl_current
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240304005104.732288812@linutronix.de>
References: <20240304005104.732288812@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170955450435.398.16469805838479350464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     ca3ec9e5540428afa3d372fb39f0d88c4f44af8b
Gitweb:        https://git.kernel.org/tip/ca3ec9e5540428afa3d372fb39f0d88c4f44af8b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 04 Mar 2024 11:12:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 04 Mar 2024 12:09:13 +01:00

x86/cpu: Use EXPORT_PER_CPU_SYMBOL_GPL() for x86_spec_ctrl_current

Sparse rightfully complains:

  bugs.c:71:9: sparse: warning: incorrect type in initializer (different address spaces)
  bugs.c:71:9: sparse:    expected void const [noderef] __percpu *__vpp_verify
  bugs.c:71:9: sparse:    got unsigned long long *

The reason is that x86_spec_ctrl_current which is a per CPU variable is
exported with EXPORT_SYMBOL_GPL().

Use EXPORT_PER_CPU_SYMBOL_GPL() instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240304005104.732288812@linutronix.de
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 48d049c..0767ab6 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -56,7 +56,7 @@ EXPORT_SYMBOL_GPL(x86_spec_ctrl_base);
 
 /* The current value of the SPEC_CTRL MSR with task-specific bits set */
 DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_current);
+EXPORT_PER_CPU_SYMBOL_GPL(x86_spec_ctrl_current);
 
 u64 x86_pred_cmd __ro_after_init = PRED_CMD_IBPB;
 EXPORT_SYMBOL_GPL(x86_pred_cmd);

