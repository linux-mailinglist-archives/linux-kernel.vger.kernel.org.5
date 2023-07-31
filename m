Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FBF769A30
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjGaO5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGaO5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:57:50 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E45FE7D;
        Mon, 31 Jul 2023 07:57:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52256241b76so6062938a12.1;
        Mon, 31 Jul 2023 07:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690815467; x=1691420267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qo75w1cQ79isjWxGQqFcL39VK1tMqrr6OMLzI30LRwo=;
        b=JxBM4lkdYw1/OqTnzkUg2E2EXMmiJa1lI0sHTAKP4lAmHLpVPB5YRCh4/ojYL5Nz2b
         2ajeL8jYA/xeTyYIa+idm2dGD5AUjvCwC2BmjVF6oWJDOJnOvMi6OFblzWK0BlTxU00t
         0bwZ5aW+ff6yp22thZlf0Jis1oS3jDSDA62YhOqT0QSl8iVw5kdc5oJrQBQitn8kmcel
         pRKcdyXlsdBwCbz1q1Ij+YULTREWsFKnhzFTJKw2Y8h0th4wsgvolYrhWVaHCXtYpE39
         SVJaQdIcIuWLXe/J3cLHom6GS013L1VrcVfx3gtdPSNW/L4yvkxGB2WXEq0njHlStPym
         FOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690815467; x=1691420267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qo75w1cQ79isjWxGQqFcL39VK1tMqrr6OMLzI30LRwo=;
        b=KXdJIPrmrdMe5DuitJ21W2BtnEzi3zxi3NgN797zeJbIqHRO4TaZWlcxNWZrOuW/Pa
         C7PJ6Vd3sZLIcSBMteSi5JB5rwSKL0SrVPhMB61glxKL8h+SItFC4c26rzvmeOKOOVkF
         wmdGD3+q20ye2H2Kus0Y6MHLeRSACQQVK5KM8g3jdPkrOhZ61poHnJ3atyJUZA1Hys6w
         CGzCBf5Knl8xgI64lvvYi5lVJe9rpWBbi+7wYcegpCiQi1hi/54VTYRC6KaNq5X+VljK
         x0FJfzFVCfS9EPtQaEbmWvsBY+CrH2HLwEUsT4PLBALYYrW4nL4fb20TtJdZn0OSPl4t
         JCjA==
X-Gm-Message-State: ABy/qLbe5roLF47z66dG2xYX49ztrf6xtlrIzlIulOuPfnea28JGwJ/C
        RGVLs6ehhFSG6DKQ329p4gayMt6ZbQokdg==
X-Google-Smtp-Source: APBJJlEeY0g9yw4hSXk8RydezZSdZt8Hcy03LohNKhy5LXsCKUJF5PAffGGFbF71AYvCqgMMp2cNDw==
X-Received: by 2002:aa7:c715:0:b0:51d:fa7c:c330 with SMTP id i21-20020aa7c715000000b0051dfa7cc330mr125878edq.26.1690815466486;
        Mon, 31 Jul 2023 07:57:46 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:1806])
        by smtp.gmail.com with ESMTPSA id k5-20020a05640212c500b005222c160464sm5556775edx.72.2023.07.31.07.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 07:57:46 -0700 (PDT)
From:   Gustavo Luiz Duarte <gustavold@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH] net: ipmr: Call ipmr_ioctl() directly from ipmr_sk_ioctl()
Date:   Mon, 31 Jul 2023 07:57:13 -0700
Message-Id: <20230731145713.178509-1-gustavold@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call ipmr_ioctl()/ip6mr_ioctl() directly from ipmr_sk_ioctl()/ip6mr_sk_ioctl()
and avoid sk_prot->ioctl function pointer indirection.

Also, delete the sock_ioctl_inout() helper as it is no longer needed.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
---
 include/linux/mroute6.h | 33 ++++++++++++++++++++++++++-------
 include/net/sock.h      |  2 --
 net/core/sock.c         | 20 --------------------
 net/ipv4/ipmr.c         | 33 ++++++++++++++++++++++++++-------
 4 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/include/linux/mroute6.h b/include/linux/mroute6.h
