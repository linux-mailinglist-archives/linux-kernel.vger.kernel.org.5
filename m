Return-Path: <linux-kernel+bounces-50731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE98847D64
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01B51C225E6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51ED12D745;
	Fri,  2 Feb 2024 23:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Clu3thbS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B8585946;
	Fri,  2 Feb 2024 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918018; cv=none; b=YuTnGWmMw0Gq9xIs5SKjLO0zmYYeVH0SvGEfZc6QHSVOkJxx+29uABEwdEjmk5T8wx9JC+m3alA/JRpvzjTYjuLTI9eb3q7X2W1k5hP/EGyO7bWnx/h5Hr2+Uu2PfunixFAWa5rdAByswXoOf8mFVGAZq0qZnyaO2bglv8aJ63o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918018; c=relaxed/simple;
	bh=ToVjAvQmv/dtNRn5p4/8OjGcotgzRI0qmd7n0/i3AJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sVfPvS2/xStBFpUsWuVpkNqyUerEyg1KmvIzEhI7WfghfXqrGAX6LnpMsfQXCL9iOJd1g+FsaQ3mhwonkzEzpwxPNT2//2jfj4bd4V4rO2GQXdhsmhI+K3ntWhNgvKFndPRB7T+BBDdTTQhWXigpDHNqPy7v9MNpl9AmNCONHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Clu3thbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC73C433C7;
	Fri,  2 Feb 2024 23:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706918017;
	bh=ToVjAvQmv/dtNRn5p4/8OjGcotgzRI0qmd7n0/i3AJA=;
	h=From:Date:Subject:To:Cc:From;
	b=Clu3thbSoR8/bxiVDj/+7YLjpR9VmIrYwYhNJwQlNPbwg7l83CnutrlFfMFD907Sg
	 B447oCeU97r/zGad3HHVC0pzuDGf5Qb6KXpsqcWkoRaPcpNXkSZ2a2sxQf8THivYaN
	 +WpZkHcoOVWHSBjpzhgy7jCgdKXp0WE8U88W30qe9Ho2IZrii68KRQTMeqkaQXrpdl
	 JUM6kM26LOqoclr7wmUwZpL/0q1imPWBbCs+1jySwU+iEXFhYG6aYwF7vFlF/J6ts+
	 KJaoT/rNZqL6+RpLibWGxsAWP7qPYv5bER7dGSqWoGPatiyJeYmtcJXdddSWGiuDbG
	 HyuW/Czm23xRg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 02 Feb 2024 16:53:21 -0700
Subject: [PATCH] x86/coco: Define cc_vendor without
 CONFIG_ARCH_HAS_CC_PLATFORM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-provide-cc_vendor-without-arch_has_cc_platform-v1-1-09ad5f2a3099@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHCAvWUC/x2N0QoCIRBFf2XxuQFzE6JfiZBBxxwoldG1YNl/T
 3o5cDhw764aCVNTt2VXQoMblzzlfFqUT5ifBBymK6PNRU9AlTI4EHjvBuVQBD7cU9k6oPjkEjY
 3U31hj0XesBqLa0S6WqvVHK1Ckb//w/vjOH7efz0/gAAAAA==
To: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: kirill.shutemov@linux.intel.com, ndesaulniers@google.com, 
 morbo@google.com, justinstitt@google.com, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2621; i=nathan@kernel.org;
 h=from:subject:message-id; bh=ToVjAvQmv/dtNRn5p4/8OjGcotgzRI0qmd7n0/i3AJA=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKl7GxpezDlQ0XH0+nVGxhge+Z4nixuUWrfvOzjvZqtVo
 uH26bn3O0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEKroY/qfcFXhU3mi2N2Lv
 1Ot+635tz2TleKKdwvjCa9KTKQv2rp7H8FecZ/HrC1PyTL9dP/ak1bnIJv+phFfytEP5/ae8JZb
 wpzIDAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit a9ef277488cf ("x86/kvm: Fix SEV check in
sev_map_percpu_data()"), there is a build error when building
x86_64_defconfig with GCOV using LLVM:

  ld.lld: error: undefined symbol: cc_vendor
  >>> referenced by kvm.c
  >>>               arch/x86/kernel/kvm.o:(kvm_smp_prepare_boot_cpu) in archive vmlinux.a

which corresponds to

  if (cc_vendor != CC_VENDOR_AMD ||
      !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
            return;

Without GCOV, clang is able to eliminate the use of cc_vendor because
cc_platform_has() evaluates to false when CONFIG_ARCH_HAS_CC_PLATFORM is
not set, meaning that if statement will be true no matter what value
cc_vendor has.

With GCOV, the instrumentation keeps the use of cc_vendor around for
code coverage purposes but cc_vendor is only declared, not defined,
without CONFIG_ARCH_HAS_CC_PLATFORM, leading to the build error above.

Provide a macro definition of cc_vendor when CONFIG_ARCH_HAS_CC_PLATFORM
is not set with a value of CC_VENDOR_NONE, so that the first condition
can always be evaluated/eliminated at compile time, avoiding the build
error altogether. This is very similar to the situation prior to
commit da86eb961184 ("x86/coco: Get rid of accessor functions").

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Commit a9ef277488cf ("x86/kvm: Fix SEV check in sev_map_percpu_data()")
exposes this build error but I think it is really a problem with commit
da86eb961184 ("x86/coco: Get rid of accessor functions"), although I am
not positive so I left out the fixes tag. It would be nice if this could
go along with KVM tree that has that change but it is obviously well
within -tip's territory so I will just aim it at both parties and let
them figure it out :)
---
 arch/x86/include/asm/coco.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 6ae2d16a7613..76c310b19b11 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -10,13 +10,14 @@ enum cc_vendor {
 	CC_VENDOR_INTEL,
 };
 
-extern enum cc_vendor cc_vendor;
-
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+extern enum cc_vendor cc_vendor;
 void cc_set_mask(u64 mask);
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
 #else
+#define cc_vendor (CC_VENDOR_NONE)
+
 static inline u64 cc_mkenc(u64 val)
 {
 	return val;

---
base-commit: a9ef277488cfc1b7da88235dc11c338a14f34835
change-id: 20240202-provide-cc_vendor-without-arch_has_cc_platform-325a3fae8550

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


