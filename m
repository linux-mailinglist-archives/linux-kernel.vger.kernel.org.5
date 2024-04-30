Return-Path: <linux-kernel+bounces-164009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 694858B7713
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7A81C22198
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1467176FCF;
	Tue, 30 Apr 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fQ7RFjMG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HTxoox62"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B4B172795;
	Tue, 30 Apr 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483729; cv=none; b=q9v3obrmlai84AJBQUqkGbKtRFgEngAGi5II2bpUWdhTkOMVieN8kqIHqBYHWYdZrdaSXYfyagpeRjXSBFraFV/N3PFZOX4nHjvoBocvblCEeZC+ydUvOJ8H/C8OVVY15+O5X2Fv+4lSbM9HOJUNAN5Y1s2yYxmx0yd+ykahMTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483729; c=relaxed/simple;
	bh=gvi0unxcUxzyyNfvv7dDkZ4sv2qB/pjm9h8Rdr9zBdI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tz6XfqLh/MnlcspODXjr87Ps05s2lCStt/Poz6t5cLqXekh8UsU9eRmp96M/zcYAS58Yj7C2uz6zz5RyBX29qqP7U97nk0tn9MM/hIVvJvTF35GNXB465HRokOyWK0ZJVfzEcmuH7FGu7+9MD5ArxF/cSjPqGJt4AVA3FvZHNTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fQ7RFjMG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HTxoox62; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Apr 2024 13:28:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714483722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3my01OLyRquY/EnxEaTm9O9NtTmb/Af+BiVmn/8C+uE=;
	b=fQ7RFjMGnx95J9wNYoLAQB+eaZ75hCAdWFKv3AQWzMfcnQL8nNl0voYEpTMLfLPLbMDG/z
	EszOOEkKX9+sZHQZG08hEMBzQ77OCE8ikJqNl6DsAZCW7qBtwsWWrWxBP0eEozB7ZZGjub
	VzB1czBK/B2z6TRiNXn+HBpN9JEDSHiOkk/s5hlhCEDgbntk/NBjvkSZ1v991NyqBQNHjv
	34e8LA8sMpgON1qey0495RegmrMt3xpxrtRsO4CkAfVpzUq5mL4wSCBJrS7WpfTgN5hkaY
	IBg0on/VmOvKcF3lwmwUg3F4G2x6vrG3lxhr+bR/KWl5oJ77BU0/O+Cu4V6Xgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714483722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3my01OLyRquY/EnxEaTm9O9NtTmb/Af+BiVmn/8C+uE=;
	b=HTxoox621zsZMvQ49QIxcf5Ne3b2rAQKoKCfVzUzyCOs/Vm5UOncdz7bqc1j3FIsE2QGKI
	vmOdKSpgxY6GoZBw==
From: "tip-bot2 for Jacob Pan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/irq] x86/irq: Remove bitfields in posted interrupt descriptor
Cc: Sean Christopherson <seanjc@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240423174114.526704-4-jacob.jun.pan@linux.intel.com>
References: <20240423174114.526704-4-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171448372251.10875.230386187944725418.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     2254808b53d92c9fe7b645b2f43acc55f22cdce6
Gitweb:        https://git.kernel.org/tip/2254808b53d92c9fe7b645b2f43acc55f22cdce6
Author:        Jacob Pan <jacob.jun.pan@linux.intel.com>
AuthorDate:    Tue, 23 Apr 2024 10:41:05 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Apr 2024 00:54:42 +02:00

x86/irq: Remove bitfields in posted interrupt descriptor

Mixture of bitfields and types is weird and really not intuitive, remove
bitfields and use typed data exclusively. Bitfields often result in
inferior machine code.

Suggested-by: Sean Christopherson <seanjc@google.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240423174114.526704-4-jacob.jun.pan@linux.intel.com
Link: https://lore.kernel.org/all/20240404101735.402feec8@jacob-builder/T/#mf66e34a82a48f4d8e2926b5581eff59a122de53a
---
 arch/x86/include/asm/posted_intr.h | 21 ++++++++++++---------
 arch/x86/kvm/vmx/posted_intr.c     |  4 ++--
 arch/x86/kvm/vmx/vmx.c             |  2 +-
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/posted_intr.h b/arch/x86/include/asm/posted_intr.h
index acf237b..20e3189 100644
--- a/arch/x86/include/asm/posted_intr.h
+++ b/arch/x86/include/asm/posted_intr.h
@@ -15,17 +15,9 @@ struct pi_desc {
 	};
 	union {
 		struct {
-				/* bit 256 - Outstanding Notification */
-			u16	on	: 1,
-				/* bit 257 - Suppress Notification */
-				sn	: 1,
-				/* bit 271:258 - Reserved */
-				rsvd_1	: 14;
-				/* bit 279:272 - Notification Vector */
+			u16	notifications; /* Suppress and outstanding bits */
 			u8	nv;
-				/* bit 287:280 - Reserved */
 			u8	rsvd_2;
-				/* bit 319:288 - Notification Destination */
 			u32	ndst;
 		};
 		u64 control;
@@ -88,4 +80,15 @@ static inline bool pi_test_sn(struct pi_desc *pi_desc)
 	return test_bit(POSTED_INTR_SN, (unsigned long *)&pi_desc->control);
 }
 
+/* Non-atomic helpers */
+static inline void __pi_set_sn(struct pi_desc *pi_desc)
+{
+	pi_desc->notifications |= BIT(POSTED_INTR_SN);
+}
+
+static inline void __pi_clear_sn(struct pi_desc *pi_desc)
+{
+	pi_desc->notifications &= ~BIT(POSTED_INTR_SN);
+}
+
 #endif /* _X86_POSTED_INTR_H */
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index af66231..ec08fa3 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -107,7 +107,7 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		 * handle task migration (@cpu != vcpu->cpu).
 		 */
 		new.ndst = dest;
-		new.sn = 0;
+		__pi_clear_sn(&new);
 
 		/*
 		 * Restore the notification vector; in the blocking case, the
@@ -157,7 +157,7 @@ static void pi_enable_wakeup_handler(struct kvm_vcpu *vcpu)
 		      &per_cpu(wakeup_vcpus_on_cpu, vcpu->cpu));
 	raw_spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
 
-	WARN(pi_desc->sn, "PI descriptor SN field set before blocking");
+	WARN(pi_test_sn(pi_desc), "PI descriptor SN field set before blocking");
 
 	old.control = READ_ONCE(pi_desc->control);
 	do {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 273d264..becefaf 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4845,7 +4845,7 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
 	 * or POSTED_INTR_WAKEUP_VECTOR.
 	 */
 	vmx->pi_desc.nv = POSTED_INTR_VECTOR;
-	vmx->pi_desc.sn = 1;
+	__pi_set_sn(&vmx->pi_desc);
 }
 
 static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)

