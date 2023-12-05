Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596E4804534
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346753AbjLECnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346687AbjLECnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:43:33 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2550A109
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:43:39 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d84ddd642fso2807758a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 18:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701744217; x=1702349017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezsx5Eqv7C1IIJcHeXVdQzYdP4PWuNbr/jfR9i9uc+E=;
        b=FKH1Gs8B1mqIu9eyoVmvKmmrtqbDrYKlv0vtgXtIxQJmNTeb5piflB3M9hRwo3r1JC
         f51kFxYpLx505XbsNejjSN353ZLlwQ5IMt4KqnW88yHFpPFGjYD9q5JhwfJyW9LZAmvK
         6MSHbLFY5h4lk8taYY7dpw9CIDzsnMSKAMzKUJELD8k6JBkxkFffrCcruEh6kSlV4/1c
         Q3fxN3Gxm8XhgmVm3MFbDqqYWGsSdXZLH5/1aRmE8aHqhW2eiCmS0FfOfG+HC0hmkgB6
         r37cx5zgfhxlDkX9137V+0E4O+NIqXJpFmWBAkamHiYP6oFAEZpZ25ezg16xC7ADMznH
         xKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701744217; x=1702349017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezsx5Eqv7C1IIJcHeXVdQzYdP4PWuNbr/jfR9i9uc+E=;
        b=j0afK9KcjQh9CqA7FQxk2iwoCwXbgy2CrDPPZtFBS4aLEDGNXbCqqM/T2oVFPSJfyn
         A0KDOtrnSHTWLOXijlr4ZoQDDaFgERWGNOa4qBTlGBJ0rCNk5sF0nRoo3UJXgUZ/HFVQ
         Wxhvb2/lr8B2sWFO+0UE2qt4zrGDd/Ljll3MfIRXXryRFc6fjct7oSiUhDwUUgbRYy/j
         tOkBSsS36f6ZE0uUf3+C6g8ulJJr4bgxM5VR10ML7cjV+s8Y8L3mxR2B8lD0w3dg7Js+
         E1XQV6hFcw1WvXQIeDZ94pDwHAP8oUimboPzDaGJoHgJLskADm2zWcVcdcMkGu3/If6L
         23uQ==
X-Gm-Message-State: AOJu0YwqUHVX+EP3Y6Y0nArPpfhFRbiuPqcSY2PHKHxEJIDFKmWa3pXP
        O7h5QcRQKujeKl+nCkaQPzMsroC2iChqA74cqMHB8Q==
X-Google-Smtp-Source: AGHT+IF8HbmBfGcwhzrY8QgNBoAV0D9dftfiztmlrc9uBoUNExR6eq192ybD6wyNke0oHa4GT14FGA==
X-Received: by 2002:a9d:6398:0:b0:6d9:a17c:237 with SMTP id w24-20020a9d6398000000b006d9a17c0237mr2375646otk.23.1701744217652;
        Mon, 04 Dec 2023 18:43:37 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z17-20020a9d62d1000000b006b9848f8aa7sm2157655otk.45.2023.12.04.18.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 18:43:37 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC 4/9] drivers/perf: riscv: Read upper bits of a firmware counter
Date:   Mon,  4 Dec 2023 18:43:05 -0800
Message-Id: <20231205024310.1593100-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205024310.1593100-1-atishp@rivosinc.com>
References: <20231205024310.1593100-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBI v2.0 introduced a explicit function to read the upper bits
for any firmwar counter width that is longer than XLEN. Currently,
this is only applicable for RV32 where firmware counter can be
64 bit.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 40a335350d08..1c9049e6b574 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -490,16 +490,23 @@ static u64 pmu_sbi_ctr_read(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 	struct sbiret ret;
-	union sbi_pmu_ctr_info info;
 	u64 val = 0;
+	union sbi_pmu_ctr_info info = pmu_ctr_list[idx];
 
 	if (pmu_sbi_is_fw_event(event)) {
 		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
 				hwc->idx, 0, 0, 0, 0, 0);
 		if (!ret.error)
 			val = ret.value;
+#if defined(CONFIG_32BIT)
+		if (sbi_v2_available && info.width >= 32) {
+			ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ_HI,
+					hwc->idx, 0, 0, 0, 0, 0);
+			if (!ret.error)
+				val = val | ((u64)ret.value << 32);
+		}
+#endif
 	} else {
-		info = pmu_ctr_list[idx];
 		val = riscv_pmu_ctr_read_csr(info.csr);
 		if (IS_ENABLED(CONFIG_32BIT))
 			val = ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 31 | val;
-- 
2.34.1

