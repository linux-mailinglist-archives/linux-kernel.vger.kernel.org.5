Return-Path: <linux-kernel+bounces-24647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8089D82BFAB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31151286CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B1C6A02E;
	Fri, 12 Jan 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPTW06PX"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748626A024
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cd17a979bcso72653441fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 04:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705061911; x=1705666711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oS2qn0GJyVpGgMF00XWbssPMomttVds4YoSmdD8QAUI=;
        b=fPTW06PXZclcX19wEQ/OIkTJicxTqxhJdQu5NqnYcVnCEn1Mh742GSfDKICZrNS/mq
         HOFSHdwFz8RfvIhSj87n0s8NjRCmwGrkKtjNYaA0kVHXfWRnYeZEVAT8Xba1nKGT57ft
         JxhM+jG1mlxL8kiq3lAK6o63wUpEipgHtbmZKhEml3Ft6DLJD0LvXep4qac2kQScTxks
         7UEobLzhnm0Sh11ThvnIB8ALJeruFqTiJJ8JM3USQ7VrYPlhGt7JSEl2B7CDiPyJY56G
         W0VDEw27sUmGd6wBdEujVh6tbBAHhAeh7tapbz4o+GFxIhb78DaO7v+pak/VaVvapEcT
         PMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705061911; x=1705666711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS2qn0GJyVpGgMF00XWbssPMomttVds4YoSmdD8QAUI=;
        b=HT/F9W4J9rDqzXoOYdTh8OSJhk225pKfRvqBjpuE/bX64QLksE+hV30pWTO+6aQRJB
         ocMoksdE4M856Y/zfcJShVpXntNrajWTMHOdOQpBd0sFtuXTSxe3jm79WOtgbPalBtRb
         +eKR0XeFPu3VXsmAWNtUXy67Gn7IJBKmRX8tdVkzmDH7EZZuuZKTUx38F8HitzityJ7O
         GPnQU3BWjLUUbN2S9IqX2latNG9LAp9Lar9BWRun6M9D+Cze2bNRv+r2pHK6v2kClt10
         zjftXIkWfnhWr/skZkFvhkMworQBv++/MNVVIwcOo7iXThN44Egjx6Kho8fPgtQI1BVh
         kBlA==
X-Gm-Message-State: AOJu0YwTH5fX/OSq0VwB6p2EaeIHc3N6R+2+Rn3ygsJd8s6syp5fvn28
	W/a15eSs8ACeKn7vuZMXjeE=
X-Google-Smtp-Source: AGHT+IFNYL1OyfgyDf+BH6IU8s3uCsnkAlJGEbJN8LXhms+M85RFhVMkhw3DJJPnaL0spCEIxORJyg==
X-Received: by 2002:a2e:9595:0:b0:2cc:7578:3ce6 with SMTP id w21-20020a2e9595000000b002cc75783ce6mr347140ljh.10.1705061911149;
        Fri, 12 Jan 2024 04:18:31 -0800 (PST)
Received: from pc636 (host-90-233-192-22.mobileonline.telia.com. [90.233.192.22])
        by smtp.gmail.com with ESMTPSA id k38-20020a05651c062600b002cd1d9bf77dsm457803lje.81.2024.01.12.04.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 04:18:30 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 12 Jan 2024 13:18:27 +0100
To: Dave Chinner <david@fromorbit.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 07/11] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <ZaEuE37TIM1s3OXF@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-8-urezki@gmail.com>
 <ZZ+umGZ2NFQN/KuW@dread.disaster.area>
 <ZaAPSJHGsmG_oHAU@pc638.lan>
 <ZaBRkCtkMoTdiN+3@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaBRkCtkMoTdiN+3@dread.disaster.area>

On Fri, Jan 12, 2024 at 07:37:36AM +1100, Dave Chinner wrote:
> On Thu, Jan 11, 2024 at 04:54:48PM +0100, Uladzislau Rezki wrote:
> > On Thu, Jan 11, 2024 at 08:02:16PM +1100, Dave Chinner wrote:
> > > On Tue, Jan 02, 2024 at 07:46:29PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > Concurrent access to a global vmap space is a bottle-neck.
> > > > We can simulate a high contention by running a vmalloc test
> > > > suite.
> > > > 
> > > > To address it, introduce an effective vmap node logic. Each
> > > > node behaves as independent entity. When a node is accessed
> > > > it serves a request directly(if possible) from its pool.
> > > > 
> > > > This model has a size based pool for requests, i.e. pools are
> > > > serialized and populated based on object size and real demand.
> > > > A maximum object size that pool can handle is set to 256 pages.
> > > > 
> > > > This technique reduces a pressure on the global vmap lock.
> > > > 
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > 
> > > Why not use a llist for this? That gets rid of the need for a
> > > new pool_lock altogether...
> > > 
> > Initially i used the llist. I have changed it because i keep track
> > of objects per a pool to decay it later. I do not find these locks
> > as contented one therefore i did not think much.
> 
> Ok. I've used llist and an atomic counter to track the list length
> in the past.
> 
> But is the list length even necessary? It seems to me that it is
> only used by the shrinker to determine how many objects are on the
> lists for scanning, and I'm not sure that's entirely necessary given
> the way the current global shrinker works (i.e. completely unfair to
> low numbered nodes due to scan loop start bias).
> 
I use the length to decay pools by certain percentage, currently it is
25%, so i need to know number of objects. It is done in the purge path.
As for shrinker, once it hits us we drain pools entirely.

> > Anyway, i will have a look at this to see if llist is easy to go with
> > or not. If so i will send out a separate patch.
> 
> Sounds good, it was just something that crossed my mind given the
> pattern of "producer adds single items, consumer detaches entire
> list, processes it and reattaches remainder" is a perfect match for
> the llist structure.
> 
The llist_del_first() has to be serialized. For this purpose a per-cpu
pool would work or kind of "in_use" atomic that protects concurrent
removing.

If we detach entire llist, then we need to keep track of last node
to add it later as a "batch" to already existing/populated list.

Thanks four looking!

--
Uladzislau Rezki

