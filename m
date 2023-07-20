Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A7E75A5EA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjGTFzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGTFzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:55:42 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D7392
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:55:37 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R623N2KKdzBRDsD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 13:55:28 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689832526; x=1692424527; bh=s7dX9DPq+huLER3GBSvz83Ncmxd
        j4J4K+dRUh1SvFEg=; b=XyesGWKiMom3V9F7jAHXceJdLtUojI2hljPlb7LdDd7
        +PWXjrZpmcbLWnzHBCs3mM/KFVoStEmY4Ag/OPjGhlLcAxOWoL/QhrJmTB3lBCIF
        y0VHhajzBKZP3xPbBRx/jyzXzSuBA3K9EHO8Can3p/Y2TsCDdi0OlqJYkGLChVNh
        I9RuAbe0+RUpHQ2Yh1Jh02f1tOCNPeAeKuwvByc1ZB8DdJ479NcuvhzcZ4ECDi8B
        sHToOVVY5ngc5ToeLr1BPnJd05XrDoT8ym1pDgaUydJ2zHQc8QQ8U4ea+O+G/C2X
        Bvti1ttz6orDdG/7ToT+7/eDBmCu+SOr+VIPpG4dy1g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ldFOGPVp_yh3 for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 13:55:26 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R623L4b1czBR1P6;
        Thu, 20 Jul 2023 13:55:26 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 13:55:26 +0800
From:   sunran001@208suo.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aic7xxx: Remove unnecessary parentheses in hyperv.h
In-Reply-To: <20230720055410.2271-1-xujianghui@cdjrlc.com>
References: <20230720055410.2271-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <25cd9e8299995ff3c35379221b7f0270@208suo.com>
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
  drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c 
b/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c
index 975fcfcc0d8f..c8170bbd67da 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c
@@ -74,7 +74,7 @@ symbol_create(char *name)
  		 stop("Unable to strdup symbol name", EX_SOFTWARE);
  	new_symbol->type = UNINITIALIZED;
  	new_symbol->count = 1;
-	return (new_symbol);
+	return new_symbol;
  }

  void
