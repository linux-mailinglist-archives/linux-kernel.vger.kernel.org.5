Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEF57E7FED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjKJSBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjKJR7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:59:54 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D852B794;
        Fri, 10 Nov 2023 03:05:17 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c115026985so1968483b3a.1;
        Fri, 10 Nov 2023 03:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699614316; x=1700219116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kwtDltZqo6DRYNAe427685yCrF5zwVVyWvlJ8J0IIxE=;
        b=GiTRKNP9dAwIYBs6SNkMWZd/vooYtvgKLg5dTG7wk0o7bSxqxPu3FgUnqtsZphFiXI
         PWpZ0LQKcx92x8lQ6Gw2n5IqZGfXhaS/QpoSrkOJv0a4eSUM4WenOOGZMduuVjizV07b
         fex/9BccWs2dCCBrVq5o2kMhPgf4j5fHhjqbsvC+dypUXKyxabbzLxDrthUEXW9Sv9hZ
         xCY1NHqmkUUs74ozoLIj0KLCi5WqJgQu55gcqiRHEFJH748DHJWM5tRuzuJaRGbnQyv1
         YoTRQe/6JOlQxDYjEIdRAI6T44l2Fwnzp3/siQ45XG/iEnZGEEaxNhGhjBbpis9k/qn9
         ibUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699614316; x=1700219116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwtDltZqo6DRYNAe427685yCrF5zwVVyWvlJ8J0IIxE=;
        b=lzwYuQE/tRcHEDPSA+e8U0Ai+yQQ56wGY6BAEWvfbq8YQ5Rrwi5Kk7gKFqF9hCix++
         X61B164g3EHQzna01wDzCQUJ62MJPerOlpFDffUu2qio0RSEdFL4BW+JcPwGEa3c1fZ6
         kgfUfyPdoNDmKMq2oktwYcFgt943/FJ60ozrrhM2g1Jr++MmT0SV3H5f65Gw9Zwvf2El
         9g8oCXDbn5kIMGu+ESFEHDBoYU38VKtjooIXaiLUStJMBm7pH1jEtJ3qfQdTVj7260zW
         UIRwI8+B2I7IE6N4kfzJBGK2xZjw0C1xHr16Nt2RyydRFiJDmC38FdePtfsSXq0shVUZ
         SzvQ==
X-Gm-Message-State: AOJu0Yy2NJzzcTkiUjFwCZmSuKbNiBqxCQEIU3BCO45qvgfFtzjPqRJV
        nhSPX3rYEYsb5JH2gVnp6DM=
X-Google-Smtp-Source: AGHT+IFFW5pDixabAM8siIP62wg5JRPJT9/pzTZ5dLjbDzNknwhVd78EnQPMrW0ubr+G7381zAUD/w==
X-Received: by 2002:a17:90a:1a04:b0:281:61c:1399 with SMTP id 4-20020a17090a1a0400b00281061c1399mr4342992pjk.3.1699614316559;
        Fri, 10 Nov 2023 03:05:16 -0800 (PST)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001c726147a45sm5112612pli.190.2023.11.10.03.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 03:05:16 -0800 (PST)
Date:   Fri, 10 Nov 2023 20:04:04 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     Jakub Kicinski <kuba@kernel.org>, borisp@nvidia.com,
        john.fastabend@gmail.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ywchoi@casys.kaist.ac.kr
Subject: Re: Missing a write memory barrier in tls_init()
Message-ID: <ZU4OJG56g2V9z_H7@dragonet>
References: <ZUNLocdNkny6QPn8@dragonet>
 <20231106143659.12e0d126@kernel.org>
 <ZUq-GrWMvbfhX74a@hog>
 <20231107185324.22eecf10@kernel.org>
 <ZUtP7lMqFnNK8lw_@hog>
 <ZU4Ecx2qbdqGfRVw@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU4Ecx2qbdqGfRVw@dragonet>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 07:22:48PM +0900, Dae R. Jeong wrote:
> On Wed, Nov 08, 2023 at 10:07:58AM +0100, Sabrina Dubroca wrote:
> > 2023-11-07, 18:53:24 -0800, Jakub Kicinski wrote:
> > > On Tue, 7 Nov 2023 23:45:46 +0100 Sabrina Dubroca wrote:
> > > > Wouldn't it be enough to just move the rcu_assign_pointer after ctx is
> > > > fully initialized, ie just before update_sk_prot? also clearer wrt
> > > > RCU.
> > > 
> > > I'm not sure, IIUC rcu_assign_pointer() is equivalent to
> > > WRITE_ONCE() on any sane architecture, it depends on address
> > > dependencies to provide ordering.
> > 
> > Not what the doc says:
> > 
> >     /**
> >      * rcu_assign_pointer() - assign to RCU-protected pointer
> >      [...]
> >      * Inserts memory barriers on architectures that require them
> >      * (which is most of them), and also prevents the compiler from
> >      * reordering the code that initializes the structure after the pointer
> >      * assignment.
> >      [...]
> >      */
> > 
> > And it uses smp_store_release (unless writing NULL).
> > 
> 
> I think Sabrina is right. We can rely on the release semantic implied
> in rcu_assign_pointer(). Simply moving rcu_assign_pointer() to the end
> of tls_ctx_create() should prevent a scenario what I thought (ie.,
> store-store reordering between ctx->sk_proto and sk->sk_prot).
> 
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index 1c2c6800949d..d20b823c68d4 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -816,9 +816,9 @@ struct tls_context *tls_ctx_create(struct sock *sk)
>                 return NULL;
>  
>         mutex_init(&ctx->tx_lock);
> -       rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
>         ctx->sk_proto = READ_ONCE(sk->sk_prot);
>         ctx->sk = sk;
> +       rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
>         return ctx;
>  }
> 
> But what I also wonder is that, do we need to ensure that
> ctx->{tx,rx}_conf is visible before updating sk->sk_prot? If so, as
> Sabrina suggested, we may want to move rcu_assign_pointer() right
> before update_sk_prot().
> 
> 
> Best regards,
> Dae R. Jeong

I sent a patch by taking suggestions from Sabrina. The patches 1)
moves rcu_assign_pointer() after fully initializing ctx, and 2) gets
rid of tls_ctx_create().

I'm not sure whether removing tls_ctx_create() is a good idea or not,
but it still did not fully initialize ctx (i.e., ctx->{tx,rx}_conf).

Let me know if there is any issue, then I will rewrite a patch.


Best regards,
Dae R. Jeong
