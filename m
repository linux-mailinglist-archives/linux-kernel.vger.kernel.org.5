Return-Path: <linux-kernel+bounces-134536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F47789B2B1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB63E1F21C89
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8105E39FC3;
	Sun,  7 Apr 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEBsYuHx"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717F1EF03
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712503633; cv=none; b=PxJb2BmGKSi1ZgaVYHCVo44l056Cc9AE31riM7IrjvjenN8YRo9MJHr4k4VpTFTYtHsm9LYbFpYyCC3yvtnB1t6XY0pF7+h6iB/Uopa7BPH6/nvow6SonZc5lcpPAxDMX6EFLd/4FXTu3prJSiLaccfIbcm72/QLMpcdJCDPwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712503633; c=relaxed/simple;
	bh=FURRWrHSgX80uBiDSafgZNT2fkaTyb3bovkxas4UjKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGkJVv4GEpoC9GZopxk1zcF5ykfqeBGzZYDeQKKyBepehZiTgYongq2/X0RQUVqnWF5W4aQmsrQ0ykZNIS/j0BGnjIutffVf8UnYC8FLL/vgN4g+RR/1+KMh+3AoZH0wVRBv3/7Q4Qskpdy0ttH6ltPLjuILkDnXjh6InUjH69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEBsYuHx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a51c35a1b7eso104837466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712503630; x=1713108430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SuBrWZuzMdfV2ubuf1lp4gVv+r9cyyPK0cIRWvRywLk=;
        b=cEBsYuHx8M+7Kr0D28ZuDpsKwq/DLtPtbTUZiDfp5SIEv0r9jfwnROiPHwj22rV2go
         3urzwppgOq072HOc4y1tiaa9liIa/NQ1n97zODvns89vfg/EbLDMGxnAzn1y8Vau6d/f
         PGY4ucLSO5KmcBGq3S6+MRmBEo+AV13dmog4XjE2YuX1JGt8QJF7vAtnoeAda3nQPcw/
         s6bd74qBQThaAiiAsbQeHa8zSslGApZfjgiZbXfSclDtEQNfAkZ3X0tvtt35KWCiySA0
         P2nqJ0ynWQV/DSe2OZCkFfLLJJnGu/k1EB4qUZS/+tcf6dtJv0VvdpcNIMs1sL1yTTeb
         Vofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712503630; x=1713108430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuBrWZuzMdfV2ubuf1lp4gVv+r9cyyPK0cIRWvRywLk=;
        b=XTsDuVs7exWl3/+yTPjWfq89kw+ovtwBiFiP3ntmWkhIONXvGC+EXelZPWzNvrmJNu
         c5IZiIVN3/UlcyQ0oKWUzeIuJVdwM0oG6TtQDvTc0F9aGRNNPtYjExfY89UITRgAkLtI
         rJOv+abSlwmyHjuFN2nvXt+Uqh1MF+slQAqNgHa2j4vmfF9qLsPLSHTN+nxGu7XcCehq
         OT9NUXUFFKxU2DK+zQyvuWJxwMvLQXmqD+wvWrwAh8HANSE1ZdpHGEXjb+5Z7ybyjk50
         miivVIIyMLb2+HKJyokCaAupWhJlXPwjGc8A1oageA/1BJmYBVWP/QOu07hQ0/9WVIwi
         bA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUx6RbXoqw5Y8WsRXuN3XG5kyOnLOrzX59Z1JlH+yZd6JG++QBkunoHemXYW4nK+j1u8+V6zH1AVWew9VpjFpEg7RFqsznvbvpJBaf0
X-Gm-Message-State: AOJu0YzeToxNyNNOB5B2/xReQqt4CYRuNJbgabWEcmrOk5Bt7jLZfiVG
	q+Ic+V5CkKe8XFUWryM4mEV1i38XKWye2EpKU1AG7jG9VYqb3+Y=
X-Google-Smtp-Source: AGHT+IE7X7pS0UU+V/gQ4l3LEd34xTkYN3rspMbVlnt1E+AbKxN89MiOyng+4a3NNquz7xbZaLT6gw==
X-Received: by 2002:a17:906:4a81:b0:a51:885a:c0a with SMTP id x1-20020a1709064a8100b00a51885a0c0amr4253599eju.61.1712503630102;
        Sun, 07 Apr 2024 08:27:10 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.6])
        by smtp.gmail.com with ESMTPSA id sd15-20020a170906ce2f00b00a518debfd49sm3269440ejb.116.2024.04.07.08.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 08:27:09 -0700 (PDT)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: tglx@linutronix.de
Cc: adobriyan@gmail.com,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	Jonathan.Cameron@huawei.com,
	linuxarm@huawei.com,
	linux@roeck-us.net,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH 1/2] x86/cpu/topology: don't write to immutable cpu_present_mask
Date: Sun,  7 Apr 2024 18:26:43 +0300
Message-ID: <20240407152643.3245-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Workaround the following oops:

	topology_hotplug_apic
	topo_set_cpuids
		set_cpu_possible(cpu, true);
		// write to __ro_after_init section after init

adobriyan: I'm not sure what's going on, can it set unset bit here?
If not, then why does it repeat the job and set already set bits.

Anyhow, let's not oops peoples' machines for now.

Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 arch/x86/kernel/cpu/topology.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index aaca8d235dc2..42f4a17f8019 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -117,13 +117,18 @@ static __init int topo_get_cpunr(u32 apic_id)
 	return topo_info.nr_assigned_cpus++;
 }
 
-static void topo_set_cpuids(unsigned int cpu, u32 apic_id, u32 acpi_id)
+static void topo_set_cpuids(unsigned int cpu, u32 apic_id, u32 acpi_id, bool from_init)
 {
 #if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apic_id;
 	early_per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
 #endif
-	set_cpu_possible(cpu, true);
+	if (from_init) {
+		set_cpu_possible(cpu, true);
+	} else {
+		/* cpu_possible_mask is supposed to be fixed by now. */
+		WARN_ON(!cpumask_test_cpu(cpu, cpu_possible_mask));
+	}
 	set_cpu_present(cpu, true);
 }
 
@@ -191,7 +196,7 @@ static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
 			cpu = topo_get_cpunr(apic_id);
 
 		cpuid_to_apicid[cpu] = apic_id;
-		topo_set_cpuids(cpu, apic_id, acpi_id);
+		topo_set_cpuids(cpu, apic_id, acpi_id, true);
 	} else {
 		u32 pkgid = topo_apicid(apic_id, TOPO_PKG_DOMAIN);
 
@@ -343,7 +348,7 @@ int topology_hotplug_apic(u32 apic_id, u32 acpi_id)
 		return -ENOSPC;
 
 	set_bit(apic_id, phys_cpu_present_map);
-	topo_set_cpuids(cpu, apic_id, acpi_id);
+	topo_set_cpuids(cpu, apic_id, acpi_id, false);
 	cpu_mark_primary_thread(cpu, apic_id);
 	return cpu;
 }
-- 
2.43.2


