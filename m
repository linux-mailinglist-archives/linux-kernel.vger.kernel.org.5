Return-Path: <linux-kernel+bounces-65684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2989A85505F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2981F22DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C399484A3D;
	Wed, 14 Feb 2024 17:31:23 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D86760DE5;
	Wed, 14 Feb 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931883; cv=none; b=qfFDAFiNMXxr2uYwNTXChj6JL8SbUUVUee3w96bWxEvmh82GGFtW8xV4bVdIzY2xOXglPwUZJz/PJO+ogzLcIiXXTomdyB9DpwX6lCPKhq8iXWhX+BzbR3MsEfk0aQf88z37nGz5y9Ir4K2p13r5ewsGRJEPleQavE39rslR5L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931883; c=relaxed/simple;
	bh=TI2ouCUQfA4fr9a9yre8mcJK8Eb5SODMsK3voKBojIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBbIfbs4N55BK53cJEwkl5sWw6fQKZtqYUQ9nwSoJY8s9trgEaJ6rbltPDWjkRdGsBWjnWSWRMxLpVVLULBmcmNYeYRMn63OGrs52eoA9VxRzRwHORBLSvzdSjPvT3mF1CeRUnONuTs0ff/PDPkexKan8kDCsXWnu83rpAAfGAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5116ec49081so6438801e87.2;
        Wed, 14 Feb 2024 09:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707931879; x=1708536679;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlfPrkPJhB6RnllcrS7qovDvaF/KY1qwGjvc2MBg3WE=;
        b=XGdCXJjHWdXkBkqhrCodfH6GaXui4Y77TNqIpr0+G4ZMk0R65+3tEyDnEwVhfDCNCW
         Mb9BY2ELEynu5x3C2gHO9FNpyeywVogBFoy9lT7r3kCEiH5HKPS965w+nLERZsYZq15/
         pJ1DTWjxMciMUR6Ck6sDRWvfWop+lM4FZ+labpi7+M/wHM4xSLrTEQNpCanTZ/vyEGWe
         cmQZcINMuCPXZT2l/X4RaXDUE/Gqd8pDDwLe0WhBFr0/qBRoeoVibgZrPRobiqGZUJ7S
         Gw2fpFQJeZpxB2jI7F+6j5xtFnggWDJSiMot8LSOe0NnMH9vdwCTSDZnvsDwGY9Mbwrj
         gUeg==
X-Forwarded-Encrypted: i=1; AJvYcCVCcqb/jOcPScfdl21y8DAG/SUQFOvj6a0LmDiORYAJKg5JsL52xtiJE/vv0PnRCd7k6rBmvnteeNfYKoITagBgdAsQSMPkMpCtfzCyD8uZtOFLd7m4LfXInuTElTdipQtx1KvASK2vKFQDJCkNeqT281y59N0RPmHFAL0xABUmLmnl5uYK3sAC
X-Gm-Message-State: AOJu0Yx01Xdnm3IZbAg1DkUtm1DKa52HWeO86Khh4XeE/qhPyzvOoTA5
	5uvjFVMQ2VsHj9fLR7Fh8Jm48Z40MhRxEJiT01kdk+UUtLzGIjZL
