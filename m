Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4A17E7E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjKJRoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbjKJRnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:43:41 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059477688
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:32:41 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc1682607eso16694425ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699597960; x=1700202760;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujl3jIy32sZVS9KiR+zaT0iaqG18G/enwiDyAL/Fxo8=;
        b=izFRBnCokJz/xGKelx6dj8/7hdvZ6OswpBho5jq4V8SHYjEDjcyzZzFX0B0PbLSRFQ
         nuTL0jmELch9miyajjpok9jRUxxyZg3IV71dwguYuqD7ho8gaVn47mcGmd5lGMK/Z//+
         YJ8GvDrnL+9tqijEq+HJcNVE6zAQpi0g2iDz7XC2pRwFj/HaA12m9oBnxfO8JOe0m95y
         U9qm/uY8zmz46QSRgXJjRLtwHekiPdtkEIAsdUnpsNa5XHwrhonMieslliNDYcvER3ST
         9mdiXvQzjHGsECUYRE0vHRtXQlm//anS2QISRdT+LuFuTpwlx4IHXarDBlnGdre81rmR
         eBfg==
X-Gm-Message-State: AOJu0Yz1tSRLVmkua7X179A8dzDLQCgSsijWXnB9c6/sMWQPLpFcyUo8
        JBZ+VBvs2fbkBFS5VaKs3vC3LrrcmhBx3jd/Pi98/TzkYjb3eHs=
X-Google-Smtp-Source: AGHT+IF6rj6OHOqRBNLOEkIFwzv/EM5p9cltFO9tdpF+K87G+ARPLrrw390+9onNT29yEb9Kg41XGkkDP1/EZDKNHGnvKsFJ9Gd1
MIME-Version: 1.0
X-Received: by 2002:a17:902:6b02:b0:1cc:3597:9e2f with SMTP id
 o2-20020a1709026b0200b001cc35979e2fmr998719plk.2.1699597960584; Thu, 09 Nov
 2023 22:32:40 -0800 (PST)
Date:   Thu, 09 Nov 2023 22:32:40 -0800
In-Reply-To: <0000000000007323f20609b7cfbb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3a5370609c67cfe@google.com>
Subject: Re: [syzbot] [PATCH] test aea6bf908d73
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] test aea6bf908d73
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git aea6bf908d73

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index e2680a3bef79..6ba43a0369d3 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -738,7 +738,7 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 
 	pr_debug("Send UI frame len %zd\n", len);
 
-	local = sock->local;
+	local = nfc_llcp_find_local(sock->dev);
 	if (local == NULL)
 		return -ENODEV;
 
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 1dac28136e6a..150d0e24e27c 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -284,6 +284,7 @@ struct nfc_llcp_local *nfc_llcp_find_local(struct nfc_dev *dev)
 	spin_lock(&llcp_devices_lock);
 	list_for_each_entry(local, &llcp_devices, list)
 		if (local->dev == dev) {
+			printk("finded: %p, d: %p, %s\n", local, dev, __func__);
 			res = nfc_llcp_local_get(local);
 			break;
 		}
@@ -299,6 +300,7 @@ static struct nfc_llcp_local *nfc_llcp_remove_local(struct nfc_dev *dev)
 	spin_lock(&llcp_devices_lock);
 	list_for_each_entry_safe(local, tmp, &llcp_devices, list)
 		if (local->dev == dev) {
+			printk("deled: l: %p, d: %p, %s\n", local, dev, __func__);
 			list_del(&local->list);
 			spin_unlock(&llcp_devices_lock);
 			return local;
