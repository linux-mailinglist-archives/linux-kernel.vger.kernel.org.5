Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0C5759AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGSQg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGSQgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:36:22 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06918210E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:36:02 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5ghG6kkjzBRYmT
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:07:42 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689782862; x=1692374863; bh=aYX+9YVsvT7Z8Ux2Z6JeV66JjGS
        PhhvfeeawkGuzLSg=; b=qfvmBrRAWhZxsnCvVal7qlfcPebN5AhVnM2qP01ILfc
        dz31TP4kyC3o6+fiEy7PqyoKn6vW4AFPnr/k/M7Eg0e/mws2pciXjTCp/EHpNqka
        fB9vSuNd7y7Wja3CmFif5Pmjy/wPtE7VGsAUqOYnUDdM4IbpIvy4L5S75qbbU3z6
        f3ou5XN+RqKGp4KoA27n2VNA7gkrc3E/v3bRZnRvx8sVHhppidLZkjeteYWXoEpS
        eJIRc5ufrNiVncr8/e1DRiGsYcqj8C+q2vthKpB9BovJ5LDB5WH9TxEncK8bU6fG
        0Bo9Ojzgoy6R77L3Wc3JBoNpzQ9IxV8U8ubp9MTKJAQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id P30bubTdvB1y for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 00:07:42 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5RmF0VYCzBppQj;
        Wed, 19 Jul 2023 15:10:21 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 15:10:21 +0800
From:   sunran001@208suo.com
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: add missing spaces after ';'
In-Reply-To: <20230719041722.18919-1-xujianghui@cdjrlc.com>
References: <20230719041722.18919-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <a03e17db9cf1e08db037149747306d03@208suo.com>
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

Remove spaces to clear checkpatch errors.

ERROR: space required after that ';' (ctx:VxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  include/trace/stages/stage4_event_fields.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/stages/stage4_event_fields.h 
b/include/trace/stages/stage4_event_fields.h
index b6f679ae21aa..9627e081a990 100644
--- a/include/trace/stages/stage4_event_fields.h
+++ b/include/trace/stages/stage4_event_fields.h
@@ -2,7 +2,7 @@

  /* Stage 4 definitions for creating trace events */

-#define ALIGN_STRUCTFIELD(type) ((int)(__alignof__(struct {type b;})))
+#define ALIGN_STRUCTFIELD(type) ((int)(__alignof__(struct {type b; })))

  #undef __field_ext
  #define __field_ext(_type, _item, _filter_type) {			\
