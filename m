Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55FF75A4BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGTDZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGTDY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:24:57 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90F1268F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:24:49 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5yjW4VtLzBRDs0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:24:47 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689823486; x=1692415487; bh=ppjwFhVPDtaNu7oIL/ApBshuMIo
        6bf9nBUAqS4MhxEo=; b=zyopWuNo5fl4qrDyiU+Kpn5peWBydyDyp/ysE82smrg
        kPZbc+Sgp22yX03bi6F51mYB8WdWz5d6tNcoPmqsw8Vxim4ihv+PzduW4CBCOX3M
        gvTy5eq/l1uS81So9vJpBWeyPMfu8kSjkHBZwpYIkD7RU4c6ciFEOrYtwwoOwdk5
        8gNMap/5d81hMubnDGx9MJEqevrxHNHtEa4QZHHVva3asY3Yq8fKsfHoO7ufvZV0
        Gs9m+D3fUGljwxEQIIK9H9HIYRxRYfMfLGsMdmMJYxrKxUApBaMAZHNCyJ7v9rx5
        0JEMFyFMUBmbYwSMUehhrwU58+7Bkq+ncuKLURE1zEg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 55pw1ysM3A1P for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 11:24:46 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5yjV5yZRzBR1P6;
        Thu, 20 Jul 2023 11:24:46 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 11:24:46 +0800
From:   sunran001@208suo.com
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] oom: remove spaces after '*'
In-Reply-To: <20230720032346.1869-1-xujianghui@cdjrlc.com>
References: <20230720032346.1869-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <944703e88ae911d7008f2b5f1ca52d2f@208suo.com>
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

remove redundant spaces to clear checkpatch errors.

ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  include/linux/oom.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 7d0c9c48a0c5..7964f1fd9984 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -72,7 +72,7 @@ static inline bool oom_task_origin(const struct 
task_struct *p)
  	return p->signal->oom_flag_origin;
  }

-static inline bool tsk_is_oom_victim(struct task_struct * tsk)
+static inline bool tsk_is_oom_victim(struct task_struct *tsk)
  {
  	return tsk->signal->oom_mm;
  }
