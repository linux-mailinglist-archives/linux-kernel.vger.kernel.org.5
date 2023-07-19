Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CD9759C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjGSRTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGSRSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:18:54 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFBD189;
        Wed, 19 Jul 2023 10:18:53 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-52166c7f77cso8685885a12.2;
        Wed, 19 Jul 2023 10:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689787132; x=1692379132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJ8zyPA28H2PBLz8lr4+2NlPFh5DMTLYGFS9mgafKcY=;
        b=EdmHU8N936Tg5yFldrBTh0UBsL6U1yjpXDu+8EdaGEJtcAulimdbkyDbmHUIzsL5/T
         Z8NQrLkOu6HA+qdYGGriwFa5KOuZzBxRx+JpK664QqO+9AnKHUPlSas7Hya1fsqtPGTD
         N9xVypkjYvVFsupXiUKKjENvPYFSBRMO6vy8SA3jjC+7jeRBxJHxZbvQzBu935/mfnNR
         l75p3QHodqDfMZyLZIHtPDtXb7qWsH6Ka3PBGswUgWZ0O7MtZWDG8j0HkYKkyZC3xQhF
         8IFpt5f7raGa4CB5j+sE6tTLhy44Rw9lthkKrWju+8Wr0Py/qlfbBffBUvHgRRHP7GPK
         UsPQ==
X-Gm-Message-State: ABy/qLaQFG54qtG1V1rD6l97CZPsAKtY2vngbjFaeqWmvPAfoOFBBUnM
        sPPjDgtmbHAf1KdqMKRFkik=
X-Google-Smtp-Source: APBJJlEOJvQn9kSsZWsRdnFrSThCTxwiUITIx9D1MPZqWcvz6lb1LwjVA9hbY8O/MmLpzg1hUSocNw==
X-Received: by 2002:a05:6402:1a31:b0:51d:96d2:6578 with SMTP id be17-20020a0564021a3100b0051d96d26578mr3359383edb.28.1689787131622;
        Wed, 19 Jul 2023 10:18:51 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-017.fbsv.net. [2a03:2880:31ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id k19-20020a05640212d300b00521d1c34b23sm371987edx.83.2023.07.19.10.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 10:18:51 -0700 (PDT)
Date:   Wed, 19 Jul 2023 10:18:49 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     alexander@mihalicyn.com, ast@kernel.org, davem@davemloft.net,
        dhowells@redhat.com, edumazet@google.com, kernelxing@tencent.com,
        kuba@kernel.org, leit@meta.com, linux-kernel@vger.kernel.org,
        lucien.xin@gmail.com, martin.lau@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next] net: Use _K_SS_MAXSIZE instead of absolute value
Message-ID: <ZLga+cBUKkN5Fnn7@gmail.com>
References: <20230719084415.1378696-1-leitao@debian.org>
 <20230719170445.30993-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719170445.30993-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 10:04:45AM -0700, Kuniyuki Iwashima wrote:
> From: Breno Leitao <leitao@debian.org>
> Date: Wed, 19 Jul 2023 01:44:12 -0700
> > Looking at sk_getsockopt function, it is unclear why 128 is a magical
> > number.
> > 
> > Use the proper macro, so it becomes clear to understand what the value
> > mean, and get a reference where it is coming from (user-exported API).
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  net/core/sock.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 9370fd50aa2c..58b6f00197d6 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -1815,7 +1815,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
> >  
> >  	case SO_PEERNAME:
> >  	{
> > -		char address[128];
> > +		char address[_K_SS_MAXSIZE];
> 
> I guess you saw a bug caught by the fortified memcpy(), but this
> doesn't fix it properly.

Not really, in fact. I was reading this code, and I found this
discussion a while ago, where I got the idea:

https://lore.kernel.org/lkml/20140930.005925.995989898229686123.davem@davemloft.net/
