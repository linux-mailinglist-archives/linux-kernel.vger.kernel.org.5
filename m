Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A57177EDC9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347162AbjHPXYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347147AbjHPXXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:23:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA11271E;
        Wed, 16 Aug 2023 16:23:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe4cdb727cso72292945e9.0;
        Wed, 16 Aug 2023 16:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692228226; x=1692833026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3QZb2R3EdSRGjNldFEi1fV9QVZELOWJSDHH54gUih4=;
        b=lxO1UAr4NneU+P6Ihb8bkx/VGrROmaqowPU14iRlhaBcEsBBUdJxksJxlCRA9CwkWj
         0K7pbCpiUVKHSucjlDfysFP9QM7lhCmB3z93KBLq0ivmXhN5CHHoCpwFQ1TXGaRbZeaW
         HAm3YcHxdA3UWYYSAeCVwP5sBve3HbXdjGQIcXUiD5My1JU0+nEdoGu3gzv5WH95S4dl
         n+qxFbotzHG4sAsD8mfY7mQwTSAunSbjRE2Y3HT+JvZcZ7qSLV2UVa05X82kLCtEGv/S
         OwdbKJ6X9Zj6/LKSLYRBCKveneRYhLxhLY6mAy5UfKaY0iqZGd5eIWRmcAjQARJWqQLd
         U0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692228226; x=1692833026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3QZb2R3EdSRGjNldFEi1fV9QVZELOWJSDHH54gUih4=;
        b=ed2YoDoYqWIT3yxYnGDfFHkSRFIW9aKVhwrHZcx/1In/g4IxAnDe+pZ9OE653ZU6je
         XfTKYLOnrQR6dtzPVsVQq+FEGWkl9ns76z2FrH7c5bLycORuW+44CBFsc05veEUGbI3D
         SEsRCpSY113TpkvipzVl/LVePo9L6rbdmuyUEkcNW9fygoQSo9iK7IzxskC9OSBZwxYw
         VOvjMo7Sj5WbGp/U7O4Z1eEJQl6cNFsE8kaWbJQbds4EXd1tFMX4n91WdrCyPf6fJi3X
         XtEGh0fGhopqVATkBD7bf6x3Z97xq7r+DZRwS1LGYfCHXVpo3YgOSMQxnsWSFL2Jqd9A
         DCnw==
X-Gm-Message-State: AOJu0YyoZydtJnClX9736Lv8W/S0+X4raCEAlhaYx5Nms4Gvnwc0Gjhf
        RMHZ6ei4pg2Etbry8oBUVwmFALzkp7f2+w==
X-Google-Smtp-Source: AGHT+IEJnRIZ1RA+2A8XOGo4qJdGXnm7sLvGhrm0Oh2ZgRs2v30ncOfTStpL4pgYtbcwGDoCsAU2Qg==
X-Received: by 2002:adf:f7c9:0:b0:315:a32d:311f with SMTP id a9-20020adff7c9000000b00315a32d311fmr277540wrq.14.1692228225599;
        Wed, 16 Aug 2023 16:23:45 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:aeb8:832b:ebc0:1bbf])
        by smtp.gmail.com with ESMTPSA id q4-20020adff944000000b003143c9beeaesm22752617wrr.44.2023.08.16.16.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 16:23:44 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 1/3] riscv: dma-mapping: only invalidate after DMA, not flush
Date:   Thu, 17 Aug 2023 00:23:34 +0100
Message-Id: <20230816232336.164413-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816232336.164413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230816232336.164413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

No other architecture intentionally writes back dirty cache lines into
a buffer that a device has just finished writing into. If the cache is
clean, this has no effect at all, but if a cacheline in the buffer has
actually been written by the CPU,  there is a driver bug that is likely
made worse by overwriting that buffer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3
* No change

v1->v2
* Fixed typo drive->driver in commit message
* Included RB and ACKs
---
 arch/riscv/mm/dma-noncoherent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index d51a75864e53..94614cf61cdd 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -42,7 +42,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		break;
 	case DMA_FROM_DEVICE:
 	case DMA_BIDIRECTIONAL:
-		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+		ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
 		break;
 	default:
 		break;
-- 
2.34.1

