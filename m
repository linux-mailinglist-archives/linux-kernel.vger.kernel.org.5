Return-Path: <linux-kernel+bounces-136533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A730F89D541
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06C89B22B18
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6DB7FBBC;
	Tue,  9 Apr 2024 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJ/2kmNv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DXJd+R0C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E357F476;
	Tue,  9 Apr 2024 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654198; cv=none; b=lVzwFxHSd8WYEGolX6/VCtocVT4j6JbtqB71D70QbngmMnj2YLC4h1m/F+JlsGtp/khOkehulUR+jYQ/2m9CLkMcqonJy2PNNFZnpHFllQ7ix70dLLS8BV+NVSZLWSEO0Dc6xe6Z0jDH+ZlSBZRBtD3fwSApXq27ZY7VLRK3y+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654198; c=relaxed/simple;
	bh=PV3ABrpUzz7O86C+PI0/38DFjZ+AQp1PQ2wjp8NXC20=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oZpoh6IskIaDlcsLaYLWLohJDrnn9qEKdGo73oHWOUk5AQitD+enkkHIDmVvGfDU9GRa53xljwwnhzFwmU6hDzDDLBhMBmOkN1L7hXcixHFv7wmDjkTY1CV1b8dxhhAIJ4A6/92LH4QkCjEbW6j7M6jaiPlC9x5h05+5joyg+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJ/2kmNv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DXJd+R0C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 09:16:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712654195;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iZNDVqbvbJbOp01LGO6Qp01I5l3QKdSxp5TQHKwyyzE=;
	b=WJ/2kmNvdech/bTo5JwaomhvDsA9XcphgzOUW5vteN6bgAELkmHdldFOStnEGm0zGbkGO2
	5N0LncVx59GJV9oeM4a4pbc/W787oqPDZ88xVHPIrkJoPUC+KDCG/9rB3qXAyVyXzuLK7s
	ZQi/mUWpAcRQCtqmweHl5ZJoOOlzbR+oZXsYwtAEJtA2fTjNs6feXE235vUq/Uy6fAKgGn
	/7DiMEdyEBfLU2qpov1N8pk00CMsF1kjaq2f4CE9Siuvrb2u8aGBEtG85pjN4Y0x4ftfRe
	vk7v80bYJcPkzgEBFRtcvbrzDlnnQnSA1QADKyjRzoHCDoJx+2WbBlUES0PAYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712654195;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iZNDVqbvbJbOp01LGO6Qp01I5l3QKdSxp5TQHKwyyzE=;
	b=DXJd+R0CVeZp0YuS4yVm3Qo4pNS00MeD+sNB581mUnBFF55wnfVPl0uuamwlxAiKpxBWfi
	Y9kLH2NHfsse7xCw==
From: "tip-bot2 for Nianyao Tang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3-its: Fix VSYNC referencing an
 unmapped VPE on GIC v4.1
Cc: Nianyao Tang <tangnianyao@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240406022737.3898763-1-tangnianyao@huawei.com>
References: <20240406022737.3898763-1-tangnianyao@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171265419457.10875.5533397957548411107.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     80e9963fb3b5509dfcabe9652d56bf4b35542055
Gitweb:        https://git.kernel.org/tip/80e9963fb3b5509dfcabe9652d56bf4b35542055
Author:        Nianyao Tang <tangnianyao@huawei.com>
AuthorDate:    Sat, 06 Apr 2024 02:27:37 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Apr 2024 11:11:18 +02:00

irqchip/gic-v3-its: Fix VSYNC referencing an unmapped VPE on GIC v4.1

As per the GICv4.1 spec (Arm IHI 0069H, 5.3.19):

 "A VMAPP with {V, Alloc}=={0, x} is self-synchronizing, This means the ITS
  command queue does not show the command as consumed until all of its
  effects are completed."

Furthermore, VSYNC is allowed to deliver an SError when referencing a
non existent VPE.

By these definitions, a VMAPP followed by a VSYNC is a bug, as the
later references a VPE that has been unmapped by the former.

Fix it by eliding the VSYNC in this scenario.

Fixes: 64edfaa9a234 ("irqchip/gic-v4.1: Implement the v4.1 flavour of VMAPP")
Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20240406022737.3898763-1-tangnianyao@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fca888b..2a537cb 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -786,6 +786,7 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 					   struct its_cmd_block *cmd,
 					   struct its_cmd_desc *desc)
 {
+	struct its_vpe *vpe = valid_vpe(its, desc->its_vmapp_cmd.vpe);
 	unsigned long vpt_addr, vconf_addr;
 	u64 target;
 	bool alloc;
@@ -798,6 +799,11 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 		if (is_v4_1(its)) {
 			alloc = !atomic_dec_return(&desc->its_vmapp_cmd.vpe->vmapp_count);
 			its_encode_alloc(cmd, alloc);
+			/*
+			 * Unmapping a VPE is self-synchronizing on GICv4.1,
+			 * no need to issue a VSYNC.
+			 */
+			vpe = NULL;
 		}
 
 		goto out;
@@ -832,7 +838,7 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 out:
 	its_fixup_cmd(cmd);
 
-	return valid_vpe(its, desc->its_vmapp_cmd.vpe);
+	return vpe;
 }
 
 static struct its_vpe *its_build_vmapti_cmd(struct its_node *its,

