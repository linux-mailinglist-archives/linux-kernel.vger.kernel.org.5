Return-Path: <linux-kernel+bounces-129855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F22897151
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E65C7B26EFA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50621487CB;
	Wed,  3 Apr 2024 13:39:05 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A66C18E1C;
	Wed,  3 Apr 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151545; cv=none; b=Qk/bfMmmfaLEuANMfHw1eJnCQTxPKqtiFvDwAps7lgZk38kwhbAzdpNgvN3/4HTRYYDF406svU7y71DLZDuKTHzwc3a46QTL8lxi+t1cDPv1BIv5HHCjjhwo59ZWAsl6fGfSkuLkL17Zo/JEZa4/AdhdGadFCUCB3UWylcDWu8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151545; c=relaxed/simple;
	bh=RSVUJ5mvNN/mq647F8u0GPy0owFHj4sKNcBF1bx+SMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6Cun0hZY5lV09wOBmprljuowxyS59A0VNGwwsgWnnAQxNogPB6zdltlf8Mao+xJltxm74z9VTBw8MKXEa8FpWB336vj8AHUOmNV4tfHDOgvQEvNHfKdJ/v2TtuoGdt/cnpcpUjDBWzZav9FPjRWE3ywyGDcxTX0FczZjFgL4ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46a7208eedso832809466b.0;
        Wed, 03 Apr 2024 06:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712151542; x=1712756342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQZWvxGtqYUJOyAXOjn6bj9QAMTQq/STy2Dnfaguhx0=;
        b=gJwl02+moE3OrWgukFV2BGJWmu/km8ippQWSu5iftC/BAz+v8z84wk/AwJZvP4dnbJ
         MGnXarRqSsx7kRqhyEY6oCLeFw5FbXXfHxwnv1tnzeiVLaRwztM2z4RWcMh0va3dMjq9
         NjVHngTw6jP1o1mxc7JxGrf9a0mcIo8do0RfeaS9TY4JKRj9oYJLaPxqglIWIJzRcFEU
         RK9Qj4CDq4RT4TLxSvxBxflNUkIR2focILhMNvVrdyIF9SM5impv8r7o9mblR9HGZ5Sb
         1hZbLI4s5aGLvQXeZIMm+bz9PNXMEjMODkD9UDj2gLPPIMZcpVeWcEcy+ixRd1YNYkqf
         6BEA==
X-Forwarded-Encrypted: i=1; AJvYcCWgczZoMkW3AyaiyRGamN4jjzj/hWcyhnLVyeWGP/oQCXEzLJyWvQCqM9Q70NuLVKKibZOB7VeTaQ5lIlQPjDJ7dmYGjkWMP/4csB4CmJRh5gA3E2KKYMyweay3yuwaApfeAZ/N
X-Gm-Message-State: AOJu0Ywh0E9udvkWhB1SYwhZusdOfQBFii6PptkJ4EgxWPXxFucwUIgp
	UKhwuLjj5aP9IUEBirUe3UXVtnsVMJC81D8BTef08LmvdORV23K1
X-Google-Smtp-Source: AGHT+IHXOC6EFSz3HkXWkyVHv1Jm6dSjc4W8ZrKXv7CclLdkH+h9aQfqGLELfWL4Sk/dxIthf0ePKw==
X-Received: by 2002:a17:906:b78e:b0:a4e:8f62:487d with SMTP id dt14-20020a170906b78e00b00a4e8f62487dmr1645298ejb.28.1712151541613;
        Wed, 03 Apr 2024 06:39:01 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm7019723ejb.11.2024.04.03.06.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:39:01 -0700 (PDT)
Date: Wed, 3 Apr 2024 06:38:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Alex Elder <elder@ieee.org>
Cc: aleksander.lobakin@intel.com, kuba@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com,
	Alex Elder <elder@kernel.org>, quic_jjohnson@quicinc.com,
	kvalo@kernel.org, leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/5] net: ipa: allocate dummy net_device
 dynamically
