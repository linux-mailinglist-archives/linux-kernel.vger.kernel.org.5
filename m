Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8BF7DE5AF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjKAR7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjKAR7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:59:19 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CE3C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:59:15 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id yFUmqLu9UdNF0yFUmqlWiI; Wed, 01 Nov 2023 18:59:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698861554;
        bh=nSCBkCeZL0EQ7NHodw1YX1UP/T3rsY2JwArBMjG08Zc=;
        h=From:To:Cc:Subject:Date;
        b=O4u5rTofB6KkdSZGCpBZFY1Yp76juWyKZtYGAbn0PX+e9vkx1MqBokVwOp5Diu64u
         Gwq1TK7Ou/2WiF4YWCN46PQ4sw0oBsXjnutFBhhElG2x0ksu4Egj9PoKb9BWA4gcJH
         vcGIe0B4H+m0GPti6Ot+G2B4J5XPNyE7h5n2sv1gcky2lF5M/P29tveE8g14XxwWa0
         Kb/OfNwVkqbs+0cQy5upv5TqraMGpY3GTxxXrG3/MFztH/TF7SFt90YAjFxyBdPoCV
         bJdW0W5BR8JpdRFsOpQOIOMRKqmS6bAIQrfBPsAyx46MQRS6tVTNa4EVQA2Q3UPa/I
         ppyjuUjqFDiAQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Nov 2023 18:59:14 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rostedt@goodmis.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, willy@infradead.org,
        senozhatsky@chromium.org
Cc:     list@mail.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/2] seq_buf: Export seq_buf_putc() &nd seq_buf_puts()
Date:   Wed,  1 Nov 2023 18:59:04 +0100
Message-Id: <cover.1698861216.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seq_buf_putc() has a potential real use-case (link in the patch), but 
seq_buf_puts() has currently no forseen use-case, so I have split it in 2
patches if only the 1st one is accepted.

Christophe JAILLET (2):
  seq_buf: Export seq_buf_putc()
  seq_buf: Export seq_buf_puts()

 lib/seq_buf.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.34.1

