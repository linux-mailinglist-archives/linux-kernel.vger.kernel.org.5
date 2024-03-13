Return-Path: <linux-kernel+bounces-101363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9F387A601
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F10282906
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CA23D544;
	Wed, 13 Mar 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GMUkcPIQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ya0nWvyi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D6225AD;
	Wed, 13 Mar 2024 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326402; cv=none; b=AZtOl/7yvLFMEvxaBv00+rYdTs8SPbITbfiQxtX26rL72oos3PgswZQUtcInpQxLa6CT8kAJmkn0CWvPKSOCMXmwbeAqIXEcRVAgtgXKnHtzt+st7dAirj3YUL63fbq6T/E4Uo2+f6Bl9rQoan/pNHckMENaTzVvHOmrQ5q0Sm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326402; c=relaxed/simple;
	bh=GVy6srAz078qzLw5TMfdLMD6yNhqmz1rV0HYo2eVM2c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wi8OW4GHrkZ6UHJ9x/qVjGAohw+lVkXZm2dEX5PsLAZJkOtBiKPVaR5uMuIPm71Mfcznwd2LV7eycP90wPGiJrgEFpg93Ptt64zo0MvPj73hKdJGw3JxUReFWLKgSPOvg6G2BZsVG7GHJdAvzuQhtnvJa2ARJeH+YtrwiHue53A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GMUkcPIQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ya0nWvyi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Mar 2024 10:39:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710326399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBDsqCIRae9oF8BdiuyyntcNynieeZ8JqhBB5Ca3FqM=;
	b=GMUkcPIQ9uiMybbo6mew8GLuA3zzPorsGSZXElxQgBtkii8ax1VLLSMGeCBzjK0EveWaqv
	NLpQSr8TulnF3xpVmKiBJiMEj+PHSI0NalUKxnk9/ADLmsLxtCwAcj/12ff/vc05qtoSu9
	VeWJbHCnEF8CB42QDkdWudUpdC/qc0esdZxXvIfjCaxsdtN2POeph/ptO0JTILzvAWYSxn
	ZA44xzjx6+soj7fmiqPuXSKXDDQpFzbDJYuNtsCp6CMDgsMvSnWHZVG7MwTMvbzYcu0BFg
	jq2zlYrB9qWFUsr0N5WEKcSEkNPiZJWiJsVaTmR1Hbn2A9+spJ+od1+6rbEvBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710326399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBDsqCIRae9oF8BdiuyyntcNynieeZ8JqhBB5Ca3FqM=;
	b=ya0nWvyi8nG2S5fA5Ytg1dAeDoo3dvNwr3jWvVFHHk+6u64JzExEgn3L/txBpWXNVx1q0b
	xS1LBiOW7CjB+gDQ==
From: "tip-bot2 for Wei Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/vmlinux.lds.S: Take __START_KERNEL out
 conditional definition
Cc: Wei Yang <richard.weiyang@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240313075839.8321-5-richard.weiyang@gmail.com>
References: <20240313075839.8321-5-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171032639798.398.6782499590864932676.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     9b67ce2c121fbf11c0c7b6216c08200fda23c9af
Gitweb:        https://git.kernel.org/tip/9b67ce2c121fbf11c0c7b6216c08200fda23c9af
Author:        Wei Yang <richard.weiyang@gmail.com>
AuthorDate:    Wed, 13 Mar 2024 07:58:39 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Mar 2024 11:29:11 +01:00

x86/vmlinux.lds.S: Take __START_KERNEL out conditional definition

If CONFIG_X86_32=y, the section start address is defined to be
"LOAD_OFFSET + LOAD_PHYSICAL_ADDR", which is the same as
__START_KERNEL_map.

Unify it with the 64-bit definition to simplify the code.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240313075839.8321-5-richard.weiyang@gmail.com
---
 arch/x86/kernel/vmlinux.lds.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 88dcf93..a20409b 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -110,11 +110,10 @@ PHDRS {
 
 SECTIONS
 {
+	. = __START_KERNEL;
 #ifdef CONFIG_X86_32
-	. = LOAD_OFFSET + LOAD_PHYSICAL_ADDR;
 	phys_startup_32 = ABSOLUTE(startup_32 - LOAD_OFFSET);
 #else
-	. = __START_KERNEL;
 	phys_startup_64 = ABSOLUTE(startup_64 - LOAD_OFFSET);
 #endif
 

