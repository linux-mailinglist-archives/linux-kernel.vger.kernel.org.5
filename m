Return-Path: <linux-kernel+bounces-3349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD339816B54
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC371F229BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C444A199D3;
	Mon, 18 Dec 2023 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Pf1OvCGw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDA18627
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59091e4a0f9so1115181eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702896080; x=1703500880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=892a7MXGmC/bLYrq2xxQmZbI6vgYpLZafzDkJ/FX6g8=;
        b=Pf1OvCGwJ8z8lh9BXygrDkqJiDparXSzZzQsOlM2jSpRqpAPfI8+Wt3Z0Pf2Jj9eXW
         S2DbY4OLMJH13S52qglLqzaUTYyWwliq4I3ChoyxL2uXNX8kAfjlha5+jAUh8lrHy8h7
         OXPGK8EIwjSSf7Nd6tRIrrcVwQkWvj0DttIoH7E3qSYJsQUlTtriu4POqixXiQeN+x5h
         WJNUmRArDXll2SAuZnENR00jNuOh4T1vnPSlmygwLaBuV/94wousBgzXJirJpkDyHUKS
         5bHvRvhzfyM9NgUqoVjF7qcRODEUP9aegSDnjU1frURC6ErxdFmPBTekqxeo3K6Zfj2i
         IXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702896080; x=1703500880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=892a7MXGmC/bLYrq2xxQmZbI6vgYpLZafzDkJ/FX6g8=;
        b=g7wEWjlEcqT/w42FHGrt9/73J4fTW+E34p1+Fi/3V4apL66YiDU9KPDaUvcitaMj0Y
         NmGDkus+MnlYZ3FScnIE5gVlBlArGTw7MG12v1o9M7IMgz8HzW/UqRoU4jXyc/RxaD1P
         +Wl8U5qbLigG2KJiKFsNvJz8uD5S/lA3p4enYmz/Oj4YbGk1iUm9/XZF0XGKsHfkIsAb
         Vav1CnkRSU3HI1b7/84Y0YPM7VaWVNUXA3UcAkAyzbW/9OXanweMGakEUI4HEHimWD5t
         ir4hzbhZCOMgz0emBTLOhvAJC95afSoRnwrB+LtTiB7ZMJ5uKEiiWTWyR1v3fsgFtWIe
         A55Q==
X-Gm-Message-State: AOJu0YwORfJQeNfmOkVKjyvtKnYq9wdKizoYc0ZBmIpVNCiUKvQ+f8j1
	jFj/Zk/CVQJPLu3g7TD7q7GboYGZhMILajvEJEE=
X-Google-Smtp-Source: AGHT+IFgByVnLmmTZ/wPh8GAxGl3YQsD3+CdxKG6a7sBAikC48zmomkZqc6rzvayrv+U3EDDZxFKJQ==
X-Received: by 2002:a05:6820:162c:b0:590:5c02:a4d2 with SMTP id bb44-20020a056820162c00b005905c02a4d2mr8417153oob.13.1702896080113;
        Mon, 18 Dec 2023 02:41:20 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 185-20020a4a1ac2000000b005907ad9f302sm574970oof.37.2023.12.18.02.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:41:19 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@atishpatra.org>,
	Guo Ren <guoren@kernel.org>,
	Icenowy Zheng <uwu@icenowy.me>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Will Deacon <will@kernel.org>
Subject: [v1 02/10] RISC-V: Add FIRMWARE_READ_HI definition
Date: Mon, 18 Dec 2023 02:40:59 -0800
Message-Id: <20231218104107.2976925-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218104107.2976925-1-atishp@rivosinc.com>
References: <20231218104107.2976925-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SBI v2.0 added another function to SBI PMU extension to read
the upper bits of a counter with width larger than XLEN.

Add the definition for that function.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 0892f4421bc4..f3eeca79a02d 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -121,6 +121,7 @@ enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_COUNTER_START,
 	SBI_EXT_PMU_COUNTER_STOP,
 	SBI_EXT_PMU_COUNTER_FW_READ,
+	SBI_EXT_PMU_COUNTER_FW_READ_HI,
 };
 
 union sbi_pmu_ctr_info {
-- 
2.34.1


