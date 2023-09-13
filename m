Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81AB79ED4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjIMPi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjIMPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:38:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A22B93
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:38:53 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso120260271fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694619531; x=1695224331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFpe8x5qo/g5j4s2/ldCOIs5ClZpZwe3ie5guHHQEOQ=;
        b=SzVNOQtmcR3QlIoPx8L6Acz0EiroH7jYnSnid84ZiG0Cio8bFMumZcoCFDgqHeHEU2
         XKkX0j20MIuuOAWXNZJFEqwssA0yB7RB+APocnOUpDNtKoogsSy3qh6IfIVVRDj4RBoS
         XfrQZDT1MT8t57Wh7rEhJQJn48f32w0+Al9q0IXv84LfjNUBS/fULsaq5jERn9lt9rao
         B0KI/jZdqtxlsl1T5a8Du2+rUSR/nuudIPPS+Edkb/t+TokjBX3rJ9MLaVGSZrNDc49V
         fVLLH2wPF+TeCrzy4IC7Dlizj00dYZ0mGWxXgVoWD2AGg3BDczc/ALbd2S+mNvLJVlRr
         HsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694619531; x=1695224331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFpe8x5qo/g5j4s2/ldCOIs5ClZpZwe3ie5guHHQEOQ=;
        b=fLr17Brv+ZiYXMvaTjvf+iQpLSrEZkABzXIWMGcjTqeV6i30ME2fj3Rf8bbuAS+sRh
         Uw7VK0nV16hw+Usv0F2FZ8BDf2qHltvv1tHeqJM88xpzfQtm5X+MwZFncGfrw1jPgJ2T
         CIKk+D5MW9Aj719gexLTVySPPTyesbPt0/CucylbUTNnARysYLxFnrr4Dw0vX3yjPnxw
         xNAqi28BbO5GNLYBR1c5rCY8AOBHGLvedzFsxD+ol0nIXV4pNYxylxzX8qysfXgtP+f+
         Wiz6VE2SEry1TjQOk+PY9Nuy1yQbpsx5qf3xN6bRcxfeCNQc0FhhBtcwfF6Wk/9AKrN7
         6w6g==
X-Gm-Message-State: AOJu0YzAp+lvFL3pcuneaTkelQQXWuxilOE47EDzIWMKV5mxyrBqOpau
        BeqFGwMkWW5RVDJ5sbtLj34=
X-Google-Smtp-Source: AGHT+IHh4Xjck4Cj5JBjtVgxQDZ/oh8VR3i7Oss7PxQ87xkSrwAos7R7oxCXtYc+QMOGlcpWKv0evg==
X-Received: by 2002:ac2:51bc:0:b0:4ff:a8c6:d1aa with SMTP id f28-20020ac251bc000000b004ffa8c6d1aamr2107222lfk.48.1694619530936;
        Wed, 13 Sep 2023 08:38:50 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id x13-20020ac25dcd000000b004fbddb14020sm2182107lfq.56.2023.09.13.08.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:38:50 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 13 Sep 2023 17:38:48 +0200
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
Message-ID: <ZQHXiKJbINsuqfzt@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-8-urezki@gmail.com>
 <ZP6QVTQmDGx7tx1a@MiWiFi-R3L-srv>
 <ZP9ZdRc4FDSH2ej4@pc636>
 <ZQGWHmESO/GpScHo@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQGWHmESO/GpScHo@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 06:59:42PM +0800, Baoquan He wrote:
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
> You are right, kcore.c's reading granularity is truly PAGE_SIZE.
> I don't know procfs well, still need to study the code. Then it doesn't
> matter much with the multiple nodes in vread_iter(). Sorry for the noise.
> 
> static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
> {  
> 	......
>         start = kc_offset_to_vaddr(*fpos - data_offset);
>         if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
>                 tsz = buflen;
> 
> 	m = NULL;
>         while (buflen) {
> 	}
> 	...
> }
> 
Good. Then we are on the same page :)

Thank you!

--
Uladzislau Rezki
