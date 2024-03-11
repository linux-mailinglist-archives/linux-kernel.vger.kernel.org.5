Return-Path: <linux-kernel+bounces-98720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90AB877E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340C1B216E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B1936B01;
	Mon, 11 Mar 2024 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="wa8p3djt"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B60199AD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154105; cv=none; b=P6YnkX/+6dw9KpH72kRzToEKlYBENrqWpZCUWgXS5DR5ZLj12GBB9mGYl6jCMt7VBJ5Oc9SJzJg86vhZ38Gjsd9eXjODO+7hnf1yVk/wgMVsL3pcO5NR/zuFWKjyfqslY/HuYPIXl2h+E+OJSioe2tv+3m1XKAndtPh9F3rcqZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154105; c=relaxed/simple;
	bh=u7lJIQiGFJaiLYFrbNMt/+qQVYShImyArwbHI/t7fRw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ryN7MqQceUnlpKgL3EORMaVrqrusL0mSP5hNF1n7/PTvVrwMd3lOJyxE+0ZsPPSkvXPHSr304YRgTKm98FCAFkhBRg6XZgpkQx1WAorpk3UkEPkkGZWyDb8pcIrNzXVaPwEPNqqP/O5rU5UhrHXg1Rx0MR85I68KwNvipG31DnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=wa8p3djt; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1710154093;
	bh=ERBSc0Wgyuw8/bY8P/pT1Iga4mFQ1r/VjlA6SHnWbMc=;
	h=From:To:Cc:Subject:Date;
	b=wa8p3djtCl2NC95sj1m/7HcUiV5MwEkk9KWQXIa4abVtju6apyk14dqV45uvFXj/8
	 oHHcGQ9ACHfYWfuDU43ddqi+ep5iLFR/K9Ez6HKopgC5Ncbx/zy6Qcthbmcq6oS4Op
	 CIf0Vv9310Kl5MO9jE+TGWH5v+xWjd0Iyqx3vMbs=
Received: from localhost.localdomain ([58.208.182.212])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id BF783C2D; Mon, 11 Mar 2024 18:47:55 +0800
X-QQ-mid: xmsmtpt1710154075t9nxfgrpw
Message-ID: <tencent_4B50D08D2E6211E4F9B867F0531F2C05BA0A@qq.com>
X-QQ-XMAILINFO: NPS3ZrBWpSdgwmZoGF8L3qHSPnepBxH/g50XR6uvTWEemFW4HPGPTU7ONGN+L5
	 h62JwZaaypXsJLW0XnqgDflVczBy0BHBQ4CaMFH09mWsdaxyiNheN8rD78Xdm3FSjyG3r9N3+Npo
	 clWfwJSkDSnd1vytEAYqC4iyOWvmPLhM3lL9CdMeVjbMEYERTLBDf5nA1a5XMiv0cf3H7k9zUf6v
	 WG5Cs8MRIOQK+gkvVpq9iKjrsaOGtYoJX+n6yqHpTd90qZSyUOdGfjodOiXblphbOHjiXOl9u9I0
	 myVtF8NNgExxZdxXYJ9i6ovCJA98bGT7797Auw6F6RW47MVsMVOYN002VFOWo+RjuT9oXQ+phCxS
	 R1MfGrOPjPiPvFlw8vFHTQu1kfQVhNX9mSweaFICPxONj3SmOiljtuX1pQQPd8c5ZJvhOHz7RuA3
	 5jAIjPc5hHCGb+bXc+qwhwHRzOiQKlnX8bxz1A6/obbP296SnEjAsO5h4ufdHJBh7WAom6l8ZExL
	 oB+iVGNB2TKg9ieVU0A5cUfJL6lSYwxCX3OzIATOr+BbUJP8+ZmBBCDmfTtaoZ+CM+GkPnzerMw6
	 mn7FA1MB7m96/8KvAEx7SwDDJ3kEpxXcQCXVCGrH6aDIgXTpZXcn0PeEK1wof0YPup24Ic8608K6
	 QO7jz5qgsibJ+7oITizyWjGdI99vkNntf8rYBsrzE1ZHgyWnuOIPxhp14eH+QAkeHavpKbRXap2y
	 cH76lBWZ+LAy5boTSbqaWHT6naILEhY+b/+lKe2m0s/Pl9WypQnWTaYz8/7AgKQG/i0iA9jAEC3U
	 igLm9jln6mbU5Xo8hRTIHm4W7f0zxr10HjfQa6MoRj2c1cwatvm3TEqOUy24471Xn4dpYeWcnXxv
	 6S3LM6L6PPrGWE9xOZ/3JVnwvDzK0R9GiXI7mhUcN9/q0rOKQHG03xQZ8EhY0UxTXLxAkMJPybcf
	 pSN0LHlKpg1nr2wYtb8G2/6Vc9FftGspK7ujuDIEVeDg1Y9Uz6CfnVgRnJ/KnQlEhgWX80l8D5jW
	 qZ84c3MpYfQewIcjFvTlSdWgmW6IBuhlfoABk7PaW17BCyjCkyCDiYmt6di8esXqEVYcxUWA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: francisco_flynn <francisco_flynn@foxmail.com>
