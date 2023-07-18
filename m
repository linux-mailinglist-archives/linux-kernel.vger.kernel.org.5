Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DF7757809
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjGRJa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjGRJaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:30:52 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA9A186
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:30:50 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4twj6jkMzBR1P1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:30:45 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689672645; x=1692264646; bh=4gedVbL7S7MH4j3jlvs633IMoV8
        +4e8hGBJoYgg3gIY=; b=aDyPUMWBFZTU9DxX0RElDmf01O02AIui4LgO1PYkPKW
        JYvRBoKx8nvgC3sdwHw5gBXs/eKsldFl19E2bftcG0MHUlCYxnLEOF8P85fqY7KD
        qrqoTQuV9nMUpO8S76jk454dM01BuXXnQ2LOvC8eFPpkf4/bhJ+YcXC6Y2/kWjYd
        SImy8Z0hm6rkSWnXU+TLdqKTGSiZQJNFWDLUuVgym3xyjJAr3qpOL4g0Ebh9D6sq
        sNxbD3nh03Qj0Pv0lMdhASAy9nEmSqiVhGPs5sHLXlyLF7T8bGcTUdKvu/PntkG/
        zF+tOfstGQo3ofbUlfJxdf/HptfT7rsKM3HGncnjBFw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tMEbL0vbIm3G for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 17:30:45 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4twj562VzBJBfd;
        Tue, 18 Jul 2023 17:30:45 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 17:30:45 +0800
From:   hanyu001@208suo.com
To:     dlemoal@kernel.org, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: "foo * bar" should be "foo *bar"
In-Reply-To: <tencent_B3697156112E542F68C876BB0362BE18A905@qq.com>
References: <tencent_B3697156112E542F68C876BB0362BE18A905@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <28f4481572293230e84275db48a69462@208suo.com>
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

This patch fixes the checkpatch.pl error:

./drivers/ata/pata_serverworks.c:305: ERROR: "foo * bar" should be "foo 
*bar"

Signed-off-by: 	Yu Han <hanyu001@208suo.com>
---
  drivers/ata/pata_serverworks.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_serverworks.c 
b/drivers/ata/pata_serverworks.c
index 549ff24..b348784 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -302,7 +302,7 @@ static int serverworks_fixup_csb(struct pci_dev 
*pdev)

      /* Third Channel Test */
      if (!(PCI_FUNC(pdev->devfn) & 1)) {
-        struct pci_dev * findev = NULL;
+        struct pci_dev *findev = NULL;
          u32 reg4c = 0;
          findev = pci_get_device(PCI_VENDOR_ID_SERVERWORKS,
              PCI_DEVICE_ID_SERVERWORKS_CSB5, NULL);
