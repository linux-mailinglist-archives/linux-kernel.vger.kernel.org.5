Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E53375ABC8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjGTKRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGTKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:17:24 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E400B7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 03:17:22 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R67sW2fLqzBRDsV
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 18:17:19 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :subject:to:from:date:mime-version; s=dkim; t=1689848239; x=
        1692440240; bh=LxfpSJfL1V77NdEh9Dzlz3/ExUhcJbp14kqRmN4ha/0=; b=F
        LH62Zzg+TbiqpAVUsMbBmczTlQlOqjQdLQZ1Un++GYWC0RNcURKGfy3kU898lH7l
        J5rGK1XLE2UmY6PUGgtG5ty7LTMdy3QzLFo2LC7rVeViwVCknRuQv6dYuJK1PlDu
        NKkwAu3feWLUoQBYt0zOEHybQZktHtT0jJ7RsB+S2TsvHfZWMVrmsVPSW6U/VjD1
        MtWX9EzMsvEbPXOAvxrNBQKJhZjFNAT0vQGDSIfkP/kz9QHdmZCNCAXyzmWf5TNS
        qIkNbvHjn5a4NJAAo4qlapDhfe9RSol2pu0fBf7Y2uEL0OA3WGxVmQltkOSVzaQE
        hy1yGUBHZvBpj7Lg++izA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cKE8NkFVQpEB for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 18:17:19 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R67sW0k0MzBJqBL;
        Thu, 20 Jul 2023 18:17:19 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 18:17:15 +0800
From:   zhangyongle001@208suo.com
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] floppy: ERROR: that open brace { should be on the previous
 line
User-Agent: Roundcube Webmail
Message-ID: <058c3448e220ee16bcb5e588271b685c@208suo.com>
X-Sender: zhangyongle001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix twoce occurrences of the checkpatch.pl error:
ERROR: that open brace { should be on the previous line

Signed-off-by: zhangyongle <zhangyongle001@208suo.com>
---
  arch/powerpc/include/asm/floppy.h | 6 ++----
  1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/floppy.h 
b/arch/powerpc/include/asm/floppy.h
index f8ce178b43b7..1ae67d2629be 100644
--- a/arch/powerpc/include/asm/floppy.h
+++ b/arch/powerpc/include/asm/floppy.h
@@ -163,16 +163,14 @@ static int hard_dma_setup(char *addr, unsigned 
long size, int mode, int io)
  	return 0;
  }

-static struct fd_dma_ops real_dma_ops =
-{
+static struct fd_dma_ops real_dma_ops = {
  	._disable_dma = disable_dma,
  	._free_dma = free_dma,
  	._get_dma_residue = get_dma_residue,
  	._dma_setup = hard_dma_setup
  };

-static struct fd_dma_ops virt_dma_ops =
-{
+static struct fd_dma_ops virt_dma_ops = {
  	._disable_dma = vdma_disable_dma,
  	._free_dma = vdma_nop,
  	._get_dma_residue = vdma_get_dma_residue,
-- 
2.40.1

