Return-Path: <linux-kernel+bounces-155194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB588AE686
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36948283ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417DF129E9A;
	Tue, 23 Apr 2024 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1MLIH4z4"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E951485C48
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876223; cv=none; b=PNRHA+L5pApn2ru+Jg5AzWidk+h8ljTZJqdj/1l5hlgs+f03FGMSh4eggV0OV91r5KtkEhsRE+vm31a1hNaaaWCseVGNPRKUvdQJJZsjpCv+EOd/E+ofLLlHKog5IGJIgH31CHBjK6De181s2Ze1zX9pqiYfbogO9o+BPCv4lms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876223; c=relaxed/simple;
	bh=KFTgdydb4lEVKcKMSrUXTV8nL0BiY5SkmBYLlzxl7F0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lPZLsPz41tmb719/pFUV3K9FZQFmWPpfVramLwd9f7aae9kxLnDFFGV+rK4CNLMN3JdXBPqgfX23qBccTn21MU59OFhU93PJzC3BlqXi9vITuMBheg5xn1PJiIoUj0WS+pf6BQg7Z7pPzH2/PBxklAcGK/wC07kOOFTuk8X/z60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1MLIH4z4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34801b1bc4aso947579f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713876220; x=1714481020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C9WxKxISE98J4DR8ayongvF0iJ3p8rHkiA1LnrlMpVw=;
        b=1MLIH4z4Q+7/YnVtmiaHYKGDV7pr/oww+tOY7BaRCpi07buImlOwcJoqNXnFtKbdgt
         Gw6HuSr9pNM34RB90Cgts/q6gmDiQONj5XVxY9o/WSt2jX32M6c1X69uzOXaR6HZypKR
         nGPSVfQoC9UmJX3DEm9RPUPzZKbD3J2LNIXiO4Au5mgqDvzpWvIDRt8UtrYrj10DIuK8
         l/IF0/Q2HlmSsZ792Su1K8wVeFF0n/4l+EpMY5U1sLwvD1J+vuHE/zIFnvkNm+rRCgHw
         6nPjR51BAsLPMEyHvDAO5fbYew+Z35TsskqB6gArk4nyUdXTp6VbCib2YZiPqWWA3dEE
         ZwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713876220; x=1714481020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9WxKxISE98J4DR8ayongvF0iJ3p8rHkiA1LnrlMpVw=;
        b=nJQALxUzthpQb3nYJirPOSGlPg5zXPAvD0G93RZTli/9tKbFjWbmuUf/rpOOVA1EOs
         KtvGx1E7IGB4mUxwrLOBZC2HNH9ROUc+UhTXtEnnjQg76MO0Jq8JsCsatnn29Pl9C2z5
         YmosxdMtNs8V1wukZ3vC2ZUBzTDLWU+yN5k6inW6rsOegf2omjoms2TpOIrvttcdMz/e
         ugRupbBAz99zSPATHq9uGHDOY03NzZGX67S/FfGZQnaaY2vgnqxo8sE8wyZ7iQzwnEBj
         DN7scFuOZY9dooUjgndYRrNEeeaa+upfhX6UspBW3VimSmPbDeCxP2Z3JNTPCgEdtswd
         ZrTw==
X-Forwarded-Encrypted: i=1; AJvYcCVHjy0M9eyzUz7HjRJldhri0m2fvHkVt/elY5RfY6uNXj9ONInYY6WOxbQfYPx2DCXZ8D/zQ5jmnBpwNA3ahFdrh2V44EE7f7MiZXU4
X-Gm-Message-State: AOJu0YwHcSkrN03pwdfXVEX5xq8y3MxSXLS8Z/RAA4kou+AkXMMo+fsw
	o0FJQYHudwITEAWxPSNqOr0A3JhxgtdRZRXNd0MBf8ZQ7VI7eWGTonx0sHF5a0s=
X-Google-Smtp-Source: AGHT+IHpI2Tpv9REfejw04rEmQ/PVuDNtz+wncAv+sSz/yClI0MXsOsXH9hJ+L4XIOgzD6O4fSViLQ==
X-Received: by 2002:a05:600c:1c90:b0:41a:b9a1:3ecc with SMTP id k16-20020a05600c1c9000b0041ab9a13eccmr1166991wms.3.1713876220072;
        Tue, 23 Apr 2024 05:43:40 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:71cb:1f75:7053:849c])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b00418a386c059sm19975709wmo.42.2024.04.23.05.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:43:39 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 00/11] Add support for a few Zc* extensions as well as Zcmop
Date: Tue, 23 Apr 2024 14:43:14 +0200
Message-ID: <20240423124326.2532796-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for (yet again) more RVA23U64 missing extensions. Add
support for Zcmop, Zca, Zcf, Zcd and Zcb extensions isa string parsing,
hwprobe and kvm support. Zce, Zcmt and Zcmp extensions have been left
out since they target microcontrollers/embedded CPUs and are not needed
by RVA23U64.

Since Zc* extensions states that C implies Zca, Zcf (if F and RV32), Zcd
(if D), this series modifies the way ISA string is parsed and now does
it in two phases. First one parses the string and the second one
validates it for the final ISA description.

This series is based on the Zimop one [1]. An additional fix [2] should
be applied to correctly test that series.

Link: https://lore.kernel.org/linux-riscv/20240404103254.1752834-1-cleger@rivosinc.com/ [1]
Link: https://lore.kernel.org/all/20240409143839.558784-1-cleger@rivosinc.com/ [2]

---

v3:
 - Fix typo "exists" -> "exist"
 - Remove C implies Zca, Zcd, Zcf, dt-bindings rules
 - Rework ISA string resolver to handle dependencies
 - v2: https://lore.kernel.org/all/20240418124300.1387978-1-cleger@rivosinc.com/

v2:
 - Add Zc* dependencies validation in dt-bindings
 - v1: https://lore.kernel.org/lkml/20240410091106.749233-1-cleger@rivosinc.com/

Clément Léger (11):
  dt-bindings: riscv: add Zca, Zcf, Zcd and Zcb ISA extension
    description
  riscv: add ISA extensions validation
  riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
  riscv: hwprobe: export Zca, Zcf, Zcd and Zcb ISA extensions
  RISC-V: KVM: Allow Zca, Zcf, Zcd and Zcb extensions for Guest/VM
  KVM: riscv: selftests: Add some Zc* extensions to get-reg-list test
  dt-bindings: riscv: add Zcmop ISA extension description
  riscv: add ISA extension parsing for Zcmop
  riscv: hwprobe: export Zcmop ISA extension
  RISC-V: KVM: Allow Zcmop extension for Guest/VM
  KVM: riscv: selftests: Add Zcmop extension to get-reg-list test

 Documentation/arch/riscv/hwprobe.rst          |  24 ++
 .../devicetree/bindings/riscv/extensions.yaml |  90 +++++++
 arch/riscv/include/asm/cpufeature.h           |   1 +
 arch/riscv/include/asm/hwcap.h                |   5 +
 arch/riscv/include/uapi/asm/hwprobe.h         |   5 +
 arch/riscv/include/uapi/asm/kvm.h             |   5 +
 arch/riscv/kernel/cpufeature.c                | 249 ++++++++++++------
 arch/riscv/kernel/sys_hwprobe.c               |   5 +
 arch/riscv/kvm/vcpu_onereg.c                  |  10 +
 .../selftests/kvm/riscv/get-reg-list.c        |  20 ++
 10 files changed, 329 insertions(+), 85 deletions(-)

-- 
2.43.0


