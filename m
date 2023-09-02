Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE57B7908CF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjIBRIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 13:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIBRIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 13:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F8BE5B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693674452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lrrM2Y/zZF7w803gWmPyZ7A2zLr5CJoErzGeQi8Jcu8=;
        b=GhrJxWQP1ukpv80E60U5CbM3VF+jOxvgyI3CgROdC1rEYd9H25ChWqyOxsNmw8Kk/mvPkd
        E0KQC3MSJQLYZlDLBC7fLz7WS+CLfPnQHJNX21GzqVy6LDI2huHRxQwrNxj+6S3DHY+H7x
        Xni1uodRbNpCrFRuVjcFJOv7xyST1mY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-CzsZz52iNb-ANEbFpKmfOQ-1; Sat, 02 Sep 2023 13:07:30 -0400
X-MC-Unique: CzsZz52iNb-ANEbFpKmfOQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1bf707f526bso962175ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 10:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693674449; x=1694279249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrrM2Y/zZF7w803gWmPyZ7A2zLr5CJoErzGeQi8Jcu8=;
        b=g7dW/saG5Y27L6Sg42gsQaypRC6RGYqzKYY6ps4sqZp4OsR2zV8duMBUGapiMW+hMZ
         GM5udkcQt0nToDDRpzX0OaP8JwifIBCBrrIXa2Y9N6vuVKZ1P/0SvAxDXy+LLkqhQ16A
         S4ETdzypKIM90OcmzkJPtLuNQkc9PEfYts+J7AEzG30kP+oc32Mn+66mvGzfadBw0vPQ
         SSXR0SQnrJpCwVFKXLZK1utE88CQy8LsTb2dvZAfYWtoh182IO1bBoigKyCx/d/PNpiW
         O2Uj1h58+pGpZDI3YsDragluqItvPun6WCX6yi1nT8JdLXRrJAijErCZdSRBUonT2KSt
         y/zw==
X-Gm-Message-State: AOJu0Yyn8ub4yAuNOYj1F1jMSRkZbA8axw3m5ROXz4b7vxXBkaqe9ljC
        MhyKazTRTNlNDtk/0bXsT5M67QaNOwVza0CqoMuIdPezbZZFju7tIs1BkXXUmxsEaQf+AjrMuU5
        Ra7D+dYc/i9ipAVOMZBNgIMX8
X-Received: by 2002:a17:902:c209:b0:1b8:6850:c3c4 with SMTP id 9-20020a170902c20900b001b86850c3c4mr5299033pll.22.1693674449283;
        Sat, 02 Sep 2023 10:07:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuy1UPUdxrNCdMmJkPvNypnCa/jr3jSd4rwfJxeJe9vwdZGPIw7NzRd5+fBKpBjT71d9P+Ew==
X-Received: by 2002:a17:902:c209:b0:1b8:6850:c3c4 with SMTP id 9-20020a170902c20900b001b86850c3c4mr5299022pll.22.1693674448968;
        Sat, 02 Sep 2023 10:07:28 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id ji5-20020a170903324500b001b9dadf8bd2sm4870370plb.190.2023.09.02.10.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 10:07:28 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net] kcm: Destroy mutex in kcm_exit_net()
Date:   Sun,  3 Sep 2023 02:07:08 +0900
Message-ID: <20230902170708.1727999-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kcm_exit_net() should call mutex_destroy() on knet->mutex. This is especially
needed if CONFIG_DEBUG_MUTEXES is enabled.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/kcm/kcmsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 393f01b2a7e6..4580f61426bb 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1859,6 +1859,8 @@ static __net_exit void kcm_exit_net(struct net *net)
 	 * that all multiplexors and psocks have been destroyed.
 	 */
 	WARN_ON(!list_empty(&knet->mux_list));
+
+	mutex_destroy(&knet->mutex);
 }
 
 static struct pernet_operations kcm_net_ops = {
-- 
2.41.0

