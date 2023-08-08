Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675637742DA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjHHRvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjHHRut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:50:49 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1FD9EC4;
        Tue,  8 Aug 2023 09:22:42 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id af79cd13be357-76c8dd2ce79so553474785a.1;
        Tue, 08 Aug 2023 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691511740; x=1692116540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nhz2+yXHajZnOYlDCo8CCrQ4By4cAhwFG/S6tJ/BEs=;
        b=smgq4l5pqVlPVvW/cItPB+/vNnEpRlbTOqquu8fjl0JTgwlDWqCHxptoR5z0/pqiUU
         i3jZVELHVmZPdmLsO06WA2TGsc0eo+LRMWYa2pM3wDK8q2E938BvNL3P2ml60Z55AwKv
         Igd7K8q9MIN4OIDRc1mzMvfmIZYl/X5nn55QKL5tjVanXWOH5zf1Eyxl5hXd3h+JEnN2
         Ga3xzRO3Mop3Sh/eBsFctiJvHKnWh6X5BCdLFCpVaNR3+wvYmlROlx7tBnh8R69YqO6+
         Q0ZhCrMiAp6oosTtRxDYWMx3QA8FAUysieU8DkRUOyJg4hHsD2tHe9DiYJWy1sU9pIBL
         y5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511740; x=1692116540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nhz2+yXHajZnOYlDCo8CCrQ4By4cAhwFG/S6tJ/BEs=;
        b=In0mTEB76cZ/WqcWPYeua8tTSx1tSN07WZjmRPj575ObMQHRWQK/Cucqa4OEoPFw8/
         KHcTmk9VLdY0iEbOe8vvjt2ggBamlz6MgKAudhHVvaaQyZtMV4y7QGoyE/KQ9O6lBmC/
         AuxGy05w9qYBEGvMemgMBOzcFBqRNNJ9dHdE3ihWT2+ARHbxyb5qbsnbNEO0k7gHodvb
         17CtNn9G7mBshuipM0bFSENDmqTn8YO61Lsiq+XfngFcb3qzEXNboBPWNMWOpG5NYndN
         U9rJaxQFqfb2FR24uJue11TyZzCitidqHCjIUjnYNNVr1o3ofx+M/Q5uNAif/QWfGOt5
         K1sQ==
X-Gm-Message-State: AOJu0YyLxG13YVn/XD8x7bxtP9RNVAQApaXaWeGIoDjYLxAj11/lL1Bq
        3UN2Xu4hYHi7xwUwbsWQRjHdYBjn1ZP4pF9t/u4=
X-Google-Smtp-Source: AGHT+IGDcprBdU/YGEJVmxmD2MiUy10xqa6E8xYjXFsuq2GGfBWfr75xn14FdeRLImTlStc0nYy2wA==
X-Received: by 2002:a05:6a20:1057:b0:13d:ac08:6b72 with SMTP id gt23-20020a056a20105700b0013dac086b72mr9944937pzc.18.1691495953949;
        Tue, 08 Aug 2023 04:59:13 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.11])
        by smtp.gmail.com with ESMTPSA id j22-20020a63e756000000b00563b36264besm6484136pgk.85.2023.08.08.04.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:59:13 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com, ncardwell@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next v3 2/3] net: tcp: allow zero-window ACK update the window
Date:   Tue,  8 Aug 2023 19:58:34 +0800
Message-Id: <20230808115835.2862058-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808115835.2862058-1-imagedong@tencent.com>
References: <20230808115835.2862058-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

Fow now, an ACK can update the window in following case, according to
the tcp_may_update_window():

1. the ACK acknowledged new data
2. the ACK has new data
3. the ACK expand the window and the seq of it is valid

Now, we allow the ACK update the window if the window is 0, and the
seq/ack of it is valid. This is for the case that the receiver replies
an zero-window ACK when it is under memory stress and can't queue the new
data.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2ac059483410..d34d52fdfdb1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3525,7 +3525,7 @@ static inline bool tcp_may_update_window(const struct tcp_sock *tp,
 {
 	return	after(ack, tp->snd_una) ||
 		after(ack_seq, tp->snd_wl1) ||
-		(ack_seq == tp->snd_wl1 && nwin > tp->snd_wnd);
+		(ack_seq == tp->snd_wl1 && (nwin > tp->snd_wnd || !nwin));
 }
 
 /* If we update tp->snd_una, also update tp->bytes_acked */
-- 
2.40.1

