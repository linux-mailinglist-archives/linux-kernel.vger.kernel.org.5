Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB167E5A64
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjKHPp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjKHPpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:45:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432101FDA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699458268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9pfTamduDuXvj1ycdmEqtqmHUJQLMXtDuZ7PUu6n6YA=;
        b=jREken/xfshM5fckfCQh7onDDbyjPRPAdvl1S909c91VnU4tZ5Y66O8+1LuN5p51ipLVzO
        Ubm4Jga0iIBfZko18dX5cLrfMWp0d7/SEwTOy+rpqZJJ/Z/negrBpXpDNA+rQnpxmYPKaw
        Ft/y1pSFE9gd4MZSEaKN/Vkhcfw9YkY=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-Xlh4_8-ROE-tRAOkbIkl0w-1; Wed, 08 Nov 2023 10:44:27 -0500
X-MC-Unique: Xlh4_8-ROE-tRAOkbIkl0w-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6b1f7baa5ceso4960315b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 07:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699458266; x=1700063066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pfTamduDuXvj1ycdmEqtqmHUJQLMXtDuZ7PUu6n6YA=;
        b=FXrH0Ew9vUGmGxr2mvM5OCdA4WNWrd/Uu9LNsecVf+vNpdl9YB/Yg3tRhtHd9rAyCq
         uVVVCmYWGMat6FkPP+PImxx5Gr8hIvc1A0SVrer8Zij4jXgBt6U3slZ94VdidNbCewOv
         Vr5Tho7Mz7tK8AWTnxtZxH8tKUTmKHAfbDQ173PEdJYNPfkFrirNIro4nd4Jn/vHSL9r
         CKi1NsvHF3SEIv2s1FXLHP8iBDxG73dLUcgj6I5HjH/TX4RN9s7A8DHt79evYtElvz8m
         TMB4PDfWJ95QR37ZcyFalRu8ctkJj1kTiMOisEJKLySjKf1lo+OLXgZ+20zx678TTHG6
         xKSQ==
X-Gm-Message-State: AOJu0YzRcfZCkApfu8f9cPsI1udf0LVPrFClmFRYr9bu1fLv1rul5OCz
        1e4n1wgpLO+3d7dN1FtvhNE3O2zGPWIge0i1M/IQR3iU7L/bpMiy5mAnDoUgqJBF+9atUIi7GNy
        kpofva/qljKHnMgBfNKBIp9HN
X-Received: by 2002:a05:6a20:7349:b0:181:7aa7:de46 with SMTP id v9-20020a056a20734900b001817aa7de46mr1945368pzc.8.1699458265961;
        Wed, 08 Nov 2023 07:44:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyrfKU4MqxbyH9BApHxfTp6hLteN1T9QI82b/UtxOmPvpYED3KgY/5w5B3MEUMr1rMniNAeg==
X-Received: by 2002:a05:6a20:7349:b0:181:7aa7:de46 with SMTP id v9-20020a056a20734900b001817aa7de46mr1945350pzc.8.1699458265661;
        Wed, 08 Nov 2023 07:44:25 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id ei4-20020a056a0080c400b006c31b4d5e57sm9161068pfb.184.2023.11.08.07.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:44:25 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net] tty: Fix uninit-value access in ppp_sync_receive()
Date:   Thu,  9 Nov 2023 00:44:20 +0900
Message-ID: <20231108154420.1474853-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN reported the following uninit-value access issue:

=====================================================
BUG: KMSAN: uninit-value in ppp_sync_input drivers/net/ppp/ppp_synctty.c:690 [inline]
BUG: KMSAN: uninit-value in ppp_sync_receive+0xdc9/0xe70 drivers/net/ppp/ppp_synctty.c:334
 ppp_sync_input drivers/net/ppp/ppp_synctty.c:690 [inline]
 ppp_sync_receive+0xdc9/0xe70 drivers/net/ppp/ppp_synctty.c:334
 tiocsti+0x328/0x450 drivers/tty/tty_io.c:2295
 tty_ioctl+0x808/0x1920 drivers/tty/tty_io.c:2694
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0x211/0x400 fs/ioctl.c:857
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 __alloc_pages+0x75d/0xe80 mm/page_alloc.c:4591
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 __page_frag_cache_refill+0x9a/0x2c0 mm/page_alloc.c:4691
 page_frag_alloc_align+0x91/0x5d0 mm/page_alloc.c:4722
 page_frag_alloc include/linux/gfp.h:322 [inline]
 __netdev_alloc_skb+0x215/0x6d0 net/core/skbuff.c:728
 netdev_alloc_skb include/linux/skbuff.h:3225 [inline]
 dev_alloc_skb include/linux/skbuff.h:3238 [inline]
 ppp_sync_input drivers/net/ppp/ppp_synctty.c:669 [inline]
 ppp_sync_receive+0x237/0xe70 drivers/net/ppp/ppp_synctty.c:334
 tiocsti+0x328/0x450 drivers/tty/tty_io.c:2295
 tty_ioctl+0x808/0x1920 drivers/tty/tty_io.c:2694
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0x211/0x400 fs/ioctl.c:857
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 12950 Comm: syz-executor.1 Not tainted 6.6.0-14500-g1c41041124bd #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
=====================================================

ppp_sync_input() checks the first 2 bytes of the data are PPP_ALLSTATIONS
and PPP_UI. However, if the data length is 1 and the first byte is
PPP_ALLSTATIONS, an access to an uninitialized value occurs when checking
PPP_UI. This patch resolves this issue by checking the data length.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/net/ppp/ppp_synctty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index ebcdffdf4f0e..ea261a628786 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -687,7 +687,7 @@ ppp_sync_input(struct syncppp *ap, const u8 *buf, const u8 *flags, int count)
 
 	/* strip address/control field if present */
 	p = skb->data;
-	if (p[0] == PPP_ALLSTATIONS && p[1] == PPP_UI) {
+	if (skb->len >= 2 && p[0] == PPP_ALLSTATIONS && p[1] == PPP_UI) {
 		/* chop off address/control */
 		if (skb->len < 3)
 			goto err;
-- 
2.41.0

