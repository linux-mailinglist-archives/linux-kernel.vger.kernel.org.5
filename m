Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DD1772668
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjHGNrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjHGNrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:47:19 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F60A10D5;
        Mon,  7 Aug 2023 06:47:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1bbd03cb7c1so28376995ad.3;
        Mon, 07 Aug 2023 06:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691416037; x=1692020837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujZiVs9WYzU9nGaUspRh3pJHwz3VwVmUv7LZdW5BRhE=;
        b=QiU/70y8hV0yRGawTxx8X4WMJJJ6A8PQ/M+j1eP1xpUj2WI6TkxhC9NoGqo2Yc1ly1
         MyFyd/zy5EHwdxAhxKYiM/rZ43ZctBXvSijSH4Y264vd8QyoMisSzrBBuOxug/okDsG6
         MVG8gX1VYvds4lLcWKZZsQvxHXuI0RijwimGg0uAXi8Cb4OWIgf/s/weRONZ0F8hL/UZ
         Y/9xbPyR9418eLrcia8NaCFYu2VwzpKkKWxBCLHWahB4dyQupl2pSl3bQLipvXu7Wksb
         8P9JEQMf4N2P8/CnIzaAwY7GGMYhER/I7ie+8WtTQ9FBtClII7che7vCP/T9ttpF3eyz
         zMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691416037; x=1692020837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujZiVs9WYzU9nGaUspRh3pJHwz3VwVmUv7LZdW5BRhE=;
        b=OvRiq/YXP7H81Svv9Om+qQXUpOm8fZ+/5DMRRQAkor4kqRkBjfNMU/MXIryK1R1+bf
         LuQ8JUT+pRhbn2JpOSYTltYEe80P4YywOVGdUnSDfs5/t+CKJ5y5r/LEeQK/MZx/P7nH
         h8PBUNAmUQgCticlexzKKJctY/pSeRfWMiTt2YKW4ZTJiaX0wDLWGG5wmn3wPZc2JUap
         Rj3dz8MV9s4q58IfIqvdd3fGqY9uMiw66Vb4QoIj2Li2eQpIgCiEwqYn3WuTvgzO8zkO
         jV1LucpJzDqUoGjK4GxY+E1Hmm7UHrPPaH8cxtRN5JMryxj/+hm/gT10FuIjH+oyhir0
         OfLA==
X-Gm-Message-State: AOJu0Yy81832ttY8/itMj2JfQqs23L6T1ZOxL7cZgB2kPVQVv602rJqn
        nAG5Y1fgzLI8gQCAvm9MqeA=
X-Google-Smtp-Source: AGHT+IHqAZ/HoDVBS19gynk+DiCMvNQ708LWevboxkgOEgFd7C8CKbB6TI9I0CALezHxRYM/YYDfJg==
X-Received: by 2002:a17:902:dad2:b0:1b6:6c32:59a8 with SMTP id q18-20020a170902dad200b001b66c3259a8mr7472543plx.36.1691416037440;
        Mon, 07 Aug 2023 06:47:17 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.23])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001b54a88e4a6sm6912097plt.51.2023.08.07.06.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:47:16 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com, ncardwell@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next v2 2/3] net: tcp: allow zero-window ACK update the window
Date:   Mon,  7 Aug 2023 21:45:46 +0800
Message-Id: <20230807134547.2782227-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807134547.2782227-1-imagedong@tencent.com>
References: <20230807134547.2782227-1-imagedong@tencent.com>
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
index aae485d0a3b6..f17cca362086 100644
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

