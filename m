Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E212C757321
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjGRF0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjGRF0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:26:10 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77635E55
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:26:08 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4nVP33LDzBQslL
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:26:05 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689657965; x=1692249966; bh=HM9Jjku1M9Q+CIDDNjLgBH4aWXj
        NzUmkcwULLAv4VBg=; b=DaxFAts4X9YnSkApnIEiXpEnmiUe7rYUuQ4J0Wq13Ut
        9qFAIObQKJsbvjflPjkOP2XzLmGvX4bhQh+y6C7Bev2VbCT1f2DHTxGbLH2tlfKO
        jmokXAV6RUgdMF9XW5X/RJqG6qNH5J+WnGY56wN6EEBdM5U2FK5EXZ4G1j1K/Ksc
        KI14junMrPTtc17GVxvodpQmQrVN7C6CdZed90dbNn62AjcyGIzMowIYfmQ2tOjx
        rhnxCaOwuvKkJFU6hmbY2nlCqplbYhWMzB9Zrk3woUgug0Gf4PIkk2E60JoPNlSx
        qcCbHExJkFsvCqzAstWEHkg6nhC6o4gcq4KEZw71ULQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aNoEjeSopJrK for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 13:26:05 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4nVP1rZpzBQslB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:26:05 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 13:26:05 +0800
From:   shijie001@208suo.com
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] samples: uhid: Fix errors in uhid-example.c
In-Reply-To: <tencent_4422F294FED5B7D0585A9774467761664F08@qq.com>
References: <tencent_4422F294FED5B7D0585A9774467761664F08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <993d59c45492409c3b3b8b8294ff8c8c@208suo.com>
X-Sender: shijie001@208suo.com
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

The following checkpatch error is removed:
ERROR: "(foo*)" should be "(foo *)"

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  samples/uhid/uhid-example.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/uhid/uhid-example.c b/samples/uhid/uhid-example.c
index 015cb06a241e..c425eb630955 100644
--- a/samples/uhid/uhid-example.c
+++ b/samples/uhid/uhid-example.c
@@ -179,7 +179,7 @@ static int create(int fd)

      memset(&ev, 0, sizeof(ev));
      ev.type = UHID_CREATE;
-    strcpy((char*)ev.u.create.name, "test-uhid-device");
+    strcpy((char *)ev.u.create.name, "test-uhid-device");
      ev.u.create.rd_data = rdesc;
      ev.u.create.rd_size = sizeof(rdesc);
      ev.u.create.bus = BUS_USB;
