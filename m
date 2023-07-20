Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F67875AAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjGTJgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjGTJgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:36:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB83659FD;
        Thu, 20 Jul 2023 02:31:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-992f15c36fcso102387166b.3;
        Thu, 20 Jul 2023 02:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689845378; x=1692437378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RoYsLMnGNe370x/PWpt6fRr+CVnI3rb6B5FxBlD/WA=;
        b=kmvo5JSSEt1EhryFKa3eb3dtiAtJoPVxrN6WfHIK7hDynxFff9ivv8P2ST6bI43WBD
         1y2h7N+tD2g64pg03sox94Qz2a3L2YcYRuRRrdy1DS7Er9y4z0BGRctOJLIh2Z+P/XEI
         78hNv9B3AMgkCgmrQElg5GMRU7mqu2PF5CMm+aCL+Rbgu0vTsmckrrQU4Z7k2aYXSimt
         tqSxPfbfLf5NhDNsibMmHKcqYPZcsAdN8AOwkx2LgUv60QYw/tT2ZkC41/N7b4oi6ETt
         aHa789dSZkY2Zs6DykU4aJd3FqMujxP8cdvcadR6boz/skL0byc5uUMEIValtIS4xIje
         h3DQ==
X-Gm-Message-State: ABy/qLbQwWKtzCuVnFyOR7ujAwuCRlmXxo//pz8AVA6tjLzgkOPMGM6g
        85kYnOPcSfcaEaOSniaekrE=
X-Google-Smtp-Source: APBJJlHkJywRjVkZQwN03Cbfk0eu/+dNa6uJAGKwjTe4AASepKeIlg3Ko4e5vauro2zPz6HmF5+0fw==
X-Received: by 2002:a17:906:d8ae:b0:969:93f2:259a with SMTP id qc14-20020a170906d8ae00b0096993f2259amr4338341ejb.73.1689845378108;
        Thu, 20 Jul 2023 02:29:38 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-017.fbsv.net. [2a03:2880:31ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id r27-20020a17090638db00b009786c8249d6sm421063ejd.175.2023.07.20.02.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 02:29:37 -0700 (PDT)
Date:   Thu, 20 Jul 2023 02:29:35 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     alexander@mihalicyn.com, ast@kernel.org, davem@davemloft.net,
        dhowells@redhat.com, edumazet@google.com, kernelxing@tencent.com,
        kuba@kernel.org, leit@meta.com, linux-kernel@vger.kernel.org,
        lucien.xin@gmail.com, martin.lau@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next] net: Use _K_SS_MAXSIZE instead of absolute value
Message-ID: <ZLj+f4heU8Bk7GVq@gmail.com>
References: <ZLga+cBUKkN5Fnn7@gmail.com>
 <20230719173017.33951-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719173017.33951-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 10:30:17AM -0700, Kuniyuki Iwashima wrote:
> From: Breno Leitao <leitao@debian.org>
> Date: Wed, 19 Jul 2023 10:18:49 -0700
> > On Wed, Jul 19, 2023 at 10:04:45AM -0700, Kuniyuki Iwashima wrote:
> > > From: Breno Leitao <leitao@debian.org>
> > > Date: Wed, 19 Jul 2023 01:44:12 -0700
> > > > Looking at sk_getsockopt function, it is unclear why 128 is a magical
> > > > number.
> > > > 
> > > > Use the proper macro, so it becomes clear to understand what the value
> > > > mean, and get a reference where it is coming from (user-exported API).
> > > > 
> > > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > > ---
> > > >  net/core/sock.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > index 9370fd50aa2c..58b6f00197d6 100644
> > > > --- a/net/core/sock.c
> > > > +++ b/net/core/sock.c
> > > > @@ -1815,7 +1815,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
> > > >  
> > > >  	case SO_PEERNAME:
> > > >  	{
> > > > -		char address[128];
> > > > +		char address[_K_SS_MAXSIZE];
> > > 
> > > I guess you saw a bug caught by the fortified memcpy(), but this
> > > doesn't fix it properly.
> > 
> > Not really, in fact. I was reading this code, and I found this
> > discussion a while ago, where I got the idea:
> > 
> > https://lore.kernel.org/lkml/20140930.005925.995989898229686123.davem@davemloft.net/
> 
> I got it, but I prefer using struct sockaddr_storage as done in
> other places.
> 
>   $ grep -rn sockaddr_storage net/
> 
> Also, there would be some situations where we must cast each
> family-specific address back to sockaddr_storage for fortified
> library.
> 
> Then, it makes more sense to use sockaddr_storage rather than
> _K_SS_MAXSIZE.

Agree, that is a better fix. Thanks for working on it!
