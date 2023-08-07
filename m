Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B52D77181E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 03:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjHGByX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 21:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjHGByU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 21:54:20 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5729171A;
        Sun,  6 Aug 2023 18:54:19 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 41be03b00d2f7-564cd28d48dso962264a12.0;
        Sun, 06 Aug 2023 18:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691373259; x=1691978059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rdi5E1PQ0o3BBsXYa5VsiIGJTnnuGpESj+0QonmsL84=;
        b=M/wEYT1CZPMKVtpM5GRki9ggF4ijAfH1n4r9xHu5IlxTZACUWfF4uAwrmX/gMRpPXs
         D9IJ+P6Jo+ZKEZIN7ZClp9zu8OfsjMssXB+eLPX0Z2VzJGihg5ZiVaiTk7SK4k5iwFmE
         aEupIonSR2HnjrebgQXyRnjuEVCjmX8AhlfhgQdx3z1A5jSZqtT9/6C576EqWGeG2Rdj
         exN8SRTYRnksA1i2UcKGLcsgcBNFO6q1vlTkaHIiydzD1vnvDWx4bjQJ835tP5U7jjEN
         AXO8ofwEzGzGhYFhD4J8RMVEEJkbc+22U3Y656h2Sbo7hOV3kdVbW3a1DFCw4DXAxXnR
         ghsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691373259; x=1691978059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rdi5E1PQ0o3BBsXYa5VsiIGJTnnuGpESj+0QonmsL84=;
        b=M6EOrz2G+g9A0YJoHcADQOMBt0qc4DRFzv5E7WSOoYqSnZtOmZDpU5SBqpXnfpcMjJ
         g57S9FOBbGyUlob0FQnxWN7nNbLZ0rWisskYEQi6dnAmrvv1TLxHw10FQcTQqhC1PgSE
         JuiOj6F9UJW0//0kCnzZSsEF6IufgPJk0mnrUMdWn/vJkw6G7te8Gor/GavHqzutsB99
         o8DMl1e5DGdFDySx7yyTQmOa5dP4OyOUOD1LvkS/bKAF/RTAxhz20AY4e8uCJjFCgYV9
         h5EcVHOLqr5qs34qR0QgqX3R3cbBn/0nw7urvl/ONDp+I6xAUquNgd3Toz50dwhZVDtp
         /eeA==
X-Gm-Message-State: AOJu0YxZtuqjVKjVay6wrjUxFPZCrlQedaSh8YPbXR/6Hym0hQzSqD3a
        lxagkC5cl+Z8jmJhCY4MsAE=
X-Google-Smtp-Source: AGHT+IHFUuEvzi3RhS8HjthmkQv2x8UQhg4gV0GrRlpqPpqj9iaSoNg4keyDu3Hekat3+CyleVddOg==
X-Received: by 2002:a17:90a:1c09:b0:269:5821:5808 with SMTP id s9-20020a17090a1c0900b0026958215808mr1919828pjs.32.1691373259089;
        Sun, 06 Aug 2023 18:54:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x34-20020a17090a38a500b00263ba6a248bsm8115429pjb.1.2023.08.06.18.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 18:54:18 -0700 (PDT)
From:   xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     davem@davemloft.net
Cc:     dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>, Si Hao <si.hao@zte.com.cn>
Subject: [PATCH linux-next v2] net/ipv4: return the real errno instead of -EINVAL
Date:   Mon,  7 Aug 2023 01:54:08 +0000
Message-Id: <20230807015408.248237-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

For now, No matter what error pointer ip_neigh_for_gw() returns,
ip_finish_output2() always return -EINVAL, which may mislead the upper
users.

For exemple, an application uses sendto to send an UDP packet, but when the
neighbor table overflows, sendto() will get a value of -EINVAL, and it will
cause users to waste a lot of time checking parameters for errors.

Return the real errno instead of -EINVAL.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Cc: Si Hao <si.hao@zte.com.cn>
---
 net/ipv4/ip_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6ba1a0fafbaa..f28c87533a46 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -236,7 +236,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	net_dbg_ratelimited("%s: No header cache and no neighbour!\n",
 			    __func__);
 	kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREATEFAIL);
-	return -EINVAL;
+	return PTR_ERR(neigh);
 }
 
 static int ip_finish_output_gso(struct net *net, struct sock *sk,
-- 
2.15.2


