Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89FF7BB621
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjJFLQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjJFLQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:16:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E83D6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:16:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7133C43397;
        Fri,  6 Oct 2023 11:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696590965;
        bh=lgHxBR1MXcz9SOv/ilPUJyFBLRJZCHLDgsuiRWJ7OsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8xcCG5bk2TiFUKZO4lDfGCoA8EclOMrs2DUsRBRmuuqOCYGD+lBz800T1tyd5NTg
         0IuvyiDvVuYBaOdDre/VU34Ac9/nkuK+W8TqTN0yhMcJjOLQU9X/p/A1vEPLdkTzJT
         lbrioIPLWbtXVuEQsce1mnyFoLdqQDrUy4gAhcy71niHgl4P9L8jK6WavDAMjySHC8
         pcQAGEUpoVPyYGHp1ZiM6rTG6HfVOgzl/YxMXaZRMqFZ+gFHI1ob0yGvOpnFZhkg6N
         UymxMc8oAAOTxST9M+hRVrofjdxl5NTnDeaqDFrugNyyKuIdDHiptRQPKZAI6nGksh
         t3szND6TPmbRA==
Date:   Fri, 6 Oct 2023 13:16:02 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v8 06/25] timers: Split out forward timer base
 functionality
Message-ID: <ZR/scqiLd0BG7PrJ@lothringen>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <20231004123454.15691-7-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004123454.15691-7-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:34:35PM +0200, Anna-Maria Behnsen wrote:
> Forwarding timer base is done when the next expiry value is calculated and
> when a new timer is enqueued. When the next expiry value is calculated the
> jiffies value is already available and does not need to be reread a second
> time.
> 
> Splitting out the forward timer base functionality to make it executable
> via both contextes - those where jiffies are already known and those, where
> jiffies need to be read.
> 
> No functional change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
