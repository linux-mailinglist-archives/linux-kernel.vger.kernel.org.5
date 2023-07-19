Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EC7758CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 06:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGSEba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 00:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjGSEb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 00:31:28 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A1FE47
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 21:31:27 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5MWR4zMzzCLkFW
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:58:59 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689739138; x=1692331139; bh=g+gKctoELFDP+ddd+DRaRwJpB4a
        9mxa7pY0/WAvW5us=; b=Le1d1Mi1sYe25CYC2+UfbN4Xl7V37NbkvDA+GPVlT+e
        8rCrcpmX3CxVag+l/mrS663ZSfplnjVbpFu2s+esZFGu4jLrNnCRAvu/En7FIuAw
        MpZFGz1caz7WLdh1/GYHLniJLZGAKV+e3HQWXhbWzi6FOApSxJoMz+vmLJaAghHO
        6rHATEu0wnbqHD9l+U4dLzFwhFNbr9YVT4Nxn94bEzIxYg7eLRB9folyfyI95cnz
        E+d39JqHZV7HNoOSJ9h/gtFNVQa77LRMGabySXSk0enTjR9GKmu1EFSjhQaYb81I
        QzB+kZea5AIRsAyHqXlpBRU3H2ECHWzUUQ0mN764Bbg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oHzmDJ_IDU5D for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 11:58:58 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5Lgg5ttGzCDHsB;
        Wed, 19 Jul 2023 11:21:03 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 11:21:03 +0800
From:   sunran001@208suo.com
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] include: events: remove spaces after '(' and before ')'
In-Reply-To: <20230719030939.18448-1-xujianghui@cdjrlc.com>
References: <20230719030939.18448-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <7d6b48368594b2f815dff7c5375be638@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix four occurrences of the checkpatch error:

ERROR: space prohibited after that open parenthesis '('
ERROR: space prohibited before that close parenthesis ')'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  include/trace/events/nmi.h | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/nmi.h b/include/trace/events/nmi.h
index 18e0411398ba..99abd0bc8ebd 100644
--- a/include/trace/events/nmi.h
+++ b/include/trace/events/nmi.h
@@ -15,9 +15,9 @@ TRACE_EVENT(nmi_handler,
  	TP_ARGS(handler, delta_ns, handled),

  	TP_STRUCT__entry(
-		__field(	void *,		handler	)
-		__field(	s64,		delta_ns)
-		__field(	int,		handled	)
+		__field(void *,	handler)
+		__field(s64, delta_ns)
+		__field(int, handled)
  	),

  	TP_fast_assign(
