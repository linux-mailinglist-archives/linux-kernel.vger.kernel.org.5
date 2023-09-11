Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6647679B56C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354604AbjIKVyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243150AbjIKQx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:53:56 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E0D110
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:53:51 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so76814251fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694451229; x=1695056029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5srutzo1BddM/TCc6OOu/CdzmFcQ83QZi+pAlNeBHaY=;
        b=RyCZQKlseZ+jfmV4hvZpUIC5oKfSNMrkJz7AGdWF/K5cKn2cymyoQbcKjN4+dqEnuH
         WTzlav9zNTfnTT565GMHy9E2AfPxwTsr24cqXVOei3wqj2u8ZdBbL/wtmtJkZvcq63r2
         zy0gaXjDbyLuZZebJlUZsnV5tBZNuJc4tfJQ7FMgnIyHMdvCxNK8xazGE8juTiqdUW66
         v35J4ThPQgWB59NacpRZe5KEucjFI3n2ifmIuA4kMImikGaOWosE0bqu0u2rJjqwidyg
         TclYsGZw8W99toObrlHa3I07Pw3xvGVBBt/+lDx1ZK53HdwArXxvlc0hNmiZIuBe9ztD
         zvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451229; x=1695056029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5srutzo1BddM/TCc6OOu/CdzmFcQ83QZi+pAlNeBHaY=;
        b=Vo6VfCri1YfhzHzHsfcqX4Bo1MxZz1199jvulO/svxAFtmhTey/dJxZI7I8mRNRSj4
         7eFVKrXI5wgvucq2vbYwbqwzHpvD/af93ToTAJ8Jm1Zqtuw00Dskfp7IbRoCZc8CYPQd
         Z0hr9Q3hLG4h8CVh4jhJD/kOU7MqwIQFoERRn//v9A7R0ZsNzm6vV2zp00EZ8KRr1Z3V
         VYoquPTdz2Zy0C+7fjPkCJtwVCOQLK8omXMJBLAsSGkvF+a8ZSl9f+hJ73oxH1ulvNKQ
         nK9L+iOnU3nqP80YNozcGjN7q37cj3+VOeF6+V9k6XlOM3c6BS4w9AZOhKpcAZ8QN9e7
         5tDw==
X-Gm-Message-State: AOJu0Yxcp+yv8xwA0OdXES88RDBZkDLqQg2P7nfdYmrrApBe24PFNBvX
        D+XSVsBRRaSHak3d1HrZmIg=
X-Google-Smtp-Source: AGHT+IF5ie5+fR/y92Nbopcxkp0rBX3RA2X3/kgUn5aHdofrkbMm3oT0ubb25cM1f5j45OotNAJO3Q==
X-Received: by 2002:a2e:8850:0:b0:2bc:c51d:daa1 with SMTP id z16-20020a2e8850000000b002bcc51ddaa1mr9532788ljj.39.1694451229108;
        Mon, 11 Sep 2023 09:53:49 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id p15-20020a2e9a8f000000b002b9f4f3e16dsm1604798lji.85.2023.09.11.09.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:53:48 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 11 Sep 2023 18:53:45 +0200
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
Subject: Re: [PATCH v2 4/9] mm: vmalloc: Remove global vmap_area_root rb-tree
Message-ID: <ZP9GGW/q0nCFelLf@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-5-urezki@gmail.com>
 <ZP59pbh9SKROtjlr@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP59pbh9SKROtjlr@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 10:38:29AM +0800, Baoquan He wrote:
> On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > Store allocated objects in a separate nodes. A va->va_start
> > address is converted into a correct node where it should
> > be placed and resided. An addr_to_node() function is used
> > to do a proper address conversion to determine a node that
> > contains a VA.
> > 
> > Such approach balances VAs across nodes as a result an access
> > becomes scalable. Number of nodes in a system depends on number
> > of CPUs divided by two. The density factor in this case is 1/2.
> > 
> > Please note:
> > 
> > 1. As of now allocated VAs are bound to a node-0. It means the
> >    patch does not give any difference comparing with a current
> >    behavior;
> > 
> > 2. The global vmap_area_lock, vmap_area_root are removed as there
> >    is no need in it anymore. The vmap_area_list is still kept and
> >    is _empty_. It is exported for a kexec only;
> > 
> > 3. The vmallocinfo and vread() have to be reworked to be able to
> >    handle multiple nodes.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 209 +++++++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 161 insertions(+), 48 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index b7deacca1483..ae0368c314ff 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -728,11 +728,9 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
> >  #define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
> >  
> >  
> > -static DEFINE_SPINLOCK(vmap_area_lock);
> >  static DEFINE_SPINLOCK(free_vmap_area_lock);
> >  /* Export for kexec only */
> >  LIST_HEAD(vmap_area_list);
> > -static struct rb_root vmap_area_root = RB_ROOT;
> >  static bool vmap_initialized __read_mostly;
> >  
> >  static struct rb_root purge_vmap_area_root = RB_ROOT;
> > @@ -772,6 +770,38 @@ static struct rb_root free_vmap_area_root = RB_ROOT;
> >   */
> >  static DEFINE_PER_CPU(struct vmap_area *, ne_fit_preload_node);
> >  
> > +/*
> > + * An effective vmap-node logic. Users make use of nodes instead
> > + * of a global heap. It allows to balance an access and mitigate
> > + * contention.
> > + */
> > +struct rb_list {
> > +	struct rb_root root;
> > +	struct list_head head;
> > +	spinlock_t lock;
> > +};
> > +
> > +struct vmap_node {
> > +	/* Bookkeeping data of this node. */
> > +	struct rb_list busy;
> > +};
> > +
> > +static struct vmap_node *nodes, snode;
> > +static __read_mostly unsigned int nr_nodes = 1;
> > +static __read_mostly unsigned int node_size = 1;
> 
> It could be better if calling these global variables a meaningful name,
> e.g vmap_nodes, static_vmap_nodes, nr_vmap_nodes. When I use vim+cscope
> to reference them, it gives me a super long list. Aside from that, a
> simple name often makes me mistake it as a local virable. A weak
> opinion.
> 
I am OK to add "vmap_" prefix:

vmap_nodes;
vmap_nr_nodes;
vmap_node_size;
..

If you are not OK with that, feel free to propose other variants.

Thank you!

--
Uladzislau Rezki
