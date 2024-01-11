Return-Path: <linux-kernel+bounces-24054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 485DF82B619
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB928282CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E12E57335;
	Thu, 11 Jan 2024 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ofSShxPs"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298501E4A6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9bd63ec7fso3641922b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1705005459; x=1705610259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yxBuKN/MoPpwsq3PNEySr+XuvXYo9s46uBeQBOjipgw=;
        b=ofSShxPsxjE9vQwoRVuZOXLhJ7X/ZgY+D4gGYOPLzXHIdttTRMv6K9lhes6mE+OQQC
         VqYfKfNyZ1kUgwgXk4cieYRdK5ZTYtyfZO3kQXYum7QA7EWQAJQVlzFnP3RKBuFzuXE2
         6BQAYFu+lR4x0ItJPZntuc93Y16aPH97/BW2yCHyVPdRRnpxgjLvrh1qUKTylis7KgWd
         CRkXfyIBfml7BqN70SLfdgs+5dfC56JcpexSIDneOPNS/U13J+ciwZ6MtYR+u4UuxXr2
         C5fcx9yLiUnbFBOZfOfowvjGtLFK1UDCBiw4uw0acCyyuXfIII9NAGrBtxVCo4bSDKlm
         JrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705005459; x=1705610259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxBuKN/MoPpwsq3PNEySr+XuvXYo9s46uBeQBOjipgw=;
        b=IwZkmNVqdXZnTzjxcd2SAPj43vfPCcYBUCVMPzsQ3KzMQQ7pYndF/mBzRy4YbGRyPM
         PJJ6NAD03o24FPUcyrFSNFP2gxdB8Wzs7xDg2IVFstwV5lvdxPrJThNlNNG4rpSKLv6v
         bUOr9NuwEIRkhBpuMNr/0H2qKQ5xA7oo4ibzrtkAGPiQfFyBOOoMKmTPc3HC9DPgkq5f
         NXzU7gkk1+ziN+ek0+ttFQRILOYGsS2SPdXQISA0Vuh3NQHXbYlmJprozsgJy1t+K3jd
         iNkspSy+o9y+PiSnzxaVnmJ7jUPb2KdiuFkbxAfnI+NAQefSuczRzhg3sn/96u7ZF29A
         vwzg==
X-Gm-Message-State: AOJu0YxeB1rc5Z4G/05WkeIzdxkSXx6cjk4f+xGVCq46+Su++5XGThIT
	SwNsB0yUxuoHTKr/r5rtYldl+fIHaEO8zA==
X-Google-Smtp-Source: AGHT+IHaTMgRMIUpQCkZqRjmRqx46enVbiAFd75KWOBCpI2zzlw0tYf0YRat6Gx9TkzMZ7Pmkya6vA==
X-Received: by 2002:a05:6a00:2ea1:b0:6da:6c33:f269 with SMTP id fd33-20020a056a002ea100b006da6c33f269mr354614pfb.25.1705005459373;
        Thu, 11 Jan 2024 12:37:39 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id e17-20020aa78c51000000b006da105deedesm1598667pfd.197.2024.01.11.12.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 12:37:39 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rO1o0-00967a-2F;
	Fri, 12 Jan 2024 07:37:36 +1100
Date: Fri, 12 Jan 2024 07:37:36 +1100
From: Dave Chinner <david@fromorbit.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 07/11] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <ZaBRkCtkMoTdiN+3@dread.disaster.area>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-8-urezki@gmail.com>
 <ZZ+umGZ2NFQN/KuW@dread.disaster.area>
 <ZaAPSJHGsmG_oHAU@pc638.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaAPSJHGsmG_oHAU@pc638.lan>

On Thu, Jan 11, 2024 at 04:54:48PM +0100, Uladzislau Rezki wrote:
> On Thu, Jan 11, 2024 at 08:02:16PM +1100, Dave Chinner wrote:
> > On Tue, Jan 02, 2024 at 07:46:29PM +0100, Uladzislau Rezki (Sony) wrote:
> > > Concurrent access to a global vmap space is a bottle-neck.
> > > We can simulate a high contention by running a vmalloc test
> > > suite.
> > > 
> > > To address it, introduce an effective vmap node logic. Each
> > > node behaves as independent entity. When a node is accessed
> > > it serves a request directly(if possible) from its pool.
> > > 
> > > This model has a size based pool for requests, i.e. pools are
> > > serialized and populated based on object size and real demand.
> > > A maximum object size that pool can handle is set to 256 pages.
> > > 
> > > This technique reduces a pressure on the global vmap lock.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > 
> > Why not use a llist for this? That gets rid of the need for a
> > new pool_lock altogether...
> > 
> Initially i used the llist. I have changed it because i keep track
> of objects per a pool to decay it later. I do not find these locks
> as contented one therefore i did not think much.

Ok. I've used llist and an atomic counter to track the list length
in the past.

But is the list length even necessary? It seems to me that it is
only used by the shrinker to determine how many objects are on the
lists for scanning, and I'm not sure that's entirely necessary given
the way the current global shrinker works (i.e. completely unfair to
low numbered nodes due to scan loop start bias).

> Anyway, i will have a look at this to see if llist is easy to go with
> or not. If so i will send out a separate patch.

Sounds good, it was just something that crossed my mind given the
pattern of "producer adds single items, consumer detaches entire
list, processes it and reattaches remainder" is a perfect match for
the llist structure.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

