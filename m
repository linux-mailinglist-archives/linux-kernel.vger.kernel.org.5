Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51BE80DF31
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345189AbjLKWwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjLKWwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:52:30 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD7CB8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:52:36 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dbc7fce330cso1973162276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702335155; x=1702939955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B9ebOHKT7ubdCD5+hQDSD8eq6ojeprFgMPVNOjVnCG8=;
        b=mAY8olsEcKszTzM3EWC1r5S/jY+6ef8Iu9ZrUassQcMJL2aJVu9a89hP96ycIxnoJY
         UhARvAFkdtxSoSvqeiMCJEqpqmrPEHxjLIRdatTkJdpPJr1dbG4sY9Z+LLvDWSDrIYPr
         3u78F4CaHL7XCjZ7p5dJyJgSiOOrMh3N7LtHRdR3sHKymLCsJAdOpv62vr6jmkD9A/oj
         8GuV41xpPcA6AEl7t0ivll8N9288eP7BdWAgmWTTwS7746Weda66z4I1QgzFw9psqOz2
         kEGU+AVvU+rN+4Cml/MPeyMRiSnLQtbwoVscPjH11MQ/QjLMFyMem0Okyov9jzUYuY21
         Xk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335155; x=1702939955;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9ebOHKT7ubdCD5+hQDSD8eq6ojeprFgMPVNOjVnCG8=;
        b=tPns4gMFuUUP49kzLqwFj1nzsP/1z9uHRlAC7aB6F1WlOZUumFUFzDUTyJfZZJnfMM
         dVq9bdC2bG40DUZq0hL814hSHXAoX1TbMJrLVg7ECKXxKXZtieP2mz8fbu3CBpwW99YL
         HaGBQrBu3BZcRS3wunskvENLzHeG2elJHsFmYnS/I4ClmOGnu9AWQ1A6Ryh1gGtgZ5Ev
         c65FTKlK74gTbrjmFNQHFggHKmjF8bCdCiKQtF0c6mdNybQRyA6UFGe3KHXotIl8Agz6
         RtRMAJ23AHSOeVCvseQZtf2Df8DrLAs6gajBffpCbAs4ENObdIXqvRwbg6KrILSYN3kW
         f81A==
X-Gm-Message-State: AOJu0Yz7ZkaSg4aiVgnLh6hMPCmZk7FWBVgcVWkgysFEjfG94RnIG2XA
        YfKk8nhGQSy1HH9i6ZWJsiDxzu1S9AMb
X-Google-Smtp-Source: AGHT+IGsrJP5MwOhfiNyz2OKPJOAqglVB7R2Jud6wtKYGBu0YDJXzcKpaWV2UlZbYDwuPYUO9cfoNhGAdE0D
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a25:b90e:0:b0:dbc:1c42:2d4e with SMTP id
 x14-20020a25b90e000000b00dbc1c422d4emr39340ybj.8.1702335155628; Mon, 11 Dec
 2023 14:52:35 -0800 (PST)
Date:   Mon, 11 Dec 2023 22:52:32 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK+Sd2UC/4XPwW7DIBAE0F+JOJeKBeyanvIfVQ9AB4IUm8hUq
 FXkf+8ml6qtVB9npXmjvYqGtaCJ58NVrOillbpwoIeDiCe/ZMjyxllopQ1pIrlirh2+zRkLV6N
 MYwAZb3UYg+DaZUUqH3fy5ZXzqbT3un7eFzrdrv9gnSRJG3RSiqaBYjjm2ZfzY6yzuGFd7wGaA
 aUwPY0KLir3GzB7gGGAXwJIJQ2HY641n/Et2D3BsuCMH21Mfpqc+yMMe8LAQnBmQAzwZMwPYdu 2L2VpWta3AQAA
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702335154; l=882;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=A2aVJiix4clFb7X/1Qv26DmYyS9huqwRq6TucutM9l8=; b=Atw+9+xOK54xIt5bcfqJF5/wLLnYZYUHButs4pynDb3A9boCboW8uw4pnJv/IQFiSAUcVEAv7
 hgQ8l56jQVpCLWxFf41bSu1Wvl7YE5QvEJRFS2f68436QH5YbQ6SDpU
X-Mailer: b4 0.12.3
Message-ID: <20231211-removeasmgeneric-v1-1-a0274e802789@google.com>
Subject: [PATCH] arch/riscv/kernel/sys_riscv.c: removed asm-generic
From:   tanzirh@google.com
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <nnn@google.com>,
        Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/riscv/kernel/sys_riscv.c builds without using anything
from asm-generic/mman-common.h. There seems to be no reason
to include this file.

Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---

---
 arch/riscv/kernel/sys_riscv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index a2ca5b7756a5..ebcaf386ea62 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -14,7 +14,6 @@
 #include <asm/switch_to.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
-#include <asm-generic/mman-common.h>
 #include <vdso/vsyscall.h>
 
 static long riscv_sys_mmap(unsigned long addr, unsigned long len,

---
base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
change-id: 20231211-removeasmgeneric-f6be13a42b6b

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>

