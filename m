Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287EA7EEA66
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 01:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbjKQAhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 19:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQAhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 19:37:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C001AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 16:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700181439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gLq9QND6ayr1x65UPXkRh82Mu4Sx1+2cD2sZ+Ae8qnc=;
        b=LV/jzk7XPLukx1wWFELwh2yiZ/p/CI0YSY5ytm9beQqSSu0AeAxRtpBOGkkDue6PPd43hA
        RBcnOiR1XugoFS6Fr5UOjhwN/6dh5JliHkTI/+nXRaA/P2oV/1ySenKO4UjVaQVm2khSdz
        IdYVfSbg/t4pp45Kdv//NIOTq9h+t/U=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-Ozoe3NZhOr-xyr9bW4hygQ-1; Thu, 16 Nov 2023 19:37:18 -0500
X-MC-Unique: Ozoe3NZhOr-xyr9bW4hygQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ce5d31e709so2940295ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 16:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700181437; x=1700786237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLq9QND6ayr1x65UPXkRh82Mu4Sx1+2cD2sZ+Ae8qnc=;
        b=fLseR2p2HKouZ7EL/J4dqQMpH61Dt0luiydCjuP9G0szUAVdh72OKjOmGa/6kemkw9
         p1tjHHYBWpXspOn4ebISa2DfSWo9LftdEVxCgspINThcKJ0znlNmGO7u4buCN8BZkyQW
         sJz/AiWekRg7mLJt9XYnR1y4BMmxVgYf5KiOXHN9IIuJ8bLKn7WxGeRQke6DHuPdRWCG
         DoXJpz3CX+QeM4tbwkkLcFmi3A3Ln54pW7i19OUoewdYHGeuqwxs6SBJ4Whbr03iXyPq
         /jPDJS1EmkUK6ROmKdCwrWzcpCXiTGnwtBMEA8Pp324PFqZ5aWUJQCaB6knK8U36lBrd
         XAFg==
X-Gm-Message-State: AOJu0YxRV/Z86PCxm/UXJylKJvo8sGMSjDOZ4uxBH0P6UxI1/zpkqnN1
        EMkaNwUrWrJBljlcAuOPGWWkIQO9VrAN0cWuOvnQAnhKavRQ5NIy/eS03n/CTM3zLOPOr6dUK5D
        1G8oqlabtKSy2qX94Qao5laqO
X-Received: by 2002:a17:902:ab47:b0:1c9:dfb8:a5a0 with SMTP id ij7-20020a170902ab4700b001c9dfb8a5a0mr9979182plb.10.1700181437143;
        Thu, 16 Nov 2023 16:37:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwhqCMmksgqBhmIr37nfnk0at0x9kkOfJxVQwaXdZidniXfUab2Rhk+ksUDMtc+ZNY8tJiIA==
X-Received: by 2002:a17:902:ab47:b0:1c9:dfb8:a5a0 with SMTP id ij7-20020a170902ab4700b001c9dfb8a5a0mr9979170plb.10.1700181436840;
        Thu, 16 Nov 2023 16:37:16 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902a40700b001ca4cc783b6sm256213plq.36.2023.11.16.16.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 16:37:16 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net-next v2] tipc: Remove redundant call to TLV_SPACE()
Date:   Fri, 17 Nov 2023 09:37:04 +0900
Message-ID: <20231117003704.1738094-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of TLV_SPACE() is to add the TLV descriptor size to the size of
the TLV value passed as argument and align the resulting size to
TLV_ALIGNTO.

tipc_tlv_alloc() calls TLV_SPACE() on its argument. In other words,
tipc_tlv_alloc() takes its argument as the size of the TLV value. So the
call to TLV_SPACE() in tipc_get_err_tlv() is redundant. Let's remove this
redundancy.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
v1->v2:
- Re-submit to net-next
https://lore.kernel.org/all/20231114144336.1714364-1-syoshida@redhat.com/
---
 net/tipc/netlink_compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index 5bc076f2fa74..db0365c9b8bd 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -167,7 +167,7 @@ static struct sk_buff *tipc_get_err_tlv(char *str)
 	int str_len = strlen(str) + 1;
 	struct sk_buff *buf;
 
-	buf = tipc_tlv_alloc(TLV_SPACE(str_len));
+	buf = tipc_tlv_alloc(str_len);
 	if (buf)
 		tipc_add_tlv(buf, TIPC_TLV_ERROR_STRING, str, str_len);
 
-- 
2.41.0

