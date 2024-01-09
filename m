Return-Path: <linux-kernel+bounces-20895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9153C828713
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353A91F253BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB6038FA6;
	Tue,  9 Jan 2024 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsIS+vGQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F338F95
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704806980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15WUaUtJR6dbWoV6G1ufbk9qhY55jeRmgoJT7AkGO8Y=;
	b=EsIS+vGQgcheTHGYVhOufhqgm6SVto3/cy0hNW/dsoUXX50vmS0w7dugaE2w+HbBD0p3TI
	n2l4LA3tkg0cFSCThkPJH6eBWx2nETv1EDBUvg+2oHOCXfBJyo1x0pWknq+Ol3ndH/7aEb
	ZnaYjQj4tG+RXYTOe8EMKVp1gXF5n6c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-ILWMBoojOBq-w87_asJT-g-1; Tue, 09 Jan 2024 08:29:39 -0500
X-MC-Unique: ILWMBoojOBq-w87_asJT-g-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-427e371c28cso47794561cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 05:29:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704806978; x=1705411778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15WUaUtJR6dbWoV6G1ufbk9qhY55jeRmgoJT7AkGO8Y=;
        b=IjMhe0IV4bFhHqTitLn4l7nhaerT/a37kD67d/Ogl31g3A4lYvyW5k46nzK3aEaw02
         ue0EVwPx4V8P1lZsazFlW2koGgA4r4XGmxRq4QxrnEpFs02iwr3ZKPrdIvlaqZH9IdA6
         9VxVJJEZkHusQUdvcIQ5mS18P2PHho24TzpmG9q93fiVP7oOFC8pBZsG+F+3T9Cv03kQ
         uHYgbZuG1X0ATmCH9JG3wokUrbFKmX1YOrtjRKnl7TpH8HbNYMljsEcFWx+kEZbxiYmk
         hwrO2gPIN+LWw5UZDJ6/PY8hNuKlwrB9ad76pv1juaKoSrVqEjB+gUSBqUOCffLiDyXE
         vbug==
X-Gm-Message-State: AOJu0YzAZAjp1a0wNqcCIEQSaT8/XqePUKLqaSanbAymQGXSD4lOzswH
	NdQrZkPCBZ7Kw0X8NZPpB7IUCPicqlqEnXN8FLsWKKoZxgwWtIILZ2VesPBcFoM4YOetcti50uf
	rSSKXyFFh0Yj+kSIMbCMl1XJAcT4GLhwv
X-Received: by 2002:a05:622a:245:b0:429:a2bc:3173 with SMTP id c5-20020a05622a024500b00429a2bc3173mr1630290qtx.124.1704806978656;
        Tue, 09 Jan 2024 05:29:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsIJB0i1Ie0GcVwu2hmfVgPidxfgcdf4zv+xDBG59MebZv/M1AFPN63TY4iMwZ7RdExAnXJw==
X-Received: by 2002:a05:622a:245:b0:429:a2bc:3173 with SMTP id c5-20020a05622a024500b00429a2bc3173mr1630278qtx.124.1704806978408;
        Tue, 09 Jan 2024 05:29:38 -0800 (PST)
Received: from fedora ([136.56.198.188])
        by smtp.gmail.com with ESMTPSA id c1-20020ac853c1000000b004181e5a724csm849005qtq.88.2024.01.09.05.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 05:29:37 -0800 (PST)
Date: Tue, 9 Jan 2024 08:29:36 -0500
From: Audra Mitchell <audra@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Audra Mitchell <aubaker@redhat.com>, linux-kernel@vger.kernel.org,
	raquini@redhat.com, jiangshanlai@gmail.com,
	hirokazu.yamauchi.hk@hitachi.com,
	Laurence Oberman <loberman@redhat.com>,
	Donald Douwsma <ddouwsma@redhat.com>
Subject: Re: [PATCH] workqueue.c: Change workqueue to accept variable length
 name
Message-ID: <ZZ1KQN5SBvujlXF8@fedora>
References: <20231215193954.1785069-1-audra@redhat.com>
 <ZYSwieA7FeYLh5Ey@mtj.duckdns.org>
 <CA+bDH-v6T5vvyOwsphseHwgihdGQta7TZ9tOtt-Fnij92kvU6A@mail.gmail.com>
 <ZYXNMEXBnuumL3D6@mac.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYXNMEXBnuumL3D6@mac.lan>

On Sat, Dec 23, 2023 at 02:53:52AM +0900, Tejun Heo wrote:
> Hello,
> 
> On Fri, Dec 22, 2023 at 10:35:03AM -0500, Audra Mitchell wrote:
> > We have one concrete example from a Hitachi block device driver (notice the
> > 47a1/47a2 gets
> > cut off with the workqueue name):
> > 
> > Device                              Workqueue Name (24char zero terminated)
> > /dev/sd0279b080047a1   xfs-blockgc/sd0279b0800
> > /dev/sd0279b080047a2   xfs-blockgc/sd0279b0800
> 
> I see, so it's a combination of somewhat lengthy device names and then xfs
> adding a prefix to them. Neither is particularly long but the combination
> is.
> 
> > I can also imagine this issue being present with nvme devices, but the
> > request came from Hitachi.
> > I believe it would be up to the device driver to determine if the name can
> > be shortened and I've
> > included Hitachi requester on this email thread.
> > 
> > Alternatively, we could increase the size of the WQ_NAME_LEN, but it seems
> > highly likely we are
> > going to butt against the static size again in the future. We previously
> > had variable length names
> > and it seems (to me) to be the best long term path forward.
> 
> Can we just bump the length to 32 and trigger a warning if the requested
> name overruns? I want to provide some pressure to limit the length of the
> name so that it doesn't get too long over time. If folks bump into it and
> can't find a different way to deal with it, we can get bring back the
> subject.

Hey Tejun!

Hope you had a nice holiday. I just got back from a bit of a break and will
work on your suggestions this week. Thanks a bunch for your feedback!

- Audra


