Return-Path: <linux-kernel+bounces-65201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8C3854952
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523D81C228C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEAC5336E;
	Wed, 14 Feb 2024 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Tyh4PyIf"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7572F52F8A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914292; cv=none; b=lM7cdKMt45nanGB82hKGarCXVVJJI6PtQmEj1bPWvrb6CKWEpE+s18mBnfVxRY0RDX+Y5z6mhXKhqX1yU93tRbRDmNboZIEJbgouzGOxQsePng/N5vlnDFFZ3qkumNTWh3NBB1FotoJN1gSgLztzdkIcYZtLHDXmWUZmi3Xqq24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914292; c=relaxed/simple;
	bh=p3rGoxtAPqxJg7aO4efv+e3imv8GPR0Hro2uu4NOwB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F4a6ydLhGFW/TwJ9rc4M4OJVKUBAnwqGzx6AfpDK5IIRPYxnYD/TkMOWwF5CW47uscWZMllLd5oj2e8PsdmqyOVjePIZK9dCpOYjG90jI6306rEtUga6DsU1BIemd3dH+No9qqQiN14yXACXS8eOiBuD1IfkrISJcTgR49nPV18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Tyh4PyIf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e10746c6f4so695756b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 04:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707914290; x=1708519090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnX8n4eslB3tatxrOtV2L4MVIcOQlO77yyiHCpmaDS0=;
        b=Tyh4PyIfervvl3D1Yghw0BLl1RerZ6sZwxvz3CupjgZacH+5cSDD3mlyOji6ZWgkvg
         oyligUs4ii54nXiAPWyHV81Oq9XNOEpls3ECBSX/swCqpK9g4OlAKx+gOLk2gKMNk4FF
         AkbDst66kjqgSmJ60nPzozxzrUtSVTpEvY/L5Pd+9LDk9gcD152N4sYPrYYuWC1oQJZ7
         rUJOT84Vuq3hGcWPkUQ1H3KPkuGmHj/qBa0XxPWyDJHcOsMxvoHUIRUn3c6zMR5LGRE+
         o9GIwgAv9WuN8eGx6ru5ugTwGuh+z2vF6qmOz10LAo1cILH6s6A7nUushEaj0sN7crvI
         Bmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707914290; x=1708519090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnX8n4eslB3tatxrOtV2L4MVIcOQlO77yyiHCpmaDS0=;
        b=Rim0fUYAooDVdJIrZEazg/INhp1KkkIJbprIjUraLAV+oQookyQr2dnJHHFbd1aG5E
         HtCouFUv9Woi43YN2E71u6LIAuGBakXOnPAc9WkXcrzQ1DxMTvtrbFrh/5ZW4cUG47fM
         lMec/NU26SJrzA+2RtsAdBcv1BM4ZYFzLcGMp8rXPQvgINcqudYtoMpGWmJvGA0dZT4f
         XGxlkCMOoWHnK+uwyIn04WO8HCTWvVBa/1W0Cq68vYnzL12auZVIpmukVjvXH1ErjY3l
         qO1WLKh2OAbJVsG1bHTZURpvhuRKgTGJ42KdfR/IaH1C0jyBwgEwy7uycDx9xYrTQPP7
         j49w==
X-Forwarded-Encrypted: i=1; AJvYcCWETx4HXnbQYCEzlljfUFJbmmqAs3H1kzMvw0NyH0Y76dOn8EpcT5da7BS2mq1NX6zQc14NpPEzHHGUBArfz/kVKD+O3raIgNmLU25g
X-Gm-Message-State: AOJu0Yx9jMlTUm6XEH68iD2B683r28H5FrCgMJBsi7kwKBGVR+k+rd68
	yFlqFwrt+Gqel6pVnHatnqVcyCkwWAUK75N0Ra2405aCg3hLSE9izvKlN7HM7q8=
X-Google-Smtp-Source: AGHT+IE6uz5maWXsKH4t6Aoq6//Z/uwPwTljcM59c0ZygfRhwmy9JrCrRK0P+aMmGkUP38CMtl1oDQ==
X-Received: by 2002:a05:6a20:d90a:b0:19e:cd5d:8903 with SMTP id jd10-20020a056a20d90a00b0019ecd5d8903mr2859932pzb.24.1707914289771;
        Wed, 14 Feb 2024 04:38:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUseRnh7ThDsfj5aeC1nn7XD1vuC0T+l4uR5+8EA2oeNaaY4beARLRbEc2A5dB3+gf69HhCmg95FNFrVqsL676h30byk8kTd9lYlLxs0hSgvQ8X5/etcT/DhcJY8x1psR7VHew9KbANffe3Cy1WV5dL6KB3sEeLM+e1Ggoznv+uXUAmeTpY+BHCYZ+k+q2ITM53/7M2rM/QM66hI4uepvz2r5n/RgCxqGIjSxTLyWZKFElRBSB9M1Eyognik4Z2r0UgSIMR3y93lLWpqJJ90Dc5/wjKMjvhSJsf6oFZNXoF8FTdUTdBAUpRfkelhR66EbOuZ2UQTbcsxdsyDQO6736aiHEUmDWyc6aZlgxg9YIaxd7odR3dbPTWOrxRnRN72wFkQyDH2Odm5MjV6E7fQl0JJwQp0hyrQ+wglwQXoIC3GobElHq8xRR5QOxNNw==
Received: from anup-ubuntu-vm.localdomain ([171.76.87.178])
        by smtp.gmail.com with ESMTPSA id o20-20020a170902e29400b001d9b749d281sm3041419plc.53.2024.02.14.04.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 04:38:09 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 1/5] RISC-V: KVM: Forward SEED CSR access to user space
Date: Wed, 14 Feb 2024 18:07:53 +0530
Message-Id: <20240214123757.305347-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214123757.305347-1-apatel@ventanamicro.com>
References: <20240214123757.305347-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SEED CSR access from VS/VU mode (guest) will always trap to
HS-mode (KVM) when Zkr extension is available to the Guest/VM.

We must forward this CSR access to KVM user space so that it
can be emulated based on the method chosen by VMM.

Fixes: f370b4e668f0 ("RISC-V: KVM: Allow scalar crypto extensions for Guest/VM")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_insn.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
index 7a6abed41bc1..ee7215f4071f 100644
--- a/arch/riscv/kvm/vcpu_insn.c
+++ b/arch/riscv/kvm/vcpu_insn.c
@@ -7,6 +7,8 @@
 #include <linux/bitops.h>
 #include <linux/kvm_host.h>
 
+#include <asm/cpufeature.h>
+
 #define INSN_OPCODE_MASK	0x007c
 #define INSN_OPCODE_SHIFT	2
 #define INSN_OPCODE_SYSTEM	28
@@ -213,9 +215,20 @@ struct csr_func {
 		    unsigned long wr_mask);
 };
 
+static int seed_csr_rmw(struct kvm_vcpu *vcpu, unsigned int csr_num,
+			unsigned long *val, unsigned long new_val,
+			unsigned long wr_mask)
+{
+	if (!riscv_isa_extension_available(vcpu->arch.isa, ZKR))
+		return KVM_INSN_ILLEGAL_TRAP;
+
+	return KVM_INSN_EXIT_TO_USER_SPACE;
+}
+
 static const struct csr_func csr_funcs[] = {
 	KVM_RISCV_VCPU_AIA_CSR_FUNCS
 	KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS
+	{ .base = CSR_SEED, .count = 1, .func = seed_csr_rmw },
 };
 
 /**
-- 
2.34.1


