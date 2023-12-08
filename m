Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF03180A583
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573965AbjLHOch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573929AbjLHOcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:32:36 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D1B1723
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+0hR8iHkts47BXUEwt1m4VXqQmgzp5uhBg0j2NTEQik=; b=ExTb8DDP4ttMjHoIksxVgefCDU
        Omms7qX+sXI0iXUPxlBfB1VUCoIodTdABTeavvHHC0Cq35O3Ik3lrRE3sgFE+3em9OiZUYjeuAeQz
        7Zvalr/H8J2dtJ1vxwewgzGYPQieklHBW5W9cmPxhj+hh1UNUo7Zeet/wJZPoxsILoRLQuTl5cp0j
        brhaY3bLO8PibWhNPeV6Mo7MJIdchBrtPwH/GgCc2+w9EzrDQTco34hyNgiq7J2LoQkrcIpcoNAdk
        ltP2SElFm5vedYiXsbmRjqdySBWnfhpkPYItj3+CyuH5dc8C/+ZnpntB6sP6e2rzEJtX2QsLl6TKN
        kto+IpBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rBbth-006bwr-28;
        Fri, 08 Dec 2023 14:32:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0817F3003F0; Fri,  8 Dec 2023 15:32:09 +0100 (CET)
Date:   Fri, 8 Dec 2023 15:32:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tiwei Bie <tiwei.btw@antgroup.com>
Cc:     mingo@kernel.org, wuyun.abel@bytedance.com,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -tip] sched/fair: gracefully handle EEVDF scheduling
 failures
Message-ID: <20231208143208.GF28727@noisy.programming.kicks-ass.net>
References: <20231208112100.18141-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208112100.18141-1-tiwei.btw@antgroup.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 07:20:59PM +0800, Tiwei Bie wrote:
> The EEVDF scheduling might fail due to unforeseen issues. Previously,

I might also fly if I jump up. But is there any actual reason to believe
something like that will happen?
