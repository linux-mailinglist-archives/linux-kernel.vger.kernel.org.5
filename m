Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B02D7F36BF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjKUTT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 14:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUTT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:19:57 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A616188
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 11:19:54 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28011e1cdcbso7750402a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 11:19:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700594393; x=1701199193;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUBkvtKlljNw5RGXfShx1sdDMysH6AQ2CmAfAVALdNU=;
        b=dhJmqOKjUH7/S6T0ej/SY7EW0W+PU93sLPrZX1cHqIPMMG7LJrSDyWnrkBmgytjkJY
         cwZVhP4agc2862XG70VjZV6qaA17vqgH22cPa1z1O3tkypKgI+WLrqMlPfOiIAmqG2RB
         /p3sHIpU7CsH6oATfvpOUdxkUJzuwxgUigYFCLYsppw3ecCzLXPfVyJuTWe0cobOAKH6
         MzqXZWGRLqSL6TI8Qif4h9iGwiiKVEvJc8VD20jlkr4ajeU+lRyPWVx2RXep1Ws33VLv
         EPnFMolIZuoPA7GUdJVRMNiu94yo81cdY2oc0I9iwIVvHKq2C+lBsYigfDY5/N8QdBVL
         Nz5g==
X-Gm-Message-State: AOJu0YzqzHJNnAM7DL7ruLik4LlwFXX33ZwdOeXeLUD2okp/z8Ng8mmV
        2ZxYlIx9BMNPdHcJbAAnv2e0uc2ev0jinuBy119tdTcHUhwhJjE=
X-Google-Smtp-Source: AGHT+IGWNaPAGyEf+h3ROvpObYlG5kLp0q8Q1YP7m3lQWLR/xmBe+EjayCcHdvuNVMj/uFkIzJ2bZK3eew2BMWW/JPhuf5t2JCDM
MIME-Version: 1.0
X-Received: by 2002:a17:90a:8986:b0:27d:e1c:533e with SMTP id
 v6-20020a17090a898600b0027d0e1c533emr37550pjn.3.1700594393855; Tue, 21 Nov
 2023 11:19:53 -0800 (PST)
Date:   Tue, 21 Nov 2023 11:19:53 -0800
In-Reply-To: <000000000000d330500607d85a5f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0be0d060aae7c5b@google.com>
Subject: Re: [syzbot] [PATCH] Tried to correct
From:   syzbot <syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] Tried to correct
Author: tintinm2017@gmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Signed-off-by: attreyee-muk <tintinm2017@gmail.com>
---
 drivers/hid/usbhid/hid-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index a90ed2ceae84..582ddbef448f 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1021,6 +1021,8 @@ static int usbhid_parse(struct hid_device *hid)
 	       (hdesc->bLength - offset) / sizeof(struct hid_class_descriptor));
 
 	for (n = 0; n < num_descriptors; n++)
+		if (n >= ARRAY_SIZE(hdesc->desc))
+			break;
 		if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT)
 			rsize = le16_to_cpu(hdesc->desc[n].wDescriptorLength);
 
-- 
2.34.1

