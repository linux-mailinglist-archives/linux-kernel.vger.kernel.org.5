Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F15D75A72F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjGTHFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjGTHEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:04:49 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07E42694
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:04:46 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R63bJ04tbzBRDsL
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:04:44 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689836683; x=1692428684; bh=SxLz4ao45O0X+YIy2ts9PRzhG/I
        MbOXt0lftUDMW3CY=; b=fz6GN0/PVIdFqIlpxgKXAwmTl9RyDuwirgrwxpMHFYK
        IZHzhqagujSDNhdipwc7jfiKQwR8Ye5qTlPWGqi0avJRyuLm5yBGTTklbUyEIc+g
        3qse0WVIluzrj5JYg+QQhHjWZHSXfR533+C3QRy7CoEyGetwQAB09Li9DUZW3New
        c+fSHzepb9h8AkP9inYnPLGSBtMdLcSgN8Q8wwjlCQl3bRRTBYF+osQkVUTua39l
        UrtIJTrf2AeOS1ymIsYA0O5I85f7QZ4yXgBrLdC2ni0aNP+43jxELCj2KJuTARbf
        kPpPUVCT0kUxBEhdjlnkQHC2PZ6rSry73FNKe2iRI3A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZIIpkFcPRLHY for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 15:04:43 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R63bH5Fn3zBRDsD;
        Thu, 20 Jul 2023 15:04:43 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 15:04:43 +0800
From:   sunran001@208suo.com
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aic7xxx: Remove unnecessary parentheses in hyperv.h
In-Reply-To: <20230720070343.2926-1-xujianghui@cdjrlc.com>
References: <20230720070343.2926-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <9bfa0761de4afcb66fb56b46671c54be@208suo.com>
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
  drivers/scsi/aic7xxx/aic7770_osm.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7770_osm.c 
b/drivers/scsi/aic7xxx/aic7770_osm.c
index bdd177e3d762..cfaf3ac29d79 100644
--- a/drivers/scsi/aic7xxx/aic7770_osm.c
+++ b/drivers/scsi/aic7xxx/aic7770_osm.c
@@ -54,7 +54,7 @@ aic7770_map_registers(struct ahc_softc *ahc, u_int 
port)
  		return (ENOMEM);
  	ahc->tag = BUS_SPACE_PIO;
  	ahc->bsh.ioport = port;
-	return (0);
+	return 0;
  }

  int
@@ -97,13 +97,13 @@ aic7770_probe(struct device *dev)
  	if (error != 0) {
  		ahc->bsh.ioport = 0;
  		ahc_free(ahc);
-		return (error);
+		return error;
  	}

   	dev_set_drvdata(dev, ahc);

  	error = ahc_linux_register_host(ahc, &aic7xxx_driver_template);
-	return (error);
+	return error;
  }

  static int
