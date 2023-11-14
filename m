Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618957EB2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjKNOnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjKNOns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770ADCA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699973024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mQIaQPMOld1Kc5nwv0wGbX0LFpmGQ9KKGNwoI/vm3Ic=;
        b=Evm2cY8XOGjOghpu84xE4s8MxGXF99GLdbKtpwGS98yvBNy0zM80cQV4y5ztNuGPrUhB/b
        0a6H2LCFzttYdLHZ74+gds9XBRWJnBssmaZN1+ltJ7KTHZowAi/r6uq3L8tdz8lSHHxTax
        Og+0cOklinwHTKNfQaqQ+lVW8hovsSQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-zdfsMsppMZ29l6cj5Sa4oA-1; Tue, 14 Nov 2023 09:43:43 -0500
X-MC-Unique: zdfsMsppMZ29l6cj5Sa4oA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-58b57d05c70so5350208a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699973022; x=1700577822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQIaQPMOld1Kc5nwv0wGbX0LFpmGQ9KKGNwoI/vm3Ic=;
        b=rKNHclv8Tjtjfmuuc0oXPQpCupUKG62KSpYs2nBGNjXUD+6huA4cGC7UGNuPzn6QEa
         4yF0lRvr04WdW9SzGrB9ZeJEftG5XmFLOU7/zROhkKXVSxbMRT3vcuRy+s/LoZ/DPoNd
         nDiLTvPyx52qczLM0sKOypc5buvmmmfPG2Wuo7feHaPERJthPIwJSamdq/8GHPYnXZ13
         HP6/T9r95VNl5dwqNqtrvi4LV+Mdt8cNPgaV6zcD4VXJxzyQoefIKkFD31aKStiUzVjy
         gNdVVG/YMzDRH6mkEprQ1ZjoLoBVCi5xJOwrkglHmMgkmdfZUMCW8vmojdYphlT7S6us
         O2gw==
X-Gm-Message-State: AOJu0YzScd5GHNKCakiARPqQO3FTQ3JwO4PMfrQDuMXgmaIMXp0nboA1
        iP/W3pxLLUot7AQ3odDDLFaHtY0V7jVi8eCmSl07XwmT60RihrKWpRiJRrmfsWJbFfdyNurWYIk
        IeDqtUYQ0eonN7pqOOFf6nEn5
X-Received: by 2002:a05:6a20:8403:b0:186:aac2:26b9 with SMTP id c3-20020a056a20840300b00186aac226b9mr6086432pzd.30.1699973022209;
        Tue, 14 Nov 2023 06:43:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK7BkhMmeEDIpgWq8BX2/zMWGfrbmoU5cFlw762Ol84eWMWoCowEUrKngx/sMldw6NAmVs4Q==
X-Received: by 2002:a05:6a20:8403:b0:186:aac2:26b9 with SMTP id c3-20020a056a20840300b00186aac226b9mr6086409pzd.30.1699973021834;
        Tue, 14 Nov 2023 06:43:41 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b006c33c82da67sm1208825pfe.213.2023.11.14.06.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:43:41 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net] tipc: Remove redundant call to TLV_SPACE()
Date:   Tue, 14 Nov 2023 23:43:36 +0900
Message-ID: <20231114144336.1714364-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Fixes: d0796d1ef63d ("tipc: convert legacy nl bearer dump to nl compat")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
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

