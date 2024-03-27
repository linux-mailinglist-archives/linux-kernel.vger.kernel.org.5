Return-Path: <linux-kernel+bounces-121450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC3B88E9EC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13845B37B99
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74E5149C74;
	Wed, 27 Mar 2024 14:38:13 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E7013A26B;
	Wed, 27 Mar 2024 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550293; cv=none; b=pKo3zeb9f0XqQsjFxbGUTuro3b82xy03jkn1+iLdVqO9L/rcQXxjV21FENMpi9KyMPDRVzoD2mXaRQw2PJ1FohJtTDcCv/l2hRhTL1G01hi/dyRCzSmT4EBMHYloOr1h82qy6QnRjWF4dqBvm5L5ET2s6S4EBd4asTBB+kELq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550293; c=relaxed/simple;
	bh=VX5k21NRx3fWguIphiWuA1EPQi1w9iEZgiguBcBjjl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYeJSVgiGHuOHr/HLiP5cbN8Coyc6xGlXiZpYthkV1NaxQTjuo9iPAX3qXYSR9SohcR+7j3U7q52bSEk8l7Vh3ne4ofxVVpPbZC/xLKZbhSlxiamsB+CLR+6l1ezv6C0qegY1S9duqgNyn819K0SBmbJYcVqOdYncsGzWQ8KAkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513e89d0816so8409769e87.0;
        Wed, 27 Mar 2024 07:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711550288; x=1712155088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHLS+yjkto2+nMleZ8grHPnFghQaTySqd33/PIFTa3E=;
        b=ZcVbjXpVqPo5+kUBp461VA9DY9OnghGnb+gOJW9vCRIg+aQ+kua4sQxd1nAJdH2OUZ
         G6e3xL40HHVrSKguS4DYDA9w3oqMDi5ofxdJQ+3FR1uNc/snRMnhFrV5T5dv06qE0GmD
         APw3iz5mHonXQnVrt5ZpIw6adatJlueocxunkcFw67x8gj33VaI59ADmPW7bLNSh7uJc
         lrcl84m4noXudVy9eqQtcIEJt85usnCUQ0X5um1wuYQRzovitc8pGSKEHmiNrF1yoMSp
         j2fahlOAj7nlMDOY2SDjm2sHNoz3rkEfSJUt3id8JbzZpwmn0dC/+z0HHr715pqIKX6l
         TSAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAwXw7ly1ugWAVnvQk40KNk1FsVml8f/MlfeQxkoZQ3T+LhEqnJMBIhaTup0mqMl07X+75R3I6epqgG3T5ujbHVT/hUO0PSukewotIKfelQ7BTBl1TFjjY7axbB1lk/4pKJPz3rT2eu7KPIbU=
X-Gm-Message-State: AOJu0Yzqmwg7aEh1LJvCRgDvVNiZBi9CD6/JE3mfyBAsHC5BZ9p1p9qP
	s7+34RCynrHDfwfj/sUwknnbk/SOTwGSpuoCFxjpGIjQ/4EbX/E2
X-Google-Smtp-Source: AGHT+IES0d/otFDGydKDRmqo9wlgMp2zSraYoybu3fR4X81qxCRc+daWncgKBaKZFHeZwGdozoKHlg==
X-Received: by 2002:a05:6512:2e8:b0:515:a417:334 with SMTP id m8-20020a05651202e800b00515a4170334mr1007582lfq.46.1711550288177;
        Wed, 27 Mar 2024 07:38:08 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id t2-20020a1709067c0200b00a47090964casm2285717ejo.184.2024.03.27.07.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 07:38:07 -0700 (PDT)
Date: Wed, 27 Mar 2024 07:38:05 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, keescook@chromium.org,
	"open list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>,
	"open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath10k: allocate dummy net_device dynamically
Message-ID: <ZgQvTTnMoBn2oG1K@gmail.com>
References: <20240319104754.2535294-1-leitao@debian.org>
 <9fcdb857-da62-4832-ae11-043fe993e4ad@quicinc.com>
 <20240321072821.59f56757@kernel.org>
 <5039256c-03eb-4cda-8d11-49e4561cf1ef@quicinc.com>
 <20240321151744.246ce2d0@kernel.org>
 <Zf2ceu2O47lLbKU3@gmail.com>
 <20240322082336.49f110cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322082336.49f110cc@kernel.org>

Hello Jakub,

On Fri, Mar 22, 2024 at 08:23:36AM -0700, Jakub Kicinski wrote:
> > > Maybe we should add a new helper to "alloc dummy netdev" which can
> > > call alloc_netdev() with right arguments and do necessary init?  
> > 
> > What are the right arguments in this case?
> 
> I'm not sure we have a noop setup() callback today. If you define a
> wrapper to allocate a dummy netdev you can define a new empty function
> next to it and pass that as init? Hope I got the question right.

