Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBA47A96C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjIURBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjIURBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:01:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5834F4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:00:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FDBC61187;
        Thu, 21 Sep 2023 16:22:06 +0000 (UTC)
Date:   Thu, 21 Sep 2023 12:22:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, yuzhao@google.com,
        kaleshsingh@google.com, akpm@linux-foundation.org, vbabka@suse.cz,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        jaewon31.kim@gmail.com
Subject: Re: [PATCH v2] vmscan: add trace events for lru_gen
Message-ID: <20230921122244.1cbf2d57@gandalf.local.home>
In-Reply-To: <CABdmKX1V-yPF260gORh-0LFkL+bDfPhOJteiwBjg1v6rYgrvgg@mail.gmail.com>
References: <CGME20230921061944epcas1p2f8a022282709da12840b33c0f5898b5f@epcas1p2.samsung.com>
        <20230921062206.14429-1-jaewon31.kim@samsung.com>
        <CABdmKX1V-yPF260gORh-0LFkL+bDfPhOJteiwBjg1v6rYgrvgg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 09:12:30 -0700
"T.J. Mercier" <tjmercier@google.com> wrote:

> > +       TP_fast_assign(
> > +               __entry->nid = nid;
> > +               __entry->nr_reclaimed = nr_reclaimed;
> > +               __entry->nr_dirty = stat->nr_dirty;
> > +               __entry->nr_writeback = stat->nr_writeback;
> > +               __entry->nr_congested = stat->nr_congested;
> > +               __entry->nr_immediate = stat->nr_immediate;
> > +               __entry->nr_activate0 = stat->nr_activate[0];
> > +               __entry->nr_activate1 = stat->nr_activate[1];
> > +               __entry->nr_ref_keep = stat->nr_ref_keep;
> > +               __entry->nr_unmap_fail = stat->nr_unmap_fail;
> > +               __entry->priority = priority;
> > +               __entry->reclaim_flags = trace_reclaim_flags(file);
> > +       ),
> > +
> > +       TP_printk("nid=%d nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",  
> 
> Many of these values are unsigned so I think many of these format
> specifiers should be %lu instead of %ld.

Other than this, from the tracing POV:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
