Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD867E4775
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343747AbjKGRrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbjKGRqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:46:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BCD10C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:46:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7BFC433C7;
        Tue,  7 Nov 2023 17:46:33 +0000 (UTC)
Date:   Tue, 7 Nov 2023 12:46:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Message-ID: <20231107124636.63cd7a81@gandalf.local.home>
In-Reply-To: <20231107123540.69038c6c@gandalf.local.home>
References: <cover.1699095159.git.bristot@kernel.org>
        <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
        <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
        <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
        <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
        <20231107114732.5dd350ec@gandalf.local.home>
        <20231107123540.69038c6c@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 12:35:40 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I ran my migrate[1] program which I use to test RT migration, and it kicks

> 
> And ran my userspin[2] program. And recorded it with:

I forgot to add the [1] and [2]

[1] https://rostedt.org/code/migrate.c
[2] https://rostedt.org/code/userspin.c

-- Steve