Message-ID: <Zg1b8vuTs5Z+1Obv@gmail.com>
References: <20240328235214.4079063-1-leitao@debian.org>
 <20240328235214.4079063-5-leitao@debian.org>
 <c03b8113-e1be-4cf3-a85c-43de15163ab1@ieee.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c03b8113-e1be-4cf3-a85c-43de15163ab1@ieee.org>

Hello Alex,

On Mon, Apr 01, 2024 at 08:56:46AM -0500, Alex Elder wrote:
> Thanks for pointing this out, I didn't notice the earlier
> discussion.  Embedding the dummy netdev in this case was
> probably done to eliminate the chance of an unlikely
> allocation error at init time.  It is not at all necessary.
> 
> I had to go find the rest of your series.  If at least one patch
> is addressed to me in a series, please copy me on all of them.

Sure, do you know if there ia way to do it using git send-email
identity?

I basically sent the patch series using git setnd-email with an
identity, and, for each patch, git send-email parses the patch and run
scripts/get_maintainer.pl for each patch, appeneding the "important"
people in that patch.

To do what you are suggesting, I would need to have a cumulative to: and
 cc: list. Any tip here would be appreciate.

> I see the dummy netdev now gets "fully initialized" but that's
> a one-time thing, and seems harmless.  But given that, shouldn't
> the result of alloc_dummy_netdev() also have a free_dummy_netdev()
> (rather than simply calling kfree(dummy_netdev))?

Right. I am moving to use free_netdev() now. I can us create a
free_dummy_netdev() macro that points to free_netdev(), but, I think
that might not be necessary.

> > @@ -2369,12 +2369,14 @@ int gsi_init(struct gsi *gsi, struct platform_device *pdev,
> >   	/* GSI uses NAPI on all channels.  Create a dummy network device
> >   	 * for the channel NAPI contexts to be associated with.
> >   	 */
> > -	init_dummy_netdev(&gsi->dummy_dev);
> > +	gsi->dummy_dev = alloc_netdev_dummy(0);
> > +	if (!gsi->dummy_dev)
> > +		return -ENOMEM;
> >   	init_completion(&gsi->completion);
> >   	ret = gsi_reg_init(gsi, pdev);
> >   	if (ret)
> > -		return ret;
> > +		goto err_reg_exit;
> 
> Assuming you change it to not just use kfree() to free the
> dummy netdev, the above call won't work.  You'll want to do
> something like:
> 
> 	if (ret)
> 		goto err_netdev_free;
> 
> . . .
> 
> err_netdev_free:
> 	free_dummy_netdev(gsi->dummy_dev);
> err_reg_exit:

I am not sure I followed this one. All the exit paths should free the
device, if I have err_netdev_free: label, then it will replace
err_reg_exit: label completely.

If I apply your suggestion, it will look like the following (with some
concerns I have).

        gsi->dummy_dev = alloc_netdev_dummy(0);
        if (!gsi->dummy_dev)
                return -ENOMEM;

        ret = gsi_reg_init(gsi, pdev);
        if (ret)
                goto err_netdev_free;

        ret = gsi_irq_init(gsi, pdev); 
        if (ret)
                goto err_reg_exit;            <-- This needs to point to err_netdev_free also

        ret = gsi_channel_init(gsi, count, data);
        if (ret)
                goto err_reg_exit;            <-- This needs to point to err_netdev_free also

        mutex_init(&gsi->mutex);

        return 0;

  err_netdev_free:
        free_netdev(gsi->dummy_dev);
  err_reg_exit: 	                    <-- This label will be unused
        gsi_reg_exit(gsi);


That said, basically fixing the concerns above will result in the same code I
originally proposed.

 > @@ -2400,6 +2403,7 @@ void gsi_exit(struct gsi *gsi)
> >   	mutex_destroy(&gsi->mutex);
> >   	gsi_channel_exit(gsi);
> 
> Please call the free here, so the cleanup is done in
> exactly the reverse order of the initialization.

Ack!

Thanks for the feedback.

