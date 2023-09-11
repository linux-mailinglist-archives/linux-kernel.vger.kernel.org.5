Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE2479AF76
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358334AbjIKWIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243900AbjIKSQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:16:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2858C110
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:16:27 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5007c8308c3so7914742e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694456185; x=1695060985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cDa5JU95ipLVTmCnhHx/vvuhcR66vjYPASjkoXlpLVc=;
        b=g0sWCZ2nUFFNy9s6oPBdJ1GuMh0SgAOgXR54toHUKRQcRXZWX3TN+TmQ3oLNP9RqkJ
         vMZnpC38WqPTWqZn7V0zzSzHJb3oFu7R6xJqpLW3Snncj4sr50ZHJZyIk6qhvDGnH5Ij
         TqGk1o9rzRKy28Ux9H9WXbb4YLcn1xgs99id5crY0PHg92eX/bzV/sXNBD0UWapPe8TX
         dJOOrfQkcufa3pCfUZBuxfEQ0CjRiFMkTaraWCq8XZXHzP6uqYWmPza5+gHP+VgYKwkz
         HSWc5Q+4n2oWOxjcpM2/8GXSf3ibWbidVLcGJ+d4GsRQvJBaZDX+ypksosF6E+lI1mXn
         P6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694456185; x=1695060985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDa5JU95ipLVTmCnhHx/vvuhcR66vjYPASjkoXlpLVc=;
        b=wA/lVsa49D7hr/86tawtKOPvYFtbPvzbarIhR7EtidYPSQYWeve8X++e/8KZFGdGb4
         y9fZZysHfoymRRVQv4GKFwiA6O5D/dS1dVI64kBi43/m6G/BmeRzHSTwwD35aBdV29v0
         l5voe+xFxVq6q/EfT76qLsFZpAmlP5iBAKdSt/8l6PPhmF8J7jRCq7BJUMqCBs7B6WVI
         ln7MC7xuo5qvVUlvMANLbSdUtYLi7tldt4z3IJiq+qWenuRW6FvZA5YkllNJWeVvuj6M
         pOXe+fHPXlhmdVRautmsDb830XTblXankClB7FmDe6Qe0MycsoyWlDVh8NPWNtXe6WE+
         OOEQ==
X-Gm-Message-State: AOJu0YwxZhRs5HiGU6mZyNfqOu26AFFYcLXFJwrgEgA1bH5xon1CyPDk
        iHoCCT1ez3e7+3WZ0d9l7OA=
X-Google-Smtp-Source: AGHT+IHG+d+2GrCBcS3fh+1b+isuHigZi+5jMtl9wDN4QG9NEdAnB3mW1/JZFET9TimfQWTDn/GFXw==
X-Received: by 2002:ac2:48b4:0:b0:500:ac0b:8d51 with SMTP id u20-20020ac248b4000000b00500ac0b8d51mr7445264lfg.37.1694456185037;
        Mon, 11 Sep 2023 11:16:25 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id u23-20020ac243d7000000b004fe5688b5dcsm1415042lfl.150.2023.09.11.11.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 11:16:24 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 11 Sep 2023 20:16:21 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
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
Message-ID: <ZP9ZdRc4FDSH2ej4@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-8-urezki@gmail.com>
 <ZP6QVTQmDGx7tx1a@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP6QVTQmDGx7tx1a@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 11:58:13AM +0800, Baoquan He wrote:
> On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > Extend the vread_iter() to be able to perform a sequential
> > reading of VAs which are spread among multiple nodes. So a
> > data read over the /dev/kmem correctly reflects a vmalloc
> > memory layout.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 67 +++++++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 53 insertions(+), 14 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 4fd4915c532d..968144c16237 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> ......  
> > @@ -4057,19 +4093,15 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
> >  
> >  	remains = count;
> >  
> > -	/* Hooked to node_0 so far. */
> > -	vn = addr_to_node(0);
> > -	spin_lock(&vn->busy.lock);
> 
> This could change the vread behaviour a little bit. Before, once we take
> vmap_area_lock, the vread will read out the content of snapshot at the
> moment. Now, reading out in one node's tree won't disrupt other nodes'
> tree accessing. Not sure if this matters when people need access
> /proc/kcore, e.g dynamic debugging.
>
With one big tree you anyway drop the lock after one cycle of reading.
As far as i see, kcore.c's read granularity is a PAGE_SIZE.

Please correct me if i am wrong.

> 
> And, the reading will be a little slower because each va finding need
> iterate all vmap_nodes[].
> 
Right. It is a bit tough here, because we have multiple nodes which
represent zones(address space), i.e. there is an offset between them,
it means that, reading fully one tree, will not provide a sequential
reading.

>
> Otherwise, the patch itself looks good to me.
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
>
Applied.

Thank you for looking at it!

--
Uladzislau Rezki
