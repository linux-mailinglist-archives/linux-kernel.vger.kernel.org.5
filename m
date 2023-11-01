Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4A97DE5B2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjKAR7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjKAR7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:59:30 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E557811B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:59:27 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id yFUmqLu9UdNF0yFV0qlWko; Wed, 01 Nov 2023 18:59:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698861566;
        bh=fmXDam8ctwZy0nwdVkg4LI2xqdzczg/T9kzcAIDeL50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PwsCyBiM7rseh7jFjjmEIaK+1rEjKjORJ/6LE63E7XYnWtKuyRBcoW1RNDKbs9AWr
         ACvuCd0qoJhsoRwVvW9tVWlBWBjJx61sihf+LYGbiNPRDVAZpBngT6JUic1GCFZ6k9
         MMODtBMkQcpdfROVrEdmidc+OhF11eoYz2s28IS6aCd6D+4pr+okvK/ZshZ8v7piXV
         7P+okjmXoHZ7Exy7TyQ7bcQcIzgE/hSp+hdMs1s6TeVMTtdByQTwMrlOyl3nwKRkCT
         eKAL7wQVGSyvz5lRCVHRmt4f1Z/VCvGf91pLfVSUGPVrJnO6jIDPrzG7ZMCrZ2jMWC
         YVuSfP55gvTqQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Nov 2023 18:59:26 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rostedt@goodmis.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, willy@infradead.org,
        senozhatsky@chromium.org
Cc:     list@mail.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] seq_buf: Export seq_buf_puts()
Date:   Wed,  1 Nov 2023 18:59:06 +0100
Message-Id: <b9e3737f66ec2450221b492048ce0d9c65c84953.1698861216.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698861216.git.christophe.jaillet@wanadoo.fr>
References: <cover.1698861216.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark seq_buf_puts() which is part of the seq_buf API to be exported to
kernel loadable GPL modules.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
There is currently no need for me for this export, but should the seq_buf
API be more widely used, it could become convenient to have it available.
---
 lib/seq_buf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index fb99168c3309..010c730ca7fc 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -187,6 +187,7 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
 	seq_buf_set_overflow(s);
 	return -1;
 }
+EXPORT_SYMBOL_GPL(seq_buf_puts);
 
 /**
  * seq_buf_putc - sequence printing of simple character
-- 
2.34.1