To: dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org
Cc: hpa@zytor.com,
	rdunlap@infradead.org,
	francisco_flynn@foxmail.com,
	akpm@linux-foundation.org,
	bhelgaas@google.com,
	mawupeng1@huawei.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86/mmu: treat WC memory as MMIO
Date: Mon, 11 Mar 2024 18:47:49 +0800
X-OQ-MSGID: <20240311104750.2149241-1-francisco_flynn@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when doing kvm_tdp_mmu_map for WC memory, such as pages
allocated by amdgpu ttm driver for ttm_write_combined
caching mode(e.g. host coherent in vulkan),
the spte would be set to WB, in this case, vcpu write
to these pages would goes to cache first, and never
be write-combined and host-coherent anymore. so
WC memory should be treated as MMIO, and the effective
memory type is depending on guest PAT.

Signed-off-by: francisco_flynn <francisco_flynn@foxmail.com>
---
 arch/x86/include/asm/memtype.h | 2 ++
 arch/x86/kvm/mmu/spte.c        | 5 +++--
 arch/x86/mm/pat/memtype.c      | 8 ++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/memtype.h b/arch/x86/include/asm/memtype.h
index 113b2fa51849..b49887d8580e 100644
--- a/arch/x86/include/asm/memtype.h
+++ b/arch/x86/include/asm/memtype.h
@@ -23,6 +23,8 @@ extern void memtype_free_io(resource_size_t start, resource_size_t end);
 
 extern bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn);
 
+extern bool pat_pfn_is_wc(unsigned long pfn);
+
 bool x86_has_pat_wp(void);
 enum page_cache_mode pgprot2cachemode(pgprot_t pgprot);
 
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 4a599130e9c9..7842458dafa8 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -88,9 +88,10 @@ u64 make_mmio_spte(struct kvm_vcpu *vcpu, u64 gfn, unsigned int access)
 static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
 {
 	if (pfn_valid(pfn))
-		return !is_zero_pfn(pfn) && PageReserved(pfn_to_page(pfn)) &&
+		return !is_zero_pfn(pfn) &&
+			(PageReserved(pfn_to_page(pfn)) || pat_pfn_is_wc(pfn)) &&
 			/*
-			 * Some reserved pages, such as those from NVDIMM
+			 * Some reserved or WC pages, such as those from NVDIMM
 			 * DAX devices, are not for MMIO, and can be mapped
 			 * with cached memory type for better performance.
 			 * However, the above check misconceives those pages
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 0904d7e8e126..a5dd906cd987 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -716,6 +716,14 @@ bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn)
 }
 EXPORT_SYMBOL_GPL(pat_pfn_immune_to_uc_mtrr);
 
+bool pat_pfn_is_wc(unsigned long pfn)
+{
+	enum page_cache_mode cm = lookup_memtype(PFN_PHYS(pfn));
+
+	return cm == _PAGE_CACHE_MODE_WC;
+}
+EXPORT_SYMBOL_GPL(pat_pfn_is_wc);
+
 /**
  * memtype_reserve_io - Request a memory type mapping for a region of memory
  * @start: start (physical address) of the region
-- 
2.25.1


