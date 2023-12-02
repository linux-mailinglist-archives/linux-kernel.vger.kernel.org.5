Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1B4801D72
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 16:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjLBPFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 10:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBPFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 10:05:04 -0500
X-Greylist: delayed 370 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Dec 2023 07:05:09 PST
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB8B102;
        Sat,  2 Dec 2023 07:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1701529506;
        bh=+4tkXT2Y0ZJNldwcYbIGmHyE8OJNqApK4fyYv38niwQ=;
        h=From:To:Cc:Subject:Date;
        b=GUBi5Fha+OHP29KFzB+au403WHJ9kax2BT4WP5zoXnLxcl2y5HtsinAz7zmO3Mlpl
         2N9FKfFLzOoRrOqLYBM7dJuu3JRMQ0dUHnw5ZAT8PwLuyzVYq+/fmVOOrjdIk6dS16
         CEw0lqdTvyj4ZdxIdkqKHDkInu7QlJwdve63Dl7A=
Received: from KernelDevBox.byted.org ([180.184.49.4])
        by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
        id EB51FC1C; Sat, 02 Dec 2023 22:58:53 +0800
X-QQ-mid: xmsmtpt1701529133tmz3ieq44
Message-ID: <tencent_1C04CA8D66ADC45608D89687B4020B2A8706@qq.com>
X-QQ-XMAILINFO: MIHMmFPOQW9Xwuxg219KDH2tOJ9xY5IPqVV5LYIize3GgkHCsQ7U0mx5nSYkzi
         yIo8eJVrtOHShJqG4/qHU1EVMvth1+D7N/gaQqZGlmOVGcrm65ydZ0TZ5CEOqsMZNl4b0wE31gpd
         T/YHSGDqME7yHtIGbpOYCP7mrr1X+Pc/FIv+BfMGGVb/5oxtpO25xQpcDEg6nodoibM1cIAxQjqE
         9kHxBDNIKtD0uXzv1vSdK67VEcf2xKYeW/uoeixXBMhm9cIhKEfAzp7jUUjZOcjw2KUTljWlC+yO
         n1HliH+0SUx1RupK8T2duLqSZyC8rpnjT1SPb6NQ7MsSERjoALEdZM6bQOUIVBfuiQyo7gKEZ9b3
         ZqCcdlEjfMTo/6DKMPtBdo8fZX4Q20XvC6zCBDfsOk1rNiMhGNKoUvICFqOF9AXvoJ/SgZ8yxg+B
         V3kUK2NEkf4TCGo1XjidMDuNDJt6fYQwaHgJIEKAna6Ulu9LFGeksKIovGsjm/ET3zMOZHjZuYuX
         HtPJhapVtj4iDe898/wGNEDRTmE21fL28xUamfGY8ZsCy2/7IzwaJ349haBZbh68Jt0ZVjjA+ZaD
         OVYipUnHFHNvLVJU96SFnbRwikfUk6avPWCWcXtS67DkgeNmkEyFHt7C1S+qRuHHTIA4fn+MFv4F
         AQjij1XUOgCT6XolUo8Stnin1tQV9WTb5WGtC+HKAjYU+OUPSNn/M6cD4TO4yur3XUBWD1HkKqBm
         jZSZDxhpUTjbh2FEJjxG9lAlrKUhhuZeYK6VstgIkpAosSyNlm4eAXIlxdzWqfMFPtjy5IzfO8q7
         8kLvmB2QwEJMQmlNtaNHFiUlV2uqAXknI03ZhSbS/EuLuYsPmiK9H8ExMNwjC3yWcSNFp+nO+Fm8
         lhlxgf6d0nP3+W9tSfQB5YejFyxZGhOzISSk2O7rkuNX/IST8Kw6VBbLHmJ4XIGYaDBElC+Gjrgf
         nJUC9nxrxBMORxrZ6axc/5EjFLTDsUBKBRKceBKvfOIUX3Cp+jCOq+KrA7r80a
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     alex.aring@gmail.com
Cc:     stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        harperchen1110@gmail.com, Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH RESEND] mac802154: Fix uninit-value access in ieee802154_hdr_push_sechdr
Date:   Sat,  2 Dec 2023 22:58:52 +0800
X-OQ-MSGID: <20231202145852.505410-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syzkaller reported an issue:

BUG: KMSAN: uninit-value in ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
BUG: KMSAN: uninit-value in ieee802154_hdr_push+0x971/0xb90 net/ieee802154/header_ops.c:108
 ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
 ieee802154_hdr_push+0x971/0xb90 net/ieee802154/header_ops.c:108
 ieee802154_header_create+0x9c0/0xc00 net/mac802154/iface.c:396
 wpan_dev_hard_header include/net/cfg802154.h:494 [inline]
 dgram_sendmsg+0xd1d/0x1500 net/ieee802154/socket.c:677
 ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg net/socket.c:748 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2494
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2548
 __sys_sendmsg+0x225/0x3c0 net/socket.c:2577
 __compat_sys_sendmsg net/compat.c:346 [inline]
 __do_compat_sys_sendmsg net/compat.c:353 [inline]
 __se_compat_sys_sendmsg net/compat.c:350 [inline]

We found hdr->key_id_mode is uninitialized in mac802154_set_header_security()
which indicates hdr.fc.security_enabled should be 0. However, it is set to be cb->secen before.
Later, ieee802154_hdr_push_sechdr is invoked, causing KMSAN complains uninit-value issue.
Since mac802154_set_header_security() sets hdr.fc.security_enabled based on the variables
ieee802154_sub_if_data *sdata and ieee802154_mac_cb *cb in a collaborative manner.
Therefore, we should not set security_enabled prior to mac802154_set_header_security().

Fixed it by removing the line that sets the hdr.fc.security_enabled.

Syzkaller don't provide repro, and I provide a syz repro like:
r0 = syz_init_net_socket$802154_dgram(0x24, 0x2, 0x0)
setsockopt$WPAN_SECURITY(r0, 0x0, 0x1, &(0x7f0000000000)=0x2, 0x4)
setsockopt$WPAN_SECURITY(r0, 0x0, 0x1, &(0x7f0000000080), 0x4)
sendmsg$802154_dgram(r0, &(0x7f0000000100)={&(0x7f0000000040)={0x24, @short}, 0x14, &(0x7f00000000c0)={0x0}}, 0x0)

Fixes: 32edc40ae65c ("ieee802154: change _cb handling slightly")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 net/mac802154/iface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0e2da5072be..c99b6e40a5db 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -368,7 +368,6 @@ static int ieee802154_header_create(struct sk_buff *skb,
 
 	memset(&hdr.fc, 0, sizeof(hdr.fc));
 	hdr.fc.type = cb->type;
-	hdr.fc.security_enabled = cb->secen;
 	hdr.fc.ack_request = cb->ackreq;
 	hdr.seq = atomic_inc_return(&dev->ieee802154_ptr->dsn) & 0xFF;
 
-- 
2.30.2

