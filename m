Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E297F66F2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345778AbjKWTId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWTIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:08:31 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44719E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:08:37 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cf644b090cso13418965ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:08:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700766517; x=1701371317;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBtaPymrrtk/QUO39g14If+0oQi2iYLfbj1PNH+d9+A=;
        b=rYGCM5Es76g8zC/oYHwWEygaO8tQdYqhniPh09nGRqEVvD2iGz/wAp13Bg+X4XO8as
         3WgK4k8gWllWrZRVxwl+iPWpf0HWkZbQHxpproCy/b3eV7xm//ifpu2RqbH8S0FmVV9M
         GvClSeoWZpjWHBZpM8sp5qnPs1QbIv4nQ0spbutHM5xuHLCjU+g2r8ig6ZoDkWfBRQOr
         6gkMsPKG08n3bdnlwtvKg52nuZfQjQQIXfO4N9Z4i28I88mZ+aPO/hDo7U536GwnP794
         5yKXqKjq0hXONm6Dq6wJl3EllexZDZJ6FqFTX4+JBKEvUgEBiQZeJHQdg3I2dGRPv8d+
         tLlQ==
X-Gm-Message-State: AOJu0YxhOqiwqbYJsULrBYWHjeW52o54vgaZ8Ouq6/P+8izUxR6/6J7S
        VdX1G+n7vG8y+JGJXJ4QKI9njZNOcEgyRHBBiC6hfzfE7wgV5BI=
X-Google-Smtp-Source: AGHT+IFSDbiFtnqXap6WHcOb2nQf6o12HBX65Z3v+Ou3heiVmintUltAheWp64CImiLw6UbOGwzEu307W/1EjpJvl2s5XR/ao13g
MIME-Version: 1.0
X-Received: by 2002:a17:902:efc5:b0:1cf:54e4:cdcc with SMTP id
 ja5-20020a170902efc500b001cf54e4cdccmr100325plb.4.1700766517512; Thu, 23 Nov
 2023 11:08:37 -0800 (PST)
Date:   Thu, 23 Nov 2023 11:08:37 -0800
In-Reply-To: <000000000000809328060a8a4c1c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f52df060ad6900a@google.com>
Subject: Re: [syzbot] printk debug
From:   syzbot <syzbot+83763e624cfec6b462cb@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: printk debug
Author: yuran.pereira@hotmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/staging/rtl8712/rtl871x_xmit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 6353dbe554d3..c80c60417d5c 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -125,6 +125,7 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 			      ((addr_t)(pxmitpriv->pallocated_xmitbuf) & 3);
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
 	for (i = 0; i < NR_XMITBUFF; i++) {
+		pr_info("==> Allocating pallocated_buf %d\n", i);
 		INIT_LIST_HEAD(&pxmitbuf->list);
 		pxmitbuf->pallocated_buf =
 			kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ, GFP_ATOMIC);
@@ -188,6 +189,7 @@ void _free_xmit_priv(struct xmit_priv *pxmitpriv)
 		pxmitframe++;
 	}
 	for (i = 0; i < NR_XMITBUFF; i++) {
+		pr_info("==> Freeing pallocated_buf %d\n", i);
 		r8712_xmit_resource_free(padapter, pxmitbuf);
 		kfree(pxmitbuf->pallocated_buf);
 		pxmitbuf++;
-- 
2.25.1

