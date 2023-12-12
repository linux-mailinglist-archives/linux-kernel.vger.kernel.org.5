Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256F180DFF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345453AbjLLAUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjLLAUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:20:20 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD283
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:20:27 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d053953954so25863725ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702340426; x=1702945226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qx7m9vRzp56qZzBiDq54IglkfWGSk4qU7xvtkpwu46k=;
        b=uU1ekAgf7jmJ6npoUqWGnxZxgX3Ux9h9O0q5Gz9NTrzoMnS5u/Qr5dvi/d2oLCbvNK
         nZhfL8aNyiXsEXTG582tqbScZ74MBHAn+OZmnlVsQnkaPi1Yu0xiaxgSNAYpntSyeZr4
         f0D/6t9NlOwCnVV8pLOZA1zhLHcZGVq9GHslPFe8NWjIm6oErMBq0Jed4+/MjIjj2Nct
         o8SEhTjonBeSVpw1BKTt2oN2ZjDNeBflm01gnFlwZn5ngLOk8IH/6gGh5FWsAZkWf9tg
         yOPzMTYl+5u4LToEsCIaIy3RZ0f5beLs2Iqd5+E0adH4kZjgd/OXxAOIg/y2xm1+bqqh
         iHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702340426; x=1702945226;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qx7m9vRzp56qZzBiDq54IglkfWGSk4qU7xvtkpwu46k=;
        b=I8XiQQEAuX3dZbXIbTtOKLALG7hHOo9fDUGLo/x7AILiYGxRrvTemlUeXovbvMl+C0
         ZXx2U6mkNJ/0gWyGVkVqrenADbMsyReJSmBg+XbJU5KFo2MLGg+id4vo1jxPH0s3qdXn
         UpEhN/tcZToBuYo7VEiz5B96zu+9r4cHpXpESMtGNffeMWgHE863M5OdnjmVnPOdMPIN
         7jxdRnLY95fsEmlXX5De8wowEOJeIAZGRYNmNow6nMW9G1I44lJ12RIr/rdHfrqY7oBU
         2mZ1PokpwBPHr+Ovmjq0ZE17E431ohhACv8djIhgJcd6S1775DJ3DikQAv8J5a1yDHqO
         /S3Q==
X-Gm-Message-State: AOJu0YwUdmUoigF4Rg0HcEUU+rX3nGyvFE2C3jNM4LrZL7Wg1A9GEF3L
        djVPX20NdstAoCrnFql3TOExinstD9Af
X-Google-Smtp-Source: AGHT+IEQkbdDIljwjMioFvyc1cxwo2xErwu6uT/g4NnGKyVsAd4qaF0of9asKVrfJantMA3+6h/L049nRoOU
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a17:902:cec5:b0:1d2:f388:6def with SMTP id
 d5-20020a170902cec500b001d2f3886defmr42116plg.10.1702340426511; Mon, 11 Dec
 2023 16:20:26 -0800 (PST)
Date:   Tue, 12 Dec 2023 00:20:14 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAD2nd2UC/4XQwWrEIBAG4FdZPNfiqMlqT/sepQe1oytsYtEiL
 UvevZOcWhbqRfiF/5vRO2tYMzb2crqzij23XFYK8unEwtWtCXl+p8ykkAokAK+4lI6uLQlXqgY
 eZ4+gnJZ+9oxqHxVj/jrI1zfK19w+S/0+JnTYb//BOnDg2ssoBJgJgr+kxeXbcyjLbg+KTsizR
 kOnsZdUSrrh0dzX6HI0WpIgBJrzLNAGYX+NPgA1AhQB9BmIIKJEiw8r6JGgSbDKzTpEZ4x9fMQ 0EiYSvFUTBo8OlPojbNv2AxOaRE7xAQAA
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702340424; l=1046;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=MGLaiGsynrvaDSNN1tr+dE3u0Z9QSFrYm2m2LgINKqo=; b=Ag5LoG3LmarazrPJQCeL9+7ZPXoR1L4scDRe/vYQ9PeC8tuSGxCGnOUNuFfkJ7kn5faHE6yhe
 bkCm+AO/4ChBY9yRb1jSK9cJCHsBKXIoteKgcRgccRry0BZZu7v4rNt
X-Mailer: b4 0.12.3
Message-ID: <20231212-removeasmgeneric-v2-1-a0e6d7df34a7@google.com>
Subject: [PATCH v2] riscv: remove unused header
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
Changes in v2:
- Changed name to riscv: remove unused header
- Link to v1: https://lore.kernel.org/r/20231211-removeasmgeneric-v1-1-a0274e802789@google.com
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

