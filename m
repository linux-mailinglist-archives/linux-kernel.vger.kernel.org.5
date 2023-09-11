Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CA879B5B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbjIKVEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243419AbjIKRKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:10:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A628D1AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:10:48 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-501bd164fbfso7622327e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694452247; x=1695057047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6syMadHgFPAkfE/eyX/0s8O+02EDKPP57+xWFdRX0k=;
        b=nEo8kgODiVpY1wvDP1LlKWpiGLZLKE/pqC3zWnBU2YgSx/FI9Z6fjilb9TAcWYGxMW
         3BDGKxHpaXgQix3TfZApy3CUSLnVjzO3tzNhQ49skW3Fv7v/OzClJo/pP2iXbFFUAVdN
         MbvATiszS7qZzqJj/YAR3s96yEfftfyFI4hpqYkiM5UdRULfYtjP0TaBWY9GnZVetwDL
         eCpidkpwkw3nljRD8ihGTH54HRmaOHZr8RagmQXJOWICaaLhrKmfqbOkMnhRzamUaRMS
         nbysjAAUn8krVYj7HuQBxwIO6kg8lKAKHZTaYvIfxAwlwuArROYz4Ho6GPG9Bx5kiZpS
         Uong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694452247; x=1695057047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6syMadHgFPAkfE/eyX/0s8O+02EDKPP57+xWFdRX0k=;
        b=f/2PjGqJ5VQgfnqAocaNB58ddPbiZyULV+BwLZd1Pqx2B1ov3rScVQCPQ9CEMetQxO
         8g7mdbhE8bY7if7/JbUnd8f+HdVPbEAdcgUojuJP2fI4YkQGnyZdMCC8HgjV8/3fP1om
         UcslyA68m2V43QV2mmuy9DeniYVznZx7YVgvm9vcfMlaoZxaXWSGHKIrK5pHc+KrxiOj
         wx8gBgK4Dt2A8QIqBwjUb6dUgIoFQal3OIU8uHRGqRV9CIMuiv/30VuB1O1l1Ki+sAGg
         nlVi1Bl2WRxbN4chQuhBjPGUlqDnhs/188AuckY7J1igfwcGwAxTmBIdKoqdOoUYPi5H
         ZFow==
X-Gm-Message-State: AOJu0YxWTLnY6vPp1l5xtMW6m5RuFTUjVEkxRmBK6eaC9QrM4Rmt+HLo
        LHSDXXLrk3rTH2SCLSmm08QcwU6t6QdbdA==
X-Google-Smtp-Source: AGHT+IE44z9fPP/pxu0glLigR7PbpHaue9z+DSqHcXr9ybgrwq7WhRS1Ll8N+R95mx1ubxx/q+tjzA==
X-Received: by 2002:a05:6512:36cd:b0:502:bdbd:8442 with SMTP id e13-20020a05651236cd00b00502bdbd8442mr2528153lfs.50.1694452246410;
        Mon, 11 Sep 2023 10:10:46 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id q21-20020ac25295000000b004fe1bc7e4acsm1388027lfm.131.2023.09.11.10.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 10:10:45 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 11 Sep 2023 19:10:43 +0200
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
Subject: Re: [PATCH v2 6/9] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <ZP9KE8bU+c1Tp2Rg@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-7-urezki@gmail.com>
 <ZP6IjeCpDIqHgV0y@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP6IjeCpDIqHgV0y@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 11:25:01AM +0800, Baoquan He wrote:
> On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > Concurrent access to a global vmap space is a bottle-neck.
> > We can simulate a high contention by running a vmalloc test
> > suite.
> > 
> > To address it, introduce an effective vmap node logic. Each
> > node behaves as independent entity. When a node is accessed
> > it serves a request directly(if possible) also it can fetch
> > a new block from a global heap to its internals if no space
> > or low capacity is left.
> > 
> > This technique reduces a pressure on the global vmap lock.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 316 +++++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 279 insertions(+), 37 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 5a8a9c1370b6..4fd4915c532d 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -779,6 +779,7 @@ struct rb_list {
> >  
> >  struct vmap_node {
> >  	/* Bookkeeping data of this node. */
> > +	struct rb_list free;
> >  	struct rb_list busy;
> >  	struct rb_list lazy;
> >  
> > @@ -786,6 +787,13 @@ struct vmap_node {
> >  	 * Ready-to-free areas.
> >  	 */
> >  	struct list_head purge_list;
> > +	struct work_struct purge_work;
> > +	unsigned long nr_purged;
> > +
> > +	/*
> > +	 * Control that only one user can pre-fetch this node.
> > +	 */
> > +	atomic_t fill_in_progress;
> >  };
> >  
> >  static struct vmap_node *nodes, snode;
> > @@ -804,6 +812,32 @@ addr_to_node(unsigned long addr)
> >  	return &nodes[addr_to_node_id(addr)];
> >  }
> >  
> > +static inline struct vmap_node *
> > +id_to_node(int id)
> > +{
> > +	return &nodes[id % nr_nodes];
> > +}
> > +
> > +static inline int
> > +this_node_id(void)
> > +{
> > +	return raw_smp_processor_id() % nr_nodes;
> > +}
> > +
> > +static inline unsigned long
> > +encode_vn_id(int node_id)
> > +{
> > +	/* Can store U8_MAX [0:254] nodes. */
> > +	return (node_id + 1) << BITS_PER_BYTE;
> > +}
> > +
> > +static inline int
> > +decode_vn_id(unsigned long val)
> > +{
> > +	/* Can store U8_MAX [0:254] nodes. */
> > +	return (val >> BITS_PER_BYTE) - 1;
> > +}
> 
> This patch looks good to me. However, should we split out the encoding
> vn_id into va->flags optimization into another patch? It looks like an
> independent optimization which can be described better with specific
> log. At least, in the pdf file pasted or patch log, it's not obvious
> that:
> 1) node's free tree could contains any address range;
> 2) nodes' busy tree only contains address range belonging to this node;
>    - could contain crossing node range, corner case.
> 3) nodes' purge tree could contain any address range;
>    - decided by encoded vn_id in va->flags.
>    - decided by address via addr_to_node(va->va_start).
> 
> Personal opinion, feel it will make reviewing easier.
> 
Sure, if it is easier to review, then i will split these two parts.
All three statements are correct and valid. The pdf file only covers
v1, so it is not up to date.

Anyway i will update a cover letter in v3 with more details.

--
Uladzislau Rezki
