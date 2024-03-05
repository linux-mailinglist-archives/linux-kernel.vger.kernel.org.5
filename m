Return-Path: <linux-kernel+bounces-92671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5B58723F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AF5288CFD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A67812882B;
	Tue,  5 Mar 2024 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4Zdm/QD"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583F128382
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655712; cv=none; b=fM+e8MMBbp/UxwPkeri40GAUMZK1fPkOiKd5G/XIB6K1RR3tta4dD3dxj93xd8exCuKRY95g0NqvakZ5CHjEUcuokIv35/710GpQz8th0rM2Vg0CYzm7cx4cH+iZzxVgN7/YNnpHoijGtbzNW6v4mGMNrWbB8JCTCLPGlxi8Sy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655712; c=relaxed/simple;
	bh=ePf0scKJsigQuOAKkRlhcPZMVuNR9qj2n46++S/7wAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvDXqnnYt1RsL99b7LyJRreQzl/aDQ+DtzF+n4TZsaWBcu+pkqLOwKPz69fLSbutBLN/zKvx3tAAlh6ABdBCaWcw9GOROhrAB2RWNjKhsNrZIlCmofMBBxL5sNPIZX33lF1jvPYgvj40kccLoV6bmXANKbrQJZMmGnl/X6gCh6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T4Zdm/QD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412eb6e15ceso7689565e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 08:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709655709; x=1710260509; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xbTnyXoHjbAH+HuOp1p4uK1MGCpktFM+Ft7hQZ4kc8Y=;
        b=T4Zdm/QDsGo7+DHiFCAi+h0B6tVnuom95VW/bt3TqoR4l51WLCTLozJmolkrmNwPBs
         VT/wFQjCS7tznszg5Y9t6f/y7gAkWpvUXJZx0CwzCv/vWOfZzt4nq7n9Y3swXSsfwfQ/
         sQq2vx+2RQf23qEusTk6uImaEwbuAFG5Ww1Kem1CmOOa/zceVsivMTcNXlKp2bY58s8L
         //FuGr/CGc1XHTv7WdsIJ//qDEvQpl+aM1fNdUxdmmuL/UluG1hmwntRGSjiNLRtS4gD
         i3KCYGibagfvgGMOunXYcSyHpx+7DDVc5+/2ByG+uIMa70kbNHVtQ0ESjwBwLtzS/l48
         tIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709655709; x=1710260509;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbTnyXoHjbAH+HuOp1p4uK1MGCpktFM+Ft7hQZ4kc8Y=;
        b=UFeWxmNOC8QoTEmtubatDzlyncrw9nkYbPqMA9CCaHgrcS5S2UFJi+r7Jdzf8/nLuj
         ISJvoDJWUT+Qf0sxGuEpQJ9Aq4aQ435oAX6mq9kpcnimMCG1QU+81cCaf2RAm8gQChDa
         ZmR8mvzPbksvvK4qEmaAlzwcqSJ7vkifO42LAvb7pE/j0CPoBFYjoo7D9iG2gm19nykv
         gcqrlAmRRrZHmeVgTLJFEy7MBcB36+KkFbP5Yit90unh3HtLDUJTUv1mta0/czoCK8Ez
         Af7KTmxeG6Q+jquRCdkZs/Xk95ixGNfgDQ1Gu0A55H1vq/SZy6zMOItkO4CmJ3f6GFEk
         JrfA==
X-Forwarded-Encrypted: i=1; AJvYcCVhfRBWXS2qbRLdpD0zY5yZmQe69nk8kI3l1p3z1TT35iXI8GIx/eiTcgJ+kbPm9XAHR/U0Kf3IQbdtzc9cC9B0gM3MNt72oPX/XDKm
X-Gm-Message-State: AOJu0Yysf2I5F3cOgOL2Z1/ukDUtBGkYWrEvfb+tBHKtcBVvNfKQD+ZG
	VnwamVpcHKCdyy8U4BzkfAAozyQM6PQfklmXJslhzlRc67tfC3hb0/tuJIyS7Ao=
X-Google-Smtp-Source: AGHT+IFzmlN7MlHIvgYTDNDnpOiEWNiD6ttwixhjRaArwIgoqAErAdm9nFln7aLUd8aHdUcKy+wmzg==
X-Received: by 2002:a05:600c:46ce:b0:412:ad6e:88cb with SMTP id q14-20020a05600c46ce00b00412ad6e88cbmr10431968wmo.36.1709655708736;
        Tue, 05 Mar 2024 08:21:48 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b00412704a0e4asm21342739wmo.2.2024.03.05.08.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 08:21:48 -0800 (PST)
Date: Tue, 5 Mar 2024 19:21:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-staging@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: staging: media: tegra-video: Use common error handling code in
 tegra_vi_graph_parse_one()
Message-ID: <e38cc9fb-9453-47ed-b460-335016581049@moroto.mountain>
References: <dbebaea7-289c-47d9-ba06-cd58a10ea662@web.de>
 <20240301183936.505fcc72@booty>
 <9f1b617f-06cb-4b22-a050-325424720c57@moroto.mountain>
 <f451ffba-db26-4a3b-a4b3-186c31f2ad64@web.de>
 <20240305162427.49a9f013@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305162427.49a9f013@booty>

On Tue, Mar 05, 2024 at 04:24:27PM +0100, Luca Ceresoli wrote:
> Hello Dan, Markus,
> 
> On Sat, 2 Mar 2024 11:40:26 +0100
> Markus Elfring <Markus.Elfring@web.de> wrote:
> 
> > >>> Add a jump target so that a bit of exception handling can be better reused
> > >>> at the end of this function implementation.  
> > …
> > >> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>  
> > >
> > > These patches make the code worse.  
> 
> This is of course a legitimate opinion. However Markus' patch
> implements what is recommended by the documentation and is in common
> use in the kernel code. A quick search found 73 occurrences in v6.8-rc7:
> 
> $ expr $(pcregrep -r -M ':\n\tfwnode_handle_put'  drivers | wc -l) / 2
> 73
> $
> 
> 300+ are found for of_node_put().
> 

Using an unwind ladder is the best way to write error handling, yes.
I've written a long blog about it.

https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

In my blog, I talk about that "Unwinding from loops is slightly
complicated."  Because what you want to do is clean up partial
iterations before the goto.

Now imagine we apply Markus's patch and someone comes along an adds a
new allocation after the loop is over.  Then we have to do some kind of
bunny hop:

free_new_thing:
	free(thing);
	goto cleanup;  <-- ugly little goto
put_fwnode:
	fwnode_handle_put(remote);
cleanup:
	dev_err(vi->dev, "failed parsing the graph: %d\n", ret);
	v4l2_async_nf_cleanup(&chan->notifier);
	return ret;

Adding the little goto seems like a small thing when you're seeing it
in an email like this.  But when you add the new goto years later,
people are used to unwind ladders working in a specific way and they
forget that, "Oh this ladder has a weird rung that we have to skip over."
We see these bugs more with locking.

	one = alloc();
	if (!one)
		return;

	lock();
	two = alloc();
	if (!two)
		goto free_one;  <-- should have unlocked before the goto
	unlock;

	three = alloc();
	if (!three)
		goto free_two;

	return 0;

free_two:
	free(two);
free_one:
	unlock();
	free(one);

	return -ENOMEM;

regards,
dan carpenter


