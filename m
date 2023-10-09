Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099247BD52D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbjJII0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbjJII0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:26:19 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC24AC;
        Mon,  9 Oct 2023 01:26:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-538575a38ffso6894114a12.1;
        Mon, 09 Oct 2023 01:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696839976; x=1697444776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZtyZM5UwNK1vdlTVhqvX8FdpSesET9nnywzUTMvlnU=;
        b=JzYE4dewsSL83JkXoc2qr0pwUqhP3gCxdCHkK9ZZ+IJu56+daDgZz6zv7J4PWIePdb
         h3kC6N0N7VtlVl7Ug82GCHDGnxD4qhtdbeXJQTeJksQMyCgQd4XAIvcgsFO4f6GDPACY
         X8L/tPZWN9MObSm1MLzcOjhvxCU7XBs/+8erSfsnooQGox2i2ROC8K7Xf1e5Fn0yEr4O
         MtlQj2npwNznCxO3ytbcdCkUXdQrZzvQZnIUtdbvvS+EWg0B8N44K7iuyI5lfp8gw7qT
         UlJlAGv3zjl5iQGpoxEORUrdAaimkBe06i3gF/0Z4dcStvDQXr/2nO5VLSkGIN6JxRdk
         xyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696839976; x=1697444776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZtyZM5UwNK1vdlTVhqvX8FdpSesET9nnywzUTMvlnU=;
        b=HmBsX3q6dAL0uH6ed8O8f8LtZfkF+znM4GrRvALV2OBVVzeVlUkl0qfN0uZ1a2oBp+
         DRjuVIjYFZf4FyviMBIgxCwvX/pcbmVOC11GqS6m2gHlAIxss4P1ewE5NyAVco73uy4u
         FpRh6GwdMtyS6qf58WTYE/vYYep3pXQJUaesBQO5NDHJzwuYOo5e2S/6o0gvH+Ch0bf5
         eJTyXyk09alNEpmpu3w496aigNBfpqlS39+oralT7gazxQM+N7PWSTVnZHn+FbyPF3F6
         gCEKSddG9rD3VHvP6I43db2j48JPgp3ooso2KwBRCeC/RTRCBA6o7AGoYBxKRotGy+gA
         fjeg==
X-Gm-Message-State: AOJu0YzXHBBH7Egogugpqg5BRS05nteL766AQuPoc7oyISYorAOvZypC
        d1Z3obs/ZvVOk+UmotRLIIg5fWRyO+g=
X-Google-Smtp-Source: AGHT+IGIbhGzFHVEyX2qL3XYXw9TNxMLPN8Qz0eEfIbGrSAzMf+0laqRxwW5pbhv5wkyAyr/ofTqDQ==
X-Received: by 2002:aa7:cf92:0:b0:523:102f:3ce1 with SMTP id z18-20020aa7cf92000000b00523102f3ce1mr12742631edx.10.1696839976258;
        Mon, 09 Oct 2023 01:26:16 -0700 (PDT)
Received: from tp.home.arpa (host-79-24-102-58.retail.telecomitalia.it. [79.24.102.58])
        by smtp.gmail.com with ESMTPSA id p22-20020a05640210d600b00530a9488623sm5844810edu.46.2023.10.09.01.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 01:26:16 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/7] ipv4: use tunnel flow flags for tunnel route lookups
Date:   Mon,  9 Oct 2023 10:20:56 +0200
Message-Id: <20231009082059.2500217-5-b.galvani@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009082059.2500217-1-b.galvani@gmail.com>
References: <20231009082059.2500217-1-b.galvani@gmail.com>
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

Commit 451ef36bd229 ("ip_tunnels: Add new flow flags field to
ip_tunnel_key") added a new field to struct ip_tunnel_key to control
route lookups. Currently the flag is used by vxlan and geneve tunnels;
use it also in udp_tunnel_dst_lookup() so that it affects all tunnel
types relying on this function.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 net/ipv4/udp_tunnel_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 494685e82856..a87defb2b167 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -232,6 +232,7 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 	fl4.fl4_dport = dport;
 	fl4.fl4_sport = sport;
 	fl4.flowi4_tos = RT_TOS(tos);
+	fl4.flowi4_flags = key->flow_flags;
 
 	rt = ip_route_output_key(net, &fl4);
 	if (IS_ERR(rt)) {
-- 
2.40.1

