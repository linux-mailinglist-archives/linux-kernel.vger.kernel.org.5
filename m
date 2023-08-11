Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D98778955
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjHKI6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjHKI6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:58:35 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7130110F6;
        Fri, 11 Aug 2023 01:58:32 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so248432066b.2;
        Fri, 11 Aug 2023 01:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691744311; x=1692349111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRWfB9LQHdt9A21IWCnZ+M54s1U8QSJYOzwROk+UCCg=;
        b=WZCpEBQdd7mplWxI1kwwbFMJvcJzWH7VsBjIzpXFyBlLRPcoxGQlTKuFjhLMqgEu+Y
         NKiu+fY/WKiLTTxjXxFTEn5EkW0Y6q9qlHToQPvpSu47jsjz7UmNBKLXSA2sR6a5PwJw
         IocYHaHXJPT5ZCuMoCr5WZN27S8Au0NBNokXMuTm/UK0bQaxnhjrK1ArbFDP0ie9tFE2
         G+K/+MMMV92Wo4xiE/juBT5CdDfPXVfvdz2ZrqoLJLYnxO/c1Cm/LOkRUWvdrtheD1AL
         kMZXBJDLpaxwp76SoK51c/D0neXr/CwGUSg4FMJ7AFP82Pu0dpw68zNvWCq2UG8zwUwB
         LQaQ==
X-Gm-Message-State: AOJu0Yw8jwPw4347LRmObVRQAfnUTirLiIWK8btWRvcMLoqOXuOqYmv2
        VPdygSinD6x9rmDRrDBUVdU=
X-Google-Smtp-Source: AGHT+IHqLdWXwuYvIhydho+xwvmjaWx6+A6OQWMHGr5HxvYEPrYsLZo40YgOy9ZkahcSe4mRnQ5//w==
X-Received: by 2002:a17:907:7883:b0:99b:e464:bf49 with SMTP id ku3-20020a170907788300b0099be464bf49mr1222415ejc.51.1691744310605;
        Fri, 11 Aug 2023 01:58:30 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-003.fbsv.net. [2a03:2880:31ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id a17-20020a17090682d100b009944e955e19sm1991096ejy.30.2023.08.11.01.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 01:58:30 -0700 (PDT)
Date:   Fri, 11 Aug 2023 01:58:25 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Simon Horman <horms@kernel.org>
Cc:     rdunlap@infradead.org, benjamin.poirier@gmail.com,
        davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 1/2] netconsole: Create a allocation helper
Message-ID: <ZNX4MexwrLKMABx+@gmail.com>
References: <20230810095452.3171106-1-leitao@debian.org>
 <20230810095452.3171106-2-leitao@debian.org>
 <ZNVFzhBVT/LyhTuR@vergenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNVFzhBVT/LyhTuR@vergenet.net>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Simon,

On Thu, Aug 10, 2023 at 10:17:18PM +0200, Simon Horman wrote:
> On Thu, Aug 10, 2023 at 02:54:50AM -0700, Breno Leitao wrote:
> > De-duplicate the initialization and allocation code for struct
> > netconsole_target.
> > 
> > The same allocation and initialization code is duplicated in two
> > different places in the netconsole subsystem, when the netconsole target
> > is initialized by command line parameters (alloc_param_target()), and
> > dynamically by sysfs (make_netconsole_target()).
> > 
> > Create a helper function, and call it from the two different functions.
> > 
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/net/netconsole.c | 42 +++++++++++++++++++++-------------------
> >  1 file changed, 22 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 87f18aedd3bd..f93b98d64a3c 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -167,19 +167,16 @@ static void netconsole_target_put(struct netconsole_target *nt)
> >  
> >  #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
> >  
> > -/* Allocate new target (from boot/module param) and setup netpoll for it */
> > -static struct netconsole_target *alloc_param_target(char *target_config)
> > +/* Allocate and initialize with defaults.
> > + * Note that these targets get their config_item fields zeroed-out.
> > + */
> > +static struct netconsole_target *alloc_and_init(void)
> >  {
> > -	int err = -ENOMEM;
> >  	struct netconsole_target *nt;
> >  
> > -	/*
> > -	 * Allocate and initialize with defaults.
> > -	 * Note that these targets get their config_item fields zeroed-out.
> > -	 */
> >  	nt = kzalloc(sizeof(*nt), GFP_KERNEL);
> >  	if (!nt)
> > -		goto fail;
> > +		return nt;
> >  
> >  	nt->np.name = "netconsole";
> >  	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
> > @@ -187,6 +184,21 @@ static struct netconsole_target *alloc_param_target(char *target_config)
> >  	nt->np.remote_port = 6666;
> >  	eth_broadcast_addr(nt->np.remote_mac);
> >  
> > +	return nt;
> > +}
> > +
> > +/* Allocate new target (from boot/module param) and setup netpoll for it */
> > +static struct netconsole_target *alloc_param_target(char *target_config)
> > +{
> > +	struct netconsole_target *nt;
> > +	int err;
> 
> Hi Breno,
> 
> This function returns err.
> However, clang-16 W=1 and Smatch warn that there is a case
> where this may occur without err having being initialised.

That can really happen, if we get into this function:

        if (*target_config == 'r') {
                if (!nt->extended) {
                        pr_err("Netconsole configuration error. Release feature requires extended log message");
                        goto fail;

	fail:
		return ERR_PTR(err);


Let me update it.
