Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FBE7EE822
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345396AbjKPUL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjKPUL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:11:57 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B124B3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:11:54 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2ec5ee2e4so760637b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700165513; x=1700770313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w2peqo+SYVQgbTF6odymZNSu+sZ00cIgIYlcjFlppWM=;
        b=MzesG7g3i8qt5IBoUzsxdwY7I600BmpV87GNM5DQhg0hA+cSya0lonorx7/kcl8Jc0
         yWaAoEHI+tlGAwqjobJh8WHP0axD94ET+YATbdCfT/vphU8d72sh2vtmHQ7uiDvIPIsv
         fysrbH51sTFSLrk9UMQAohFWF5rR9hQBB6W8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700165513; x=1700770313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2peqo+SYVQgbTF6odymZNSu+sZ00cIgIYlcjFlppWM=;
        b=hqCrLWH9jXQKG6sPdGhJZZuRZt2N/EvTiYzLcPgjk2QIqyLeySNLBlxIhTD4SemBgN
         54pogMCXpO83APRMe6+iI6p4YRjzx8VvnprcImGczyfxhOUNnY1c8I9TLthKEimM2fFZ
         dDPWQchh3MQVJi7aEq8MATYqPZJx6JP7E5xjrSegmVy5sRZRydJPq7Xs5qEPaAS6Zq6p
         nxUv8gbHNgM4w2jGaMxNlw+FCS6Wv5sqpcoyYhONtP/FRjNCQGEhG8R5A+K6Uug3Y1Wy
         Et7OOWjEGPAiATz4ZxaJa1HeDN5NLV9KaKsiQESjCmhwJVqsb0vpV1rxZeJXrkrBk6RK
         XV6g==
X-Gm-Message-State: AOJu0YxrA94P2BJIrE5D2SWig3c54wcr7C0MUbgcZPfYVinuag8Tu6Yk
        Xz6Sf3tzrumklpHyQux5gT5v8Q==
X-Google-Smtp-Source: AGHT+IHHS27q9Zol1WZfao+OWS6LqfHtSOy7auNOYxNNvA5QCM5TNvcbBs4bj/jenhCC5LoEFl+7MQ==
X-Received: by 2002:a05:6808:202a:b0:3ae:a81:55a9 with SMTP id q42-20020a056808202a00b003ae0a8155a9mr23090946oiw.24.1700165513547;
        Thu, 16 Nov 2023 12:11:53 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j26-20020a63551a000000b005b529d633b7sm101355pgb.14.2023.11.16.12.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 12:11:52 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add netdev subsystem profile link
Date:   Thu, 16 Nov 2023 12:11:51 -0800
Message-Id: <20231116201147.work.668-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=keescook@chromium.org;
 h=from:subject:message-id; bh=ix3E5+mpX2+wWYY/dmA26qPFSe5TqgzyFgYbY0i+LqA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlVneHMkrUTIl41b1SKNI4TkufbDe3uul9AZl+q
 /WfNMumb3yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVZ3hwAKCRCJcvTf3G3A
 Jh0oD/wNsSPwMniWu2bzU9OJhEovajw1GN8hxsOmemJsLBYKdg9R9zO1l7UKgyPjnKJMt5n86IM
 02541MKA1uWNwInV6KZqFiiLB/+6gCJUzsY7DZ06BIDH+z6oDh8kqLw3KGMvPc9CGuhXwBSLeL7
 JunGL2wtooeHHXbsmzqyJRQtY++gfAWDsrMBuudMc41i4TlbBDVxJi9ZrGcrPv/ObKlsK3AdFH0
 m2SEHxhp5aLBn0iYiYKzdNe9XaCQRhY7SrkxaU40R6RooUocbn++yJ/0MnPfVo4JDmwrcBjgmxX
 rYEvPoJSgzUtFp9nrUVbdVzFrbBho7+xAmxnmTZl1FPSrifk3Aka39/BTDfzEvJZHf7u5S0IW4i
 BGm0iMDUvZjO7Gf5VKFW/96pplKslQ5zSEShPQr6+QNL7a5k5aZQyUGC76Vb7vtiTNSt8w8pF2O
 pTRmoutNr8UvyWEIFuhKzWq2fUVRRibVSLmjHRcVd3kTCoiivuKyvzhDVzyx1YtjTLBhRtgjDKk
 HzYRCRDeDXwNvc9yeaKutTpJx1tSiEWbVE8nSPlUx6JckhQpHs3QIXFRKeQSFGhj8dvPK8LNsTh
 6t6hGmbqC4SxSt7aKNpTyW1PPLDP5f1due559QlUJn+m5B3PqVlu+Tj9NRqpGdkKvqp4QjETdkz
 dM3T2Rz vv9xN20Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The netdev subsystem has had a subsystem process document for a while
now. Link it appropriately in MAINTAINERS with the P: tag.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..b6d570c4eda6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14995,6 +14995,7 @@ M:	Jakub Kicinski <kuba@kernel.org>
 M:	Paolo Abeni <pabeni@redhat.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+P:	Documentation/process/maintainer-netdev.rst
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
@@ -15046,6 +15047,7 @@ M:	Jakub Kicinski <kuba@kernel.org>
 M:	Paolo Abeni <pabeni@redhat.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+P:	Documentation/process/maintainer-netdev.rst
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 B:	mailto:netdev@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
-- 
2.34.1

