Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B06F7E80AC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344852AbjKJSRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbjKJSO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:14:56 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8470428B11;
        Fri, 10 Nov 2023 02:23:55 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc3542e328so15572815ad.1;
        Fri, 10 Nov 2023 02:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699611835; x=1700216635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/2cSIxf2LiNikr5+UZH8g91X0Uc2ts17P5QtMNK58mc=;
        b=aJ+nQjAkK7YVbVINs+X6SEG5H2lWSwRpXrpnsNccu9xUvxlB4MjLw85MRwRKG7MiLP
         OiuPZY8jQPgvYz8IVRH8R8C51VoeHVmO8jEK8ZqYnDhaFb5NM6k0G8EbLRTDabRKPuXv
         PWhJH3I34OOD4cN0xvecFbJrO+yivn4mQSttvt+Pvpnr2RHcuKAx0HvlGWMYGg7RcRAo
         snv7Q6WgTWnJF9k+3neCY0vYJDXnyJepwRIMQDCFGEuGi0dc9OlAIthoTvNcyegj1KMy
         HbpV0qITFs4m7meqUU422MwXQpBHEnst4v/6J4ci+SqHyiax0wZ87wKrWrFS2Ie0qWuv
         stYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611835; x=1700216635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2cSIxf2LiNikr5+UZH8g91X0Uc2ts17P5QtMNK58mc=;
        b=P/0AjSY7VPKwYcRr6E0XTfw1TIcDLCHGvkbANNzTUviLK2v67olTk9VheyaqIssmk0
         OyVrFnI5nFRvr3QLfaz/3X4cpzcBEbEwTc2NQ4Bwfd+Q+VahJEPafGnETTH+ipBe+64f
         WnnUsCZ0Kh1+Nst/k2frhTkaTrmTauZzBk48SNcEiColxu1kehohZez4tALWytRqulOl
         XrLsaUlbG6EA5ARinazp4erxui00UUFWqb4DyERPjRGai+vV0BdTVI+/sy4hfqxgLJRs
         47ROD8XjxaVGYsalocA7bjEl80+QYAZuRAG1MdgPaygrfYDDYOkEeibZnjZVvcPemTX1
         uDVA==
X-Gm-Message-State: AOJu0YzNiO1tcFNPv/9BHerb8NEa/DR/CmJQGT4lA4Xh9ISJ2A0OnIrA
        /iTUvFTFxyTaB6qBITARC5w=
X-Google-Smtp-Source: AGHT+IH+Lqu9XPEnKKNzGYWaYuidCTu0HniqN9du1LvZf+5vxSLs//4ZqYeE9JdELHxJyeMLO1iwAw==
X-Received: by 2002:a17:902:eac6:b0:1cc:6f7b:636a with SMTP id p6-20020a170902eac600b001cc6f7b636amr7274169pld.2.1699611834844;
        Fri, 10 Nov 2023 02:23:54 -0800 (PST)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b001cc55bcd0c1sm5014551plf.177.2023.11.10.02.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:23:54 -0800 (PST)
Date:   Fri, 10 Nov 2023 19:22:43 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     Jakub Kicinski <kuba@kernel.org>, borisp@nvidia.com,
        john.fastabend@gmail.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ywchoi@casys.kaist.ac.kr
Subject: Re: Missing a write memory barrier in tls_init()
Message-ID: <ZU4Ecx2qbdqGfRVw@dragonet>
References: <ZUNLocdNkny6QPn8@dragonet>
 <20231106143659.12e0d126@kernel.org>
 <ZUq-GrWMvbfhX74a@hog>
 <20231107185324.22eecf10@kernel.org>
 <ZUtP7lMqFnNK8lw_@hog>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUtP7lMqFnNK8lw_@hog>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 10:07:58AM +0100, Sabrina Dubroca wrote:
> 2023-11-07, 18:53:24 -0800, Jakub Kicinski wrote:
> > On Tue, 7 Nov 2023 23:45:46 +0100 Sabrina Dubroca wrote:
> > > Wouldn't it be enough to just move the rcu_assign_pointer after ctx is
> > > fully initialized, ie just before update_sk_prot? also clearer wrt
> > > RCU.
> > 
> > I'm not sure, IIUC rcu_assign_pointer() is equivalent to
> > WRITE_ONCE() on any sane architecture, it depends on address
> > dependencies to provide ordering.
> 
> Not what the doc says:
> 
>     /**
>      * rcu_assign_pointer() - assign to RCU-protected pointer
>      [...]
>      * Inserts memory barriers on architectures that require them
>      * (which is most of them), and also prevents the compiler from
>      * reordering the code that initializes the structure after the pointer
>      * assignment.
>      [...]
>      */
> 
> And it uses smp_store_release (unless writing NULL).
> 

I think Sabrina is right. We can rely on the release semantic implied
in rcu_assign_pointer(). Simply moving rcu_assign_pointer() to the end
of tls_ctx_create() should prevent a scenario what I thought (ie.,
store-store reordering between ctx->sk_proto and sk->sk_prot).

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 1c2c6800949d..d20b823c68d4 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -816,9 +816,9 @@ struct tls_context *tls_ctx_create(struct sock *sk)
                return NULL;
 
        mutex_init(&ctx->tx_lock);
-       rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
        ctx->sk_proto = READ_ONCE(sk->sk_prot);
        ctx->sk = sk;
+       rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
        return ctx;
 }

But what I also wonder is that, do we need to ensure that
ctx->{tx,rx}_conf is visible before updating sk->sk_prot? If so, as
Sabrina suggested, we may want to move rcu_assign_pointer() right
before update_sk_prot().


Best regards,
Dae R. Jeong
