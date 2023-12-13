Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72830810ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjLMHEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjLMHD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:03:59 -0500
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D3399
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:04:04 -0800 (PST)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4Sqmb940DczB13yq;
        Wed, 13 Dec 2023 15:00:37 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 13 Dec
 2023 15:03:58 +0800
Date:   Wed, 13 Dec 2023 15:03:57 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>, <stone.xulei@xfusion.com>
Subject: Re: [PATCH] sched/fair: merge same code in enqueue_task_fair
Message-ID: <ZXlXXaGUsiH14pUb@fedora>
References: <202312101719+0800-wangjinchao@xfusion.com>
 <CAKfTPtCMOPVhjpLW3Y3fb4=rfYnAKzYeDmdMCRHjPzZdXYjVxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtCMOPVhjpLW3Y3fb4=rfYnAKzYeDmdMCRHjPzZdXYjVxg@mail.gmail.com>
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00601.xfusion.com (10.32.135.241) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 04:23:52PM +0100, Vincent Guittot wrote:
> On Sun, 10 Dec 2023 at 10:22, WangJinchao <wangjinchao@xfusion.com> wrote:
> >
> > 1. The code below is duplicated in two for loops and need to be
> >    consolidated
> > 2. Fix the bug where a se's on_rq is true but its parent is not
> 
> Could you clarify which bug you want to fix ?
Taking into account the additional information provided by Tim,
this is not a bug. Therefore, this patch is merely a logical
simplification.

I will send out a v2 and update the description in it.
