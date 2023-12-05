Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B9F804531
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346652AbjLECna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346337AbjLECn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:43:28 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870DECD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:43:34 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d87a83ec27so1843951a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 18:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701744213; x=1702349013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESe2+H6xRcIvQHZC4sCC1Ujc/nu3bNcuHE36+amdpNs=;
        b=Y+ciD/tNCJQ8NcC2aGaOUHpwaeXN8Bf4qOEpdx8qdaMxXj+XhQ0CJGVcbaW2iopBha
         EWPptcxKOXaAIF44bTipFnQAzSBJax29OwbCbYsdm96LVzlQqU34IvNM2H5mDmVLqJW9
         ctBByOzacU7BTiAoLrbLg0SDJIktlQUEnFSX4nvhA/HGoXe2XF2M0rbLeYyqZg/Gvuht
         AjCdMW3YlZt29/NrIT3WYz6bIbU/ERucE2PS0Qp6SNUk0hGWCXp2WGOwN6EO1aOGAgVm
         S1T1NEUI/PzvYqnC0uBE6LbmffXt8h5AUhB/S1hoJNQPP3xlWCHjN1+RyJ8JL/bDnxTW
         e3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701744213; x=1702349013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESe2+H6xRcIvQHZC4sCC1Ujc/nu3bNcuHE36+amdpNs=;
        b=Y8UMd3RLuQ6OYkGgT8X2uIS6XFEt+QUGz6Vs1h0+q7WyuYa1b1Cy7oMob6hWaXjbBd
         J721jhi7HOR9e5CjFR76OcHIvXDtxF2625mxp2Y1gy3FnXTFLjX5ufDsZ6bCDwetse3k
         Ey54usXnl/EzagBmO+4o0CfAk4+Jh/KznNdFwjYcsOjbkdTcTJsObxzMF7njxvTYcwqS
         mzLW5O/hpwqh994dYt+U3q3leCsCgyyLd9zCCxcDlPm9GtxQvWTBgwWofeQ9bGSSIGbT
         MYS7id8ndSj0312B/4AXt4o3dZM6pRmDqYW2ucMOMm9DQw2YWKKfy9z9T6JT64YOlWZQ
         nMCw==
X-Gm-Message-State: AOJu0YxSLW9bz/v7RfSTRlHIoXHLbw/BZYm4zAefD2eNuqjoGN+fjl5S
        XWMRl9flzS3AZJNFy87PGPfMvRfvX2UsbeiE2usatw==
X-Google-Smtp-Source: AGHT+IGEgSVldCBVjabdNWyXSrgKexmOSpdOUxfqb+i3/FDPH6nx8GslbA4iHobHadY6ni/KUBPIug==
X-Received: by 2002:a9d:748b:0:b0:6d9:9ef8:84b7 with SMTP id t11-20020a9d748b000000b006d99ef884b7mr2852315otk.26.1701744213065;
        Mon, 04 Dec 2023 18:43:33 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z17-20020a9d62d1000000b006b9848f8aa7sm2157655otk.45.2023.12.04.18.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 18:43:32 -0800 (PST)
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
Subject: [RFC 2/9] drivers/perf: riscv: Add a flag to indicate SBI v2.0 support
Date:   Mon,  4 Dec 2023 18:43:03 -0800
Message-Id: <20231205024310.1593100-3-atishp@rivosinc.com>
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

SBI v2.0 added few functions to improve SBI PMU extension. In order
to be backward compatible, the driver must use these functions only
if SBI v2.0 is available.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 16acd4dcdb96..40a335350d08 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -35,6 +35,8 @@
 PMU_FORMAT_ATTR(event, "config:0-47");
 PMU_FORMAT_ATTR(firmware, "config:63");
 
+static bool sbi_v2_available;
+
 static struct attribute *riscv_arch_formats_attr[] = {
 	&format_attr_event.attr,
 	&format_attr_firmware.attr,
@@ -1108,6 +1110,9 @@ static int __init pmu_sbi_devinit(void)
 		return 0;
 	}
 
+	if (sbi_spec_version >= sbi_mk_version(2, 0))
+		sbi_v2_available = true;
+
 	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
 				      "perf/riscv/pmu:starting",
 				      pmu_sbi_starting_cpu, pmu_sbi_dying_cpu);
-- 
2.34.1

