Return-Path: <linux-kernel+bounces-23819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B4382B232
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15211C23633
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B18B4EB5C;
	Thu, 11 Jan 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3obFj26"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945C4CE0A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e72e3d435so5383922e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704988491; x=1705593291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9D6hjaSglgdfQvddjjobt6j5XcOqKqKM6+zvWQwcr/U=;
        b=Y3obFj26xGikUK/pKs/NnnJHXTUiLawFrm2Giei+t8h/ot4UgyxGam4RN1ZPp2sheR
         qrNjlnkgAkQtScHtzxTN8eju/Mm8iUew8GhkR8zBK77abHrqlVYq7WwL71kcSyJC70Y0
         HdSde8kfNBUKwFbg3HBAmZlrueMJAB641qwC/PNxEn6BZUy4TnAgFu0KESE7ITgOH/9C
         Iy5ERAfJbafLlYVrQ3MW9eUM96WhZXTy2ZUUHQgbEqOwjeiswdQ3z5rwCt4tlZrcry4a
         mhVuB9wHI0FFL9n4HK8BFSps65h/nEPE3akz1D9J4AQAnhzH418p02pamV9RnwZokGMN
         t9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704988491; x=1705593291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9D6hjaSglgdfQvddjjobt6j5XcOqKqKM6+zvWQwcr/U=;
        b=SxBz1WaC8KBCHwNX8PHCr8QwEMSui1uJDbm5NjHHq3PcdcVqadrZ9/5fW3ZZSOistb
         J/Xzlypw7aIdm3v8//lwNxQlbFPUmPabJGI8FBfn6nZ8Ldh4eO/CwHJ89qbQACLOobje
         i48uV1RDv/8sv7BYG7j3WS2PCNx4k7C5nqB6lbPMYkJ89edpSXzQF5ucVWN8wUxOEy0/
         roHTqrZYG5RBdrrte/tNiTPmIoHfSlS2FOKRheT5MzlVhqXq5z5DqXXurtu9BbfoixTt
         HKRwB0zec2OiE/wspfForddTjFzGq5++iZLkK+e6Kofl8FgeIu+7fAFfF1efWypWlpFO
         otdw==
X-Gm-Message-State: AOJu0Yys4yT1M89DzTWdDxupVA5hK8JfxEi0ZFd537aoSOn9hQdYFpB2
	HmT5ke3qDCPrrwznVNW+JKg=
X-Google-Smtp-Source: AGHT+IHWww78MAc9JmlyFjErWKyyUMNZFBcpBvlXspy60BDMWCT/6SDFn/2Pg6iG6jtsOZpHcyBc9Q==
X-Received: by 2002:a19:7617:0:b0:50e:a93a:fb7a with SMTP id c23-20020a197617000000b0050ea93afb7amr484815lff.184.1704988491077;
        Thu, 11 Jan 2024 07:54:51 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id f5-20020ac251a5000000b0050e8cd014d7sm234026lfk.16.2024.01.11.07.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 07:54:50 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Thu, 11 Jan 2024 16:54:48 +0100
To: Dave Chinner <david@fromorbit.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
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
Message-ID: <ZaAPSJHGsmG_oHAU@pc638.lan>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-8-urezki@gmail.com>
 <ZZ+umGZ2NFQN/KuW@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ+umGZ2NFQN/KuW@dread.disaster.area>

On Thu, Jan 11, 2024 at 08:02:16PM +1100, Dave Chinner wrote:
> On Tue, Jan 02, 2024 at 07:46:29PM +0100, Uladzislau Rezki (Sony) wrote:
> > Concurrent access to a global vmap space is a bottle-neck.
> > We can simulate a high contention by running a vmalloc test
> > suite.
> > 
> > To address it, introduce an effective vmap node logic. Each
> > node behaves as independent entity. When a node is accessed
> > it serves a request directly(if possible) from its pool.
> > 
> > This model has a size based pool for requests, i.e. pools are
> > serialized and populated based on object size and real demand.
> > A maximum object size that pool can handle is set to 256 pages.
> > 
> > This technique reduces a pressure on the global vmap lock.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Why not use a llist for this? That gets rid of the need for a
> new pool_lock altogether...
> 
Initially i used the llist. I have changed it because i keep track
of objects per a pool to decay it later. I do not find these locks
as contented one therefore i did not think much.

Anyway, i will have a look at this to see if llist is easy to go with
or not. If so i will send out a separate patch.

Thanks!

--
Uladzislau Rezki

