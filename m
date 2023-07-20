Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FC175A463
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 04:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjGTCan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 22:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGTCal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 22:30:41 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622C52107
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 19:30:40 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5xW10ZQmzBRDrL
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:30:37 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689820236; x=1692412237; bh=LgGf9G+dE6aOo+jbUjeBLHSt/8/
        h1kBlS9EWXwngvDc=; b=s5DLPsfHGKxG96Vh5IFGXvXZjP36fOrZUm5d5KfMEwa
        Kgyc+GpKSSa7ZQG7S+a0qeEWO88o9tmGSfx3chKtBbfNlgDq+qneNHkE+pNNiLtt
        ikUuv7XT2Nna2cvcNhPfTiKN+8UbUqQu2HmkANTk6IIdMZonZH7yLh6Pn+p2uElM
        SZwI3MbowoENj2yxLO7xybe5hRVWbcdre7Z93Pbv3+e+b10wvpEdYeZLO/QIFDU+
        Jak8n7+5KwLUos+ri984XTmnCjdYfuyHm4gOvAwo5Zs2zDjeoJoBaGW3JMrJ9Qa0
        MX39vioE3lTcxfiVEL/fwP0UD2+xZe1OUVsQNPuqODQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id P9enMTnpa_RA for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 10:30:36 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5xW05DKRzBRDrD;
        Thu, 20 Jul 2023 10:30:36 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 10:30:36 +0800
From:   wuyonggang001@208suo.com
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: add missing spaces after ';'
In-Reply-To: <20230719064321.19047-1-xujianghui@cdjrlc.com>
References: <20230719064321.19047-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <74685bd017411f96c8a846ebd5e3916a@208suo.com>
X-Sender: wuyonggang001@208suo.com
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

Remove spaces to clear checkpatch errors.

ERROR: space required after that ';' (ctx:VxV)

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
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
  #define __field_ext(_type, _item, _filter_type) {            \
