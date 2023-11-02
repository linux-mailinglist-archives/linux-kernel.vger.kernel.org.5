Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669A77DED21
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjKBHMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjKBHM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:12:29 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210381AC;
        Thu,  2 Nov 2023 00:12:20 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b2e22a4004so391877b6e.3;
        Thu, 02 Nov 2023 00:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698909139; x=1699513939; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3WEBioVxJk3ym90q7TlVf9nmpXWD8MimLsKfSDcLwOE=;
        b=HmeF7Skhqt08Egb6OKEPs/wEjdUPj2Kop9OiLmG1LNQCnoU52D0HrgX/kN6+MDP8mR
         4mm9sCFlrEOJcnfWL7345K9/qFIRO/KWqH0+uBqJ/b0V/leihxuxJFv26xsAQULnVfa0
         heBRO3zZoNvVlB1WtLWxscUhufW0W9EHDfGUfpOEZHOghuSmdXtAp5pz0Ajcgz5xIvO/
         GTu8Nr5GpiuscSDqh3fGKZDK11M3Dbl6STuTU6M3Bj1sUS7N3Gywcb7Ut2wWloIzrX5E
         RgZWGyPj0Fl4vqgMwbPZGm/99AHDIbHDYunr6IxnmwZ8K6hPaVgUW928V3HFkbsb+l1w
         FC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698909139; x=1699513939;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WEBioVxJk3ym90q7TlVf9nmpXWD8MimLsKfSDcLwOE=;
        b=j5rlP4kyf7rxZDkzpDSYVUw95doqhf14G1mi0fewNb7bwM5oYNlAc5+M+3C6vo56wZ
         nQt6kh4vQa1PlUSveuLMEdXDNE11jR/RAatzd0XbWnnKPUtzaJ/jxzohB0MVhuZTJkKI
         nCuBO5SHhUy19FLPf08am/qNwNTKT42dvrY+Tqpy0zyUXTykvftuqFT8AtGdkexmjSxl
         Um3Tk6uZSN/H3uXDYi7SrXKDCErLvL2SWF7KtpUr+U4HCyEQ7L1HQAL+QfQlyJt/WpZS
         RieIIW9Gt+HZq/GB6hjI/9af72kEDY3lyUeoEmxZKfkonRKtpGzDhrXMNU3IDAuAc9lr
         wrYg==
X-Gm-Message-State: AOJu0YxwmGUHATj3FR08VigAa7JfkNlSLTOt9vN6+AsvgXwQGz8dSofL
        XfLpDGk5SLw3J+folaP3Mu4=
X-Google-Smtp-Source: AGHT+IFCvLXG2b6XRmoEKc6mhGvo/X1AYuCuvX6slrH9Rb6m7aigv9aeSv+yP1Rj2rWWFTWRE3H1Gw==
X-Received: by 2002:a05:6808:aa2:b0:3a7:6b1c:8142 with SMTP id r2-20020a0568080aa200b003a76b1c8142mr19106701oij.25.1698909139033;
        Thu, 02 Nov 2023 00:12:19 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id g20-20020a056a00079400b006c010ba44d9sm2236972pfu.164.2023.11.02.00.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 00:12:18 -0700 (PDT)
Date:   Thu, 2 Nov 2023 16:11:29 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ywchoi@casys.kaist.ac.kr
Subject: Missing a write memory barrier in tls_init()
Message-ID: <ZUNLocdNkny6QPn8@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It seems a write memory barrier is missing in tls_init() (or
tls_ctx_create()). In the following execution, NULL dereference may
happen in {tls_setsockopt, tls_getsockopt}.

CPU0                                         CPU1
-----                                        -----
// In tls_init()
// In tls_ctx_create()
ctx = kzalloc()
ctx->sk_proto = READ_ONCE(sk->sk_prot) - (1)

// In update_sk_prot()
WRITE_ONCE(sk->sk_prot, tls_prots)     - (2)
                                              // In sock_common_setsockopt()
                                              READ_ONCE(sk->sk_prot)->setsockopt()

                                              // In tls_{setsockopt,getsockopt}()
                                              ctx->sk_proto->setsockopt()    - (3)


In the above concurrent execution, nothing prevents store-store
reordering in CPU0, so it is possible that CPU0 completes (2) before
(1). If it happens, CPU1 may crash at (3).

To prevent such out-of-order execution, I think we need something like
this (although I don't like smp_wmb(). smp_store_release() should be
better):

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 1c2c6800949d..5dccde91f9b1 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -819,6 +819,7 @@ struct tls_context *tls_ctx_create(struct sock *sk)
        rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
        ctx->sk_proto = READ_ONCE(sk->sk_prot);
        ctx->sk = sk;
+       smp_wmb();
        return ctx;
 }

In addition, I believe the {tls_setsockopt, tls_getsockopt}
implementation is fine because of the address dependency. I think
load-load reordering is prohibited in this case so we don't need a
read barrier.

Could you check this?


Best regards,
Dae R. Jeong
