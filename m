Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876AA75AAFC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGTJhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGTJhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:37:04 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB3F3AB8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:32:14 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R66rG1K8YzBRDsV
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 17:31:10 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689845470; x=1692437471; bh=Rn7Xlh1oIvUwUEDMLuoY1G5XCcn
        PCbkmV3qgyrjXcqk=; b=A0rk/YPmDtPgyn4R1R3XyW5eStfBWLRMiRqe6ygATPQ
        eNrgV8VZFd4tYzgvN0tWIAS8jXSvU0RmCzuFsk7SxGFmqbACv8JqxdpZbcubB3uI
        OI+y3U968qacY/FAc34sT0oV+8txSKeNPw0M5L8s/vtqscI+qyzgsPowYp8dXerr
        VM457S5c160R/h5QVZuTeJXoBd8QI20VrVsZYHPCDl2ZKOz6QdBntjxM1JEwoYwn
        FJUsSkI/GpGMbk1PaahyGSeEZhtso/Sm3v5NMdBGM8C0JW4lsqs41A35wEmrfKai
        xjApZePWgZxlSWoJMKomaBQSSwRyXCoSqMSf4siTrxA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GwZDQ0DQd-D3 for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 17:31:10 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R66rF6NykzBHXhQ;
        Thu, 20 Jul 2023 17:31:09 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 17:31:09 +0800
From:   sunran001@208suo.com
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aic7xxx: fix the following errors
In-Reply-To: <20230720092958.3730-1-xujianghui@cdjrlc.com>
References: <20230720092958.3730-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <047fe06a541e4cc69e5f22b8b2cb33b5@208suo.com>
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

ERROR: space required before the open parenthesis '('
ERROR: return is not a function, parentheses are not required
ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/scsi/aic7xxx/aic7770.c | 23 +++++++++++------------
  1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7770.c 
b/drivers/scsi/aic7xxx/aic7770.c
index 176704b24e6a..21f3ef4ac230 100644
--- a/drivers/scsi/aic7xxx/aic7770.c
+++ b/drivers/scsi/aic7xxx/aic7770.c
@@ -59,8 +59,7 @@ static ahc_device_setup_t ahc_aic7770_VL_setup;
  static ahc_device_setup_t ahc_aic7770_EISA_setup;
  static ahc_device_setup_t ahc_aic7770_setup;

-struct aic7770_identity aic7770_ident_table[] =
-{
+struct aic7770_identity aic7770_ident_table[] = {
  	{
  		ID_AHA_274x,
  		0xFFFFFFFF,
@@ -237,11 +236,11 @@ aic7770_config(struct ahc_softc *ahc, struct 
aic7770_identity *entry, u_int io)
  	 */
  	error = ahc_init(ahc);
  	if (error != 0)
-		return (error);
+		return error;

  	error = aic7770_map_int(ahc, irq);
  	if (error != 0)
-		return (error);
+		return error;

  	ahc->init_level++;

@@ -249,7 +248,7 @@ aic7770_config(struct ahc_softc *ahc, struct 
aic7770_identity *entry, u_int io)
  	 * Enable the board's BUS drivers
  	 */
  	ahc_outb(ahc, BCTL, ENABLE);
-	return (0);
+	return 0;
  }

  static int
@@ -259,7 +258,7 @@ aic7770_chip_init(struct ahc_softc *ahc)
  	ahc_outb(ahc, BUSTIME, ahc->bus_softc.aic7770_softc.bustime);
  	ahc_outb(ahc, SBLKCTL, ahc_inb(ahc, SBLKCTL) & ~AUTOFLUSHDIS);
  	ahc_outb(ahc, BCTL, ENABLE);
-	return (ahc_chip_init(ahc));
+	return ahc_chip_init(ahc);
  }

  /*
@@ -294,7 +293,7 @@ aha2840_load_seeprom(struct ahc_softc *ahc)
  	if (have_seeprom) {

  		if (ahc_verify_cksum(sc) == 0) {
-			if(bootverbose)
+			if (bootverbose)
  				printk ("checksum error\n");
  			have_seeprom = 0;
  		} else if (bootverbose) {
@@ -317,7 +316,7 @@ aha2840_load_seeprom(struct ahc_softc *ahc)

  		max_targ = (ahc->features & AHC_WIDE) != 0 ? 16 : 8;
  		discenable = 0;
-		for (i = 0; i < max_targ; i++){
+		for (i = 0; i < max_targ; i++) {
  			uint8_t target_settings;

  			target_settings = (sc->device_flags[i] & CFXFER) << 4;
@@ -348,7 +347,7 @@ aha2840_load_seeprom(struct ahc_softc *ahc)
  		if (sc->adapter_control & CF284XSTERM)
  			ahc->flags |= AHC_TERM_ENB_A;
  	}
-	return (have_seeprom);
+	return have_seeprom;
  }

  static int
@@ -358,7 +357,7 @@ ahc_aic7770_VL_setup(struct ahc_softc *ahc)

  	error = ahc_aic7770_setup(ahc);
  	ahc->chip |= AHC_VL;
-	return (error);
+	return error;
  }

  static int
@@ -368,7 +367,7 @@ ahc_aic7770_EISA_setup(struct ahc_softc *ahc)

  	error = ahc_aic7770_setup(ahc);
  	ahc->chip |= AHC_EISA;
-	return (error);
+	return error;
  }

  static int
@@ -381,5 +380,5 @@ ahc_aic7770_setup(struct ahc_softc *ahc)
  	ahc->bugs |= AHC_TMODE_WIDEODD_BUG;
  	ahc->flags |= AHC_PAGESCBS;
  	ahc->instruction_ram_size = 448;
-	return (0);
+	return 0;
  }
