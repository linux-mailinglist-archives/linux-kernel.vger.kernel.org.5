Return-Path: <linux-kernel+bounces-139557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 266D08A0460
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFAFA287518
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869A2DDA8;
	Thu, 11 Apr 2024 00:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CcRbNcO5"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9D9454
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794095; cv=none; b=W+EcAc0fFdgPxyHd/DtK6F0Lk8gqS2/XNG7VX6Bxnmh9eojmJri9cJgRbIRIBs0XgLId7oQSfVyFhDvKG0zwzW/Zf4KLzwfooVO+6bvFlUOTbT/wGOxSOEd0wUahsNTVvyRdwpuKvOle/0T+b6ZSmM4t/e5aMXcGbRpa+tDabZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794095; c=relaxed/simple;
	bh=tjU5YEqQieqMxVoH/UAjG6llZvkwIlIrjBWxORyGdm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0BhNWJcrlvcA8YRQ058QWhGmx6mERIqpeHedFwkP9o4/kX3YG9Hvopm63TdnwdEtxuFuI3kkJhYoJWZfbkmsT/X+U3dEDgtAA/EjgENB2G3EKXkXkWGxdh/3VjcKw+reWjUopEX1TeuBXsLH4nB8Dm+WgW3HeqEq7ziQbh//7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CcRbNcO5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e24c889618so59413305ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794093; x=1713398893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nwzSC0mjOXawHhzlfTnID2LKW7HdSbdpZLlPlBet3o=;
        b=CcRbNcO5bCACh8lgHlWrppEKVAfyW+AwH2Z+0+i+AZ0yLkKeCmwytpqfp+30pIoTBP
         HIajYvWftMSwby1j7RzYwyiRLd2AN7dsUr5XiMdkIUkCNUoonmlEH9cZNDDDK6wibCb9
         dkeyASE39QuqsfJNg2IkS0QBSvmR20WMOGkrlDpeZVx3AzV9etHmjUpoujzNYP3qMP29
         d61Z2FW7ohPwSeMtRAuD4gecn6nXZxsgylFAu642YZ8I8onN/blguiOSnWswjT/zYFmV
         SlMqA5mh3PiFL+xfctDJbp0dajpxS5F/MGhTomMZETbOVvWXkBgZQ4jbWxi590VdIMHL
         hl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794093; x=1713398893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nwzSC0mjOXawHhzlfTnID2LKW7HdSbdpZLlPlBet3o=;
        b=Qt4zoJtEuMkXHT1gMvAWDpfI7aRs+nLg/t2rgiQGYFYUU/jsGjzqVsbnEUIIyoZIci
         dmcV8+rl0/tZHkNB3PkTE8FJsPkd9ZOVVoHpj8hyKziZE9X34f6vG5E7gMHIrQj9HYqW
         EIZ/xfJsrNV+/pgW+zuhVw2TT9riEkkuMKteYBcUDSlMtCNgtHcNtiGLArRjF1M5mDGy
         PJt1nw5bIP6v07w8FoZLB3bEflaPjRhRDTz1QP4Qip0a+wpTeKQoRLyf0XIU+dSPVj43
         hj7Ax4cXswPoNI8dqEUkzfnvgbP41ChfYZ6dKYq0dGFsPbryrTMMt4YRGtz1LXULMr9f
         TG+w==
X-Gm-Message-State: AOJu0Yx82JiIRRgB7BYzGvAaRSvhzURyiKI3iAFz6ZrD0Y0U+maXT3ha
	L59qH1/E6wl9YgufuW0bl8I1DOhuYx6yV17l3zKQ+KHJ2Y0fJgjcPRMhJxU26ngRgvotjxM7C6+
	G
X-Google-Smtp-Source: AGHT+IG6OqYaJjg7MK1R6d7hiCeHot83RH1wCuW5h1sC+EdY34oQu3GEIDBFrBS/g+puRrw/WL9vMQ==
X-Received: by 2002:a17:902:d511:b0:1e0:b62a:c0a2 with SMTP id b17-20020a170902d51100b001e0b62ac0a2mr5130331plg.51.1712794092857;
        Wed, 10 Apr 2024 17:08:12 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:11 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v6 02/24] RISC-V: Add FIRMWARE_READ_HI definition
Date: Wed, 10 Apr 2024 17:07:30 -0700
Message-Id: <20240411000752.955910-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

SBI v2.0 added another function to SBI PMU extension to read
the upper bits of a counter with width larger than XLEN.

Add the definition for that function.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 6e68f8dff76b..ef8311dafb91 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -131,6 +131,7 @@ enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_COUNTER_START,
 	SBI_EXT_PMU_COUNTER_STOP,
 	SBI_EXT_PMU_COUNTER_FW_READ,
+	SBI_EXT_PMU_COUNTER_FW_READ_HI,
 };
 
 union sbi_pmu_ctr_info {
-- 
2.34.1


