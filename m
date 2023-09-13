Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6280379ED82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjIMPnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjIMPnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:43:33 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248641FFB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:42:57 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b962535808so119286721fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694619775; x=1695224575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xZy/ik6yCjiyz1H5HblZSgJgBstuh1f5EQmTPAK0KFU=;
        b=S+vbavs90M3Wr0aexwXIVR7IdosM+kl6ElGWeSPc9FVbrSlLBHTCosMzy2G643ISRX
         bmYixCZgt1uNKi3J0mJjxPEonu16d1r9/a90yOTQCB4fkxXssgAS/lUtoRmecpCQHzbz
         55u+sFn+L5qyXRmQr/zJs34v43gYevYEpLfsaWpeLvIsAsHueaSO1aziFgO+ObIA0t4O
         eRfdVlMs6M6Bh1u8wKdrIm/xfd8r6LeuSi5Ly2J2F/XO/UGk3/jqgzxJz7Q8CiI+WSWB
         9FEIhvK+64HogkMGn/W1m16HLdiR+7wH+nMUB9AgBkMyVTixYEcQaplKxiDtoGbpQ6vp
         Hjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694619775; x=1695224575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZy/ik6yCjiyz1H5HblZSgJgBstuh1f5EQmTPAK0KFU=;
        b=gBOSQxzhZcWVWM80HBPyAi1T0JbJfi400jCbMhqwCzPVBYb5oqWZiEfbMSn6GFPRHR
         epuROTui0SR0hL8Ii3T0Jkck+uraBiml7r8kxV6rGmkHq2rxcZ08VKOAwiQPJ3IhOPIg
         ZVziOtUFUSt3tAmDvL0KFLK7s5pOaZfA+r5Xjm7hXhkvYzqkXS73I3/gZwetXPNfCx0L
         LGeHJ5nFpWfwXi8MVLq1HeGFaOXkcAke5OAJukavLNCAxGBadufd6Zq2IvYDEj0d5h1M
         tRtSGeSy3Vpx09ldHfdVL1EhzmwoPByvT0IiariBLLqj1Ggwxp6V3G1FeQuhdsZEF9D6
         3+nw==
X-Gm-Message-State: AOJu0YwdU2UIb4ygLQvLUKZQMXijduA+Je37r0TVUEiHIszJRf8WnTbY
        xJrRC6XVWU45WN8N5CjFc8s=
X-Google-Smtp-Source: AGHT+IFIJsojZFdmY9DxysMoa+ylnVzD6rIejsrMQlBfnlmAY/9rao7NpwYHkxUHzg7NAXEeWXEKzQ==
X-Received: by 2002:a2e:96cf:0:b0:2bc:d38e:65ab with SMTP id d15-20020a2e96cf000000b002bcd38e65abmr2765042ljj.37.1694619775104;
        Wed, 13 Sep 2023 08:42:55 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id z7-20020a2e9b87000000b002b9fe77d00dsm2455243lji.93.2023.09.13.08.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:42:54 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 13 Sep 2023 17:42:52 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 7/9] mm: vmalloc: Support multiple nodes in vread_iter
Message-ID: <ZQHYfO0GTco4qPEF@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-8-urezki@gmail.com>
 <ZP6QVTQmDGx7tx1a@MiWiFi-R3L-srv>
 <ZP9ZdRc4FDSH2ej4@pc636>
 <ZQBqyDxVuCphprk2@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQBqyDxVuCphprk2@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:42:32PM +0800, Baoquan He wrote:
> On 09/11/23 at 08:16pm, Uladzislau Rezki wrote:
> > On Mon, Sep 11, 2023 at 11:58:13AM +0800, Baoquan He wrote:
> > > On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > > > Extend the vread_iter() to be able to perform a sequential
> > > > reading of VAs which are spread among multiple nodes. So a
> > > > data read over the /dev/kmem correctly reflects a vmalloc
> > > > memory layout.
> > > > 
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  mm/vmalloc.c | 67 +++++++++++++++++++++++++++++++++++++++++-----------
> > > >  1 file changed, 53 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 4fd4915c532d..968144c16237 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > ......  
> > > > @@ -4057,19 +4093,15 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
> > > >  
> > > >  	remains = count;
> > > >  
> > > > -	/* Hooked to node_0 so far. */
> > > > -	vn = addr_to_node(0);
> > > > -	spin_lock(&vn->busy.lock);
> > > 
> > > This could change the vread behaviour a little bit. Before, once we take
> > > vmap_area_lock, the vread will read out the content of snapshot at the
> > > moment. Now, reading out in one node's tree won't disrupt other nodes'
> > > tree accessing. Not sure if this matters when people need access
> > > /proc/kcore, e.g dynamic debugging.
> > >
> > With one big tree you anyway drop the lock after one cycle of reading.
> > As far as i see, kcore.c's read granularity is a PAGE_SIZE.
> 
> With my understanding, kcore reading on vmalloc does read page by page,
> it will continue after one page reading if the required size is bigger
> than one page. Please see aligned_vread_iter() code. During the complete
> process, vmap_area_lock is held before this patch.
> 
> > 
> > > 
> > > And, the reading will be a little slower because each va finding need
> > > iterate all vmap_nodes[].
> > > 
> > Right. It is a bit tough here, because we have multiple nodes which
> > represent zones(address space), i.e. there is an offset between them,
> > it means that, reading fully one tree, will not provide a sequential
> > reading.
> 
> Understood. Suppose the kcore reading on vmalloc is not critical. If I
> get chance to test on a machine with 256 cpu, I will report here.
> 
It would be great! Unfortunately i do not have an access to such big
systems. What i have is 64 CPUs max system. If you, by chance can test
on bigger systems or can provide a temporary ssh access that would be
awesome.

--
Uladzislau Rezki
