Return-Path: <linux-kernel+bounces-68833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36AA8580CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F271C22322
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB69912FB3F;
	Fri, 16 Feb 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4bwb4LRM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zAisVLXa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFFB1487E9;
	Fri, 16 Feb 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096643; cv=none; b=Nht2yxmiEZeeABdwChUvEWqlNZVuEZMI8T7Jjq8ggA7SK3GU6mwKecJ7UDPQDx/GVeZ2JFunRj5KYBon1OXXOX+Ica71l2j1XNmqwE0N1jwdJASb5CVE5bCsVT+Pwdwk+3wx93RTbSqZKRUAqANvnZusq59Vhf7jFcrQMjx42gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096643; c=relaxed/simple;
	bh=Ka7l+9b/kcJ8yeluk86OI7o6/TI3/gV9KGz2qXFF7Ks=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zl7O7XdYlhC3vWTUF4mY7nG0FzVdlEpHpOxPu105493rgnFNb+fzLMuxAHDSMg/AulY3M2zs8kXGnHDEgVHP6Dx/CaJfnVV1wDp6GvfS1HYctrzMJXWdOc1GQN9FdgNgkT8jjGetfPiEP2ZdZSEZCTawoUa5VKBMIo7uTcDRqsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4bwb4LRM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zAisVLXa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFDZOk3CF+plwPGV6FSuesG0u9SxV0ui7OgL/FdRHIE=;
	b=4bwb4LRMdAZm18DRa5SZCPKW1pCuvsmXW5j6CX8Tza1GDQIKCM3ikEceYlqRWx3fbUj1Vq
	rz7WxnJqpwRigaMjAK82XGr19S5GN1z+e2K5LVIyTTcRG9EP0JW147Lzli54sOAAmKu1QX
	scgMbU23ax9gd2HEWqGiPcrwXQ9VRFaeEwWOW6arqPlBmtKCzGniy3SSvpujq3trPQ1Vux
	1HOi3fCCLPrEwc+ohdeJ0nGefZUl8OgkEw6TsBsHx/BBmMjJPFDHjbYRDoDUSfFUQ6m3pX
	IO8MoD4pcAzK0QzMtys6YC/5RITA4OPPIGSKXEEL5m+axeefCXEYkrPlaT0n/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFDZOk3CF+plwPGV6FSuesG0u9SxV0ui7OgL/FdRHIE=;
	b=zAisVLXa+8ujMTnDqzU2Yh0ZK0NxBPULGbaIIv5aub/RJHS6uEXVGFMNCgF/DUIB3R4HO0
	Ly4wQBhtK1tQyqDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/mpparse: Provide separate early/late callbacks
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154639.370491894@linutronix.de>
References: <20240212154639.370491894@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809663903.398.7540995320450780112.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     fc60fd009c830a21c7699c6e36ab9ec51b9dd939
Gitweb:        https://git.kernel.org/tip/fc60fd009c830a21c7699c6e36ab9ec51b9dd939
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:40 +01:00

x86/mpparse: Provide separate early/late callbacks

The early argument of x86_init::mpparse::get_smp_config() is more than
confusing. Provide two callbacks, one for each purpose.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154639.370491894@linutronix.de



---
 arch/x86/include/asm/x86_init.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 4ae7764..375825f 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -17,11 +17,15 @@ struct irq_domain;
  * @setup_ioapic_ids:		platform specific ioapic id override
  * @find_mptable:		Find MPTABLE early to reserve the memory region
  * @get_smp_config:		get the smp configuration
+ * @early_parse_smp_cfg:	Parse the SMP configuration data early before initmem_init()
+ * @parse_smp_cfg:		Parse the SMP configuration data
  */
 struct x86_init_mpparse {
 	void (*setup_ioapic_ids)(void);
 	void (*find_mptable)(void);
 	void (*get_smp_config)(unsigned int early);
+	void (*early_parse_smp_cfg)(void);
+	void (*parse_smp_cfg)(void);
 };
 
 /**

