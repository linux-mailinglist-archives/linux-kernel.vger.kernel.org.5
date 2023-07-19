Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4611C759B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGSQk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjGSQkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:40:21 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56A713E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:40:20 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5gcL050rzBSlPv
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:04:17 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689782657; x=1692374658; bh=PUla6YxRk64OglOS2131UVbMHa5
        6/2XtLAw2enOh0Fc=; b=JPiYaVEzgEobsenkfu2d7RakUKYy6Pdo9I4ckhgjCKl
        TY3oqGL5b2eMhKTH74EjwwG75Fz2E57KPHM6E14dU7R2mS0/xfaP/wh0WLY5ChoE
        JP4CBI7hQ5ZaSQKxiRN9pOozN9erj9yT8LxdIGZ/tUYROtUmuIrJ9jzCrFIVF4zM
        3stuFAtL5dyxY7UwRc4qQ8j5SMLxE4Jddw/BfxXp6HVoC+Tl+1M5oN5NG2H2G1ns
        k0p3J+hePtmaR6Cn4gPHNvRnS6+yalGO2GfWlDgEmRkjLpop7QBsTlCsVfI1Wbu3
        gp3teA35n7fDAyZ3adzzSBxIYujFIRtUJc1t2RAb7mw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0_37KiBtFVJt for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 00:04:17 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5RJz4159zD3hf8;
        Wed, 19 Jul 2023 14:50:11 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 14:50:11 +0800
From:   sunran001@208suo.com
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] napi: remove spaces after '('
In-Reply-To: <20230719032953.18679-1-xujianghui@cdjrlc.com>
References: <20230719032953.18679-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <f9128b6d2307a4a53904930cae864dcc@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_INVALID,DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix four occurrences of the checkpatch error:

ERROR: space prohibited after that open parenthesis '('

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  include/trace/events/napi.h | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/napi.h b/include/trace/events/napi.h
index 6678cf8b235b..98fb9e0d2219 100644
--- a/include/trace/events/napi.h
+++ b/include/trace/events/napi.h
@@ -18,10 +18,10 @@ TRACE_EVENT(napi_poll,
  	TP_ARGS(napi, work, budget),

  	TP_STRUCT__entry(
-		__field(	struct napi_struct *,	napi)
-		__string(	dev_name, napi->dev ? napi->dev->name : NO_DEV)
-		__field(	int,			work)
-		__field(	int,			budget)
+		__field(struct napi_struct *, napi)
+		__string(dev_name, napi->dev ? napi->dev->name : NO_DEV)
+		__field(int, work)
+		__field(int, budget)
  	),

  	TP_fast_assign(
