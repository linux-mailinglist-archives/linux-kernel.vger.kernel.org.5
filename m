Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC67975AB8B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjGTJ5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGTJ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:57:32 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41366AA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:57:31 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R67Qc4fh4zBRDsb
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 17:57:28 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689847048; x=1692439049; bh=Byn4fG+l3+wgeKB6vOCQHYXNjBM
        M0bYlNp8Mj7rgedE=; b=gNGnKqORVcaZ1xhOD3iSAnNzJjbMIXOlcKoh7PINSa+
        kbtTz9uIRK3pYRg1GE59N6qeZsC+ccyxrmCSHzuNWQkRmStGKyD30l8iGcTcGFeV
        4VCUd18xxKgj2Yktt3j5ZjzbPAVto3ERX64k/iAGe9Wz7NYsyvVHdJf1qnkvuneX
        VMMRLx6vHMoBXY4zDMhR/S1Fy1TxsURhGogCYmhEQLSYWrd92DthIcxum0Hhx1v8
        CwVx+EQuO2R1mGCVAlz0G236YVGPTDanFMptXOE2E3ZW8kKCe9x6AF4qrBTqdW+c
        IrC8ZN2Bo6ytbMaal7AFcI5FYbeNuaBnVH/fZOywaaA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id e8RRTPJV1VZK for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 17:57:28 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R67Qc2pNPzBRDsS;
        Thu, 20 Jul 2023 17:57:28 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 17:57:28 +0800
From:   sunran001@208suo.com
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.co
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aic7xxx: avoid checkpatch error
In-Reply-To: <20230720095619.3954-1-xujianghui@cdjrlc.com>
References: <20230720095619.3954-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <4d48377ca4e62a71f89e4de6f80e6725@208suo.com>
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

ERROR: do not initialise statics to NULL

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/scsi/aic7xxx/aic7xxx_osm.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c 
b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index d3b1082654d5..c062bf27b55a 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -124,7 +124,7 @@
  #include "aic7xxx_inline.h"
  #include <scsi/scsicam.h>

-static struct scsi_transport_template *ahc_linux_transport_template = 
NULL;
+static struct scsi_transport_template *ahc_linux_transport_template;

  #include <linux/init.h>		/* __setup */
  #include <linux/mm.h>		/* For fetching system memory size */
@@ -325,7 +325,7 @@ static uint32_t aic7xxx_periodic_otag;
  /*
   * Module information and settable options.
   */
-static char *aic7xxx = NULL;
+static char *aic7xxx;

  MODULE_AUTHOR("Maintainer: Hannes Reinecke <hare@suse.de>");
  MODULE_DESCRIPTION("Adaptec AIC77XX/78XX SCSI Host Bus Adapter 
driver");