Thanks for the explanation, it is clear now. I've been working on it,
and this is what I came up with. This is compile-tested by now, and, if
this is what you had in mind, I will do more extensive testing.

  commit db794d99950f68731884a67d911094d94179c522
  Author: Breno Leitao <leitao@debian.org>
  Date:   Wed Mar 27 07:20:03 2024 -0700
  
      net: Create net_device allocator for dummy
      
      Create a helper to allocate and initialize dummy netdevices. This
      function basically simplify the allocation of dummy devices, by
      allocating and initializing it.
      
      Suggested-by: Jakub Kicinski <kuba@kernel.org>
      Signed-off-by: Breno Leitao <leitao@debian.org>
  
  diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
  index 643d2b469c49..9d1a5383c23f 100644
  --- a/include/linux/netdevice.h
  +++ b/include/linux/netdevice.h
  @@ -4546,6 +4546,9 @@ static inline void netif_addr_unlock_bh(struct net_device *dev)
   
   void ether_setup(struct net_device *dev);
   
  +/* Allocate dummy net_device */
  +struct net_device *alloc_netdev_dummy(int sizeof_priv, const char *name);
  +
   /* Support for loadable net-drivers */
   struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
   				    unsigned char name_assign_type,
  diff --git a/net/core/dev.c b/net/core/dev.c
  index a08d698fe45c..628f35c3cfa2 100644
  --- a/net/core/dev.c
  +++ b/net/core/dev.c
  @@ -10998,6 +10998,13 @@ void free_netdev(struct net_device *dev)
   }
   EXPORT_SYMBOL(free_netdev);
   
  +struct net_device *alloc_netdev_dummy(int sizeof_priv, const char *name)
  +{
  +	return alloc_netdev(sizeof_priv, name, NET_NAME_UNKNOWN,
  +			    init_dummy_netdev_core);
  +}
  +EXPORT_SYMBOL_GPL(alloc_netdev_dummy);
  +
   /**
    *	synchronize_net -  Synchronize with packet receive processing
    *
  
  commit 35500cd6a5db0bbdedbc1067758948769c7ce57e
  Author: Breno Leitao <leitao@debian.org>
  Date:   Wed Mar 27 07:07:40 2024 -0700
  
      net: Split init_dummy_netdev
      
      It is impossible to use init_dummy_netdev together with alloc_netdev()
      as the 'setup' argument.
      
      This is because alloc_netdev() initializes some fields in the net_device
      structure, and later init_dummy_netdev() memzero them all. This casues
      some problems as reported here:
      
              https://lore.kernel.org/all/20240322082336.49f110cc@kernel.org/
      
      Split the function in two. Create a new function called
      init_dummy_netdev_core() that does not memset the net_device structure.
      Then have init_dummy_netdev() memseting and calling
      init_dummy_netdev_core().
      
      init_dummy_netdev_core() will be the function that could be called as
      an argument for alloc_netdev().
      
      Signed-off-by: Breno Leitao <leitao@debian.org>
  
  diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
  index c6f6ac779b34..643d2b469c49 100644
  --- a/include/linux/netdevice.h
  +++ b/include/linux/netdevice.h
  @@ -3119,6 +3119,7 @@ int netdev_refcnt_read(const struct net_device *dev);
   void free_netdev(struct net_device *dev);
   void netdev_freemem(struct net_device *dev);
   void init_dummy_netdev(struct net_device *dev);
  +void init_dummy_netdev_core(struct net_device *dev);
   
   struct net_device *netdev_get_xmit_slave(struct net_device *dev,
   					 struct sk_buff *skb,
  diff --git a/net/core/dev.c b/net/core/dev.c
  index 0766a245816b..a08d698fe45c 100644
  --- a/net/core/dev.c
  +++ b/net/core/dev.c
  @@ -10340,25 +10340,11 @@ int register_netdevice(struct net_device *dev)
   }
   EXPORT_SYMBOL(register_netdevice);
   
  -/**
  - *	init_dummy_netdev	- init a dummy network device for NAPI
  - *	@dev: device to init
  - *
  - *	This takes a network device structure and initialize the minimum
  - *	amount of fields so it can be used to schedule NAPI polls without
  - *	registering a full blown interface. This is to be used by drivers
  - *	that need to tie several hardware interfaces to a single NAPI
  - *	poll scheduler due to HW limitations.
  +/* Same as init_dummy_netdev, but, basically do not call memset.
  + * This is useful if you are calling this function after alloc_netdev()
    */
  -void init_dummy_netdev(struct net_device *dev)
  +void init_dummy_netdev_core(struct net_device *dev)
   {
  -	/* Clear everything. Note we don't initialize spinlocks
  -	 * are they aren't supposed to be taken by any of the
  -	 * NAPI code and this dummy netdev is supposed to be
  -	 * only ever used for NAPI polls
  -	 */
  -	memset(dev, 0, sizeof(struct net_device));
  -
   	/* make sure we BUG if trying to hit standard
   	 * register/unregister code path
   	 */
  @@ -10379,8 +10365,29 @@ void init_dummy_netdev(struct net_device *dev)
   	 * its refcount.
   	 */
   }
  -EXPORT_SYMBOL_GPL(init_dummy_netdev);
  +EXPORT_SYMBOL_GPL(init_dummy_netdev_core);
   
  +/**
  + *	init_dummy_netdev	- init a dummy network device for NAPI
  + *	@dev: device to init
  + *
  + *	This takes a network device structure and initialize the minimum
  + *	amount of fields so it can be used to schedule NAPI polls without
  + *	registering a full blown interface. This is to be used by drivers
  + *	that need to tie several hardware interfaces to a single NAPI
  + *	poll scheduler due to HW limitations.
  + */
  +void init_dummy_netdev(struct net_device *dev)
  +{
  +	/* Clear everything. Note we don't initialize spinlocks
  +	 * are they aren't supposed to be taken by any of the
  +	 * NAPI code and this dummy netdev is supposed to be
  +	 * only ever used for NAPI polls
  +	 */
  +	memset(dev, 0, sizeof(struct net_device));
  +	init_dummy_netdev_core(dev);
  +}
  +EXPORT_SYMBOL_GPL(init_dummy_netdev);
   
   /**
    *	register_netdev	- register a network device
  

