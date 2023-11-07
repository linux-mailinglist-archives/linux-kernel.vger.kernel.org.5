Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E3F7E4625
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjKGQhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjKGQhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:37:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263C2119
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:37:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F97C433C7;
        Tue,  7 Nov 2023 16:37:29 +0000 (UTC)
Date:   Tue, 7 Nov 2023 11:37:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Message-ID: <20231107113732.2d492739@gandalf.local.home>
In-Reply-To: <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
References: <cover.1699095159.git.bristot@kernel.org>
        <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Nov 2023 11:59:23 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> @@ -828,6 +836,7 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
>   * could happen are, typically, a entity voluntarily trying to overcome its
>   * runtime, or it just underestimated it during sched_setattr().
>   */
> +static int start_dl_timer(struct sched_dl_entity *dl_se);
>  static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>  {
>  	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);

Nit, but you really shouldn't have a function prototype declaration right
next to a function, and especially not between the function's comment and
the function itself.

-- Steve
