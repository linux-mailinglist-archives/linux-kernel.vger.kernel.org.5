Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B0C75A629
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGTGRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjGTGQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:16:58 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154C51BF2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:16:57 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R62X65mRzzBRDsB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:16:54 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689833814; x=1692425815; bh=lJ2z1PnaNM6Y2Mn1zwiU8mdSCQy
        pr99a1vck88s3bIM=; b=SByFtHhZptFIIvUl2eh07ulhGO/QPCKByzYmD7qqxGe
        VwhJ9kL1jPg2MQKPDUIHpsNpn4kvrKPYYiWVJQCcLh2h8dxnipuWhUx6GaCBZi5W
        jIebCLxBwkmh5yPu1scO4JFfJiyBxjlAQzN3QTrss8wDzXUh9W+/+lGTpBwyaC2s
        CF4ofZ4A3FZV3bzs9+JS1FQ7HTFAs3cWK9g3PtTRw9yIda40qj6LD0IX2206kh+e
        V/a/ON3unNSqL6fP95Yu4LzXeLy1exuEMp/RVa5R1OL2z8gDcvbpzV+gvGdIezo3
        o9hgSCkAUkB/QCuDd07K0f7H4lEcxisGtmzUulSwgWw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3K-XVBkviTeX for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 14:16:54 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R62X63mFGzBR1P6;
        Thu, 20 Jul 2023 14:16:54 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 14:16:54 +0800
From:   sunran001@208suo.com
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aic7xxx: "foo* bar" should be "foo *bar"
In-Reply-To: <20230720061553.2523-1-xujianghui@cdjrlc.com>
References: <20230720061553.2523-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <035e4317991f34f20b8dfec0c574ec0f@208suo.com>
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

ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h 
b/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h
index ed3bdd43c297..ec4eae41418a 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h
@@ -65,7 +65,7 @@ typedef enum {
  	RO = 0x01,
  	WO = 0x02,
  	RW = 0x03
-}amode_t;
+} amode_t;

  typedef SLIST_HEAD(symlist, symbol_node) symlist_t;

@@ -113,7 +113,7 @@ STAILQ_HEAD(macro_arg_list, macro_arg);
  struct macro_info {
  	struct macro_arg_list args;
  	int   narg;
-	const char* body;
+	const char *body;
  };

  typedef struct expression_info {