index 63ef5191cc57..1ed34264bb72 100644
--- a/include/linux/mroute6.h
+++ b/include/linux/mroute6.h
@@ -103,19 +103,38 @@ extern int ip6mr_sk_done(struct sock *sk);
 static inline int ip6mr_sk_ioctl(struct sock *sk, unsigned int cmd,
 				 void __user *arg)
 {
+	int ret;
+
 	switch (cmd) {
-	/* These userspace buffers will be consumed by ip6mr_ioctl() */
 	case SIOCGETMIFCNT_IN6: {
-		struct sioc_mif_req6 buffer;
+		struct sioc_mif_req6 karg;
+
+		if (copy_from_user(&karg, arg, sizeof(karg)))
+			return -EFAULT;
+
+		ret = ip6mr_ioctl(sk, cmd, &karg);
+		if (ret)
+			return ret;
+
+		if (copy_to_user(arg, &karg, sizeof(karg)))
+			return -EFAULT;
 
-		return sock_ioctl_inout(sk, cmd, arg, &buffer,
-					sizeof(buffer));
+		return 0;
 		}
 	case SIOCGETSGCNT_IN6: {
-		struct sioc_sg_req6 buffer;
+		struct sioc_sg_req6 karg;
+
+		if (copy_from_user(&karg, arg, sizeof(karg)))
+			return -EFAULT;
+
+		ret = ip6mr_ioctl(sk, cmd, &karg);
+		if (ret)
+			return ret;
+
+		if (copy_to_user(arg, &karg, sizeof(karg)))
+			return -EFAULT;
 
-		return sock_ioctl_inout(sk, cmd, arg, &buffer,
-					sizeof(buffer));
+		return 0;
 		}
 	}
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 2eb916d1ff64..0df582e3776a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2969,8 +2969,6 @@ int sock_get_timeout(long timeo, void *optval, bool old_timeval);
 int sock_copy_user_timeval(struct __kernel_sock_timeval *tv,
 			   sockptr_t optval, int optlen, bool old_timeval);
 
-int sock_ioctl_inout(struct sock *sk, unsigned int cmd,
-		     void __user *arg, void *karg, size_t size);
 int sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg);
 static inline bool sk_is_readable(struct sock *sk)
 {
diff --git a/net/core/sock.c b/net/core/sock.c
index 9370fd50aa2c..e0002805ecbd 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4129,26 +4129,6 @@ int sock_bind_add(struct sock *sk, struct sockaddr *addr, int addr_len)
 }
 EXPORT_SYMBOL(sock_bind_add);
 
-/* Copy 'size' bytes from userspace and return `size` back to userspace */
-int sock_ioctl_inout(struct sock *sk, unsigned int cmd,
-		     void __user *arg, void *karg, size_t size)
-{
-	int ret;
-
-	if (copy_from_user(karg, arg, size))
-		return -EFAULT;
-
-	ret = READ_ONCE(sk->sk_prot)->ioctl(sk, cmd, karg);
-	if (ret)
-		return ret;
-
-	if (copy_to_user(arg, karg, size))
-		return -EFAULT;
-
-	return 0;
-}
-EXPORT_SYMBOL(sock_ioctl_inout);
-
 /* This is the most common ioctl prep function, where the result (4 bytes) is
  * copied back to userspace if the ioctl() returns successfully. No input is
  * copied from userspace as input argument.
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 3f0c6d602fb7..0144da36e6c0 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1550,19 +1550,38 @@ int ip_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 /* Execute if this ioctl is a special mroute ioctl */
 int ipmr_sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 {
+	int ret;
+
 	switch (cmd) {
-	/* These userspace buffers will be consumed by ipmr_ioctl() */
 	case SIOCGETVIFCNT: {
-		struct sioc_vif_req buffer;
+		struct sioc_vif_req karg;
+
+		if (copy_from_user(&karg, arg, sizeof(karg)))
+			return -EFAULT;
+
+		ret = ipmr_ioctl(sk, cmd, &karg);
+		if (ret)
+			return ret;
+
+		if (copy_to_user(arg, &karg, sizeof(karg)))
+			return -EFAULT;
 
-		return sock_ioctl_inout(sk, cmd, arg, &buffer,
-				      sizeof(buffer));
+		return 0;
 		}
 	case SIOCGETSGCNT: {
-		struct sioc_sg_req buffer;
+		struct sioc_sg_req karg;
+
+		if (copy_from_user(&karg, arg, sizeof(karg)))
+			return -EFAULT;
+
+		ret = ipmr_ioctl(sk, cmd, &karg);
+		if (ret)
+			return ret;
 
-		return sock_ioctl_inout(sk, cmd, arg, &buffer,
-				      sizeof(buffer));
+		if (copy_to_user(arg, &karg, sizeof(karg)))
+			return -EFAULT;
+
+		return 0;
 		}
 	}
 	/* return code > 0 means that the ioctl was not executed */
-- 
2.40.1

