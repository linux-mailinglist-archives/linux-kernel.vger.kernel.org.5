Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E065980CAE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343617AbjLKNZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKNZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:25:18 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613619A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:25:24 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67abd1879c0so29520406d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702301123; x=1702905923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YFtv/UZjlpbIfchVI2Eg4g5klyHxnMNJuBk5+joq/H0=;
        b=Ba3og296wOPlhW3eZQLq3vsMBRB9FHZseUJJkfhHz+16Bfs5STtWRlJU+cP2yONYcc
         d3ujZnS0DTCrV0KpmjSpXOIg6t5+YmUn6Ueby2tTpupSvkJ96pVRVSZxrAnDNQZGlQO2
         oN5fM14Nove7XmT6+Z1Z05lRgvy/CUjtE94TUfFizGVsDAWqGbsinsThq+1nw5UdD5AO
         s6MXDKp27fZjPRmjWLH2z33frsVW01L34yL2I/FGREs88B2HkzG0sjhUCgvoH/lVEY8n
         wLAo+T2LgM4iRKHckGaGU182nOtXn84qwRtVrPziSeMCgLKL+l9wOA9AFbnwpRYWofAP
         +zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702301123; x=1702905923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFtv/UZjlpbIfchVI2Eg4g5klyHxnMNJuBk5+joq/H0=;
        b=Tsd5rH4R+cdZ1tExXLiMl4eHX303VKerN6oCrNATUpGA3GG8bjM55QJJApv+N/H+HN
         zNu3X+52UTGmapJZJcCQUOHwgVHHn9ZyquN/RpFHu45+irBQWgyZNz7w4crZuvA0I7va
         tcJFd9a6xPq/wERJVN4vZFA58vyDVSiYA4fpsXOXeo3w9RpM6zdYiO7UzvAi375Zcbt5
         q5iIi0ubJ4G91bzRoaAQBtPgzs03oaVmPjo0P9QHHi70v4brUkvtsIcn8D0/eTMorruX
         Q4RHIHlK6IqKn8BZ+2OrwSjmvNZyMXq/btxOHa6HFxJzjW77IE3SiCpXZzmOMpps8YId
         AtMA==
X-Gm-Message-State: AOJu0YxsbbQowoZY072XJP0v4nRUudDfCoAUN2R07cHggkj8htTKmgOi
        s9rMBDuQKBGma3fcvd2dcj/Z/w==
X-Google-Smtp-Source: AGHT+IHZGeyP3BjcJlaAjr6e3g0qYv8anKUCcQLzvX5kgf3uL5XcY2iAAOvqcGLs20XwyXPwCpTXXA==
X-Received: by 2002:a0c:f682:0:b0:67a:a721:7846 with SMTP id p2-20020a0cf682000000b0067aa7217846mr4460297qvn.107.1702301123506;
        Mon, 11 Dec 2023 05:25:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id mk10-20020a056214580a00b0067aa860b1f9sm3292627qvb.122.2023.12.11.05.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 05:25:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rCgHi-00CaWy-Bc;
        Mon, 11 Dec 2023 09:25:22 -0400
Date:   Mon, 11 Dec 2023 09:25:22 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Daniel Vacek <neelx@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/ipoib: No need to hold the lock while printing the
 warning
Message-ID: <20231211132522.GY1489931@ziepe.ca>
References: <20231211131051.1500834-1-neelx@redhat.com>
 <20231211132217.GF4870@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211132217.GF4870@unreal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 03:22:17PM +0200, Leon Romanovsky wrote:
 
> Please fill some text in commit message.

Yes, explain *why* you are doing this
 
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > index 5b3154503bf4..ae2c05806dcc 100644
> > --- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > @@ -536,17 +536,17 @@ static int ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast)
> >  	multicast = ib_sa_join_multicast(&ipoib_sa_client, priv->ca, priv->port,
> >  					 &rec, comp_mask, GFP_KERNEL,
> >  					 ipoib_mcast_join_complete, mcast);
> > -	spin_lock_irq(&priv->lock);
> >  	if (IS_ERR(multicast)) {
> >  		ret = PTR_ERR(multicast);
> >  		ipoib_warn(priv, "ib_sa_join_multicast failed, status %d\n", ret);
> > +		spin_lock_irq(&priv->lock);
> >  		/* Requeue this join task with a backoff delay */
> >  		__ipoib_mcast_schedule_join_thread(priv, mcast, 1);
> >  		clear_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
> >  		spin_unlock_irq(&priv->lock);
> >  		complete(&mcast->done);
> > -		spin_lock_irq(&priv->lock);

It is super weird to unlock just around complete.

Jason
