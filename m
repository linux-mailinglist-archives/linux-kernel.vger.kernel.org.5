Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662DD793311
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 02:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244122AbjIFAxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 20:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjIFAxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 20:53:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305FECDB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 17:53:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c337aeefbdso21152945ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 17:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693961595; x=1694566395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNbJ8Xh/lpTcyZ6zob7yaBq8XspnWgOm5MTNQgKj8PE=;
        b=R2XgdW2x13m+/pb3XZaOeSpRiCKR3shHzL2hmieghN1aQ/m5xCuOCaLSLFC4ZuHwqc
         oMBfeC3C6Tq0145kZW5g3817RnDqzMxR4Q1z6pvcBV23zhwfQVEqzDXmRw2A7e8fvdHX
         xfnZHDGtsZv8o3FyABt5HMD4gJHLDHSoX/JVN1KG+mnO8iOdx+9hDOMtS7WCRJ7pIMeu
         z/UrFZwrw1vIBRipScezcuYAsCFJEwA/BUK9j+i3hlJoXFI5eESdLUIfnIssLesVQ10z
         WhcVpkVWUZK88ukU+WAWO3DWhI+ZuHSzdDloIVaGOy8w/lmUjrB9m1B+Lz1Tm8M1hQfw
         UGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693961595; x=1694566395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNbJ8Xh/lpTcyZ6zob7yaBq8XspnWgOm5MTNQgKj8PE=;
        b=DJw+LhtUFd73rxf72f8AXqpchYmNBJptJjcX9+Pr83goVlfKv/jc//pxeewu4xipjB
         OJY7nejFwZahbKi9sU6TSNyISw0yLuwt03CDxKW8zp0XNSjUgepTEJYszdpf+NkJfH3+
         6jB788N1z/YdbqmqaWuabV6zL3hR9/XqOum6YDAvidkXVp3+C+sWgnSTsycnnaeUGfvA
         lz/oXF2NJoMxoZbhd0JIQacWJ5d+Q6uG4aHrP9N/mXAASk7SO7wRZxqY8SfF8mctE0PC
         StJXbqxh6SdsgB9/Xa0ygZvIDosByTejMl50i3arQlACpUBKkyCueEhGw8wu8cVua0yG
         kg2A==
X-Gm-Message-State: AOJu0Yz+rlyFo6gR05JI+msmpQr/sMP5gAB043n71wDuAuNGDYZYo0O/
        HKG8r4MVCYSB8OsC/s/s07G3clr+3WH6nw==
X-Google-Smtp-Source: AGHT+IE9iPqXykM2fiujUN63wC5KgY/EHFhkgqRFRrGmzyWt8LBow1u/GcVms3ZWN4URFmyD5Sz8NA==
X-Received: by 2002:a17:903:249:b0:1a9:b8c3:c2c2 with SMTP id j9-20020a170903024900b001a9b8c3c2c2mr18721337plh.37.1693961595476;
        Tue, 05 Sep 2023 17:53:15 -0700 (PDT)
Received: from localhost (42.122.96.58.static.exetel.com.au. [58.96.122.42])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001bdd68b3f4bsm9888214plc.295.2023.09.05.17.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 17:53:14 -0700 (PDT)
From:   Education Directorate <bsingharora@gmail.com>
X-Google-Original-From: Education Directorate <directorate@ed.act.edu.au>
Date:   Wed, 6 Sep 2023 10:53:11 +1000
To:     "liwenyu01@bilibili.com" <liwenyu01@bilibili.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wangyun@bilibili.com" <wangyun@bilibili.com>
Subject: Re: [PATCH RFC] delayacct: add memory reclaim delay in
 get_page_from_freelist
Message-ID: <ZPfNdzXCqSx2mV6m@balbir-desktop>
References: <SH0PR01MB058780B26AB21BEB8E76B6BBC11CA@SH0PR01MB0587.CHNPR01.prod.partner.outlook.cn>
 <SH0PR01MB0587E4A7886C9642CCF1F8DBC1E5A@SH0PR01MB0587.CHNPR01.prod.partner.outlook.cn>
 <20230902164454.30dda58820ced683849b45cb@linux-foundation.org>
 <SH0PR01MB0587592CA2974791B177BFA4C1E8A@SH0PR01MB0587.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SH0PR01MB0587592CA2974791B177BFA4C1E8A@SH0PR01MB0587.CHNPR01.prod.partner.outlook.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 05:32:15AM +0000, liwenyu01@bilibili.com wrote:
> >> reclaim of the task in do_try_to_free_pages(). In systems with NUMA
> >> open, some tasks occasionally experience slower response times, but the
> >> total count of reclaim does not increase, using ftrace can show that
> >> node_reclaim has occurred.
> >>
> >> The memory reclaim occurring in get_page_from_freelist() is also due to
> >> heavy memory load. To get the impact of tasks in memory reclaim, this
> >> patch adds the statistics of the memory reclaim delay statistics for
> >> __node_reclaim().
> >>
> >> ...
> >>
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -8010,6 +8010,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
> >>
> >>         cond_resched();
> >>         psi_memstall_enter(&pflags);
> >> +       delayacct_freepages_start();
> >>         fs_reclaim_acquire(sc.gfp_mask);
> >>         /*
> >>          * We need to be able to allocate from the reserves for RECLAIM_UNMAP
> >> @@ -8032,6 +8033,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
> >>         memalloc_noreclaim_restore(noreclaim_flag);
> >>         fs_reclaim_release(sc.gfp_mask);
> >>         psi_memstall_leave(&pflags);
> >> +       delayacct_freepages_end();
> >>
> >>         trace_mm_vmscan_node_reclaim_end(sc.nr_reclaimed);
> >
> > __node_reclaim() calls shrink_node() which at some point will call
> > do_try_to_free_pages() (yes?), which calls delayacct_freepages_start().
> >
> > So we're effectively nesting calls to delayacct_freepages_start(),
> > which isn't designed for that?
> >
> sorry, the last reply was a mistake.
> 
> It seems that no point in shrink_node() will call do_try_to_free_pages().
> And do_try_to_free_pages() will call shrink_node() through shrink_zones(),
> if shrink_node() also has some point will call do_try_to_free_pages,then
> delayacct_freepages_start() is nested now?

That's because shrink_node() goes through shrink_list() via
shrink_lruvec()? do_try_to_free_pages() will call shrink_node(). Ideally
we should have some counters around __node_reclaim() and balance_pgdat()
like psi_memstall_* does. Do you want to mimic what psi_memstall_* does?
This would change the definition of delayacct free pages, but I don't think
it will make it worse.

Balbir Singh


