Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD0275A76C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjGTHL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjGTHLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:11:33 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6761B3595
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:10:27 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R63jn0tqVzBRDsQ
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:10:21 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689837020; x=1692429021; bh=KFPxENNW0VwHdPoTYLfLgku/l1a
        nuBYSc4ixw/H739o=; b=CYUP4KkLpq4LLZ6bFzM7oBFXvtKLCg6jaK0g7G+lddi
        dpSAg9Yx8Wxa6MAy/MKHGAHimj4bK66fhDPy0gYKXPFFg67pWEi8aISI8sJyybXh
        UAJGtMD8dpNhhGXrN1sjaw4K767745mJ6LzOiJVpoxyIFIZ3x69CtVFP0ozAY1N1
        VJWu+ycvAHEziphNkCRTCDR9FwZuWiiUmxPcGl2QLMIViVLEf9fJ7LpUvBgRtfkz
        wzRbGyydHDGciVaPaW6J2l5ESUcjPherAET4mhTZ0c5fQs2UnNhIfik5gk4jlUDN
        Q1X5eONciO4w0NNJTmsoTAVtuDinQXCViJObBhPUv9Q==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zuuwni8Igy05 for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 15:10:20 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R63jm5JymzBRDsD;
        Thu, 20 Jul 2023 15:10:20 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 15:10:20 +0800
From:   sunran001@208suo.com
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [SCSI] aic7xxx: Remove unnecessary parentheses in hyperv.h
In-Reply-To: <20230720070717.3013-1-xujianghui@cdjrlc.com>
References: <20230720070717.3013-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <999e85cf01a7117c2c968831ec703730@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "return is not a function, parentheses are not required" checkpatch
error.

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/scsi/aic7xxx/aic79xx_inline.h | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_inline.h 
b/drivers/scsi/aic7xxx/aic79xx_inline.h
index 09335a3c8691..7644e3d2ec22 100644
--- a/drivers/scsi/aic7xxx/aic79xx_inline.h
+++ b/drivers/scsi/aic7xxx/aic79xx_inline.h
@@ -50,7 +50,7 @@ static inline char *ahd_name(struct ahd_softc *ahd);

  static inline char *ahd_name(struct ahd_softc *ahd)
  {
-	return (ahd->name);
+	return ahd->name;
  }

  /************************ Sequencer Execution Control 
*************************/
@@ -157,13 +157,13 @@ do {								\
  static inline uint8_t *
  ahd_get_sense_buf(struct ahd_softc *ahd, struct scb *scb)
  {
-	return (scb->sense_data);
+	return scb->sense_data;
  }

  static inline uint32_t
  ahd_get_sense_bufaddr(struct ahd_softc *ahd, struct scb *scb)
  {
-	return (scb->sense_busaddr);
+	return scb->sense_busaddr;
  }

  /************************** Interrupt Processing 
******************************/
