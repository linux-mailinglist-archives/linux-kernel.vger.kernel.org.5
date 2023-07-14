Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047C5753492
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjGNIFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGNIE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:04:28 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBDF35AD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:02:16 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2P8Q3fMbzBR9sj
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:02:14 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689321734; x=1691913735; bh=+kfv0rzFf1YF8igHb2UwtVQy61O
        3wotE1gBrJRPYCM8=; b=qO3kPVroR4qrteqpYfXvVZSkwnhi5wXN4Iycz10MZm1
        octNyyGopPOYeVoOEbB2vEnO+yxnWcejTESG+bYkZEkeRcQiWSs5QWceA1jdSEsK
        HGiIfYOAIzrjgm5s4kG9E+Y8ST4gljMdsYABizaJPWBVtqwBU8PPcN0uJ7b+NtLj
        lPbiWceK1h/wM+/oLEi1nnNKff4x7B3VHxHx45BD0oVkGls98dcczY5Wtdb80G6z
        qm0744FKzFtwQ2Ugl8Jef9JINtmLQJG7d0SHDU/xhaKExLOwl+7YQGGs2cIsaKY4
        KFsck9DcTUkzM9i18ZSnYXz+JeSlVbBw3iPg7P++vZQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mNG1W64ndmpr for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 16:02:14 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2P8Q0SgwzBR9sc;
        Fri, 14 Jul 2023 16:02:14 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 16:02:13 +0800
From:   hanyu001@208suo.com
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/slip: Add space after that ','
In-Reply-To: <tencent_C824D439C8CE96AD83779E068967114FF105@qq.com>
References: <tencent_C824D439C8CE96AD83779E068967114FF105@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <4b922e9203381b3411696feae9ee02da@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fix Error reported by checkpatch.pl

./drivers/net/slip/slhc.c:381: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/slip/slhc.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
index befdf4a..cf0245a 100644
--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -378,7 +378,7 @@ struct slcompress *
          goto uncompressed;
      }
      if((deltaS = ntohs(th->window) - ntohs(oth->window)) != 0){
-        cp = encode(cp,deltaS);
+        cp = encode(cp, deltaS);
          changes |= NEW_W;
      }
      if((deltaA = ntohl(th->ack_seq) - ntohl(oth->ack_seq)) != 0L){
