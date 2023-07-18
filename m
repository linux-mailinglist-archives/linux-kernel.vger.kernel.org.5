Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103FC75771C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjGRIxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjGRIxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:53:22 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C7E173C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:53:14 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4t5J4H0CzBR9sm
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:53:08 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689670388; x=1692262389; bh=NNqVhTvojOR5CkC0Xg6gNOBnmFc
        On8HQuCGNUFBgEwc=; b=dEq5BbKjUbbKCiBCpcQW/Yd0xYj4PVw90T5OSRiW1Tz
        VYQAMr1dHfKYuAaIZwUzP2J3Std7JLM2LWHRsZh+/N2I6PofpoabYFMI0yRQVKBO
        anRrLxK9eSda4II6xLOx4b5fS1e00cIZTxyQnIncYSh9fYNnRqRbvJ/Py9a8R4FO
        00bjgRnS9HkCwmRWTUyTIu8LRFoDrv1Bs7I2uwilx7qF+PzjbXedpQLf6CBLc574
        6WK+HkjxeOd40fzADV0s9dacsgkuoTvtzVwv4p7mf8FhkxHjXOwWR4jhFljZN2hn
        /wiataYnTWoJsTYgEBsLJSazgpp/8W4oG86kR9sIFVQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VBE-6jgVAvmg for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 16:53:08 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4t5J2VSLzBR7bp;
        Tue, 18 Jul 2023 16:53:08 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 16:53:08 +0800
From:   hanyu001@208suo.com
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: remove whitespace after '(' and before ')'
In-Reply-To: <tencent_6714ED434F83826DD33A8EE7B99064165309@qq.com>
References: <tencent_6714ED434F83826DD33A8EE7B99064165309@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <07f7ac9c59d027f959a69836fee9940c@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch errors:

./drivers/ata/pata_sis.c:691: ERROR: space prohibited after that open 
parenthesis '('
./drivers/ata/pata_sis.c:691: ERROR: space prohibited before that close 
parenthesis ')'

Signed-off-by: Yu Han <	hanyu001@208suo.com>
---
  drivers/ata/pata_sis.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 31de06b..2019777 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -688,7 +688,7 @@ static void sis_fixup(struct pci_dev *pdev, struct 
sis_chipset *sis)

      if (sis->info == &sis_info33) {
          pci_read_config_byte(pdev, PCI_CLASS_PROG, &reg);
-        if (( reg & 0x0F ) != 0x00)
+        if ((reg & 0x0F) != 0x00)
              pci_write_config_byte(pdev, PCI_CLASS_PROG, reg & 0xF0);
          /* Fall through to ATA16 fixup below */
      }
