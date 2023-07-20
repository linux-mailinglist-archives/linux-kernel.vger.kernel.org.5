Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867F575AA99
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGTJ0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGTJ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:26:20 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B599030EC0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:09:58 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R66Mg5fszzBRDrK
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 17:09:51 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689844191; x=1692436192; bh=ZXcpy+AEoHMva1uuc2MXgOHxjIp
        1WDQ9VhZyfCsAByU=; b=LRWBOa7zssXRIuySv1T8BGMZIPFvmhNs5RMcaY1xNhr
        ktOWDhFjz82mfdMy3q2GStURre1II3T3PBXY82xxtbaPIgRtOSuLSr3Jj2Ilf/au
        zyo70ZV8dhXh6pZZTY6i/hTbhWJnjq1GSFpyptVGy3ihR5VVU/vfDIYkvmixOHJX
        6K4CFZ4roaWInsFdLMta1nDQVmVkRyn/wHZkpTNa+c+lolb9cENZr94tjFl60VxU
        +00InB08cmJ2Ek1c3LvcGVGY189nGTK7L33Yta8XMMqgL/FjsHPtUuXC4f5kAyU4
        TbcNztR2F52NyMqSavtdiDVzcMDA5gpSJ+9VK5m/IQg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z4uPALwymecB for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 17:09:51 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R66Mg3XpVzBHXhQ;
        Thu, 20 Jul 2023 17:09:51 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 17:09:51 +0800
From:   sunran001@208suo.com
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aic7xxx: aic79xx: Remove unnecessary parentheses
In-Reply-To: <20230720090839.3506-1-xujianghui@cdjrlc.com>
References: <20230720090839.3506-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <5663619f5f713c1ad99efbb8fa53bbb1@208suo.com>
X-Sender: sunran001@208suo.com
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

Fix "return is not a function, parentheses are not required" checkpatch
error.

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/scsi/aic7xxx/aic7xxx_93cx6.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_93cx6.c 
b/drivers/scsi/aic7xxx/aic7xxx_93cx6.c
index 11ddffbcc2f3..0d3c33322eb5 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_93cx6.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_93cx6.c
@@ -236,7 +236,7 @@ ahc_write_seeprom(struct seeprom_descriptor *sd, 
uint16_t *buf,
  	} else {
  		printk("ahc_write_seeprom: unsupported seeprom type %d\n",
  		       sd->sd_chip);
-		return (0);
+		return 0;
  	}

  	send_seeprom_cmd(sd, ewen);
@@ -292,7 +292,7 @@ ahc_write_seeprom(struct seeprom_descriptor *sd, 
uint16_t *buf,
  	send_seeprom_cmd(sd, ewds);
  	reset_seeprom(sd);

-	return (1);
+	return 1;
  }

  int
@@ -311,8 +311,8 @@ ahc_verify_cksum(struct seeprom_config *sc)
  		checksum = checksum + scarray[i];
  	if (checksum == 0
  	 || (checksum & 0xFFFF) != sc->checksum) {
-		return (0);
+		return 0;
  	} else {
-		return(1);
+		return 1;
  	}
  }
