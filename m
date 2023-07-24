Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCE775E5E3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 02:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjGXAko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 20:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGXAkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 20:40:42 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758F010D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 17:40:39 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R8LtC2g3VzBRDtQ
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:40:35 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690159233; x=1692751234; bh=QsKucN7um2wSg3VJdhbboiTHbpM
        KyR824zes2RdZRmg=; b=jrvLEplgI2k471PCIotvecCPXML3Rsp0FqmHVQPNTaR
        l2EePHZWp4lsDp6fHVXTU24lXNimnBdA2flNoOnn0p9R/TgE48QMCIJv1psYrDna
        FUyK5QOPq+ftC+DCuvhJ3DpmwkFG9Z/4RAuKEKGVLUFATcCTnm5WvWYgOsz5e3bO
        J/Oe5FOfx1+YvmKZPC9pTTXpVmFqHsCE+UKLh1Cul/8TvuvboCEb2cTlXTOsPOdr
        6seKnQPjXdvx6jnQqvxwG61QuRSRzyg0HdLQdUjQE5OLv/557fHNCW8+Cexns+6v
        Cq88bCX4Ho9LmuJteDX0whSvXXO53a2UjSY+ZAAZ9Ug==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hmFDdMd7THz8 for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jul 2023 08:40:33 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R8Lt90TqHzBRDsK;
        Mon, 24 Jul 2023 08:40:33 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 08:40:32 +0800
From:   huzhi001@208suo.com
To:     gerg@linux-m68k.org, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] m68knommu: Fix warnings in io_no.h: Delete one of repeated
 word 'readw readl writew writel' in comment. WARNING: Possible repeated word:
 'readw' WARNING: Possible repeated word: 'readl' WARNING: Possible repeated
 word: 'writew' WARNING: Possible repeated word: 'writel'
In-Reply-To: <tencent_816D5035481D1083943D8E965A59860D5E06@qq.com>
References: <tencent_816D5035481D1083943D8E965A59860D5E06@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <9e13fec02524afde21bdf5783dcf7246@208suo.com>
X-Sender: huzhi001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  arch/m68k/include/asm/io_no.h | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/include/asm/io_no.h 
b/arch/m68k/include/asm/io_no.h
index 2c96e8480173..b24eb741e666 100644
--- a/arch/m68k/include/asm/io_no.h
+++ b/arch/m68k/include/asm/io_no.h
@@ -62,7 +62,7 @@ static int cf_internalio(const volatile void __iomem 
*addr)
   * endian on m68k/ColdFire. Bus based address ranges, like the PCI bus,
   * are accessed little endian - so we need to byte swap those.
   */
-#define readw readw
+#define readw
  static inline u16 readw(const volatile void __iomem *addr)
  {
      if (cf_internalio(addr))
@@ -70,7 +70,7 @@ static inline u16 readw(const volatile void __iomem 
*addr)
      return swab16(__raw_readw(addr));
  }

-#define readl readl
+#define readl
  static inline u32 readl(const volatile void __iomem *addr)
  {
      if (cf_internalio(addr))
@@ -78,7 +78,7 @@ static inline u32 readl(const volatile void __iomem 
*addr)
      return swab32(__raw_readl(addr));
  }

-#define writew writew
+#define writew
  static inline void writew(u16 value, volatile void __iomem *addr)
  {
      if (cf_internalio(addr))
@@ -87,7 +87,7 @@ static inline void writew(u16 value, volatile void 
__iomem *addr)
          __raw_writew(swab16(value), addr);
  }

-#define writel writel
+#define writel
  static inline void writel(u32 value, volatile void __iomem *addr)
  {
      if (cf_internalio(addr))
