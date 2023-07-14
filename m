Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8127E7534BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbjGNIJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbjGNIJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:09:04 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D533C2B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:06:47 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2PFc5LgbzBR9sg
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:06:44 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689322004; x=1691914005; bh=XnHXJPirhwWBp38ABP/TuJuTwR8
        3qRslG4kr4zY2jQE=; b=prRBxH8oaDBDTnR82sVlKMzhnplxgraSpUiFkTrSEAi
        PL/0jsa+/sZJSgNgjvqdrFQxajScW/0VMmk1IkERiOJnCxIrMehW37VmPbLwXLTz
        4/Gg6Epqe4zEUM8ajdjI6Emvj6lYvp3VJs3ihqxvcok75YhIfp5jDc/08LR4ZkJY
        DJR48ZTH6xczM1qTomDWaAvfVGKk2V529dYKCtUB80aGWWZ/CX6qltAQ3ViLWxqD
        lnf1NQjE0i2Pt5XDCz6HEsa2yzHyW+YTtD0wixN1haz5NiBN1wLqxmY+PHSop7WZ
        EGAY3AuUQCUrdLd8ZPKP/0alZxTnW14UuYWckTM1FFw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id e8oICkZVoc43 for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 16:06:44 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2PFc412lzBR9sc;
        Fri, 14 Jul 2023 16:06:44 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 16:06:44 +0800
From:   sunran001@208suo.com
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb: remove spaces before '['
In-Reply-To: <20230714080514.14297-1-xujianghui@cdjrlc.com>
References: <20230714080514.14297-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <ad3e13dcf101ff613c7fc72c99db8dd2@208suo.com>
X-Sender: sunran001@208suo.com
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

Remove spaces to clear checkpatch errors.

ERROR: space prohibited before open square bracket '['

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/media/dvb-frontends/tda826x.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/tda826x.c 
b/drivers/media/dvb-frontends/tda826x.c
index f9703a1dd758..7f17efe17d11 100644
--- a/drivers/media/dvb-frontends/tda826x.c
+++ b/drivers/media/dvb-frontends/tda826x.c
@@ -38,7 +38,7 @@ static int tda826x_sleep(struct dvb_frontend *fe)
  {
      struct tda826x_priv *priv = fe->tuner_priv;
      int ret;
-    u8 buf [] = { 0x00, 0x8d };
+    u8 buf[] = { 0x00, 0x8d };
      struct i2c_msg msg = { .addr = priv->i2c_address, .flags = 0, .buf 
= buf, .len = 2 };

      dprintk("%s:\n", __func__);
@@ -65,7 +65,7 @@ static int tda826x_set_params(struct dvb_frontend *fe)
      u32 div;
      u32 ksyms;
      u32 bandwidth;
-    u8 buf [11];
+    u8 buf[11];
      struct i2c_msg msg = { .addr = priv->i2c_address, .flags = 0, .buf 
= buf, .len = 11 };

      dprintk("%s:\n", __func__);
@@ -130,7 +130,7 @@ static const struct dvb_tuner_ops tda826x_tuner_ops 
= {
  struct dvb_frontend *tda826x_attach(struct dvb_frontend *fe, int addr, 
struct i2c_adapter *i2c, int has_loopthrough)
  {
      struct tda826x_priv *priv = NULL;
-    u8 b1 [] = { 0, 0 };
+    u8 b1[] = { 0, 0 };
      struct i2c_msg msg[2] = {
          { .addr = addr, .flags = 0,        .buf = NULL, .len = 0 },
          { .addr = addr, .flags = I2C_M_RD, .buf = b1, .len = 2 }
