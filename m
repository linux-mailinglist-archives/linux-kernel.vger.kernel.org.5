Return-Path: <linux-kernel+bounces-74955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C0985E075
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821DE1C23912
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7437FBD9;
	Wed, 21 Feb 2024 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoA6nDhx"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27E138398;
	Wed, 21 Feb 2024 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527842; cv=none; b=kaqNQ58dYjH9L1alGNGFAt396VQz7RozFJMg/b2e1gjKeTR3q/LxP5+UGaMx0VEjUl4AxQJyGM4i0XPYauAHXRkgdUZ8Urvq37BE00kcoi59NFhHo2W38wBpoWc0+4zGm1yovHO7TXjOomIN+1Kr3GalrQV4hE0Y2KTBeZZ8h2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527842; c=relaxed/simple;
	bh=k0YKRdcXLv7T6Y/xtVvaPhBbS5q+kGmG8nilLb4h+RM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bClQcKKRH8aog0h/oGsdcD7YSn/ipVWib7Yowg58HyYNGymE9Xuz+HlMpLfHgp7U/fb+JgHu1EtRGBWhRmNOmqT+ad3zc+/FrvnFL51nIVVj7L2OdOTpKG5M8OzL7yQKUIVEoLWzDVyMP8/hIqBxzd7yTgKebk5B3qI4DtYPyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoA6nDhx; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78725b62cf2so325089185a.1;
        Wed, 21 Feb 2024 07:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708527839; x=1709132639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pSFKbDD0hHRKl9KpChoMfKBPYL3gXyV4FEuLeI7tSI=;
        b=ZoA6nDhxJk2x/4YztFdkWvP9DW1XWqS7yAlH2ffZCbx2lZRvR8O0r9pJqPSmFZfAYf
         CTCPMk1yOYqfd2qXEpmapnHUYIQAavAiydo/Nz92Z8psuvb/EAXAjf72c76XsfVo4nCi
         /wXgpnBUivk4vmlorXiCtCnGWejb4pHr4Fv9fvics8RxYb85QYN1z/RU71kTLp6UOdqz
         C5mlui/IMwNZbD4EYFJAV1UtHQCN/UP7u+wlUoLDhe+I2TnRbZ1U+XpFn388c1ilH+vt
         EoRwKnsRKVp+qbL9mhz6HmJDcU6bulLGkLYS8ztr+u7k7SiFl5+gkM52eBvWS7UKd7Dz
         dGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708527839; x=1709132639;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8pSFKbDD0hHRKl9KpChoMfKBPYL3gXyV4FEuLeI7tSI=;
        b=aNLSwGkCyEExsFpwU1bupbCojSrOYhPShxXHefnrSGmBGE9yoXcRvaH6R6Nsh+UM23
         oFbl/8kxALJkqbwI22msVVSEhJ/Z9RL+d+swMkbdl1pZnTt0ll8IGsk8qWJRI61+YF/8
         KjT5xgFrwDdxtVeBwNi2slgA4jx68PfHZIiezkapDHx2RBKy9sIamLLACfu3qTh3pLCK
         /12NC9HGKSsbf21sTDj0TTuup/4eHpmxOqTxDb+Zp69gjIKiSbr/r03R+PWMuuhkTNS1
         sYXtP/mib98zWdcxL+eosoiLd+qJ1ouh1V2a0dWM1Xd+0Dx+Cw0aZKY7l/iIbq2pSNIL
         FEkA==
X-Forwarded-Encrypted: i=1; AJvYcCWXyZ74xd/jkQ8apP6OwM0x3dYNUN1I4nBQZ7kxQUaU+bINC4hDPqnKbA0ihalXqmpx/TahlNKSz6ghWA5r+r475c0QTZqr3CwidQVp
X-Gm-Message-State: AOJu0YwJArH2LhrDG1SS5l6PUjA0hHYQ86nJgwaa0KI9v15txb6F8V+k
	06it3YyfAqQv4aXZbTAu819FkRgNRWxQs12EZy7jFfy5jlAl8AvfhHDeNSRv
