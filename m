Return-Path: <linux-kernel+bounces-95183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1AA874A58
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9EC1F20C2A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FB383A19;
	Thu,  7 Mar 2024 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZoMoFYo"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A561C2A3;
	Thu,  7 Mar 2024 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802440; cv=none; b=jUzmgI5f1TrzCc4CDAfsnvjaMjlTlWKDNDjBW1zodvVRqsSGDairapoJjAt8ckVppAiuRknn/rdZq8pPDVqtZO0KJHaNZNxViNuwAB3R2zl3qIJaFzMfqLFIrGGMPsJ7ntUanSg6OV8bBeaLPOhAiSjJhonTa6kIAQfMH76LByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802440; c=relaxed/simple;
	bh=Pda2tifda1uxhTuwgSnRPk7P0Rx7Ri+GXcWDUQip8YM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NegkkpCKze1I6Vxcw+lD9TwLee5aL9B54y6EEu2EZWPYUMfdYrtgaTZKMd1abmmrzbw0Kc7PRmgF8/CvJ3bDQKG1aOOMCq8uAHedWZxgnM0qFgEJ+h8pMC1cTpfQRaIynCwNVe9TWqboSXKRkUNMdCPk7uhbA/MEojdvO0cr4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZoMoFYo; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-787edfea5adso43991985a.2;
        Thu, 07 Mar 2024 01:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709802438; x=1710407238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDXKJ3yVafAMIzaPU15d+oR0sojzZuH0Yz2adcF+Uwc=;
        b=lZoMoFYoFtJ3206rh4GSMMqjY71KFBGIjpvv2yZOxfIT0BZlajhuKpGrd4qTQEARim
         VHa+95V1GM5ag2flmz3abT746nNUOEiefZZ21VFcrI2jOmutcpt4T1Bz0MycjB65s1av
         asn+e17Hv+7WL35OZIY8EhlNIFt8Qjimu0yQwgU6xVa8octuuJxfwFCMV4bLvlDFgr3k
         k+WBiW7aXrK9F5NyUTP68wPgBcy5sVrKKNz6HDeSH75sfhBsb/1A1kgJU4W0dQmTc0zZ
         7YjK0hjYoQ2TiUoEXH1TAvQLix7JB793oRBaXUtIMNMwamVRMz2JfW73Ud5ufQz5DaKz
         Bbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709802438; x=1710407238;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qDXKJ3yVafAMIzaPU15d+oR0sojzZuH0Yz2adcF+Uwc=;
        b=CYeXr8yuKDKefxsXu7i8PqrpXA4phrie7IhFd8aeChKmDdOx5X4VxBOW43LQoD0Hsy
         I0V/vO3FHuS3ctDAUsg0hLrXL4QKAmpQaq1xK7hBBMj3udIDKrNwN3vxrDqiXNI2sPL0
         LjEdKGKxW1GtKoYCaUL+u70cQoKYMKMOc/l/ODI9kbFoZeADCuqdh+TlFuyb7QMtHhM0
         2WQBOrcGrSdSCNfJWlT3b2vmgwD4Gd9b3DzlUE0+t81ijk/IneXvA1kp6LxCL9r4xYyu
         BcUuLrOfxDfjBuOo7BkkVhp6PCbPsXs9ODAnTiej2eJBsVu2nJ/nhSxihxI+xayxCkPt
         8L/A==
X-Forwarded-Encrypted: i=1; AJvYcCX5uRmFaeJPCuGumIKECwdC/55Uz8gMfDoyrRoyMURrn+Zup0WtM7d4cmji4xvswQ2JWqBLqvK8PavZw+hd5hq/7X2DPN/ZRQT/MWjiYZrpdzQ4HK5Zg9wCzRwnjNeT/auP36Fo
X-Gm-Message-State: AOJu0Yx7KAGurXYFOp2ERG4ZsOLi/RquqT0SdF8xABCc/tuI4qsNRvVs
	HNy9A10fNyfGJ5VynU+tRARf34GEkb23wDya6bt4zmE0UXGXgkpm
X-Google-Smtp-Source: AGHT+IEM5osKxEPkO+biHBaUBaE46cg/B0nhTfABPNlXDl6SuS5kKX6+XAcFSdN6DCuHcwNjGTBCsA==
X-Received: by 2002:a05:620a:40d6:b0:788:49fc:c758 with SMTP id g22-20020a05620a40d600b0078849fcc758mr452659qko.38.1709802437737;
        Thu, 07 Mar 2024 01:07:17 -0800 (PST)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id o13-20020ae9f50d000000b00788269e5d5fsm4229013qkg.94.2024.03.07.01.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:07:17 -0800 (PST)
Date: Thu, 07 Mar 2024 04:07:17 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <65e983c5155fa_f5b792941b@willemb.c.googlers.com.notmuch>
In-Reply-To: <65e82e533857c_a463929462@willemb.c.googlers.com.notmuch>
References: <ZeXQup48+X6U9TQ/@tpad>
 <65e82e533857c_a463929462@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net-next -v3] net/core/dev.c: enable timestamp static key
 if CPU isolation is configured
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Marcelo Tosatti wrote:
> > 
> > For systems that use CPU isolation (via nohz_full), creating or destroying
> > a socket with
> 
> - timestamping (SOCK_TIMESTAMPING_RX_SOFTWARE) might cause a
> + SO_TIMESTAMP, SO_TIMESTAMPNS or SO_TIMESTAMPING with flag
> + SOF_TIMESTAMPING_RX_SOFTWARE will cause a
> 
> > static key to be enabled/disabled. This in turn causes undesired
> > IPIs to isolated CPUs.
> > 
> > So enable the static key unconditionally, if CPU isolation is enabled,
> > thus avoiding the IPIs.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index c588808be77f..15a32f5900e6 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -155,6 +155,7 @@
> >  #include <net/netdev_rx_queue.h>
> >  #include <net/page_pool/types.h>
> >  #include <net/page_pool/helpers.h>
> > +#include <linux/sched/isolation.h>
> >  
> >  #include "dev.h"
> >  #include "net-sysfs.h"
> > @@ -11851,3 +11852,14 @@ static int __init net_dev_init(void)
> >  }
> >  
> >  subsys_initcall(net_dev_init);
> > +
> > +static int __init net_dev_late_init(void)
> > +{
> > +	/* avoid static key IPIs to isolated CPUs */
> > +	if (housekeeping_enabled(HK_TYPE_MISC))
> > +		net_enable_timestamp();
> > +
> > +	return 0;
> > +}
> > +
> > +late_initcall(net_dev_late_init);
> > 
> 
> Can this be included in the existing net_dev_init
> subsys_initcall?

You sent a v4, but can you answer this question?


