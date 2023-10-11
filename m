Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2F47C4F61
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjJKJuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjJKJuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:50:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B0092;
        Wed, 11 Oct 2023 02:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H+ZjL5UeofSvdt3MvrvIRciTt6i5B2zw6nuHglGjsuk=; b=Kyg383SEEPXgOC/W5/ONDpSJt+
        rShTiwTpl8cI6xd/dT+kJwALPyLSilOD3yoVNeymlcpkf705R0V46CXsW4Sv1xX9WLp3tatTETJHS
        fdSS6omQhKIudPCZ7vQ51dvOj3Zv3gW99f/oTuH2eKLYOD9NaayOJ4LHMOxgPTaHRDxW+KDGZoqM/
        d70mkVKM69wRAhMDvZecwCwkhkCOymsOrXvUWdAtk0oQqaaf1QStpZ7p7k+EZ1iNUyKUq6LUDD/4W
        KaMUOSKrlotkPDWEoJ9WpE1VUOdh3c0X1tHmlkl3uCrf4itK29yvg30EMzcKAqV5r/BBPu2NhmsN0
        ogbqgZ1w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqVqw-00A35N-AZ; Wed, 11 Oct 2023 09:50:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id EEF7F30026F; Wed, 11 Oct 2023 11:50:04 +0200 (CEST)
Date:   Wed, 11 Oct 2023 11:50:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH] perf/core: Introduce cpuctx->cgrp_ctx_list
Message-ID: <20231011095004.GD6337@noisy.programming.kicks-ass.net>
References: <20231004040844.797044-1-namhyung@kernel.org>
 <20231004160224.GB6307@noisy.programming.kicks-ass.net>
 <CAM9d7cizC0J85ByuF5fBmc_Bqi=wpNJpiVsw+3F1Avusn2aQog@mail.gmail.com>
 <20231009210425.GC6307@noisy.programming.kicks-ass.net>
 <CAM9d7cigs9mWuYiE=MYNg-xVhXzDu5FF6GdMGJi=D_zP1zJoCQ@mail.gmail.com>
 <CAM9d7cjxSd9QJzTs1_s6Nh7c38FZ7_2FGPoCunvnmjX_y-+Dyg@mail.gmail.com>
 <20231011075136.GM14330@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011075136.GM14330@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 09:51:36AM +0200, Peter Zijlstra wrote:

> I'll go write me a Changelog and apply the thing, then we can forget
> about things.

I pushed out:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=perf/core&id=52ecef05348dc97e3a5121f7cc0dd08e340b870c

for the robots to chew on, will push out to tip if nobody complains.