X-Google-Smtp-Source: AGHT+IHXwfnZmnQYY9psWLXdE3GzNd+Xny5u1iw5D5Lndpo1nClrZMWNF4+JqBThHbMfVH2MwHeK2A==
X-Received: by 2002:a05:6512:4dc:b0:511:5e2c:e63 with SMTP id w28-20020a05651204dc00b005115e2c0e63mr2269094lfq.59.1707931879222;
        Wed, 14 Feb 2024 09:31:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUS/aTw6rXkB58RduOcUE6wZ1CsNrUweG18iwnbpQhJSXLjs9OUeuTYWhRg9+f0Ny+68pSA1SGaoCEgzUoD+nqVuQVSDGUWkLw+oqvs5asDRoxKfB++I3+aIBZeUWBy9mAqTJz3ay0FuUjYHQ56GJxHkBaPVrlWREGyRwb5Yabp/KrK7Y+QwBvEWn0knEFVbpZ34EwW7kvW/dOziDAnPx+jOTkdfI8x0TdrDLy7COfxF9bRZu34pBtij56MYgZxxQ6optYj+gwaoSb/rlAusMG021RPnZZeoiKw9ef8BqA7GrWS4g5OfPfeytwD4AWRWKahBEflt7XBvh1yfXlNx3UzXu92P3jo8G4S0a1g5qXYWuepNAKBAor82j2nsArUgNQh38H5qHyVUqaNLnLW01dZaHS7THZru2L3kToooeAHNFoN68ObTtooTD965+pACWqh4I8sino7WSwrvDUKGwFCawjp7Z4hH7apxQzdMDKq5gc/oQiihXopWV5qWo44jIroFomgtb9AS1JJd8Xd8U+ZYRjzW+nbqvfbQIG2I1aURxe+Yeyc
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id d20-20020a1709064c5400b00a3c598d6b74sm2510250ejw.54.2024.02.14.09.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 09:31:18 -0800 (PST)
Date: Wed, 14 Feb 2024 09:31:16 -0800
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	pabeni@redhat.com, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>, weiwan@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: dqs: add NIC stall detector based on BQL
Message-ID: <Zcz45KZj9JxwjGtR@gmail.com>
References: <20240202165315.2506384-1-leitao@debian.org>
 <CANn89iLWWDjp71R7zttfTcEvZEdmcA1qo47oXkAX5DuciYvOtQ@mail.gmail.com>
 <20240213100457.6648a8e0@kernel.org>
 <ZczSEBFtq6E6APUJ@gmail.com>
 <CANn89iJH5jpvBCw8csGux9U10HwM+ewnL1A7udBi6uwAX6VBYA@mail.gmail.com>
 <ZczvGJ90L7689F6J@gmail.com>
 <CANn89i+zF3k4OyhJsK3sg5zNsFzKAQ5G_ANYEaxOfc41B7S18w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+zF3k4OyhJsK3sg5zNsFzKAQ5G_ANYEaxOfc41B7S18w@mail.gmail.com>

On Wed, Feb 14, 2024 at 05:58:37PM +0100, Eric Dumazet wrote:
> On Wed, Feb 14, 2024 at 5:49 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > On Wed, Feb 14, 2024 at 04:41:36PM +0100, Eric Dumazet wrote:
> > > On Wed, Feb 14, 2024 at 3:45 PM Breno Leitao <leitao@debian.org> wrote:
> > > >
> > > > On Tue, Feb 13, 2024 at 10:04:57AM -0800, Jakub Kicinski wrote:
> > > > > On Tue, 13 Feb 2024 14:57:49 +0100 Eric Dumazet wrote:
> > > > > > Please note that adding other sysfs entries is expensive for workloads
> > > > > > creating/deleting netdev and netns often.
> > > > > >
> > > > > > I _think_ we should find a way for not creating
> > > > > > /sys/class/net/<interface>/queues/tx-{Q}/byte_queue_limits  directory
> > > > > > and files
> > > > > > for non BQL enabled devices (like loopback !)
> > > > >
> > > > > We should try, see if anyone screams. We could use IFF_NO_QUEUE, and
> > > > > NETIF_F_LLTX as a proxy for "device doesn't have a real queue so BQL
> > > > > would be pointless"? Obviously better to annotate the drivers which
> > > > > do have BQL support, but there's >50 of them on a quick count..
> > > >
> > > > Let me make sure I understand the suggestion above. We want to disable
> > > > BQL completely for devices that has dev->features & NETIF_F_LLTX or
> > > > dev->priv_flags & IFF_NO_QUEUE, right?
> > > >
> > > > Maybe we can add a ->enabled field in struct dql, and set it according
> > > > to the features above. Then we can created the sysfs and process the dql
> > > > operations based on that field. This should avoid some unnecessary calls
> > > > also, if we are not display sysfs.
> > > >
> > > > Here is a very simple PoC to represent what I had in mind. Am I in the
> > > > right direction?
> > >
> > > No, this was really about sysfs entries (aka dql_group)
> > >
> > > Partial patch would be:
> >
> > That is simpler than what I imagined. Thanks!
> >
> 
> >
> > for netdev_uses_bql(), would it be similar to what I proposed in the
> > previous message? Let me copy it here.
> >
> >         static bool netdev_uses_bql(struct net_device *dev)
> >         {
> >                if (dev->features & NETIF_F_LLTX ||
> >                    dev->priv_flags & IFF_NO_QUEUE)
> >                        return false;
> >
> >                return true;
> >         }
> 
> I think this should be fine, yes.

Awesome, thanks.

I am planning to send this in separate from the "net: dqs: add NIC stall
detector based on BQL" patch since there isn't really a dependency here.

