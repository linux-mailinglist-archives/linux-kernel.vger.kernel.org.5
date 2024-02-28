Return-Path: <linux-kernel+bounces-85264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0E986B32D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC06028BAE5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD7A15CD57;
	Wed, 28 Feb 2024 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi2m/Hfe"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA42CCDF;
	Wed, 28 Feb 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134379; cv=none; b=JfYFHcLy82oxqj9MVGSdnw2UpoFVVEK647jQMkQ7yzBLoeB1KbC9OgnGWYA5oGQTzWKnFYsVTLkvfL0M7s52de95+mTnIc6A/DhqL52vkyqEAfGTBNdBPbunQm+vPcNJxXx+c8cFCw0z+8uydbdRHTMElBHMgPOvFttGs0S1fGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134379; c=relaxed/simple;
	bh=eMOXCVDBo6+1DuKmb5bWVTwZLMGsk/p0Tc8klb/hjMs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=R2ES3xsgjHXPMMQYiEG6eniBtXWW9ZSkMT411MyycVsPl0kXu528x3NkiVbkOJrElBfHMT8wDWN2YDjYH2cfVVs9OE4+gnNj66rfAjXnFdTGJ2oUCruCkV+cO3GqsqU3PlaZ7KxPAaj4D0IKYWspLTmsg4IiUXMnCoI2xAP48RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zi2m/Hfe; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6900f479e3cso26096636d6.0;
        Wed, 28 Feb 2024 07:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709134377; x=1709739177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPdHn4gLfwbF9NBUo162FC73q3tXtmG68jirZU3UGyE=;
        b=Zi2m/HfefMFUFaUZ1Ok/mc64Mi6OxLr+xP5k5gyko36hpcr4nc4Rt5I5a/TYpkyChf
         ZRoHD8CAXtIQWkcrHA3Aziz1i5JEwKSjmCCIABuUa9b2SfNzgw0MCb7HnnN8n0+SXwGg
         iRUOEfACdivYp16Fl75nw9WRoiu+QBKFJkhkBH9F1DUy/Dua3vdyaKGRykt6prnBiIKO
         vQO69RT8oc/pwoFIxY6VfgKdtWqGmYr8V7BmpSVMLyBZJSKh+03HfmLaysT/O9va/kwh
         Y5cSguR0QatQm66Y5ItuXEafZFvJYxmBJ+G+kgnoKpip7/WsfCTuq8cCvE5pGn1zYghw
         PpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709134377; x=1709739177;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KPdHn4gLfwbF9NBUo162FC73q3tXtmG68jirZU3UGyE=;
        b=bcd5CnUASz2oWkmBAaDsWEqT/TWSW16u8V1hZpm+NBEkdnOBH/8aoUS1sd7rKCanb6
         G8zM2WvcBD9NGBkl5IpkcZmW2C7uy+voH+HTiQRIV5fPhHgeoICN+mnJCXF3s+8l026O
         QAMjTYxnKkjYQv/Rzem5NclVydHyKNqsEocX+Axhn2ewTMuyfY4evczPTuO0wcRHMmE2
         hMhfzwJrgR/kNA/IBSCtfQklVk5dnTpX9zlN7kW/4BshlO7CjvdVfoYfcDrQAm5Yz995
         XRqpm9Ky212BZcsw9iO3ruEUj/pJIw280tqzwZF6GlR7Fs1pIJ27xffpJRkBB+XmAKOl
         d4kA==
X-Forwarded-Encrypted: i=1; AJvYcCU4anYRuvILkEAvn8T+jtpMU8/mKCltTLfW5WoA79/k0z6jaOW4IuHfHzk3IRP21CRQgryDhVAULaGwvfjP627BymWtdEpmvusVyl0rkW2UTc5CSofIvbyaRGrgNj6RmMzzpN1G
X-Gm-Message-State: AOJu0YxVK3qMaVZMyKbL7JfzwH6HeLSuTqMAlsM+YS2HjgPdDeAqlOug
	HB1tD25ppsrYBDeR7mD96iArHlprxlOXsxHsRexvYrxSh8yys3bj
X-Google-Smtp-Source: AGHT+IESSnYnz43KE+tzOcvx5UZxfRl8t0fhKq+nDSRFt9IOaDcmUDz45Ga8zxM+kNS6h+siIdqUmA==
X-Received: by 2002:a0c:f144:0:b0:68f:3919:ebc2 with SMTP id y4-20020a0cf144000000b0068f3919ebc2mr6014087qvl.39.1709134377262;
        Wed, 28 Feb 2024 07:32:57 -0800 (PST)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id ks30-20020a056214311e00b0068fa4534070sm5319436qvb.83.2024.02.28.07.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 07:32:56 -0800 (PST)
Date: Wed, 28 Feb 2024 10:32:56 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcelo Tosatti <mtosatti@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <65df52286736b_7162829478@willemb.c.googlers.com.notmuch>
In-Reply-To: <Zd81gp2utD9+ripX@tpad>
References: <Zd81gp2utD9+ripX@tpad>
Subject: Re: [PATCH -v2 net-next] net/core/dev.c: enable timestamp static key
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

Marcelo Tosatti wrote:
> 
> For systems that use CPU isolation (via nohz_full), creating or destroying
> a socket with timestamping (SOCK_TIMESTAMPING_RX_SOFTWARE and 
> SOF_TIMESTAMPING_OPT_TX_SWHW) might cause a

Again, SOF_TIMESTAMPING_OPT_TX_SWHW is irrelevant here.

See Documentation/networking/timestamping.rst for a definition of the
various flags.

> static key to be enabled/disabled. This in turn causes undesired
> IPIs to isolated CPUs.
> 
> So enable the static key unconditionally, if CPU isolation is enabled,
> thus avoiding the IPIs.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> v2: mention SOF_TIMESTAMPING_OPT_TX_SWHW in the commit log (Willem de Bruijn / Paolo Abeni)

I did not suggest that

The subject line is slightly corrupted: net-next -v2

> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c588808be77f..15a32f5900e6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -155,6 +155,7 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/page_pool/types.h>
>  #include <net/page_pool/helpers.h>
> +#include <linux/sched/isolation.h>
>  
>  #include "dev.h"
>  #include "net-sysfs.h"
> @@ -11851,3 +11852,14 @@ static int __init net_dev_init(void)
>  }
>  
>  subsys_initcall(net_dev_init);
> +
> +static int __init net_dev_late_init(void)
> +{
> +	/* avoid static key IPIs to isolated CPUs */
> +	if (housekeeping_enabled(HK_TYPE_MISC))
> +		net_enable_timestamp();
> +
> +	return 0;
> +}
> +
> +late_initcall(net_dev_late_init);
> 



