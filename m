Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BDC798838
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbjIHN7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjIHN7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:59:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8749F1BF1;
        Fri,  8 Sep 2023 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cvpfWTNpL5Sx3YRmhLqC6Bwdf/uIujxR6g9MMGDBU08=; b=dyToNxSSrdMCxtH1q4fZL7up1K
        TPln+Lyx2BUQVVI3u/yphKPtxvGIha6wGQZzbUWUGbF5ymkNM0c/FChOMDJ5wrnxclu1KQ3EakCcQ
        2agRWJotFHfuiRoN5qX6ZiCM3RJvltIwxYeWXExB3qL9y3JviKHlxQerN0BLlQxwGOD3Z554Z+T40
        toxfa2zbR22klP0HmI+O/HI8hA5vQ5bkv/iVcW7h08KGf3w6ilOF5YBaZAx3CyCN3qBo7wFanBYz1
        j0mOcebv3HYeZTm4icqD6o21bLjMF7Uh2xXHhiFgwss69ruNvp3e9w2iSx83oaLI68pXZ5/h4nkTh
        CxQPcg6w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qec1K-002YUy-0f;
        Fri, 08 Sep 2023 13:59:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51063300472; Fri,  8 Sep 2023 15:59:39 +0200 (CEST)
Date:   Fri, 8 Sep 2023 15:59:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230908135939.GD24372@noisy.programming.kicks-ass.net>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230907130805.GE10955@noisy.programming.kicks-ass.net>
 <20230908001725.mtqbse3xwhzvo5qp@airbuntu>
 <20230908102511.GA24372@noisy.programming.kicks-ass.net>
 <20230908133336.uge4hcnx4cum3lg5@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908133336.uge4hcnx4cum3lg5@airbuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 02:33:36PM +0100, Qais Yousef wrote:

> > (even hardware has these things today, we get 0-255 values that do
> > 'something' uarch specific)
> 
> Ah, could I get some pointers please?

Intel HWP.EPP and AMD CPPC EPP I think.. both intel-pstate and
amd-pstate have EPP thingies.
