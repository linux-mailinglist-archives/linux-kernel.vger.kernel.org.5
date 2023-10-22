Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6857D245A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjJVQUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjJVQUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:20:40 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25447D7B;
        Sun, 22 Oct 2023 09:20:38 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7788db95652so182823985a.2;
        Sun, 22 Oct 2023 09:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991637; x=1698596437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QjLK10gOjLyBhjnmz7OKoZPoDInuhNvXPFVtbeHVZ/Y=;
        b=g/GlPv0Zhl1w3yNguY+dkzDGndcNOurb34FXRRWSrkVGz9zKFS04S6QTmY/FGsCkVW
         20+s2rR7JrhiJ/DXxewMwjZotXSmr1VY3YC+YcKk/81QD2ukE26IH8qAuRevLGUSJmeZ
         sIeNfi5LlSRpN172SsWym+OmEXONlro3ic94ftTDyjmtwf4n1R98HeCRc9AguZ9qGn6f
         5SmORnykAxzaElLUV/gZ3ACL73rp0khbyXJsXPqEuqDaLUBDJEg7q0Mp8TbVFOND1cII
         ItwZ/bR81hktCaA8XvpPeRGGbFg+EU7hU2N4G3Ur1gV4FNkdsY85SUtP9hkloiiAIFwu
         5BHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991637; x=1698596437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjLK10gOjLyBhjnmz7OKoZPoDInuhNvXPFVtbeHVZ/Y=;
        b=nseg0BmsfkmJ85sSOp+n7mGhftyraiCF5GLgb5IRsiFns65wYI76uFcZQnEnWd//8o
         irHR0FPwL51NpWgOP1xvzkOdV3Iw2R+PyLQUL2/Ubj/gNSbXXt+jF6rWEndFvoFnRdHp
         bdWSRxUQNc8Wddf2shPfF2O/LnvPwOaksH7slvsOTwQZvee/AIKEx2bJSEDRzcDZCdrK
         1/cirFAM1uiQFnMeV14zNGVY+SyuqLoNdf55EK3Pfw8hnG11o0IMy7OsTxTCRZYianD3
         AMJXerNTpX89CRV1qTOq5hURymtN1Mh22upN+no5AXJmwRxMYkD3am3Ib2tNexc1Fejg
         zr3Q==
X-Gm-Message-State: AOJu0YzjVA3imSjnrQqbsYpWJGjY6ZjMuVOUEAFOrMMfeeGdG1e/ae55
        O8y6dD5oP49xU93yDYCXnH5qhOexA3tUe5b0
X-Google-Smtp-Source: AGHT+IF6IF7PiiL05w2lscUsZuxa0kKMIy3FEDAf1RfzauBfE5lzZ7IeEvfVQb6djUsC6QS8lXj16g==
X-Received: by 2002:a05:620a:4550:b0:76f:839:6bdd with SMTP id u16-20020a05620a455000b0076f08396bddmr9931828qkp.3.1697991636887;
        Sun, 22 Oct 2023 09:20:36 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id a24-20020a05620a103800b00767da10efb6sm2110025qkk.97.2023.10.22.09.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:20:36 -0700 (PDT)
Date:   Sun, 22 Oct 2023 12:20:35 -0400
From:   Oliver Crumrine <ozlinuxc@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.n
Subject: [PATCH net-next 06/17] Update code for cork as a pointer
Message-ID: <29d13b7a3b74d7922b199ab70baa15569f453fe8.1697989543.git.ozlinuxc@gmail.com>
References: <cover.1697989543.git.ozlinuxc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697989543.git.ozlinuxc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the corks are pointers, they don't need to be referenced to be
passed into __ip6_make_skb.

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 include/net/ipv6.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index c6932d1a3fa8..88eded2662ff 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1122,8 +1122,8 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 
 static inline struct sk_buff *ip6_finish_skb(struct sock *sk)
 {
-	return __ip6_make_skb(sk, &sk->sk_write_queue, &inet_sk(sk)->cork,
-			      &inet6_sk(sk)->cork);
+	return __ip6_make_skb(sk, &sk->sk_write_queue, inet_sk(sk)->cork,
+			      inet6_sk(sk)->cork);
 }
 
 int ip6_dst_lookup(struct net *net, struct sock *sk, struct dst_entry **dst,
-- 
2.42.0