X-Google-Smtp-Source: AGHT+IH63gtd8yjx7ZG5d5Ka7XZEN4srWldxBljYBBHyYU3jY3K5r3913jDT7+5S75z4g8aq6t5jsA==
X-Received: by 2002:a05:620a:c16:b0:787:2275:3aa1 with SMTP id l22-20020a05620a0c1600b0078722753aa1mr18098886qki.10.1708527839421;
        Wed, 21 Feb 2024 07:03:59 -0800 (PST)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id qs21-20020a05620a395500b00787388490d3sm4369591qkn.89.2024.02.21.07.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:03:58 -0800 (PST)
Date: Wed, 21 Feb 2024 10:03:58 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: wangyunjian <wangyunjian@huawei.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "jasowang@redhat.com" <jasowang@redhat.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 xudingke <xudingke@huawei.com>
Message-ID: <65d610de7cd07_2824ff29494@willemb.c.googlers.com.notmuch>
In-Reply-To: <3f175a5ef4e34a0394ae584a0b84523e@huawei.com>
References: <1708398727-46308-1-git-send-email-wangyunjian@huawei.com>
 <65d4cc4b88e56_23483829431@willemb.c.googlers.com.notmuch>
 <3f175a5ef4e34a0394ae584a0b84523e@huawei.com>
Subject: RE: [PATCH net] tun: Fix xdp_rxq_info's queue_index when detaching
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

wangyunjian wrote:
> 
> 
> > -----Original Message-----
> > From: Willem de Bruijn [mailto:willemdebruijn.kernel@gmail.com]
> > Sent: Tuesday, February 20, 2024 11:59 PM
> > To: wangyunjian <wangyunjian@huawei.com>;
> > willemdebruijn.kernel@gmail.com; jasowang@redhat.com; kuba@kernel.org;
> > davem@davemloft.net
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > brouer@redhat.com; xudingke <xudingke@huawei.com>; wangyunjian
> > <wangyunjian@huawei.com>
> > Subject: Re: [PATCH net] tun: Fix xdp_rxq_info's queue_index when detaching
> > 
> > Yunjian Wang wrote:
> > > When a queue(tfile) is detached, we only update tfile's queue_index,
> > > but do not update xdp_rxq_info's queue_index. This patch fixes it.
> > >
> > > Fixes: 8bf5c4ee1889 ("tun: setup xdp_rxq_info")
> > > Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> > > ---
> > >  drivers/net/tun.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c index
> > > bc80fc1d576e..be37235af55d 100644
> > > --- a/drivers/net/tun.c
> > > +++ b/drivers/net/tun.c
> > > @@ -652,6 +652,7 @@ static void __tun_detach(struct tun_file *tfile, bool
> > clean)
> > >  				   tun->tfiles[tun->numqueues - 1]);
> > >  		ntfile = rtnl_dereference(tun->tfiles[index]);
> > >  		ntfile->queue_index = index;
> > > +		ntfile->xdp_rxq.queue_index = index;
> > >  		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
> > >  				   NULL);
> > 
> > Does it matter that this value is stale when undetached?
> 
> Yes, the detach tfile'queue_index is not important because the re-attach will update.
> But this patch is to fix the 'ntfile'(that replaces the detach tfile)'s queue_index, it is wrong.

Oh yes. This looks correct to me. Let's cc: the author of the patch listed as Fixed too.

> 
> Thanks
> > 
> > It is replaced in tun_attach if previously attached:
> > 
> > 		/* Re-attach detached tfile, updating XDP queue_index */
> >                 WARN_ON(!xdp_rxq_info_is_reg(&tfile->xdp_rxq));
> > 
> >                 if (tfile->xdp_rxq.queue_index    != tfile->queue_index)
> >                         tfile->xdp_rxq.queue_index = tfile->queue_index;



