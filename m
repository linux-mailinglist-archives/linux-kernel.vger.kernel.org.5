Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF16811023
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbjLMLdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377794AbjLMLdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:33:31 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A0210F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:33:14 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2cc2adbcf87so5356501fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702467193; x=1703071993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdmTrlQiysEJ9gRiozTT9JeMo8PxECkQ3IPcbyVimLw=;
        b=1JzP0M/Zj2mlSQmonb0E6bjzwpGdul5JD5yby86ozwQQnkcAMlhoXcu1gNto7LHn6w
         L2tfbjF7psCq8omOqGZL+9tA6zC/+z6zgSIobdgW6zm7negsTBRt5pAJUzu7Xij+Cx5Q
         CB3LeqWVb/7tV67MbHb7hLFBlVdP8/ratdtjzS47snCF/1OPXaQLNdYPHnPCBgKhli70
         EDvxqSi4acmAjmoXKMOsew45jGFPWnz5AEMGzPk0SbWGT4g8WFYc9HNtnvoALloDyZJv
         Sn2rCzFG3Xk0/yXGulGk0miKAvcLcUxg8NZnhidEOfD5jV8uUZeMq0We6Kq8KBRSyyuS
         uSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702467193; x=1703071993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdmTrlQiysEJ9gRiozTT9JeMo8PxECkQ3IPcbyVimLw=;
        b=lNe5oanKqFi5aQPyf/xoie6pcMtbjs90r0p9cbT7cA0XA2FyrZ60lgmz5BOK88j3IL
         5waPdA1/olniDqBlvLstqacy+aaw/utwTgTSGQsBxmMr7EkOfzEOQFAfBC8YNQmeyJ3L
         FRpf4r1r91E87fq/2gL8XSKeEVIiNeA7Gftm305/tekB33n+jQ8YMgG2a+9eEt4xsvCB
         PUE/UiEXSlC2waX7jsCowyUEM9i9+qfDf8Q5sKkDMB7mE/g9EyAnZffdYjMnKwMLxkMg
         G1riNFcjmBCTR7GKrSFKTMqZMORqafOqaXemY2OfS7EtxLmCFX0tmnR8auNtQiM0VDqz
         zxQQ==
X-Gm-Message-State: AOJu0Yy0rEf/E3Z69q7YB3v95+TQQ6Ia40qxQqhaJG+/gP+JS8sTzC4+
        kQXJiP/HylxuYrBW/ucrqpnuWw==
X-Google-Smtp-Source: AGHT+IGRFuH629++Bb3wGMQ+qnci9mOmjy+tVmt+kXTT5YpcBLnKt70/RrbZJJli1/GOWOFaotbQYw==
X-Received: by 2002:a2e:a54f:0:b0:2ca:350:9339 with SMTP id e15-20020a2ea54f000000b002ca03509339mr8364738ljn.3.1702467193265;
        Wed, 13 Dec 2023 03:33:13 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:c564:f167:d072:5672])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm22433137wms.30.2023.12.13.03.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:33:12 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robbin Ehn <rehn@rivosinc.com>
Subject: [PATCH 1/9] riscv: add ISA extension parsing for Ztso
Date:   Wed, 13 Dec 2023 12:32:57 +0100
Message-ID: <20231213113308.133176-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213113308.133176-1-cleger@rivosinc.com>
References: <20231213113308.133176-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to parse the Ztso string in the riscv,isa string. The
bindings already supports it but not the ISA parsing code.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 2438d4685da6..3b31efe2f716 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -84,6 +84,7 @@
 #define RISCV_ISA_EXT_ZVFH		69
 #define RISCV_ISA_EXT_ZVFHMIN		70
 #define RISCV_ISA_EXT_ZFA		71
+#define RISCV_ISA_EXT_ZTSO		72
 
 #define RISCV_ISA_EXT_MAX		128
 #define RISCV_ISA_EXT_INVALID		U32_MAX
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index dc0ab3e97cd2..3eb48a0eecb3 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -279,6 +279,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
 	__RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
 	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
+	__RISCV_ISA_EXT_DATA(ztso, RISCV_ISA_EXT_ZTSO),
 	__RISCV_ISA_EXT_SUPERSET(zvbb, RISCV_ISA_EXT_ZVBB, riscv_zvbb_exts),
 	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
 	__RISCV_ISA_EXT_DATA(zvfh, RISCV_ISA_EXT_ZVFH),
-- 
2.43.0

