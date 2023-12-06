Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C9F807570
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377992AbjLFQly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjLFQlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:41:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392D8D4D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701880916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BRBYbA6A9iVFJVJw2yLnCuRWTbq0bYeGysrV9jksr78=;
        b=HvwHU/3wBwdD8oPXKZ2+jR1CI5hSr+MJuSguM9HX7nXpd2cZH6S2D6PxOwqo4tYJcuM7NP
        0/zD+/vmoqPpqJzujAOcdKB9OxHQKxiPDm+TxqH/+FxVOlgkvUpWJEeV8U3Y/X9YNhpNYI
        bjFrf39TuMgC85HBIA1fszBxXyXxFC0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-A3tHQDjNOVq_7hoHC3IhPw-1; Wed, 06 Dec 2023 11:41:55 -0500
X-MC-Unique: A3tHQDjNOVq_7hoHC3IhPw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-423f2e9ed5dso11235761cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 08:41:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880914; x=1702485714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRBYbA6A9iVFJVJw2yLnCuRWTbq0bYeGysrV9jksr78=;
        b=SzEbg4sfNSdt64C3ie9oyMr6CM5RB9r8M40xTHG250T1B03dDMprUNngSjNUFXhW+/
         n3xZyA92QKzWA6tiwlcowRV8zBrt4N4Noqa9VNvGqZD65a+4s6xpEPeWuQD7tO/1+J6F
         8g3lYcKhtmZFhwhMmiGhPhGVPxGedGifTTSpB+GLVtm0J3T60uiEj45PPVGCB7+4kti2
         xCE9WKFaX4Wn6KY4ppQHTsALXaPj5b6wHAIeqpDDj6/lEr4nYSbK7r6kJxqv7R1/Aq6A
         LPXlgesNdO988jRaGsPC07rz4iorB4nzggrFCYD+1r2KMoq5JqKPmJ2X/eMqNZo7WtYh
         FxzA==
X-Gm-Message-State: AOJu0Yyrj/BRNVul7Cj+ONfUU6Yjix18beMDOeVIVNY5DXk5qT7Us4Kj
        3dWpwGHAl4iIjqjOSD6dzq/8qlPnKOcdXUQTTO1SN6qDank5cTvBX1DTytKkrGsz1/opMloAB0b
        5rTIPuQLNJ/vvbBzDr7zaJ7qH
X-Received: by 2002:ac8:5b95:0:b0:425:4043:2a05 with SMTP id a21-20020ac85b95000000b0042540432a05mr1420274qta.128.1701880914551;
        Wed, 06 Dec 2023 08:41:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaJIB6NOvZQTIiVkkPSR38mjWBsiSx+xgzPD2epv6qC/zaKWzLLIvu6i12qCTPMRBfNOkUNA==
X-Received: by 2002:ac8:5b95:0:b0:425:4043:2a05 with SMTP id a21-20020ac85b95000000b0042540432a05mr1420258qta.128.1701880914272;
        Wed, 06 Dec 2023 08:41:54 -0800 (PST)
Received: from step1.redhat.com (host-79-46-200-125.retail.telecomitalia.it. [79.46.200.125])
        by smtp.gmail.com with ESMTPSA id e25-20020ac86719000000b00423e8021da2sm78802qtp.42.2023.12.06.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:41:53 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux.dev,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Arseniy Krasnov <avkrasnov@salutedevices.com>,
        Stefano Garzarella <sgarzare@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] vsock/virtio: fix "comparison of distinct pointer types lacks a cast" warning
Date:   Wed,  6 Dec 2023 17:41:43 +0100
Message-ID: <20231206164143.281107-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After backporting commit 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY
flag support") in CentOS Stream 9, CI reported the following error:

    In file included from ./include/linux/kernel.h:17,
                     from ./include/linux/list.h:9,
                     from ./include/linux/preempt.h:11,
                     from ./include/linux/spinlock.h:56,
                     from net/vmw_vsock/virtio_transport_common.c:9:
    net/vmw_vsock/virtio_transport_common.c: In function ‘virtio_transport_can_zcopy‘:
    ./include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
       20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
          |                                   ^~
    ./include/linux/minmax.h:26:18: note: in expansion of macro ‘__typecheck‘
       26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
          |                  ^~~~~~~~~~~
    ./include/linux/minmax.h:36:31: note: in expansion of macro ‘__safe_cmp‘
       36 |         __builtin_choose_expr(__safe_cmp(x, y), \
          |                               ^~~~~~~~~~
    ./include/linux/minmax.h:45:25: note: in expansion of macro ‘__careful_cmp‘
       45 | #define min(x, y)       __careful_cmp(x, y, <)
          |                         ^~~~~~~~~~~~~
    net/vmw_vsock/virtio_transport_common.c:63:37: note: in expansion of macro ‘min‘
       63 |                 int pages_to_send = min(pages_in_iov, MAX_SKB_FRAGS);

We could solve it by using min_t(), but this operation seems entirely
unnecessary, because we also pass MAX_SKB_FRAGS to iov_iter_npages(),
which performs almost the same check, returning at most MAX_SKB_FRAGS
elements. So, let's eliminate this unnecessary comparison.

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Cc: avkrasnov@salutedevices.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f6dc896bf44c..c8e162c9d1df 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -59,8 +59,7 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 	t_ops = virtio_transport_get_ops(info->vsk);
 
 	if (t_ops->can_msgzerocopy) {
-		int pages_in_iov = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
-		int pages_to_send = min(pages_in_iov, MAX_SKB_FRAGS);
+		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
 
 		/* +1 is for packet header. */
 		return t_ops->can_msgzerocopy(pages_to_send + 1);
-- 
2.43.0

