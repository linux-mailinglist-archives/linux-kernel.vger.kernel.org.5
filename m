Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC8C7F6C97
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344244AbjKXHKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjKXHKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:10:23 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5C9D6E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:10:29 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1e9bb3a0bfeso1031688fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700809829; x=1701414629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUH3sN/jANNMbAvxiLE+FR6QScUT3piYF3Fp6n0y2EI=;
        b=RoALgjWnemxxjmtlqT5DvnrTTgrLgOFwI5HLeHeeAIVVWAflUwcIjaxs52WR1GmaIp
         TnAMIpePdF6OisIV869E0SRSwj+9o02T8gUCYCP95UcOXOG415pScOy1ADdF+g+J7K/7
         N8rDXO5drpGbBzpJPJkQCWnEL3cpsOohih4cebzkF7/BtJaMJGwoYH8IHtxt8wPK8tot
         jqSsMNqSF9zIvyNufldP/BRztJ+o2e2eKKSBXd2NeKiVqn4jKsOSJ5lXCi8bgdGrYVjy
         rcxf4XHUGaDSCwE/gj607oToozYwVevud+OIZXJ1RJR6AZMEfVHWqXHrFlbchS59SlqR
         a3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700809829; x=1701414629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUH3sN/jANNMbAvxiLE+FR6QScUT3piYF3Fp6n0y2EI=;
        b=stf9yhdjUNMInPuHgcDq95v0UryYiJy9U8VoailRf8t2ACl0L49u1iFjvnuLET60hc
         ySouc+UuMQ1aGv5IQxJY8nIMKLfDgPFCE1MJlqu5MjOZrLIqCcZviF5Xh9nX31cund9D
         CKUdAxvbzWB4CfzpIZX+zDqKLBncG41j7HjCU5QbxaGqzvDgizRditHdYOcjequAMOPr
         2dSvmCrTuJ8xc98rrfJfnGMbYn1WQwV6AT/iiuIFc1PvaPGqw5UXN03L/xks+tmQY2g+
         fqYWXAtNCeLZQ+2Y4ol8N4c3tFJTPDVO1CnCHFel4UDzw6aPr3uiFGG3r4rngxdbXa9O
         YQcA==
X-Gm-Message-State: AOJu0Yxqw0ZHUZsgHXNQnj3MwpiYv/PDB+zwH8z8w39wTw2MP4vYK27k
        IYgYdZVuLJATbuhwmERAoWapPg==
X-Google-Smtp-Source: AGHT+IFcPdJe1/+ZUHL4jSznxzi4QTW1Nct7Qxw/93cKKbEqCPdbOrdVTAgRyzDakbY8JJUSxK2OJg==
X-Received: by 2002:a05:6870:d8cb:b0:1e1:3ac9:bc14 with SMTP id of11-20020a056870d8cb00b001e13ac9bc14mr2262118oac.30.1700809828736;
        Thu, 23 Nov 2023 23:10:28 -0800 (PST)
Received: from localhost.localdomain ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id e5-20020a9d7305000000b006c61c098d38sm435532otk.21.2023.11.23.23.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:10:28 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v5 1/5] RISC-V: Add stubs for sbi_console_putchar/getchar()
Date:   Fri, 24 Nov 2023 12:39:01 +0530
Message-Id: <20231124070905.1043092-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124070905.1043092-1-apatel@ventanamicro.com>
References: <20231124070905.1043092-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions sbi_console_putchar() and sbi_console_getchar() are
not defined when CONFIG_RISCV_SBI_V01 is disabled so let us add
stub of these functions to avoid "#ifdef" on user side.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 0892f4421bc4..66f3933c14f6 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -271,8 +271,13 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg3, unsigned long arg4,
 			unsigned long arg5);
 
+#ifdef CONFIG_RISCV_SBI_V01
 void sbi_console_putchar(int ch);
 int sbi_console_getchar(void);
+#else
+static inline void sbi_console_putchar(int ch) { }
+static inline int sbi_console_getchar(void) { return -ENOENT; }
+#endif
 long sbi_get_mvendorid(void);
 long sbi_get_marchid(void);
 long sbi_get_mimpid(void);
-- 
2.34.1

