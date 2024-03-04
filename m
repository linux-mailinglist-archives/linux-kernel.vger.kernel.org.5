Return-Path: <linux-kernel+bounces-90549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC88870104
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BF81C21759
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C043BB4C;
	Mon,  4 Mar 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qgfrCD1/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L3atGOpt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83568224DF;
	Mon,  4 Mar 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554507; cv=none; b=Qm6OTQ2uEJNc/0lYfAh22zBfLk4FawZBfPOhO644yoBgdGSWd6hQ4LgDXpe0vYjp7VyzqvM5pITn9JKVVQI6w0ZGQ1GpSbbq5sAYXL2VeyGJHvW/AsUU6taSFkvowVC/hZnxiTGrPGq4lXRATh0YvDi8PKIvz8SzZOHIt8LgVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554507; c=relaxed/simple;
	bh=xna8Tq+68YK+QFRtmzdEQOSfL64Ez/yudXFqikgl5QM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aBwwOpWzsPcCL55XfyNeOYLDwzHEPDcdZ/kg+duv3dezpHqb77u+ZNDoa2QEksCXzByosXmBL4SFr0DF/peB81H0CeN7yuvFHxwPEmysjGstKJqDy0X02JckRFXSvg22nE2a6Td7x92K60nS1n+crTTBinSn5X33JwvaBjyG6T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qgfrCD1/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L3atGOpt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 12:15:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709554503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYle3p+VrER+wxqmhUkcQ5fFt+9wZ6/WSZK+biz4LJI=;
	b=qgfrCD1/KZQhytnuDTAxJ5DJf0FIJXjCkWCabAEcKkFvZL+1jYUgpf3AReWhyY/be6gGdh
	Vhu4qqsYAikCLDTFX5Ro3uW9plHay/Pi+FXq1cuSWq1yp1Qxh6IxIBgKJhKV4BksBYnDxU
	zSvv1ol42AEU2XyFhe5ZpJe5iTSw5JS3ZkPEVwhpnNbeNPLie0+bbV5fS7ikLeUKAsVfu5
	t9XQ68ZR3I98ctK8GkG+B1VLx1s5jABi80vA43xvEyGklzMk9aCrhE4vGDU5ocMkqPsasx
	43AvlF9MCsuIFqyz/WcrpuZ275o2/aIyMwJZpF7qkpFKOTFNNSCjJ7Tx5yWGAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709554503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYle3p+VrER+wxqmhUkcQ5fFt+9wZ6/WSZK+biz4LJI=;
	b=L3atGOptto3b41WxCQDzHuWYJNJHMvisO+dYhIhksg5FxfePT0AnaVwZumccgyBScHUERA
	BQc4J2VkuzE3jFBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/callthunks: Use EXPORT_PER_CPU_SYMBOL_GPL()
 for per CPU variables
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240304005104.841915535@linutronix.de>
References: <20240304005104.841915535@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170955450241.398.13909761798230298332.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     cad860b59531ba4d456b3921d5ced621620d76fc
Gitweb:        https://git.kernel.org/tip/cad860b59531ba4d456b3921d5ced621620d76fc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 04 Mar 2024 11:12:29 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 04 Mar 2024 12:09:13 +01:00

x86/callthunks: Use EXPORT_PER_CPU_SYMBOL_GPL() for per CPU variables

Sparse complains rightfully about the usage of EXPORT_SYMBOL_GPL() for per
CPU variables:

  callthunks.c:346:20: sparse: warning: incorrect type in initializer (different address spaces)
  callthunks.c:346:20: sparse:    expected void const [noderef] __percpu *__vpp_verify
  callthunks.c:346:20: sparse:    got unsigned long long *

Use EXPORT_PER_CPU_SYMBOL_GPL() instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240304005104.841915535@linutronix.de
---
 arch/x86/kernel/callthunks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 64ad2dd..aeccea2 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -42,8 +42,8 @@ DEFINE_PER_CPU(u64, __x86_call_count);
 DEFINE_PER_CPU(u64, __x86_ret_count);
 DEFINE_PER_CPU(u64, __x86_stuffs_count);
 DEFINE_PER_CPU(u64, __x86_ctxsw_count);
-EXPORT_SYMBOL_GPL(__x86_ctxsw_count);
-EXPORT_SYMBOL_GPL(__x86_call_count);
+EXPORT_PER_CPU_SYMBOL_GPL(__x86_ctxsw_count);
+EXPORT_PER_CPU_SYMBOL_GPL(__x86_call_count);
 #endif
 
 extern s32 __call_sites[], __call_sites_end[];

