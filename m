Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7B77B75F4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 02:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjJDAtW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 20:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJDAtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 20:49:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853E3A7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 17:49:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2980AC433C8;
        Wed,  4 Oct 2023 00:49:17 +0000 (UTC)
Date:   Tue, 3 Oct 2023 20:50:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/2] mm/damon/core: add a tracepoint for damos
 apply target regions
Message-ID: <20231003205022.58ffcb2a@gandalf.local.home>
In-Reply-To: <20230913022050.2109-2-sj@kernel.org>
References: <20230913022050.2109-1-sj@kernel.org>
        <20230913022050.2109-2-sj@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 02:20:49 +0000
SeongJae Park <sj@kernel.org> wrote:

> DAMON provides damon_aggregated tracepoint, which exposes details of
> each region and its access monitoring results.  It is useful for
> getting whole monitoring results, e.g., for recording purposes.
> 
> For investigations of DAMOS, DAMON Sysfs interface provides DAMOS
> statistics and tried_regions directory.  But, those provides only
> statistics and snapshots.  If the scheme is frequently applied and if
> the user needs to know every detail of DAMOS behavior, the
> snapshot-based interface could be insufficient and expensive.
> 
> As a last resort, userspace users need to record the all monitoring
> results via damon_aggregated tracepoint and simulate how DAMOS would
> worked.  It is unnecessarily complicated.  DAMON kernel API users,
> meanwhile, can do that easily via before_damos_apply() callback field of
> 'struct damon_callback', though.
> 
> Add a tracepoint that will be called just after before_damos_apply()
> callback for more convenient investigations of DAMOS.  The tracepoint
> exposes all details about each regions, similar to damon_aggregated
> tracepoint.
> 
> Please note that DAMOS is currently not only for memory management but
> also for query-like efficient monitoring results retrievals (when 'stat'
> action is used).  Until now, only statistics or snapshots were
> supported.  Addition of this tracepoint allows efficient full recording
> of DAMOS-based filtered monitoring results.
> 

From a tracing point of view.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
