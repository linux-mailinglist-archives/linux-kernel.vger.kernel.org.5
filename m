Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9179475A606
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGTGIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjGTGI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:08:29 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345071985
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:08:27 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R62LG6jwgzBRDs8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:08:22 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689833302; x=1692425303; bh=CqFzjHxcc+z7cjMF9hVel9FQGh2
        4WWb7acalQVdNRLc=; b=FDOvXPBWw/mdXWUuhkew6q4wQjgB56VxGybU1/u3Dzt
        iewh8G24qfgvgl636npqGTI8AmPOpzadVSCBD2naYwkp2ip9JcPeXOUrRlVG01Ey
        u7RmBD6ot2q1+QDJkVe5DLeAMaL1/pnGggmrGMlnd7Fr+5970o/D1Xxf4GOKY6ib
        RjNiepea9QHHnQJCGJ0106eJAwE/zo1zfJX2fvNlkAsWDSlNW8iutSyFQbvA4/qX
        MLgmxbYZMvkErcbXXbpJaAnohBELYZSRtiDkXV02l6KNdfhUnhX6TCHBvNsROfj0
        jh73dklUwZuHbOMuGbZDo5Ux+mMgTt/R6B6h4e3irig==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IJvXve9wuEaF for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 14:08:22 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R62LG35wXzBR1P6;
        Thu, 20 Jul 2023 14:08:22 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 14:08:22 +0800
From:   sunran001@208suo.com
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aic7xxx: add missing spaces before '(' and after '!='
In-Reply-To: <20230720060342.2381-1-xujianghui@cdjrlc.com>
References: <20230720060342.2381-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <178634b2c91aa1441a6d0eb2fcb4da36@208suo.com>
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

Add missing spaces to clear checkpatch errors.

ERROR: space required before the open parenthesis '('
ERROR: spaces required around that '!=' (ctx:WxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c | 18 +++++++++---------
  1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c 
b/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c
index c8170bbd67da..6c06e3652e85 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c
@@ -87,7 +87,7 @@ symbol_delete(symbol_t *symbol)
  		key.size = strlen(symbol->name);
  		symtable->del(symtable, &key, /*flags*/0);
  	}
-	switch(symbol->type) {
+	switch (symbol->type) {
  	case SCBLOC:
  	case SRAMLOC:
  	case REGISTER:
@@ -183,7 +183,7 @@ symtable_get(char *name)
  			data.data = &new_symbol;
  			data.size = sizeof(new_symbol);
  			if (symtable->put(symtable, &key, &data,
-					  /*flags*/0) !=0) {
+					  /*flags*/0) != 0) {
  				perror("Symtable put failed");
  				exit(EX_SOFTWARE);
  			}
@@ -197,7 +197,7 @@ symtable_get(char *name)
  	memcpy(&stored_ptr, data.data, sizeof(stored_ptr));
  	stored_ptr->count++;
  	data.data = &stored_ptr;
-	if (symtable->put(symtable, &key, &data, /*flags*/0) !=0) {
+	if (symtable->put(symtable, &key, &data, /*flags*/0) != 0) {
  		perror("Symtable put failed");
  		exit(EX_SOFTWARE);
  	}
@@ -210,7 +210,7 @@ symlist_search(symlist_t *symlist, char *symname)
  	symbol_node_t *curnode;

  	curnode = SLIST_FIRST(symlist);
-	while(curnode != NULL) {
+	while (curnode != NULL) {
  		if (strcmp(symname, curnode->symbol->name) == 0)
  			break;
  		curnode = SLIST_NEXT(curnode, links);
@@ -234,7 +234,7 @@ symlist_add(symlist_t *symlist, symbol_t *symbol, 
int how)
  		int field;

  		field = FALSE;
-		switch(symbol->type) {
+		switch (symbol->type) {
  		case REGISTER:
  		case SCBLOC:
  		case SRAMLOC:
@@ -314,7 +314,7 @@ symlist_merge(symlist_t *symlist_dest, symlist_t 
*symlist_src1,
  	symbol_node_t *node;

  	*symlist_dest = *symlist_src1;
-	while((node = SLIST_FIRST(symlist_src2)) != NULL) {
+	while ((node = SLIST_FIRST(symlist_src2)) != NULL) {
  		SLIST_REMOVE_HEAD(symlist_src2, links);
  		SLIST_INSERT_HEAD(symlist_dest, node, links);
  	}
@@ -492,7 +492,7 @@ symtable_dump(FILE *ofile, FILE *dfile)
  		symbol_t *cursym;

  		memcpy(&cursym, data.data, sizeof(cursym));
-		switch(cursym->type) {
+		switch (cursym->type) {
  		case REGISTER:
  		case SCBLOC:
  		case SRAMLOC:
@@ -538,7 +538,7 @@ symtable_dump(FILE *ofile, FILE *dfile)
  		if (curnode->symbol->dont_generate_debug_code)
  			continue;

-		switch(curnode->symbol->type) {
+		switch (curnode->symbol->type) {
  		case REGISTER:
  		case SCBLOC:
  		case SRAMLOC:
@@ -606,7 +606,7 @@ symtable_dump(FILE *ofile, FILE *dfile)

  		curnode = SLIST_FIRST(&registers);
  		SLIST_REMOVE_HEAD(&registers, links);
-		switch(curnode->symbol->type) {
+		switch (curnode->symbol->type) {
  		case REGISTER:
  		case SCBLOC:
  		case SRAMLOC:
