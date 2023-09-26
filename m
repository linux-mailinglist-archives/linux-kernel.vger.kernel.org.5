Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CD17AF6C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjIZXjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjIZXhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:37:53 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2454F1F9DA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:58:29 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d8164e661abso11238363276.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695765508; x=1696370308; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C6kFfoWUpW/8kB893AEctkntP41wPPc2fMMmzCd25kM=;
        b=oMe82goYUhFUGkbP9M7+GVSaD2GO2sYBSIO3bc1WzZEoEL6x/x2kbUkP89taW5fdya
         KfDvFPvQraWuqnqh9ad2vFfab3VbaBcGKkVtd6zGw9p97ebdqp24dY5cjCHL2hQ2roM1
         MIHXv2upKzOt2o4RLP/Lhr1XEzsatE5M+kfuGQLMzK8AT5pNxV/pldzMrj2Ufhz1PP1f
         bBArWKoQE/xsMaSSZww2OX2Okqn/OR8k9Qg06zUdFO9XN7NEWrufHShlaQLN+Lu5x1gG
         VTcQNQ47uRA1cDK4c0IqZf6GKTOQx5r97Y0A1Opltsh/vpYeu92F3dXeWmHW9DljGoEJ
         cXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695765508; x=1696370308;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6kFfoWUpW/8kB893AEctkntP41wPPc2fMMmzCd25kM=;
        b=s4P1R8VSghzpfOfD6T2PIAHXM8roxc7lMSd/BvBvjS9w0DsrjnZdGG9o0gc+HoWPU/
         it8HKSh700xqyiqHQF4efWXuG4kvH6ymqNKQwQFYRE/bbGijPxfaUkglurS8upd+yd6J
         DqRz23Zeo9V7Ht0ZCtDHTpQKzL5HzmwSJerwv9fM5ZqzvCuBG2TOaoiEpm9kuQMHtHV/
         d/XKiJIkkJGwtprD53E5SPOVHjtnv1me2ykHqxcvkV+M30pi71HE68GZChYEsBLxTgWG
         5ZiLClm79vcC+oAV+reK4c+jYflrKQC7KueuuSX0gzYIJQR14T9ZgvSF6ZJqV7uYKR/E
         DMoQ==
X-Gm-Message-State: AOJu0YwvkAXjo2wS72JCaojjHHqDV6OSQNe4dENReV18lqbb9pDOPV2j
        KGkz6Kjt5npQy8IJMilpTZoSPg==
X-Google-Smtp-Source: AGHT+IF1lC9gZTVPKEK6v5XtwRFX9u+Q/KPjl3ek/67xFlemq2bGgHxn41G26C6x9G8iwO4SwapdLA==
X-Received: by 2002:a25:c590:0:b0:d81:5240:679f with SMTP id v138-20020a25c590000000b00d815240679fmr220291ybe.16.1695765508147;
        Tue, 26 Sep 2023 14:58:28 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i137-20020a25d18f000000b00d81425266c1sm2981515ybg.42.2023.09.26.14.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 14:58:27 -0700 (PDT)
Date:   Tue, 26 Sep 2023 14:58:24 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 09/12] mm: add page_rmappable_folio() wrapper
In-Reply-To: <ZRIQjZOZJ2ZFkY8C@casper.infradead.org>
Message-ID: <8bfe25ca-def2-f33d-fdba-8ce5fbb5efd0@google.com>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com> <f4dc7bb6-be3a-c1b-c30-37c4e0c16e4d@google.com> <ZRIQjZOZJ2ZFkY8C@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023, Matthew Wilcox wrote:
> On Mon, Sep 25, 2023 at 01:32:02AM -0700, Hugh Dickins wrote:
> >  {
> >  	struct page *page = __alloc_pages(gfp | __GFP_COMP, order,
> > -			preferred_nid, nodemask);
> > +					  preferred_nid, nodemask);
> 
> I really prefer not to do this "align arguments with opening bracket"
> style.  As long as they're indented enough to make them visually distinct
> from indentation-for-if-blocks, I find it annoying when functions get
> renamed to something with a different length and somebody then wastes
> time reindenting all the arguments to match.

Okay, I don't care much about inserting spaces to align with the bracket,
but didn't like those continuation args leftward of function name above.
I'll adjust in v2, and eventually we reach a compromise.

> 
> > +	return page_rmappable_folio(page);
> 
> I don't particularly object to the main thrust of this patch.  I'm not
> sure I like it in huge_mm.h though.  Maybe in mm/internal.h?  I
> wouldn't want anyone outside mm/ calling it.

I was expecting more resistance :)  Right, I put it in huge_mm.h to be
next to your folio_prep_large_rmappable() declaration, but it doesn't
have to be there.  Ooh, there's a folio_undo_large_rmappable() in
mm/internal.h, I'll move page_rmappable_folio() next to that.

Hugh
