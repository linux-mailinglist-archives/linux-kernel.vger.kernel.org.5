Return-Path: <linux-kernel+bounces-132254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B095899211
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98327B23EAC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B56513C3FC;
	Thu,  4 Apr 2024 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Omb990ZD"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F813849C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272983; cv=none; b=fS+2EPULbt1ChYqZnjzbQkhUGt+8erxcF0Sf2gDZ7OjwNXJyhvtpc6sncYul/xQOoAwTzMmiNZ58Z+GXzb5zAQgt9JxQBsdDYXsf1XZiwEHD0Aiia5F1GJdwhlvW3tHM6tcSUqHsxRCM1x2RvcHaKzwm7jMDEeN6jSUAaQtpyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272983; c=relaxed/simple;
	bh=JDhLyOSQcTaSooSrCsfonCB5AjeLH72k876s7xQGT/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XC3IL+ChmBsGx2qWi37+YyfXmuUcQA7BekmbLVzxz1Ti3A9VRNXyQbSuWfU1TeepYrQDJ2fPwsE83xnxvp4tVHtwJWyD5+VEaMjJhYwUXnr5DLjRUUkbDg6UjMt429PWYBz2cNy+meSjAeabpDLHKBIu0CsCN/9BV7IqOOY9GYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Omb990ZD; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a50f170b7e3so217539166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 16:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712272980; x=1712877780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KwA9Lj7DcFnIwvQ2Z0JNXU/969zMWpLh40LE9qlTFsg=;
        b=Omb990ZDy3Ni8KlC44STRVuYWA08FoM6Roa3TdPJzgj11mYOVyDuZEAqgPc25R8lxE
         lPpfVTUYaW4HRxIJWmSqw5+nRheQHacFfmKbeCxZViX0dIHTw3pyUYARbAX9x9J6IGBa
         Cq7hVeuQxVjW4k/zN3PMPhSr6ELcPviHqIwM59knGNu9laYHn/0Msrpdn9rwYhSzvwvK
         68vC4imC5869z3a0KEkIKVrJwSxQALXzk7yIUINcdC7M4GU6T1FTzH/BBpAb3ece6u7B
         f4kCvKOi12H2/CbNVEVCoz/zxbG3VEwN9z5SPBOAK7Xfj2XFSKf6EFLxuifCBQZvHc6G
         1mSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712272980; x=1712877780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwA9Lj7DcFnIwvQ2Z0JNXU/969zMWpLh40LE9qlTFsg=;
        b=t5QkukLltb77yDBnqW9SERu0PWAhnigXiQNlsDEq+XQAPQ1VC4tvs+As6sPKIwoVtL
         p7n0cKAY5bAtYxbLw8rLqyqo7Yh+XBpmoCMAYPVoc5JKD50zlS8JIaL/oHUKHZtJzpSK
         GaessYStjMRc+gfth0PZxxFaZ70W594We/ivS9xgjEywXdzQV1Y2Cc56odeTt404Yz8n
         KWFuB0vCW4xgvy5lPEz0FJXZl7giZyyvaX7kCWtuqN3gbYMQ1qXKC0FN3AxG9VpMdMxl
         6tLaEelxfoASvmne+EHINYB5ktpLKrXXAQnjyVaja4uRP4P9RCnXbJlOrLeIdsXP50kB
         yz9w==
X-Forwarded-Encrypted: i=1; AJvYcCW5oMGteFpVv9cUowb/dV7kxEkyTZmPG0mb+z3i91W2mLf0TGJgpoubkNvefwykSuISmMv1hjOJfbOZuIRwQyN/EdkAn6G6UKRrPnlY
X-Gm-Message-State: AOJu0Yx1CpJhm8zsS/LKKbrp3v04VdtrSwnOyFK7veAGzVIahbSyD9QI
	ULv3Tapf8YhiLsNewChdcy8tYyACJKCoGivKAFOj5cb2MAs20G9Zi1hYEEltE7A=
X-Google-Smtp-Source: AGHT+IFuZOyI31RPfJNqk84k9YT+wF+zzwVQYgTjznj8dP/IUFod/milr4sZ93Uc0o0L77TMd3ntvQ==
X-Received: by 2002:a17:906:5a98:b0:a51:8ce1:4eea with SMTP id l24-20020a1709065a9800b00a518ce14eeamr1773193ejq.55.1712272979914;
        Thu, 04 Apr 2024 16:22:59 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id gx5-20020a1709068a4500b00a4e579ce949sm126123ejc.51.2024.04.04.16.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 16:22:59 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] x86/apic: Use max() to fix Coccinelle warning
Date: Fri,  5 Apr 2024 01:21:47 +0200
Message-ID: <20240404232146.47105-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
minmax.cocci:

	WARNING opportunity for max()

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/x86/kernel/apic/ipi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 5da693d633b7..7047948396c1 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -314,7 +314,7 @@ int safe_smp_processor_id(void)
 
 	cpuid = convert_apicid_to_cpu(apicid);
 
-	return cpuid >= 0 ? cpuid : 0;
+	return max(cpuid, 0);
 }
 #endif
 #endif
-- 
2.44.0


